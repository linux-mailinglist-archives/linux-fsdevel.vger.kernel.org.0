Return-Path: <linux-fsdevel+bounces-32998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C439B1479
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 05:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712931C22C01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 03:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED451632C2;
	Sat, 26 Oct 2024 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INVc7CQQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326A374C4
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2024 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729915166; cv=none; b=EFyRjWgBpSz+nf4pe4ngF20WyZ5g4pQnBplw1K7cYPTupw9pi4AFeMPffjl7jIRU4g0r5gB6AszBzo/f7/+mVMfaOB3unSY7dbpUskRPpZ+Tbw2CUDvSPa89Hcl34PGbTNmk8FykonXjUaOqjLcWReWC5msVrL3gbgZWW4hM+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729915166; c=relaxed/simple;
	bh=pspOPZrWDcFcuQrVcV1mOQqaC17rfkv8K8cBaeNGar4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kL97smdNa7X1TIQsDE8EspHJPoKkLqt8Dw7VZX/+pvwKE7BGgrGNR9zdJeeaTrRqUnqHn2403ALgYneeG8qb935nEwKLmu2cmaJgzQXMV4cXMZwEKPTWoUpCECqoF+jB4556ntlVrLfRzWtr1SzrP9R9jiJvMvwTAnkfvzDt6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INVc7CQQ; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a4789662c1so772711137.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729915162; x=1730519962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KB/LcqBhsdnYUzdTisxph+TSCmdRKdSymSSUMenIBw=;
        b=INVc7CQQOGtMnxOKNGrs1OaO4lDV1Dt1T6zcOdU2yShpEKJ2gHjMjFzh6UdRkSgTCl
         VUmSaXiOfbP+pKXIuf2xiqxzFlUPF1Fgs59pwIKkoagp4CIg3nq9SV2q0hSn8p/4Wsbp
         yBUscL5QfiPD0hFdP5ZMjZPOo7Q4u+ejnKPr0LJjHR9g/73CjE2z9KMt9SjHzCt4aNpS
         mWwI11BoSgrEvg7JiBBw5rucUl+oMyP0sP2Y+WNCc3AWthdo8vz9s8wlktN0lZf2Makz
         g7Suv86wXZCM9gyDZFbSI0Th34wE0qszkcyq46aFq7UL2GFR7lic/XKBDWzN/gK5iLCk
         G6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729915162; x=1730519962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KB/LcqBhsdnYUzdTisxph+TSCmdRKdSymSSUMenIBw=;
        b=OWwCp2sz6mP6fA7wAGu90M2Xuk7HxKzPqN3meSSFvBaeb7Klw8lWfVphvNXl8cfH0I
         jxzx15aNyLzOoK7ma4V4IBRYRhhOWd2Bkl4kmUh+wdtGZda/gfZqqEtIsm/wMu49P9zc
         Z57n6vSSE18NbiRygjGuBPNKpFb6VHQwxJDP6aRX1KHOt9yv78nXZo7ff/mbkLHpfJi2
         Z8uy1SwOQwNwUKtwhYBPK+cw9IqgzvH7kRpMWJjUMCAINCaYtIb4NYw/cvlNiaOeEQ7O
         dMNCrUxoacM+ee5g858Uja5XplmQhcpforvOHU7ymf/6AlAF96N3c7IOhT85pEc7EHrd
         qW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtJoSe+CDuwaFAZOgcscHCshLeqTGySzkTVt1pNwwnbU8seO/LTF1pREr/7qoU80Xl9tD/WConJqegZZSq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywskotx27SNjnCRcxolkYeozqu2dVDemNSYtBBcrk0jhoaz31Dl
	jD+p0xkj0hgN+u0t0THw6YQV70IAXKM7qgK4rtX1aPTwLYW4zlwKf+fqQWyhlXWePJlJqnEchXq
	Ig0G2jpZnZZZKxKrScCxeDwpmrtOW5Qj2ZtK+
X-Google-Smtp-Source: AGHT+IGAOdbwDufxdTWY1PatysXL3lH/4WN/WWRD5cb5neztcqlyDvKK0fc7DMPGOOKjO4i7Nn22hw0cAdo0dtH19WM=
X-Received: by 2002:a05:6102:160a:b0:4a4:8756:d899 with SMTP id
 ada2fe7eead31-4a8cfd723demr1233728137.29.1729915162377; Fri, 25 Oct 2024
 20:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev> <20241025012304.2473312-7-shakeel.butt@linux.dev>
