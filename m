Return-Path: <linux-fsdevel+bounces-38040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA8F9FAFBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6023A1883FD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE711DC05F;
	Mon, 23 Dec 2024 14:20:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B91DACB1;
	Mon, 23 Dec 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963621; cv=none; b=Sgbv+DnzYw9j65Cq8kuGoX/982IFcJnjne1a2aARESUBBfXo9Fz8z2ZnPSGatgj4ZVwIN3NrZT50c7HTc6i2yVl3mjqU7JDtft0uJM/PtCy9HEdy6xkh3zDue9nkNP4GnwzBeTDr3Q1FofXkj7tKFw2JQfBfwDjCFrx3w+umOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963621; c=relaxed/simple;
	bh=G0/hXX8Mux5h/pq5gAqYAZXB7LfB0NEUl29fatTQeaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjWnCIvWO4u6qTUDLJgGxcGu384/3DA0khnpH1R8iTmL+TIrbo4337XYxEAPWEW24MGZoKLTemARPXcAQlX5Bcz9KirZYPGsd0uQXzfufQ52LSySTcQ/ajtg5yrWrJL86Th7LzcNOTxwUzZ3erb1Il44EkuJcp7e0b5A1JP+zL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YH0Tq2xVNz1kwqP;
	Mon, 23 Dec 2024 22:17:35 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ED25180043;
	Mon, 23 Dec 2024 22:20:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Dec
 2024 22:20:13 +0800
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
Subject: [PATCH v4 -next 13/15] x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
Date: Mon, 23 Dec 2024 22:15:32 +0800
Message-ID: <20241223141550.638616-14-yukaixiong@huawei.com>
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

When CONFIG_X86_32 is defined and CONFIG_UML is not defined,
vdso_enabled belongs to arch/x86/entry/vdso/vdso32-setup.c.
So, move it into its own file.

Before this patch, vdso_enabled was allowed to be set to
a value exceeding 1 on x86_32 architecture. After this patch is
applied, vdso_enabled is not permitted to set the value more than 1.
It does not matter, because according to the function load_vdso32(),
only vdso_enabled is set to 1, VDSO would be enabled. Other values
all mean "disabled". The same limitation could be seen in the
function vdso32_setup().

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v4:
 - const qualify struct ctl_table vdso_table
---
---
 arch/x86/entry/vdso/vdso32-setup.c | 16 +++++++++++-----
 kernel/sysctl.c                    |  8 +-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 76e4e74f35b5..f71625f99bf9 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -51,15 +51,17 @@ __setup("vdso32=", vdso32_setup);
 __setup_param("vdso=", vdso_setup, vdso32_setup, 0);
 #endif
 
-#ifdef CONFIG_X86_64
 
 #ifdef CONFIG_SYSCTL
-/* Register vsyscall32 into the ABI table */
 #include <linux/sysctl.h>
 
-static struct ctl_table abi_table2[] = {
+static const struct ctl_table vdso_table[] = {
 	{
+#ifdef CONFIG_X86_64
 		.procname	= "vsyscall32",
+#elif (defined(CONFIG_X86_32) && !defined(CONFIG_UML))
+		.procname	= "vdso_enabled",
+#endif
 		.data		= &vdso32_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
@@ -71,10 +73,14 @@ static struct ctl_table abi_table2[] = {
 
 static __init int ia32_binfmt_init(void)
 {
-	register_sysctl("abi", abi_table2);
+#ifdef CONFIG_X86_64
+	/* Register vsyscall32 into the ABI table */
+	register_sysctl("abi", vdso_table);
+#elif (defined(CONFIG_X86_32) && !defined(CONFIG_UML))
+	register_sysctl_init("vm", vdso_table);
+#endif
 	return 0;
 }
 __initcall(ia32_binfmt_init);
 #endif /* CONFIG_SYSCTL */
 
-#endif	/* CONFIG_X86_64 */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 860dea8f1587..7ff07b7560b4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2013,17 +2013,11 @@ static struct ctl_table kern_table[] = {
 };
 
 static struct ctl_table vm_table[] = {
-#if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
-   (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
+#if defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL)
 	{
 		.procname	= "vdso_enabled",
-#ifdef CONFIG_X86_32
-		.data		= &vdso32_enabled,
-		.maxlen		= sizeof(vdso32_enabled),
-#else
 		.data		= &vdso_enabled,
 		.maxlen		= sizeof(vdso_enabled),
-#endif
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
-- 
2.34.1


