Return-Path: <linux-fsdevel+bounces-27145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A5D95F06F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F7028305F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A0C17ADF4;
	Mon, 26 Aug 2024 12:05:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9149171E76;
	Mon, 26 Aug 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673940; cv=none; b=R53BL8moHkqVGXC5YGfjE+QzZQvaP4dWp9uQMYdSupliyCxOmNiQMS/Yyfw9AiIycgABnGKCSAxGhaKVabH/dTqU9uf6y9RBwKunnUz1ONUuJ9z53EWMeZ8O86NO1yPbTx0F4Pljci8+DVO4Wt+eg/AYQclr5mYcSZYDN/+hE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673940; c=relaxed/simple;
	bh=iC+NEcThU7d/U6VYyZvq1sKDNfpWMYDZgg/hLa8DA+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFcHIkfpON3VQPpi4niyRcvntK/vhmq5T1OezNaTMnHszb1J/2wn3aS8ydi9Td5KHaXTYcKxAnZHjzfCMcxRsx+4f8BMpwxZs3OAcMXXvcHFTL4cEfn8IogDpaEe8yKqh4nOL2iOIzi870iktj2Q/EzfiEp7TLY2z765p9ExlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wsq4v1T1SzQqgW;
	Mon, 26 Aug 2024 20:00:47 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id C95D01800A5;
	Mon, 26 Aug 2024 20:05:34 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:32 +0800
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
Subject: [PATCH -next 06/15] mm: mmap: move sysctl into its own file
Date: Mon, 26 Aug 2024 20:04:40 +0800
Message-ID: <20240826120449.1666461-7-yukaixiong@huawei.com>
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

This moves all mmap related sysctls to its own file, as part of the
kernel/sysctl.c cleaning, also move the variable declaration from
kernel/sysctl.c into mm/mmap.c. Besides, move MAPCOUNT_ELF_CORE_MARGIN
and DEFAULT_MAX_MAP_COUNT into mmap.c from mm.h.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 include/linux/mm.h | 19 ------------
 kernel/sysctl.c    | 50 +------------------------------
 mm/mmap.c          | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/util.c          |  1 -
 4 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a04543984a46..9400c92b4522 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -176,25 +176,6 @@ static inline void __mm_zero_struct_page(struct page *page)
 #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
 #endif
 
