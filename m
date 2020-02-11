Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDBDF15976A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgBKRzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:55:12 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42275 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgBKRzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:55:11 -0500
Received: by mail-qt1-f173.google.com with SMTP id r5so7268657qtt.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 09:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLSKIJjQ1kft1gJ/qKtxM4amgzFG9wE8AKsRtRYht/Y=;
        b=QMTXv/vgPNtb2MsNkUjTpvjjg1Vk4SEu3+RlU0eZE/V16XKXbBPDsGunK62bP9CqiA
         FRLQetK0pQ/VaNSZ87bskQgk0xJZx7Y2V4yYb9wwbjsPmyBMa8fwrAnpphkQ6J6A2/eL
         UjG1G25kYd/OGWKD83MqbgOWEqGiNjq34djuc/4dckvnPTNN/M+qbDUv27q3SCGJKj/o
         1J2lhg801kPPtRuHlvApLw0fvf/JlAqTWeLECp1FpSYBcdKZZbFj+j5zXRTFNRkLbCKn
         QqNnuaIds7fRggoa1sTlQj6q3pH5THgWSC6v3ZYUQAQBgCQuObmI+lrVeQUL+6kVOdSq
         wMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLSKIJjQ1kft1gJ/qKtxM4amgzFG9wE8AKsRtRYht/Y=;
        b=VlX0fbrSvWCze4B/5NifFJ0pND4VKDwiJN3446Vgd6lYCjYXxzxNmxx+Utfhn3ZtIS
         H3iMB/y4yCmqfC+ZLrkEDY6AzBlALNb2oMj2S0wPnGsmCDnmRHTr9COCoDnquIJZIqWX
         yYbmjFiIYIpG52eskvta6mV0fkJE/sXfUNb5tCDT8ETjAW6p7mBWOt/uxolGt2eKNBk+
         ng92k2MyJ72dHmt7MPWS1bnnADPrdPoqvvdJwqkSNJ333lZIIqDggtN4A7p3ufqGVT6X
         iJuugFyVUPSvGwnKuoZA8/X0Enys17s5tJ0FeMnJtqMVtmgDn3nV11GJ4MVeSsvw96zd
         9N4Q==
X-Gm-Message-State: APjAAAXReqhpTQd/h1cRLxmLe1lF0vFnnIUCNlQfCve9MOzI9CHQisKH
        o0D7BSuD/QfyEVzUXnUxa3FoltQZ+Wc=
X-Google-Smtp-Source: APXvYqxl/dCeI5uKoA4fVduINodfjBAz5C5rJp74yhkE3YmywZRh3gcymu/U9QumNjvskwj8+5Rs+g==
X-Received: by 2002:ac8:6054:: with SMTP id k20mr3443837qtm.92.1581443708963;
        Tue, 11 Feb 2020 09:55:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:3189])
        by smtp.gmail.com with ESMTPSA id z1sm2503434qtq.69.2020.02.11.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:55:08 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
Date:   Tue, 11 Feb 2020 12:55:07 -0500
Message-Id: <20200211175507.178100-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VFS inode shrinker is currently allowed to reclaim inodes with
populated page cache. As a result it can drop gigabytes of hot and
active page cache on the floor without consulting the VM (recorded as
"inodesteal" events in /proc/vmstat).

This causes real problems in practice. Consider for example how the VM
would cache a source tree, such as the Linux git tree. As large parts
of the checked out files and the object database are accessed
repeatedly, the page cache holding this data gets moved to the active
list, where it's fully (and indefinitely) insulated from one-off cache
moving through the inactive list.

However, due to the way users interact with the tree, no ongoing open
file descriptors into the source tree are maintained, and the inodes
end up on the "unused inode" shrinker LRU. A larger burst of one-off
cache (find, updatedb, etc.) can now drive the VFS shrinkers to drop
first the dentries and then the inodes - inodes that contain the most
valuable data currently held by the page cache - while there is plenty
of one-off cache that could be reclaimed instead.

