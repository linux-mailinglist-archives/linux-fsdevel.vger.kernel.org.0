Return-Path: <linux-fsdevel+bounces-68714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D021C63CDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6044E23C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB732274F;
	Mon, 17 Nov 2025 11:27:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440628727C;
	Mon, 17 Nov 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378863; cv=none; b=r26FrVYPRmR1GOvYiZ2ei4X4vwHnC7R9xE5MK4f5ahdA+OGmrRs9BWQiiSBTVJ66gkMYu7NehVXL5jTpr1TM4ks4nb9+G202QvePopi8ZV0SZ3oI2B+OEnpfcxzrYqsJxeazj5M6F7R3bs+gGsTYWvX37LA3vN1oMBqMyvJ6OYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378863; c=relaxed/simple;
	bh=UUzNA2iPHWl40lVGfTrHFl/4YfRzwJru2qn2FYZlZMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArFfBExKaz4N2n3xDeJm51n7jLVreOIYV50jGpcmBud9F+ECHkkN3Ca+I9BvuThsBbYRHu16mXVBSF1dNx5pi0Nfkp/LL0DNzjOoO2f5mN26hNcZqunkrluglMFSpMPUQha4EzwGtzoOwNlsWHg6JyKbSCmPKqMiPegAPHBC93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d957P5Z9lzKHMmC;
	Mon, 17 Nov 2025 19:27:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CE62D1A0E82;
	Mon, 17 Nov 2025 19:27:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXunBhtp39Q6BA--.30165S6;
	Mon, 17 Nov 2025 19:27:38 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com
Subject: [PATCH v2 2/3] sysctl: add support for drop_caches for individual filesystem
Date: Mon, 17 Nov 2025 19:27:34 +0800
Message-Id: <20251117112735.4170831-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117112735.4170831-1-yebin@huaweicloud.com>
References: <20251117112735.4170831-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXunBhtp39Q6BA--.30165S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1fJryDtry3Gr18Xry5Arb_yoWrWFyrpF
	Wa9ry5KrWFy3W3tr9xAr4vvF1S93ykJw12g3sF934Skw1avryvgasYyFyYqF45JrWUWrW7
	uF4DKF1DW3yDXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcBT5DUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

In order to better analyze the issue of file system uninstallation caused
by kernel module opening files, it is necessary to perform dentry recycling
on a single file system. But now, apart from global dentry recycling, it is
not supported to do dentry recycling on a single file system separately.
This feature has usage scenarios in problem localization scenarios.At the
same time, it also provides users with a slightly fine-grained
pagecache/entry recycling mechanism.
This patch supports the recycling of pagecache/entry for individual file
systems.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/drop_caches.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..3c7e624129ec 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -11,6 +11,10 @@
 #include <linux/sysctl.h>
 #include <linux/gfp.h>
 #include <linux/swap.h>
+#include <linux/ptrace.h>
+#include <asm/syscall.h>
+#include <linux/task_work.h>
+#include <linux/namei.h>
 #include "internal.h"
 
 /* A global variable is a bit ugly, but it keeps the code simple */
@@ -78,6 +82,124 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 	return 0;
 }
 
+struct drop_fs_caches_work {
+	struct callback_head task_work;
+	dev_t dev;
+	char *path;
+	unsigned int ctl;
+};
+
+static void drop_fs_caches(struct callback_head *twork)
+{
+	int ret;
+	struct super_block *sb;
+	static bool suppress;
+	struct drop_fs_caches_work *work = container_of(twork,
+			struct drop_fs_caches_work, task_work);
+	unsigned int ctl = work->ctl;
+	dev_t dev = work->dev;
+
+	if (work->path) {
+		struct path path;
+
+		ret = kern_path(work->path, LOOKUP_FOLLOW, &path);
+		if (ret) {
+			syscall_set_return_value(current,
+						 current_pt_regs(),
+						 0, ret);
+			goto out;
+		}
+		dev = path.dentry->d_sb->s_dev;
+		/* Make this file's dentry and inode recyclable */
+		path_put(&path);
+	}
+
+	sb = user_get_super(dev, false);
+	if (!sb) {
+		syscall_set_return_value(current, current_pt_regs(), 0,
+					 -EINVAL);
+		goto out;
+	}
+
+	if (ctl & BIT(0)) {
+		lru_add_drain_all();
+		drop_pagecache_sb(sb, NULL);
+		count_vm_event(DROP_PAGECACHE);
+	}
+
+	if (ctl & BIT(1)) {
+		reclaim_dcache_sb(sb);
+		reclaim_icache_sb(sb);
+		count_vm_event(DROP_SLAB);
+	}
+
+	if (!READ_ONCE(suppress)) {
+		pr_info("%s (%d): %s: %d %u:%u\n", current->comm,
+			task_pid_nr(current), __func__, ctl,
+			MAJOR(sb->s_dev), MINOR(sb->s_dev));
+
+		if (ctl & BIT(2))
+			WRITE_ONCE(suppress, true);
+	}
+
+	drop_super(sb);
+out:
+	kfree(work->path);
+	kfree(work);
+}
+
+static int drop_fs_caches_sysctl_handler(const struct ctl_table *table,
+					 int write, void *buffer,
+					 size_t *length, loff_t *ppos)
+{
+	struct drop_fs_caches_work *work = NULL;
+	unsigned int major, minor;
+	unsigned int ctl;
+	int ret;
+	char *path = NULL;
+
+	if (!write)
+		return 0;
+
+	if (sscanf(buffer, "%u %u:%u", &ctl, &major, &minor) != 3) {
+		path = kstrdup(buffer, GFP_NOFS);
+		if (!path) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (sscanf(buffer, "%u %s", &ctl, path) != 2) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (ctl < 1 || ctl > 7) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	if (!work) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	init_task_work(&work->task_work, drop_fs_caches);
+	if (!path)
+		work->dev = MKDEV(major, minor);
+	work->path = path;
+	work->ctl = ctl;
+	ret = task_work_add(current, &work->task_work, TWA_RESUME);
+out:
+	if (ret) {
+		kfree(path);
+		kfree(work);
+	}
+
+	return ret;
+}
+
 static const struct ctl_table drop_caches_table[] = {
 	{
 		.procname	= "drop_caches",
@@ -88,6 +210,11 @@ static const struct ctl_table drop_caches_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_FOUR,
 	},
+	{
+		.procname	= "drop_fs_caches",
+		.mode		= 0200,
+		.proc_handler	= drop_fs_caches_sysctl_handler,
+	},
 };
 
 static int __init init_vm_drop_caches_sysctls(void)
-- 
2.34.1


