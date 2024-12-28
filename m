Return-Path: <linux-fsdevel+bounces-38191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646D9FDB50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 16:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF62D1885A9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CBB194C9E;
	Sat, 28 Dec 2024 15:02:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C219E98C;
	Sat, 28 Dec 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398142; cv=none; b=ndXeaMhCL2QfWiTXDXOO8op4a0MKCpbbTtTOZt4nW0b232OzL5FOuEumD435vHEKYQVsqt3PZjsLdIMrbIsMPjBrXWg5ULC8PN/fPbRqnHC5duy6lQPP4lwGC3AL1VzHwTzM+dVss3AdhkmugbK47wBSaEQS8FSWRtT2aVn20oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398142; c=relaxed/simple;
	bh=14J6OJXW3DOPTHcTHfE49I+xzEk3GmudwvAZ5T7utTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/gatm2EA78+aJaBRqMPoKcqLwN08Bja/W6HCFL/lGA9jbIWLzIt0+Pvk5dZxq6qwQBtg1pXE/4GzvG9HGV9S2kjGyzQq3UbxxhFnm9stBpeHLUt3NeQUyAt77tQwbvk9kn1x/HnP9ki0OtUdujJTuVE6MQ+9XkF2gjgF5racBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YL59r1bPRz1T7Z7;
	Sat, 28 Dec 2024 22:59:28 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AA71180042;
	Sat, 28 Dec 2024 23:02:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Dec
 2024 23:02:12 +0800
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
Subject: [PATCH v4 -next 10/15] fs: drop_caches: move sysctl to fs/drop_caches.c
Date: Sat, 28 Dec 2024 22:57:41 +0800
Message-ID: <20241228145746.2783627-11-yukaixiong@huawei.com>
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

The sysctl_drop_caches to fs/drop_caches.c, move it to
fs/drop_caches.c from /kernel/sysctl.c. And remove the
useless extern variable declaration from include/linux/mm.h

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v4:
 - const qualify struct ctl_table drop_caches_table
v3:
 - change the title
---
---
 fs/drop_caches.c   | 23 +++++++++++++++++++++--
 include/linux/mm.h |  6 ------
 kernel/sysctl.c    |  9 ---------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d45ef541d848..019a8b4eaaf9 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -14,7 +14,7 @@
 #include "internal.h"
 
 /* A global variable is a bit ugly, but it keeps the code simple */
-int sysctl_drop_caches;
+static int sysctl_drop_caches;
 
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
@@ -48,7 +48,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	iput(toput_inode);
 }
 
-int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
+static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret;
@@ -77,3 +77,22 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 	}
 	return 0;
 }
+
+static const struct ctl_table drop_caches_table[] = {
+	{
+		.procname	= "drop_caches",
+		.data		= &sysctl_drop_caches,
+		.maxlen		= sizeof(int),
+		.mode		= 0200,
+		.proc_handler	= drop_caches_sysctl_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_FOUR,
+	},
+};
+
+static int __init init_vm_drop_caches_sysctls(void)
+{
+	register_sysctl_init("vm", drop_caches_table);
+	return 0;
+}
+fs_initcall(init_vm_drop_caches_sysctls);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9813b5b9c093..387f579a6c18 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3803,12 +3803,6 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 
 extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
 
-#ifdef CONFIG_SYSCTL
-extern int sysctl_drop_caches;
-int drop_caches_sysctl_handler(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-#endif
-
 void drop_slab(void);
 
 #ifndef CONFIG_MMU
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c5527f59e3f2..7fb77cbcc24d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2014,15 +2014,6 @@ static struct ctl_table kern_table[] = {
 };
 
 static struct ctl_table vm_table[] = {
-	{
-		.procname	= "drop_caches",
-		.data		= &sysctl_drop_caches,
-		.maxlen		= sizeof(int),
-		.mode		= 0200,
-		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_FOUR,
-	},
 	{
 		.procname	= "vfs_cache_pressure",
 		.data		= &sysctl_vfs_cache_pressure,
-- 
2.34.1


