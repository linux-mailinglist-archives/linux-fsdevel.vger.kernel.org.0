Return-Path: <linux-fsdevel+bounces-9675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F13844423
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E221C2539E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873912BEAC;
	Wed, 31 Jan 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tPFOoGUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3012BE8F;
	Wed, 31 Jan 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718353; cv=none; b=POAj/54xoax5vn2noySHee6yTnX8jrZGXC6kE/NQNacff6SO/RfR7mwreDl+OQdmipANi7BiPj1y7P2jnYnssdj1M8zdmT15EOYMFTztUDCrosN3XRbJS/ND51r7OEH6QMuDkx5igTfgyj+cVRUhW6nYYeDHT0Kc2z0cGlMil68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718353; c=relaxed/simple;
	bh=QiUQHVE9OuD7A7XRfq4nHC+crkQnZ8+IZ0u7lnayc8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QaeRJdyEg3QatJIHmAPF15Yva1YVB6zXFmYZhM1wTKn60uTJ8B39Eb05Mp17z+RWUgny298zd+nuG89EOlkdfKTAwznvtac18b3dfAAcEEVRnOw7ENFwEwdzvMwkqgP2XF0gVmZq78daz6+yGz2es30YtGgJqtVOoEZ3bKis+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tPFOoGUC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706718348;
	bh=QiUQHVE9OuD7A7XRfq4nHC+crkQnZ8+IZ0u7lnayc8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPFOoGUCQpG6nbDTeV4EO+3l6CQr96GDzwrgBAkFN3BBXvvuVDa7KEgUQVhRO+9UJ
	 OGBfhp6+IHWdIbnDgzb7rp6f5NoCAVT/MC/jdSqh/SbWXQai0GciSCZ5jGzJAZJFn9
	 zdbBdntL/XW+dTsVqtKTP0pFMFrIkzMRY2EjvD3nxnNlRo8+GV97CGNQTyzuR04/Bv
	 DnVLu22IZhi/FCEikncgvc+r9uRAQtDTq6OOUCYLLFl+SPLOZdSfK/om2/oxbsUHtn
	 heRyE9JrDmR4Al+5f3ZW4R/iVTnsP1/2fKc1z18/UCX+ap0fXxxnWGMUegUer3Cath
	 BZBJCCPLX8AoA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQ6ph3nMyzVny;
	Wed, 31 Jan 2024 11:25:48 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
Date: Wed, 31 Jan 2024 11:25:31 -0500
Message-Id: <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the following fs/Kconfig:FS_DAX dependency:

  depends on !(ARM || MIPS || SPARC)

By a runtime check within alloc_dax().

This is done in preparation for its use by each filesystem supporting
the "dax" mount option to validate whether DAX is indeed supported.

This is done in preparation for using cpu_dcache_is_aliasing() in a
following change which will properly support architectures which detect
data cache aliasing at runtime.

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
Cc: dm-devel@lists.linux.dev
---
 drivers/dax/super.c | 6 ++++++
 fs/Kconfig          | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0da9232ea175..e9f397b8a5a3 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -445,6 +445,12 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 	dev_t devt;
 	int minor;
 
+	/* Unavailable on architectures with virtually aliased data caches. */
+	if (IS_ENABLED(CONFIG_ARM) ||
+	    IS_ENABLED(CONFIG_MIPS) ||
+	    IS_ENABLED(CONFIG_SPARC))
+		return NULL;
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
-- 
2.39.2


