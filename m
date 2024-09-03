Return-Path: <linux-fsdevel+bounces-28314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64628969244
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 05:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E72B22E35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 03:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D4F1D6C52;
	Tue,  3 Sep 2024 03:31:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3491CE6F1;
	Tue,  3 Sep 2024 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725334295; cv=none; b=lyle+s/H51io2f3V+w2T23k4EFnjy0cwuqKVguAk/DyFzXzLiCk6kWOxP0JY9rK23U3qi7YtZe9pvvctxzrfR97N2CltTShiXkftfcT2O69ojGCInfz9E7De9G27vUkdx3DbD2uL2K7ltsy4ZSlDMVn6Zms75vAe/tGad3GhTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725334295; c=relaxed/simple;
	bh=4OKRopg7mHrwPVJdVGc96zM+e/6Qr3K2glUvb4GrODc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kkw0fxMe7FncTl1CXB0Wh0JMjBYVNida1xyFS+Apzhc0DTtyJ/YU03HvhpCFzhBL4VZ0mROiv6Sok67EeArQgwnOst4R5x2lf6honP6inkdren9cyG7QfUi29HZtkUSCpxobPsn8Plzcg+rdOOBoEjD42Imfs5OR/4Gyde3s7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WyWM82cThzgYvk;
	Tue,  3 Sep 2024 11:29:24 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id EC29C1402D0;
	Tue,  3 Sep 2024 11:31:30 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 11:31:28 +0800
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
Subject: [PATCH v2 -next 12/15] fs: dcache: move the sysctl into its own file
Date: Tue, 3 Sep 2024 11:30:08 +0800
Message-ID: <20240903033011.2870608-13-yukaixiong@huawei.com>
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

The sysctl_vfs_cache_pressure belongs to fs/dcache.c, move it to
its own file from kernel/sysctl.c. As a part of fs/dcache.c cleaning,
sysctl_vfs_cache_pressure is changed to a static variable, and change
the inline-type function vfs_pressure_ratio() to out-of-inline type,
export vfs_pressure_ratio() with EXPORT_SYMBOL_GPL to be used by other
files. Move the unneeded include(linux/dcache.h).

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v2:
- update the changelog to call out changing the inline-type function
  vfs_pressure_ratio() to out-of-inline type
---
 fs/dcache.c            | 21 +++++++++++++++++++--
 include/linux/dcache.h |  7 +------
 kernel/sysctl.c        |  9 ---------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0f6b16ba30d0..17ea029fa9c9 100644
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
 
@@ -201,8 +206,20 @@ static struct ctl_table fs_dcache_sysctls[] = {
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


