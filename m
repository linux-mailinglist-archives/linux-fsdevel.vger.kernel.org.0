Return-Path: <linux-fsdevel+bounces-38050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16F9FAFE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E712D1687B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B71DFE34;
	Mon, 23 Dec 2024 14:20:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD01DFE04;
	Mon, 23 Dec 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963657; cv=none; b=u1C69OBbFWXfK7oFaP8WDB28aIh6wzF4EJJYYyZ0cZ4mL2zd+veJF4NIjyxK3/bd8fQz74+nBJNggqRFdUu3uNWdbrkVKGXiXWbJQXH4LE5f1vGkuwNM28y8CHQYy2rsvMoBs8RH6Aj1mizpPMtfez8PGh0neWn7CeGft/abiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963657; c=relaxed/simple;
	bh=+Sagc6YHoR7nUNc4+sYUmF/kg8re5kI6IQ8+RhDQyCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJU0LD/IG5lh9/1WHb0Jwbm/I5Npad+GOqtQ0XhU/uxxzE+mXFNOkyDe7swfXg5o359BuLNJkHrFFVSxwPCozE1LAgTGwDnA7ZG8SUbcr30m9s4AvtpvPlYJSxto0gS9F5sRn2EBfW8sC31np6BcephleNdNI77Xq/9uNqICSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YH0VW5mCTz1T711;
	Mon, 23 Dec 2024 22:18:11 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 9907F140202;
	Mon, 23 Dec 2024 22:20:53 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Dec
 2024 22:20:50 +0800
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
Subject: [PATCH v4 -next 08/15] mm: nommu: move sysctl to mm/nommu.c
Date: Mon, 23 Dec 2024 22:15:43 +0800
Message-ID: <20241223141550.638616-25-yukaixiong@huawei.com>
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

The sysctl_nr_trim_pages belongs to nommu.c, move it to mm/nommu.c
from /kernel/sysctl.c. And remove the useless extern variable declaration
from include/linux/mm.h

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
v4:
 - const qualify struct ctl_table nommu_table
v3:
 - change the title
v2:
 - fix the build error: expected ';' after top level declarator
 - fix the build error: call to undeclared function 'register_syscall_init',
   use 'register_sysctl_init' to replace it.
---
---
 include/linux/mm.h |  2 --
 kernel/sysctl.c    | 10 ----------
 mm/nommu.c         | 15 ++++++++++++++-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b3b87c1dc1e4..9813b5b9c093 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4080,8 +4080,6 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 				      pgoff_t first_index, pgoff_t nr);
 #endif
 
-extern int sysctl_nr_trim_pages;
-
 #ifdef CONFIG_PRINTK
 void mem_dump_obj(void *object);
 #else
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62a58e417c40..97f9abffff0f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2031,16 +2031,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_FOUR,
 	},
-#ifndef CONFIG_MMU
-	{
-		.procname	= "nr_trim_pages",
-		.data		= &sysctl_nr_trim_pages,
-		.maxlen		= sizeof(sysctl_nr_trim_pages),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-#endif
 	{
 		.procname	= "vfs_cache_pressure",
 		.data		= &sysctl_vfs_cache_pressure,
diff --git a/mm/nommu.c b/mm/nommu.c
index baa79abdaf03..3c32f8b1eb54 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -48,7 +48,6 @@ struct page *mem_map;
 unsigned long max_mapnr;
 EXPORT_SYMBOL(max_mapnr);
 unsigned long highest_memmap_pfn;
-int sysctl_nr_trim_pages = CONFIG_NOMMU_INITIAL_TRIM_EXCESS;
 int heap_stack_gap = 0;
 
 atomic_long_t mmap_pages_allocated;
@@ -392,6 +391,19 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return mm->brk = brk;
 }
 
+static int sysctl_nr_trim_pages = CONFIG_NOMMU_INITIAL_TRIM_EXCESS;
+
+static const struct ctl_table nommu_table[] = {
+	{
+		.procname	= "nr_trim_pages",
+		.data		= &sysctl_nr_trim_pages,
+		.maxlen		= sizeof(sysctl_nr_trim_pages),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+};
+
 /*
  * initialise the percpu counter for VM and region record slabs
  */
@@ -402,6 +414,7 @@ void __init mmap_init(void)
 	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
 	VM_BUG_ON(ret);
 	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
+	register_sysctl_init("vm", nommu_table);
 }
 
 /*
-- 
2.34.1


