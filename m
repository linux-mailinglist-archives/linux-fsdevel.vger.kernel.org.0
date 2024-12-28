Return-Path: <linux-fsdevel+bounces-38193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081FB9FDB57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FC33A2C5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99251A23AF;
	Sat, 28 Dec 2024 15:02:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4F314F70;
	Sat, 28 Dec 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398151; cv=none; b=CJCEYQY3DjZ4S71zm41uXF5A85mbIz6gT43VDcr37QRRilYGjugz9fHdjoO4M7v6mpvD723MScLZnUL//yDzuL0iDWPHDgkWo25qrsjxB832J+vFeRfQvRqS1iCprPI6+a2CXS/JUx5tLdWvb4nH2hTS29eooK/VhUW3fh4y1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398151; c=relaxed/simple;
	bh=G0/hXX8Mux5h/pq5gAqYAZXB7LfB0NEUl29fatTQeaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0cS4fw5JWTA/rEQlcYE7BXZ/SHhmZx5tcYIyIabFl48DH3hMCLFp8apzw74G7/+Ovd8hl6Ivqp0Ez6/pb5B5jbVA3HDaxYYnEJU+X6IAKX8k8ktw5uy9ASmqYMPGZ2mlZbpIcWZphGUWFac6cC422EsWRkpMo9R9FzgPwVedzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YL5B30xN4z2Fby3;
	Sat, 28 Dec 2024 22:59:39 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id B9F301401E0;
	Sat, 28 Dec 2024 23:02:26 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Dec
 2024 23:02:23 +0800
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
Date: Sat, 28 Dec 2024 22:57:44 +0800
Message-ID: <20241228145746.2783627-14-yukaixiong@huawei.com>
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


