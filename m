Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE98201F12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgFTARw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 20:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbgFTARv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:17:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59514C06174E;
        Fri, 19 Jun 2020 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fFSEXflWreKo1G1cvrL7drqCbz0HejuYmmv7qSFZe1Q=; b=amJf92ZxjtaHFV4K+AAc7E7qmY
        a8VrQUsa/3eN2z89ypqXo7Tx4arU1THWVR2OvHnA1dpOoquREie4Ya5OCL2QlAlTLbmfqV3jtB86o
        egkpFP6J2o6Pl4MFzk8UmoiFIHE4QfRQOtGYUpkjkzrmZL4cZqiJ5D88+01j3y58fObgRfYL4JosR
        7pyIvc7URFW+5TU5VKNR2TK34rKUJR5pvcRzSVqEYK+ZQZ8EoghVKWDatQVk4uiNStKthzdQDQgON
        siPVZDq3dT4Oq68R8IuihmxsCstJjJ25xpjBqJnctP8Fqhcr2xpQNimX8R5wxyF20JiByAWO19iLT
        UWad3Ogg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmRCd-0002PY-D0; Sat, 20 Jun 2020 00:17:47 +0000
Date:   Fri, 19 Jun 2020 17:17:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     darrick.wong@oracle.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: WARN_ON_ONCE(1) in iomap_dio_actor()
Message-ID: <20200620001747.GC8681@bombadil.infradead.org>
References: <20200619211750.GA1027@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619211750.GA1027@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:17:50PM -0400, Qian Cai wrote:
> Running a syscall fuzzer by a normal user could trigger this,
> 
> [55649.329999][T515839] WARNING: CPU: 6 PID: 515839 at fs/iomap/direct-io.c:391 iomap_dio_actor+0x29c/0x420
...
> 371 static loff_t
> 372 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> 373                 void *data, struct iomap *iomap, struct iomap *srcmap)
> 374 {
> 375         struct iomap_dio *dio = data;
> 376
> 377         switch (iomap->type) {
> 378         case IOMAP_HOLE:
> 379                 if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
> 380                         return -EIO;
> 381                 return iomap_dio_hole_actor(length, dio);
> 382         case IOMAP_UNWRITTEN:
> 383                 if (!(dio->flags & IOMAP_DIO_WRITE))
> 384                         return iomap_dio_hole_actor(length, dio);
> 385                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> 386         case IOMAP_MAPPED:
> 387                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> 388         case IOMAP_INLINE:
> 389                 return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> 390         default:
> 391                 WARN_ON_ONCE(1);
> 392                 return -EIO;
> 393         }
> 394 }
> 
> Could that be iomap->type == IOMAP_DELALLOC ? Looking throught the logs,
> it contains a few pread64() calls until this happens,

It _shouldn't_ be able to happen.  XFS writes back ranges which exist
in the page cache upon seeing an O_DIRECT I/O.  So it's not supposed to
be possible for there to be an extent which is waiting for the contents
of the page cache to be written back.

