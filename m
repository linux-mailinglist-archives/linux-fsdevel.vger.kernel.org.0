Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7785638C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiGARxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiGARxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:53:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05043AA5B
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 10:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A6960F31
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 17:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7659BC341C6;
        Fri,  1 Jul 2022 17:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656698028;
        bh=wxt8C0ZCQqaQQe6turUtJUGQ/QfW4qnnO1bI0hOaJYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeT2eG5DAbP8UFjlVXIaUUcuYJCP0Ew+5EDj4VBJzwWYNfDY2BaDCz7CayBOz4Xky
         um1ZYTlZEjNzOHqYKqLmnkoWj2LkgEDZt6wFS9VTx40e0J79sTZp9ixtfF+iFaouAV
         EpSqT/eWvUyiGFABJyXScO3nHyG4nj1wG3yR1U+QGaDL+JYQuO7IJW/8qUk62nj0s8
         aoKdcM7AAiBrrM5CyALvlE8q2Q6kwkix7P4Gp3FZCT5lJSspTLIdJPOAaGEKOfL0LS
         362L15HDjnmrRx9JQwLGTT8zYsbYsSrbF5qsqiUuFHfUgHi5jUSKzboUJuQ1DR4Dy0
         75Ozz8gMjlcTA==
Date:   Fri, 1 Jul 2022 11:53:44 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
 <Yr4fj0uGfjX5ZvDI@ZenIV>
 <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr8xmNMEOJke6NOx@ZenIV>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 06:40:40PM +0100, Al Viro wrote:
> -static void bio_put_pages(struct page **pages, size_t size, size_t off)
> -{
> -	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
> -
> -	for (i = 0; i < nr; i++)
> -		put_page(pages[i]);
> -}
> -
>  static int bio_iov_add_page(struct bio *bio, struct page *page,
>  		unsigned int len, unsigned int offset)
>  {
> @@ -1228,11 +1220,11 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	 * the iov data will be picked up in the next bio iteration.
>  	 */
>  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> -	if (size > 0)
> -		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
> +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
>  
> +	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));

This isn't quite right. The result of the ALIGN_DOWN could be 0, so whatever
page we got before would be leaked since unused pages are only released on an
add_page error. I was about to reply with a patch that fixes this, but here's
the one that I'm currently testing:

---
diff --git a/block/bio.c b/block/bio.c
index 933ea3210954..c4a1ce39c65c 100644
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
@@ -1208,9 +1200,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
+	unsigned len, i = 0;
 	ssize_t size, left;
-	unsigned len, i;
 	size_t offset;
+	int ret;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1228,14 +1221,19 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * the iov data will be picked up in the next bio iteration.
 	 */
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
-	if (size > 0)
+	if (size > 0) {
+		nr_pages = DIV_ROUND_UP(size + offset, PAGE_SIZE);
 		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
-	if (unlikely(size <= 0))
-		return size ? size : -EFAULT;
+	} else
+		nr_pages = 0;
+
+	if (unlikely(size <= 0)) {
+		ret = size ? size : -EFAULT;
+		goto out;
+	}
 
-	for (left = size, i = 0; left > 0; left -= len, i++) {
+	for (left = size; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
-		int ret;
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
@@ -1244,15 +1242,19 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		else
 			ret = bio_iov_add_page(bio, page, len, offset);
 
-		if (ret) {
-			bio_put_pages(pages + i, left, offset);
-			return ret;
-		}
+		if (ret)
+			goto out;
 		offset = 0;
 	}
 
 	iov_iter_advance(iter, size);
-	return 0;
+out:
+	while (i < nr_pages) {
+		put_page(pages[i]);
+		i++;
+	}
+
+	return ret;
 }
 
 /**
--