This doesn't make sense. The inodes aren't really "unused" as long as
the VM deems it worthwhile to hold on to their page cache. And the
shrinker can't possibly guess what is and isn't valuable to the VM
based on recent inode reference information alone (we could delete
several thousand lines of reclaim code if it could).

History

This behavior of invalidating page cache from the inode shrinker goes
back to even before the git import of the kernel tree. It may have
been less noticeable when the VM itself didn't have real workingset
protection, and floods of one-off cache would push out any active
cache over time anyway. But the VM has come a long way since then and
the inode shrinker is now actively subverting its caching strategy.

As this keeps causing problems for people, there have been several
attempts to address this.

One recent attempt was to make the inode shrinker simply skip over
inodes that still contain pages: a76cf1a474d7 ("mm: don't reclaim
inodes with many attached pages").

However, this change had to be reverted in 69056ee6a8a3 ("Revert "mm:
don't reclaim inodes with many attached pages"") because it caused
severe reclaim performance problems: Inodes that sit on the shrinker
LRU are attracting reclaim pressure away from the page cache and
toward the VFS. If we then permanently exempt sizable portions of this
pool from actually getting reclaimed when looked at, this pressure
accumulates as deferred shrinker work (a mechanism for *temporarily*
unreclaimable objects) until it causes mayhem in the VFS cache pools.

In the bug quoted in 69056ee6a8a3 in particular, the excessive
pressure drove the XFS shrinker into dirty objects, where it caused
synchronous, IO-bound stalls, even as there was plenty of clean page
cache that should have been reclaimed instead.

Another variant of this problem was recently observed, where the
kernel violates cgroups' memory.low protection settings and reclaims
page cache way beyond the configured thresholds. It was followed by a
proposal of a modified form of the reverted commit above, that
implements memory.low-sensitive shrinker skipping over populated
inodes on the LRU [1]. However, this proposal continues to run the
risk of attracting disproportionate reclaim pressure to a pool of
still-used inodes, while not addressing the more generic reclaim
inversion problem outside of a very specific cgroup application.

[1] https://lore.kernel.org/linux-mm/1578499437-1664-1-git-send-email-laoar.shao@gmail.com/

Solution

To fix the reclaim inversion described in the beginning, without
reintroducing the problems associated with shrinker LRU rotations,
this patch keeps populated inodes off the LRUs entirely.

Currently, inodes are kept off the shrinker LRU as long as they have
an elevated i_count, indicating an active user. Unfortunately, the
page cache cannot simply hold an i_count reference, because unlink()
*should* result in the inode being dropped and its cache invalidated.

Instead, this patch makes iput_final() consult the state of the page
cache and punt the LRU linking to the VM if the inode is still
populated; the VM in turn checks the inode state when it depopulates
the page cache, and adds the inode to the LRU if necessary.

This is not unlike what we do for dirty inodes, which are moved off
the LRU permanently until writeback completion puts them back on (iff
still unused). We can reuse the same code -- inode_add_lru() - here.

This is also not unlike page reclaim, where the lower VM layer has to
negotiate state with the higher VFS layer. Follow existing precedence
and handle the inversion as much as possible on the VM side:

- introduce an I_PAGES flag that the VM maintains under the i_lock, so
  that any inode code holding that lock can check the page cache state
  without having to lock and inspect the struct address_space

- introduce inode_pages_set() and inode_pages_clear() to maintain the
  inode LRU state from the VM side, then update all cache mutators to
  use them when populating the first cache entry or clearing the last

With this, the concept of "inodesteal" - where the inode shrinker
drops page cache - is a thing of the past. The VM is in charge of the
page cache, the inode shrinker is in charge of freeing struct inode.

Footnotes

- For debuggability, add vmstat counters that track the number of
  times a new cache entry pulls a previously unused inode off the LRU
  (pginoderescue), as well as how many times existing cache deferred
  an LRU addition. Keep the pginodesteal/kswapd_inodesteal counters
  for backwards compatibility, but they'll just show 0 now.

- Fix /proc/sys/vm/drop_caches to drop shadow entries from the page
  cache. Not doing so has always been a bit strange, but since most
  people drop cache and metadata cache together, the inode shrinker
  would have taken care of them before - no more, so do it VM-side.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/block_dev.c                |   2 +-
 fs/dax.c                      |  14 +++++
 fs/drop_caches.c              |   2 +-
 fs/inode.c                    | 106 ++++++++++++++++++++++++++--------
 fs/internal.h                 |   2 +-
 include/linux/fs.h            |  12 ++++
 include/linux/pagemap.h       |   2 +-
 include/linux/vm_event_item.h |   3 +-
 mm/filemap.c                  |  39 ++++++++++---
 mm/huge_memory.c              |   3 +-
 mm/truncate.c                 |  34 ++++++++---
 mm/vmscan.c                   |   6 +-
 mm/vmstat.c                   |   4 +-
 mm/workingset.c               |   4 ++
 14 files changed, 183 insertions(+), 50 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..46f67147ad20 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -79,7 +79,7 @@ void kill_bdev(struct block_device *bdev)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (mapping_empty(mapping))
 		return;
 
 	invalidate_bh_lrus();
diff --git a/fs/dax.c b/fs/dax.c
index 35da144375a0..7f3ce4612272 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -478,9 +478,11 @@ static void *grab_mapping_entry(struct xa_state *xas,
 {
 	unsigned long index = xas->xa_index;
 	bool pmd_downgrade = false; /* splitting PMD entry into PTE entries? */
+	int populated;
 	void *entry;
 
 retry:
+	populated = 0;
 	xas_lock_irq(xas);
 	entry = get_unlocked_entry(xas, order);
 
@@ -526,6 +528,8 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, true);
 		mapping->nrexceptional--;
+		if (mapping_empty(mapping))
+			populated = -1;
 		entry = NULL;
 		xas_set(xas, index);
 	}
@@ -541,11 +545,17 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		dax_lock_entry(xas, entry);
 		if (xas_error(xas))
 			goto out_unlock;
+		if (mapping_empty(mapping))
+			populated++;
 		mapping->nrexceptional++;
 	}
 
 out_unlock:
 	xas_unlock_irq(xas);
+	if (populated == -1)
+		inode_pages_clear(mapping->inode);
+	else if (populated == 1)
+		inode_pages_set(mapping->inode);
 	if (xas_nomem(xas, mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM))
 		goto retry;
 	if (xas->xa_node == XA_ERROR(-ENOMEM))
@@ -631,6 +641,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 					  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
+	bool empty = false;
 	int ret = 0;
 	void *entry;
 
@@ -645,10 +656,13 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	dax_disassociate_entry(entry, mapping, trunc);
 	xas_store(&xas, NULL);
 	mapping->nrexceptional--;
+	empty = mapping_empty(mapping);
 	ret = 1;
 out:
 	put_unlocked_entry(&xas, entry);
 	xas_unlock_irq(&xas);
+	if (empty)
+		inode_pages_clear(mapping->host);
 	return ret;
 }
 
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index dc1a1d5d825b..a5e9e9053474 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -27,7 +27,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		 * we need to reschedule to avoid softlockups.
 		 */
 		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
