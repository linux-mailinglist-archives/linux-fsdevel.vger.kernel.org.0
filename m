Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019D9541DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 00:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382700AbiFGWWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 18:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385480AbiFGWVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:21:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADBB26A92D;
        Tue,  7 Jun 2022 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RenhU3RHwEHXRFKuc3WvitvoD8h0d/HVNFY9bYLj8SU=; b=Gx8fCNRA/y4+Z8IMSNPyWnv9Qi
        az+7jD5WsnmosJnTH8yCD2pM9k1hAX3tHv7O4crKDcgFxgV++uQq5PymRu3QBqBh5+zHZdSgTkgKq
        /EubDI22NDfzTqreZS5c/k+GnVps/Tb5WGPS04PkEs4ItAuqZitiWUcIY1b2ks92PgU9DjXiN3P9v
        47Av6a1jfTZ961wweogmga76P8IsEBxABnATMP3z+Mi8diuFtSpgIlKcP5g//Tfk6Qb8UNPZ3/iVi
        J34SdTwreZxSORNmse43tdIYFaj6ZJxTgkWXVH/1WXH7lZP8zNad9fsU2dUGBAHcF02Gjs8DgwMPE
        XnhauhUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyem4-00Bucx-0c; Tue, 07 Jun 2022 19:21:56 +0000
Date:   Tue, 7 Jun 2022 20:21:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 15/20] balloon: Convert to migrate_folio
Message-ID: <Yp+lU55H4igaV3pB@casper.infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-16-willy@infradead.org>
 <e4d017a4-556d-bb5f-9830-a8843591bc8d@redhat.com>
 <Yp9fj/Si2qyb61Y3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp9fj/Si2qyb61Y3@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:24:15PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 07, 2022 at 09:36:21AM +0200, David Hildenbrand wrote:
> > On 06.06.22 22:40, Matthew Wilcox (Oracle) wrote:
> > >  const struct address_space_operations balloon_aops = {
> > > -	.migratepage = balloon_page_migrate,
> > > +	.migrate_folio = balloon_migrate_folio,
> > >  	.isolate_page = balloon_page_isolate,
> > >  	.putback_page = balloon_page_putback,
> > >  };
> > 
> > I assume you're working on conversion of the other callbacks as well,
> > because otherwise, this ends up looking a bit inconsistent and confusing :)
> 
> My intention was to finish converting aops for the next merge window.
> 
> However, it seems to me that we goofed back in 2016 by merging
> commit bda807d44454.  isolate_page() and putback_page() should
> never have been part of address_space_operations.
> 
> I'm about to embark on creating a new migrate_operations struct
> for drivers to use that contains only isolate/putback/migrate.
> No filesystem uses isolate/putback, so those can just be deleted.
> Both migrate_operations & address_space_operations will contain a
> migrate callback.

Well, that went more smoothly than I thought it would.

I can't see a nice way to split this patch up (other than making secretmem
its own patch).  We just don't have enough bits in struct page to support
both ways of handling PageMovable at the same time, so we can't convert
one driver at a time.  The diffstat is pretty compelling.

The patch is on top of this patch series; I think it probably makes
sense to shuffle it to be first, to avoid changing these drivers to
folios, then changing them back.

Questions:

Is what I've done with zsmalloc acceptable?  The locking in that
file is rather complex.

Can we now eliminate balloon_mnt / balloon_fs from cmm.c?  I haven't even
compiled thatfile , but it seems like the filesystem serves no use now.

Similar question for vmw_balloon.c, although I have compiled that.

---

