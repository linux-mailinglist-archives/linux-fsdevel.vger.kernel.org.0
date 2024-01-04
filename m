Return-Path: <linux-fsdevel+bounces-7398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273582466B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AEE1C220B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A33A2CCD9;
	Thu,  4 Jan 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HS6Lr8NJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D222C855;
	Thu,  4 Jan 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FPwsr0b5fglYQXWUN5NF5I5tBgC3MgAQLlBQ5JhnBJ0=; b=HS6Lr8NJasM40FJXxml08nOWCE
	R5dzJa4VWPkI+0xH0t0rdnBC4ZkdWG8hMKCI7/l6t+DQE21Xh2nviclqPiZ3J12UwjewG3A06Is3f
	VF1mDBFQrEeUxg4MtJwA4mSEv7VeTKryd6+d7EKaraa4tkBEEAsoXHrphR2f3V2wUqcotF1Upk0qj
	KWJWIdlbGUbDxdGMjeKazHHle/Fp20/zQ4WS18X/vn8W1GVOTJX8wna/yeH2NJ2oug0Gu+10cnh9U
	T0cc1amt93PR7gTrdN1mWXPMrjhqJ3i3/mv/tIQ1chd60CHhNxdqsFVAlWQt3NVxu9aplbnK1ve1t
	UG3WiSNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLQiE-00FY2V-Nt; Thu, 04 Jan 2024 16:36:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] buffer: Add kernel-doc for try_to_free_buffers()
Date: Thu,  4 Jan 2024 16:36:50 +0000
Message-Id: <20240104163652.3705753-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240104163652.3705753-1-willy@infradead.org>
References: <20240104163652.3705753-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for this function has become separated from it over
time; move it to the right place and turn it into kernel-doc.  Mild
editing of the content to make it more about what the function does, and
less about how it does it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 31e171382e00..a657920802ac 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2863,26 +2863,6 @@ int sync_dirty_buffer(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(sync_dirty_buffer);
 
-/*
- * try_to_free_buffers() checks if all the buffers on this particular folio
- * are unused, and releases them if so.
- *
- * Exclusion against try_to_free_buffers may be obtained by either
- * locking the folio or by holding its mapping's private_lock.
- *
- * If the folio is dirty but all the buffers are clean then we need to
- * be sure to mark the folio clean as well.  This is because the folio
- * may be against a block device, and a later reattachment of buffers
- * to a dirty folio will set *all* buffers dirty.  Which would corrupt
- * filesystem data on the same device.
- *
- * The same applies to regular filesystem folios: if all the buffers are
- * clean then we set the folio clean and proceed.  To do that, we require
- * total exclusion from block_dirty_folio().  That is obtained with
- * private_lock.
- *
- * try_to_free_buffers() is non-blocking.
- */
 static inline int buffer_busy(struct buffer_head *bh)
 {
 	return atomic_read(&bh->b_count) |
@@ -2916,6 +2896,30 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
 	return false;
 }
 
+/**
+ * try_to_free_buffers: Release buffers attached to this folio.
+ * @folio: The folio.
+ *
+ * If any buffers are in use (dirty, under writeback, elevated refcount),
+ * no buffers will be freed.
+ *
+ * If the folio is dirty but all the buffers are clean then we need to
+ * be sure to mark the folio clean as well.  This is because the folio
+ * may be against a block device, and a later reattachment of buffers
+ * to a dirty folio will set *all* buffers dirty.  Which would corrupt
+ * filesystem data on the same device.
+ *
+ * The same applies to regular filesystem folios: if all the buffers are
+ * clean then we set the folio clean and proceed.  To do that, we require
+ * total exclusion from block_dirty_folio().  That is obtained with
+ * private_lock.
+ *
+ * Exclusion against try_to_free_buffers may be obtained by either
+ * locking the folio or by holding its mapping's private_lock.
+ *
+ * Context: Process context.  @folio must be locked.  Will not sleep.
+ * Return: true if all buffers attached to this folio were freed.
+ */
 bool try_to_free_buffers(struct folio *folio)
 {
 	struct address_space * const mapping = folio->mapping;
-- 
2.43.0


