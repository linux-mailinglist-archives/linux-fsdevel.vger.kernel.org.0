Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF88730127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbjFNOEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245381AbjFNOEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:04:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04BF1FDD;
        Wed, 14 Jun 2023 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OSL1nuzwKsIXKnJLJ9bC7aLj85J8tz1NUL8M/RaHueI=; b=ziPVkzsoToBw8HyGoGo9Kf60kr
        DXGZHzJDufMZHkMkzaSO/9+2+j1wNF+GamUI4o0mc7O/a1uImkC4/BEi+hxSZnwOV7XrQeX4Tuhhs
        gLuF62QFXBt67QuX+6VtHDp9Pe7OXB3dJKVx1yAZJxANAtb3Z4cD0IixWtY3Z93P23eHgFct8w/Uu
        Rad+DpGdHuUWHb9psr5TiLOu3kPHyDy8UbQsDWo3+ccBViUGk+5CCGTElZ+o9xjhY1gkg29U4hHPJ
        uhj+x577LPkev3s8yO28j0ThfCeauPs7Cp0/ClV8ASFPJoXdPW+DSo3zOePupmnoh54bUOvjW+DKP
        Bb89Zj6A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9R6L-00BrAj-2a;
        Wed, 14 Jun 2023 14:03:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] iov_iter: remove iov_iter_get_pages and iov_iter_get_pages_alloc
Date:   Wed, 14 Jun 2023 16:03:41 +0200
Message-Id: <20230614140341.521331-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614140341.521331-1-hch@lst.de>
References: <20230614140341.521331-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the direct I/O helpers have switched to use
iov_iter_extract_pages, these helpers are unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uio.h |  6 ------
 lib/iov_iter.c      | 35 +++++++----------------------------
 2 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 60c342bb7ab89f..8e7d2c425340c5 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -277,14 +277,8 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
-ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
-		size_t maxsize, unsigned maxpages, size_t *start,
-		iov_iter_extraction_t extraction_flags);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
-		struct page ***pages, size_t maxsize, size_t *start,
-		iov_iter_extraction_t extraction_flags);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f18138e0292ae4..b667b1e2f68866 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1082,8 +1082,7 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   unsigned int maxpages, size_t *start,
-		   iov_iter_extraction_t extraction_flags)
+		   unsigned int maxpages, size_t *start)
 {
 	unsigned int n, gup_flags = 0;
 
@@ -1093,8 +1092,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		return 0;
 	if (maxsize > MAX_RW_COUNT)
 		maxsize = MAX_RW_COUNT;
-	if (extraction_flags & ITER_ALLOW_P2PDMA)
-		gup_flags |= FOLL_PCI_P2PDMA;
 
 	if (likely(user_backed_iter(i))) {
 		unsigned long addr;
@@ -1144,49 +1141,31 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 	return -EFAULT;
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
-		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start, iov_iter_extraction_t extraction_flags)
+ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
+		size_t maxsize, unsigned maxpages, size_t *start)
 {
 	if (!maxpages)
 		return 0;
 	BUG_ON(!pages);
 
-	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
-					  start, extraction_flags);
-}
-EXPORT_SYMBOL_GPL(iov_iter_get_pages);
-
-ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
-		size_t maxsize, unsigned maxpages, size_t *start)
-{
-	return iov_iter_get_pages(i, pages, maxsize, maxpages, start, 0);
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
 }
 EXPORT_SYMBOL(iov_iter_get_pages2);
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
-		   struct page ***pages, size_t maxsize,
-		   size_t *start, iov_iter_extraction_t extraction_flags)
+ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start)
 {
 	ssize_t len;
 
 	*pages = NULL;
 
-	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
-					 extraction_flags);
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
 	if (len <= 0) {
 		kvfree(*pages);
 		*pages = NULL;
 	}
 	return len;
 }
-EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc);
-
-ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
-		struct page ***pages, size_t maxsize, size_t *start)
-{
-	return iov_iter_get_pages_alloc(i, pages, maxsize, start, 0);
-}
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
-- 
2.39.2

