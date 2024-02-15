Return-Path: <linux-fsdevel+bounces-11718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1651385665E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6358285541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7E13342B;
	Thu, 15 Feb 2024 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lJxsuurM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C2132470;
	Thu, 15 Feb 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008403; cv=none; b=cO6foGmzsI5XvlGJusSqjR6nK3GP01aPU5jX8X2rqpDcacRE7F7M8fKR8GmioXxmmsvBqF2BiReN6MQEDOPOJ5pwigFwx7rHLpCwME+hUO/omzFzR7zQa56faiukuNfimPWJPDeSwRhhF9riDvgL6jRWPcuTXH2H1PyaxNQHoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008403; c=relaxed/simple;
	bh=JafNy954LGAswGK3M3iYUpQrWP3IyrMlG3pf6B1HRm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwEBek/XxdZGS+CaKSfTxD9j1Q+5q2F8oeXew/n/S9pxmnQZsHdPFITsEQwMXUpvUJzCgNLB4L5tiHRmCmZnasccrnpozN/pRDfmmCNjonQrbwxijmR1Xma66pn3b9qncmC0bEKgzb6BtDkvnRpjpNYN6PvOcmDkiQBzxBNk0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lJxsuurM; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708008399;
	bh=JafNy954LGAswGK3M3iYUpQrWP3IyrMlG3pf6B1HRm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJxsuurMOJq5+e74ZxcF+tIqPH0Qs+YhXRuSmvFSmLIGw0LXLL9OmA1TEc/hvC2zZ
	 o91WMEukwLB1u4oCCHlgydXVguhQi11fEI6Vi8Ku08OyjSoiO2W2yeKDFGbjlSybRo
	 grKnwo+y78PBVFCkNYKO8rAp12NTsmM88gHsKGJN+nzU5BYHEfglGxTm+PNhXBm4WX
	 1SH+QbvBu0shB1ITutjbBN/RvzwOVym/BdBANG0CF8gzUqRhhDPi+s7F1/D+ZD8taq
	 b/ma0zxd+t86Hak1i/GDe5SYOKqW2uCqPPPfo+rNAEbyPVhQvm8B6Y94EIVbT9v+oc
	 6t/MP5Z/oCexQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TbHvM4gxZzZS5;
	Thu, 15 Feb 2024 09:46:39 -0500 (EST)
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
Subject: [PATCH v6 2/9] dax: alloc_dax() return ERR_PTR(-EOPNOTSUPP) for CONFIG_DAX=n
Date: Thu, 15 Feb 2024 09:46:26 -0500
Message-Id: <20240215144633.96437-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215144633.96437-1-mathieu.desnoyers@efficios.com>
References: <20240215144633.96437-1-mathieu.desnoyers@efficios.com>
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

Fixes: 4e4ced93794a ("dax: Move mandatory ->zero_page_range() check in alloc_dax()")
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
index e3ffe7c7f01d..9d3e3327af4c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -88,11 +88,7 @@ static inline void *dax_holder(struct dax_device *dax_dev)
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