-		    (inode->i_mapping->nrpages == 0 && !need_resched())) {
+		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
diff --git a/fs/inode.c b/fs/inode.c
index 7d57068b6b7a..575b780fa9bb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -430,25 +430,87 @@ static void inode_lru_list_add(struct inode *inode)
 		inode->i_state |= I_REFERENCED;
 }
 
+static void inode_lru_list_del(struct inode *inode)
+{
+	if (list_lru_del(&inode->i_sb->s_inode_lru, &inode->i_lru))
+		this_cpu_dec(nr_unused);
+}
+
 /*
  * Add inode to LRU if needed (inode is unused and clean).
  *
  * Needs inode->i_lock held.
  */
-void inode_add_lru(struct inode *inode)
+bool inode_add_lru(struct inode *inode)
 {
-	if (!(inode->i_state & (I_DIRTY_ALL | I_SYNC |
-				I_FREEING | I_WILL_FREE)) &&
-	    !atomic_read(&inode->i_count) && inode->i_sb->s_flags & SB_ACTIVE)
-		inode_lru_list_add(inode);
+	if (inode->i_state &
+	    (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE | I_PAGES))
+		return false;
+	if (atomic_read(&inode->i_count))
+		return false;
+	if (!(inode->i_sb->s_flags & SB_ACTIVE))
+		return false;
+	inode_lru_list_add(inode);
+	return true;
 }
 
