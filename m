Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13C6D481E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjDCO0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjDCO0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:26:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E568A312BB;
        Mon,  3 Apr 2023 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9rJG6l8wMzXAM54wP29kUuXjpqOODtNDmtoaNswAGgc=; b=s49q265FubigqzjfH3WsRsztsf
        cHzWXCvfJ2gwLev7T7PI6tWN8TrIEMMRfTmfguJjfauMEVXaYybc1df4N6bYwueE3tV2cVsTM5UKW
        M5Tr2nVMESN3HqLljX4hW+RJ8GflrFIYzmWTLwsXJovlGplE4UXD8nnlDRMNnT4I0zOJij9mDXlBr
        TPp3oay7HljxkTNXBlZwP66CJVOxoH7Me1BQjVV3Dg3QzpaVKBoZ9y9DcQALbH8RFZZM4f+a+w9rE
        aZY0tsL72yl8D4BdrDaNwT3ZtgmeNtcoOU9sMquRVqD/nQzkpPBvGwnNgfAtexW650xH1DnRXQIXA
        EEZR9VKg==;
Received: from [2001:4bb8:191:a744:529d:286f:e3d8:fddb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjL85-00FdlL-1f;
        Mon, 03 Apr 2023 14:25:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] iov_iter: remove iov_iter_get_pages
Date:   Mon,  3 Apr 2023 16:25:41 +0200
Message-Id: <20230403142543.1913749-2-hch@lst.de>
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

All previous users have been converted to the FOLL_PIN based interfaces.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uio.h |  3 ---
 lib/iov_iter.c      | 14 +++-----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 74598426edb405..37f93a613f3dc7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -238,9 +238,6 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
-ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
-		size_t maxsize, unsigned maxpages, size_t *start,
-		iov_iter_extraction_t extraction_flags);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fad95e4cf372a2..07872e30ee82e3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1081,23 +1081,15 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
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
 
 	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
-					  start, extraction_flags);
-}
-EXPORT_SYMBOL_GPL(iov_iter_get_pages);
-
-ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
-		size_t maxsize, unsigned maxpages, size_t *start)
-{
-	return iov_iter_get_pages(i, pages, maxsize, maxpages, start, 0);
+					  start, 0);
 }
 EXPORT_SYMBOL(iov_iter_get_pages2);
 
-- 
2.39.2

