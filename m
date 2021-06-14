Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD5C3A711C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhFNVVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhFNVV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:21:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD36DC0617AF
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 14:19:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t9so9704905qtw.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcD57FtNiWWrNimGrimqF/td7GBZ9gYAGkV/5ivnuQo=;
        b=QKRPAgQhM9SUJn2ILF83S8tR3b5HRzWek6zKuhYZsa42SpQMDIvDh7tiWzw0gnDIb0
         on+8jWjW6+zeQFL+9zFsNDlO16NfOLlR8AGqc5P71prto0IvIS6HzMa3lQbddejj9nS6
         Knkp1qSmpQd//eJ1TOe36iMX4b4dHJpynKFXV0FN7DWm5jL5iPNWIBSWBaN4GNVe4pzW
         vz98Ufg1VhJ6PlD/etx37Dc4tAnkj0GCvaqvDrkrf1VpFjqCQMF1tGh+bLw3umyG4+wj
         mxUPpmcP+9H/1ahep+qwu18iKtRLQIllIeZaABt4Am8MIH5lh+FzrAzqLnDl8lG0aab8
         M0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcD57FtNiWWrNimGrimqF/td7GBZ9gYAGkV/5ivnuQo=;
        b=Y2x2Y3OkCWMdlzEDsKfiYEoZ+ihnzjWkJ36WQknBrBsBqDR4NPAu+h75qJvqljv/Va
         CQfQ+mFBI1Vps8HuXmgZgJJl3QQe8BwLrrNZSrxSHJI49/scznOEc45tfwuvWziEq0Ti
         EIoks7lXzOwSa4i8f357MufTxHyNt/v3XKfUdrd3XAK8ilDr+2CovFW+gZP7jim7YAKU
         TvOcsAYqya88tKBco8Gim1pBrj8ucU2pgChnkSeMsz7xvQVVqmvoJSvJhJJ0+PVOUVaL
         jNZsgaAt3WUb+LQ4+Tr43HXQJtUU6OCG/kg+4BYwa8ju3I8WpmGTpKkT7+cC0O+scFPv
         X0DQ==
X-Gm-Message-State: AOAM532lz7H3UO0jhwBfAGQP9/fe6Vmmm2IL8Bj2FRRoKMVGwD25UymW
        A8jrvUPzhK5lTR1TmA9qfwtlhg==
X-Google-Smtp-Source: ABdhPJwzrRrY2GPbYHtXtlQCHq58Du7ysF5zlWkgtjH22uYcEOuDKyojOhKRZpsNm2uJdI9Be4JxQg==
X-Received: by 2002:aed:204c:: with SMTP id 70mr18858717qta.260.1623705549819;
        Mon, 14 Jun 2021 14:19:09 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 5sm8326659qkj.99.2021.06.14.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:19:09 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] vfs: keep inodes with page cache off the inode shrinker LRU
Date:   Mon, 14 Jun 2021 17:19:04 -0400
Message-Id: <20210614211904.14420-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614211904.14420-1-hannes@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Historically (pre-2.5), the inode shrinker used to reclaim only empty
inodes and skip over those that still contained page cache. This
caused problems on highmem hosts: struct inode could put fill lowmem
zones before the cache was getting reclaimed in the highmem zones.

To address this, the inode shrinker started to strip page cache to
facilitate reclaiming lowmem. However, this comes with its own set of
problems: the shrinkers may drop actively used page cache just because
the inodes are not currently open or dirty - think working with a
large git tree. It further doesn't respect cgroup memory protection
settings and can cause priority inversions between containers.

Nowadays, the page cache also holds non-resident info for evicted
cache pages in order to detect refaults. We've come to rely heavily on
this data inside reclaim for protecting the cache workingset and
driving swap behavior. We also use it to quantify and report workload
health through psi. The latter in turn is used for fleet health
monitoring, as well as driving automated memory sizing of workloads
and containers, proactive reclaim and memory offloading schemes.

The consequences of dropping page cache prematurely is that we're
seeing subtle and not-so-subtle failures in all of the above-mentioned
scenarios, with the workload generally entering unexpected thrashing
states while losing the ability to reliably detect it.