I just spotted a bug with zs_unregister_migration(); it won't compile
without CONFIG_MIGRATION.  I'll fix that up if the general approach is
acceptable.

 arch/powerpc/platforms/pseries/cmm.c |   13 --------
 drivers/misc/vmw_balloon.c           |   10 ------
 include/linux/balloon_compaction.h   |    6 +---
 include/linux/fs.h                   |    2 -
 include/linux/migrate.h              |   27 ++++++++++++++----
 include/linux/page-flags.h           |    2 -
 mm/balloon_compaction.c              |   18 ++++++------
 mm/compaction.c                      |   29 ++++++++-----------
 mm/migrate.c                         |   23 ++++++++-------
 mm/secretmem.c                       |    6 ----
 mm/util.c                            |    4 +-
 mm/z3fold.c                          |   45 ++++++------------------------
 mm/zsmalloc.c                        |   52 +++++++++--------------------------
 13 files changed, 83 insertions(+), 154 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 15ed8206c463..2ecbab3db723 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -578,23 +578,10 @@ static int cmm_balloon_compaction_init(void)
 		return rc;
 	}
 
-	b_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
-	if (IS_ERR(b_dev_info.inode)) {
-		rc = PTR_ERR(b_dev_info.inode);
-		b_dev_info.inode = NULL;
-		kern_unmount(balloon_mnt);
-		balloon_mnt = NULL;
-		return rc;
-	}
-
-	b_dev_info.inode->i_mapping->a_ops = &balloon_aops;
 	return 0;
 }
 static void cmm_balloon_compaction_deinit(void)
 {
-	if (b_dev_info.inode)
-		iput(b_dev_info.inode);
-	b_dev_info.inode = NULL;
 	kern_unmount(balloon_mnt);
 	balloon_mnt = NULL;
 }
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 086ce77d9074..4a6755934bb5 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1869,10 +1869,6 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
  */
 static void vmballoon_compaction_deinit(struct vmballoon *b)
 {
-	if (!IS_ERR(b->b_dev_info.inode))
-		iput(b->b_dev_info.inode);
-
-	b->b_dev_info.inode = NULL;
 	kern_unmount(vmballoon_mnt);
 	vmballoon_mnt = NULL;
 }
@@ -1895,12 +1891,6 @@ static __init int vmballoon_compaction_init(struct vmballoon *b)
 		return PTR_ERR(vmballoon_mnt);
 
 	b->b_dev_info.migratepage = vmballoon_migratepage;
-	b->b_dev_info.inode = alloc_anon_inode(vmballoon_mnt->mnt_sb);
-
-	if (IS_ERR(b->b_dev_info.inode))
-		return PTR_ERR(b->b_dev_info.inode);
-
-	b->b_dev_info.inode->i_mapping->a_ops = &balloon_aops;
 	return 0;
 }
 
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index edb7f6d41faa..5ca2d5699620 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -57,7 +57,6 @@ struct balloon_dev_info {
 	struct list_head pages;		/* Pages enqueued & handled to Host */
 	int (*migratepage)(struct balloon_dev_info *, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
-	struct inode *inode;
 };
 
 extern struct page *balloon_page_alloc(void);
@@ -75,11 +74,10 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 	spin_lock_init(&balloon->pages_lock);
 	INIT_LIST_HEAD(&balloon->pages);
 	balloon->migratepage = NULL;
-	balloon->inode = NULL;
 }
 
 #ifdef CONFIG_BALLOON_COMPACTION
