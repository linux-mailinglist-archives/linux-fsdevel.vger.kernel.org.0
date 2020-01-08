Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680F5134715
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgAHQE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 11:04:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40307 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgAHQE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:04:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so1788819pgt.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mf24uDxaxrXyVR4iCc3eAN/jtu0xKe1ZH34Ft0DWACg=;
        b=UFK59NqJPTz8BoeQ77BfQ+g5LONu/dr6l0d0g52YSUrbiG6xRjko26oVDtEVsHPsD0
         sLsL5G/iP4iOGBCIeED9AwBiw9ntPiCBdbdcF9mDcRgt0W8fUJ+1MGHknNRkRcyGnGOa
         zQhZWUf4Wk7/i0RParuvUd+yMRMpHZniPBCS4iRGlfp0RACYKB3W+dJ3BR1ITnuZncL6
         YE8WEeeW4P2NX933EJbqhtiqYtUCxXCP6d7ZUEiCDx5TAJcdZaHvlrfQ6/pbtfrPdNJ4
         FVY0UhBCq0sf6biYqyWxXcbdST4mQyfOA7ssO8xVkdkPujOo8D5/SQEkPG2woll6nrJL
         YGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mf24uDxaxrXyVR4iCc3eAN/jtu0xKe1ZH34Ft0DWACg=;
        b=aeJpImLk0A/NnGSH0UVt34raqGcDdoSZrE5Nmy8Cqr+oizUAp+Kyp/jtsG+lJTKKI/
         b4liGK6PBCsNLtynNMCS/UN3Na30XmoaNAJ0DZKb/2oWDgWuukRCL1vTU4G4kZurQueK
         NTAWiZFmDVf3x3G+pSKwW8Kyd8TLL0EvUUUyOBfSKb+0T64DfvUdtyn0du49Mw6M+6Lf
         GbP7xnTA4szkN2pEjIEUveBZqL8DANNEni+yWmHWSgAuuyFO7q54UJKcv6kx8pbuiFT+
         i1a4lGbS8gBIKVAj8Zea3qGOpgZsQi8rvQUsD7p2mC6nqDqHvuhQdlyv9AgTYSsVdYsT
         R8mQ==
X-Gm-Message-State: APjAAAW0BvI1ksCj6wCv6wF1g54Y+rgAK6NHijKtKp1tTN8822zZCQ4i
        wfSn5aVnOCAff6T3KPordkc=
X-Google-Smtp-Source: APXvYqzpzaMo2o2yXGVPMqVWd7zOMF6/eFu/cnrHQ2glwGA4Vc7bHzW2fKgoLF43tcgijlEb5spNiA==
X-Received: by 2002:a62:cdcb:: with SMTP id o194mr5659462pfg.117.1578499467505;
        Wed, 08 Jan 2020 08:04:27 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id d22sm4079894pfo.187.2020.01.08.08.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:04:26 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 3/3] memcg, inode: protect page cache from freeing inode
Date:   Wed,  8 Jan 2020 11:03:57 -0500
Message-Id: <1578499437-1664-4-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
References: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
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

Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/inode.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2b0f511..80dddbc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -54,6 +54,12 @@
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
@@ -713,6 +719,61 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
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
+	unsigned long cgroup_size;
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
+	cgroup_size = mem_cgroup_size(memcg);
+	if (inode->i_data.nrpages + protection >= cgroup_size)
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
@@ -731,8 +792,9 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
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
@@ -741,6 +803,11 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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
@@ -798,9 +865,14 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
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

