Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8E3EC07F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 06:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhHNEaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 00:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhHNEaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 00:30:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248AAC061756;
        Fri, 13 Aug 2021 21:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lwU/IB+Nm5xyRqkYrurF6eOIosLOeIB9lERbwxGE+Dg=; b=mEigd+RjClZCSGpcrcOTkqnqZC
        nehtbqTGvEHUl1RMBpynmAyfNh6+qTtT/xN1hvdmx006BQ5OIlAMvytLJxpnJjfoIRv8AHK0yDO4C
        Yf8wPQ+/B2EvniCanoYo44kn17z/G2Zyya6TWHI35HGTEnjMNw1EX6xNFvBb4Do2ewQrtjR6mbgCg
        Zx3V9cjoeuLI+o121oULU00ybt3BWHeE6ndrlLnL2vzx/f0jFkbLLX4H80xJBc/NnIfwXksjydpua
        ZRMJ7fT17o2Q9cv07DaLzCStkjt9evQpLrSko4LRKP4wf164VVRb3SlUDrvpbjHa/vt8ElsRXiopS
        oIyVRHaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mElHU-00GNYa-Oq; Sat, 14 Aug 2021 04:28:44 +0000
Date:   Sat, 14 Aug 2021 05:28:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 080/138] mm/workingset: Convert workingset_refault()
 to take a folio
Message-ID: <YRdGaKsLkAwpadW5@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-81-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-81-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:06AM +0100, Matthew Wilcox (Oracle) wrote:
>  /**
> - * workingset_refault - evaluate the refault of a previously evicted page
> - * @page: the freshly allocated replacement page
> - * @shadow: shadow entry of the evicted page
> + * workingset_refault - evaluate the refault of a previously evicted folio
> + * @page: the freshly allocated replacement folio

Randy pointed out this doc mistake.  Which got me looking at this
whole patch again, and I noticed that we're counting an entire folio as
a single page.

So I'm going to apply this patch on top of the below patch.

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 241bd0f53fb9..bfe38869498d 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -597,12 +597,6 @@ static inline void mod_lruvec_page_state(struct page *page,
 
 #endif /* CONFIG_MEMCG */
 
-static inline void inc_lruvec_state(struct lruvec *lruvec,
-				    enum node_stat_item idx)
-{
-	mod_lruvec_state(lruvec, idx, 1);
-}
-
 static inline void __inc_lruvec_page_state(struct page *page,
 					   enum node_stat_item idx)
 {
diff --git a/mm/workingset.c b/mm/workingset.c
index 10830211a187..9f91c28cc0ce 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -273,9 +273,9 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 }
 
 /**
- * workingset_refault - evaluate the refault of a previously evicted folio
- * @page: the freshly allocated replacement folio
- * @shadow: shadow entry of the evicted folio
+ * workingset_refault - Evaluate the refault of a previously evicted folio.
+ * @folio: The freshly allocated replacement folio.
+ * @shadow: Shadow entry of the evicted folio.
  *
  * Calculates and evaluates the refault distance of the previously
  * evicted folio in the context of the node and the memcg whose memory
@@ -295,6 +295,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	unsigned long refault;
 	bool workingset;
 	int memcgid;
+	long nr;
 
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
 
@@ -347,10 +348,11 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 * However, the cgroup that will own the folio is the one that
 	 * is actually experiencing the refault event.
 	 */
+	nr = folio_nr_pages(folio);
 	memcg = folio_memcg(folio);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);
+	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
 	/*
 	 * Compare the distance to the existing workingset size. We
@@ -376,15 +378,15 @@ void workingset_refault(struct folio *folio, void *shadow)
 		goto out;
 
 	folio_set_active(folio);
-	workingset_age_nonresident(lruvec, folio_nr_pages(folio));
-	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);
+	workingset_age_nonresident(lruvec, nr);
+	mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file, nr);
 
 	/* Folio was active prior to eviction */
 	if (workingset) {
 		folio_set_workingset(folio);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
 		lru_note_cost_folio(folio);
-		inc_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file);
+		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
 out:
 	rcu_read_unlock();

> + * @shadow: shadow entry of the evicted folio
>   *
>   * Calculates and evaluates the refault distance of the previously
> - * evicted page in the context of the node and the memcg whose memory
> + * evicted folio in the context of the node and the memcg whose memory
>   * pressure caused the eviction.
>   */
> -void workingset_refault(struct page *page, void *shadow)
> +void workingset_refault(struct folio *folio, void *shadow)
>  {
> -	bool file = page_is_file_lru(page);
> +	bool file = folio_is_file_lru(folio);
>  	struct mem_cgroup *eviction_memcg;
>  	struct lruvec *eviction_lruvec;
>  	unsigned long refault_distance;
> @@ -301,10 +301,10 @@ void workingset_refault(struct page *page, void *shadow)
>  	rcu_read_lock();
>  	/*
>  	 * Look up the memcg associated with the stored ID. It might
> -	 * have been deleted since the page's eviction.
> +	 * have been deleted since the folio's eviction.
>  	 *
>  	 * Note that in rare events the ID could have been recycled
> -	 * for a new cgroup that refaults a shared page. This is
> +	 * for a new cgroup that refaults a shared folio. This is
>  	 * impossible to tell from the available data. However, this
>  	 * should be a rare and limited disturbance, and activations
>  	 * are always speculative anyway. Ultimately, it's the aging
> @@ -340,14 +340,14 @@ void workingset_refault(struct page *page, void *shadow)
>  	refault_distance = (refault - eviction) & EVICTION_MASK;
>  
>  	/*
> -	 * The activation decision for this page is made at the level
> +	 * The activation decision for this folio is made at the level
>  	 * where the eviction occurred, as that is where the LRU order
> -	 * during page reclaim is being determined.
> +	 * during folio reclaim is being determined.
>  	 *
> -	 * However, the cgroup that will own the page is the one that
> +	 * However, the cgroup that will own the folio is the one that
>  	 * is actually experiencing the refault event.
>  	 */
> -	memcg = page_memcg(page);
> +	memcg = folio_memcg(folio);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  
>  	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);
> @@ -375,15 +375,15 @@ void workingset_refault(struct page *page, void *shadow)
>  	if (refault_distance > workingset_size)
>  		goto out;
>  
> -	SetPageActive(page);
> -	workingset_age_nonresident(lruvec, thp_nr_pages(page));
> +	folio_set_active(folio);
> +	workingset_age_nonresident(lruvec, folio_nr_pages(folio));
>  	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);
>  
> -	/* Page was active prior to eviction */
> +	/* Folio was active prior to eviction */
>  	if (workingset) {
> -		SetPageWorkingset(page);
> +		folio_set_workingset(folio);
>  		/* XXX: Move to lru_cache_add() when it supports new vs putback */
> -		lru_note_cost_page(page);
> +		lru_note_cost_folio(folio);
>  		inc_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file);
>  	}
>  out:
> -- 
> 2.30.2
> 
