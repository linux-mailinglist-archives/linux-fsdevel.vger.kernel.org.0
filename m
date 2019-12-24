Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E9129EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 08:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLXHzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 02:55:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45771 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfLXHzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:55:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so8170657pls.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 23:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kZ3OMcMXwx7R/y0P55Kf7rXfdQYQYitdi49ZafohpU8=;
        b=M4vEKx3wrrHwrHAxdlTcjzq22bDDXAAhjs9OdAGn5eeqZtFHHJEiH2RenGeIweDvnt
         a8jq2l9fVB5PQ/T5ATnsfVZZaHep6aTV+1HfJNEpBUEwWDAWgjXqgpm3YX6ouPYOfEFi
         W+sBJVOjgBHaefVmRraRA52SA+gTUGJDbgr0Zrq3PWMB0S9GMgtP6eRn3d9gn5Cs33jW
         DPYJLkYm+cj+wLGzPt/7dirhzudrVCN2fkTwHl33MlJXXzI1TcgcVtufRlFEtoghNb7E
         jSATInsJOHEIAoMGD1SSjDgTP9nHPbl4WBfiAaTPig1DXFnfg3cUeaknHcgB8Qo5VvlS
         VM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kZ3OMcMXwx7R/y0P55Kf7rXfdQYQYitdi49ZafohpU8=;
        b=rQty4ksllSCZIglsAz2F/anYhvJRS5WMI5adbWR0UOoMBXBx0XyMfHwmAi66x1KdgG
         PjdtMIRMg3XEccSkeJZhp2VAL1EN5XuePsqn+X603R1uJsEmxG4C3MkuvuJC4Z6biDF4
         5LMdMfIs1MJ+WoRly2OUzJJtBJsSv8yNwDhl2ZWgrL2zl+rxTLgbVm9tIZdolXPAS/Yc
         OcN9D/GdhxWSx1kK5FtyvDlc4CgwsrQBxIphgsnDuxprGfjo7YTeLawDQrQCWDPtekFs
         mJIFqV3CssGpMJ7yC6brGeIydrLceZniRY8iSjT6rVSIkdwFNC9NxwACuKl0dpz9C2//
         cbxg==
X-Gm-Message-State: APjAAAXSt7Wz5g7v3sVYMHOFkYsurKgpU8Zb895BtdzifOxtXaN8xF1B
        nHmLm/rMc9+3nU9TFgbcouM=
X-Google-Smtp-Source: APXvYqyHpzRKeidKJFiCUXzcUbXAqifMuaaaaknwdZo6Y+QXCqEurYZ93Agk2WD8yfSYA+6iGUqcjQ==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr4383136pjz.116.1577174130816;
        Mon, 23 Dec 2019 23:55:30 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c2sm2004064pjq.27.2019.12.23.23.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 23:55:30 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, david@fromorbit.com, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2 5/5] memcg, inode: protect page cache from freeing inode
Date:   Tue, 24 Dec 2019 02:53:26 -0500
Message-Id: <1577174006-13025-6-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On my server there're some running MEMCGs protected by memory.{min, low},
but I found the usage of these MEMCGs abruptly became very small, which
were far less than the protect limit. It confused me and finally I
found that was because of inode stealing.
Once an inode is freed, all its belonging page caches will be dropped as
well, no matter how may page caches it has. So if we intend to protect the
page caches in a memcg, we must protect their host (the inode) first.
Otherwise the memcg protection can be easily bypassed with freeing inode,
especially if there're big files in this memcg.

Supposes we have a memcg, and the stat of this memcg is,
	memory.current = 1024M
	memory.min = 512M
And in this memcg there's a inode with 800M page caches.
Once this memcg is scanned by kswapd or other regular reclaimers,
    kswapd <<<< It can be either of the regular reclaimers.
        shrink_node_memcgs
	    switch (mem_cgroup_protected()) <<<< Not protected
		case MEMCG_PROT_NONE:  <<<< Will scan this memcg
			beak;
            shrink_lruvec() <<<< Reclaim the page caches
            shrink_slab()   <<<< It may free this inode and drop all its
                                 page caches(800M).
So we must protect the inode first if we want to protect page caches.

The inherent mismatch between memcg and inode is a trouble. One inode can
be shared by different MEMCGs, but it is a very rare case. If an inode is
shared, its belonging page caches may be charged to different MEMCGs.
Currently there's no perfect solution to fix this kind of issue, but the
inode majority-writer ownership switching can help it more or less.

Cc: Roman Gushchin <guro@fb.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/inode.c                 | 25 +++++++++++++++++++++++--
 include/linux/memcontrol.h | 11 ++++++++++-
 mm/memcontrol.c            | 43 +++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |  5 +++++
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index fef457a..4f4b2f3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -54,6 +54,13 @@
  *   inode_hash_lock
  */
 
+struct inode_head {
+	struct list_head *freeable;
+#ifdef CONFIG_MEMCG_KMEM
+	struct mem_cgroup *memcg;
+#endif
+};
+
 static unsigned int i_hash_mask __read_mostly;
 static unsigned int i_hash_shift __read_mostly;
 static struct hlist_head *inode_hashtable __read_mostly;
