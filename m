Return-Path: <linux-fsdevel+bounces-27150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1C95F08F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C051F239AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0232189911;
	Mon, 26 Aug 2024 12:05:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6261862B9;
	Mon, 26 Aug 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673957; cv=none; b=CjEEPxDfJRRGCPqeeKo9CS9HFihFuPw72p6PbjwuCFSfDznQ1rfG/qip+M9EVmvZl/kWLsYCv8fgP2Wc2mC6vovkTht9PYfxQWUIK38Iu/sPikpkMEBBtWsr93wrM4wxRTR40/6t4nTjbj+nL8XaFvPWyaupNM5btdzwpN7fM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673957; c=relaxed/simple;
	bh=AUMQDviq5vnQ71E92lZ5oROx2zM1mtwspjqa1AuPMj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLmUz0F3ReN1P61faRQMiiF5r2lGk2oia5cGqVLpdBIRdGuk9lmict8y4ase1rDrOZfEpvsq2SpBdV/2CAo8PAkGmaprGFLQRQMxRfNPuBgvT9mOZrqE5rK4jkD9feBNEDh6usdWuCy3rB0zIv+xj+Oh7pi+LhDdKDTfR1bfvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wsq9v2t7YzyQK8;
	Mon, 26 Aug 2024 20:05:07 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 4528C1401F0;
	Mon, 26 Aug 2024 20:05:53 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:50 +0800
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
Subject: [PATCH -next 14/15] sh: vdso: move the sysctl into its own file
Date: Mon, 26 Aug 2024 20:04:48 +0800
Message-ID: <20240826120449.1666461-15-yukaixiong@huawei.com>
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

When CONFIG_SUPERH and CONFIG_VSYSCALL are defined,
vdso_enabled belongs to arch/sh/kernel/vsyscall/vsyscall.c.
So, move it into its own file. After this patch is applied,
all sysctls of vm_table would be moved. So, delete vm_table.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 arch/sh/kernel/vsyscall/vsyscall.c | 14 ++++++++++++++
 kernel/sysctl.c                    | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
index add35c51e017..43bc3715e38c 100644
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
 
+static struct ctl_table vdso_table[] = {
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
index 24617be93119..f04da9f3abc6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2022,23 +2022,9 @@ static struct ctl_table kern_table[] = {
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
2.25.1