-/*
- * Default maximum number of active map areas, this limits the number of vmas
- * per mm struct. Users can overwrite this number by sysctl but there is a
- * problem.
- *
- * When a program's coredump is generated as ELF format, a section is created
- * per a vma. In ELF, the number of sections is represented in unsigned short.
- * This means the number of sections should be smaller than 65535 at coredump.
- * Because the kernel adds some informative sections to a image of program at
- * generating coredump, we need some margin. The number of extra sections is
- * 1-3 now and depends on arch. We use "5" as safe margin, here.
- *
- * ELF extended numbering allows more than 65535 sections, so 16-bit bound is
- * not a hard limit any more. Although some userspace tools can be surprised by
- * that.
- */
-#define MAPCOUNT_ELF_CORE_MARGIN	(5)
-#define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
-
 extern int sysctl_max_map_count;
 
 extern unsigned long sysctl_user_reserve_kbytes;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad3ac6f6c808..41d4afc978e6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -127,12 +127,6 @@ enum sysctl_writes_mode {
 
 static enum sysctl_writes_mode sysctl_writes_strict = SYSCTL_WRITES_STRICT;
 #endif /* CONFIG_PROC_SYSCTL */
-
-#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
-    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
-int sysctl_legacy_va_layout;
-#endif
-
 #endif /* CONFIG_SYSCTL */
 
 /*
@@ -2047,16 +2041,7 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_FOUR,
 	},
-#ifdef CONFIG_MMU
-	{
-		.procname	= "max_map_count",
-		.data		= &sysctl_max_map_count,
-		.maxlen		= sizeof(sysctl_max_map_count),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-#else
+#ifndef CONFIG_MMU
 	{
 		.procname	= "nr_trim_pages",
 		.data		= &sysctl_nr_trim_pages,
@@ -2074,17 +2059,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
-#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
-    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
-	{
-		.procname	= "legacy_va_layout",
-		.data		= &sysctl_legacy_va_layout,
-		.maxlen		= sizeof(sysctl_legacy_va_layout),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-#endif
 #ifdef CONFIG_MMU
 	{
 		.procname	= "mmap_min_addr",
@@ -2110,28 +2084,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
-	{
-		.procname	= "mmap_rnd_bits",
-		.data		= &mmap_rnd_bits,
-		.maxlen		= sizeof(mmap_rnd_bits),
-		.mode		= 0600,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&mmap_rnd_bits_min,
-		.extra2		= (void *)&mmap_rnd_bits_max,
-	},
-#endif
-#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
-	{
-		.procname	= "mmap_rnd_compat_bits",
-		.data		= &mmap_rnd_compat_bits,
-		.maxlen		= sizeof(mmap_rnd_compat_bits),
-		.mode		= 0600,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&mmap_rnd_compat_bits_min,
-		.extra2		= (void *)&mmap_rnd_compat_bits_max,
-	},
-#endif
 };
 
 int __init sysctl_init_bases(void)
diff --git a/mm/mmap.c b/mm/mmap.c
index 88524a3768f6..2b37d8fb997f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -62,6 +62,27 @@
 #define arch_mmap_check(addr, len, flags)	(0)
 #endif
 
+/*
+ * Default maximum number of active map areas, this limits the number of vmas
+ * per mm struct. Users can overwrite this number by sysctl but there is a
+ * problem.
+ *
+ * When a program's coredump is generated as ELF format, a section is created
+ * per a vma. In ELF, the number of sections is represented in unsigned short.
+ * This means the number of sections should be smaller than 65535 at coredump.
+ * Because the kernel adds some informative sections to a image of program at
+ * generating coredump, we need some margin. The number of extra sections is
+ * 1-3 now and depends on arch. We use "5" as safe margin, here.
+ *
+ * ELF extended numbering allows more than 65535 sections, so 16-bit bound is
+ * not a hard limit any more. Although some userspace tools can be surprised by
+ * that.
+ */
+#define MAPCOUNT_ELF_CORE_MARGIN	(5)
+#define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
+
+int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
+
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
 const int mmap_rnd_bits_min = CONFIG_ARCH_MMAP_RND_BITS_MIN;
 int mmap_rnd_bits_max __ro_after_init = CONFIG_ARCH_MMAP_RND_BITS_MAX;
@@ -2171,6 +2192,57 @@ struct vm_area_struct *_install_special_mapping(
 					&special_mapping_vmops);
 }
 
+#ifdef CONFIG_SYSCTL
+#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
+		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
+int sysctl_legacy_va_layout;
+#endif
+
+static struct ctl_table mmap_table[] = {
+		{
+				.procname       = "max_map_count",
+				.data           = &sysctl_max_map_count,
+				.maxlen         = sizeof(sysctl_max_map_count),
+				.mode           = 0644,
+				.proc_handler   = proc_dointvec_minmax,
+				.extra1         = SYSCTL_ZERO,
+		},
+#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
+		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
+		{
+				.procname       = "legacy_va_layout",
+				.data           = &sysctl_legacy_va_layout,
+				.maxlen         = sizeof(sysctl_legacy_va_layout),
+				.mode           = 0644,
+				.proc_handler   = proc_dointvec_minmax,
+				.extra1         = SYSCTL_ZERO,
+		},
+#endif
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
+		{
+				.procname       = "mmap_rnd_bits",
+				.data           = &mmap_rnd_bits,
+				.maxlen         = sizeof(mmap_rnd_bits),
+				.mode           = 0600,
+				.proc_handler   = proc_dointvec_minmax,
+				.extra1         = (void *)&mmap_rnd_bits_min,
+				.extra2         = (void *)&mmap_rnd_bits_max,
+		},
+#endif
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
+		{
+				.procname       = "mmap_rnd_compat_bits",
+				.data           = &mmap_rnd_compat_bits,
+				.maxlen         = sizeof(mmap_rnd_compat_bits),
+				.mode           = 0600,
+				.proc_handler   = proc_dointvec_minmax,
+				.extra1         = (void *)&mmap_rnd_compat_bits_min,
+				.extra2         = (void *)&mmap_rnd_compat_bits_max,
+		},
+#endif
+};
+#endif /* CONFIG_SYSCTL */
+
 /*
  * initialise the percpu counter for VM
  */
@@ -2180,6 +2252,9 @@ void __init mmap_init(void)
 
 	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
 	VM_BUG_ON(ret);
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", mmap_table);
+#endif
 }
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 04a677f04ca9..7f687563b8c7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -906,7 +906,6 @@ EXPORT_SYMBOL(folio_mc_copy);
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;
-int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
-- 
2.25.1


