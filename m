Return-Path: <linux-fsdevel+bounces-38039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E0F9FAFAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F12916924C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1548D1DA2F6;
	Mon, 23 Dec 2024 14:20:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C661B0F1E;
	Mon, 23 Dec 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963617; cv=none; b=YyIel6//PSIA6ln/UB7ehycVjiea64YZMfp45vnrtbAe4enzwbNqTA/NbtURO1x5Qzhc5wWc+hCK5i4YRpo82SJcCYDxuCcE7c7srcMMQEQTJgvZPzaLoJQs54jrWmbrhHUPNdgKEQyUxTX3ej9uqouvsidSIdMlhTemm1nN/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963617; c=relaxed/simple;
	bh=cCXzle1aOmQhUqNQ8R/XsZIMZehG8SpEKq614igrZkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bp/dGXvnwHor/1k4SaS+dnzJO7As9awm+P1g8Goh9eft6sjoO+f9zJUgRxBpRJ4XY+XvXxZcm4UlBPCVu920Q3FFMtMP6lQ66bB+kZ8OmwawAb5JleqdIC3/AAd7xhDr/ko05u8HDo2og6zb/Lou+PyLYJqrxbqlnxYZpsNuWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YH0Tl6qjgz2DjPQ;
	Mon, 23 Dec 2024 22:17:31 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DAFF1402E0;
	Mon, 23 Dec 2024 22:20:13 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Dec
 2024 22:20:09 +0800
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
Subject: [PATCH v4 -next 12/15] fs: dcache: move the sysctl to fs/dcache.c
Date: Mon, 23 Dec 2024 22:15:31 +0800
Message-ID: <20241223141550.638616-13-yukaixiong@huawei.com>
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

The sysctl_vfs_cache_pressure belongs to fs/dcache.c, move it to
fs/dcache.c from kernel/sysctl.c. As a part of fs/dcache.c cleaning,
sysctl_vfs_cache_pressure is changed to a static variable, and change
the inline-type function vfs_pressure_ratio() to out-of-inline type,
export vfs_pressure_ratio() with EXPORT_SYMBOL_GPL to be used by other
files. Move the unneeded include(linux/dcache.h).

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v4:
 - const qualify struct ctl_table vm_dcache_sysctls
v3:
 - change the title
v2:
 - update the changelog to call out changing the inline-type function
   vfs_pressure_ratio() to out-of-inline type
---
---
 fs/dcache.c            | 21 +++++++++++++++++++--
 include/linux/dcache.h |  7 +------
 kernel/sysctl.c        |  9 ---------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b4d5e9e1e43d..77ca6e9bb71e 100644
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
 
@@ -211,8 +216,20 @@ static struct ctl_table fs_dcache_sysctls[] = {
 	},
 };
 
+static const struct ctl_table vm_dcache_sysctls[] = {
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
index 7fb77cbcc24d..860dea8f1587 100644
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
@@ -2014,14 +2013,6 @@ static struct ctl_table kern_table[] = {
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
2.34.1


