Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D662F11BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 12:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbhAKLpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 06:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729845AbhAKLpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610365456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Hcdfw5VdpoOwIxyvr0g1FbdByZ5Ha2c5UYqhxzG0vE=;
        b=b7BiN2eOAIC2eSOj7ADHVwWm25rNHkgyQ7fQ2Qye18gqXJWbBKTGZiR63RMk153DKBOodz
        mXi8Rr5YSVOhhGlYF9VCbVl1YXX9OzNZQniw1WDVxhiMLvgedTmCNu4L2AAjYmjineF6dp
        ouOSG1a7MM5JBqz+SLXEu+xK9BlGz6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-PFxPmiI0PCK_U1RyLxwyqQ-1; Mon, 11 Jan 2021 06:44:14 -0500
X-MC-Unique: PFxPmiI0PCK_U1RyLxwyqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4999D801B13;
        Mon, 11 Jan 2021 11:44:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1E63106D5B9;
        Mon, 11 Jan 2021 11:44:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10BBiAnB005247;
        Mon, 11 Jan 2021 06:44:10 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10BBi9Af005243;
        Mon, 11 Jan 2021 06:44:10 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Jan 2021 06:44:09 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     David Laight <David.Laight@ACULAB.COM>
cc:     "'Al Viro'" <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [RFC v2] nvfs: a filesystem for persistent memory
In-Reply-To: <c26db2b0ea1a4891a7cbd0363de856d3@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.2101110641490.4356@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210110162008.GV3579531@ZenIV.linux.org.uk> <c26db2b0ea1a4891a7cbd0363de856d3@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 11 Jan 2021, David Laight wrote:

> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> > Sent: 10 January 2021 16:20
> > 
> > On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> > > Hi
> > >
> > > I announce a new version of NVFS - a filesystem for persistent memory.
> > > 	http://people.redhat.com/~mpatocka/nvfs/
> > Utilities, AFAICS
> > 
> > > 	git://leontynka.twibright.com/nvfs.git
> > Seems to hang on git pull at the moment...  Do you have it anywhere else?
> > 
> > > I found out that on NVFS, reading a file with the read method has 10%
> > > better performance than the read_iter method. The benchmark just reads the
> > > same 4k page over and over again - and the cost of creating and parsing
> > > the kiocb and iov_iter structures is just that high.
> > 
> > Apples and oranges...  What happens if you take
> > 
> > ssize_t read_iter_locked(struct file *file, struct iov_iter *to, loff_t *ppos)
> > {
> > 	struct inode *inode = file_inode(file);
> > 	struct nvfs_memory_inode *nmi = i_to_nmi(inode);
> > 	struct nvfs_superblock *nvs = inode->i_sb->s_fs_info;
> > 	ssize_t total = 0;
> > 	loff_t pos = *ppos;
> > 	int r;
> > 	int shift = nvs->log2_page_size;
> > 	size_t i_size;
> > 
> > 	i_size = inode->i_size;
> > 	if (pos >= i_size)
> > 		return 0;
> > 	iov_iter_truncate(to, i_size - pos);
> > 
> > 	while (iov_iter_count(to)) {
> > 		void *blk, *ptr;
> > 		size_t page_mask = (1UL << shift) - 1;
> > 		unsigned page_offset = pos & page_mask;
> > 		unsigned prealloc = (iov_iter_count(to) + page_mask) >> shift;
> > 		unsigned size;
> > 
> > 		blk = nvfs_bmap(nmi, pos >> shift, &prealloc, NULL, NULL, NULL);
> > 		if (unlikely(IS_ERR(blk))) {
> > 			r = PTR_ERR(blk);
> > 			goto ret_r;
> > 		}
> > 		size = ((size_t)prealloc << shift) - page_offset;
> > 		ptr = blk + page_offset;
> > 		if (unlikely(!blk)) {
> > 			size = min(size, (unsigned)PAGE_SIZE);
> > 			ptr = empty_zero_page;
> > 		}
> > 		size = copy_to_iter(to, ptr, size);
> > 		if (unlikely(!size)) {
> > 			r = -EFAULT;
> > 			goto ret_r;
> > 		}
> > 
> > 		pos += size;
> > 		total += size;
> > 	} while (iov_iter_count(to));
> 
> That isn't the best formed loop!
> 
> 	David

I removed the second "while" statement and fixed the arguments to 
copy_to_iter - other than that, Al's function works.

Mikuklas

