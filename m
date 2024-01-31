Return-Path: <linux-fsdevel+bounces-9674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934F844420
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35086290430
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A7C12CD8A;
	Wed, 31 Jan 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HA2Zt+xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E312BE9D;
	Wed, 31 Jan 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718352; cv=none; b=V0C4vzYYDvTcysYeIH+t4j+GElvPSilRboIKrlapuMkcOKdOFa2eWxBt1RgsIj1cnLKS1F9DgtWrmTCwhnvePz2mtnGsvkj8Z1JIlYGjC/unPKicKeseS63u9DDaKjjePkInN36UMsfhPt2b28TH12itQtzRcur5ug4XPCcBsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718352; c=relaxed/simple;
	bh=eX0TXo9pcQzgnT4JpiJ1uz+KvY1x3UAQjUEMAJVLHgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7wK+DcVP7CkWGWEBI3hBtwHsbaYLW/8n/E8wsVehJ3B0czv+slQ+9N8/SUE5sVRiBD0Lsj6Mq0P+dmAwSPcDrNS/DlwxnNbDOAK5I6PiZmdS95P/lmnDDsa0CKqmvJrHSXrxseRDdzMGH8F/FOUUPQpuJOxgEhQ9T/r+DotJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HA2Zt+xx; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706718349;
	bh=eX0TXo9pcQzgnT4JpiJ1uz+KvY1x3UAQjUEMAJVLHgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HA2Zt+xxhsvOb4O2UchDtcajfJ8ji+gNYMyIjAGZ5EQWJYleafh08/eminp77aE82
	 yajKp/NCmwT9QgTnvK/lTjgc7JIeNPSy8OUEcPFCHvxToJXJOl1x+D89IDEw3SnePY
	 HGYVNr8qWrGj0nxbnfdG/h4ky03ZNKXxoNWxV0+YPw/t1zr8gq/bQQlqqJb50gIUWj
	 lAj2UWcRkVhbWaTg+78o35p3+S3Ghr9Cg2Ii6UU64XHEvV7/avptbzfMDDiPYGDOD+
	 vFw7mg9tqqdM9u0smvoSSRwh4/CSG1XgucTAvwWj3hKokxfqG7+Q+wSjDRNZ6qGj4w
	 HNu4r51PyvvHw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQ6pj2GjXzVp1;
	Wed, 31 Jan 2024 11:25:49 -0500 (EST)
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
Subject: [RFC PATCH v3 4/4] dax: Fix incorrect list of data cache aliasing architectures
Date: Wed, 31 Jan 2024 11:25:33 -0500
Message-Id: <20240131162533.247710-5-mathieu.desnoyers@efficios.com>
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

commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
prevents DAX from building on architectures with virtually aliased
dcache with:

  depends on !(ARM || MIPS || SPARC)

This check is too broad (e.g. recent ARMv7 don't have virtually aliased
dcaches), and also misses many other architectures with virtually
aliased data cache.

This is a regression introduced in the v5.13 Linux kernel where the
dax mount option is removed for 32-bit ARMv7 boards which have no data
cache aliasing, and therefore should work fine with FS_DAX.

This was turned into the following check in alloc_dax() by a preparatory
change:

        if (IS_ENABLED(CONFIG_ARM) ||
            IS_ENABLED(CONFIG_MIPS) ||
            IS_ENABLED(CONFIG_SPARC))
                return NULL;

Use cpu_dcache_is_aliasing() instead to figure out whether the environment
has aliasing data caches.

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
 drivers/dax/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e9f397b8a5a3..8c3a6e8e6334 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -13,6 +13,7 @@
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
+#include <linux/cacheinfo.h>
 #include "dax-private.h"
 
 /**
@@ -446,9 +447,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 	int minor;
 
 	/* Unavailable on architectures with virtually aliased data caches. */
-	if (IS_ENABLED(CONFIG_ARM) ||
-	    IS_ENABLED(CONFIG_MIPS) ||
-	    IS_ENABLED(CONFIG_SPARC))
+	if (cpu_dcache_is_aliasing())
 		return NULL;
 
 	if (WARN_ON_ONCE(ops && !ops->zero_page_range))
-- 
2.39.2


