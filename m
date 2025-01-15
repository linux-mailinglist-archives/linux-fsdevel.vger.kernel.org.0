Return-Path: <linux-fsdevel+bounces-39257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 952EAA11E7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0CD188E627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721423F29B;
	Wed, 15 Jan 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h8dpluIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AC23F280;
	Wed, 15 Jan 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934436; cv=none; b=lA5TOeCk5RbbZMK/BxzDqL0xDDupORWu90ECrNQGW9XXq3rWGOiaXDGcEFSRoQ7JIgFmhsYy65D3h5Yy5FSnA9HwTLL9n295v0IL2GtzdvT0C/lb2bQ0dHdYWjPYlglPOCQ3DiObKHIyFbCfwOEEzkrwLUK74EjbeUl9e+z/3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934436; c=relaxed/simple;
	bh=n811duFVKAkIfWm5Z6B/zhieoS2ASsCsFji31GJzTjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adpMcX+y0Dor3e+RB8qBiwfa67AejD3RyJs9ymLl/7HWkQdeaCmtMom6uAz0r5zWF9dVOIT72MrshsFMStaSgfr1T9nxH12fRwDZk5bRunMeMFauYSfaNBgbFitTDLfhZI4enu498fARJWPEOKJ3aaXuPqltCA6B73zFduAu2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h8dpluIR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hPOnhSQ0mVQSxdqd9+OXmMe6Ci3iABOIejHsGxfpgNc=; b=h8dpluIRfwDN/s/F80wti5ojXn
	5K6j6iAa+Y1Ss0dCC8pdGnHsR8V8WqiIOUb/KDp2Qod3fGSjLTa8xPYuEPrDdxRJQ3DKHBjd7Dh1g
	OvI1poxJMckuc++FXPSjpY3tdBh1iYBeD2kav7hWUyspMp8ib/zxMfCf17Xjn6rTl89Hr7Ok9ZL+o
	RHZkq5gKn48IjS6N23bDigYEZjCQFyPn4Iibj6UQuvT0jaEmo/9QITCWt/8jZqGe8foa8FB13z7Xj
	Lxz3opalR6o8vDFRp3hRsfX5pNWVV13yKwXiQMVGve6izyO96gJCCJC1MePDG3EvqgTfKc/epzBly
	cZFUYf/g==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzV-0000000BOec-1gaW;
	Wed, 15 Jan 2025 09:47:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	gfs2@lists.linux.dev
Subject: [PATCH 3/8] lockref: use bool for false/true returns
Date: Wed, 15 Jan 2025 10:46:39 +0100
Message-ID: <20250115094702.504610-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115094702.504610-1-hch@lst.de>
References: <20250115094702.504610-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Replace int used as bool with the actual bool type for return values that
can only be true or false.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockref.h |  6 +++---
 lib/lockref.c           | 30 ++++++++++++++----------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index e5aa0347f274..3d770e1bdbad 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -36,11 +36,11 @@ struct lockref {
 
 extern void lockref_get(struct lockref *);
 extern int lockref_put_return(struct lockref *);
-extern int lockref_get_not_zero(struct lockref *);
-extern int lockref_put_or_lock(struct lockref *);
+bool lockref_get_not_zero(struct lockref *lockref);
+bool lockref_put_or_lock(struct lockref *lockref);
 
 extern void lockref_mark_dead(struct lockref *);
-extern int lockref_get_not_dead(struct lockref *);
+bool lockref_get_not_dead(struct lockref *lockref);
 
 /* Must be called under spinlock for reliable results */
 static inline bool __lockref_is_dead(const struct lockref *l)
diff --git a/lib/lockref.c b/lib/lockref.c
index b1b042a9a6c8..5d8e3ef3860e 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -58,23 +58,22 @@ EXPORT_SYMBOL(lockref_get);
  * @lockref: pointer to lockref structure
  * Return: 1 if count updated successfully or 0 if count was zero
  */
-int lockref_get_not_zero(struct lockref *lockref)
+bool lockref_get_not_zero(struct lockref *lockref)
 {
-	int retval;
+	bool retval = false;
 
 	CMPXCHG_LOOP(
 		new.count++;
 		if (old.count <= 0)
-			return 0;
+			return false;
 	,
-		return 1;
+		return true;
 	);
 
 	spin_lock(&lockref->lock);
-	retval = 0;
 	if (lockref->count > 0) {
 		lockref->count++;
-		retval = 1;
+		retval = true;
 	}
 	spin_unlock(&lockref->lock);
 	return retval;
@@ -106,22 +105,22 @@ EXPORT_SYMBOL(lockref_put_return);
  * @lockref: pointer to lockref structure
  * Return: 1 if count updated successfully or 0 if count <= 1 and lock taken
  */
-int lockref_put_or_lock(struct lockref *lockref)
+bool lockref_put_or_lock(struct lockref *lockref)
 {
 	CMPXCHG_LOOP(
 		new.count--;
 		if (old.count <= 1)
 			break;
 	,
-		return 1;
+		return true;
 	);
 
 	spin_lock(&lockref->lock);
 	if (lockref->count <= 1)
-		return 0;
+		return false;
 	lockref->count--;
 	spin_unlock(&lockref->lock);
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(lockref_put_or_lock);
 
@@ -141,23 +140,22 @@ EXPORT_SYMBOL(lockref_mark_dead);
  * @lockref: pointer to lockref structure
  * Return: 1 if count updated successfully or 0 if lockref was dead
  */
-int lockref_get_not_dead(struct lockref *lockref)
+bool lockref_get_not_dead(struct lockref *lockref)
 {
-	int retval;
+	bool retval = false;
 
 	CMPXCHG_LOOP(
 		new.count++;
 		if (old.count < 0)
-			return 0;
+			return false;
 	,
-		return 1;
+		return true;
 	);
 
 	spin_lock(&lockref->lock);
-	retval = 0;
 	if (lockref->count >= 0) {
 		lockref->count++;
-		retval = 1;
+		retval = true;
 	}
 	spin_unlock(&lockref->lock);
 	return retval;
-- 
2.45.2


