Return-Path: <linux-fsdevel+bounces-32856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA519AFA86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EEDB21951
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4EA1B3942;
	Fri, 25 Oct 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gEzTynn8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587B1B2180
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839597; cv=none; b=A3ki1tAetsuUszh18p34qNx7atWvFpbKKoBR6aMBMjWdCK3bYitw8/KP5+mnKdcH0fmZPy02hZ1Zha97iycqeNAqOe4EHjQos6S6bYme2Icd+1pIbbj5jE92aEbmIYsnAFJXNsDPnXY61G5uKKIe2HGYyE+8NAlI6b16x3xJZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839597; c=relaxed/simple;
	bh=s+QgsBk4XPagi2ax1zsfB1zGpI78D2Ce8ZdU2tw09qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEFbQ+fsqe7Yo/hIA8AK5EsgwQfGo9zQ7Odv758f1vYmp26JSejAE/3yrdaM8TUS4lOo3hbuWZT0Wc0xHMIIsFINhKRwxXwa+Uqsz19Kf7Nof5rTNzYodgjg6HLXHIRiky5gYIif9tF1QWITq7pIrSNd05V7SejOmx8cC2YHBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gEzTynn8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43159c9f617so17056685e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729839591; x=1730444391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNlDlbGnZjEseQwHJzCTTzalLqX7nd5y80oKxZwRmOg=;
        b=gEzTynn8w4c3RBlbDZBVb5bPg9mXwzzYpGbuvIK/P2YSPZxSMFj0unumtFiLBt/cAQ
         N9DqY/U9YnQi9/XBFThoFq6AoxdwFq7GfaTZEMi3O23m5mXPEcOKSHsbrjJDsgrQNf3E
         dASVnXt1Mag1mvrHQbooQcrkgeppsxlBEPSv791k+QYDcul4eEohh7INyOr2iu0VZpqm
         /PWxPMj4xdaNlP7fhC2W42C4+gNlGM5iJW5Lihrb3nOb8EgizxeSiVJ1mKdT8OFo2XxA
         El+JZq57ZEYvYk/NQjF5kLFno1XbrSdMx4F+d7XUFnjoRslnggL+FCsZ0m29YHt3umo+
         sZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839591; x=1730444391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNlDlbGnZjEseQwHJzCTTzalLqX7nd5y80oKxZwRmOg=;
        b=bDGa3SN25nmOiYdGx62PNbmyGWGxPx5NRGNY7sbKMfo+WgJWJNHjIP8FLbvBApOVO4
         oOCA4LWcC03YOB3I11vIDBoXZ8IlRkwVwHx/T2gW8L/lNUIYmwj++5Lffku/ND3mIomL
         REEJOMqfOOkpWD7l38jUq2z8lz6y+LsVxWi+dhFPU23qPd3aogIV8MEOKju9ZL3YuS02
         zxRnNSuC8o7DfmybhUjm8EqYViTSem2mImXcfnMs+q2FaxNvoWPM3NQVBAKhgAlkKCXY
         +atIGQQSH5CxvL58U6C90hDrHtJK9mpvxefU+UUO3UG6JkmhU22qrEOYPMjn3wWiHNYB
         bo7w==
X-Forwarded-Encrypted: i=1; AJvYcCVQCmAVpniZ/U4cIED/JfCW3w278+qP6NsElhJXcs9j+spC1xH5AdW3139aomGYL/dKmP5G+BjhpdktovgZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQHpq5a03+xASSu4IDnIbCibbH2/oGTH89husH0Gpl0jtLb4/
	nkn47bkyszyNITbgifqVIbNp2VXwf3ducSPBK1NfF7WFf0Ek61PP0Y0PR54JDwQ=
X-Google-Smtp-Source: AGHT+IEz5go4s70yRgnb7sCkqqL1NoAbqlFuG3nuWrwbpPPRkMbsbBXXdAzPHGvjE01RqknnfC54XQ==
X-Received: by 2002:adf:f98b:0:b0:37d:5130:b384 with SMTP id ffacd0b85a97d-380458967dbmr3018377f8f.35.1729839591527;
        Thu, 24 Oct 2024 23:59:51 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bde6sm765004f8f.40.2024.10.24.23.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:59:51 -0700 (PDT)
Date: Fri, 25 Oct 2024 08:59:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 6/6] memcg-v1: remove memcg move locking code
Message-ID: <ZxtB5hosqhv2UkP5@tiehlicka>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-7-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-7-shakeel.butt@linux.dev>