@@ -724,8 +731,10 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 static enum lru_status inode_lru_isolate(struct list_head *item,
 		struct list_lru_one *lru, spinlock_t *lru_lock, void *arg)
 {
-	struct list_head *freeable = arg;
+	struct inode_head *ihead = (struct inode_head *)arg;
+	struct list_head *freeable = ihead->freeable;
 	struct inode	*inode = container_of(item, struct inode, i_lru);
+	struct mem_cgroup *memcg = NULL;
 
 	/*
 	 * we are inverting the lru lock/inode->i_lock here, so use a trylock.
@@ -734,6 +743,15 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;
 
+#ifdef CONFIG_MEMCG_KMEM
+	memcg = ihead->memcg;
+#endif
+	if (memcg && inode->i_data.nrpages &&
+	    !(memcg_can_reclaim_inode(memcg, inode))) {
+		spin_unlock(&inode->i_lock);
+		return LRU_ROTATE;
+	}
+
 	/*
 	 * Referenced or dirty inodes are still in use. Give them another pass
 	 * through the LRU as we canot reclaim them now.
@@ -789,11 +807,14 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
  */
 long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 {
+	struct inode_head ihead;
 	LIST_HEAD(freeable);
 	long freed;
 
+	ihead.freeable = &freeable;
+	ihead.memcg = sc->memcg;
 	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
-				     inode_lru_isolate, &freeable);
+				     inode_lru_isolate, &ihead);
 	dispose_list(&freeable);
 	return freed;
 }
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f36ada9..d1d4175 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -247,6 +247,9 @@ struct mem_cgroup {
 	unsigned int tcpmem_active : 1;
 	unsigned int tcpmem_pressure : 1;
 
+	/* Soft protection will be ignored if it's true */
+	unsigned int in_low_reclaim : 1;
+
 	int under_oom;
 
 	int	swappiness;
@@ -363,7 +366,7 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg);
-
+bool memcg_can_reclaim_inode(struct mem_cgroup *memcg, struct inode *inode);
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
 			  bool compound);
@@ -865,6 +868,12 @@ static inline enum mem_cgroup_protection mem_cgroup_protected(
 	return MEMCG_PROT_NONE;
 }
 
+static inline bool memcg_can_reclaim_inode(struct mem_cgroup *memcg,
+					   struct inode *memcg)
+{
+	return true;
+}
+
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 					gfp_t gfp_mask,
 					struct mem_cgroup **memcgp,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2fc2bf4..c3498fd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6340,6 +6340,49 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 }
 
 /**
+ * Once an inode is freed, all its belonging page caches will be dropped as
+ * well, even if there're lots of page caches. So if we intend to protect
+ * page caches in a memcg, we must protect their host(the inode) first.
+ * Otherwise the memcg protection can be easily bypassed with freeing inode,
+ * especially if there're big files in this memcg.
+ * Note that it may happen that the page caches are already charged to the
+ * memcg, but the inode hasn't been added to this memcg yet. In this case,
+ * this inode is not protected.
+ * The inherent mismatch between memcg and inode is a trouble. One inode
+ * can be shared by different MEMCGs, but it is a very rare case. If
+ * an inode is shared, its belonging page caches may be charged to
+ * different MEMCGs. Currently there's no perfect solution to fix this
+ * kind of issue, but the inode majority-writer ownership switching can
+ * help it more or less.
+ */
+bool memcg_can_reclaim_inode(struct mem_cgroup *memcg,
+			     struct inode *inode)
+{
+	unsigned long cgroup_size;
+	unsigned long protection;
+	bool reclaimable = true;
+
+	if (memcg == root_mem_cgroup)
+		goto out;
+
+	protection = mem_cgroup_protection(memcg, memcg->in_low_reclaim);
+	if (!protection)
+		goto out;
+
+	/*
+	 * Don't protect this inode if the usage of this memcg is still
+	 * above the protection after reclaiming this inode and all its
+	 * belonging page caches.
+	 */
+	cgroup_size = mem_cgroup_size(memcg);
+	if (inode->i_data.nrpages + protection > cgroup_size)
+		reclaimable = false;
+
+out:
+	return reclaimable;
+}
+
+/**
  * mem_cgroup_try_charge - try charging a page
  * @page: page to charge
  * @mm: mm context of the victim
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3c4c2da..ecc5c1d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2666,6 +2666,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				sc->memcg_low_skipped = 1;
 				continue;
 			}
+
+			memcg->in_low_reclaim = 1;
 			memcg_memory_event(memcg, MEMCG_LOW);
 			break;
 		case MEMCG_PROT_NONE:
@@ -2693,6 +2695,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
 
+		if (memcg->in_low_reclaim)
+			memcg->in_low_reclaim = 0;
+
 		/* Record the group's reclaim efficiency */
 		vmpressure(sc->gfp_mask, memcg, false,
 			   sc->nr_scanned - scanned,
-- 
1.8.3.1

