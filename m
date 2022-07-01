Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276745638AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiGARky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiGARkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:40:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8818033E99
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4s3HSu9eIvVoFcRx4RSW4OZhQchQl5sQwX2kVl+T86k=; b=L2XKX2RBTCob53RLSf3cPQdKBM
        oVy2b07JZWkx9DYlW+QifqerSgkkUUInqFoDGRYoFBX3GsG/lLgTebyzeSN8FVcwcyiYViPdZkoBV
        rcnu/M3rQFxI3ELS/8OUW17MaVCMDqEle+jkyGd/NjwPp4cJuZs7mQkm/wW/94SAevfydhQ9Ugan0
        jag/MAawGDXATIb1RyD0cJbMsl+qmnO30lsNqW6O9oZ+e8mBu98BwszBZuDVBK2u18Nsk5x2oGIyU
        AOxKxuAfCZ1x4x0wHVQzwOPX795HzS3+xsfXqLbI3YSVcvBqR/c7LSGcO7FZDKjLJKRhxU0FzqSGt
        O4UjNvDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o7KdE-0073uz-4c;
        Fri, 01 Jul 2022 17:40:40 +0000
Date:   Fri, 1 Jul 2022 18:40:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr8xmNMEOJke6NOx@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:07:24PM -0600, Keith Busch wrote:
> On Thu, Jun 30, 2022 at 11:39:36PM +0100, Al Viro wrote:
> > On Thu, Jun 30, 2022 at 11:11:27PM +0100, Al Viro wrote:
> > 
> > > ... and the first half of that thing conflicts with "block: relax direct
> > > io memory alignment" in -next...
> > 
> > BTW, looking at that commit - are you sure that bio_put_pages() on failure
> > exit will do the right thing?  We have grabbed a bunch of page references;
> > the amount if DIV_ROUND_UP(offset + size, PAGE_SIZE).  And that's before
> > your
> >                 size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> 
> Thanks for the catch, it does look like a page reference could get leaked here.
> 
> > in there.  IMO the following would be more obviously correct:
> >         size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> >         if (unlikely(size <= 0))
> >                 return size ? size : -EFAULT;
> > 
> > 	nr_pages = DIV_ROUND_UP(size + offset, PAGE_SIZE);
> > 	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > 
> >         for (left = size, i = 0; left > 0; left -= len, i++) {
> > ...
> >                 if (ret) {
> > 			while (i < nr_pages)
> > 				put_page(pages[i++]);
> >                         return ret;
> >                 }
> > ...
> > 
> > and get rid of bio_put_pages() entirely.  Objections?
> 
> 
> I think that makes sense. I'll give your idea a test run tomorrow.

See vfs.git#block-fixes, along with #work.iov_iter_get_pages-3 in there.
Seems to work here...

If you are OK with #block-fixes (it's one commit on top of
bf8d08532bc1 "iomap: add support for dma aligned direct-io" in
block.git), the easiest way to deal with the conflicts would be
to have that branch pulled into block.git.  Jens, would you be
OK with that in terms of tree topology?  Provided that patch
itself looks sane to you, of course...

FWOW, the patch in question is
commit 863965bb7e52997851af3a107ec3e4d8c7050cbd
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Jul 1 13:15:36 2022 -0400

    __bio_iov_iter_get_pages(): make sure we don't leak page refs on failure
    
    Calculate the number of pages we'd grabbed before trimming size down.
    And don't bother with bio_put_pages() - an explicit cleanup loop is
    easier to follow...
    
    Fixes: b1a000d3b8ec "block: relax direct io memory alignment"
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/block/bio.c b/block/bio.c
index 933ea3210954..59be4eca1192 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1151,14 +1151,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static void bio_put_pages(struct page **pages, size_t size, size_t off)
-{
-	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
-
-	for (i = 0; i < nr; i++)
-		put_page(pages[i]);
-}
-
 static int bio_iov_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int offset)
 {
@@ -1228,11 +1220,11 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * the iov data will be picked up in the next bio iteration.
 	 */
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
-	if (size > 0)
-		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
+	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
+	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
 	for (left = size, i = 0; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
 		int ret;
@@ -1245,7 +1237,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			ret = bio_iov_add_page(bio, page, len, offset);
 
 		if (ret) {
-			bio_put_pages(pages + i, left, offset);
+			while (i < nr_pages)
+				put_page(pages[i++]);
 			return ret;
 		}
 		offset = 0;
