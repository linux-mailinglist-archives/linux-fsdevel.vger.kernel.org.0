Return-Path: <linux-fsdevel+bounces-38182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FCC9FDB19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 16:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AC73A13EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7C9197558;
	Sat, 28 Dec 2024 15:01:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A91917F1;
	Sat, 28 Dec 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398117; cv=none; b=IOD6j+xOuhPun5Td1tkrDi+gR4UCjTTWa41r8MkwPMP3OkZiygG01GEY1CXY2kFqiFcu2RvGMmNbTjGGvcTNoREUCEhXnV1ziu5kxrizLR+ThbfZW2cbJdg5soRjyeNhO4Ixtci1pCAGOHyVOSEI8pVg7Ojz53tTJ5S85S+DsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398117; c=relaxed/simple;
	bh=bamcIdzVZRRdfLmC1Lu05/MmX20ZnHBl+HSAyfF2ZMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWqce/syqSAfjW9ql6l6kKuF9wN1Fddowd+r9p8jk03zPB7vjKCGL1Y9e1snfciImmPgWlUm4SKML3NgOwApZQThKstT0xLJVym9mIROMV578UbJ7C6z8JaB5zi8kj4cTWZQdhOipkLugogkChSjJVtRdqERyKw/D5krC/4Orus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YL59N0JR2z1T7Z7;
	Sat, 28 Dec 2024 22:59:04 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E452180042;
	Sat, 28 Dec 2024 23:01:52 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Dec
 2024 23:01:48 +0800
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
Date: Sat, 28 Dec 2024 22:57:34 +0800
Message-ID: <20241228145746.2783627-4-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228145746.2783627-1-yukaixiong@huawei.com>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