-extern const struct address_space_operations balloon_aops;
+extern const struct movable_operations balloon_mops;
 
 /*
  * balloon_page_insert - insert a page into the balloon's page list and make
@@ -94,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	__SetPageMovable(page, balloon->inode->i_mapping);
+	__SetPageMovable(page, &balloon_mops);
 	set_page_private(page, (unsigned long)balloon);
 	list_add(&page->lru, &balloon->pages);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 95347cc035ae..7e06919b8f60 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -367,8 +367,6 @@ struct address_space_operations {
 	 */
 	int (*migrate_folio)(struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
-	bool (*isolate_page)(struct page *, isolate_mode_t);
-	void (*putback_page)(struct page *);
 	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4670f3aec232..27f3780fac36 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -19,6 +19,13 @@ struct migration_target_control;
  */
 #define MIGRATEPAGE_SUCCESS		0
 
+struct movable_operations {
+	bool (*isolate_page)(struct page *, isolate_mode_t);
+	int (*migrate_page)(struct page *dst, struct page *src,
+			enum migrate_mode);
+	void (*putback_page)(struct page *);
+};
+
 /* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];
 
@@ -79,13 +86,13 @@ static inline int next_demotion_node(int node)
 #endif
 
 #ifdef CONFIG_COMPACTION
-extern int PageMovable(struct page *page);
-extern void __SetPageMovable(struct page *page, struct address_space *mapping);
-extern void __ClearPageMovable(struct page *page);
+bool PageMovable(struct page *page);
+void __SetPageMovable(struct page *page, const struct movable_operations *ops);
+void __ClearPageMovable(struct page *page);
 #else
-static inline int PageMovable(struct page *page) { return 0; }
+static inline bool PageMovable(struct page *page) { return false; }
 static inline void __SetPageMovable(struct page *page,
-				struct address_space *mapping)
+		const struct movable_operations *ops)
 {
 }
 static inline void __ClearPageMovable(struct page *page)
@@ -98,6 +105,15 @@ static inline bool folio_test_movable(struct folio *folio)
 	return PageMovable(&folio->page);
 }
 
+static inline
+const struct movable_operations *page_movable_ops(struct page *page)
+{
+	VM_BUG_ON(!__PageMovable(page));
+
+	return (const struct movable_operations *)
+		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 extern int migrate_misplaced_page(struct page *page,
 				  struct vm_area_struct *vma, int node);
@@ -171,5 +187,4 @@ int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
 #endif /* CONFIG_MIGRATION */
-
 #endif /* _LINUX_MIGRATE_H */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e66f7aa3191d..3f5490f6f038 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -639,7 +639,7 @@ __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
  * structure which KSM associates with that merged page.  See ksm.h.
  *
  * PAGE_MAPPING_KSM without PAGE_MAPPING_ANON is used for non-lru movable
- * page and then page->mapping points a struct address_space.
+ * page and then page->mapping points to a struct movable_operations.
  *
  * Please note that, confusingly, "page_mapping" refers to the inode
  * address_space which maps the page from disk; whereas "page_mapped"
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 3f75b876ad76..7d1eb90ed07a 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -230,10 +230,10 @@ static void balloon_page_putback(struct page *page)
 
 
 /* move_to_new_page() counterpart for a ballooned page */
-static int balloon_migrate_folio(struct address_space *mapping,
-		struct folio *dst, struct folio *src, enum migrate_mode mode)
+static int balloon_migrate_page(struct page *dst, struct page *src,
+		enum migrate_mode mode)
 {
-	struct balloon_dev_info *balloon = balloon_page_device(&src->page);
+	struct balloon_dev_info *balloon = balloon_page_device(src);
 
 	/*
 	 * We can not easily support the no copy case here so ignore it as it
@@ -243,17 +243,17 @@ static int balloon_migrate_folio(struct address_space *mapping,
 	if (mode == MIGRATE_SYNC_NO_COPY)
 		return -EINVAL;
 
-	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
-	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
+	VM_BUG_ON_PAGE(!PageLocked(src), src);
+	VM_BUG_ON_PAGE(!PageLocked(dst), dst);
 
-	return balloon->migratepage(balloon, &dst->page, &src->page, mode);
+	return balloon->migratepage(balloon, dst, src, mode);
 }
 
-const struct address_space_operations balloon_aops = {
-	.migrate_folio = balloon_migrate_folio,
+const struct movable_operations balloon_mops = {
+	.migrate_page = balloon_migrate_page,
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
 };
-EXPORT_SYMBOL_GPL(balloon_aops);
+EXPORT_SYMBOL_GPL(balloon_mops);
 
 #endif /* CONFIG_BALLOON_COMPACTION */
diff --git a/mm/compaction.c b/mm/compaction.c
index f0dc62159c0e..a2c53fcf933e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -110,28 +110,27 @@ static void split_map_pages(struct list_head *list)
 }
 
 #ifdef CONFIG_COMPACTION
-
-int PageMovable(struct page *page)
+bool PageMovable(struct page *page)
 {
-	struct address_space *mapping;
+	const struct movable_operations *mops;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	if (!__PageMovable(page))
-		return 0;
+		return false;
 
-	mapping = page_mapping(page);
-	if (mapping && mapping->a_ops && mapping->a_ops->isolate_page)
-		return 1;
+	mops = page_movable_ops(page);
+	if (mops)
+		return true;
 
-	return 0;
+	return false;
 }
 EXPORT_SYMBOL(PageMovable);
 
-void __SetPageMovable(struct page *page, struct address_space *mapping)
+void __SetPageMovable(struct page *page, const struct movable_operations *mops)
 {
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE((unsigned long)mapping & PAGE_MAPPING_MOVABLE, page);
-	page->mapping = (void *)((unsigned long)mapping | PAGE_MAPPING_MOVABLE);
+	VM_BUG_ON_PAGE((unsigned long)mops & PAGE_MAPPING_MOVABLE, page);
+	page->mapping = (void *)((unsigned long)mops | PAGE_MAPPING_MOVABLE);
 }
 EXPORT_SYMBOL(__SetPageMovable);
 
@@ -139,12 +138,10 @@ void __ClearPageMovable(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	/*
-	 * Clear registered address_space val with keeping PAGE_MAPPING_MOVABLE
-	 * flag so that VM can catch up released page by driver after isolation.
-	 * With it, VM migration doesn't try to put it back.
+	 * This page still has the type of a movable page, but it's
+	 * actually not movable any more.
 	 */
-	page->mapping = (void *)((unsigned long)page->mapping &
-				PAGE_MAPPING_MOVABLE);
+	page->mapping = (void *)PAGE_MAPPING_MOVABLE;
 }
 EXPORT_SYMBOL(__ClearPageMovable);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 53fcfa5d55b8..a13e17ab72c8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -59,7 +59,7 @@
 
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
-	struct address_space *mapping;
+	const struct movable_operations *mops;
 
 	/*
 	 * Avoid burning cycles with pages that are yet under __free_pages(),
@@ -97,10 +97,10 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	if (!PageMovable(page) || PageIsolated(page))
 		goto out_no_isolated;
 
-	mapping = page_mapping(page);
-	VM_BUG_ON_PAGE(!mapping, page);
+	mops = page_movable_ops(page);
+	VM_BUG_ON_PAGE(!mops, page);
 
-	if (!mapping->a_ops->isolate_page(page, mode))
+	if (!mops->isolate_page(page, mode))
 		goto out_no_isolated;
 
 	/* Driver shouldn't use PG_isolated bit of page->flags */
@@ -120,10 +120,9 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 
 static void putback_movable_page(struct page *page)
 {
-	struct address_space *mapping;
+	const struct movable_operations *mops = page_movable_ops(page);
 
-	mapping = page_mapping(page);
-	mapping->a_ops->putback_page(page);
+	mops->putback_page(page);
 	ClearPageIsolated(page);
 }
 
@@ -889,16 +888,15 @@ static int fallback_migrate_folio(struct address_space *mapping,
 static int move_to_new_folio(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
 {
-	struct address_space *mapping;
 	int rc = -EAGAIN;
 	bool is_lru = !__PageMovable(&src->page);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
 	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
 
-	mapping = folio_mapping(src);
-
 	if (likely(is_lru)) {
+		struct address_space *mapping = folio_mapping(src);
+
 		if (!mapping)
 			rc = migrate_folio(mapping, dst, src, mode);
 		else if (mapping->a_ops->migrate_folio)
@@ -914,6 +912,8 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 		else
 			rc = fallback_migrate_folio(mapping, dst, src, mode);
 	} else {
+		const struct movable_operations *mops;
+
 		/*
 		 * In case of non-lru page, it could be released after
 		 * isolation step. In that case, we shouldn't try migration.
@@ -925,7 +925,8 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			goto out;
 		}
 
-		rc = mapping->a_ops->migrate_folio(mapping, dst, src, mode);
+		mops = page_movable_ops(&src->page);
+		rc = mops->migrate_page(&dst->page, &src->page, mode);
 		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
 				!folio_test_isolated(src));
 	}
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 9c7f6e3bf3e1..43bebf703cf9 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -133,11 +133,6 @@ static const struct file_operations secretmem_fops = {
 	.mmap		= secretmem_mmap,
 };
 
-static bool secretmem_isolate_page(struct page *page, isolate_mode_t mode)
-{
-	return false;
-}
-
 static int secretmem_migrate_folio(struct address_space *mapping,
 				 struct folio *dst, struct folio *src,
 				 enum migrate_mode mode)
@@ -155,7 +150,6 @@ const struct address_space_operations secretmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
 	.free_folio	= secretmem_free_folio,
 	.migrate_folio	= secretmem_migrate_folio,
-	.isolate_page	= secretmem_isolate_page,
 };
 
 static int secretmem_setattr(struct user_namespace *mnt_userns,
diff --git a/mm/util.c b/mm/util.c
index 0837570c9225..53af0e79d3e4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -804,10 +804,10 @@ struct address_space *folio_mapping(struct folio *folio)
 		return swap_address_space(folio_swap_entry(folio));
 
 	mapping = folio->mapping;
-	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
+	if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
 		return NULL;
 
-	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
+	return mapping;
 }
 EXPORT_SYMBOL(folio_mapping);
 
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 5d091c41fb35..4883e3f573b5 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -149,7 +149,6 @@ struct z3fold_header {
  * @compact_wq:	workqueue for page layout background optimization
  * @release_wq:	workqueue for safe page release
  * @work:	work_struct for safe page release
- * @inode:	inode for z3fold pseudo filesystem
  *
  * This structure is allocated at pool creation time and maintains metadata
  * pertaining to a particular z3fold pool.
@@ -169,7 +168,6 @@ struct z3fold_pool {
 	struct workqueue_struct *compact_wq;
 	struct workqueue_struct *release_wq;
 	struct work_struct work;
-	struct inode *inode;
 };
 
 /*
@@ -362,26 +360,6 @@ static void z3fold_unmount(void)
 	kern_unmount(z3fold_mnt);
 }
 
-static const struct address_space_operations z3fold_aops;
-static int z3fold_register_migration(struct z3fold_pool *pool)
-{
-	pool->inode = alloc_anon_inode(z3fold_mnt->mnt_sb);
-	if (IS_ERR(pool->inode)) {
-		pool->inode = NULL;
-		return 1;
-	}
-
-	pool->inode->i_mapping->private_data = pool;
-	pool->inode->i_mapping->a_ops = &z3fold_aops;
-	return 0;
-}
-
-static void z3fold_unregister_migration(struct z3fold_pool *pool)
-{
-	if (pool->inode)
-		iput(pool->inode);
-}
-
 /* Initializes the z3fold header of a newly allocated z3fold page */
 static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 					struct z3fold_pool *pool, gfp_t gfp)
@@ -1002,14 +980,10 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 	pool->release_wq = create_singlethread_workqueue(pool->name);
 	if (!pool->release_wq)
 		goto out_wq;
-	if (z3fold_register_migration(pool))
-		goto out_rwq;
 	INIT_WORK(&pool->work, free_pages_work);
 	pool->ops = ops;
 	return pool;
 
-out_rwq:
-	destroy_workqueue(pool->release_wq);
 out_wq:
 	destroy_workqueue(pool->compact_wq);
 out_unbuddied:
@@ -1043,11 +1017,12 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
 
 	destroy_workqueue(pool->compact_wq);
 	destroy_workqueue(pool->release_wq);
-	z3fold_unregister_migration(pool);
 	free_percpu(pool->unbuddied);
 	kfree(pool);
 }
 
+static const struct movable_operations z3fold_mops;
+
 /**
  * z3fold_alloc() - allocates a region of a given size
  * @pool:	z3fold pool from which to allocate
@@ -1117,11 +1092,11 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 	}
 	if (can_sleep) {
 		lock_page(page);
-		__SetPageMovable(page, pool->inode->i_mapping);
+		__SetPageMovable(page, &z3fold_mops);
 		unlock_page(page);
 	} else {
 		WARN_ON(!trylock_page(page));
-		__SetPageMovable(page, pool->inode->i_mapping);
+		__SetPageMovable(page, &z3fold_mops);
 		unlock_page(page);
 	}
 	z3fold_page_lock(zhdr);
@@ -1554,11 +1529,9 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	return false;
 }
 
-static int z3fold_migrate_folio(struct address_space *mapping,
-		struct folio *dst, struct folio *src, enum migrate_mode mode)
+static int z3fold_migrate_page(struct page *newpage, struct page *page,
+		enum migrate_mode mode)
 {
-	struct page *newpage = &dst->page;
-	struct page *page = &src->page;
 	struct z3fold_header *zhdr, *new_zhdr;
 	struct z3fold_pool *pool;
 	struct address_space *new_mapping;
@@ -1610,7 +1583,7 @@ static int z3fold_migrate_folio(struct address_space *mapping,
 	spin_lock(&pool->lock);
 	list_add(&newpage->lru, &pool->lru);
 	spin_unlock(&pool->lock);
-	__SetPageMovable(newpage, new_mapping);
+	__SetPageMovable(newpage, &z3fold_mops);
 	z3fold_page_unlock(new_zhdr);
 
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
@@ -1644,9 +1617,9 @@ static void z3fold_page_putback(struct page *page)
 	z3fold_page_unlock(zhdr);
 }
 
-static const struct address_space_operations z3fold_aops = {
+static const struct movable_operations z3fold_mops = {
 	.isolate_page = z3fold_page_isolate,
-	.migrate_folio = z3fold_migrate_folio,
+	.migrate_page = z3fold_migrate_page,
 	.putback_page = z3fold_page_putback,
 };
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 8ed79121195a..582765115289 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -252,7 +252,6 @@ struct zs_pool {
 	struct dentry *stat_dentry;
 #endif
 #ifdef CONFIG_COMPACTION
-	struct inode *inode;
 	struct work_struct free_work;
 #endif
 	/* protect page/zspage migration */
@@ -271,6 +270,7 @@ struct zspage {
 	unsigned int freeobj;
 	struct page *first_page;
 	struct list_head list; /* fullness list */
+	struct zs_pool *pool;
 #ifdef CONFIG_COMPACTION
 	rwlock_t lock;
 #endif
@@ -295,8 +295,6 @@ static bool ZsHugePage(struct zspage *zspage)
 }
 
 #ifdef CONFIG_COMPACTION
-static int zs_register_migration(struct zs_pool *pool);
-static void zs_unregister_migration(struct zs_pool *pool);
 static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
@@ -309,8 +307,6 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
 static int zsmalloc_mount(void) { return 0; }
 static void zsmalloc_unmount(void) {}
-static int zs_register_migration(struct zs_pool *pool) { return 0; }
-static void zs_unregister_migration(struct zs_pool *pool) {}
 static void migrate_lock_init(struct zspage *zspage) {}
 static void migrate_read_lock(struct zspage *zspage) {}
 static void migrate_read_unlock(struct zspage *zspage) {}
@@ -1083,6 +1079,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 
 	create_page_chain(class, zspage, pages);
 	init_zspage(class, zspage);
+	zspage->pool = pool;
 
 	return zspage;
 }
@@ -1823,6 +1820,8 @@ static void dec_zspage_isolation(struct zspage *zspage)
 	zspage->isolated--;
 }
 
+static const struct movable_operations zsmalloc_mops;
+
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
@@ -1843,7 +1842,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	set_first_obj_offset(newpage, get_first_obj_offset(oldpage));
 	if (unlikely(ZsHugePage(zspage)))
 		newpage->index = oldpage->index;
-	__SetPageMovable(newpage, page_mapping(oldpage));
+	__SetPageMovable(newpage, &zsmalloc_mops);
 }
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
@@ -1865,11 +1864,9 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	return true;
 }
 
