Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC80F169708
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 10:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBWJcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 04:32:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38297 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:32:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so2750961plj.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 01:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UPCguODQNHlafe6Q1lmQMxoxQpO6G2fyl/mROhgUGYE=;
        b=IISaJv5V/UKla+SEV1G+kAQgN76/AXuT7oFueJr0W5wOG0eAVr2UyRR/E8cie/iGsx
         YN2PEOLDHRSAsv5X9kh8Xy1GpjRwwW6KKKRWoZ+zs0aFirAKj0s0ML+coU/QNBRDT1j9
         1F0PjQywKjQbL4GNulxMxHwZDatmkW3Y5fj7JT5U23cwqLpHZqoX9x3hX5JhhiTEmI9n
         BciESIc9pCxOiZdv9jVxcQqf1WDB+o2ajeldvw7txXopjsGm959bGrNpps2ecX8X9BIV
         o+PQV98f+Kt0VVuwNbTEQ0zcYYP4bnFfNG7m5FQ5VSVgyXurMZceZI9WmV0X/FYWdA+b
         Kizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UPCguODQNHlafe6Q1lmQMxoxQpO6G2fyl/mROhgUGYE=;
        b=TGlf5ROWsgMtNj/0N7zuIirdyqrStiUbl1V+USj4vVj5bIgwFHGdPQ1IYUX1nB5haT
         TUG58wvgOG2vVYsQnSaOHfdEEWRZrNkWgxOX7oEf50TyhmBkiSJX1WbqyY066YyD5EjW
         knDgNeax4Yhx/yGuta0iOdYobazzDQrSzdQYD0WdcgKHMoCTgsbKzbAScwcw2zH+gJvv
         XwiRGzo2kbphCWsdnAYaiYt0ABHvLv/uA/cw2kBBCv+sPaF3iOMYazsZV1FUtm23GIWC
         KCD6PmNRkG6icTVcm0stYb5va5YzpRkFcrQ6PM71L94MlSJb4lAs2SsJFAA05pWUvD/5
         8x4A==
X-Gm-Message-State: APjAAAVe0vlAGoUhK2uDCCTQaqnmqiE5t7facJYb8xCkdmaJqK302H33
        hIiGteKpjbw+kqoNTyMvcR8=
X-Google-Smtp-Source: APXvYqz7xMZz6ALe2Ma9WgplkMwhuaaRnU6/TRKfjbD9wssoNU8DPB1T/EsDFmWaSf9rCFRZW0peHA==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr45076125plo.12.1582450331351;
        Sun, 23 Feb 2020 01:32:11 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id t19sm8346011pgg.23.2020.02.23.01.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 01:32:10 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 3/3] inode: protect page cache from freeing inode
Date:   Sun, 23 Feb 2020 04:31:34 -0500
Message-Id: <1582450294-18038-4-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582450294-18038-1-git-send-email-laoar.shao@gmail.com>
References: <1582450294-18038-1-git-send-email-laoar.shao@gmail.com>
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
 fs/inode.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 7d57068..6373cd0 100644
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
@@ -714,6 +720,59 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
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
+	if (inode->i_data.nrpages)
+		reclaimable = false;
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
@@ -732,8 +791,9 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
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
@@ -742,6 +802,11 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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
@@ -799,9 +864,14 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
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
Yafang Shao

