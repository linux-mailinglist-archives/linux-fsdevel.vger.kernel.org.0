Return-Path: <linux-fsdevel+bounces-38189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF89FDB41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CC53A2459
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47119E7ED;
	Sat, 28 Dec 2024 15:02:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5419DF48;
	Sat, 28 Dec 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398138; cv=none; b=A/U+kIrBDSzzeGTe+IrP9WEfABMJgkcPQZuE27FO1nbky5yjlwTPLjJw4MuRvYHbwcao9lmVDhHN7sbWyaM/QGuWf3f712AMCAEkGoNNYbKDXWloh7j2Rr+n5HrNQGJR+mZa0RlvMqmGDZiC82/DH9man+rFi2yO2beDQBcG6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398138; c=relaxed/simple;
	bh=fAeSG8GX2vLrPZYjKh64LRtiL1F/nvMSmcxJk9KJfNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9TSWWWuzxigzqevMH/LU8bBJwVJPaGYiuyjEx5J7SEHSCwj2NdSl0kZaBw09FqDvi9ErU1v+AodplcDhiWX4W565St61m8iNv3VGodiU9k8W5Cryrg63eVkgDTonrEI2op91FHp1uhMaCs70muVylaCbBPRqQxDgi20WtLouUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YL59n2bf5z2FcBc;
	Sat, 28 Dec 2024 22:59:25 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id F29C51A0188;
	Sat, 28 Dec 2024 23:02:12 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Dec
 2024 23:02:09 +0800
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
Subject: [PATCH v4 -next 09/15] fs: fs-writeback: move sysctl to fs/fs-writeback.c
Date: Sat, 28 Dec 2024 22:57:40 +0800
Message-ID: <20241228145746.2783627-10-yukaixiong@huawei.com>
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

The dirtytime_expire_interval belongs to fs/fs-writeback.c, move it to
fs/fs-writeback.c from /kernel/sysctl.c. And remove the useless extern
variable declaration and the function declaration from
include/linux/writeback.h

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
v4:
 - const qualify struct ctl_table vm_fs_writeback_table
v3:
 - change dirtytime_expire_interval to static type
 - change the title
---
---
 fs/fs-writeback.c         | 30 +++++++++++++++++++++---------
 include/linux/writeback.h |  4 ----
 kernel/sysctl.c           |  8 --------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5980ac24c7a4..4f907e8dbfff 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -65,7 +65,7 @@ struct wb_writeback_work {
  * timestamps written to disk after 12 hours, but in the worst case a
  * few inodes might not their timestamps updated for 24 hours.
  */
-unsigned int dirtytime_expire_interval = 12 * 60 * 60;
+static unsigned int dirtytime_expire_interval = 12 * 60 * 60;
 
 static inline struct inode *wb_inode(struct list_head *head)
 {
@@ -2435,14 +2435,7 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 }
 
-static int __init start_dirtytime_writeback(void)
-{
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
-	return 0;
-}
-__initcall(start_dirtytime_writeback);
-
-int dirtytime_interval_handler(const struct ctl_table *table, int write,
+static int dirtytime_interval_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -2453,6 +2446,25 @@ int dirtytime_interval_handler(const struct ctl_table *table, int write,
 	return ret;
 }
 
+static const struct ctl_table vm_fs_writeback_table[] = {
+	{
+		.procname	= "dirtytime_expire_seconds",
+		.data		= &dirtytime_expire_interval,
+		.maxlen		= sizeof(dirtytime_expire_interval),
+		.mode		= 0644,
+		.proc_handler	= dirtytime_interval_handler,
+		.extra1		= SYSCTL_ZERO,
+	},
+};
+
+static int __init start_dirtytime_writeback(void)
+{
+	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	register_sysctl_init("vm", vm_fs_writeback_table);
+	return 0;
+}
+__initcall(start_dirtytime_writeback);
+
 /**
  * __mark_inode_dirty -	internal function to mark an inode dirty
  *
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d11b903c2edb..caf4f0b12235 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -327,12 +327,8 @@ extern struct wb_domain global_wb_domain;
 /* These are exported to sysctl. */
 extern unsigned int dirty_writeback_interval;
 extern unsigned int dirty_expire_interval;
-extern unsigned int dirtytime_expire_interval;
 extern int laptop_mode;
 
-int dirtytime_interval_handler(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
 unsigned long cgwb_calc_thresh(struct bdi_writeback *wb);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 97f9abffff0f..c5527f59e3f2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2014,14 +2014,6 @@ static struct ctl_table kern_table[] = {
 };
 
 static struct ctl_table vm_table[] = {
-	{
-		.procname	= "dirtytime_expire_seconds",
-		.data		= &dirtytime_expire_interval,
-		.maxlen		= sizeof(dirtytime_expire_interval),
-		.mode		= 0644,
-		.proc_handler	= dirtytime_interval_handler,
-		.extra1		= SYSCTL_ZERO,
-	},
 	{
 		.procname	= "drop_caches",
 		.data		= &sysctl_drop_caches,
-- 
2.34.1


