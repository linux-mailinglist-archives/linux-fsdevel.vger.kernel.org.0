Return-Path: <linux-fsdevel+bounces-28308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C896921D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 05:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C00284E90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 03:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176E51D04BD;
	Tue,  3 Sep 2024 03:31:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37F1CFEAF;
	Tue,  3 Sep 2024 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725334278; cv=none; b=HOj2WTO5kKOMwAfHkkzO9FUp9WeUOnF20RsZfAYZobFUH2HyO6mtBRmALK00Ji3BVhqUNLhxzAZPyHkJz9kHEYa24+IB8Yl4vBoNO6YwU9UpavrlRWmyziLvnkGOHfVrJ6I+qpv9fNDo2JoeV4QIIdgbsYwX1JzrxZpBA8djmQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725334278; c=relaxed/simple;
	bh=kMeuEsRaLXA0kUc7EcwAJIeZfnO5LhozKY3BR2W1jD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGWaz2Tjy37gWcbFOW/1Z/HQT8H2SKgjXaATuRRjRx0hBq14YwGy+W7rk86a1vkOumaT0LmFq4yo9WSJdorzZbdeZ2phuTjotEhXCKXYpfeSLJpVpYVzSObEbheUmxpViP6K1ANVsj3L/1y8ehQWR/XhDIkwlyhYAt8zWvCXIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WyWHS4qH9z20mjM;
	Tue,  3 Sep 2024 11:26:12 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B0F51402C6;
	Tue,  3 Sep 2024 11:31:08 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 11:31:05 +0800
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
Subject: [PATCH v2 -next 03/15] mm: swap: move sysctl to its own file
Date: Tue, 3 Sep 2024 11:29:59 +0800
Message-ID: <20240903033011.2870608-4-yukaixiong@huawei.com>
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

The page-cluster belongs to mm/swap.c, move it into its own file.
Removes the redundant external variable declaration and unneeded
include(linux/swap.h).

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/linux/mm.h |  2 --
 kernel/sysctl.c    | 10 ----------
 mm/swap.c          | 16 +++++++++++++++-
 mm/swap.h          |  1 +
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca196ba1e2d8..99f3c84652d8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -75,8 +75,6 @@ static inline void totalram_pages_add(long count)
 }
 
 extern void * high_memory;
-extern int page_cluster;
-extern const int page_cluster_max;
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_legacy_va_layout;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2a875b739054..9fad501311a1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -21,7 +21,6 @@
 
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
@@ -2054,15 +2053,6 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= overcommit_kbytes_handler,
 	},
-	{
-		.procname	= "page-cluster",
-		.data		= &page_cluster,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&page_cluster_max,
-	},
 	{
 		.procname	= "dirtytime_expire_seconds",
 		.data		= &dirtytime_expire_interval,
diff --git a/mm/swap.c b/mm/swap.c
index 510573d7e82e..07cbd55938e8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -45,7 +45,7 @@
 
 /* How many pages do we try to swap or page in/out together? As a power of 2 */
 int page_cluster;
-const int page_cluster_max = 31;
+static const int page_cluster_max = 31;
 
 struct cpu_fbatches {
 	/*
@@ -1089,6 +1089,18 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
 	fbatch->nr = j;
 }
 
+static struct ctl_table swap_sysctl_table[] = {
+	{
+		.procname	= "page-cluster",
+		.data		= &page_cluster,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void *)&page_cluster_max,
+	}
+};
+
 /*
  * Perform any setup for the swap system
  */
@@ -1105,4 +1117,6 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	register_sysctl_init("vm", swap_sysctl_table);
 }
diff --git a/mm/swap.h b/mm/swap.h
index f8711ff82f84..7283593a0d4a 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -3,6 +3,7 @@
 #define _MM_SWAP_H
 
 struct mempolicy;
+extern int page_cluster;
 
 #ifdef CONFIG_SWAP
 #include <linux/swapops.h> /* for swp_offset */
-- 
2.25.1