To fix this on non-highmem systems at least, going back to rotating
inodes on the LRU isn't feasible. We've tried (commit a76cf1a474d7
("mm: don't reclaim inodes with many attached pages")) and failed
(commit 69056ee6a8a3 ("Revert "mm: don't reclaim inodes with many
attached pages"")). The issue is mostly that shrinker pools attract
pressure based on their size, and when objects get skipped the
shrinkers remember this as deferred reclaim work. This accumulates
excessive pressure on the remaining inodes, and we can quickly eat
into heavily used ones, or dirty ones that require IO to reclaim, when
there potentially is plenty of cold, clean cache around still.

Instead, this patch keeps populated inodes off the inode LRU in the
first place - just like an open file or dirty state would. An
otherwise clean and unused inode then gets queued when the last cache
entry disappears. This solves the problem without reintroducing the
reclaim issues, and generally is a bit more scalable than having to
wade through potentially hundreds of thousands of busy inodes.

Locking is a bit tricky because the locks protecting the inode state
(i_lock) and the inode LRU (lru_list.lock) don't nest inside the
irq-safe page cache lock (i_pages.xa_lock). Page cache deletions are
serialized through i_lock, taken before the i_pages lock, to make sure
depopulated inodes are queued reliably. Additions may race with
deletions, but we'll check again in the shrinker. If additions race
with the shrinker itself, we're protected by the i_lock: if
find_inode() or iput() win, the shrinker will bail on the elevated
i_count or I_REFERENCED; if the shrinker wins and goes ahead with the
inode, it will set I_FREEING and inhibit further igets(), which will
cause the other side to create a new instance of the inode instead.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/inode.c              | 46 +++++++++++++++++++++----------------
 fs/internal.h           |  1 -
 include/linux/fs.h      |  1 +
 include/linux/pagemap.h | 50 +++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c            |  8 +++++++
 mm/truncate.c           | 19 ++++++++++++++--
 mm/vmscan.c             |  7 ++++++
 mm/workingset.c         | 10 +++++++++
 8 files changed, 120 insertions(+), 22 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8830a727b0af..6b74701c1954 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -424,11 +424,20 @@ void ihold(struct inode *inode)
 }
 EXPORT_SYMBOL(ihold);
 
-static void inode_lru_list_add(struct inode *inode)
+static void __inode_add_lru(struct inode *inode, bool rotate)
 {
+	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
+		return;
+	if (atomic_read(&inode->i_count))
+		return;
+	if (!(inode->i_sb->s_flags & SB_ACTIVE))
+		return;
+	if (!mapping_shrinkable(&inode->i_data))
+		return;
+
 	if (list_lru_add(&inode->i_sb->s_inode_lru, &inode->i_lru))
 		this_cpu_inc(nr_unused);
-	else
+	else if (rotate)
 		inode->i_state |= I_REFERENCED;
 }
 
@@ -439,16 +448,11 @@ static void inode_lru_list_add(struct inode *inode)
  */
 void inode_add_lru(struct inode *inode)
 {
-	if (!(inode->i_state & (I_DIRTY_ALL | I_SYNC |
-				I_FREEING | I_WILL_FREE)) &&
-	    !atomic_read(&inode->i_count) && inode->i_sb->s_flags & SB_ACTIVE)
-		inode_lru_list_add(inode);
+	__inode_add_lru(inode, false);
 }
 
-
 static void inode_lru_list_del(struct inode *inode)
 {
-
 	if (list_lru_del(&inode->i_sb->s_inode_lru, &inode->i_lru))
 		this_cpu_dec(nr_unused);
 }
@@ -724,10 +728,6 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
  *
- * Any inodes which are pinned purely because of attached pagecache have their
- * pagecache removed.  If the inode has metadata buffers attached to
- * mapping->private_list then try to remove them.
- *
  * If the inode has the I_REFERENCED flag set, then it means that it has been
  * used recently - the flag is set in iput_final(). When we encounter such an
  * inode, clear the flag and move it to the back of the LRU so it gets another
@@ -743,31 +743,39 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	struct inode	*inode = container_of(item, struct inode, i_lru);
 
 	/*
-	 * we are inverting the lru lock/inode->i_lock here, so use a trylock.
-	 * If we fail to get the lock, just skip it.
+	 * We are inverting the lru lock/inode->i_lock here, so use a
+	 * trylock. If we fail to get the lock, just skip it.
 	 */
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;
 
 	/*
-	 * Referenced or dirty inodes are still in use. Give them another pass
-	 * through the LRU as we canot reclaim them now.
+	 * Inodes can get referenced, redirtied, or repopulated while
+	 * they're already on the LRU, and this can make them
+	 * unreclaimable for a while. Remove them lazily here; iput,
+	 * sync, or the last page cache deletion will requeue them.
 	 */
 	if (atomic_read(&inode->i_count) ||
-	    (inode->i_state & ~I_REFERENCED)) {
+	    (inode->i_state & ~I_REFERENCED) ||
+	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
 		spin_unlock(&inode->i_lock);
 		this_cpu_dec(nr_unused);
 		return LRU_REMOVED;
 	}
 
