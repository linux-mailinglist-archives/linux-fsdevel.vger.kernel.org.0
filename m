Return-Path: <linux-fsdevel+bounces-17011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E62F8A616F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E315B21A83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206D2033E;
	Tue, 16 Apr 2024 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dagUszmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330617999;
	Tue, 16 Apr 2024 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237480; cv=none; b=dvNhR85Q3tO+bk6zqw576DYqPRjSwopPAH338jXXHbhdQflk8qSg/cQDyF1xyHuYQ7Z680eRpcmiVm/IYAtio3WxH7aThn8ZOpoUZlB1+TZzsMFC8f29ZpXD9SNmPEY83BjndeurNZPna1O+CV7hJDKhIK+qjIwdqOfQo6kFc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237480; c=relaxed/simple;
	bh=E95jUP9ti1BS2kxBZYtw3uLF7lT3S+o1aLhs5Rmn4Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5ZKpXBbQaLKE+Q2rg76Zxqdl0rXqiJubOLT2aEgbS7Rj8AlJjgD4oGHFOAX6375KXj4zb9Jp4RQOP8heJyp1C6DvDAgNWZo3hqdzgUnz974Z7NOziEAazcIQU3YgttT4ReJFUJCi2UiHm7W6B97foEvnR6LRlKBupBjg8cEdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dagUszmL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pk9BBryg92so+HGLLXF/V590GSRkQSChFQr6bBQemN0=; b=dagUszmLGKgFnvSZCKCQjufSTU
	geaiXPZExHmlwI6cmL8f4YeBnxVf+t5S0B2ek3wVY74g/C3XRkXjWfvGBJxH8veEajEZq8S+DQPjW
	EJ28R7PXN+Ez5NZ5erZS2xj9ozG8N4h6/Ae158fP3/b5YI++9RQHYXsU/d3Awof6GEO/y6E40VSgG
	WZJVOOKTZSj2qugx+iHc9fWty2citR62r2YcHla04xF8KFbgPcG6Ig49TsW1GQVZMYu4glmPbLS2V
	RoRMYSJ5+4zoUWf7K5OmhbyfHikT8RMi/8CmC6m5t6e13s6C+kOFf4aNMUA2k7eZHDhVEjK73JiHf
	UsLUsypg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKW-0000000H6b4-1IqZ;
	Tue, 16 Apr 2024 03:17:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 6/8] buffer: Add kernel-doc for bforget() and __bforget()
Date: Tue, 16 Apr 2024 04:17:50 +0100
Message-ID: <20240416031754.4076917-7-willy@infradead.org>
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

Distinguish these functions from brelse() and __brelse().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 |  9 ++++++---
 include/linux/buffer_head.h | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e5beca3868a7..60829312787a 100644
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
index c145817c6ca0..a1c0bdd0cca6 100644
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


