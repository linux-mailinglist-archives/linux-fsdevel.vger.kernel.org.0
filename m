Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B86B30E79B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 00:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhBCXk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 18:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbhBCXkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:40:23 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80887C061573;
        Wed,  3 Feb 2021 15:39:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cl8so622457pjb.0;
        Wed, 03 Feb 2021 15:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WfSI0hyPUdRFKgVdTfoAk9cB/Ccm0yFjJ+ceEr+djhM=;
        b=p6xUeqmr1Q0qmWWgOqqwYh5gD1KetiycNwa230vEpEyg4YRRlSZmX5rmg/rNjo3gJn
         GIf2deXivzte4vXUG+Wn79RZX5IQkiF9bKF3UNeNxqrQsiterFZutK/vk7oVV2r9NaM1
         6ASnlFDPKokxK3sFj/tjoT4tjbD9LTFGze8HdMWi4n8vUXf1517waQu/vfdqav0Mv4JM
         R321o1IdwCwwEzRFUjE94Y6ULxTpdrBhchZj/KNRviNXGSqVFv/jKd4WpV3jMYFs4l9B
         YFjePos7T92nI72XCdbrquh/os8vdL6uZuyp0iSrZaqkPHG3cKm3EixBiBmrGLXOi8bI
         aFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WfSI0hyPUdRFKgVdTfoAk9cB/Ccm0yFjJ+ceEr+djhM=;
        b=FGNi2IaLq9Yi7tC9PcqnbvT8lgKidPQyaZDjHD/HiXnslcnZVL1CbfK83Or/D88ToI
         9XkhQ1Nko0QMp9v5FXKkX/CnaSf4EBYwbJnQbLWoNS9z1hmzc1OPRg8Oolr0sKEuJE0J
         nzIDpzdFDQDpphmesMJXF4zLoaR+4q8RM1d3o51S3U6LmglzN0TeHslxPslXCVDBCcRS
         jhpI0SOFL4J9dEFvNsuxoBW01CjagrNLXP8+vO5Y4FBcrfiS72dToRyMt1dmIYp3QuCv
         vn9GyKTGZg5Dcs5FftwwgLLlSOs0nY7kALZybh8GvHyuoI2b3N5uWyLr/uhTDT0FdSAa
         Itsg==
X-Gm-Message-State: AOAM533pFAvFk/b633PSqFC4QqFm7YBHeAW9r5eNk2WstJ0Osrt99j16
        u91x4TCqveLBglPaWSLRXc0=
X-Google-Smtp-Source: ABdhPJyjE+rH5FcVzwCSRNgHNRq3ElbU07nceJl/1zliEwg1n3jaLI48gwvZypgPQo00D7tCYiR8OA==
X-Received: by 2002:a17:90b:188d:: with SMTP id mn13mr5500281pjb.215.1612395580045;
        Wed, 03 Feb 2021 15:39:40 -0800 (PST)
Received: from google.com ([2620:15c:211:201:598:57c0:5d30:3614])
        by smtp.gmail.com with ESMTPSA id l14sm3011307pjy.15.2021.02.03.15.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 15:39:39 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 3 Feb 2021 15:39:37 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: fs: Invalidate BH LRU during page migration
Message-ID: <YBs0Od0NVfwJhVfx@google.com>
References: <cover.1612248395.git.cgoldswo@codeaurora.org>
 <695193a165bf538f35de84334b4da2cc3544abe0.1612248395.git.cgoldswo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695193a165bf538f35de84334b4da2cc3544abe0.1612248395.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:55:47PM -0800, Chris Goldsworthy wrote:
> Pages containing buffer_heads that are in the buffer_head LRU cache
> will be pinned and thus cannot be migrated.  Correspondingly,
> invalidate the BH LRU before a migration starts and stop any
> buffer_head from being cached in the LRU, until migration has
> finished.

Thanks for the work, Chris. I have a few of comments below.

> 
> Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  fs/buffer.c                 |  6 ++++++
>  include/linux/buffer_head.h |  3 +++
>  include/linux/migrate.h     |  2 ++
>  mm/migrate.c                | 18 ++++++++++++++++++
>  mm/page_alloc.c             |  3 +++
>  mm/swap.c                   |  3 +++
>  6 files changed, 35 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 96c7604..39ec4ec 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1289,6 +1289,8 @@ static inline void check_irqs_on(void)
>  #endif
>  }
>  
> +bool bh_migration_done = true;