> [child21:124180] [17] pread64(fd=353, buf=0x0, count=0x59b5, pos=0xe0e0e0e) = -1 (Illegal seek)
> [child21:124180] [339] pread64(fd=339, buf=0xffffbcc40000, count=0xbd71, pos=0xff26) = -1 (Illegal seek)
> [child21:124627] [136] pread64(fd=69, buf=0xffffbd290000, count=0xee42, pos=2) = -1 (Illegal seek)
> [child21:124627] [196] pread64(fd=83, buf=0x1, count=0x62f8, pos=0x15390000) = -1 (Illegal seek)
> [child21:125127] [154] pread64(fd=345, buf=0xffffbcc40000, count=9332, pos=0xffbd) = 9332
> [child21:125169] [188] pread64(fd=69, buf=0xffffbce90000, count=0x4d47, pos=0) = -1 (Illegal seek)
> [child21:125169] [227] pread64(fd=345, buf=0x1, count=0xe469, pos=1046) = -1 (Bad address)
> [child21:125569] [354] pread64(fd=87, buf=0xffffbcc50000, count=0x4294, pos=0x16161616) = -1 (Illegal seek)
> [child21:125569] [655] pread64(fd=341, buf=0xffffbcc70000, count=2210, pos=0xffff) = -1 (Illegal seek)
> [child21:125569] [826] pread64(fd=343, buf=0x8, count=0xeb22, pos=0xc090c202e598b) = 0
> [child21:126233] [261] pread64(fd=338, buf=0xffffbcc40000, count=0xe8fe, pos=105) = -1 (Illegal seek)
> [child21:126233] [275] pread64(fd=190, buf=0x8, count=0x9c24, pos=116) = -1 (Is a directory)
> [child21:126882] [32] pread64(fd=86, buf=0xffffbcc40000, count=0x7fc2, pos=2) = -1 (Illegal seek)
> [child21:127448] [14] pread64(fd=214, buf=0x4, count=11371, pos=0x9b26) = 0
> [child21:127489] [70] pread64(fd=339, buf=0xffffbcc70000, count=0xb07a, pos=8192) = -1 (Illegal seek)
> [child21:127489] [80] pread64(fd=339, buf=0x0, count=6527, pos=205) = -1 (Illegal seek)
> [child21:127489] [245] pread64(fd=69, buf=0x8, count=0xbba2, pos=47) = -1 (Illegal seek)
> [child21:128098] [334] pread64(fd=353, buf=0xffffbcc90000, count=0x4540, pos=168) = -1 (Illegal seek)
> [child21:129079] [157] pread64(fd=422, buf=0x0, count=0x80df, pos=0xdfef6378b650aa) = 0
> [child21:134700] [275] pread64(fd=397, buf=0xffffbcc50000, count=0xdee6, pos=0x887b1e74a2) = -1 (Illegal seek)
> [child21:135042] [7] pread64(fd=80, buf=0x8, count=0xc494, pos=216) = -1 (Illegal seek)
> [child21:135056] [188] pread64(fd=430, buf=0xffffbd090000, count=0xbe66, pos=0x3a3a3a3a) = -1 (Illegal seek)
> [child21:135442] [143] pread64(fd=226, buf=0xffffbd390000, count=11558, pos=0x1000002d) = 0
> [child21:135513] [275] pread64(fd=69, buf=0x4, count=4659, pos=0x486005206c2986) = -1 (Illegal seek)
> [child21:135513] [335] pread64(fd=339, buf=0xffffbd090000, count=0x90fd, pos=253) = -1 (Illegal seek)
> [child21:135513] [392] pread64(fd=76, buf=0xffffbcc40000, count=0xf324, pos=0x5d5d5d5d) = -1 (Illegal seek)
> [child21:135665] [5] pread64(fd=431, buf=0xffffbcc70000, count=10545, pos=16384) = -1 (Illegal seek)
> [child21:135665] [293] pread64(fd=349, buf=0x4, count=0xd2ad, pos=0x2000000) = -1 (Illegal seek)
> [child21:135790] [99] pread64(fd=76, buf=0x8, count=0x70d7, pos=0x21000440) = -1 (Illegal seek)
> [child21:135790] [149] pread64(fd=70, buf=0xffffbd5b0000, count=0x53f3, pos=255) = -1 (Illegal seek)
> [child21:135790] [301] pread64(fd=348, buf=0x4, count=5713, pos=0x6c00401a) = -1 (Illegal seek)
> [child21:136162] [570] pread64(fd=435, buf=0x1, count=11182, pos=248) = -1 (Illegal seek)
> [child21:136162] [584] pread64(fd=78, buf=0xffffbcc40000, count=0xa401, pos=8192) = -1 (Illegal seek)
> [child21:138090] [167] pread64(fd=339, buf=0x4, count=0x6aba, pos=256) = -1 (Illegal seek)
> [child21:138090] [203] pread64(fd=348, buf=0xffffbcc90000, count=0x8625, pos=128) = -1 (Illegal seek)
> [child21:138551] [174] pread64(fd=426, buf=0x0, count=0xd582, pos=0xd7e8674d0a86) = 0
> [child21:138551] [179] pread64(fd=426, buf=0xffffbce90000, count=0x415a, pos=0x536e873600750b2d) = 0
> [child21:138988] [306] pread64(fd=436, buf=0x8, count=0x62e6, pos=0x445c403204924c1) = -1 (Illegal seek)
> [child21:138988] [353] pread64(fd=427, buf=0x4, count=0x993b, pos=176) = 0
