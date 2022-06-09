Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E92544F3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbiFIOff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 10:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343670AbiFIOfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6C0320C35;
        Thu,  9 Jun 2022 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TA+NCKNN+eR/98pPS94dU7ufUL4m7Zs6MV61a+jrgiQ=; b=mJcV7mgbC23cOsHdB1405TagzU
        l6AFmpVy5mLOXT20rfyqUCs8GP1EArGlIG1d+bclAU46G00m8RJH75DYvbpvKFAoiuSJW6O1QFxtc
        2ZX4fS2+npBuj7sf3RvxFNkEweZex+Vj5ENrzd+I9sLOEiAHImqAtc2JJMmXz3zh4NxdT+iutq57l
        sa2BrKvjamqY1v2cSnnX2SVKVkgqfyixklYyUbrljPQ6xD47cyaOzZMoDzKBVpqtqSMOytkWZDuBZ
        F+RQnbBADziujlHBIVHKfnYLbBNznbuZDQFAQyeC1t2Akp4vpvYgdDPkd6Xi/SQT+RWagEzzXyc1U
        YnTwbbOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzJFc-00DcSb-SM; Thu, 09 Jun 2022 14:35:08 +0000
Date:   Thu, 9 Jun 2022 15:35:08 +0100
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
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/19] fs: Add aops->migrate_folio
Message-ID: <YqIFHPJZNMrmtXlh@casper.infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-4-willy@infradead.org>
 <b2a81248-03fc-afb3-1041-d8206e95e08a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a81248-03fc-afb3-1041-d8206e95e08a@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 02:50:20PM +0200, David Hildenbrand wrote:
> On 08.06.22 17:02, Matthew Wilcox (Oracle) wrote:
> > diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> > index c0fe711f14d3..3d28b23676bd 100644
> > --- a/Documentation/filesystems/locking.rst
> > +++ b/Documentation/filesystems/locking.rst
> > @@ -253,7 +253,8 @@ prototypes::
> >  	void (*free_folio)(struct folio *);
> >  	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
> >  	bool (*isolate_page) (struct page *, isolate_mode_t);
> > -	int (*migratepage)(struct address_space *, struct page *, struct page *);
> > +	int (*migrate_folio)(struct address_space *, struct folio *dst,
> > +			struct folio *src, enum migrate_mode);
> >  	void (*putback_page) (struct page *);
> 
> isolate_page/putback_page are leftovers from the previous patch, no?

Argh, right, I completely forgot I needed to update the documentation in
that patch.

> > +++ b/Documentation/vm/page_migration.rst
> > @@ -181,22 +181,23 @@ which are function pointers of struct address_space_operations.
> >     Once page is successfully isolated, VM uses page.lru fields so driver
> >     shouldn't expect to preserve values in those fields.
> >  
> > -2. ``int (*migratepage) (struct address_space *mapping,``
> > -|	``struct page *newpage, struct page *oldpage, enum migrate_mode);``
> > -
> > -   After isolation, VM calls migratepage() of driver with the isolated page.
> > -   The function of migratepage() is to move the contents of the old page to the
> > -   new page
> > -   and set up fields of struct page newpage. Keep in mind that you should
> > -   indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
> > -   under page_lock if you migrated the oldpage successfully and returned
> > -   MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, driver
> > -   can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short time
> > -   because VM interprets -EAGAIN as "temporary migration failure". On returning
> > -   any error except -EAGAIN, VM will give up the page migration without
> > -   retrying.
> > -
> > -   Driver shouldn't touch the page.lru field while in the migratepage() function.
> > +2. ``int (*migrate_folio) (struct address_space *mapping,``
> > +|	``struct folio *dst, struct folio *src, enum migrate_mode);``
> > +
> > +   After isolation, VM calls the driver's migrate_folio() with the
> > +   isolated folio.  The purpose of migrate_folio() is to move the contents
> > +   of the source folio to the destination folio and set up the fields
> > +   of destination folio.  Keep in mind that you should indicate to the
> > +   VM the source folio is no longer movable via __ClearPageMovable()
> > +   under folio if you migrated the source successfully and returned
> > +   MIGRATEPAGE_SUCCESS.  If driver cannot migrate the folio at the
> > +   moment, driver can return -EAGAIN. On -EAGAIN, VM will retry folio
> > +   migration in a short time because VM interprets -EAGAIN as "temporary
> > +   migration failure".  On returning any error except -EAGAIN, VM will
> > +   give up the folio migration without retrying.
> > +
> > +   Driver shouldn't touch the folio.lru field while in the migrate_folio()
> > +   function.
> >  
> >  3. ``void (*putback_page)(struct page *);``
> 
> Hmm, here it's a bit more complicated now, because we essentially have
> two paths: LRU+migrate_folio or !LRU+movable_ops
> (isolate/migrate/putback page)