How about "bh_lru_disable"?

> +
>  /*
>   * Install a buffer_head into this cpu's LRU.  If not already in the LRU, it is
>   * inserted at the front, and the buffer_head at the back if any is evicted.
> @@ -1303,6 +1305,9 @@ static void bh_lru_install(struct buffer_head *bh)
>  	check_irqs_on();
>  	bh_lru_lock();
>  
> +	if (!bh_migration_done)
> +		goto out;
> +

Let's add why we want it in the description in bh_lru_install's description.

>  	b = this_cpu_ptr(&bh_lrus);
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
>  		swap(evictee, b->bhs[i]);
> @@ -1313,6 +1318,7 @@ static void bh_lru_install(struct buffer_head *bh)
>  	}
>  
>  	get_bh(bh);
> +out:
>  	bh_lru_unlock();
>  	brelse(evictee);
>  }
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 6b47f94..ae4eb6d 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -193,6 +193,9 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
>  		  gfp_t gfp);
>  struct buffer_head *__bread_gfp(struct block_device *,
>  				sector_t block, unsigned size, gfp_t gfp);
> +
> +extern bool bh_migration_done;
> +
>  void invalidate_bh_lrus(void);
>  struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3a38963..9e4a2dc 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -46,6 +46,7 @@ extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>  extern void putback_movable_page(struct page *page);
>  
>  extern void migrate_prep(void);
> +extern void migrate_finish(void);
>  extern void migrate_prep_local(void);
>  extern void migrate_page_states(struct page *newpage, struct page *page);
>  extern void migrate_page_copy(struct page *newpage, struct page *page);
> @@ -67,6 +68,7 @@ static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	{ return -EBUSY; }
>  
>  static inline int migrate_prep(void) { return -ENOSYS; }
> +static inline int migrate_finish(void) { return -ENOSYS; }
>  static inline int migrate_prep_local(void) { return -ENOSYS; }
>  
>  static inline void migrate_page_states(struct page *newpage, struct page *page)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a69da8a..08c981d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -64,6 +64,19 @@
>   */
>  void migrate_prep(void)
>  {
> +	bh_migration_done = false;
> +
> +	/*
> +	 * This barrier ensures that callers of bh_lru_install() between
> +	 * the barrier and the call to invalidate_bh_lrus() read
> +	 *  bh_migration_done() as false.
> +	 */
> +	/*
> +	 * TODO: Remove me? lru_add_drain_all() already has an smp_mb(),
> +	 * but it would be good to ensure that the barrier isn't forgotten.
> +	 */
> +	smp_mb();
> +
>  	/*
>  	 * Clear the LRU lists so pages can be isolated.
>  	 * Note that pages may be moved off the LRU after we have
> @@ -73,6 +86,11 @@ void migrate_prep(void)
>  	lru_add_drain_all();
>  }
>  
> +void migrate_finish(void)
> +{
> +	bh_migration_done = true;
> +}
> +
>  /* Do the necessary work of migrate_prep but not if it involves other CPUs */
>  void migrate_prep_local(void)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6446778..e4cb959 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8493,6 +8493,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
>  				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>  	}
> +
> +	migrate_finish();
> +
>  	if (ret < 0) {
>  		putback_movable_pages(&cc->migratepages);
>  		return ret;
> diff --git a/mm/swap.c b/mm/swap.c
> index 31b844d..97efc49 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -36,6 +36,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/page_idle.h>
>  #include <linux/local_lock.h>
> +#include <linux/buffer_head.h>
>  
>  #include "internal.h"
>  
> @@ -759,6 +760,8 @@ void lru_add_drain_all(void)
>  	if (WARN_ON(!mm_percpu_wq))
>  		return;
>  
> +	invalidate_bh_lrus();

Instead of adding a new IPI there, how about adding need_bh_lru_drain(cpu)
in lru_add_drain_all and then calls invalidate_bh_lru in lru_add_drain_cpu?
Not a strong but looks like more harmonized with existing LRU draining
code.

Thanks for the work.