-static int zs_migrate_folio(struct address_space *mapping,
-		struct folio *dst, struct folio *src, enum migrate_mode mode)
+static int zs_migrate_page(struct page *newpage, struct page *page,
+		enum migrate_mode mode)
 {
-	struct page *newpage = &dst->page;
-	struct page *page = &src->page;
 	struct zs_pool *pool;
 	struct size_class *class;
 	struct zspage *zspage;
@@ -1891,14 +1888,15 @@ static int zs_migrate_folio(struct address_space *mapping,
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
-	pool = mapping->private_data;
+	/* The page is locked, so this pointer must remain valid */
+	zspage = get_zspage(page);
+	pool = zspage->pool;
 
 	/*
 	 * The pool migrate_lock protects the race between zpage migration
 	 * and zs_free.
 	 */
 	write_lock(&pool->migrate_lock);
-	zspage = get_zspage(page);
 	class = zspage_class(pool, zspage);
 
 	/*
@@ -1966,31 +1964,12 @@ static void zs_page_putback(struct page *page)
 	migrate_write_unlock(zspage);
 }
 
-static const struct address_space_operations zsmalloc_aops = {
+static const struct movable_operations zsmalloc_mops = {
 	.isolate_page = zs_page_isolate,
-	.migrate_folio = zs_migrate_folio,
+	.migrate_page = zs_migrate_page,
 	.putback_page = zs_page_putback,
 };
 
-static int zs_register_migration(struct zs_pool *pool)
-{
-	pool->inode = alloc_anon_inode(zsmalloc_mnt->mnt_sb);
-	if (IS_ERR(pool->inode)) {
-		pool->inode = NULL;
-		return 1;
-	}
-
-	pool->inode->i_mapping->private_data = pool;
-	pool->inode->i_mapping->a_ops = &zsmalloc_aops;
-	return 0;
-}
-
-static void zs_unregister_migration(struct zs_pool *pool)
-{
-	flush_work(&pool->free_work);
-	iput(pool->inode);
-}
-
 /*
  * Caller should hold page_lock of all pages in the zspage
  * In here, we cannot use zspage meta data.
@@ -2045,7 +2024,7 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
 
 	do {
 		WARN_ON(!trylock_page(page));
-		__SetPageMovable(page, pool->inode->i_mapping);
+		__SetPageMovable(page, &zsmalloc_mops);
 		unlock_page(page);
 	} while ((page = get_next_page(page)) != NULL);
 }
@@ -2326,9 +2305,6 @@ struct zs_pool *zs_create_pool(const char *name)
 	/* debug only, don't abort if it fails */
 	zs_pool_stat_create(pool, name);
 
-	if (zs_register_migration(pool))
-		goto err;
-
 	/*
 	 * Not critical since shrinker is only used to trigger internal
 	 * defragmentation of the pool which is pretty optional thing.  If
@@ -2350,7 +2326,7 @@ void zs_destroy_pool(struct zs_pool *pool)
 	int i;
 
 	zs_unregister_shrinker(pool);
-	zs_unregister_migration(pool);
+	flush_work(&pool->free_work);
 	zs_pool_stat_destroy(pool);
 
 	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
