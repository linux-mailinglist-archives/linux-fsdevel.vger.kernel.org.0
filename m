Return-Path: <linux-fsdevel+bounces-10101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28634847B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B27E1C21FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393E133284;
	Fri,  2 Feb 2024 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MHwLCxMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2812F366;
	Fri,  2 Feb 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907634; cv=none; b=sr56j8D5+5vtGyqJ+4vRF7dKsHqRR4I0OjicZk/OIaLjvzoGEPFBCCQAxBQgAp0JcaqFHkcCtRFTXjXDyUKbgBEYGYLoUtprae1zcaPJ/sSv9409fDJYy987cbsYjP87qTt3c2T8p740+C54r1yzdDRDdpZchcmeMZ2nRUg6fR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907634; c=relaxed/simple;
	bh=hDhYMA3F+4l5mMIlcEOrH62nfylV2E9jEwkIfVNtigI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWicAoMIsgJpELU4FZGn6xkDr/iAYUMmSHHqfDcVlUvgwD2H4hBT3Klz2OvfW6Ks23fXev9M2ZHqG3onn2PQapKAJpxRs1O3Rs2JpLezQI/MaNX3uzyTWe+ERA/BlPqe8AH2R/YOR3FaA58XxRdH9lcEJBz5rGrsz4sXuwMxg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=MHwLCxMM; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706907629;
	bh=hDhYMA3F+4l5mMIlcEOrH62nfylV2E9jEwkIfVNtigI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHwLCxMMJ8oX6+bHEOyVn0lkZWWp3rdA/3Ni7ikq4m3u/+zRvC1YBE6wqxLL7ME+n
	 bgtUOSoSwrkc53a8AMpqI8r1roW5ed7yLgGbUksKRENhkgdc0fwks9v/6nR8TTMRY6
	 +0nAINngg+wnnGf/N2eZwv+LGmczJE5nl1OEURUOSjYrBV3Ql9BFVUT9r7x6rBUKiR
	 OS4hhk0KIM4MvPNbRVvDfCHuI/kNx4MaTpchFxgSzS7luhDBCjsF2qKuj4PU9PWXMv
	 olV2aSH37fJ9i07BukbKYDwL9bHUbH1JJggkbDvLLLQ04RCIH7ZHMou+lQfNNPnT6u
	 8aHu31qfGDDKg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRSpj1nT8zXBx;
	Fri,  2 Feb 2024 16:00:29 -0500 (EST)
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
Subject: [RFC PATCH v4 06/12] dax: Check for data cache aliasing at runtime
Date: Fri,  2 Feb 2024 16:00:13 -0500
Message-Id: <20240202210019.88022-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
References: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the following fs/Kconfig:FS_DAX dependency:

  depends on !(ARM || MIPS || SPARC)

By a runtime check within alloc_dax(). This runtime check returns
ERR_PTR(-EOPNOTSUPP) if the @ops parameter is non-NULL (which means
the kernel is using an aliased mapping) on an architecture which
has data cache aliasing.

Change the return value from NULL to PTR_ERR(-EOPNOTSUPP) for
CONFIG_DAX=n for consistency.

This is done in preparation for using cpu_dcache_is_aliasing() in a
following change which will properly support architectures which detect
data cache aliasing at runtime.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 drivers/dax/super.c | 15 +++++++++++++++
 fs/Kconfig          |  1 -
 include/linux/dax.h |  6 +-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0da9232ea175..ce5bffa86bba 100644
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
@@ -445,6 +450,16 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 	dev_t devt;
 	int minor;
 
+	/*
+	 * Unavailable on architectures with virtually aliased data caches,
+	 * except for device-dax (NULL operations pointer), which does
+	 * not use aliased mappings from the kernel.
+	 */
+	if (ops && (IS_ENABLED(CONFIG_ARM) ||
+	    IS_ENABLED(CONFIG_MIPS) ||
+	    IS_ENABLED(CONFIG_SPARC)))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (WARN_ON_ONCE(ops && !ops->zero_page_range))
 		return ERR_PTR(-EINVAL);
 
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


