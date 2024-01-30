Return-Path: <linux-fsdevel+bounces-9548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AFC842A0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772F41C24257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41645129A80;
	Tue, 30 Jan 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vgbjUBoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80386AD3;
	Tue, 30 Jan 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633591; cv=none; b=iRv4L8GOw5Al1iS1lp+1GdIfRYEsYTT6Xoj3H6aCpFr+WMitydX8E6qi9WdNUktYG8bfdGnxIhajRC5Y3OGKu1JkLRF4uvHmelwuJQ4AtO1zRTgQf/Dtb1YVTpN+n+9WCYZ+bm+aqVnrv2x7fbtQDaUS0kim7uRzmdV+3vMwrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633591; c=relaxed/simple;
	bh=kONcCPsuyI5WQYSGBCSYy4QvFvi3USH7Uw/j5x6yQS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGAFNgESmrH8YzT2H/Mjw1bymqWi0Xx2e1pAyfplLByHB4mG78FPvzKwFmCpRE8jkuuN2LxYGoKun2LSOllR10/e1ezZGVYSewnBPvJ2lOLQDWxyaRhOegxZZpvKOTg7jQbVu98sqECRbsForC+ALshtzIyrkt68cPIisZvJw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=vgbjUBoC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706633582;
	bh=kONcCPsuyI5WQYSGBCSYy4QvFvi3USH7Uw/j5x6yQS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vgbjUBoCsBWslMcltBfdpWSeMuBJh9vagVsOzVBCsYPflmZF21l/oXX1Ba/PO3mLt
	 IAo6tDBPixabdyL82vFyeZRM4K5gXSlF3AcHSkts4ATD0jK0r54h3KWd9BfSuB2vq3
	 5ncl3QmDBgaRucDB6G9aoZY9wcKTZ8lNMpVD2BB6c/pWaO6TWZJpNAP6qpjr4lp/QH
	 Xrf1q2e9OeLafet9cmHN9zLTm4hViwA6TMJFVknG1455my5qsCaRlgKhoJB5AHSqBX
	 z7oR+SBvEguwEdLQu5X8pytv05SsqgN3NUYNRzNrZcjomR6+XC1ZyjdraSUi/geEb6
	 in89aPEvh0XWw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPWSZ4m37zVCR;
	Tue, 30 Jan 2024 11:53:02 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 1/8] dax: Introduce dax_is_supported()
Date: Tue, 30 Jan 2024 11:52:48 -0500
Message-Id: <20240130165255.212591-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new dax_is_supported() static inline to check whether the
architecture supports DAX.

This replaces the following fs/Kconfig:FS_DAX dependency:

  depends on !(ARM || MIPS || SPARC)

This is done in preparation for its use by each filesystem supporting
the dax mount option to validate whether dax is indeed supported.

This is done in preparation for using dcache_is_aliasing() in a
following change which will properly support architectures which detect
dcache aliasing at runtime.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/Kconfig          |  1 -
 include/linux/dax.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 42837617a55b..e5efdb3b276b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -56,7 +56,6 @@ endif # BLOCK
 config FS_DAX
 	bool "File system based Direct Access (DAX) support"
 	depends on MMU
-	depends on !(ARM || MIPS || SPARC)
 	depends on ZONE_DEVICE || FS_DAX_LIMITED
 	select FS_IOMAP
 	select DAX
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b463502b16e1..cfc8cd4a3eae 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -78,6 +78,12 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 		return false;
 	return dax_synchronous(dax_dev);
 }
+static inline bool dax_is_supported(void)
+{
+	return !IS_ENABLED(CONFIG_ARM) &&
+	       !IS_ENABLED(CONFIG_MIPS) &&
+	       !IS_ENABLED(CONFIG_SPARC);
+}
 #else
 static inline void *dax_holder(struct dax_device *dax_dev)
 {
@@ -122,6 +128,10 @@ static inline size_t dax_recovery_write(struct dax_device *dax_dev,
 {
 	return 0;
 }
+static inline bool dax_is_supported(void)
+{
+	return false;
+}
 #endif
 
 void set_dax_nocache(struct dax_device *dax_dev);
-- 
2.39.2


