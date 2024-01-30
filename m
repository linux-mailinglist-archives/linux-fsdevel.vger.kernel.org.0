Return-Path: <linux-fsdevel+bounces-9553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2DE842A27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FC11C24EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40512DD97;
	Tue, 30 Jan 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BUhe710j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C48128393;
	Tue, 30 Jan 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633594; cv=none; b=glboj2+TrvpJdo741wecK22Az9w0VJWuKdFlUjEtixV6pdbtqyORxCaTBB0XuJMXnq8jg+9yRdJUGx+pnLGnUqonAo27i8ilQZgK1jdUKGAVJvg5SOwNvo4eYviEGAXOq3ETyVbV2VOHjPdajXTLkV3ORhD8hvxqCvP5bambfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633594; c=relaxed/simple;
	bh=39364yK8Vve2TZEwvAasv/nldxj5QFqZMMVmBMwwiu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgMtrCt5obc0ZOIQs8C7oxjW9UiorCnGDnYsCqlrczT8ugQIh9jzqtcI0olCsmRJrYcyt1trvMKTJFLVcgfM0UM2Tkz5HVNw5HQNlAZkscjQepJPuel9yjC1zgJIyt8/baT/YmOZO/l+ayHoCBxWs+KIj8kOdwnsUMzsvnKZus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BUhe710j; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706633585;
	bh=39364yK8Vve2TZEwvAasv/nldxj5QFqZMMVmBMwwiu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUhe710jU2/derdpsA0dmrgdapNQmX0LXTEssfQdWcX2L97NEiIfvqlxiNskzlCQ+
	 uFBF2yIOIW7lLhGlgmLYL2QC0ZeqL0RkTwoEYx20D9bs890S3wdBKzVJdaeYrnozqP
	 r4rIEq4WyYWNEKxGADF+jEmZYQH3YyuJEpH3/tIUj4UOrrV1coGgapkbjslqVS0p7F
	 g8VCDbYKUyXI00zoYgdo6nbeTVRFmEiOfxFc5YMj8+QBGAhQlPTdTKLswnRa7tKr2a
	 n8HrygNAcyh6r6ttOBpYmgmUin69L64Gw64u0Grq9Que0glHbaZLrtM5V+rY3Uav/H
	 Pv8DFsI0xlUoA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPWSd16qfzVlV;
	Tue, 30 Jan 2024 11:53:05 -0500 (EST)
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
Subject: [RFC PATCH v2 8/8] dax: Fix incorrect list of dcache aliasing architectures
Date: Tue, 30 Jan 2024 11:52:55 -0500
Message-Id: <20240130165255.212591-9-mathieu.desnoyers@efficios.com>
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

commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
prevents DAX from building on architectures with virtually aliased
dcache with:

  depends on !(ARM || MIPS || SPARC)

This check is too broad (e.g. recent ARMv7 don't have virtually aliased
dcaches), and also misses many other architectures with virtually
aliased dcache.

This is a regression introduced in the v5.13 Linux kernel where the
dax mount option is removed for 32-bit ARMv7 boards which have no dcache
aliasing, and therefore should work fine with FS_DAX.

This was turned into the following implementation of dax_is_supported()
by a preparatory change:

        return !IS_ENABLED(CONFIG_ARM) &&
               !IS_ENABLED(CONFIG_MIPS) &&
               !IS_ENABLED(CONFIG_SPARC);

Use dcache_is_aliasing() instead to figure out whether the environment
has aliasing dcaches.

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
 include/linux/dax.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index cfc8cd4a3eae..f59e604662e4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -5,6 +5,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/radix-tree.h>
+#include <linux/cacheinfo.h>
 
 typedef unsigned long dax_entry_t;
 
@@ -80,9 +81,7 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 }
 static inline bool dax_is_supported(void)
 {
-	return !IS_ENABLED(CONFIG_ARM) &&
-	       !IS_ENABLED(CONFIG_MIPS) &&
-	       !IS_ENABLED(CONFIG_SPARC);
+	return !dcache_is_aliasing();
 }
 #else
 static inline void *dax_holder(struct dax_device *dax_dev)
-- 
2.39.2