On Thu 24-10-24 18:23:03, Shakeel Butt wrote:
> The memcg v1's charge move feature has been deprecated. All the places
> using the memcg move lock, have stopped using it as they don't need the
> protection any more. Let's proceed to remove all the locking code
> related to charge moving.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Thank you for restructuring this. Having all callers gone by now
certainly makes this much safer and easier to review.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> Changes since RFC:
> - Remove the memcg move locking in separate patches.
> 
>  include/linux/memcontrol.h | 54 -------------------------
>  mm/filemap.c               |  1 -
>  mm/memcontrol-v1.c         | 82 --------------------------------------
>  mm/memcontrol.c            |  5 ---
>  mm/rmap.c                  |  1 -
>  5 files changed, 143 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 798db70b0a30..932534291ca2 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -299,20 +299,10 @@ struct mem_cgroup {
>  	/* For oom notifier event fd */
>  	struct list_head oom_notify;
>  
> -	/* taken only while moving_account > 0 */
> -	spinlock_t move_lock;
> -	unsigned long move_lock_flags;
> -
>  	/* Legacy tcp memory accounting */
>  	bool tcpmem_active;
>  	int tcpmem_pressure;
>  
> -	/*
> -	 * set > 0 if pages under this cgroup are moving to other cgroup.
> -	 */
> -	atomic_t moving_account;
> -	struct task_struct *move_lock_task;
> -
>  	/* List of events which userspace want to receive */
>  	struct list_head event_list;
>  	spinlock_t event_list_lock;
> @@ -428,9 +418,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
>   *
>   * - the folio lock
>   * - LRU isolation
> - * - folio_memcg_lock()
>   * - exclusive reference
> - * - mem_cgroup_trylock_pages()
>   *
>   * For a kmem folio a caller should hold an rcu read lock to protect memcg
>   * associated with a kmem folio from being released.
> @@ -499,9 +487,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>   *
>   * - the folio lock
>   * - LRU isolation
> - * - lock_folio_memcg()
>   * - exclusive reference
> - * - mem_cgroup_trylock_pages()
>   *
>   * For a kmem folio a caller should hold an rcu read lock to protect memcg
>   * associated with a kmem folio from being released.
> @@ -1873,26 +1859,6 @@ static inline bool task_in_memcg_oom(struct task_struct *p)
>  	return p->memcg_in_oom;
>  }
>  
> -void folio_memcg_lock(struct folio *folio);
> -void folio_memcg_unlock(struct folio *folio);
> -
> -/* try to stablize folio_memcg() for all the pages in a memcg */
> -static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> -{
> -	rcu_read_lock();
> -
> -	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
> -		return true;
> -
> -	rcu_read_unlock();
> -	return false;
> -}
> -
> -static inline void mem_cgroup_unlock_pages(void)
> -{
> -	rcu_read_unlock();
> -}
> -
>  static inline void mem_cgroup_enter_user_fault(void)
>  {
>  	WARN_ON(current->in_user_fault);
> @@ -1914,26 +1880,6 @@ unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	return 0;
>  }
>  
> -static inline void folio_memcg_lock(struct folio *folio)
> -{
> -}
> -
> -static inline void folio_memcg_unlock(struct folio *folio)
> -{
> -}
> -
> -static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> -{
> -	/* to match folio_memcg_rcu() */
> -	rcu_read_lock();
> -	return true;
> -}
> -
> -static inline void mem_cgroup_unlock_pages(void)
> -{
> -	rcu_read_unlock();
> -}
> -
>  static inline bool task_in_memcg_oom(struct task_struct *p)
>  {
>  	return false;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 630a1c431ea1..e582a1545d2a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -119,7 +119,6 @@
>   *    ->i_pages lock		(folio_remove_rmap_pte->set_page_dirty)
>   *    bdi.wb->list_lock		(folio_remove_rmap_pte->set_page_dirty)
>   *    ->inode->i_lock		(folio_remove_rmap_pte->set_page_dirty)
> - *    ->memcg->move_lock	(folio_remove_rmap_pte->folio_memcg_lock)
>   *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
>   *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
>   *    ->private_lock		(zap_pte_range->block_dirty_folio)
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 9c0fba8c8a83..539ceefa9d2d 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -401,87 +401,6 @@ unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	return nr_reclaimed;
>  }
>  
> -/**
> - * folio_memcg_lock - Bind a folio to its memcg.
> - * @folio: The folio.
> - *
> - * This function prevents unlocked LRU folios from being moved to
> - * another cgroup.
> - *
> - * It ensures lifetime of the bound memcg.  The caller is responsible
> - * for the lifetime of the folio.
> - */
> -void folio_memcg_lock(struct folio *folio)
> -{
> -	struct mem_cgroup *memcg;
> -	unsigned long flags;
> -
> -	/*
> -	 * The RCU lock is held throughout the transaction.  The fast
> -	 * path can get away without acquiring the memcg->move_lock
> -	 * because page moving starts with an RCU grace period.
> -         */
> -	rcu_read_lock();
> -
> -	if (mem_cgroup_disabled())
> -		return;
> -again:
> -	memcg = folio_memcg(folio);
> -	if (unlikely(!memcg))
> -		return;
> -
> -#ifdef CONFIG_PROVE_LOCKING
> -	local_irq_save(flags);
> -	might_lock(&memcg->move_lock);
> -	local_irq_restore(flags);
> -#endif
> -
> -	if (atomic_read(&memcg->moving_account) <= 0)
> -		return;
> -
> -	spin_lock_irqsave(&memcg->move_lock, flags);
> -	if (memcg != folio_memcg(folio)) {
> -		spin_unlock_irqrestore(&memcg->move_lock, flags);
> -		goto again;
> -	}
> -
> -	/*
> -	 * When charge migration first begins, we can have multiple
> -	 * critical sections holding the fast-path RCU lock and one
> -	 * holding the slowpath move_lock. Track the task who has the
> -	 * move_lock for folio_memcg_unlock().
> -	 */
> -	memcg->move_lock_task = current;
> -	memcg->move_lock_flags = flags;
> -}
> -
> -static void __folio_memcg_unlock(struct mem_cgroup *memcg)
> -{
> -	if (memcg && memcg->move_lock_task == current) {
> -		unsigned long flags = memcg->move_lock_flags;
> -
> -		memcg->move_lock_task = NULL;
> -		memcg->move_lock_flags = 0;
> -
> -		spin_unlock_irqrestore(&memcg->move_lock, flags);
> -	}
> -
> -	rcu_read_unlock();
> -}
> -
> -/**
> - * folio_memcg_unlock - Release the binding between a folio and its memcg.
> - * @folio: The folio.
> - *
> - * This releases the binding created by folio_memcg_lock().  This does
> - * not change the accounting of this folio to its memcg, but it does
> - * permit others to change it.
> - */
> -void folio_memcg_unlock(struct folio *folio)
> -{
> -	__folio_memcg_unlock(folio_memcg(folio));
> -}
> -
>  static u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
>  				struct cftype *cft)
>  {
> @@ -1189,7 +1108,6 @@ void memcg1_memcg_init(struct mem_cgroup *memcg)
>  {
>  	INIT_LIST_HEAD(&memcg->oom_notify);
>  	mutex_init(&memcg->thresholds_lock);
> -	spin_lock_init(&memcg->move_lock);
>  	INIT_LIST_HEAD(&memcg->event_list);
>  	spin_lock_init(&memcg->event_list_lock);
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 94279b9c766a..3c223aaeb6af 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1189,7 +1189,6 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
>   * These functions are safe to use under any of the following conditions:
>   * - folio locked
>   * - folio_test_lru false
> - * - folio_memcg_lock()
>   * - folio frozen (refcount of 0)
>   *
>   * Return: The lruvec this folio is on with its lock held.
> @@ -1211,7 +1210,6 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
>   * These functions are safe to use under any of the following conditions:
>   * - folio locked
>   * - folio_test_lru false
> - * - folio_memcg_lock()
>   * - folio frozen (refcount of 0)
>   *
>   * Return: The lruvec this folio is on with its lock held and interrupts
> @@ -1235,7 +1233,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
>   * These functions are safe to use under any of the following conditions:
>   * - folio locked
>   * - folio_test_lru false
> - * - folio_memcg_lock()
>   * - folio frozen (refcount of 0)
>   *
>   * Return: The lruvec this folio is on with its lock held and interrupts
> @@ -2375,9 +2372,7 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  	 *
>  	 * - the page lock
>  	 * - LRU isolation
> -	 * - folio_memcg_lock()
>  	 * - exclusive reference
> -	 * - mem_cgroup_trylock_pages()
>  	 */
>  	folio->memcg_data = (unsigned long)memcg;
>  }
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4785a693857a..c6c4d4ea29a7 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -32,7 +32,6 @@
>   *                   swap_lock (in swap_duplicate, swap_info_get)
>   *                     mmlist_lock (in mmput, drain_mmlist and others)
>   *                     mapping->private_lock (in block_dirty_folio)
> - *                       folio_lock_memcg move_lock (in block_dirty_folio)
>   *                         i_pages lock (widely used)
>   *                           lruvec->lru_lock (in folio_lruvec_lock_irq)
>   *                     inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> -- 
> 2.43.5

-- 
Michal Hocko
SUSE Labs