In-Reply-To: <20241025012304.2473312-7-shakeel.butt@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 25 Oct 2024 21:58:45 -0600
Message-ID: <CAOUHufYgvcAvbGv_3rDhj_NX-ND-TMX_nyF7ZHQRW8ZxniObOQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] memcg-v1: remove memcg move locking code
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 7:23=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The memcg v1's charge move feature has been deprecated. All the places
> using the memcg move lock, have stopped using it as they don't need the
> protection any more. Let's proceed to remove all the locking code
> related to charge moving.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
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
>         /* For oom notifier event fd */
>         struct list_head oom_notify;
>
> -       /* taken only while moving_account > 0 */
> -       spinlock_t move_lock;
> -       unsigned long move_lock_flags;
> -
>         /* Legacy tcp memory accounting */
>         bool tcpmem_active;
>         int tcpmem_pressure;
>
> -       /*
> -        * set > 0 if pages under this cgroup are moving to other cgroup.
> -        */
> -       atomic_t moving_account;
> -       struct task_struct *move_lock_task;
> -
>         /* List of events which userspace want to receive */
>         struct list_head event_list;
>         spinlock_t event_list_lock;
> @@ -428,9 +418,7 @@ static inline struct obj_cgroup *__folio_objcg(struct=
 folio *folio)
>   *
>   * - the folio lock
>   * - LRU isolation
> - * - folio_memcg_lock()
>   * - exclusive reference
> - * - mem_cgroup_trylock_pages()
>   *
>   * For a kmem folio a caller should hold an rcu read lock to protect mem=
cg
>   * associated with a kmem folio from being released.
> @@ -499,9 +487,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(stru=
ct folio *folio)

I think you missed folio_memcg_rcu().

(I don't think workingset_activation() needs it, since its only caller
must hold a refcnt on the folio.)

