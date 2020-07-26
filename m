Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2E22E097
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGZPYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGZPYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:24:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DDEC0619D2;
        Sun, 26 Jul 2020 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Z5eIAaFGWLcRkprXsSQSz/ZXR6YtVszbfA9Sx2DBkI=; b=P9RXW33o4c7/2dMj2/ZrliJYVH
        e7c+NkQFOX6OIGXB8xTc7v5uOpS7Z40n2xtlBe0tqIkRw9nb4vGKxMTMe8aWSLu2KoXQvIl7TS+YB
        NgkYZ30Man3k/hfFOIripyBF69nyLjO9OzSgH/SkZhYqUgTJYlap/xidu41OQtQiI67pODAcgbI/F
        /Iw0QcuXPvPhi20xhTTC5OVZdPHIvQrzxY+kb/Ij+XXiOzSg9Tri2S+NifrSesHe6s+lDJfepzWHj
        KGIEhGzmV3mWfDQQZovPzugaiASv24o/MepucA5rCbhMREvkBmeYge89777+wz+G9Owz4isUC564D
        y3b2DL1Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jziVY-0006x0-Rb; Sun, 26 Jul 2020 15:24:12 +0000
Date:   Sun, 26 Jul 2020 16:24:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>, darrick.wong@oracle.com,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        khlebnikov@yandex-team.ru
Subject: Re: WARN_ON_ONCE(1) in iomap_dio_actor()
Message-ID: <20200726152412.GA26614@infradead.org>
References: <20200619211750.GA1027@lca.pw>
 <20200620001747.GC8681@bombadil.infradead.org>
 <20200724182431.GA4871@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724182431.GA4871@lca.pw>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 02:24:32PM -0400, Qian Cai wrote:
> On Fri, Jun 19, 2020 at 05:17:47PM -0700, Matthew Wilcox wrote:
> > On Fri, Jun 19, 2020 at 05:17:50PM -0400, Qian Cai wrote:
> > > Running a syscall fuzzer by a normal user could trigger this,
> > > 
> > > [55649.329999][T515839] WARNING: CPU: 6 PID: 515839 at fs/iomap/direct-io.c:391 iomap_dio_actor+0x29c/0x420
> > ...
> > > 371 static loff_t
> > > 372 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> > > 373                 void *data, struct iomap *iomap, struct iomap *srcmap)
> > > 374 {
> > > 375         struct iomap_dio *dio = data;
> > > 376
> > > 377         switch (iomap->type) {
> > > 378         case IOMAP_HOLE:
> > > 379                 if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
> > > 380                         return -EIO;
> > > 381                 return iomap_dio_hole_actor(length, dio);
> > > 382         case IOMAP_UNWRITTEN:
> > > 383                 if (!(dio->flags & IOMAP_DIO_WRITE))
> > > 384                         return iomap_dio_hole_actor(length, dio);
> > > 385                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > > 386         case IOMAP_MAPPED:
> > > 387                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > > 388         case IOMAP_INLINE:
> > > 389                 return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> > > 390         default:
> > > 391                 WARN_ON_ONCE(1);
> > > 392                 return -EIO;
> > > 393         }
> > > 394 }
> > > 
> > > Could that be iomap->type == IOMAP_DELALLOC ? Looking throught the logs,
> > > it contains a few pread64() calls until this happens,
> > 
> > It _shouldn't_ be able to happen.  XFS writes back ranges which exist
> > in the page cache upon seeing an O_DIRECT I/O.  So it's not supposed to
> > be possible for there to be an extent which is waiting for the contents
> > of the page cache to be written back.
> 
> Okay, it is IOMAP_DELALLOC. We have,

Can you share the fuzzer?  If we end up with delalloc space here we
probably need to fix a bug in the cache invalidation code.