-	/* recently referenced inodes get one more pass */
+	/* Recently referenced inodes get one more pass */
 	if (inode->i_state & I_REFERENCED) {
 		inode->i_state &= ~I_REFERENCED;
 		spin_unlock(&inode->i_lock);
 		return LRU_ROTATE;
 	}
 
+	/*
+	 * On highmem systems, mapping_shrinkable() permits dropping
+	 * page cache in order to free up struct inodes: lowmem might
+	 * be under pressure before the cache inside the highmem zone.
+	 */
 	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
@@ -1634,7 +1642,7 @@ static void iput_final(struct inode *inode)
 	if (!drop &&
 	    !(inode->i_state & I_DONTCACHE) &&
 	    (sb->s_flags & SB_ACTIVE)) {
-		inode_add_lru(inode);
+		__inode_add_lru(inode, true);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
diff --git a/fs/internal.h b/fs/internal.h
index 6aeae7ef3380..3eb90dde62bd 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -146,7 +146,6 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
-extern void inode_add_lru(struct inode *inode);
 extern int dentry_needs_remove_privs(struct dentry *dentry);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8652ed7cdce8..301cd0195036 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3214,6 +3214,7 @@ static inline void remove_inode_hash(struct inode *inode)
 }
 
 extern void inode_sb_list_add(struct inode *inode);
+extern void inode_add_lru(struct inode *inode);
 
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e89df447fae3..c9956fac640e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -23,6 +23,56 @@ static inline bool mapping_empty(struct address_space *mapping)
 	return xa_empty(&mapping->i_pages);
 }
 
+/*
+ * mapping_shrinkable - test if page cache state allows inode reclaim
+ * @mapping: the page cache mapping
+ *
+ * This checks the mapping's cache state for the pupose of inode
+ * reclaim and LRU management.
+ *
+ * The caller is expected to hold the i_lock, but is not required to
+ * hold the i_pages lock, which usually protects cache state. That's
+ * because the i_lock and the list_lru lock that protect the inode and
+ * its LRU state don't nest inside the irq-safe i_pages lock.
+ *
+ * Cache deletions are performed under the i_lock, which ensures that
+ * when an inode goes empty, it will reliably get queued on the LRU.
+ *
+ * Cache additions do not acquire the i_lock and may race with this
+ * check, in which case we'll report the inode as shrinkable when it
+ * has cache pages. This is okay: the shrinker also checks the
+ * refcount and the referenced bit, which will be elevated or set in
+ * the process of adding new cache pages to an inode.
+ */
+static inline bool mapping_shrinkable(struct address_space *mapping)
+{
+	void *head;
+
+	/*
+	 * On highmem systems, there could be lowmem pressure from the
+	 * inodes before there is highmem pressure from the page
+	 * cache. Make inodes shrinkable regardless of cache state.
+	 */
+	if (IS_ENABLED(CONFIG_HIGHMEM))
+		return true;
+
+	/* Cache completely empty? Shrink away. */
+	head = rcu_access_pointer(mapping->i_pages.xa_head);
+	if (!head)
+		return true;
+
+	/*
+	 * The xarray stores single offset-0 entries directly in the
+	 * head pointer, which allows non-resident page cache entries
+	 * to escape the shadow shrinker's list of xarray nodes. The
+	 * inode shrinker needs to pick them up under memory pressure.
+	 */
+	if (!xa_is_node(head) && xa_is_value(head))
+		return true;
+
+	return false;
+}
+
 /*
  * Bits in mapping->flags.
  */
diff --git a/mm/filemap.c b/mm/filemap.c
index 819d2589abef..0d0d72ced961 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -260,9 +260,13 @@ void delete_from_page_cache(struct page *page)
 	struct address_space *mapping = page_mapping(page);
 
 	BUG_ON(!PageLocked(page));
+	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	__delete_from_page_cache(page, NULL);
 	xa_unlock_irq(&mapping->i_pages);
