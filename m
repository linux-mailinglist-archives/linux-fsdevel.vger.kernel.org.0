Return-Path: <linux-fsdevel+bounces-27155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B6595F0B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58EE1C22A1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D6A1940AA;
	Mon, 26 Aug 2024 12:06:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91318D62C;
	Mon, 26 Aug 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673962; cv=none; b=j/6PbymjgMqrMz7Dv74f4STPPexEEbtQkNAC8KX9kuuv0TgZwYuCDyztTZAf+aRxm4VKBvIZcmrf0JaBn4t1dWjXQwT7WIoKva2vpmlnX+T6Ks1COao2ilzdlS1kZ8JCY6Xl1pmtL8s5IKluFlInJeqAKf/2Lux8id1nQ6rcA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673962; c=relaxed/simple;
	bh=U69HCK4SsbxtZPxMddnOTp0bY/S4nqcRl//dNXlQVKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlkhNWFVtbilaXbtHtJEE8cgGNshKp4+XVu6ZwqTrQsnVQRh2OOSF9dXHZWn847BrHiw+NOUdHjOeJCjjoDAHXcAfOTrZ3Qe6iIkWhWlh7QM4/+OnbF6eL2yv7/zqb08T9nKQI/uVMWPy2OMtoAwdX9UvHxgeCnz3t9DJ0jf/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WsqBQ4qLNz1S913;
	Mon, 26 Aug 2024 20:05:34 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E97B1A0188;
	Mon, 26 Aug 2024 20:05:44 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:41 +0800
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
Subject: [PATCH -next 10/15] fs: drop_caches: move sysctl to its own file
Date: Mon, 26 Aug 2024 20:04:44 +0800
Message-ID: <20240826120449.1666461-11-yukaixiong@huawei.com>
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

The sysctl_drop_caches to fs/drop_caches.c, move it into
its own file from /kernel/sysctl.c. And remove the useless
extern variable declaration from include/linux/mm.h

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
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
index 9e37d46fa666..a297a298542c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3693,12 +3693,6 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 
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


