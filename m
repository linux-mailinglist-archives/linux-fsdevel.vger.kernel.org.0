Return-Path: <linux-fsdevel+bounces-27148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216195F083
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76931C22101
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8068E1862B8;
	Mon, 26 Aug 2024 12:05:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55316EC19;
	Mon, 26 Aug 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673955; cv=none; b=uMLnJ19NV+l5Vz9CEn1U286DydaLFnYRAwN718zsaGczvU1pJxUp1SNk9avUQIoOblwjyvYuq+h7p4Tzb65DGBkEsf/rdH1l4c9ujgC0N1SoGn8Mifz8tocDyWtxRS9SJQ8z2KVGaU++liN7t/oYiSMsaSRZMCJRFNKrTHLD7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673955; c=relaxed/simple;
	bh=mOpqRJqcTa3aFt5LqEXBMlD+dlCToV0cJhoNi8dD7Zc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlF+1XbMlpbRLh9pyzSofY9I0tW8I9+Wh6yjXOUcfdJfQ0TRbWllA6fo/0rXcaXfLU7wLkPJ99S87YSzpCW5awBgxbwISFFwoIbRwtyMw7fYEGyKH+Qrxc+2Q3bBlEuz9DWojE93Qfxm3JwEu1Y78nQTKjky647+jOsVsXMDx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WsqBW6Kndz2Cnfm;
	Mon, 26 Aug 2024 20:05:39 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id A83AD1A0188;
	Mon, 26 Aug 2024 20:05:48 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:46 +0800
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
Subject: [PATCH -next 12/15] fs: dcache: move the sysctl into its own file
Date: Mon, 26 Aug 2024 20:04:46 +0800
Message-ID: <20240826120449.1666461-13-yukaixiong@huawei.com>
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

The sysctl_vfs_cache_pressure belongs to fs/dcache.c, move it to
its own file from kernel/sysctl.c. As a part of fs/dcache.c cleaning,
sysctl_vfs_cache_pressure is changed to a static variable, and export
vfs_pressure_ratio with EXPORT_SYMBOL_GPL to be used by other files.
And move the unneeded include(linux/dcache.h).

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 fs/dcache.c            | 21 +++++++++++++++++++--
 include/linux/dcache.h |  7 +------
 kernel/sysctl.c        |  9 ---------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1af75fa68638..8717d5026cda 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -73,8 +73,13 @@
  * If no ancestor relationship:
  * arbitrary, since it's serialized on rename_lock
  */
-int sysctl_vfs_cache_pressure __read_mostly = 100;
-EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
+static int sysctl_vfs_cache_pressure __read_mostly = 100;
+
+unsigned long vfs_pressure_ratio(unsigned long val)
+{
+	return mult_frac(val, sysctl_vfs_cache_pressure, 100);
+}
+EXPORT_SYMBOL_GPL(vfs_pressure_ratio);
 
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
@@ -196,8 +201,20 @@ static struct ctl_table fs_dcache_sysctls[] = {
 	},
 };
 
+static struct ctl_table vm_dcache_sysctls[] = {
+	{
+		.procname	= "vfs_cache_pressure",
+		.data		= &sysctl_vfs_cache_pressure,
+		.maxlen		= sizeof(sysctl_vfs_cache_pressure),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+};
+
 static int __init init_fs_dcache_sysctls(void)
 {
+	register_sysctl_init("vm", vm_dcache_sysctls);
 	register_sysctl_init("fs", fs_dcache_sysctls);
 	return 0;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bff956f7b2b9..c81c2e9e13df 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -508,12 +508,7 @@ static inline int simple_positive(const struct dentry *dentry)
 	return d_really_is_positive(dentry) && !d_unhashed(dentry);
 }
 
-extern int sysctl_vfs_cache_pressure;
-
-static inline unsigned long vfs_pressure_ratio(unsigned long val)
-{
-	return mult_frac(val, sysctl_vfs_cache_pressure, 100);
-}
+unsigned long vfs_pressure_ratio(unsigned long val);
 
 /**
  * d_inode - Get the actual inode of this dentry
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d638a1bac9af..6f03fc749794 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -46,7 +46,6 @@
 #include <linux/key.h>
 #include <linux/times.h>
 #include <linux/limits.h>
-#include <linux/dcache.h>
 #include <linux/syscalls.h>
 #include <linux/nfs_fs.h>
 #include <linux/acpi.h>
@@ -2024,14 +2023,6 @@ static struct ctl_table kern_table[] = {
 };
 
 static struct ctl_table vm_table[] = {
-	{
-		.procname	= "vfs_cache_pressure",
-		.data		= &sysctl_vfs_cache_pressure,
-		.maxlen		= sizeof(sysctl_vfs_cache_pressure),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
 #if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
    (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
 	{
-- 
2.25.1


