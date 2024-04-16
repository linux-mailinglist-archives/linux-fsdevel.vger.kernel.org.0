Return-Path: <linux-fsdevel+bounces-17017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F978A617A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53ED2B21D07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D563937719;
	Tue, 16 Apr 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="havkGGcL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E82110F;
	Tue, 16 Apr 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237485; cv=none; b=lGHULYtPTT/zH6465a7TB4DbNlVHrUs28eCjfurpgggMXVGoIYOpqbBYAs5w/D94+63Af8PmRR2M5F0SAItHCfTw3emqQJYLLfLG3asEMwLNQrWCI9f/6pgHxp8/jVJJml9SgsLhYLZSGIE7oAH42dWE1gqK1ztw2i2pZzGjgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237485; c=relaxed/simple;
	bh=DbC+Tn185R2Zx2iSvqPYl8LWUAlvno1KmLJ8dcxgaVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHm+tHx7eTeNjTHXyFquf5UW+/wa5hUCOJzcst08iwwaeJoWANDL9qa8o9lOaKvH8EMBmPKadgLy+PinfqQx7BwTzii7+T0TfaZkxw3PAJqsPYjZHlQs0ripCbWz5CAhOXA/q+INqEftBN0kePhyAsH4PxDazv7bdgoB4su2StU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=havkGGcL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5/IxEJ6lq78GgJjoEkwt0LTdkDq6FNAtO1rS999rOAk=; b=havkGGcLEGDZABeim5heL7u4SJ
	70uwilsM6mgfa1v87jI1mC2lNqz+8wYbhu2a1GDsvwxuWCDDdQTZvDfepy+5AqlFmN1+w1JtzgRiD
	Pb2Smw2Ku/gUDe+PcNsZGA1AZASc1c0k5HmPwjyPkw9mHniToHObl3VRFJpwkSmVbKMfVGxpO4YVe
	QarpP4ZXrU5+/nmKL15BH5aq1Ns4S0mgyAOgcVKYG55GMWrbndoQxmWuuOSr2kxMw81MEr8/RgAei
	i34N2Gk8mr4W3dxDQgJnCX3W2TT4Nex0yYBIR8e/HUwZ/NrP5/7gXaEinpsf3bqSBKTYr3lkhxue3
	eYAoZ+dw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKW-0000000H6b2-0zlb;
	Tue, 16 Apr 2024 03:17:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 5/8] buffer: Add kernel-doc for brelse() and __brelse()
Date: Tue, 16 Apr 2024 04:17:49 +0100
Message-ID: <20240416031754.4076917-6-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416031754.4076917-1-willy@infradead.org>
References: <20240416031754.4076917-1-willy@infradead.org>
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
index 32ab3eddc44f..e5beca3868a7 100644
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
index 56a1e9c1e71e..c145817c6ca0 100644
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
+ * and unlocked, and if the folio is unlocked and not under writeback
+ * then try_to_free_buffers() may strip the buffers from the folio in
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