Oh ... actually, this is just documenting the driver side of things.
I don't really like how it's written.  Here, have some rewritten
documentation (which is now part of the previous patch):

+++ b/Documentation/vm/page_migration.rst
@@ -152,110 +152,15 @@ Steps:
 Non-LRU page migration
 ======================

-Although migration originally aimed for reducing the latency of memory accesses
-for NUMA, compaction also uses migration to create high-order pages.
+Although migration originally aimed for reducing the latency of memory
+accesses for NUMA, compaction also uses migration to create high-order
+pages.  For compaction purposes, it is also useful to be able to move
+non-LRU pages, such as zsmalloc and virtio-balloon pages.

-Current problem of the implementation is that it is designed to migrate only
-*LRU* pages. However, there are potential non-LRU pages which can be migrated
-in drivers, for example, zsmalloc, virtio-balloon pages.
-
-For virtio-balloon pages, some parts of migration code path have been hooked
-up and added virtio-balloon specific functions to intercept migration logics.
-It's too specific to a driver so other drivers who want to make their pages
-movable would have to add their own specific hooks in the migration path.
-
-To overcome the problem, VM supports non-LRU page migration which provides
-generic functions for non-LRU movable pages without driver specific hooks
-in the migration path.
-
-If a driver wants to make its pages movable, it should define three functions
-which are function pointers of struct address_space_operations.
-
-1. ``bool (*isolate_page) (struct page *page, isolate_mode_t mode);``
-
-   What VM expects from isolate_page() function of driver is to return *true*
-   if driver isolates the page successfully. On returning true, VM marks the page
-   as PG_isolated so concurrent isolation in several CPUs skip the page
-   for isolation. If a driver cannot isolate the page, it should return *false*.
-
-   Once page is successfully isolated, VM uses page.lru fields so driver
-   shouldn't expect to preserve values in those fields.
-
-2. ``int (*migratepage) (struct address_space *mapping,``
-|      ``struct page *newpage, struct page *oldpage, enum migrate_mode);``
-
-   After isolation, VM calls migratepage() of driver with the isolated page.
-   The function of migratepage() is to move the contents of the old page to the
-   new page
-   and set up fields of struct page newpage. Keep in mind that you should
-   indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
-   under page_lock if you migrated the oldpage successfully and returned
-   MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, driver
-   can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short time
-   because VM interprets -EAGAIN as "temporary migration failure". On returning
-   any error except -EAGAIN, VM will give up the page migration without
-   retrying.
-
-   Driver shouldn't touch the page.lru field while in the migratepage() function.
-
-3. ``void (*putback_page)(struct page *);``
-
-   If migration fails on the isolated page, VM should return the isolated page
-   to the driver so VM calls the driver's putback_page() with the isolated page.
-   In this function, the driver should put the isolated page back into its own data
-   structure.
-
-Non-LRU movable page flags
-
-   There are two page flags for supporting non-LRU movable page.
-
-   * PG_movable
-
-     Driver should use the function below to make page movable under page_lock::
-
-       void __SetPageMovable(struct page *page, struct address_space *mapping)
-
-     It needs argument of address_space for registering migration
-     family functions which will be called by VM. Exactly speaking,
-     PG_movable is not a real flag of struct page. Rather, VM
-     reuses the page->mapping's lower bits to represent it::
-
-       #define PAGE_MAPPING_MOVABLE 0x2
-       page->mapping = page->mapping | PAGE_MAPPING_MOVABLE;
-
-     so driver shouldn't access page->mapping directly. Instead, driver should
-     use page_mapping() which masks off the low two bits of page->mapping under
-     page lock so it can get the right struct address_space.
-
-     For testing of non-LRU movable pages, VM supports __PageMovable() function.
-     However, it doesn't guarantee to identify non-LRU movable pages because
-     the page->mapping field is unified with other variables in struct page.
-     If the driver releases the page after isolation by VM, page->mapping
-     doesn't have a stable value although it has PAGE_MAPPING_MOVABLE set
-     (look at __ClearPageMovable). But __PageMovable() is cheap to call whether
-     page is LRU or non-LRU movable once the page has been isolated because LRU
-     pages can never have PAGE_MAPPING_MOVABLE set in page->mapping. It is also
-     good for just peeking to test non-LRU movable pages before more expensive
-     checking with lock_page() in pfn scanning to select a victim.
-
-     For guaranteeing non-LRU movable page, VM provides PageMovable() function.
-     Unlike __PageMovable(), PageMovable() validates page->mapping and
-     mapping->a_ops->isolate_page under lock_page(). The lock_page() prevents
-     sudden destroying of page->mapping.
-
-     Drivers using __SetPageMovable() should clear the flag via
-     __ClearMovablePage() under page_lock() before the releasing the page.
-
-   * PG_isolated
-
-     To prevent concurrent isolation among several CPUs, VM marks isolated page
-     as PG_isolated under lock_page(). So if a CPU encounters PG_isolated
-     non-LRU movable page, it can skip it. Driver doesn't need to manipulate the
-     flag because VM will set/clear it automatically. Keep in mind that if the
-     driver sees a PG_isolated page, it means the page has been isolated by the
-     VM so it shouldn't touch the page.lru field.
-     The PG_isolated flag is aliased with the PG_reclaim flag so drivers
-     shouldn't use PG_isolated for its own purposes.
+If a driver wants to make its pages movable, it should define a struct
+movable_operations.  It then needs to call __SetPageMovable() on each
+page that it may be able to move.  This uses the ``page->mapping`` field,
+so this field is not available for the driver to use for other purposes.

 Monitoring Migration
 =====================
