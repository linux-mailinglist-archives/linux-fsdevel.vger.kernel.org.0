Return-Path: <linux-fsdevel+bounces-39255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72B1A11E6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8839161EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6E20CCFD;
	Wed, 15 Jan 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g+5BuL+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F14248171;
	Wed, 15 Jan 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934431; cv=none; b=qhyoF0Td6XzWiEDGHTCkH9jDAs2wBFjVPv5Krme4c5dYDC8bnD3IKCrPGPXVFN5hwU6aUJqkatAtPaHmevpTdxZnesmpcDFO4jC4o52slLWR2xzHN2gSISsQaEsQze/KW8shZRwnvvE9hlylDQ7VbqH6WStqR+RGcSjObNzpY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934431; c=relaxed/simple;
	bh=jHM4aD/gL1ggtNvB9ByEUsCGU88B5c3rVl9gfN6z0Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSNdFmKmz3xV7Ubg4xnAVVFO5crkucp+6YCoxAJ0AdVIug8Q2lbiX5oxk1nT5nvCcXvd+DBBIFZZDAVYuBF6nW8282wfhcjItZzMC9TJ78wIrFwwqaIk/tqMy5FLmjtUR3I3dOBISIxAHhFPunsARSkKDMstBiKVOz0BTwHqkA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g+5BuL+c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2emN2ZekPl9pUS8HrHL111sEmJvGZ8RKJUw7xW8tiZU=; b=g+5BuL+cWMKlkPq2h1gfpxLmjj
	rywUnEu6MLP81WJIXN0CxJ3brcQ8Fja26vBn45gYLf5UPcaz+Mkjd8xR7XkSjCIruNVND/0pxuP2d
	h4b+V2eX2CWFv7JUC/c24Zm565irmjyEeDFdYLVnSZZ2iFp2X2D4NjaGSPWms3998+G1D66YrZi9c
	+JLYCK6Upy02luduPiZO2tB9WxIkXVGpUMexecOaZL9Ozn/q4RgIgOBmVaD5aSVvlLbha55jDIYpk
	EKiV5yC5q1AXqGcmt0JUDE28B8UQqw0Qd4/3l82cCnojKvEmz4wbLBsT0kHJORBeUOfh24SodK03M
	+3jlm7uQ==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzQ-0000000BOcl-1dG1;
	Wed, 15 Jan 2025 09:47:08 +0000
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
Subject: [PATCH 1/8] lockref: remove lockref_put_not_zero
Date: Wed, 15 Jan 2025 10:46:37 +0100
Message-ID: <20250115094702.504610-2-hch@lst.de>
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

lockref_put_not_zero is not used anywhere, and unless I'm missing
something didn't end up being used used at all.  Remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/lockref.h |  1 -
 lib/lockref.c           | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index c3a1f78bc884..e5aa0347f274 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -37,7 +37,6 @@ struct lockref {
 extern void lockref_get(struct lockref *);
 extern int lockref_put_return(struct lockref *);
 extern int lockref_get_not_zero(struct lockref *);
-extern int lockref_put_not_zero(struct lockref *);
 extern int lockref_put_or_lock(struct lockref *);
 
 extern void lockref_mark_dead(struct lockref *);
diff --git a/lib/lockref.c b/lib/lockref.c
index 2afe4c5d8919..a68192c979b3 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -81,34 +81,6 @@ int lockref_get_not_zero(struct lockref *lockref)
 }
 EXPORT_SYMBOL(lockref_get_not_zero);
 
-/**
- * lockref_put_not_zero - Decrements count unless count <= 1 before decrement
- * @lockref: pointer to lockref structure
- * Return: 1 if count updated successfully or 0 if count would become zero
- */
-int lockref_put_not_zero(struct lockref *lockref)
-{
-	int retval;
-
-	CMPXCHG_LOOP(
-		new.count--;
-		if (old.count <= 1)
-			return 0;
-	,
-		return 1;
-	);
-
-	spin_lock(&lockref->lock);
-	retval = 0;
-	if (lockref->count > 1) {
-		lockref->count--;
-		retval = 1;
-	}
-	spin_unlock(&lockref->lock);
-	return retval;
-}
-EXPORT_SYMBOL(lockref_put_not_zero);
-
 /**
  * lockref_put_return - Decrement reference count if possible
  * @lockref: pointer to lockref structure
-- 
2.45.2


