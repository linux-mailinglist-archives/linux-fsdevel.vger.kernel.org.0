Return-Path: <linux-fsdevel+bounces-38045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E69FAFDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3411887836
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCFD1DE889;
	Mon, 23 Dec 2024 14:20:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA421B3925;
	Mon, 23 Dec 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963641; cv=none; b=M48gQFZu/tPkidndXmCBp8xgxQnLm9J6fzHa1kYmXrpfrDog2WZ383g/aVDiBZS3WxTjjqJp0gNoorQw8vU9QJ7P/4AAXtjT8vNTZnjNV6SOk6pdVcOlkKubTZHiGAsmKnkMsAP/M1kN65J/oZRHWQCszTDFNiTstNHcKM/fpFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963641; c=relaxed/simple;
	bh=bamcIdzVZRRdfLmC1Lu05/MmX20ZnHBl+HSAyfF2ZMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWrueTXWtHSbo9rcE7ZHjsHsJ3TmHS9OOTzNRtD3yzFmKW6IvXhdeY0a0aWuXl21CeG5w3ygnxTjELsqlkcpesnVEm9TNJwTg5ZPA6SeAo0840uOxQHZm2HQGg6tb8NwDUNIfvEL7+JB6OXzOoVxjRh1bMuEW75oR+pzp4yhDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YH0Xn1FS9z1JG5j;
	Mon, 23 Dec 2024 22:20:09 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FF2E140202;
	Mon, 23 Dec 2024 22:20:37 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Dec
 2024 22:20:32 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>
CC: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v4 -next 03/15] mm: swap: move sysctl to mm/swap.c
Date: Mon, 23 Dec 2024 22:15:38 +0800
Message-ID: <20241223141550.638616-20-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223141550.638616-1-yukaixiong@huawei.com>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100016.china.huawei.com (7.202.181.102)

The page-cluster belongs to mm/swap.c, move it to mm/swap.c .
Removes the redundant external variable declaration and unneeded
include(linux/swap.h).

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v4:
 - const qualify struct ctl_table swap_sysctl_table
v3:
 - change the title
---
---
 include/linux/mm.h |  2 --
 kernel/sysctl.c    | 10 ----------
 mm/swap.c          | 16 +++++++++++++++-
 mm/swap.h          |  1 +
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dbdf8950d681..8941ba3d9a77 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -76,8 +76,6 @@ static inline void totalram_pages_add(long count)
 }
 
 extern void * high_memory;
-extern int page_cluster;
-extern const int page_cluster_max;
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_legacy_va_layout;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 23c8db80da5d..ab5d94f07e53 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -21,7 +21,6 @@
 
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
@@ -2044,15 +2043,6 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= overcommit_kbytes_handler,
 	},
-	{
-		.procname	= "page-cluster",
-		.data		= &page_cluster,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&page_cluster_max,
-	},
 	{
 		.procname	= "dirtytime_expire_seconds",
 		.data		= &dirtytime_expire_interval,
diff --git a/mm/swap.c b/mm/swap.c
index 062c8565b899..d3344123381c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -45,7 +45,7 @@
 
 /* How many pages do we try to swap or page in/out together? As a power of 2 */
 int page_cluster;
-const int page_cluster_max = 31;
+static const int page_cluster_max = 31;
 
 struct cpu_fbatches {
 	/*
@@ -1072,6 +1072,18 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
 	fbatch->nr = j;
 }
 
+static const struct ctl_table swap_sysctl_table[] = {
+	{
+		.procname	= "page-cluster",
+		.data		= &page_cluster,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void *)&page_cluster_max,
+	}
+};
+
 /*
  * Perform any setup for the swap system
  */
@@ -1088,4 +1100,6 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	register_sysctl_init("vm", swap_sysctl_table);
 }
diff --git a/mm/swap.h b/mm/swap.h
index ad2f121de970..274dcc6219a0 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -3,6 +3,7 @@
 #define _MM_SWAP_H
 
 struct mempolicy;
+extern int page_cluster;
 
 #ifdef CONFIG_SWAP
 #include <linux/swapops.h> /* for swp_offset */
-- 
2.34.1


