Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E819A730126
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbjFNOEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245371AbjFNOEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:04:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC41BC6;
        Wed, 14 Jun 2023 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=y2VOAWVYmfWhLAJZWae0zYCsa52UbsbyvWfbxWr+KKg=; b=a79fBkGGSuBaMmrsdRjJTl2aMx
        kJNlMRrXEuqahHUEQpJV4QgQ3Ym+2E6bzMPM7oBmx6GxrLhjk58gQyn97sDE2abZhSHDDOayelUCo
        +pPQkPnwIebiR1qELno5bE9IaEnVDydbBCPcpxtvEuoRXyqfUBdFrGClWaT9p53o4XgV8eCYWyUqU
        0ymKFTi0dBeNsEFcD07nQBpAMOpvx8xnJifD7244k42gKzfuhiJYs91PZtxY4g9n5HPIUuWUFaCMy
        +BkCCiyIWzwl3ALP879d/OVOE1a2Id4lHj7XOL8NP/70kqvgawsOf+0bEJzVWCtNxsQ/i9iTNcMPy
        PQHNbeOw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9R6J-00BrAS-0M;
        Wed, 14 Jun 2023 14:03:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] block: remove BIO_PAGE_REFFED
Date:   Wed, 14 Jun 2023 16:03:40 +0200
Message-Id: <20230614140341.521331-4-hch@lst.de>
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

Now that all block direct I/O helpers use page pinning, this flag is
unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h               | 2 --
 include/linux/bio.h       | 3 +--
 include/linux/blk_types.h | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 768852a84fefb3..608c5dcc516b55 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -445,8 +445,6 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 {
 	if (bio_flagged(bio, BIO_PAGE_PINNED))
 		unpin_user_page(page);
-	else if (bio_flagged(bio, BIO_PAGE_REFFED))
-		put_page(page);
 }
 
 struct request_queue *blk_alloc_queue(int node_id);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 61752292896494..c4f5b5228105fe 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -492,8 +492,7 @@ void zero_fill_bio(struct bio *bio);
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
-	    bio_flagged(bio, BIO_PAGE_PINNED))
+	if (bio_flagged(bio, BIO_PAGE_PINNED))
 		__bio_release_pages(bio, mark_dirty);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index deb69eeab6bd7b..752a54e3284b27 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -326,7 +326,6 @@ struct bio {
  */
 enum {
 	BIO_PAGE_PINNED,	/* Unpin pages in bio_release_pages() */
-	BIO_PAGE_REFFED,	/* put pages in bio_release_pages() */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */
-- 
2.39.2

