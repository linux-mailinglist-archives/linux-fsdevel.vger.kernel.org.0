Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48F33B68C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 20:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhF1TBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhF1TBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:01:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2466C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 11:58:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso686837pjp.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nHQ6kBRMuxPR39RnH55sL4jQW/YDfbDAwhi/S60OQqs=;
        b=jsmq1oxO0nxs6XNKX1533Gv3bzTSTxaG/KUmuziTebjzdzYjLcWdogMkZ3BZ9TtB0l
         vg2ARORIvwJZRf1XmdgnTBPq+PVsGW4IWFCg7w7VsvLKYYLCLkqvoGkRFypU5SLutXZW
         pxee9xmyluJN5AGAFS1nDBbZGn5i2UUCb28uGZCXZvkq3vHj4idaU3nu2qKSkexFeAKW
         w9Ll6RVr+gIrmkA8l6NhRv73Q1y4rRcmZg9IqPiekWaa1J0akq90RgsfK16Qn7iBoVjZ
         k697RR1Qdx2psomrUzB5skJNpNEIcG+ttc/1xOPGd7qEGBWK8HVfQowQxy7MHUfq/J70
         BSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nHQ6kBRMuxPR39RnH55sL4jQW/YDfbDAwhi/S60OQqs=;
        b=gFUOw270hv0vVZo5ivZB4OoUp4Id+hzgCeq0EpTkKAmjb/dw5f4l3ZOdU0+s/RU3/I
         iNXr9Sm4jUJr/Z2v+594EaTovmhLPKaUsLzVW3DdfALIveEfvfM4VDApIW6pGcKtf+Xp
         f07ivyifhRhesxhrh+kl8NnHIUeErZ72fe2pnCwd5+H/aO45IIXm8WAFv1y88cYy/gM+
         V5cqpamLMta3M3X5s+XKqDvjbrrs227CSeKpcBMNM2qNVuKVbVjeVlm5eaBbsmgTZrgJ
         C32hSgQEZ54LRoAfxjA91H1pQjGZleHBliFsQ/RM1gK7qXGgIMMXm9A87GdezHJoQvN9
         jLqA==
X-Gm-Message-State: AOAM5329WPNmFbJI1VPV8XITjQD/mO/jphaFoKnXrtYY0b4Ad/jvUPMs
        O3DAVXEtGKAp8lxV7s7kVkF/Hg==
X-Google-Smtp-Source: ABdhPJwxyEgYk2U7qegKLqSfQz2cLHw2EDk5qgUF7jBnsZs1zv1lyCrRbrXL9Xc2sZwWh6MqpaPiXg==
X-Received: by 2002:a17:902:8546:b029:128:e56c:bda with SMTP id d6-20020a1709028546b0290128e56c0bdamr3917883plo.63.1624906720092;
        Mon, 28 Jun 2021 11:58:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:700f])
        by smtp.gmail.com with ESMTPSA id w20sm17268334pff.90.2021.06.28.11.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:58:39 -0700 (PDT)
Date:   Mon, 28 Jun 2021 14:58:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <YNob3PxRRKe/B/Ou@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210615062640.GD2419729@dread.disaster.area>
 <YMj2YbqJvVh1busC@cmpxchg.org>
 <20210616012008.GE2419729@dread.disaster.area>
 <YMmD9xhBm9wGqYhf@cmpxchg.org>
 <20210617004942.GF2419729@dread.disaster.area>
 <YMzNmpaFurN3+n6v@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMzNmpaFurN3+n6v@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 12:45:18PM -0400, Johannes Weiner wrote:
