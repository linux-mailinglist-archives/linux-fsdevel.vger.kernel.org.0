Return-Path: <linux-fsdevel+bounces-38194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8E9FDB5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459F43A2EF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092AA1A38E4;
	Sat, 28 Dec 2024 15:02:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB91A2554;
	Sat, 28 Dec 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398154; cv=none; b=jBCU4IQxgQv1pUXF/JX1cXmEyHWkzGlUE3KURTjhVOjzZQ5q9NChWLaHAgCU3k1u01TpwDcxHNXicvqFl7hy6Olkgi3iYZUJXP56E3DSXaUrBAkgNbasj4xKENokkyFdmfyhPdeAhQqHJsjeNNBm/ZgHqC7AT0gnX4kQKdBYKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398154; c=relaxed/simple;
	bh=mVynxR4ENQ8pwt669iVIuxHpk/Ejk3/+P2N16D+TN5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDOiG+n94j3E8Iy6mm2ND0FHX845WzUJu0aq8pxXfC76QdsLbUkppo18uemqrVcCoCcjn69a27We4n+HsXyiemN/xHHtFhAEJn2Dv572RkEcnH5TeN6XS/A4oyfh7ox9Kp/Qk/NMNgKjGntiBz+V+UUGJ26SdvyJQsL8UYeiWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YL5B65CNdz1kx8v;
	Sat, 28 Dec 2024 22:59:42 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A977140136;
	Sat, 28 Dec 2024 23:02:30 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Dec
 2024 23:02:26 +0800
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
Subject: [PATCH v4 -next 14/15] sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
Date: Sat, 28 Dec 2024 22:57:45 +0800
Message-ID: <20241228145746.2783627-15-yukaixiong@huawei.com>
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

When CONFIG_SUPERH and CONFIG_VSYSCALL are defined,
vdso_enabled belongs to arch/sh/kernel/vsyscall/vsyscall.c.
So, move it into its own file. After this patch is applied,
all sysctls of vm_table would be moved. So, delete vm_table.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v4:
 - const qualify struct ctl_table vdso_table
v3:
 - change the title
---
---
 arch/sh/kernel/vsyscall/vsyscall.c | 14 ++++++++++++++
 kernel/sysctl.c                    | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
index add35c51e017..898132f34e6a 100644
--- a/arch/sh/kernel/vsyscall/vsyscall.c
+++ b/arch/sh/kernel/vsyscall/vsyscall.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/elf.h>
 #include <linux/sched.h>
+#include <linux/sysctl.h>
 #include <linux/err.h>
 
 /*
@@ -30,6 +31,17 @@ static int __init vdso_setup(char *s)
 }
 __setup("vdso=", vdso_setup);
 
+static const struct ctl_table vdso_table[] = {
+	{
+		.procname	= "vdso_enabled",
+		.data		= &vdso_enabled,
+		.maxlen		= sizeof(vdso_enabled),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= SYSCTL_ZERO,
+	},
+};
+
 /*
  * These symbols are defined by vsyscall.o to mark the bounds
  * of the ELF DSO images included therein.
@@ -55,6 +67,8 @@ int __init vsyscall_init(void)
 	       &vsyscall_trapa_start,
 	       &vsyscall_trapa_end - &vsyscall_trapa_start);
 
+	register_sysctl_init("vm", vdso_table);
+
 	return 0;
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7ff07b7560b4..cebd0ef5d19d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2012,23 +2012,9 @@ static struct ctl_table kern_table[] = {
 #endif
 };
 
-static struct ctl_table vm_table[] = {
-#if defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL)
-	{
-		.procname	= "vdso_enabled",
-		.data		= &vdso_enabled,
-		.maxlen		= sizeof(vdso_enabled),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-	},
-#endif
-};
-
 int __init sysctl_init_bases(void)
 {
 	register_sysctl_init("kernel", kern_table);
-	register_sysctl_init("vm", vm_table);
 
 	return 0;
 }
-- 
2.34.1