+/**
+ * inode_pages_set - mark the inode as holding page cache
+ * @inode: the inode whose first cache page was just added
+ *
+ * Tell the VFS that this inode has populated page cache and must not
+ * be reclaimed by the inode shrinker.
+ *
+ * The caller must hold the page lock of the just-added page: by
+ * pinning the page, the page cache cannot become depopulated, and we
+ * can safely set I_PAGES without a race check under the i_pages lock.
+ *
+ * This function acquires the i_lock.
+ */
+void inode_pages_set(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	if (!(inode->i_state & I_PAGES)) {
+		inode->i_state |= I_PAGES;
+		if (!list_empty(&inode->i_lru)) {
+			count_vm_event(PGINODERESCUE);
+			inode_lru_list_del(inode);
+		}
+	}
+	spin_unlock(&inode->i_lock);
+}
 
-static void inode_lru_list_del(struct inode *inode)
+/**
+ * inode_pages_clear - mark the inode as not holding page cache
+ * @inode: the inode whose last cache page was just removed
+ *
+ * Tell the VFS that the inode no longer holds page cache and that its
+ * lifetime is to be handed over to the inode shrinker LRU.
+ *
+ * This function acquires the i_lock and the i_pages lock.
+ */
+void inode_pages_clear(struct inode *inode)
 {
+	struct address_space *mapping = &inode->i_data;
+	bool add_to_lru = false;
+	unsigned long flags;
 
-	if (list_lru_del(&inode->i_sb->s_inode_lru, &inode->i_lru))
-		this_cpu_dec(nr_unused);
+	spin_lock(&inode->i_lock);
+
+	xa_lock_irqsave(&mapping->i_pages, flags);
+	if ((inode->i_state & I_PAGES) && mapping_empty(mapping)) {
+		inode->i_state &= ~I_PAGES;
+		add_to_lru = true;
+	}
+	xa_unlock_irqrestore(&mapping->i_pages, flags);
+
+	if (add_to_lru) {
+		WARN_ON_ONCE(!list_empty(&inode->i_lru));
+		if (inode_add_lru(inode))
+			__count_vm_event(PGINODEDELAYED);
+	}
+
+	spin_unlock(&inode->i_lock);
 }
 
 /**
@@ -742,6 +804,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;
 
+	WARN_ON_ONCE(inode->i_state & I_PAGES);
+
 	/*
 	 * Referenced or dirty inodes are still in use. Give them another pass
 	 * through the LRU as we canot reclaim them now.
@@ -761,23 +825,17 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 		return LRU_ROTATE;
 	}
 
-	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
-		__iget(inode);
+	/*
+	 * Populated inodes shouldn't be on the shrinker LRU, but they
+	 * can be briefly visible when a new page is added to an inode
+	 * that was already linked but inode_pages_set() hasn't run
+	 * yet to move them off.
+	 */
+	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
+		list_lru_isolate(lru, &inode->i_lru);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(lru_lock);
-		if (remove_inode_buffers(inode)) {
-			unsigned long reap;
-			reap = invalidate_mapping_pages(&inode->i_data, 0, -1);
-			if (current_is_kswapd())
-				__count_vm_events(KSWAPD_INODESTEAL, reap);
-			else
-				__count_vm_events(PGINODESTEAL, reap);
-			if (current->reclaim_state)
-				current->reclaim_state->reclaimed_slab += reap;
-		}
-		iput(inode);
-		spin_lock(lru_lock);
-		return LRU_RETRY;
+		this_cpu_dec(nr_unused);
+		return LRU_REMOVED;
 	}
 
 	WARN_ON(inode->i_state & I_NEW);
