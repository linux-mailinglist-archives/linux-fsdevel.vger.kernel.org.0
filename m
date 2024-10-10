Return-Path: <linux-fsdevel+bounces-31588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF5C99892D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 16:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4EB1C24770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB91E5712;
	Thu, 10 Oct 2024 14:12:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA71E47BF;
	Thu, 10 Oct 2024 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569536; cv=none; b=NNw9Ul+J+AgOddTFhzn9joM9h1jk2K9zR8qTDJP+8xYf3pXvjYIRq4A8v4cv4d73Nc7yCSmO9KrnGuUWTu2eiOQnFLZIwmd6IIOeuibfU9WYnNPKQfkmFj7LGyEwW3Gud61+GSjIjpkZivWAmE7OewjbGz+UAiHfnuzGU/0YMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569536; c=relaxed/simple;
	bh=CZt2mR/9WBDow6uItoVQJv/7YbYic5+UrZnoIRNsNdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2sl7NwXM/d4DS0LvYmIVMgt1trHHggRmaM+/59xdjibf4oJMUHcP2VQX3AkIi+hwDFkrwwER//A+FGZTcStHl+CO/4LlDgZi4wIa0OhDqQu+jkS+K+q1mCxA+GiJhDzvNoa05XMZu98sUWZKmxRvsE6IZSsRvM3xLP8apzrfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPWn13NLdz1HKky;
	Thu, 10 Oct 2024 22:08:05 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 688EA18001B;
	Thu, 10 Oct 2024 22:12:12 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Oct
 2024 22:12:09 +0800
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
Subject: [PATCH v3 -next 13/15] x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
Date: Thu, 10 Oct 2024 23:22:13 +0800
Message-ID: <20241010152215.3025842-14-yukaixiong@huawei.com>
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
 arch/x86/entry/vdso/vdso32-setup.c | 16 +++++++++++-----
 kernel/sysctl.c                    |  8 +-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 76e4e74f35b5..5a6886a006ab 100644
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
+static struct ctl_table vdso_table[] = {
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
index 6f03fc749794..24617be93119 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2023,17 +2023,11 @@ static struct ctl_table kern_table[] = {
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


