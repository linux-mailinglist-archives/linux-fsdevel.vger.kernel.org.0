Return-Path: <linux-fsdevel+bounces-27156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188E95F0B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D391F23FE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288281714D5;
	Mon, 26 Aug 2024 12:06:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98F18BC1B;
	Mon, 26 Aug 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673962; cv=none; b=U1mClFDnD1fNmmD4G5VHHO8ilz1Kc9xYbBKSZhvtN+zQGwG8DnDj68sgbniqE+xBa0kClduwuInwtJLVTCMWh6/O0qsw7XgghQxnfcmV0oXEefPvWs1YB/elCNVcCMGw8aWjrgYVN1KS/nNB+5JJZel2y3oP0otaG4zpFSi7eMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673962; c=relaxed/simple;
	bh=h3Deb6bUTfVPM8fisrmPIzFbDwC8S/5kpgH7lZ8PYpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frFuS8rW4oG9qCRNjTx/Ds9T87QDc0XSSPPBNv6oLPX9RnvVvEQmOzqEDShNjBViZPi8smkzqCpwWDGZFvayrN6Ura0P6W8U2nynQy5Bjsox56H3MTV8E9WDUSUtx03o3k8PiKaf92Z1mHZ1/JZF4NQfgRRdFr0hDKodSrrUxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WsqB46qZYz1j7Lb;
	Mon, 26 Aug 2024 20:05:16 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B0FF1A0188;
	Mon, 26 Aug 2024 20:05:25 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:23 +0800
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
Subject: [PATCH -next 02/15] mm: filemap: move sysctl to its own file
Date: Mon, 26 Aug 2024 20:04:36 +0800
Message-ID: <20240826120449.1666461-3-yukaixiong@huawei.com>
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

This moves the filemap related sysctl to its own file, and
removes the redundant external variable declaration.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 include/linux/mm.h |  2 --
 kernel/sysctl.c    |  8 --------
 mm/filemap.c       | 18 +++++++++++++++---
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fc111a0a5375..1db4cd7136ff 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,8 +39,6 @@ struct user_struct;
 struct pt_regs;
 struct folio_batch;
 
-extern int sysctl_page_lock_unfairness;
-
 void mm_core_init(void);
 void init_mm_internals(void);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 726b866af57b..2a875b739054 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2089,14 +2089,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_FOUR,
 	},
-	{
-		.procname	= "page_lock_unfairness",
-		.data		= &sysctl_page_lock_unfairness,
-		.maxlen		= sizeof(sysctl_page_lock_unfairness),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
 #ifdef CONFIG_MMU
 	{
 		.procname	= "max_map_count",
diff --git a/mm/filemap.c b/mm/filemap.c
index 0f13126b43b0..72695ccacb86 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -47,6 +47,7 @@
 #include <linux/splice.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
+#include <linux/sysctl.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1067,6 +1068,19 @@ static wait_queue_head_t *folio_waitqueue(struct folio *folio)
 	return &folio_wait_table[hash_ptr(folio, PAGE_WAIT_TABLE_BITS)];
 }
 
+/* How many times do we accept lock stealing from under a waiter? */
+static int sysctl_page_lock_unfairness = 5;
+static struct ctl_table filemap_sysctl_table[] = {
+	{
+		.procname	= "page_lock_unfairness",
+		.data		= &sysctl_page_lock_unfairness,
+		.maxlen		= sizeof(sysctl_page_lock_unfairness),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	}
+};
+
 void __init pagecache_init(void)
 {
 	int i;
@@ -1075,6 +1089,7 @@ void __init pagecache_init(void)
 		init_waitqueue_head(&folio_wait_table[i]);
 
 	page_writeback_init();
+	register_sysctl_init("vm", filemap_sysctl_table);
 }
 
 /*
@@ -1222,9 +1237,6 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	return true;
 }
 
-/* How many times do we accept lock stealing from under a waiter? */
-int sysctl_page_lock_unfairness = 5;
-
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
-- 
2.25.1