diff --git a/fs/internal.h b/fs/internal.h
index f3f280b952a3..4a9dc77e817b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -139,7 +139,7 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
-extern void inode_add_lru(struct inode *inode);
+extern bool inode_add_lru(struct inode *inode);
 extern int dentry_needs_remove_privs(struct dentry *dentry);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..a98d9dee39f4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -585,6 +585,11 @@ static inline void mapping_allow_writable(struct address_space *mapping)
 	atomic_inc(&mapping->i_mmap_writable);
 }
 
+static inline bool mapping_empty(struct address_space *mapping)
+{
+	return mapping->nrpages + mapping->nrexceptional == 0;
+}
+
 /*
  * Use sequence counter to get consistent i_size on 32-bit processors.
  */
@@ -2150,6 +2155,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_CREATING		New object's inode in the middle of setting up.
  *
+ * I_PAGES		Inode is holding page cache that needs to get reclaimed
+ *			first before the inode can go onto the shrinker LRU.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2172,6 +2180,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_WB_SWITCH		(1 << 13)
 #define I_OVL_INUSE		(1 << 14)
 #define I_CREATING		(1 << 15)
+#define I_PAGES			(1 << 16)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
@@ -3097,6 +3106,9 @@ static inline void remove_inode_hash(struct inode *inode)
 		__remove_inode_hash(inode);
 }
 
+extern void inode_pages_set(struct inode *inode);
+extern void inode_pages_clear(struct inode *inode);
+
 extern void inode_sb_list_add(struct inode *inode);
 
 #ifdef CONFIG_BLOCK
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ccb14b6a16b5..ae4d90bd0873 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -609,7 +609,7 @@ int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern void delete_from_page_cache(struct page *page);
-extern void __delete_from_page_cache(struct page *page, void *shadow);
+extern bool __delete_from_page_cache(struct page *page, void *shadow);
 int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 47a3441cf4c4..f31026ccf590 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -38,7 +38,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_NUMA
 		PGSCAN_ZONE_RECLAIM_FAILED,
 #endif
-		PGINODESTEAL, SLABS_SCANNED, KSWAPD_INODESTEAL,
+		SLABS_SCANNED,
+		PGINODESTEAL, KSWAPD_INODESTEAL, PGINODERESCUE, PGINODEDELAYED,
 		KSWAPD_LOW_WMARK_HIT_QUICKLY, KSWAPD_HIGH_WMARK_HIT_QUICKLY,
 		PAGEOUTRUN, PGROTATED,
 		DROP_PAGECACHE, DROP_SLAB,
diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..fcc24b3b3540 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -116,8 +116,8 @@
  *   ->tasklist_lock            (memory_failure, collect_procs_ao)
  */
 
