Return-Path: <linux-fsdevel+bounces-31579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74FF998912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D69B2800C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E911CDA05;
	Thu, 10 Oct 2024 14:11:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979A1CCEE2;
	Thu, 10 Oct 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569509; cv=none; b=RbL5b3huaKKhyhOpLBGCpzuJ2phRaMAWJTXfHdU46V5pihKnhIgxtlkEBnIkUyN5OKJDdSOjLV5g427KaDqDX1nDcRRB9DFo7/d24+3R+zpcRddsp5K3AWhwfyBWd5v4y/a8pdCZ9BiSDYOl1J0faL/3K4MJQpEZc71zR9Zv/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569509; c=relaxed/simple;
	bh=naPOESKaE5CdzE8pdiFCJO/doUvAnVUTkP9QEjwlvNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMEf1iXj3TZrOeKCQsbGyd4gt4xtzKm0nEV4D5abWdZTFUSJedNQnq00bi7wrWXc8tsEJSJ7KBFwbZwaoo065f7RVT2/4FYNkHp5UTiPnSx+h7PvYTHqmgvXPkRwhhm8VzCTg/+aLT8v4WPvAMAlNfddN4FXa/qN8SPL3PIS+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPWmS55yMz1HKl3;
	Thu, 10 Oct 2024 22:07:36 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id A35011400DC;
	Thu, 10 Oct 2024 22:11:43 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Oct
 2024 22:11:40 +0800
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
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH v3 -next 04/15] mm: vmscan: move vmscan sysctls to mm/vmscan.c
Date: Thu, 10 Oct 2024 23:22:04 +0800
Message-ID: <20241010152215.3025842-5-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010152215.3025842-1-yukaixiong@huawei.com>
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
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
v3:
 - change the title
---
 include/linux/swap.h |  9 ---------
 kernel/sysctl.c      | 19 -------------------
 mm/internal.h        | 10 ++++++++++
 mm/vmscan.c          | 23 +++++++++++++++++++++++
 4 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ca533b478c21..c95fb8d87b05 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -425,19 +425,10 @@ extern int vm_swappiness;
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
index 9fad501311a1..184d39944e16 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2061,15 +2061,6 @@ static struct ctl_table vm_table[] = {
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
@@ -2117,16 +2108,6 @@ static struct ctl_table vm_table[] = {
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
index 906da6280c2d..84c46fe6a07c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1038,9 +1038,13 @@ static inline void mminit_verify_zonelist(void)
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
@@ -1052,6 +1056,12 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
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
index f9919b522c01..1188978e46d5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7384,6 +7384,28 @@ void __meminit kswapd_stop(int nid)
 	pgdat_kswapd_unlock(pgdat);
 }
 
+static struct ctl_table vmscan_sysctl_table[] = {
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
@@ -7391,6 +7413,7 @@ static int __init kswapd_init(void)
 	swap_setup();
 	for_each_node_state(nid, N_MEMORY)
  		kswapd_run(nid);
+	register_sysctl_init("vm", vmscan_sysctl_table);
 	return 0;
 }
 
-- 
2.34.1