> On Thu, Jun 17, 2021 at 10:49:42AM +1000, Dave Chinner wrote:
> > If you can work out a *clean* way to move inodes onto the LRU when
> > they are dirty then I'm all for it. But sprinkling inode->i_lock all
> > over the mm/ subsystem and then adding seemling randomly placed
> > inode lru manipulations isn't the way to do it.
> >
> > You should consider centralising all the work involved marking a
> > mapping clean somewhere inside the mm/ code. Then add a single
> > callout that does the inode LRU work, similar to how the
> > fs-writeback.c code does it when the inode is marked clean by
> > inode_sync_complete().
> 
> Yes, I'd prefer that as well. Let's look at the options.
> 
> The main source of complication is that the page cache cannot hold a
> direct reference on the inode; holding the xa_lock or the i_lock is
> the only thing that keeps the inode alive after we removed the page.
> 
> So our options are either overlapping the lock sections, or taking the
> rcu readlock on the page cache side to bridge the deletion and the
> inode callback - which then has to deal with the possibility that the
> inode may have already been destroyed by the time it's called.
> 
> I would put the RCU thing aside for now as it sounds just a bit too
> hairy, and too low-level an insight into the inode lifetime from the
> mapping side. The xa_lock is also dropped in several outer entry
> functions, so while it would clean up the fs side a bit, we wouldn't
> reduce the blast radius on the MM side.
> 
> When we overlap lock sections, there are two options:
> 
> a) This patch, with the page cache lock nesting inside the i_lock. Or,
> 
> b) the way we handle dirty state: When we call set_page_dirty() ->
>    mark_inode_dirty(), we hold the lock that serializes the page cache
>    state when locking and updating the inode state. The hierarchy is:
> 
>        lock_page(page)                 # MM
>          spin_lock(&inode->i_lock)     # FS
> 
>    The equivalent for this patch would be to have page_cache_delete()
>    call mark_inode_empty() (or whatever name works for everybody),
>    again under the lock that serializes the page cache state:
> 
>        xa_lock_irq(&mapping->i_pages)  # MM
>          spin_lock(&inode->i_lock)     # FS
> 
>    There would be one central place calling into the fs with an API
>    function, encapsulating i_lock handling in fs/inode.c.
> 
>    Great.
> 
>    The major caveat here is that i_lock would need to become IRQ safe
>    in order to nest inside the xa_lock. It's not that the semantical
>    layering of code here is new in any way, it's simply the lock type.
> 
>    As far as I can see, i_lock hold times are quite short - it's a
>    spinlock after all. But I haven't reviewed all the sites yet, and
>    there are a lot of them. They would all need to be updated.
> 
>    Likewise, list_lru locking needs to be made irq-safe. However,
>    irqsafe spinlock is sort of the inevitable fate of any lock
>    embedded in a data structure API. So I'm less concerned about that.
> 
>    AFAICS nothing else nests under i_lock.
> 
> If FS folks are fine with that, I would give that conversion a
> shot. Lock type dependency aside, this would retain full modularity
> and a clear delineation between mapping and inode property. It would
> also be a fully locked scheme, so none of the subtleties of the
> current patch. The end result seems clean and maintanable.

I spent some time auditing i_lock and I don't think this is workable
in its current scope. The irq disabling would be sprawling, and also
require things like d_lock to become irq safe.

That said, it might be possible to split the i_lock itself. AFAIU it
is used to serialize several independent operations. For example, it
seems i_size, i_blocks, i_nlink, i_dentry, i_private, i_*time updates
don't need to serialize against changes to i_state or inode
destruction beyond just holding a reference, and could presumably use
separate locks. Splitting that out could be a good thing in itself.

If the lifetime and LRU management of the inode can be moved to a new
lock, we could make those operations irq safe with little collateral
damage. And then the below cleanup to the current patch would be
possible, which would consolidate the MM side somewhat.

I don't mind pursuing this if people agree it's a good idea.

That said, this is a fairly invasive, non-trivial architectural
overhaul, which I don't think is a reasonable prerequisites for
addressing a real world problem we have today. I hope we can go ahead
with this fix for now and tag on the architectural rework - instead of
the other way around, and leaving memory management broken until I get
more familiar with vfs locking, let alone stabilizing those changes...

Here is the follow-up cleanup this would enable (would obviously
deadlock in the current version of i_lock). Honestly a little
underwhelming if you ask me, given the size of the prep work...