-static void page_cache_delete(struct address_space *mapping,
-				   struct page *page, void *shadow)
+static bool __must_check page_cache_delete(struct address_space *mapping,
+					   struct page *page, void *shadow)
 {
 	XA_STATE(xas, &mapping->i_pages, page->index);
 	unsigned int nr = 1;
@@ -151,6 +151,8 @@ static void page_cache_delete(struct address_space *mapping,
 		smp_wmb();
 	}
 	mapping->nrpages -= nr;
+
+	return mapping_empty(mapping);
 }
 
 static void unaccount_page_cache_page(struct address_space *mapping,
@@ -227,15 +229,18 @@ static void unaccount_page_cache_page(struct address_space *mapping,
  * Delete a page from the page cache and free it. Caller has to make
  * sure the page is locked and that nobody else uses it - or that usage
  * is safe.  The caller must hold the i_pages lock.
+ *
+ * If this returns true, the caller must call inode_pages_clear()
+ * after dropping the i_pages lock.
  */
-void __delete_from_page_cache(struct page *page, void *shadow)
+bool __must_check __delete_from_page_cache(struct page *page, void *shadow)
 {
 	struct address_space *mapping = page->mapping;
 
 	trace_mm_filemap_delete_from_page_cache(page);
 
 	unaccount_page_cache_page(mapping, page);
-	page_cache_delete(mapping, page, shadow);
+	return page_cache_delete(mapping, page, shadow);
 }
 
 static void page_cache_free_page(struct address_space *mapping,
@@ -267,12 +272,16 @@ void delete_from_page_cache(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
+	bool empty;
 
 	BUG_ON(!PageLocked(page));
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	__delete_from_page_cache(page, NULL);
+	empty = __delete_from_page_cache(page, NULL);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
+	if (empty)
+		inode_pages_clear(mapping->host);
+
 	page_cache_free_page(mapping, page);
 }
 EXPORT_SYMBOL(delete_from_page_cache);
@@ -291,8 +300,8 @@ EXPORT_SYMBOL(delete_from_page_cache);
  *
  * The function expects the i_pages lock to be held.
  */
-static void page_cache_delete_batch(struct address_space *mapping,
-			     struct pagevec *pvec)
+static bool __must_check page_cache_delete_batch(struct address_space *mapping,
+						 struct pagevec *pvec)
 {
 	XA_STATE(xas, &mapping->i_pages, pvec->pages[0]->index);
 	int total_pages = 0;
@@ -337,12 +346,15 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		total_pages++;
 	}
 	mapping->nrpages -= total_pages;
+
+	return mapping_empty(mapping);
 }
 
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec)
 {
 	int i;
+	bool empty;
 	unsigned long flags;
 
 	if (!pagevec_count(pvec))
@@ -354,9 +366,12 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 
 		unaccount_page_cache_page(mapping, pvec->pages[i]);
 	}
-	page_cache_delete_batch(mapping, pvec);
+	empty = page_cache_delete_batch(mapping, pvec);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
+	if (empty)
+		inode_pages_clear(mapping->host);
+
 	for (i = 0; i < pagevec_count(pvec); i++)
 		page_cache_free_page(mapping, pvec->pages[i]);
 }
@@ -831,9 +846,10 @@ static int __add_to_page_cache_locked(struct page *page,
 				      void **shadowp)
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
+	int error;
 	int huge = PageHuge(page);
 	struct mem_cgroup *memcg;
-	int error;
+	bool populated = false;
 	void *old;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -860,6 +876,7 @@ static int __add_to_page_cache_locked(struct page *page,
 		if (xas_error(&xas))
 			goto unlock;
 
+		populated = mapping_empty(mapping);
 		if (xa_is_value(old)) {
 			mapping->nrexceptional--;
 			if (shadowp)
@@ -880,6 +897,10 @@ static int __add_to_page_cache_locked(struct page *page,
 	if (!huge)
 		mem_cgroup_commit_charge(page, memcg, false, false);
 	trace_mm_filemap_add_to_page_cache(page);
+
+	if (populated)
+		inode_pages_set(mapping->host);
+
 	return 0;
 error:
 	page->mapping = NULL;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..8b3e33a52d93 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2535,7 +2535,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		/* Some pages can be beyond i_size: drop them from page cache */
 		if (head[i].index >= end) {
 			ClearPageDirty(head + i);
-			__delete_from_page_cache(head + i, NULL);
+			/* We know we're not removing the last page */
+			(void)__delete_from_page_cache(head + i, NULL);
 			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
 				shmem_uncharge(head->mapping->host, 1);
 			put_page(head + i);
diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da356..8fb6c2f762bc 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -31,24 +31,31 @@
  * itself locked.  These unlocked entries need verification under the tree
  * lock.
  */
-static inline void __clear_shadow_entry(struct address_space *mapping,
-				pgoff_t index, void *entry)
+static bool __must_check __clear_shadow_entry(struct address_space *mapping,
+					      pgoff_t index, void *entry)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 
 	xas_set_update(&xas, workingset_update_node);
 	if (xas_load(&xas) != entry)
-		return;
+		return 0;
 	xas_store(&xas, NULL);
 	mapping->nrexceptional--;
+
+	return mapping_empty(mapping);
 }
 
 static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
 			       void *entry)
 {
+	bool empty;
+
 	xa_lock_irq(&mapping->i_pages);
-	__clear_shadow_entry(mapping, index, entry);
+	empty = __clear_shadow_entry(mapping, index, entry);
 	xa_unlock_irq(&mapping->i_pages);
+
+	if (empty)
+		inode_pages_clear(mapping->host);
 }
 
 /*
@@ -61,7 +68,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 				pgoff_t end)
 {
 	int i, j;
-	bool dax, lock;
+	bool dax, lock, empty = false;
 
 	/* Handled by shmem itself */
 	if (shmem_mapping(mapping))
@@ -96,11 +103,16 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 			continue;
 		}
 
-		__clear_shadow_entry(mapping, index, page);
+		if (__clear_shadow_entry(mapping, index, page))
+			empty = true;
 	}
 
 	if (lock)
 		xa_unlock_irq(&mapping->i_pages);
