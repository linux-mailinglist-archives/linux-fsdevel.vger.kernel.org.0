Return-Path: <linux-fsdevel+bounces-28309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8FB969223
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 05:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4621F242B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 03:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F861D173A;
	Tue,  3 Sep 2024 03:31:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF31D0480;
	Tue,  3 Sep 2024 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725334280; cv=none; b=XoqMo6U6KdwHxT7ly9OfI0Z3xUa2JFHPDr8zbdw7/ZN73iklIvtxV7VMwNo52hwyVPQS8iXJT3RWWSxushi7qGM9wX3sNrF6xQ9DLL712O9sf4fnrd+hOvuFPBHKfAXsOBC47C5VdhM9s1MfnpHGINP3STFJUYUssGTCR4YTiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725334280; c=relaxed/simple;
	bh=uepFedYRRmDj8QBPxQqxxg6XgvN8BKxVjPc72UiCuDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm909BCzMsDjGiAThjb99cxLleLyT0xWyqSfXqnviCrBGWeqi3nFnqmsI5Mfavaee6ET4LH58FKnOB5itoCIGM5oFzLRsZ6fpBsjmIrwJi3m3ddB/1fp7eX7AjTFn29cvDaCD+xkZppZv7eY+FjLuslznu4Mzhxj6p4rxVUOwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WyWHc1xTJz20mjS;
	Tue,  3 Sep 2024 11:26:20 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id DA1AD180019;
	Tue,  3 Sep 2024 11:31:15 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 11:31:13 +0800
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
Subject: [PATCH v2 -next 06/15] mm: mmap: move sysctl into its own file
Date: Tue, 3 Sep 2024 11:30:02 +0800
Message-ID: <20240903033011.2870608-7-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903033011.2870608-1-yukaixiong@huawei.com>
References: <20240903033011.2870608-1-yukaixiong@huawei.com>
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
kernel/sysctl.c into mm/mmap.c.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v2:
 - fix sysctl_max_map_count undeclared issue in mm/nommu.c
---
 kernel/sysctl.c | 50 +--------------------------------------------
 mm/mmap.c       | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 49 deletions(-)

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
index c018f5a5bffd..e3d888aa1e25 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2120,6 +2120,57 @@ struct vm_area_struct *_install_special_mapping(
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
@@ -2129,6 +2180,9 @@ void __init mmap_init(void)
 
 	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
 	VM_BUG_ON(ret);
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", mmap_table);
+#endif
 }
 
 /*
-- 
2.25.1


