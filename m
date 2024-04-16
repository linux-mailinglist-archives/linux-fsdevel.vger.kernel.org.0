Return-Path: <linux-fsdevel+bounces-17016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E638A6177
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52461C20B51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A06331A76;
	Tue, 16 Apr 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UVdWMa7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF82110F;
	Tue, 16 Apr 2024 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237482; cv=none; b=CEFe/k2vcXjAviSx41dsDuqTWUWNrmKVDLZOSl7rgi408YxJqjsmDe1AX0SDTz9IynwuYUwmf5Q1SrFRGWS+bIqbpS2gR0E6cyJQzczNE6InKj9WpU4/oX5vonys9PnA8JmfRUhlXNWCarcxanpyCwQaC3tsm8iItOxidVBhNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237482; c=relaxed/simple;
	bh=9NvoCCyUkA9ND3Xcd1/YQvCMqfALf0ZYmG86TlVkXvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXHiJG7SL6J2YVudajMWTF/wmGl7Xto7jY7hv1RuyrTiK4X2KXxc9MVqHCdzTcAtIoqFoflLyrrY6BmwOtpFNKjKf7GB3fw4Dx6v/7lONxytCU+lY5DrqUOAXYh2pVtXRG2cf/Jz6vuvFq+CyUIYYoaaVnbkwFmK2pBX8DijVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UVdWMa7d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lpOFS2AKUdDWSXV132Y4ki1FMs3P3eJdhkcMjclknoI=; b=UVdWMa7d6K7PyViC4z6/BC4Ofe
	H99ytGmyycFiro8CSRxhP0RxrPHJSZhzWDLPOeIT3Pt5QtfZOVpF/JiKKqp2XCo6N/wvSOWVs9Awt
	u3xV+h+p4bHhoNCaWycEtRdhvYQG9TZTvKFoAmt5CdH+qLRDS9CKTrcttbA4pcx9qwZx0iwqV7iYH
	3mYKWA8dM0Ct+8i/vmwCf+DSnVNKUQr9a+Am7uWyCRqg74DYYBJDvNGLHAw9GAJZtB42Bp7e0QIZA
	M1+utYnL/5nlMX/jOrFOsOOoSgtOqsBJxVSp4oaot9JZgl0PhZxGZVJTVH4+WAXLrqPeXcVHmOb8w
	tLp0jdyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKW-0000000H6ay-0Jp5;
	Tue, 16 Apr 2024 03:17:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 3/8] buffer: Add kernel-doc for try_to_free_buffers()
Date: Tue, 16 Apr 2024 04:17:47 +0100
Message-ID: <20240416031754.4076917-4-willy@infradead.org>
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

The documentation for this function has become separated from it over
time; move it to the right place and turn it into kernel-doc.  Mild
editing of the content to make it more about what the function does, and
less about how it does it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b08526bdcb54..0466ed7ed95a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2868,26 +2868,6 @@ int sync_dirty_buffer(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(sync_dirty_buffer);
 
-/*
- * try_to_free_buffers() checks if all the buffers on this particular folio
- * are unused, and releases them if so.
- *
- * Exclusion against try_to_free_buffers may be obtained by either
- * locking the folio or by holding its mapping's i_private_lock.
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
- * i_private_lock.
- *
- * try_to_free_buffers() is non-blocking.
- */
 static inline int buffer_busy(struct buffer_head *bh)
 {
 	return atomic_read(&bh->b_count) |
@@ -2921,6 +2901,30 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
 	return false;
 }
 
+/**
+ * try_to_free_buffers - Release buffers attached to this folio.
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
+ * i_private_lock.
+ *
+ * Exclusion against try_to_free_buffers may be obtained by either
+ * locking the folio or by holding its mapping's i_private_lock.
+ *
+ * Context: Process context.  @folio must be locked.  Will not sleep.
+ * Return: true if all buffers attached to this folio were freed.
+ */
 bool try_to_free_buffers(struct folio *folio)
 {
 	struct address_space * const mapping = folio->mapping;
-- 
2.43.0


