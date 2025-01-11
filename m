Return-Path: <linux-fsdevel+bounces-38932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7CA0A18C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 08:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDFB188EA7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 07:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48405196DB1;
	Sat, 11 Jan 2025 07:12:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6C194C67;
	Sat, 11 Jan 2025 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579566; cv=none; b=s55i7Cb9RUf6CSyPnpis27sVDxOBZdcpVRy9pr/8sb5Ga5Igs0BC9p9bQymCpSUNslofNSDOFbNXI5EPUfBAkvkj6neBoFesQlcUrpc5+YKqpVoUTf7EuK2iwdyephZrfQfVrxhWVLbx8Tub2TxIOHZDCeIXyXRxzTwPz5TfAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579566; c=relaxed/simple;
	bh=hEx/1yx+9NIxuaP0d8CpdXkeA6H1Cn+tvPipkT0qCG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amwR7R7eO1OgJ5R+ZBjUz1YIHiW16LmPu4n4euAhgAHH1SlNqwK2RqGsEUF4XE6/aCvLnWye7ydv2KwoDr/3e4krLbuPl8fnhRg49IFId0uFBlGryzV/opO7ARHmpXt/YGVf2rxul+mSdH9pdLMRPrjO+9F4X6u1yY75dwkujvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YVV5G4mbpz11RmN;
	Sat, 11 Jan 2025 15:09:38 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 892DD180064;
	Sat, 11 Jan 2025 15:12:36 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 11 Jan
 2025 15:12:30 +0800
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
Subject: [PATCH v5 -next 05/16] mm: util: move sysctls to mm/util.c
Date: Sat, 11 Jan 2025 15:07:40 +0800
Message-ID: <20250111070751.2588654-6-yukaixiong@huawei.com>
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

This moves all util related sysctls to mm/util.c, as part of the
kernel/sysctl.c cleaning, also removes redundant external
variable declarations and function declarations.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v4:
 - const qualify struct ctl_table util_sysctl_table
v3:
 - change the title
---
---
 include/linux/mm.h   | 11 --------
 include/linux/mman.h |  2 --
 kernel/sysctl.c      | 37 ------------------------
 mm/util.c            | 67 ++++++++++++++++++++++++++++++++++++++------
 4 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb00ee129f77..5776bc524087 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -206,17 +206,6 @@ extern int sysctl_max_map_count;
 extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;
 
-extern int sysctl_overcommit_memory;
-extern int sysctl_overcommit_ratio;
-extern unsigned long sysctl_overcommit_kbytes;
-
-int overcommit_ratio_handler(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int overcommit_kbytes_handler(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int overcommit_policy_handler(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 #define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
diff --git a/include/linux/mman.h b/include/linux/mman.h
index a842783ffa62..bce214fece16 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -59,8 +59,6 @@
 		| MAP_HUGE_1GB)
 
 extern int sysctl_overcommit_memory;
-extern int sysctl_overcommit_ratio;
-extern unsigned long sysctl_overcommit_kbytes;
 extern struct percpu_counter vm_committed_as;
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb6ca272fe9f..aea3482106e0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2020,29 +2020,6 @@ static struct ctl_table kern_table[] = {
 };
 
 static struct ctl_table vm_table[] = {
-	{
-		.procname	= "overcommit_memory",
-		.data		= &sysctl_overcommit_memory,
-		.maxlen		= sizeof(sysctl_overcommit_memory),
-		.mode		= 0644,
-		.proc_handler	= overcommit_policy_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "overcommit_ratio",
-		.data		= &sysctl_overcommit_ratio,
-		.maxlen		= sizeof(sysctl_overcommit_ratio),
-		.mode		= 0644,
-		.proc_handler	= overcommit_ratio_handler,
-	},
-	{
-		.procname	= "overcommit_kbytes",
-		.data		= &sysctl_overcommit_kbytes,
-		.maxlen		= sizeof(sysctl_overcommit_kbytes),
-		.mode		= 0644,
-		.proc_handler	= overcommit_kbytes_handler,
-	},
 	{
 		.procname	= "dirtytime_expire_seconds",
 		.data		= &dirtytime_expire_interval,
@@ -2123,20 +2100,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-	{
-		.procname	= "user_reserve_kbytes",
-		.data		= &sysctl_user_reserve_kbytes,
-		.maxlen		= sizeof(sysctl_user_reserve_kbytes),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "admin_reserve_kbytes",
-		.data		= &sysctl_admin_reserve_kbytes,
-		.maxlen		= sizeof(sysctl_admin_reserve_kbytes),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
 	{
 		.procname	= "mmap_rnd_bits",
diff --git a/mm/util.c b/mm/util.c
index b6b9684a1438..b3480f358d11 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/sysctl.h>
 #include <linux/mman.h>
 #include <linux/hugetlb.h>
 #include <linux/vmalloc.h>
@@ -906,14 +907,16 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 EXPORT_SYMBOL(folio_mc_copy);
 
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
-int sysctl_overcommit_ratio __read_mostly = 50;
-unsigned long sysctl_overcommit_kbytes __read_mostly;
+static int sysctl_overcommit_ratio __read_mostly = 50;
+static unsigned long sysctl_overcommit_kbytes __read_mostly;
 int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
-int overcommit_ratio_handler(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+#ifdef CONFIG_SYSCTL
+
+static int overcommit_ratio_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -928,8 +931,8 @@ static void sync_overcommit_as(struct work_struct *dummy)
 	percpu_counter_sync(&vm_committed_as);
 }
 
-int overcommit_policy_handler(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int overcommit_policy_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int new_policy = -1;
@@ -964,8 +967,8 @@ int overcommit_policy_handler(const struct ctl_table *table, int write, void *bu
 	return ret;
 }
 
-int overcommit_kbytes_handler(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int overcommit_kbytes_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -975,6 +978,54 @@ int overcommit_kbytes_handler(const struct ctl_table *table, int write, void *bu
 	return ret;
 }
 
+static const struct ctl_table util_sysctl_table[] = {
+	{
+		.procname	= "overcommit_memory",
+		.data		= &sysctl_overcommit_memory,
+		.maxlen		= sizeof(sysctl_overcommit_memory),
+		.mode		= 0644,
+		.proc_handler	= overcommit_policy_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{
+		.procname	= "overcommit_ratio",
+		.data		= &sysctl_overcommit_ratio,
+		.maxlen		= sizeof(sysctl_overcommit_ratio),
+		.mode		= 0644,
+		.proc_handler	= overcommit_ratio_handler,
+	},
+	{
+		.procname	= "overcommit_kbytes",
+		.data		= &sysctl_overcommit_kbytes,
+		.maxlen		= sizeof(sysctl_overcommit_kbytes),
+		.mode		= 0644,
+		.proc_handler	= overcommit_kbytes_handler,
+	},
+	{
+		.procname	= "user_reserve_kbytes",
+		.data		= &sysctl_user_reserve_kbytes,
+		.maxlen		= sizeof(sysctl_user_reserve_kbytes),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{
+		.procname	= "admin_reserve_kbytes",
+		.data		= &sysctl_admin_reserve_kbytes,
+		.maxlen		= sizeof(sysctl_admin_reserve_kbytes),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+};
+
+static int __init init_vm_util_sysctls(void)
+{
+	register_sysctl_init("vm", util_sysctl_table);
+	return 0;
+}
+subsys_initcall(init_vm_util_sysctls);
+#endif /* CONFIG_SYSCTL */
+
 /*
  * Committed memory limit enforced when OVERCOMMIT_NEVER policy is used
  */
-- 
2.34.1


