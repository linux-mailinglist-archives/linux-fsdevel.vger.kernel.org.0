Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346296D4823
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjDCO0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjDCO0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:26:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9A319AF;
        Mon,  3 Apr 2023 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RqongliPF9xaZk80Ovz7EfDGUEGzTUxUG+t3aRImMXE=; b=mPPRodslNj+3JLJIp0gkFyO+Af
        X1p6FOrsPvbGLJvUHqUl2HT/RtG/N8pbJ/cHd5UYEfdrjtauQoRnKU7t0oP/N8Hv6j8SBP3rIqyw9
        tnOVV/DnEG4MQU5S5oWTpUd+bPzkPttZ5XT0LUKvv+SNekmQ4jzgLZc4vRfxaoRNRguMzx0FyHPv0
        1fsdYWxT8tR8LF3lWbaKMQ90W7MX06KWqS/2D1p2eJkptBpYDB+ifDx0h0SjkRpdkDfcZop7PafG6
        AlcrvfN0egu7abWJok2SqXGXQTn6YcUgtWRW645CKsm0vJ7dpZW1vbeybd13blH3XrHzMmv4WDU4c
        /YkTGH9A==;
Received: from [2001:4bb8:191:a744:529d:286f:e3d8:fddb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjL8A-00Fdlz-2t;
        Mon, 03 Apr 2023 14:25:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] iov_iter: remove iov_iter_get_pages_alloc
Date:   Mon,  3 Apr 2023 16:25:42 +0200
Message-Id: <20230403142543.1913749-3-hch@lst.de>
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

AFAICS this never had any callers except for the
iov_iter_get_pages_alloc2 wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uio.h |  3 ---
 lib/iov_iter.c      | 17 ++++-------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 37f93a613f3dc7..c84787a20721b1 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -240,9 +240,6 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
-		struct page ***pages, size_t maxsize, size_t *start,
-		iov_iter_extraction_t extraction_flags);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 07872e30ee82e3..764ddebfb9779c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1093,30 +1093,21 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
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
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start, 0);
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
-EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
+EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc2);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
-- 
2.39.2

