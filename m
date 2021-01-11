Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66D92F101E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 11:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbhAKKbH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 05:31:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:23063 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728725AbhAKKbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:31:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-34-7ibnZ-d1Oea7y-_CqhqRwQ-1; Mon, 11 Jan 2021 10:29:29 +0000
X-MC-Unique: 7ibnZ-d1Oea7y-_CqhqRwQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 10:29:28 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 10:29:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Mikulas Patocka <mpatocka@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [RFC v2] nvfs: a filesystem for persistent memory
Thread-Topic: [RFC v2] nvfs: a filesystem for persistent memory
Thread-Index: AQHW52zcFLyucqAcQUmnqwhwPozPcaoiOfvQ
Date:   Mon, 11 Jan 2021 10:29:28 +0000
Message-ID: <c26db2b0ea1a4891a7cbd0363de856d3@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210110162008.GV3579531@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: 10 January 2021 16:20
> 
> On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> > Hi
> >
> > I announce a new version of NVFS - a filesystem for persistent memory.
> > 	http://people.redhat.com/~mpatocka/nvfs/
> Utilities, AFAICS
> 
> > 	git://leontynka.twibright.com/nvfs.git
> Seems to hang on git pull at the moment...  Do you have it anywhere else?
> 
> > I found out that on NVFS, reading a file with the read method has 10%
> > better performance than the read_iter method. The benchmark just reads the
> > same 4k page over and over again - and the cost of creating and parsing
> > the kiocb and iov_iter structures is just that high.
> 
> Apples and oranges...  What happens if you take
> 
> ssize_t read_iter_locked(struct file *file, struct iov_iter *to, loff_t *ppos)
> {
> 	struct inode *inode = file_inode(file);
> 	struct nvfs_memory_inode *nmi = i_to_nmi(inode);
> 	struct nvfs_superblock *nvs = inode->i_sb->s_fs_info;
> 	ssize_t total = 0;
> 	loff_t pos = *ppos;
> 	int r;
> 	int shift = nvs->log2_page_size;
> 	size_t i_size;
> 
> 	i_size = inode->i_size;
> 	if (pos >= i_size)
> 		return 0;
> 	iov_iter_truncate(to, i_size - pos);
> 
> 	while (iov_iter_count(to)) {
> 		void *blk, *ptr;
> 		size_t page_mask = (1UL << shift) - 1;
> 		unsigned page_offset = pos & page_mask;
> 		unsigned prealloc = (iov_iter_count(to) + page_mask) >> shift;
> 		unsigned size;
> 
> 		blk = nvfs_bmap(nmi, pos >> shift, &prealloc, NULL, NULL, NULL);
> 		if (unlikely(IS_ERR(blk))) {
> 			r = PTR_ERR(blk);
> 			goto ret_r;
> 		}
> 		size = ((size_t)prealloc << shift) - page_offset;
> 		ptr = blk + page_offset;
> 		if (unlikely(!blk)) {
> 			size = min(size, (unsigned)PAGE_SIZE);
> 			ptr = empty_zero_page;
> 		}
> 		size = copy_to_iter(to, ptr, size);
> 		if (unlikely(!size)) {
> 			r = -EFAULT;
> 			goto ret_r;
> 		}
> 
> 		pos += size;
> 		total += size;
> 	} while (iov_iter_count(to));

That isn't the best formed loop!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

