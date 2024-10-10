Return-Path: <linux-fsdevel+bounces-31540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6599848D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFA61F2464D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24991C460F;
	Thu, 10 Oct 2024 11:11:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920D1BE86F;
	Thu, 10 Oct 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558677; cv=none; b=SCUs/PNFvxfW5L+9sbYf/tqOFuKziSOoRLRsFmK1udUqEFIScWYKyYiXHDFS8m9vELAn7agtKUxjZKo2WJpfMp5s3QUZ9MSh4wTUCWQG8fjLSztqgnDwrqWx55mocipeB/AmPwepaCSXGNW6dJk8fwM4o6nram1yZas3u6KpROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558677; c=relaxed/simple;
	bh=IVBmOojz8e+eSyRyjC458ty1x3vr+17pkAfmkoicGVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSNvxu+erSWnUE6p+UpsBr6ARrPhEeZCpgVxa4OLMJFufiiSrnkBDr/1Ujugck2/6bELGV3HinoHtQLBr+xbMseAfoakovOUZ4iCjcFBFT/FnTsWsIiozulR+d5jiSK8TJdV8OckSkscmJAk0hKeQaKCX8kUWqtIfQlSYF0BvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XPRrZ1ZLBz4f3jXV;
	Thu, 10 Oct 2024 19:10:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1B8EB1A018D;
	Thu, 10 Oct 2024 19:11:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sZMtgdnmHXPDg--.37048S6;
	Thu, 10 Oct 2024 19:11:10 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 2/3] sysctl: add support for drop_caches for individual filesystem
Date: Thu, 10 Oct 2024 19:25:42 +0800
Message-Id: <20241010112543.1609648-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241010112543.1609648-1-yebin@huaweicloud.com>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sZMtgdnmHXPDg--.37048S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1fJryDtry3Gry7ZFykAFb_yoW5CF43pF
	W7ury5KrWruF12qr93CF4IyF4Sv3ykGF17WrZFg34Fyw47Ary0gr1kKryaqFyrtrW7uFW2
	gFWDKr90g3y5XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU89NVDUUUUU==
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
 fs/drop_caches.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h |  2 ++
 kernel/sysctl.c    |  9 +++++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d45ef541d848..99d412cf3e52 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -77,3 +77,46 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 	}
 	return 0;
 }
+
+int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int write,
+				  void *buffer, size_t *length, loff_t *ppos)
+{
+	unsigned int major, minor;
+	unsigned int ctl;
+	struct super_block *sb;
+	static int stfu;
+
+	if (!write)
+		return 0;
+
+	if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) != 3)
+		return -EINVAL;
+
+	if (ctl < *((int *)table->extra1) || ctl > *((int *)table->extra2))
+		return -EINVAL;
+
+	sb = user_get_super(MKDEV(major, minor), false);
+	if (!sb)
+		return -EINVAL;
+
+	if (ctl & 1) {
+		lru_add_drain_all();
+		drop_pagecache_sb(sb, NULL);
+		count_vm_event(DROP_PAGECACHE);
+	}
+
+	if (ctl & 2) {
+		shrink_dcache_sb(sb);
+		shrink_icache_sb(sb);
+		count_vm_event(DROP_SLAB);
+	}
+
+	drop_super(sb);
+
+	if (!stfu)
+		pr_info("%s (%d): drop_fs_caches: %u:%u:%d\n", current->comm,
+			task_pid_nr(current), major, minor, ctl);
+	stfu |= ctl & 4;
+
+	return 0;
+}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 344541f8cba0..43079478296f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3788,6 +3788,8 @@ extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
 extern int sysctl_drop_caches;
 int drop_caches_sysctl_handler(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
+int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int write,
+				  void *buffer, size_t *length, loff_t *ppos);
 #endif
 
 void drop_slab(void);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..d434cbe10e47 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2101,6 +2101,15 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_FOUR,
 	},
+	{
+		.procname	= "drop_fs_caches",
+		.data		= NULL,
+		.maxlen		= 256,
+		.mode		= 0200,
+		.proc_handler	= drop_fs_caches_sysctl_handler,
+		.extra1         = SYSCTL_ONE,
+		.extra2         = SYSCTL_FOUR,
+	},
 	{
 		.procname	= "page_lock_unfairness",
 		.data		= &sysctl_page_lock_unfairness,
-- 
2.31.1


