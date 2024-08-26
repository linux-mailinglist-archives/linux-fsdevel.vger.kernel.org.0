Return-Path: <linux-fsdevel+bounces-27144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98695F067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79356B20CA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463E16F827;
	Mon, 26 Aug 2024 12:05:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661F155CAF;
	Mon, 26 Aug 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673936; cv=none; b=SmxFwfIedQQ/bd2+PaXRxqZGExLQH/av7DSz5lTBwJcFy4Xga6Mgb6OXzpLA1lQ9GLCr6w4c07TgD1RP/lcXnwBqzbmx2ExlHaGdvzDjec3RnC8a/c0+M0sqxwrnT2tpL8If0+0AWUghvXrzdTGxprLlk/X5yyuSUeIVh+LvIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673936; c=relaxed/simple;
	bh=9gsrQslfSULneXdTrycKoFQ3XcwiyR9LcCln0Nx75Uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1526pInEngeRdhkJcds9lFyV8+oCJSdgXFZc06bwQBc+kmijVKD8o+uiOkcvLNokSPbZNBEZrgSjC1aKVAko7aJxw5D5CWd7B7IdUO9WiB9l4PSGDRYBSu/8R1HZOxFe5cEQz3ZSb/aE9Quc8O1lbkMiCUJVfidgxeS9dA2tXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wsq9S4GSfz14G6b;
	Mon, 26 Aug 2024 20:04:44 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F1091800D0;
	Mon, 26 Aug 2024 20:05:30 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:27 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>
CC: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<kees@kernel.org>, <j.granados@samsung.com>, <willy@infradead.org>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <lorenzo.stoakes@oracle.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 04/15] mm: vmscan: move vmscan sysctls to its own file
Date: Mon, 26 Aug 2024 20:04:38 +0800
Message-ID: <20240826120449.1666461-5-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826120449.1666461-1-yukaixiong@huawei.com>
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100016.china.huawei.com (7.202.181.102)

This moves vm_swappiness and zone_reclaim_mode to its own file,
as part of the kernel/sysctl.c cleaning, also moves some external
variable declarations and function declarations from include/linux/swap.h
into mm/internal.h.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 include/linux/swap.h |  9 ---------
 kernel/sysctl.c      | 19 -------------------
 mm/internal.h        | 10 ++++++++++
 mm/vmscan.c          | 23 +++++++++++++++++++++++
 4 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 248db1dd7812..7e6287e64118 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -424,19 +424,10 @@ extern int vm_swappiness;
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
index e1e139e412d1..d396b201e636 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1031,9 +1031,13 @@ static inline void mminit_verify_zonelist(void)
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
@@ -1045,6 +1049,12 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
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
index 283e3f9d652b..38b58a40d25b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7365,6 +7365,28 @@ void __meminit kswapd_stop(int nid)
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
@@ -7372,6 +7394,7 @@ static int __init kswapd_init(void)
 	swap_setup();
 	for_each_node_state(nid, N_MEMORY)
  		kswapd_run(nid);
+	register_sysctl_init("vm", vmscan_sysctl_table);
 	return 0;
 }
 
-- 
2.25.1


