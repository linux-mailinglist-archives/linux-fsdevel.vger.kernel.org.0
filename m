Return-Path: <linux-fsdevel+bounces-38940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C949EA0A1CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 08:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0448E7A6267
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B718B499;
	Sat, 11 Jan 2025 07:13:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F51B424E;
	Sat, 11 Jan 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579588; cv=none; b=vCvRR0BkuTPT3ktNlXukAbpvuMRU1asMUFpx0NZIO5UnOnpJT5ZrQQkNRY5sR/kd+Zdp2QqhnLBNE5rA59xQCd0+SHFZ+GHYnYilTZ1qzTKVptirK9uyn6adbT0/3vCjy8mtBIj7jJK7MxkG8BMUPEYd+0gj0SUeCvQM1vkcf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579588; c=relaxed/simple;
	bh=+iJb/++eQVS1qtPzUL3GW+mQfFVAkv4oc6FSfeXUst0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/vf4cE2lyaGhznko+4IGFhH7rSTZ1D2l7fRyFFsLXsZzMfgFCgV5BnEK3RMPRtLrz/kzIIxi3B6JBy9BMfpOlOrisoclKlioSh0OVnYC+WUp7nUEXPU0CohOw/FrLGFb2pFvtfC8kkf5XPd+Sg+bNKBsJWwSy4eB8u0VJbF2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YVV5g1tqpz1kyCf;
	Sat, 11 Jan 2025 15:09:59 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 19FA71402DE;
	Sat, 11 Jan 2025 15:13:04 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 11 Jan
 2025 15:13:00 +0800
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
Subject: [PATCH v5 -next 13/16] x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
Date: Sat, 11 Jan 2025 15:07:48 +0800
Message-ID: <20250111070751.2588654-14-yukaixiong@huawei.com>
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
v5:
 - Accept Brian Gerst's suggestion to reduce the preprocessor
   condition "#elif (defined(CONFIG_X86_32) && !defined(CONFIG_UML))"
v4:
 - const qualify struct ctl_table vdso_table
---
---
 arch/x86/entry/vdso/vdso32-setup.c | 16 +++++++++++-----
 kernel/sysctl.c                    |  8 +-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 76e4e74f35b5..8894013eea1d 100644
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
+#else
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
+#else
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


