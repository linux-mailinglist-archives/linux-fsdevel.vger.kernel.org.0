Return-Path: <linux-fsdevel+bounces-27147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8095F07C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F11C21D4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A9817C9B2;
	Mon, 26 Aug 2024 12:05:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34717B51A;
	Mon, 26 Aug 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673943; cv=none; b=leKoRiQ9BJCwGsY4qdBVPupyBorF7HeR9E0arU3e+IYYeXjlJiIJS8cBzMfXzmhQ2FADUgRts3F2msJ1ymoyBfuMAB0k4LzyT9Rowm/HSIlPC/7JIfCae5oboiBbU3SKQHPXrpOla1rzvQ6ns+RLjk9SueqkvJdmouvR4HkZR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673943; c=relaxed/simple;
	bh=8C6V24t9B/ZAyaa2lnsXhkKXChe6T09hukyJHd+vfmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5wAkrr+rOEx8GfxvWVovDiWlLJjYOkB6GD0sO2KeqsvzqvTnXCgkpNcvCbtPsx9Wk0eC3ulkAwhtj3mO8b9I7IZCpWj6LPeBuEnP8s9xZLHZff7zdBzUp3keTtGmbsfn/f4K58idcS4qrU7WsiIyHOY9i4XA3WMqW/hZ9dGB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wsq9d3wqzzyQKn;
	Mon, 26 Aug 2024 20:04:53 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A46E1404FC;
	Mon, 26 Aug 2024 20:05:39 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:36 +0800
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
Subject: [PATCH -next 08/15] mm: nommu: move sysctl to its own file
Date: Mon, 26 Aug 2024 20:04:42 +0800
Message-ID: <20240826120449.1666461-9-yukaixiong@huawei.com>
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

The sysctl_nr_trim_pages belongs to nommu.c, move it into its own file
from /kernel/sysctl.c. And remove the useless extern variable declaration
from include/linux/mm.h

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 include/linux/mm.h |  2 --
 kernel/sysctl.c    | 10 ----------
 mm/nommu.c         | 15 ++++++++++++++-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9400c92b4522..9e37d46fa666 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3972,8 +3972,6 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 				      pgoff_t first_index, pgoff_t nr);
 #endif
 
-extern int sysctl_nr_trim_pages;
-
 #ifdef CONFIG_PRINTK
 void mem_dump_obj(void *object);
 #else
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0c0bab3dad7d..d3de31ec74bf 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2041,16 +2041,6 @@ static struct ctl_table vm_table[] = {
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
index 385b0c15add8..983ee961dd67 100644
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
+static struct ctl_table nommu_table[] = {
+	{
+		.procname	= "nr_trim_pages",
+		.data		= &sysctl_nr_trim_pages,
+		.maxlen		= sizeof(sysctl_nr_trim_pages),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+}
+
 /*
  * initialise the percpu counter for VM and region record slabs
  */
@@ -402,6 +414,7 @@ void __init mmap_init(void)
 	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
 	VM_BUG_ON(ret);
 	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
+	register_syscall_init("vm", nommu_table);
 }
 
 /*
-- 
2.25.1


