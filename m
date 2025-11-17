Return-Path: <linux-fsdevel+bounces-68713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C338C63D2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D923A7C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC62317715;
	Mon, 17 Nov 2025 11:27:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34397283FF9;
	Mon, 17 Nov 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378863; cv=none; b=ZXiU2CfL5Ofnn0ktoXgbRxlFctaS2TMsZ6WSxE8u5kMcZSEO7NUX5W3MGlbSuR13fs9XepHGUZQlFlqB3izRcGCNXoZmmojNd9bZCO6PlhKEIJ1LZqz5p2eYVM4vQcne6dAM3YnKRKuiRzQdm4ZQ+NqjUXbN6VGDidbbnQy02D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378863; c=relaxed/simple;
	bh=gVvg6hoLyn0AInBUZ0oAVJ9blU4F73ffRYT3FOiI4pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucYAd59I0fJMpcsVH35Dk1bozaRtrS+qGf29kyM9DqGvYDRFxwGFZBvo9wtBlcOG3W7ZQ/LWV5zUZ5Zl6P+rCI9EUepjiq5uw7gPYdBYhLY3nwCaHfkDdaxBNewIMTz6D5kL9BmfpfV0jjn9p6aCcyePm+ZdVeybSOajDnb6304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d957P58Z3zKHMf3;
	Mon, 17 Nov 2025 19:27:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BF8121A0838;
	Mon, 17 Nov 2025 19:27:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXunBhtp39Q6BA--.30165S5;
	Mon, 17 Nov 2025 19:27:38 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com
Subject: [PATCH v2 1/3] vfs: introduce reclaim_icache_sb() and reclaim_dcache_sb() helper
Date: Mon, 17 Nov 2025 19:27:33 +0800
Message-Id: <20251117112735.4170831-2-yebin@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAnhXunBhtp39Q6BA--.30165S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1fWrWrXF15Zw48Xw4fXwb_yoW5KF1UpF
	ZrAr1rGrW8Z34fWwnayr4kua4SvrWkWF4kt3yfGa4YywnxtryaqFnFyryUAryrArWxWa9I
	vF4YgFyUuF18ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU773kDUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

This patch is prepare for support drop_caches for specify file system.
reclaim_icache_sb()/reclaim_dcache_sb() helper walk the superblock
inode/dentry LRU for freeable inodes/dentrys and attempt to free them.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/dcache.c            | 22 ++++++++++++++++++++++
 fs/inode.c             | 21 +++++++++++++++++++++
 fs/internal.h          |  1 +
 include/linux/dcache.h |  1 +
 4 files changed, 45 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index de3e4e9777ea..d1b29b0f9062 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1263,6 +1263,28 @@ void shrink_dcache_sb(struct super_block *sb)
 }
 EXPORT_SYMBOL(shrink_dcache_sb);
 
+/**
+ * reclaim_dcache_sb - reclaim dcache for a superblock
+ * @sb: superblock
+ *
+ * Reclaim the dcache for the specified super block. This is used to free
+ * the dcache via sysctl 'drop_fs_caches'.
+ */
+void reclaim_dcache_sb(struct super_block *sb)
+{
+	unsigned long count = list_lru_count(&sb->s_dentry_lru);
+
+	while (count > 0) {
+		LIST_HEAD(dispose);
+		unsigned long nr_to_walk = count >= 1024 ? 1024 : count;
+
+		count -= nr_to_walk;
+		list_lru_walk(&sb->s_dentry_lru, dentry_lru_isolate, &dispose,
+			      nr_to_walk);
+		shrink_dentry_list(&dispose);
+	}
+}
+
 /**
  * enum d_walk_ret - action to talke during tree walk
  * @D_WALK_CONTINUE:	contrinue walk
diff --git a/fs/inode.c b/fs/inode.c
index 7901c2896d78..325de5a51955 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1073,6 +1073,27 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 	return freed;
 }
 
+/*
+ * Walk the superblock inode LRU for freeable inodes and attempt to free them.
+ * Inodes to be freed are moved to a temporary list and then are freed outside
+ * inode_lock by dispose_list(). This is used to free the icache via sysctl
+ * 'drop_fs_caches'.
+ */
+void reclaim_icache_sb(struct super_block *sb)
+{
+	unsigned long count = list_lru_count(&sb->s_inode_lru);
+
+	while (count > 0) {
+		LIST_HEAD(dispose);
+		unsigned long nr_to_walk = count >= 1024 ? 1024 : count;
+
+		count -= nr_to_walk;
+		list_lru_walk(&sb->s_inode_lru, inode_lru_isolate, &dispose,
+			      nr_to_walk);
+		dispose_list(&dispose);
+	}
+}
+
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
 /*
  * Called with the inode lock held.
diff --git a/fs/internal.h b/fs/internal.h
index 9b2b4d116880..8d3101232fb4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -204,6 +204,7 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
+extern void reclaim_icache_sb(struct super_block *sb);
 int dentry_needs_remove_privs(struct mnt_idmap *, struct dentry *dentry);
 bool in_group_or_capable(struct mnt_idmap *idmap,
 			 const struct inode *inode, vfsgid_t vfsgid);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c83e02b94389..fed46f694f54 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -257,6 +257,7 @@ extern struct dentry *d_find_any_alias(struct inode *inode);
 extern struct dentry * d_obtain_alias(struct inode *);
 extern struct dentry * d_obtain_root(struct inode *);
 extern void shrink_dcache_sb(struct super_block *);
+extern void reclaim_dcache_sb(struct super_block *sb);
 extern void shrink_dcache_parent(struct dentry *);
 extern void d_invalidate(struct dentry *);
 
-- 
2.34.1