+
+	if (empty)
+		inode_pages_clear(mapping->host);
+
 	pvec->nr = j;
 }
 
@@ -300,7 +312,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	pgoff_t		index;
 	int		i;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (mapping_empty(mapping))
 		goto out;
 
 	/* Offsets within partial pages */
@@ -636,6 +648,7 @@ static int
 invalidate_complete_page2(struct address_space *mapping, struct page *page)
 {
 	unsigned long flags;
+	bool empty;
 
 	if (page->mapping != mapping)
 		return 0;
@@ -648,9 +661,12 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 		goto failed;
 
 	BUG_ON(page_has_private(page));
-	__delete_from_page_cache(page, NULL);
+	empty = __delete_from_page_cache(page, NULL);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
+	if (empty)
+		inode_pages_clear(mapping->host);
+
 	if (mapping->a_ops->freepage)
 		mapping->a_ops->freepage(page);
 
@@ -692,7 +708,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int ret2 = 0;
 	int did_range_unmap = 0;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (mapping_empty(mapping))
 		goto out;
 
 	pagevec_init(&pvec);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c05eb9efec07..c82e9831003f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -901,6 +901,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	} else {
 		void (*freepage)(struct page *);
 		void *shadow = NULL;
+		int empty;
 
 		freepage = mapping->a_ops->freepage;
 		/*
@@ -922,9 +923,12 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		if (reclaimed && page_is_file_cache(page) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
 			shadow = workingset_eviction(page, target_memcg);
-		__delete_from_page_cache(page, shadow);
+		empty = __delete_from_page_cache(page, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 
+		if (empty)
+			inode_pages_clear(mapping->host);
+
 		if (freepage != NULL)
 			freepage(page);
 	}
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d53378db99..ae802253f71c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1203,9 +1203,11 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_NUMA
 	"zone_reclaim_failed",
 #endif
-	"pginodesteal",
 	"slabs_scanned",
+	"pginodesteal",
 	"kswapd_inodesteal",
+	"pginoderescue",
+	"pginodedelayed",
 	"kswapd_low_wmark_hit_quickly",
 	"kswapd_high_wmark_hit_quickly",
 	"pageoutrun",
diff --git a/mm/workingset.c b/mm/workingset.c
index 474186b76ced..7ce9c74ebfdb 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -491,6 +491,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	struct xa_node *node = container_of(item, struct xa_node, private_list);
 	XA_STATE(xas, node->array, 0);
 	struct address_space *mapping;
+	bool empty = false;
 	int ret;
 
 	/*
@@ -529,6 +530,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	if (WARN_ON_ONCE(node->count != node->nr_values))
 		goto out_invalid;
 	mapping->nrexceptional -= node->nr_values;
+	empty = mapping_empty(mapping);
 	xas.xa_node = xa_parent_locked(&mapping->i_pages, node);
 	xas.xa_offset = node->offset;
 	xas.xa_shift = node->shift + XA_CHUNK_SHIFT;
@@ -542,6 +544,8 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 
 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
+	if (empty)
+		inode_pages_clear(mapping->host);
 	ret = LRU_REMOVED_RETRY;
 out:
 	cond_resched();
-- 
2.24.1

