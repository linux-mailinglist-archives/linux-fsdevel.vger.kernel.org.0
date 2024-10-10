Return-Path: <linux-fsdevel+bounces-31536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E114998485
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E598E285425
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839811C2457;
	Thu, 10 Oct 2024 11:11:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292631C2327;
	Thu, 10 Oct 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558676; cv=none; b=MJ3toSupDgTDbknQbXbVrMPXUEhPam2skK3L8SlKUW/wZmQIj3R/gE+sYxlh99WSOjB1cC0qP/aT8jEhVTMkmhYhfclc3Rp3HN1WDgXv5eT4wlBfkmh3bByvogJ2SpTt7YPWFxOMbNLlVld1wLvWg8P6ReNgm6VdjgiyNa1Fjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558676; c=relaxed/simple;
	bh=LPBP+ydfXLjg4zx4fQ4vMwAgrFq3BvdyOwsW/lolDYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7QelYEaSTS2NHI5HnQUNf/xBuxM62bYf6W7l56jrimdquGKdd/iG/jbPfzL2MbVs/Ur7nO3ZaVMg6eiryUeZqjSjCG+IQxM9Q4oUDmTGuQ0i9U3ctvgC4w16uT2I/uWtE49lewOdGX5ihr5Jqpvjtj7cYYFGRQBkggP2tnDZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XPRrY6P8fz4f3jXK;
	Thu, 10 Oct 2024 19:10:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BFCB31A058E;
	Thu, 10 Oct 2024 19:11:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sZMtgdnmHXPDg--.37048S5;
	Thu, 10 Oct 2024 19:11:10 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 1/3] vfs: introduce shrink_icache_sb() helper
Date: Thu, 10 Oct 2024 19:25:41 +0800
Message-Id: <20241010112543.1609648-2-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDH+sZMtgdnmHXPDg--.37048S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrXFWrJr18CFykXw1xGrg_yoW8AFWUpF
	Z7JryfGr4rZ34q93savF1v934SqF4vvFWDGFy8Wa4Yywn8tryYqFn7tr13AFyFyFW8W39I
	vF4jkryUur48ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU7qjgUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

This patch is prepare for support drop_caches for specify file system.
shrink_icache_sb() helper walk the superblock inode LRU for freeable inodes
and attempt to free them.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/inode.c    | 17 +++++++++++++++++
 fs/internal.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 1939f711d2c9..2129b48571b4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1045,6 +1045,23 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 	return freed;
 }
 
+/*
+ * Walk the superblock inode LRU for freeable inodes and attempt to free them.
+ * Inodes to be freed are moved to a temporary list and then are freed outside
+ * inode_lock by dispose_list().
+ */
+void shrink_icache_sb(struct super_block *sb)
+{
+	do {
+		LIST_HEAD(dispose);
+
+		list_lru_walk(&sb->s_inode_lru, inode_lru_isolate,
+			      &dispose, 1024);
+		dispose_list(&dispose);
+	} while (list_lru_count(&sb->s_inode_lru) > 0);
+}
+EXPORT_SYMBOL(shrink_icache_sb);
+
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
 /*
  * Called with the inode lock held.
diff --git a/fs/internal.h b/fs/internal.h
index 81c7a085355c..cee79141e308 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -199,6 +199,7 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
+extern void shrink_icache_sb(struct super_block *sb);
 int dentry_needs_remove_privs(struct mnt_idmap *, struct dentry *dentry);
 bool in_group_or_capable(struct mnt_idmap *idmap,
 			 const struct inode *inode, vfsgid_t vfsgid);
-- 
2.31.1