---
 fs/inode.c              |  7 +++++++
 fs/internal.h           |  1 +
 include/linux/fs.h      |  3 ++-
 include/linux/pagemap.h | 13 +------------
 mm/filemap.c            | 14 ++++++--------
 mm/truncate.c           | 22 +++++-----------------
 mm/vmscan.c             |  7 -------
 mm/workingset.c         | 12 ++----------
 8 files changed, 24 insertions(+), 55 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6b74701c1954..18c0554148a3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -457,6 +457,13 @@ static void inode_lru_list_del(struct inode *inode)
 		this_cpu_dec(nr_unused);
 }
 
+void mark_inode_shrinkable(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	inode_add_lru(inode);
+	spin_unlock(&inode->i_lock);
+}
+
 /**
  * inode_sb_list_add - add inode to the superblock list of inodes
  * @inode: inode to add
diff --git a/fs/internal.h b/fs/internal.h
index 3eb90dde62bd..6aeae7ef3380 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -146,6 +146,7 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
+extern void inode_add_lru(struct inode *inode);
 extern int dentry_needs_remove_privs(struct dentry *dentry);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 301cd0195036..a5fb073f54c2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2409,6 +2409,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+extern void mark_inode_shrinkable(struct inode *inode);
+
 /*
  * Returns true if the given inode itself only has dirty timestamps (its pages
  * may still be dirty) and isn't currently being allocated or freed.
@@ -3214,7 +3216,6 @@ static inline void remove_inode_hash(struct inode *inode)
 }
 
 extern void inode_sb_list_add(struct inode *inode);
-extern void inode_add_lru(struct inode *inode);
 
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c9956fac640e..2e7436eba882 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -31,18 +31,7 @@ static inline bool mapping_empty(struct address_space *mapping)
  * reclaim and LRU management.
  *
  * The caller is expected to hold the i_lock, but is not required to
- * hold the i_pages lock, which usually protects cache state. That's
- * because the i_lock and the list_lru lock that protect the inode and
- * its LRU state don't nest inside the irq-safe i_pages lock.
- *
- * Cache deletions are performed under the i_lock, which ensures that
- * when an inode goes empty, it will reliably get queued on the LRU.
- *
- * Cache additions do not acquire the i_lock and may race with this
- * check, in which case we'll report the inode as shrinkable when it
- * has cache pages. This is okay: the shrinker also checks the
- * refcount and the referenced bit, which will be elevated or set in
- * the process of adding new cache pages to an inode.
+ * hold the i_pages lock, which usually protects cache state.
  */
 static inline bool mapping_shrinkable(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 0d0d72ced961..3c10830cd396 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -143,6 +143,9 @@ static void page_cache_delete(struct address_space *mapping,
 	page->mapping = NULL;
 	/* Leave page->index set: truncation lookup relies upon it */
 	mapping->nrpages -= nr;
+
+	if (mapping_shrinkable(mapping))
+		mark_inode_shrinkable(mapping->host);
 }
 
 static void unaccount_page_cache_page(struct address_space *mapping,
@@ -260,13 +263,9 @@ void delete_from_page_cache(struct page *page)
 	struct address_space *mapping = page_mapping(page);
 
 	BUG_ON(!PageLocked(page));
-	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	__delete_from_page_cache(page, NULL);
 	xa_unlock_irq(&mapping->i_pages);
-	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
-	spin_unlock(&mapping->host->i_lock);
 
 	page_cache_free_page(mapping, page);
 }
@@ -332,6 +331,9 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		total_pages++;
 	}
 	mapping->nrpages -= total_pages;
+
+	if (mapping_shrinkable(mapping))
+		mark_inode_shrinkable(mapping->host);
 }
 
 void delete_from_page_cache_batch(struct address_space *mapping,
@@ -342,7 +344,6 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	if (!pagevec_count(pvec))
 		return;
 
-	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		trace_mm_filemap_delete_from_page_cache(pvec->pages[i]);
@@ -351,9 +352,6 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	}
 	page_cache_delete_batch(mapping, pvec);
 	xa_unlock_irq(&mapping->i_pages);
