Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135E6D4829
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjDCO0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjDCO0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:26:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144F319BD;
        Mon,  3 Apr 2023 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=09bEQTljwZqyIgAzba0y0v6Yf+aAuPiWc/mpA4Uhs/A=; b=uNr/zHjki4uJsjaG9CI9ZVVxiN
        MRdhN/zAd2IcxBw4TZHidhbI4mznNteU8NXz0j+x8jzSh7tyiipxOriS/DtSL0z35Gnabkoh3dgGk
        AL+c+k69XuUcKrnT2OHn5ogTllM6CWi19InzAl88n8cx/LSdx/uEb5+DQXgEsvD67cGidM4okvl95
        NgTSKjFKVIAOFMyhTuc7jMZCTGNIgNOxcv4jYsWz573NvJUjtROwRrM/FggydktsW0r1KA3Ru/KgJ
        6xsZg5ryglmm1J4RV+g98MDOTEVwOZzfjCS9OFEJ6qv9ix+RdCP3RDUpT/CKE+7vLZKILE0xMhFu3
        yrteY6GQ==;
Received: from [2001:4bb8:191:a744:529d:286f:e3d8:fddb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjL8G-00Fdmp-2V;
        Mon, 03 Apr 2023 14:26:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] iov_iter: remove the extraction_flags argument to __iov_iter_get_pages_alloc
Date:   Mon,  3 Apr 2023 16:25:43 +0200
Message-Id: <20230403142543.1913749-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403142543.1913749-1-hch@lst.de>
References: <20230403142543.1913749-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

extraction_flags is always 0 now, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/iov_iter.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 764ddebfb9779c..c836cea6b3e432 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1019,8 +1019,7 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   unsigned int maxpages, size_t *start,
-		   iov_iter_extraction_t extraction_flags)
+		   unsigned int maxpages, size_t *start)
 {
 	unsigned int n, gup_flags = 0;
 
@@ -1030,8 +1029,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		return 0;
 	if (maxsize > MAX_RW_COUNT)
 		maxsize = MAX_RW_COUNT;
-	if (extraction_flags & ITER_ALLOW_P2PDMA)
-		gup_flags |= FOLL_PCI_P2PDMA;
 
 	if (likely(user_backed_iter(i))) {
 		unsigned long addr;
@@ -1088,8 +1085,7 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 		return 0;
 	BUG_ON(!pages);
 
-	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
-					  start, 0);
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
 }
 EXPORT_SYMBOL(iov_iter_get_pages2);
 
@@ -1100,7 +1096,7 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 
 	*pages = NULL;
 
-	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start, 0);
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
 	if (len <= 0) {
 		kvfree(*pages);
 		*pages = NULL;
-- 
2.39.2

