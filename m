Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80268319620
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBKWzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 17:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhBKWzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:55:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A59FC061574;
        Thu, 11 Feb 2021 14:54:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q10so1185344plk.2;
        Thu, 11 Feb 2021 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+tJoBnc8KR21oS215xMDwJ2EmSo2UjR67iWiW0FMZzc=;
        b=u+xB31LXo856rD2SkaUibLBlHLr1qez3qTwe4fiWBqz51qvRowRgsgqb1rp7iuFyvE
         YoslJWKKUJAsRKxhtf2rojniUXB5EJxLftpr9rXEwqcKmbGEXM95bccECg1DDfLAWQsl
         Hy8+AC1ZBimKKG8jKrdNUjFiZTvA8NEpVFrK/WkbHMsd72429angyDUYS3sece/pZtsN
         wRzA3L72yJpSFGTOmD/bycLst36kytgU+9fgi6r5LoK5eNkic7JBksCQUKE8EHLgG8pE
         AkI+gMFs2Iz7AoGtZpGS7syhnnWGJUoaKg3yYryZrv9o0gWROAladhmSP/97WjWpbXcU
         zDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+tJoBnc8KR21oS215xMDwJ2EmSo2UjR67iWiW0FMZzc=;
        b=k/33sjJ2RqSdike6k1jhBkkewXm06UYZPSBzKBmpMvAwUkt9eXD2QnVE5ToiycRS1j
         PwlaaGg0ml0DU0yseCNT4fSgLFUxWqRO4iitepOsB2HXOmzUFEYF4ke9yZAU1oeOgWx0
         8fAUkJVPXFphzBCWKhWbPWBkwCnChwUddjDKRVeRoYeV7+gE9wfqzcotXz2RNswskdSb
         u8w+3qPyHWISCUiwM0W0v7cV0w38ieBZl8oVmgBzDvCQUQz05xMtOCf2xvwBvs+P2GfU
         s8ACAY5OZ2TG4JTMRwfRvp6VSyMpVEblIRSBNuRtAn2Vk5wad8AWpHg0kY0dBPUUJLWC
         VlHw==
X-Gm-Message-State: AOAM531G6V4Csi5WYt8vypqJkAS43V0b+ZQiRXYak2QCbs8nCvsy38G1
        mwCup104am16SITh6B6jwF0=
X-Google-Smtp-Source: ABdhPJxOA0JK0aLrbeujk4Enl3c9fty8lI4Mr99IlleIjZgaGlixzYHKjUwQXG6NWG29uWjv1NUtAg==
X-Received: by 2002:a17:902:a710:b029:e3:b18:7e5b with SMTP id w16-20020a170902a710b02900e30b187e5bmr119281plq.17.1613084094449;
        Thu, 11 Feb 2021 14:54:54 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2149:cbd5:4673:bc93])
        by smtp.gmail.com with ESMTPSA id b25sm6821310pfp.26.2021.02.11.14.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:54:53 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 11 Feb 2021 14:54:51 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, david@redhat.com,
        vbabka@suse.cz
Subject: Re: [PATCH v2] [RFC] mm: fs: Invalidate BH LRU during page migration
Message-ID: <YCW1u3Si/GsyI6td@google.com>
References: <cover.1613020616.git.cgoldswo@codeaurora.org>
 <c083b0ab6e410e33ca880d639f90ef4f6f3b33ff.1613020616.git.cgoldswo@codeaurora.org>
 <20210211140950.GJ308988@casper.infradead.org>
 <60485ac195c0b1eecac2c99d8bca7fcb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60485ac195c0b1eecac2c99d8bca7fcb@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 11:39:05AM -0800, Chris Goldsworthy wrote:
> On 2021-02-11 06:09, Matthew Wilcox wrote:
> > On Wed, Feb 10, 2021 at 09:35:40PM -0800, Chris Goldsworthy wrote:
> > > +/* These are used to control the BH LRU invalidation during page
> > > migration */
> > > +static struct cpumask lru_needs_invalidation;
> > > +static bool bh_lru_disabled = false;
> > 
> > As I asked before, what protects this on an SMP system?
> > 
> 
> Sorry Matthew, I misconstrued your earlier question in V1, and thought you
> had been referring to compile-time protection (so as to prevent build
> breakages).  It is not protected, so I'll need to change this into an atomic
> counter that is incremented and decremented by bh_lru_enable() and
> bh_lru_disable() respectively (such that if the counter is greater than
> zero, we bail).
> 
> > > @@ -1292,7 +1296,9 @@ static inline void check_irqs_on(void)
> > >  /*
> > >   * Install a buffer_head into this cpu's LRU.  If not already in
> > > the LRU, it is
> > >   * inserted at the front, and the buffer_head at the back if any is
> > > evicted.
> > > - * Or, if already in the LRU it is moved to the front.
> > > + * Or, if already in the LRU it is moved to the front. Note that if
> > > LRU is
> > > + * disabled because of an ongoing page migration, we won't insert
> > > bh into the
> > > + * LRU.
> > 
> > And also, why do we need to do this?  The page LRU has no equivalent
> > mechanism to prevent new pages being added to the per-CPU LRU lists.
> > If a BH has just been used, isn't that a strong hint that this page is
> > a bad candidate for migration?
> 
> I had assumed that up until now, that pages in the page cache aren't an
> issue, such that they're dropped during migration as needed. Looking at
> try_to_free_buffers[1], I don't see any handling for the page cache.  I will
> need to do due diligence and follow up on this.
> 
> As for the question on necessity, if there is a case in which preventing
> buffer_heads from being added to the BH LRU ensures that the containing page
> can be migrated, then I would say that the change is justified, since adds
> another scenario in which migration is guaranteed (I will follow up on this
> as well).



First of all, Thanks for the work, Chris.

Looks like this is not only bh_lru problem but also general problem for
LRU pagevecs. Furthemore, there are other hidden cache meachnism to hold
additional page refcount until they are flush.
(I have seen pages in pagevec with additional refcount on migration
could make migration failure since early LRU draining right before
migrate_pages). Even though migrate_pages has retrial logic, it just
relies on the luck so the CMA allocation is still fragile for failure.

Ccing more folks, a random thought.
The idea is disable such cache mechanism for a while critical migration(
e.g., CMA) is going on. With the migrate_pending, we could apply draining
whenever we find additional refcount problem.

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604f69b3..17b8c1efdbf3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
+#include <linux/migrate.h>
 
 #include "internal.h"
 
@@ -1300,6 +1301,9 @@ static void bh_lru_install(struct buffer_head *bh)
 	struct bh_lru *b;
 	int i;
 
+	if (migrate_pending())
+		return;
+
 	check_irqs_on();
 	bh_lru_lock();
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a389633b68f..047d5358fe0d 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -46,6 +46,8 @@ extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
 extern void migrate_prep(void);
+extern void migrate_finish(void);
+extern bool migrate_pending(void);
 extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
@@ -67,6 +69,7 @@ static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
 static inline int migrate_prep(void) { return -ENOSYS; }
+static inline void migrate_finish(void) {}
 static inline int migrate_prep_local(void) { return -ENOSYS; }
 
 static inline void migrate_page_states(struct page *newpage, struct page *page)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6961238c7ef5..46d9986c7bf0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1208,6 +1208,8 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			break;
 	}
 	mmap_read_unlock(mm);
+	migrate_finish();
+
 	if (err < 0)
 		return err;
 	return busy;
@@ -1371,6 +1373,10 @@ static long do_mbind(unsigned long start, unsigned long len,
 	mmap_write_unlock(mm);
 mpol_out:
 	mpol_put(new);
+
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		migrate_finish();
+
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index a69da8aaeccd..3130a27e4e94 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,6 +57,8 @@
 
 #include "internal.h"
 
+static atomic_t migrate_pending_count = ATOMIC_INIT(0);
+
 /*
  * migrate_prep() needs to be called before we start compiling a list of pages
  * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
@@ -64,13 +66,12 @@
  */
 void migrate_prep(void)
 {
+	atomic_inc(&migrate_pending_count);
 	/*
 	 * Clear the LRU lists so pages can be isolated.
-	 * Note that pages may be moved off the LRU after we have
-	 * drained them. Those pages will fail to migrate like other
-	 * pages that may be busy.
 	 */
 	lru_add_drain_all();
+	invalidate_bh_lrus();
 }
 
 /* Do the necessary work of migrate_prep but not if it involves other CPUs */
@@ -79,6 +80,16 @@ void migrate_prep_local(void)
 	lru_add_drain();
 }
 
+void migrate_finish(void)
+{
+	atomic_dec(&migrate_pending_count);
+}
+
+bool migrate_pending(void)
+{
+	return atomic_read(&migrate_pending_count);
+}
+
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct address_space *mapping;
@@ -1837,6 +1848,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
+	migrate_finish();
 	return err;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f8fbee73dd6d..4ced6d559073 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8493,6 +8493,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
+
+	migrate_finish();
+
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
 		return ret;
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..55f9e8c8ca5b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -36,6 +36,7 @@
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
+#include <linux/migrate.h>
 
 #include "internal.h"
 
@@ -252,7 +253,8 @@ void rotate_reclaimable_page(struct page *page)
 		get_page(page);
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (!pagevec_add(pvec, page) || PageCompound(page)
+					|| migrate_pending())
 			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
 		local_unlock_irqrestore(&lru_rotate.lock, flags);
 	}
@@ -343,7 +345,8 @@ static void activate_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (!pagevec_add(pvec, page) || PageCompound(page)
+					|| migrate_pending())
 			pagevec_lru_move_fn(pvec, __activate_page);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -458,7 +461,7 @@ void lru_cache_add(struct page *page)
 	get_page(page);
 	local_lock(&lru_pvecs.lock);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
-	if (!pagevec_add(pvec, page) || PageCompound(page))
+	if (!pagevec_add(pvec, page) || PageCompound(page) || migrate_pending())
 		__pagevec_lru_add(pvec);
 	local_unlock(&lru_pvecs.lock);
 }
@@ -654,7 +657,8 @@ void deactivate_file_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (!pagevec_add(pvec, page) || PageCompound(page) ||
+					migrate_pending())
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -676,7 +680,8 @@ void deactivate_page(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (!pagevec_add(pvec, page) || PageCompound(page) ||
+					migrate_pending())
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
@@ -698,7 +703,8 @@ void mark_page_lazyfree(struct page *page)
 		local_lock(&lru_pvecs.lock);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
-		if (!pagevec_add(pvec, page) || PageCompound(page))
+		if (!pagevec_add(pvec, page) || PageCompound(page)
+					|| migrate_pending())
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 		local_unlock(&lru_pvecs.lock);
 	}
-- 
2.30.0.478.g8a0d178c01-goog