>   *
>   * - the folio lock
>   * - LRU isolation
> - * - lock_folio_memcg()
>   * - exclusive reference
> - * - mem_cgroup_trylock_pages()
>   *
>   * For a kmem folio a caller should hold an rcu read lock to protect mem=
cg
>   * associated with a kmem folio from being released.
> @@ -1873,26 +1859,6 @@ static inline bool task_in_memcg_oom(struct task_s=
truct *p)
>         return p->memcg_in_oom;
>  }
>
> -void folio_memcg_lock(struct folio *folio);
> -void folio_memcg_unlock(struct folio *folio);
> -
> -/* try to stablize folio_memcg() for all the pages in a memcg */
> -static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
> -{
> -       rcu_read_lock();
> -
> -       if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account)=
)
> -               return true;
> -
> -       rcu_read_unlock();
> -       return false;
> -}
> -
> -static inline void mem_cgroup_unlock_pages(void)
> -{
> -       rcu_read_unlock();
> -}
> -
>  static inline void mem_cgroup_enter_user_fault(void)
>  {
>         WARN_ON(current->in_user_fault);
> @@ -1914,26 +1880,6 @@ unsigned long memcg1_soft_limit_reclaim(pg_data_t =
*pgdat, int order,
>         return 0;
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
> -       /* to match folio_memcg_rcu() */
> -       rcu_read_lock();
> -       return true;
> -}
> -
> -static inline void mem_cgroup_unlock_pages(void)
> -{
> -       rcu_read_unlock();
> -}
> -
>  static inline bool task_in_memcg_oom(struct task_struct *p)
>  {
>         return false;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 630a1c431ea1..e582a1545d2a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -119,7 +119,6 @@
>   *    ->i_pages lock           (folio_remove_rmap_pte->set_page_dirty)
>   *    bdi.wb->list_lock                (folio_remove_rmap_pte->set_page_=
dirty)
>   *    ->inode->i_lock          (folio_remove_rmap_pte->set_page_dirty)
> - *    ->memcg->move_lock       (folio_remove_rmap_pte->folio_memcg_lock)
>   *    bdi.wb->list_lock                (zap_pte_range->set_page_dirty)
>   *    ->inode->i_lock          (zap_pte_range->set_page_dirty)
>   *    ->private_lock           (zap_pte_range->block_dirty_folio)
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 9c0fba8c8a83..539ceefa9d2d 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -401,87 +401,6 @@ unsigned long memcg1_soft_limit_reclaim(pg_data_t *p=
gdat, int order,
>         return nr_reclaimed;
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
> -       struct mem_cgroup *memcg;
> -       unsigned long flags;
> -
> -       /*
> -        * The RCU lock is held throughout the transaction.  The fast
> -        * path can get away without acquiring the memcg->move_lock
> -        * because page moving starts with an RCU grace period.
> -         */
> -       rcu_read_lock();
> -
> -       if (mem_cgroup_disabled())
> -               return;
> -again:
> -       memcg =3D folio_memcg(folio);
> -       if (unlikely(!memcg))
> -               return;
> -
> -#ifdef CONFIG_PROVE_LOCKING
> -       local_irq_save(flags);
> -       might_lock(&memcg->move_lock);
> -       local_irq_restore(flags);
> -#endif
> -
> -       if (atomic_read(&memcg->moving_account) <=3D 0)
> -               return;
> -
> -       spin_lock_irqsave(&memcg->move_lock, flags);
> -       if (memcg !=3D folio_memcg(folio)) {
> -               spin_unlock_irqrestore(&memcg->move_lock, flags);
> -               goto again;
> -       }
> -
> -       /*
> -        * When charge migration first begins, we can have multiple
> -        * critical sections holding the fast-path RCU lock and one
> -        * holding the slowpath move_lock. Track the task who has the
> -        * move_lock for folio_memcg_unlock().
> -        */
> -       memcg->move_lock_task =3D current;
> -       memcg->move_lock_flags =3D flags;
> -}
> -
> -static void __folio_memcg_unlock(struct mem_cgroup *memcg)
> -{
> -       if (memcg && memcg->move_lock_task =3D=3D current) {
> -               unsigned long flags =3D memcg->move_lock_flags;
> -
> -               memcg->move_lock_task =3D NULL;
> -               memcg->move_lock_flags =3D 0;
> -
> -               spin_unlock_irqrestore(&memcg->move_lock, flags);
> -       }
> -
> -       rcu_read_unlock();
> -}
> -
> -/**
> - * folio_memcg_unlock - Release the binding between a folio and its memc=
g.
> - * @folio: The folio.
> - *
> - * This releases the binding created by folio_memcg_lock().  This does
> - * not change the accounting of this folio to its memcg, but it does
> - * permit others to change it.
> - */
> -void folio_memcg_unlock(struct folio *folio)
> -{
> -       __folio_memcg_unlock(folio_memcg(folio));
> -}
> -
>  static u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
>                                 struct cftype *cft)
>  {
> @@ -1189,7 +1108,6 @@ void memcg1_memcg_init(struct mem_cgroup *memcg)
>  {
>         INIT_LIST_HEAD(&memcg->oom_notify);
>         mutex_init(&memcg->thresholds_lock);
> -       spin_lock_init(&memcg->move_lock);
>         INIT_LIST_HEAD(&memcg->event_list);
>         spin_lock_init(&memcg->event_list_lock);
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 94279b9c766a..3c223aaeb6af 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1189,7 +1189,6 @@ void lruvec_memcg_debug(struct lruvec *lruvec, stru=
ct folio *folio)
>   * These functions are safe to use under any of the following conditions=
:
>   * - folio locked
>   * - folio_test_lru false
> - * - folio_memcg_lock()
>   * - folio frozen (refcount of 0)
>   *
>   * Return: The lruvec this folio is on with its lock held.
> @@ -1211,7 +1210,6 @@ struct lruvec *folio_lruvec_lock(struct folio *foli=
o)
>   * These functions are safe to use under any of the following conditions=
:
>   * - folio locked
>   * - folio_test_lru false
> - * - folio_memcg_lock()
>   * - folio frozen (refcount of 0)
>   *
>   * Return: The lruvec this folio is on with its lock held and interrupts
> @@ -1235,7 +1233,6 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *=
folio)
>   * These functions are safe to use under any of the following conditions=
:
>   * - folio locked
>   * - folio_test_lru false
> - * - folio_memcg_lock()
>   * - folio frozen (refcount of 0)
>   *
>   * Return: The lruvec this folio is on with its lock held and interrupts
> @@ -2375,9 +2372,7 @@ static void commit_charge(struct folio *folio, stru=
ct mem_cgroup *memcg)
>          *
>          * - the page lock
>          * - LRU isolation
> -        * - folio_memcg_lock()
>          * - exclusive reference
> -        * - mem_cgroup_trylock_pages()
>          */
>         folio->memcg_data =3D (unsigned long)memcg;
>  }
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4785a693857a..c6c4d4ea29a7 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -32,7 +32,6 @@
>   *                   swap_lock (in swap_duplicate, swap_info_get)
>   *                     mmlist_lock (in mmput, drain_mmlist and others)
>   *                     mapping->private_lock (in block_dirty_folio)
> - *                       folio_lock_memcg move_lock (in block_dirty_foli=
o)
>   *                         i_pages lock (widely used)
>   *                           lruvec->lru_lock (in folio_lruvec_lock_irq)
>   *                     inode->i_lock (in set_page_dirty's __mark_inode_d=
irty)
> --
> 2.43.5
>
>

