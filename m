Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA655417B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356903AbiFVERB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356842AbiFVEQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43C6B1FB
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ji4s7IcChyTmimSd4SUpg7WzF88FA4cY7ZpcuIiuIos=; b=Vdk+9DjwMbYBdCzzkBdlV0tBi6
        Yhv/76jtsznxbtU4qkZOzactwSaFSe7zmo45Q3vMR9McmsrKh8C9gizzg2qiFrDUF4Lmhogyr/Y4V
        uPy06mx1pHe1RnYNX1jXMZ26NgTI11H9sBOGNC7b4z7xA1H8zh93QoRffV+CW7gV56yg8ibmsv983
        vMvDOUE74rEOa1DmumB+fw4lW7jXuT+mNmT1yQuTv6xj2DycXh2hOWpp9M3L5C8WobkGLLge2gJYh
        g2WcfiYm9lYmwRp/Vn6alGPCYqnmapiK1JISV0RatPhM8biFquPtOdipapOdQepSmDKc1ZFObu9gf
        YXYaPw9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmZ-0035zS-3q;
        Wed, 22 Jun 2022 04:15:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 37/44] block: convert to advancing variants of iov_iter_get_pages{,_alloc}()
Date:   Wed, 22 Jun 2022 05:15:45 +0100
Message-Id: <20220622041552.737754-37-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... doing revert if we end up not using some pages

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bio.c     | 15 ++++++---------
 block/blk-map.c |  7 ++++---
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 51c99f2c5c90..01ab683e67be 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1190,7 +1190,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size = iov_iter_get_pages2(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
@@ -1205,6 +1205,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len))) {
 				bio_put_pages(pages + i, left, offset);
+				iov_iter_revert(iter, left);
 				return -EINVAL;
 			}
 			__bio_add_page(bio, page, len, offset);
@@ -1212,7 +1213,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		offset = 0;
 	}
 
-	iov_iter_advance(iter, size);
 	return 0;
 }
 
@@ -1227,7 +1227,6 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
-	int ret = 0;
 
 	if (WARN_ON_ONCE(!max_append_sectors))
 		return 0;
@@ -1240,7 +1239,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size = iov_iter_get_pages2(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
@@ -1252,16 +1251,14 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 		if (bio_add_hw_page(q, bio, page, len, offset,
 				max_append_sectors, &same_page) != len) {
 			bio_put_pages(pages + i, left, offset);
-			ret = -EINVAL;
-			break;
+			iov_iter_revert(iter, left);
+			return -EINVAL;
 		}
 		if (same_page)
 			put_page(page);
 		offset = 0;
 	}
-
-	iov_iter_advance(iter, size - left);
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/block/blk-map.c b/block/blk-map.c
index df8b066cd548..7196a6b64c80 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -254,7 +254,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		size_t offs, added = 0;
 		int npages;
 
-		bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
+		bytes = iov_iter_get_pages_alloc2(iter, &pages, LONG_MAX, &offs);
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
@@ -284,7 +284,6 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 				bytes -= n;
 				offs = 0;
 			}
-			iov_iter_advance(iter, added);
 		}
 		/*
 		 * release the pages we didn't map into the bio, if any
@@ -293,8 +292,10 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 			put_page(pages[j++]);
 		kvfree(pages);
 		/* couldn't stuff something into bio? */
-		if (bytes)
+		if (bytes) {
+			iov_iter_revert(iter, bytes);
 			break;
+		}
 	}
 
 	ret = blk_rq_append_bio(rq, bio);
-- 
2.30.2

