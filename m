Return-Path: <linux-fsdevel+bounces-27158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A603395F0CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A8E285DCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E35197A8A;
	Mon, 26 Aug 2024 12:06:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87C19752C;
	Mon, 26 Aug 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673970; cv=none; b=avUJNHdUJRmCSi3IwWzT9sJGrA1gITJHcyH5p+UxhU7HQigrgTrfsgIiduiO9KxFh1HTMoF0GXuSimHujzUzfyYCy/VQ/QUM/TFyu5TDdWUd4ee8lwjENIIsB70+ntRLAe/tEoY0QFj2G/2aKdsUIU3oD/gYxsKdhTu5mIBFnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673970; c=relaxed/simple;
	bh=wKDgTxR9gBu6cta0yrIZtodQka8ta6dX+hbZduFZk6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W86TWWh6/A7HubFwfdI7j47ipYQ77LWBpazyd854y5Q3qZwmkCP3bFnm8lZRhuXpGevL8pxZ0rjxqDgbtfIfKFb92nLjcAeKJWLF2ECbwzRMpFJpEiYyK3AWBm14NxH4uxnqPJRjjbZNDw/hKgo8bqUK6iBDLIFnpdB/WJhEO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WsqB146phzyR5w;
	Mon, 26 Aug 2024 20:05:13 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id B6D8A1800A5;
	Mon, 26 Aug 2024 20:05:41 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:39 +0800
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
Subject: [PATCH -next 09/15] fs: fs-writeback: move sysctl to its own file
Date: Mon, 26 Aug 2024 20:04:43 +0800
Message-ID: <20240826120449.1666461-10-yukaixiong@huawei.com>
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

The dirtytime_expire_interval belongs to fs/fs-writeback.c, move it into
its own file from /kernel/sysctl.c. And remove the useless extern variable
declaration and the function declaration from include/linux/writeback.h

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 fs/fs-writeback.c         | 28 ++++++++++++++++++++--------
 include/linux/writeback.h |  4 ----
 kernel/sysctl.c           |  8 --------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1a5006329f6f..71ff73552323 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2400,14 +2400,7 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
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
@@ -2418,6 +2411,25 @@ int dirtytime_interval_handler(const struct ctl_table *table, int write,
 	return ret;
 }
 
+static struct ctl_table vm_fs_writeback_table[] = {
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
index 21dac644d325..22bc047ed91e 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -351,12 +351,8 @@ extern struct wb_domain global_wb_domain;
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
index d3de31ec74bf..373e018b950c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2024,14 +2024,6 @@ static struct ctl_table kern_table[] = {
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
2.25.1


