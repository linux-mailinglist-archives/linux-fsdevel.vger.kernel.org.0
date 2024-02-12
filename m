Return-Path: <linux-fsdevel+bounces-11131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4F851971
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE141F22D40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4CC3F8D0;
	Mon, 12 Feb 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EkF+I8nC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29B1EEE4;
	Mon, 12 Feb 2024 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755466; cv=none; b=ZmnFXibo/9C6ET7sfibz0iQi6q/irqsmP31nmBE4hcMtQR5vTo7eczGl1pJPmUZYgyuELL8QC5yjApnDVgq7AiHd8A0SuYNs2Fz+13A2br1xotMRm9ZwbDlyl88HKq3+hvi7p8vU+uQCyT3E6apWJTjMHsNeGfHvrYnmp68nE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755466; c=relaxed/simple;
	bh=q/9jEJfnqEQkc3MaRhsxgrh4+o9HVwSNE5hPfxrTXB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qk75W7L/IwH92HLTA7l4B8oF8sXHQ6JqgAH13nRgvaL1+PGKq8nXvdxWR+gI8e2yi8geswacm6uCrXLU5Cek6uvWs1ttnKSlBZJt86lEPGEeXuBLYvnpfs8LAXPUpGuPSzqsFF2gAd3JyjLZfQiRIglsvcaeLgdMNp7eGbW2/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EkF+I8nC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707755463;
	bh=q/9jEJfnqEQkc3MaRhsxgrh4+o9HVwSNE5hPfxrTXB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkF+I8nCzGXwgsjLIO9z5hrj4YLXkG1Gy+qBhoGBPBzwMSQ2ngaByzqZ8MwMu7uYR
	 HVuW3uAHo7KnmvGrg8FW5d8BZO/OcZAetn3pHPCIKXU3OWKZQrd1Gq04mjZpxP50jP
	 v2sxs0xOImWi8VD0bUUiy+VYH/NlIQft+vc+QCvBV0VT3G9XLCd+o0JpXhqhRW8rT6
	 HOmpfq2rS2ZnfBh8TL+swhmVq8Py5ZEKkF6SvmeGs+vHNFDGloUyRXskUrpYkosMzK
	 D8W0MOk5fYJK6ialW8Gs/5HZdIgZbPC1bGBNdK+vbFrB6x2RODeex/oO2dOq6vh+67
	 oMJWvt2aRlatw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TYVMC3L1TzXvQ;
	Mon, 12 Feb 2024 11:31:03 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: [PATCH v5 1/8] dax: alloc_dax() return ERR_PTR(-EOPNOTSUPP) for CONFIG_DAX=n
Date: Mon, 12 Feb 2024 11:30:54 -0500
Message-Id: <20240212163101.19614-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return value from NULL to PTR_ERR(-EOPNOTSUPP) for
CONFIG_DAX=n to be consistent with the fact that CONFIG_DAX=y
never returns NULL.

This is done in preparation for using cpu_dcache_is_aliasing() in a
following change which will properly support architectures which detect
data cache aliasing at runtime.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: dm-devel@lists.linux.dev
Cc: nvdimm@lists.linux.dev
---
 drivers/dax/super.c | 5 +++++
 include/linux/dax.h | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0da9232ea175..205b888d45bf 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -319,6 +319,11 @@ EXPORT_SYMBOL_GPL(dax_alive);
  * that any fault handlers or operations that might have seen
  * dax_alive(), have completed.  Any operations that start after
  * synchronize_srcu() has run will abort upon seeing !dax_alive().
+ *
+ * Note, because alloc_dax() returns an ERR_PTR() on error, callers
+ * typically store its result into a local variable in order to check
+ * the result. Therefore, care must be taken to populate the struct
+ * device dax_dev field make sure the dax_dev is not leaked.
  */
 void kill_dax(struct dax_device *dax_dev)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b463502b16e1..df2d52b8a245 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -86,11 +86,7 @@ static inline void *dax_holder(struct dax_device *dax_dev)
 static inline struct dax_device *alloc_dax(void *private,
 		const struct dax_operations *ops)
 {
-	/*
-	 * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
-	 * NULL is an error or expected.
-	 */
-	return NULL;
+	return ERR_PTR(-EOPNOTSUPP);
 }
 static inline void put_dax(struct dax_device *dax_dev)
 {
-- 
2.39.2


