Return-Path: <linux-fsdevel+bounces-27159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6286095F0CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151232878D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6E197A95;
	Mon, 26 Aug 2024 12:06:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C6197531;
	Mon, 26 Aug 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673970; cv=none; b=Chmw6pdObgsTwqueqwazjVUL8b0d7nNaHQHF78Rmr7kDxPkfQUYIzTrTB/ONnnSchVSNuXDnfSfaz6X3xpFmk90moWa45gK0RgK9Ujp3msQf1fKxjdBxuoUwzKNefIRggLik6wwmIbfKeIzCYjA6mnmL/yplFifxlqyCDg+e9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673970; c=relaxed/simple;
	bh=KldVUeX39PpggDsu+Wf1GFrDnDnFH5AuvGTmfuGY5h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRaaTm13f974bv14TD0z73nvGTK34kQ9Q0PsPKNStUFC8OQ+VBgzwJENNDB1U8q4uzs8aHnaunquE6PCALTACDV03zIGPWLG62I1lszo7D7pdQyVpgqAJt/CJS6YqDAZrhmrGx7kvizqPs3PduW6uC03NKJICIlzrH2k9YNmfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wsq9r2SqhzyRCP;
	Mon, 26 Aug 2024 20:05:04 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E5691800D0;
	Mon, 26 Aug 2024 20:05:32 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:30 +0800
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
Subject: [PATCH -next 05/15] mm: util: move sysctls into it own files
Date: Mon, 26 Aug 2024 20:04:39 +0800
Message-ID: <20240826120449.1666461-6-yukaixiong@huawei.com>
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

This moves all util related sysctls to its own file, as part of the
kernel/sysctl.c cleaning, also removes redundant external
variable declarations and function declarations.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 include/linux/mm.h   | 11 --------
 include/linux/mman.h |  2 --
 kernel/sysctl.c      | 37 ------------------------
 mm/util.c            | 67 ++++++++++++++++++++++++++++++++++++++------
 4 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ae41092f4328..a04543984a46 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -200,17 +200,6 @@ extern int sysctl_max_map_count;
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
index bcb201ab7a41..e62ef272d140 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -58,8 +58,6 @@
 		| MAP_HUGE_1GB)
 
 extern int sysctl_overcommit_memory;
-extern int sysctl_overcommit_ratio;
-extern unsigned long sysctl_overcommit_kbytes;
 extern struct percpu_counter vm_committed_as;
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 184d39944e16..ad3ac6f6c808 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2030,29 +2030,6 @@ static struct ctl_table kern_table[] = {
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
@@ -2133,20 +2110,6 @@ static struct ctl_table vm_table[] = {
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
index 2bfae12ade7e..04a677f04ca9 100644
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
@@ -903,14 +904,16 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
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
 
@@ -925,8 +928,8 @@ static void sync_overcommit_as(struct work_struct *dummy)
 	percpu_counter_sync(&vm_committed_as);
 }
 
-int overcommit_policy_handler(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int overcommit_policy_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int new_policy = -1;
@@ -961,8 +964,8 @@ int overcommit_policy_handler(const struct ctl_table *table, int write, void *bu
 	return ret;
 }
 
-int overcommit_kbytes_handler(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int overcommit_kbytes_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -972,6 +975,54 @@ int overcommit_kbytes_handler(const struct ctl_table *table, int write, void *bu
 	return ret;
 }
 
+static struct ctl_table util_sysctl_table[] = {
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
2.25.1


