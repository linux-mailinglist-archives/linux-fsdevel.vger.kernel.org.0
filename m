Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157762F085E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jan 2021 17:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbhAJQVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 11:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhAJQVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 11:21:39 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166EC061786;
        Sun, 10 Jan 2021 08:20:58 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kydRo-008yaK-RN; Sun, 10 Jan 2021 16:20:08 +0000
Date:   Sun, 10 Jan 2021 16:20:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [RFC v2] nvfs: a filesystem for persistent memory
Message-ID: <20210110162008.GV3579531@ZenIV.linux.org.uk>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> Hi
> 
> I announce a new version of NVFS - a filesystem for persistent memory.
> 	http://people.redhat.com/~mpatocka/nvfs/
Utilities, AFAICS

> 	git://leontynka.twibright.com/nvfs.git
Seems to hang on git pull at the moment...  Do you have it anywhere else?

> I found out that on NVFS, reading a file with the read method has 10% 
> better performance than the read_iter method. The benchmark just reads the 
> same 4k page over and over again - and the cost of creating and parsing 
> the kiocb and iov_iter structures is just that high.

Apples and oranges...  What happens if you take

ssize_t read_iter_locked(struct file *file, struct iov_iter *to, loff_t *ppos)
{
	struct inode *inode = file_inode(file);
	struct nvfs_memory_inode *nmi = i_to_nmi(inode);
	struct nvfs_superblock *nvs = inode->i_sb->s_fs_info;
	ssize_t total = 0;
	loff_t pos = *ppos;
	int r;
	int shift = nvs->log2_page_size;
	size_t i_size;

	i_size = inode->i_size;
	if (pos >= i_size)
		return 0;
	iov_iter_truncate(to, i_size - pos);

	while (iov_iter_count(to)) {
		void *blk, *ptr;
		size_t page_mask = (1UL << shift) - 1;
		unsigned page_offset = pos & page_mask;
		unsigned prealloc = (iov_iter_count(to) + page_mask) >> shift;
		unsigned size;

		blk = nvfs_bmap(nmi, pos >> shift, &prealloc, NULL, NULL, NULL);
		if (unlikely(IS_ERR(blk))) {
			r = PTR_ERR(blk);
			goto ret_r;
		}
		size = ((size_t)prealloc << shift) - page_offset;
		ptr = blk + page_offset;
		if (unlikely(!blk)) {
			size = min(size, (unsigned)PAGE_SIZE);
			ptr = empty_zero_page;
		}
		size = copy_to_iter(to, ptr, size);
		if (unlikely(!size)) {
			r = -EFAULT;
			goto ret_r;
		}

		pos += size;
		total += size;
	} while (iov_iter_count(to));

	r = 0;

ret_r:
	*ppos = pos;

	if (file)
		file_accessed(file);

	return total ? total : r;
}

and use that instead of your nvfs_rw_iter_locked() in your
->read_iter() for DAX read case?  Then the same with
s/copy_to_iter/_copy_to_iter/, to see how much of that is
"hardening" overhead.

Incidentally, what's the point of sharing nvfs_rw_iter() for
read and write cases?  They have practically no overlap -
count the lines common for wr and !wr cases.  And if you
do the same in nvfs_rw_iter_locked(), you'll see that the
shared parts _there_ are bloody pointless on the read side.
Not that it had been more useful on the write side, really,
but that's another story (nvfs_write_pages() handling of
copyin is... interesting).  Let's figure out what's going
on with the read overhead first...

lib/iov_iter.c primitives certainly could use massage for
better code generation, but let's find out how much of the
PITA is due to those and how much comes from you fighing
the damn thing instead of using it sanely...