@@ -286,3 +191,5 @@ THP_MIGRATION_FAIL and PGMIGRATE_FAIL to increase.

 Christoph Lameter, May 8, 2006.
 Minchan Kim, Mar 28, 2016.
+
+.. kernel-doc:: include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -19,6 +19,43 @@ struct migration_target_control;
  */
 #define MIGRATEPAGE_SUCCESS            0

+/**
+ * struct movable_operations - Driver page migration
+ * @isolate_page:
+ * The VM calls this function to prepare the page to be moved.  The page
+ * is locked and the driver should not unlock it.  The driver should
+ * return ``true`` if the page is movable and ``false`` if it is not
+ * currently movable.  After this function returns, the VM uses the
+ * page->lru field, so the driver must preserve any information which
+ * is usually stored here.
+ *
+ * @migrate_page:
+ * After isolation, the VM calls this function with the isolated
+ * @src page.  The driver should copy the contents of the
+ * @src page to the @dst page and set up the fields of @dst page.
+ * Both pages are locked.
+ * If page migration is successful, the driver should call
+ * __ClearPageMovable(@src) and return MIGRATEPAGE_SUCCESS.
+ * If the driver cannot migrate the page at the moment, it can return
+ * -EAGAIN.  The VM interprets this as a temporary migration failure and
+ * will retry it later.  Any other error value is a permanent migration
+ * failure and migration will not be retried.
+ * The driver shouldn't touch the @src->lru field while in the
+ * migrate_page() function.  It may write to @dst->lru.
+ *
+ * @putback_page:
+ * If migration fails on the isolated page, the VM informs the driver
+ * that the page is no longer a candidate for migration by calling
+ * this function.  The driver should put the isolated page back into
+ * its own data structure.
+ */
+struct movable_operations {
+       bool (*isolate_page)(struct page *, isolate_mode_t);
+       int (*migrate_page)(struct page *dst, struct page *src,
+                       enum migrate_mode);
+       void (*putback_page)(struct page *);
+};
+
 /* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];




