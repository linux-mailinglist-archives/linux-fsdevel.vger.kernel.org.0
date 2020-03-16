Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93108186948
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgCPKkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 06:40:45 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53641 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgCPKko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:40:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so8095659pjb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L3eSlYEGbu4PoC6YG4Y6sJy5VuyO654A9z9jaMwfoII=;
        b=U7jolHM3bRjcBPeF4kiQ8Qv4bCZPDeiyy2doENtGgy5ldWAt2Sh715JT8EcVxaAbHk
         et0mFXOJ2tTKBs9DA6+eX0rnjUvNcytq5XOJxDzfpDs1TGdXTAwT87twSqg0ZptuTxcY
         2cpCxGFrCjs+LNtDQbR/hNxqUHd+65sSNGd5lxS5BKsyoph7cuPrMAKjah2SF9XHT88l
         qBUmIW/YwEathMLVvk6vSbBBx9EQQNz+a96dZ+uHp4x0amLEe17H3KyBvgtg/ul28uIz
         Pu7RdNIGr3G8rdCBi870VZCeY+EShDhB8PvNOhbnXEmJeX5m1D9rXkDoBr+ygl0DPCiy
         LzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L3eSlYEGbu4PoC6YG4Y6sJy5VuyO654A9z9jaMwfoII=;
        b=MI7ZEat4Z0hGqg0zCC//CtAszOG23Eo569xoHeGAPkAfC+eVEa4PBYjP/tj30nW9Ih
         a3lIHfL9N7agKYTBY3eORs4L5B+qrNwkc5rHf6sA1epxuBJLhIgnmN+l1TVgBayw+ANS
         /e/9eeO5LQJE8l0VwyJZpP8+/2+8dqAlj+cF1l87oCjh9yoPaIuwgI3TOljnb7BpW946
         Wu3w3MbpTFqEbQvXU7ceBWUICOxcfs4egXgPxZ8a7ejg4WglAmtQcPhmdLoXQT+SwigF
         fhDIYEPkHUY8hlReY6FbGI59yoAfJZVJvA7A/zB9JCheAnBbViD5uwdKsJS6cZHPGqIn
         mGVw==
X-Gm-Message-State: ANhLgQ1aCRasNTr3Z7njuP4ZSZPkDGT9A9oajvrBqAZ39dtL13zLx3Fb
        CNnqcVWT6l6fWHbS6RPmxio=
X-Google-Smtp-Source: ADFU+vsFPfI9KgXUp4a42DVqAeDWUuRxQKl66czJZMnK/JrjUBixHW1pReSK4/A+y/ljHFP6Sj9lnQ==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr25960172plo.233.1584355244072;
        Mon, 16 Mar 2020 03:40:44 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id h2sm19834276pjc.7.2020.03.16.03.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 03:40:43 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 3/3] inode: protect page cache from freeing inode
Date:   Mon, 16 Mar 2020 06:39:58 -0400
Message-Id: <1584355198-10137-4-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584355198-10137-1-git-send-email-laoar.shao@gmail.com>
References: <1584355198-10137-1-git-send-email-laoar.shao@gmail.com>
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
Note that this inode may be a cold inode (in the tail of list lru), because
memcg protection protects all slabs and page cache pages whatever they are
cold or hot. IOW, this is a memcg-protection-specific issue.

The inherent mismatch between memcg and inode is a trouble. One inode can
be shared by different MEMCGs, but it is a very rare case. If an inode is
shared, its belonging page caches may be charged to different MEMCGs.
Currently there's no perfect solution to fix this kind of issue, but the
inode majority-writer ownership switching can help it more or less.

Cc: Dave Chinner <dchinner@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/inode.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 93d9252..f5a9537 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -55,6 +55,12 @@
  *   inode_hash_lock
  */
 
+struct inode_isolate_control {
+	struct list_head *freeable;
+	struct mem_cgroup *memcg;	/* derived from shrink_control */
+	bool memcg_low_reclaim;		/* derived from scan_control */
+};
+
 static unsigned int i_hash_mask __read_mostly;
 static unsigned int i_hash_shift __read_mostly;
 static struct hlist_head *inode_hashtable __read_mostly;
@@ -715,6 +721,58 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 	return busy;
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+/*
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
+static bool memcg_can_reclaim_inode(struct inode *inode,
+				    struct inode_isolate_control *iic)
+{
+	unsigned long protection;
+	struct mem_cgroup *memcg;
+	bool reclaimable = true;
+
+	if (!inode->i_data.nrpages)
+		goto out;
+
+	/* Excludes freeing inode via drop_caches */
+	if (!current->reclaim_state)
+		goto out;
+
+	memcg = iic->memcg;
+	if (!memcg || memcg == root_mem_cgroup)
+		goto out;
+
+	protection = mem_cgroup_protection(memcg, iic->memcg_low_reclaim);
+	if (!protection)
+		goto out;
+
+	reclaimable = false;
+
+out:
+	return reclaimable;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static bool memcg_can_reclaim_inode(struct inode *inode,
+				    struct inode_isolate_control *iic)
+{
+	return true;
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
  *
@@ -733,8 +791,9 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 static enum lru_status inode_lru_isolate(struct list_head *item,
 		struct list_lru_one *lru, spinlock_t *lru_lock, void *arg)
 {
-	struct list_head *freeable = arg;
-	struct inode	*inode = container_of(item, struct inode, i_lru);
+	struct inode_isolate_control *iic = arg;
+	struct list_head *freeable = iic->freeable;
+	struct inode *inode = container_of(item, struct inode, i_lru);
 
 	/*
 	 * we are inverting the lru lock/inode->i_lock here, so use a trylock.
@@ -743,6 +802,11 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;
 
+	if (!memcg_can_reclaim_inode(inode, iic)) {
+		spin_unlock(&inode->i_lock);
+		return LRU_ROTATE;
+	}
+
 	/*
 	 * Referenced or dirty inodes are still in use. Give them another pass
 	 * through the LRU as we canot reclaim them now.
@@ -800,9 +864,14 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 {
 	LIST_HEAD(freeable);
 	long freed;
+	struct inode_isolate_control iic = {
+		.freeable = &freeable,
+		.memcg = sc->memcg,
+		.memcg_low_reclaim = sc->memcg_low_reclaim,
+	};
 
 	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
-				     inode_lru_isolate, &freeable);
+				     inode_lru_isolate, &iic);
 	dispose_list(&freeable);
 	return freed;
 }
-- 
1.8.3.1

