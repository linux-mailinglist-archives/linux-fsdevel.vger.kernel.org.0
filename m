Return-Path: <linux-fsdevel+bounces-78675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNTwMxgIoWlXpwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:57:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C431B2215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C932C30518C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601FF2FE578;
	Fri, 27 Feb 2026 02:57:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3722FE589
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161041; cv=none; b=nUGYFarbZnEFvwAXubZ8SwAaJmv749OfuUdBWZ5u950oko4vw36WqW/Nq1J7DUps92IhjNKqLehlDISIyWpVO4sQxAGOZPQyCyh7CWn4Av1eByIyJB3EGHCw3d0QH12y+DJH5E3P/oDA1h0qJjQ2ZF1UNkzGgF3yNa1TMARVjrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161041; c=relaxed/simple;
	bh=uAVX1gMhxLNrfo5+MM/WUf2YsfQlJxWqAeG/2+OLr5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOgHwP0UYUtEkN+kPtoIcm0yFTJeT14uetmBPwIHUUTLQHTAnYw4jtmPFbYstH3FHBbaKZQO9A6uZ1kAuq4u6tj9/SRHylTqePXc09GhTY73DDeD2Z7nTOqQZX+QptQhodfHdj74TdTYC9984PAjJYCJhkQK5nACJ9Tb77HbaMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fMXym6Jn9zKHMSp
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:56:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 21FBB4056F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:57:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with SMTP id gCh0CgBXuPgJCKFpsEGdIw--.32070S6;
	Fri, 27 Feb 2026 10:57:14 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	yebin10@huawei.com
Subject: [PATCH v3 2/3] sysctl: add support for drop_caches for individual filesystem
Date: Fri, 27 Feb 2026 10:55:47 +0800
Message-Id: <20260227025548.2252380-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227025548.2252380-1-yebin@huaweicloud.com>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXuPgJCKFpsEGdIw--.32070S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1fJryDtry3Gw1kWF1ftFb_yoWrWw48pF
	Wa9Fy5KrWrAF13tr9xAr4vvF1S93yktw17Kwnru34Ikw1Svr1vq3Z2yryYqF45JrWUurW7
	WF4DKF1DW3yDXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUob18
	DUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78675-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 45C431B2215
X-Rspamd-Action: no action

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
 fs/drop_caches.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..0cd8ad9df07a 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -11,6 +11,8 @@
 #include <linux/sysctl.h>
 #include <linux/gfp.h>
 #include <linux/swap.h>
+#include <linux/task_work.h>
+#include <linux/namei.h>
 #include "internal.h"
 
 /* A global variable is a bit ugly, but it keeps the code simple */
@@ -78,6 +80,124 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
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
+			pr_err("%s (%d): %s: failed to get path(%s) %d\n",
+			       current->comm, task_pid_nr(current),
+			       __func__, work->path, ret);
+			goto out;
+		}
+		dev = path.dentry->d_sb->s_dev;
+		/* Make this file's dentry and inode recyclable */
+		path_put(&path);
+	}
+
+	sb = user_get_super(dev, false);
+	if (!sb) {
+		pr_err("%s (%d): %s: failed to get dev(%u:%u)'s sb\n",
+		       current->comm, task_pid_nr(current), __func__,
+		       MAJOR(dev), MINOR(dev));
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
+		drop_sb_dentry_inode(sb);
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
@@ -88,6 +208,11 @@ static const struct ctl_table drop_caches_table[] = {
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


