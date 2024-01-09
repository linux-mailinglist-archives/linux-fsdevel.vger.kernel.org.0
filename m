Return-Path: <linux-fsdevel+bounces-7617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B1828836
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F080285CB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863D3A1A1;
	Tue,  9 Jan 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lt2UkjDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531C39FD9;
	Tue,  9 Jan 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vjZcjkW+p03n5C+wK7KGpaZp9bYGqoRJwYEYBxOudMc=; b=Lt2UkjDkT28/d0suB5S1yhWMov
	vEOp9Vd5ZNRxxNKaFg7GdXTopFh0JJf4jJEOFGHoPKIn838dLZMUDVxrV3wWgW2sOoG1Vx5dZufH3
	lkBgApHwpQC2gQeJTNTrqUH3L2J6y+emSTGZV6DkFh6hsGpMfN9vv3VfnNW02r4SgnSVtA8xxvmky
	A/rIttBXUDzgh+PZG0V57SsWSRNlUh5tOhYx6QLOSwQVe7+SjYaSlaWScOt1jZZQ6x8z5SMwb2Mwl
	gqWNtgPaqCS71tNQXg9yzyCd6V67+KCBmvAqFrTmFbaatP+42QObd6TzF3KVw99BUa1y4mnclSNKR
	cyl7y2mw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNDB1-009xra-8V; Tue, 09 Jan 2024 14:33:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] buffer: Add kernel-doc for bforget() and __bforget()
Date: Tue,  9 Jan 2024 14:33:55 +0000
Message-Id: <20240109143357.2375046-7-willy@infradead.org>
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

Distinguish these functions from brelse() and __brelse().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 |  9 ++++++---
 include/linux/buffer_head.h | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9a7b3649c872..05b68eccfdcc 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1242,9 +1242,12 @@ void __brelse(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(__brelse);
 
-/*
- * bforget() is like brelse(), except it discards any
- * potentially dirty data.
+/**
+ * __bforget - Discard any dirty data in a buffer.
+ * @bh: The buffer to forget.
+ *
+ * This variant of bforget() can be called if @bh is guaranteed to not
+ * be NULL.
  */
 void __bforget(struct buffer_head *bh)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 3cbc01bbc398..9dc5477f13c7 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -325,6 +325,16 @@ static inline void brelse(struct buffer_head *bh)
 		__brelse(bh);
 }
 
+/**
+ * bforget - Discard any dirty data in a buffer.
+ * @bh: The buffer to forget.
+ *
+ * Call this function instead of brelse() if the data written to a buffer
+ * no longer needs to be written back.  It will clear the buffer's dirty
+ * flag so writeback of this buffer will be skipped.
+ *
+ * Context: Any context.
+ */
 static inline void bforget(struct buffer_head *bh)
 {
 	if (bh)
-- 
2.43.0