+	if (mapping_shrinkable(mapping))
+		inode_add_lru(mapping->host);
+	spin_unlock(&mapping->host->i_lock);
 
 	page_cache_free_page(mapping, page);
 }
@@ -338,6 +342,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	if (!pagevec_count(pvec))
 		return;
 
+	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		trace_mm_filemap_delete_from_page_cache(pvec->pages[i]);
@@ -346,6 +351,9 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	}
 	page_cache_delete_batch(mapping, pvec);
 	xa_unlock_irq(&mapping->i_pages);
+	if (mapping_shrinkable(mapping))
+		inode_add_lru(mapping->host);
+	spin_unlock(&mapping->host->i_lock);
 
 	for (i = 0; i < pagevec_count(pvec); i++)
 		page_cache_free_page(mapping, pvec->pages[i]);
diff --git a/mm/truncate.c b/mm/truncate.c
index 95934c98259a..950d73fa995d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -45,9 +45,13 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
 static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
 			       void *entry)
 {
+	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	__clear_shadow_entry(mapping, index, entry);
 	xa_unlock_irq(&mapping->i_pages);
+	if (mapping_shrinkable(mapping))
+		inode_add_lru(mapping->host);
+	spin_unlock(&mapping->host->i_lock);
 }
 
 /*
@@ -73,8 +77,10 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		return;
 
 	dax = dax_mapping(mapping);
-	if (!dax)
+	if (!dax) {
+		spin_lock(&mapping->host->i_lock);
 		xa_lock_irq(&mapping->i_pages);
+	}
 
 	for (i = j; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
@@ -93,8 +99,12 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		__clear_shadow_entry(mapping, index, page);
 	}
 
-	if (!dax)
+	if (!dax) {
 		xa_unlock_irq(&mapping->i_pages);
+		if (mapping_shrinkable(mapping))
+			inode_add_lru(mapping->host);
+		spin_unlock(&mapping->host->i_lock);
+	}
 	pvec->nr = j;
 }
 
@@ -569,6 +579,7 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	if (page_has_private(page) && !try_to_release_page(page, GFP_KERNEL))
 		return 0;
 
+	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	if (PageDirty(page))
 		goto failed;
@@ -576,6 +587,9 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	BUG_ON(page_has_private(page));
 	__delete_from_page_cache(page, NULL);
 	xa_unlock_irq(&mapping->i_pages);
+	if (mapping_shrinkable(mapping))
+		inode_add_lru(mapping->host);
+	spin_unlock(&mapping->host->i_lock);
 
 	if (mapping->a_ops->freepage)
 		mapping->a_ops->freepage(page);
@@ -584,6 +598,7 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	return 1;
 failed:
 	xa_unlock_irq(&mapping->i_pages);
+	spin_unlock(&mapping->host->i_lock);
 	return 0;
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cc5d7cd75935..6dd5ef8a11bc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1055,6 +1055,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	BUG_ON(!PageLocked(page));
 	BUG_ON(mapping != page_mapping(page));
 
+	if (!PageSwapCache(page))
+		spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	/*
 	 * The non racy check for a busy page.
@@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 			shadow = workingset_eviction(page, target_memcg);
 		__delete_from_page_cache(page, shadow);
 		xa_unlock_irq(&mapping->i_pages);
+		if (mapping_shrinkable(mapping))
+			inode_add_lru(mapping->host);
+		spin_unlock(&mapping->host->i_lock);
 
 		if (freepage != NULL)
 			freepage(page);
@@ -1132,6 +1137,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 
 cannot_free:
 	xa_unlock_irq(&mapping->i_pages);
+	if (!PageSwapCache(page))
+		spin_unlock(&mapping->host->i_lock);
 	return 0;
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 4f7a306ce75a..9d3d2b4ce44d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -540,6 +540,13 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 		goto out;
 	}
 
+	if (!spin_trylock(&mapping->host->i_lock)) {
+		xa_unlock(&mapping->i_pages);
+		spin_unlock_irq(lru_lock);
+		ret = LRU_RETRY;
+		goto out;
+	}
+
 	list_lru_isolate(lru, item);
 	__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
 
@@ -559,6 +566,9 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 
 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
+	if (mapping_shrinkable(mapping))
+		inode_add_lru(mapping->host);
+	spin_unlock(&mapping->host->i_lock);
 	ret = LRU_REMOVED_RETRY;
 out:
 	cond_resched();
-- 
2.32.0

