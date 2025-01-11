Return-Path: <linux-fsdevel+bounces-38942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18BDA0A1C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 08:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BAC16DE48
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D12E1B87DB;
	Sat, 11 Jan 2025 07:13:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42981B85EB;
	Sat, 11 Jan 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579597; cv=none; b=Id5sDOMK/49EcOPusj/OBNAd437XeemPvZ7nPUnqm0j68P6RWH9WMIx9VB+eukKqTSokZVqadzU0Gb1AMFaUrBKoiDhbZTAO1VmL4m9Ga3Amv9/albfkTTo6P7wulkjT/TsxhkWLRQrb8LMX5i971qWemWil5JPu7BkSNfcttN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579597; c=relaxed/simple;
	bh=2AS5DJLZOb1C/OyN78LI8jlBJ9J9jsdqmrUGRnP2geU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlLSi9LStG9x49wiy5Z3J6r2D6z/mjHmAGwHcZWfxkjuBA179/2E0Y0UgmVIvLeuxoXnMFFLldFPJbgVr/G0tfa15fvZgY+IcsiBqlqGwTVpEYzBXXPg7/MD6ppjS5E3oQ4F375fTmt6ajW2jtEhmV0HZYqlDqaWB2+t86hPlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YVV9k5jS7z2YPj0;
	Sat, 11 Jan 2025 15:13:30 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 83882140109;
	Sat, 11 Jan 2025 15:13:07 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 11 Jan
 2025 15:13:03 +0800
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
Subject: [PATCH v5 -next 14/16] sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
Date: Sat, 11 Jan 2025 15:07:49 +0800
Message-ID: <20250111070751.2588654-15-yukaixiong@huawei.com>
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

When CONFIG_SUPERH and CONFIG_VSYSCALL are defined,
vdso_enabled belongs to arch/sh/kernel/vsyscall/vsyscall.c.
So, move it into its own file. To avoid failure when registering
the vdso_table, move the call to register_sysctl_init() into
its own fs_initcall().

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
v5:
 - fix the error discovered by Geert Uytterhoeven.
   Move the call to register_sysctl_init() into
   its own fs_initcall() as Geert Uytterhoeven's patch does.
 - take the advice of Joel Granados, separating path14 in V4
   into patch14 and patch15 in V5. This patch just moves the
   vdso_enabled table. The next patch removes the vm_table.
 - modify the change log
v4:
 - const qualify struct ctl_table vdso_table
v3:
 - change the title
---
---
 arch/sh/kernel/vsyscall/vsyscall.c | 20 ++++++++++++++++++++
 kernel/sysctl.c                    | 13 +------------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
index add35c51e017..d80dd92a483a 100644
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
@@ -58,6 +70,14 @@ int __init vsyscall_init(void)
 	return 0;
 }
 
+static int __init vm_sysctl_init(void)
+{
+       register_sysctl_init("vm", vdso_table);
+       return 0;
+}
+
+fs_initcall(vm_sysctl_init);
+
 /* Setup a VMA at program startup for the vsyscall page */
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7ff07b7560b4..21c362768358 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2012,18 +2012,7 @@ static struct ctl_table kern_table[] = {
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
+static struct ctl_table vm_table[] = {};
 
 int __init sysctl_init_bases(void)
 {
-- 
2.34.1


