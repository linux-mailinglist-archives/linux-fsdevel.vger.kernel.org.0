Return-Path: <linux-fsdevel+bounces-7624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A68D682884C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F2A286294
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049A3C497;
	Tue,  9 Jan 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hGupIP86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8D3C481;
	Tue,  9 Jan 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OxfIaVCptnL2Ku+19F0c3pEPzF3dZDzT7NBA3grsvvg=; b=hGupIP86Lcpom0DkHphtQajPbO
	HXwIe8TJDCYILaA1beUztFAWD5PDxrfHloqmSPK5Hoxm73HAhHDYQ9B1+qW96hj8q6JMiYv9CVxGC
	IVhPSbqGoKSFYEYj2eSb2EIiU3FY2WAxgbvrtEYho0pQ2pAwyW/jGFTQYMmYieceg+l9fcE+0Mpnt
	7H/hZnvulSuk+A0tWgBNEZOgOTkXAY826yGrfGMQlI8kH4ZEPmPWHynnB4OWNzy2qVQutfhFCb9Y0
	sXlH74lhDdYo/4lM2MwUx7IEpkwfgCF5FgkhPTHnutArNUL/XQ6FHEmggXFYTqicQiHgX4G1DNGXw
	R6Ppwo8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNDB1-009xrY-5o; Tue, 09 Jan 2024 14:33:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] buffer: Add kernel-doc for brelse() and __brelse()
Date: Tue,  9 Jan 2024 14:33:54 +0000
Message-Id: <20240109143357.2375046-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240109143357.2375046-1-willy@infradead.org>
References: <20240109143357.2375046-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the documentation for __brelse() to brelse(), format it as
kernel-doc and update it from talking about pages to folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 17 ++++++++---------
 include/linux/buffer_head.h | 16 ++++++++++++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 160bbc1f929c..9a7b3649c872 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1226,17 +1226,16 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
 
-/*
- * Decrement a buffer_head's reference count.  If all buffers against a page
- * have zero reference count, are clean and unlocked, and if the page is clean
- * and unlocked then try_to_free_buffers() may strip the buffers from the page
- * in preparation for freeing it (sometimes, rarely, buffers are removed from
- * a page but it ends up not being freed, and buffers may later be reattached).
+/**
+ * __brelse - Release a buffer.
+ * @bh: The buffer to release.
+ *
+ * This variant of brelse() can be called if @bh is guaranteed to not be NULL.
  */
-void __brelse(struct buffer_head * buf)
+void __brelse(struct buffer_head *bh)
 {
-	if (atomic_read(&buf->b_count)) {
-		put_bh(buf);
+	if (atomic_read(&bh->b_count)) {
+		put_bh(bh);
 		return;
 	}
 	WARN(1, KERN_ERR "VFS: brelse: Trying to free free buffer\n");
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 56a1e9c1e71e..3cbc01bbc398 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -303,6 +303,22 @@ static inline void put_bh(struct buffer_head *bh)
         atomic_dec(&bh->b_count);
 }
 
+/**
+ * brelse - Release a buffer.
+ * @bh: The buffer to release.
+ *
+ * Decrement a buffer_head's reference count.  If @bh is NULL, this
+ * function is a no-op.
+ *
+ * If all buffers on a folio have zero reference count, are clean
+ * and unlocked, and if the folio is clean and unlocked then
+ * try_to_free_buffers() may strip the buffers from the folio in
+ * preparation for freeing it (sometimes, rarely, buffers are removed
+ * from a folio but it ends up not being freed, and buffers may later
+ * be reattached).
+ *
+ * Context: Any context.
+ */
 static inline void brelse(struct buffer_head *bh)
 {
 	if (bh)
-- 
2.43.0


