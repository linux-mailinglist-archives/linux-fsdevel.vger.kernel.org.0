Return-Path: <linux-fsdevel+bounces-28315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2396924A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 05:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD16B285E34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 03:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A71D6DA2;
	Tue,  3 Sep 2024 03:31:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB61D6188;
	Tue,  3 Sep 2024 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725334295; cv=none; b=ktUJD3comaN52Q8+Bmu+7M9AmXWRlNChLtnz5N0HH7zuDKKjRZ9q/7Wfprs2SpOCZNpMCcaF921qnzYCgSLOiWSrzPONBxrzKHTU15v/h/mscSwYuHTBsF+Mpf/HAZm2QZl9Ot09Wo9z8iUXRd26BFjUI6NU8CtmunSmtCVApKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725334295; c=relaxed/simple;
	bh=cgw66kukic4DVIIa5sUspegJ6/MzUANYOuCmJjMjPEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwpRVQv0tEKYhBlHswhZxa3/pj1pVsvZo/D9FfR1iZjHaoUG8RA3q5LiQ1FpHgzg6grY4lv7W1ivY21MruLBTGXK0R04Ow5NkTzSGFUeBdZ+zwbxpEGp0uyduvu7AZh7G4OZ7+aajhqnm3m/5fazEW1ZbZKBxxyz/eJGG7Gm5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WyWHn6dS2z69V1;
	Tue,  3 Sep 2024 11:26:29 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id F2EBE180087;
	Tue,  3 Sep 2024 11:31:25 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 11:31:23 +0800
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
Subject: [PATCH v2 -next 10/15] fs: drop_caches: move sysctl to its own file
Date: Tue, 3 Sep 2024 11:30:06 +0800
Message-ID: <20240903033011.2870608-11-yukaixiong@huawei.com>
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

The sysctl_drop_caches to fs/drop_caches.c, move it into
its own file from /kernel/sysctl.c. And remove the useless
extern variable declaration from include/linux/mm.h

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 fs/drop_caches.c   | 23 +++++++++++++++++++++--
 include/linux/mm.h |  6 ------
 kernel/sysctl.c    |  9 ---------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d45ef541d848..f2551ace800f 100644
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
+static struct ctl_table drop_caches_table[] = {
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
index b7f12988237a..d48933b47076 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3765,12 +3765,6 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 
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
index 373e018b950c..d638a1bac9af 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2024,15 +2024,6 @@ static struct ctl_table kern_table[] = {
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
2.25.1


