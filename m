Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18A5638FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiGASM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 14:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiGASMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:12:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FEF1181F
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rsbmvnEWQiwAD418KmTEoHQz1P0fDsxWyjoaZKkl6+E=; b=MeIE3ZzHRwMHn86bDNUp7tqiVB
        cMvFV6b9orUMtDO0MnyVwSP02tBbApg0UQfJIZd8PJA/J75d7vjrb5vj1EG+QrlTR4pCD6vbWV3RJ
        dQsj1eD0WBg3FVajszCzlm/90KUIXKG/sRov7Vm+Bhj9GbYEhl58K8eXlgYUjRhAkcfinaWQORWvk
        ib7FJCJ1xEBx7MOAJbAWC59bUlQu6i+VAhKfkdaYlxc7KUg7ihxsH4EEatELxwLJy/n0oZhCnKcaW
        W13L6X0+1rk/yS8lPn+uiI8hB+LBJlewRbWR3bFuV4d4HL5ho6KTLwressvsVZqOaEniGKB7/vaEc
        WTKGcJuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o7L7p-0074Wy-5B;
        Fri, 01 Jul 2022 18:12:17 +0000
Date:   Fri, 1 Jul 2022 19:12:17 +0100
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
Message-ID: <Yr85AaNqNAEr+5ve@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr838ci8FUsiZlSW@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 07:07:45PM +0100, Al Viro wrote:
> On Fri, Jul 01, 2022 at 11:53:44AM -0600, Keith Busch wrote:
> > On Fri, Jul 01, 2022 at 06:40:40PM +0100, Al Viro wrote:
> > > -static void bio_put_pages(struct page **pages, size_t size, size_t off)
> > > -{
> > > -	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
> > > -
> > > -	for (i = 0; i < nr; i++)
> > > -		put_page(pages[i]);
> > > -}
> > > -
> > >  static int bio_iov_add_page(struct bio *bio, struct page *page,
> > >  		unsigned int len, unsigned int offset)
> > >  {
> > > @@ -1228,11 +1220,11 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> > >  	 * the iov data will be picked up in the next bio iteration.
> > >  	 */
> > >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > > -	if (size > 0)
> > > -		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > >  	if (unlikely(size <= 0))
> > >  		return size ? size : -EFAULT;
> > > +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> > >  
> > > +	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > 
> > This isn't quite right. The result of the ALIGN_DOWN could be 0, so whatever
> > page we got before would be leaked since unused pages are only released on an
> > add_page error. I was about to reply with a patch that fixes this, but here's
> > the one that I'm currently testing:
> 
> AFAICS, result is broken; you might end up consuming some data and leaving
> iterator not advanced at all.  With no way for the caller to tell which way it
> went.

How about the following?

commit 5e3e9769404de54734c110b2040bdb93593e0f1b
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Jul 1 13:15:36 2022 -0400

    __bio_iov_iter_get_pages(): make sure we don't leak page refs on failure
    
    Calculate the number of pages we'd grabbed before trimming size down.
    And don't bother with bio_put_pages() - an explicit cleanup loop is
    easier to follow...
    
    Fixes: b1a000d3b8ec "block: relax direct io memory alignment"
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/block/bio.c b/block/bio.c
index 933ea3210954..a9fe20cb71fe 100644
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
@@ -1211,6 +1203,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
+	int ret;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1228,14 +1221,13 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
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
-		int ret;
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
@@ -1244,15 +1236,15 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		else
 			ret = bio_iov_add_page(bio, page, len, offset);
 
-		if (ret) {
-			bio_put_pages(pages + i, left, offset);
-			return ret;
-		}
+		if (ret)
+			break;
 		offset = 0;
 	}
+	while (i < nr_pages)
+		put_page(pages[i++]);
 
-	iov_iter_advance(iter, size);
-	return 0;
+	iov_iter_advance(iter, size - left);
+	return ret;
 }
 
 /**
