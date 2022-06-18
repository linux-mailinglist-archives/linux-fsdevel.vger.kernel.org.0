Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1837550308
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiFRFgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiFRFgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:36:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D5168321
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ji4s7IcChyTmimSd4SUpg7WzF88FA4cY7ZpcuIiuIos=; b=odAW2lRcPxN8lUXFoxT/Dc38M4
        d1Q8gZGHwe9KVTpphuh/05dITRiLy+7sNxwzRs+4SMpaDvidenzcfDa+7fyToyTGJPmVlyHzgbBBw
        yC4tU2deFYhMfgxERQB1bIW54dN4kDaFVNxnl9+QBaRpm1EHN3FrzxBj+DmACK91OsBpQhpWdDTdl
        VLZOQzpAcD6EHG9SIuyUaVQ231LvzRJJwuoL8FXW5jh0fvYyNYlqP7JbDWM0QagL3/rph0g4zNd1c
        CkiwvqwZUNz9N7SQD/t1uRi4CsbwJ98fwJE7FTg5Jld9gBsOoeS0+QeAWyvYduX796XJ9x0cirmLl
        ujfarbpQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7X-001VRQ-0J;
        Sat, 18 Jun 2022 05:35:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 24/31] block: convert to advancing variants of iov_iter_get_pages{,_alloc}()
Date:   Sat, 18 Jun 2022 06:35:31 +0100
Message-Id: <20220618053538.359065-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
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