-	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
-	spin_unlock(&mapping->host->i_lock);
 
 	for (i = 0; i < pagevec_count(pvec); i++)
 		page_cache_free_page(mapping, pvec->pages[i]);
diff --git a/mm/truncate.c b/mm/truncate.c
index 950d73fa995d..0adce9df9100 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -40,18 +40,17 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
 	if (xas_load(&xas) != entry)
 		return;
 	xas_store(&xas, NULL);
+
+	if (mapping_shrinkable(mapping))
+		mark_inode_shrinkable(mapping->host);
 }
 
 static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
 			       void *entry)
 {
-	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	__clear_shadow_entry(mapping, index, entry);
 	xa_unlock_irq(&mapping->i_pages);
-	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
-	spin_unlock(&mapping->host->i_lock);
 }
 
 /*
@@ -77,10 +76,8 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		return;
 
 	dax = dax_mapping(mapping);
-	if (!dax) {
-		spin_lock(&mapping->host->i_lock);
+	if (!dax)
 		xa_lock_irq(&mapping->i_pages);
-	}
 
 	for (i = j; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
@@ -99,12 +96,8 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		__clear_shadow_entry(mapping, index, page);
 	}
 
-	if (!dax) {
+	if (!dax)
 		xa_unlock_irq(&mapping->i_pages);
-		if (mapping_shrinkable(mapping))
-			inode_add_lru(mapping->host);
-		spin_unlock(&mapping->host->i_lock);
-	}
 	pvec->nr = j;
 }
 
@@ -579,7 +572,6 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	if (page_has_private(page) && !try_to_release_page(page, GFP_KERNEL))
 		return 0;
 
-	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	if (PageDirty(page))
 		goto failed;
@@ -587,9 +579,6 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	BUG_ON(page_has_private(page));
 	__delete_from_page_cache(page, NULL);
 	xa_unlock_irq(&mapping->i_pages);
-	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
-	spin_unlock(&mapping->host->i_lock);
 
 	if (mapping->a_ops->freepage)
 		mapping->a_ops->freepage(page);
@@ -598,7 +587,6 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	return 1;
 failed:
 	xa_unlock_irq(&mapping->i_pages);
-	spin_unlock(&mapping->host->i_lock);
 	return 0;
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6dd5ef8a11bc..cc5d7cd75935 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1055,8 +1055,6 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	BUG_ON(!PageLocked(page));
 	BUG_ON(mapping != page_mapping(page));
 
-	if (!PageSwapCache(page))
-		spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	/*
 	 * The non racy check for a busy page.
@@ -1125,9 +1123,6 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 			shadow = workingset_eviction(page, target_memcg);
 		__delete_from_page_cache(page, shadow);
 		xa_unlock_irq(&mapping->i_pages);
-		if (mapping_shrinkable(mapping))
-			inode_add_lru(mapping->host);
-		spin_unlock(&mapping->host->i_lock);
 
 		if (freepage != NULL)
 			freepage(page);
@@ -1137,8 +1132,6 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 
 cannot_free:
 	xa_unlock_irq(&mapping->i_pages);
-	if (!PageSwapCache(page))
-		spin_unlock(&mapping->host->i_lock);
 	return 0;
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 9d3d2b4ce44d..1576b7ca3fbb 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -540,13 +540,6 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 		goto out;
 	}
 
-	if (!spin_trylock(&mapping->host->i_lock)) {
-		xa_unlock(&mapping->i_pages);
-		spin_unlock_irq(lru_lock);
-		ret = LRU_RETRY;
-		goto out;
-	}
-
 	list_lru_isolate(lru, item);
 	__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
 
@@ -564,11 +557,10 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	xa_delete_node(node, workingset_update_node);
 	__inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
 
+	if (mapping_shrinkable(mapping))
+		mark_inode_shrinkable(mapping->host);
 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
-	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
-	spin_unlock(&mapping->host->i_lock);
 	ret = LRU_REMOVED_RETRY;
 out:
 	cond_resched();
-- 
2.32.0

