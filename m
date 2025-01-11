Return-Path: <linux-fsdevel+bounces-38931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E709A0A185
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 08:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5524B3AACC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B703192B7F;
	Sat, 11 Jan 2025 07:12:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629E16DEB3;
	Sat, 11 Jan 2025 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579562; cv=none; b=cm5X/PtnLPxUeh70b5Y1CT4qbRviaq2Q5+oajHGntUti/aygSKQiPIsvtECLfDwtcC9Ch6DmwhZ1w8Wc2XLQfPH6g3ScB0SdUKG5aVl45gEyJX2DTqSAKrh1oammV8Lcg1GH94t+87JcbnQ0pBUax+Ia4LxbY8buIwRNJIQ+S+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579562; c=relaxed/simple;
	bh=J6d7z/kRT4HBLB6mnmq2N6zU3tbR25XClQO6XrEL+iU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVmyXEba4o0LBhRBFsZiyXaXCeKDzT9qUmNaBCTs1HhTl8XyDahVB8o7mNMx97uDFpFl37Db22Ej77v1ZGi5NMcTns1zRFCQcFkwVetJgEw3pkCEMoY1le6k1L0Zux9lFYQ780t9PiUF8iUNqBIssBW1t2tzggHTllmGFkqIzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YVV516XRFz2DhnV;
	Sat, 11 Jan 2025 15:09:25 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id E72E41A0188;
	Sat, 11 Jan 2025 15:12:30 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 11 Jan
 2025 15:12:27 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<joel.granados@kernel.org>
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
Subject: [PATCH v5 -next 04/16] mm: vmscan: move vmscan sysctls to mm/vmscan.c
Date: Sat, 11 Jan 2025 15:07:39 +0800
Message-ID: <20250111070751.2588654-5-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111070751.2588654-1-yukaixiong@huawei.com>
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100016.china.huawei.com (7.202.181.102)

This moves vm_swappiness and zone_reclaim_mode to mm/vmscan.c,
as part of the kernel/sysctl.c cleaning, also moves some external
variable declarations and function declarations from include/linux/swap.h
into mm/internal.h.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v4:
 - const qualify struct ctl_table vmscan_sysctl_table
v3:
 - change the title
---
---
 include/linux/swap.h |  9 ---------
 kernel/sysctl.c      | 19 -------------------
 mm/internal.h        | 10 ++++++++++
 mm/vmscan.c          | 23 +++++++++++++++++++++++
 4 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db3..a98c757400fe 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -433,19 +433,10 @@ extern int vm_swappiness;
 long remove_mapping(struct address_space *mapping, struct folio *folio);
 
 #ifdef CONFIG_NUMA
-extern int node_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
 extern int sysctl_min_slab_ratio;
-#else
-#define node_reclaim_mode 0
 #endif
 
-static inline bool node_reclaim_enabled(void)
-{
-	/* Is any node_reclaim_mode bit set? */
-	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
-}
-
 void check_move_unevictable_folios(struct folio_batch *fbatch);
 
 extern void __meminit kswapd_run(int nid);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ab5d94f07e53..cb6ca272fe9f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2051,15 +2051,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= dirtytime_interval_handler,
 		.extra1		= SYSCTL_ZERO,
 	},
-	{
-		.procname	= "swappiness",
-		.data		= &vm_swappiness,
-		.maxlen		= sizeof(vm_swappiness),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO_HUNDRED,
-	},
 	{
 		.procname	= "drop_caches",
 		.data		= &sysctl_drop_caches,
@@ -2107,16 +2098,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-#ifdef CONFIG_NUMA
-	{
-		.procname	= "zone_reclaim_mode",
-		.data		= &node_reclaim_mode,
-		.maxlen		= sizeof(node_reclaim_mode),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-#endif
 #ifdef CONFIG_MMU
 	{
 		.procname	= "mmap_min_addr",
diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11..cdbbe4c215c0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1097,9 +1097,13 @@ static inline void mminit_verify_zonelist(void)
 #define NODE_RECLAIM_SUCCESS	1
 
 #ifdef CONFIG_NUMA
+extern int node_reclaim_mode;
+
 extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
 extern int find_next_best_node(int node, nodemask_t *used_node_mask);
 #else
+#define node_reclaim_mode 0
+
 static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
 				unsigned int order)
 {
@@ -1111,6 +1115,12 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
 }
 #endif
 
+static inline bool node_reclaim_enabled(void)
+{
+	/* Is any node_reclaim_mode bit set? */
+	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
+}
+
 /*
  * mm/memory-failure.c
  */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6d06bb40d5ad..f1183519bf41 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7404,6 +7404,28 @@ void __meminit kswapd_stop(int nid)
 	pgdat_kswapd_unlock(pgdat);
 }
 
+static const struct ctl_table vmscan_sysctl_table[] = {
+	{
+		.procname	= "swappiness",
+		.data		= &vm_swappiness,
+		.maxlen		= sizeof(vm_swappiness),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO_HUNDRED,
+	},
+#ifdef CONFIG_NUMA
+	{
+		.procname	= "zone_reclaim_mode",
+		.data		= &node_reclaim_mode,
+		.maxlen		= sizeof(node_reclaim_mode),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	}
+#endif
+};
+
 static int __init kswapd_init(void)
 {
 	int nid;
@@ -7411,6 +7433,7 @@ static int __init kswapd_init(void)
 	swap_setup();
 	for_each_node_state(nid, N_MEMORY)
  		kswapd_run(nid);
+	register_sysctl_init("vm", vmscan_sysctl_table);
 	return 0;
 }
 
-- 
2.34.1


