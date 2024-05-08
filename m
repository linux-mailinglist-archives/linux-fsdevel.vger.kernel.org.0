Return-Path: <linux-fsdevel+bounces-19030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDEB8BF79D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BE6281480
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816DD3E49C;
	Wed,  8 May 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ24DGvq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443E535C4;
	Wed,  8 May 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154580; cv=none; b=iBa6iz+ALOiyctJEfIAG7m1VqsPMHnP3JGNk8ZVBD7Dp8OxjJi0MMfG2hxQeyQryIy8h7m1fF8U4aXljttGinoo4sAJdcmTou4DOo9g8BLYiqB2S/WFn+PcmNvhlS4nMZXXVY/85ME3XMvS7yhCmXc9dHUFjKWG4o7nHdT58hWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154580; c=relaxed/simple;
	bh=qgEG3njGDyERCVmpynDvAcQrFyCvvjlb5Ekgf7r5MKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJJi2mu/F81icSuiaN71qTPx2kU7gMw/qIh2Y8IEBAFn84ykC6Zenm6ibG8nM8q/utj137mz5cXSER96MPHUkw160pPD5G9Ary1AKmx1pfMa+2GLoAf003lR8GlQJmi1O0X8FlxYnDapbXkCm0XHEhlkv9vUNVUoXIqMWTSJrsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ24DGvq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso44452241fa.2;
        Wed, 08 May 2024 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715154577; x=1715759377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umTDfnbL/dq64TqBpFCsgOhQUToEayhSSVPwVI4DrpI=;
        b=cZ24DGvqil+E9XQQ69duFSlLkjpF3irKLa9zMKRafI81g9KnxFJOKMh8BUkOFw6TVW
         gDqb/ZnNLv6HB+oEwNMbwhRNy5m0e9cT3OvGgb19BDsGlCCFMtKqukpblMFU50bqazPp
         6oFwoXa/dpmAD6X9OY90M2P7uJ93/MhQc19NB+cCjV6P3ZQiYMNeBG+6Yl5+hRZPsfru
         Vdcr74LiWe94SAhuABIZuP9HRjEewfq7olMalWGL6TFNBdxrHKSdCmmXj50oF1J8cuX2
         g7IX5MA9feJHVwuadKhDWkhRx2AibGRG6HFgDS0GUvZomnuI0fiqmXgna8pLY/l8Ja7o
         ygTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154577; x=1715759377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umTDfnbL/dq64TqBpFCsgOhQUToEayhSSVPwVI4DrpI=;
        b=jiSI39TpSTaM+mZ+cv6mkv6q1ULlTm08bDmTjiq6MHnFkccTv2O9zzKrpXCiJKui43
         1z/34O328bgB/7Q1ewXuDhKZGCoMVNuRpxOkyKadwbIHKVTkNii5FYSdi8UeLaNyr5Q0
         hZKCxdQcaO0OJB3hVD5XMV/gk4OwZccIJ8n3ghd/iHMaDn+K+12MJOEyPz62gR3LFgSe
         vEFfqpLkPL8fLkHpJsksXeRt0qPNKL7EXmwQHlPNYOqSmNrcNAT7t5b8DU6TQ0pptUNn
         TNt80Ht8EXLB75rEmecKhODMskaqEwq+8f6QSC2k6Z6bkPYxKEjxHS9u9g7YA2PbF7U2
         QEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHglUTOHttUOZ/aRoaX9mjKhrDe3134FVoOBdC7Li2gm2MGhw1M2aMsnw/HdhAkxvcGLzCnGlBpm8f4q8OOT2pAPdyWupPHf/uVG8HFApGDNWDHoXQoAkuTjCyO0u72Bs6+NF9VJJ0CyTGXg==
X-Gm-Message-State: AOJu0YxQ6D+noz8g64jxVueKm48CfrcfPKwyQApoxblrjTiIv6uuOCgv
	GlxI1EgfDHKCVaJ2XTI0w24LTyIwoZCozDE9vQM9CVKSDz7qBhpE0Jar8jFKdHF8Xr860M8sMoy
	+/PkrZeK7QbbbRaHZ/4joZKMy8Qw=
X-Google-Smtp-Source: AGHT+IGml2LS93vLekvZt0QIqNtoMt+ka3oiN9gq/tinwewdYfgF5mUz5MalXZDDuo0/fCQnO47chT2ANbe8sGK0bxY=
X-Received: by 2002:a2e:be09:0:b0:2e1:ebec:1ded with SMTP id
 38308e7fff4ca-2e447698ccemr11034991fa.25.1715154576730; Wed, 08 May 2024
 00:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502084609.28376-1-ryncsn@gmail.com> <20240502084939.30250-5-ryncsn@gmail.com>
 <874jb8lq8q.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <874jb8lq8q.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 8 May 2024 15:49:20 +0800
Message-ID: <CAMgjq7C8JCR-4Q0+XmK+JAXi72rNEdFfZvke-TWxuLN1UJBtaw@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] mm/swap: reduce swap cache search space
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 3:27=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently we use one swap_address_space for every 64M chunk to reduce l=
ock
> > contention, this is like having a set of smaller swap files inside one
> > swap device. But when doing swap cache look up or insert, we are
> > still using the offset of the whole large swap device. This is OK for
> > correctness, as the offset (key) is unique.
> >
> > But Xarray is specially optimized for small indexes, it creates the
> > radix tree levels lazily to be just enough to fit the largest key
> > stored in one Xarray. So we are wasting tree nodes unnecessarily.
> >
> > For 64M chunk it should only take at most 3 levels to contain everythin=
g. it should only take at most 3 levels to contain everything.
> > But if we are using the offset from the whole swap device, the offset (=
key)
> > value will be way beyond 64M, and so will the tree level.
> >
> > Optimize this by using a new helper swap_cache_index to get a swap
> > entry's unique offset in its own 64M swap_address_space.
> >
> > I see a ~1% performance gain in benchmark and actual workload with
> > high memory pressure.
> >
> > Test with `time memhog 128G` inside a 8G memcg using 128G swap (ramdisk
> > with SWP_SYNCHRONOUS_IO dropped, tested 3 times, results are stable. Th=
e
> > test result is similar but the improvement is smaller if SWP_SYNCHRONOU=
S_IO
> > is enabled, as swap out path can never skip swap cache):
> >
> > Before:
> > 6.07user 250.74system 4:17.26elapsed 99%CPU (0avgtext+0avgdata 8373376m=
axresident)k
> > 0inputs+0outputs (55major+33555018minor)pagefaults 0swaps
> >
> > After (1.8% faster):
> > 6.08user 246.09system 4:12.58elapsed 99%CPU (0avgtext+0avgdata 8373248m=
axresident)k
> > 0inputs+0outputs (54major+33555027minor)pagefaults 0swaps
> >
> > Similar result with MySQL and sysbench using swap:
> > Before:
> > 94055.61 qps
> >
> > After (0.8% faster):
> > 94834.91 qps
> >
> > Radix tree slab usage is also very slightly lower.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/huge_memory.c |  2 +-
> >  mm/memcontrol.c  |  2 +-
> >  mm/mincore.c     |  2 +-
> >  mm/shmem.c       |  2 +-
> >  mm/swap.h        | 15 +++++++++++++++
> >  mm/swap_state.c  | 19 ++++++++++---------
> >  mm/swapfile.c    |  6 +++---
> >  7 files changed, 32 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d35d526ed48f..45829cc049d2 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2918,7 +2918,7 @@ static void __split_huge_page(struct page *page, =
struct list_head *list,
> >       split_page_memcg(head, order, new_order);
> >
> >       if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> > -             offset =3D swp_offset(folio->swap);
> > +             offset =3D swap_cache_index(folio->swap);
> >               swap_cache =3D swap_address_space(folio->swap);
> >               xa_lock(&swap_cache->i_pages);
> >       }
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index d11536ef59ef..81b005c459cb 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6165,7 +6165,7 @@ static struct page *mc_handle_swap_pte(struct vm_=
area_struct *vma,
> >        * Because swap_cache_get_folio() updates some statistics counter=
,
> >        * we call find_get_page() with swapper_space directly.
> >        */
> > -     page =3D find_get_page(swap_address_space(ent), swp_offset(ent));
> > +     page =3D find_get_page(swap_address_space(ent), swap_cache_index(=
ent));
> >       entry->val =3D ent.val;
> >
> >       return page;
> > diff --git a/mm/mincore.c b/mm/mincore.c
> > index dad3622cc963..e31cf1bde614 100644
> > --- a/mm/mincore.c
> > +++ b/mm/mincore.c
> > @@ -139,7 +139,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned l=
ong addr, unsigned long end,
> >                       } else {
> >  #ifdef CONFIG_SWAP
> >                               *vec =3D mincore_page(swap_address_space(=
entry),
> > -                                                 swp_offset(entry));
> > +                                                 swap_cache_index(entr=
y));
> >  #else
> >                               WARN_ON(1);
> >                               *vec =3D 1;
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index fa2a0ed97507..326315c12feb 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1756,7 +1756,7 @@ static int shmem_replace_folio(struct folio **fol=
iop, gfp_t gfp,
> >
> >       old =3D *foliop;
> >       entry =3D old->swap;
> > -     swap_index =3D swp_offset(entry);
> > +     swap_index =3D swap_cache_index(entry);
> >       swap_mapping =3D swap_address_space(entry);
> >
> >       /*
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 82023ab93205..93e3e1b58a7f 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -27,6 +27,7 @@ void __swap_writepage(struct folio *folio, struct wri=
teback_control *wbc);
> >  /* One swap address space for each 64M swap space */
> >  #define SWAP_ADDRESS_SPACE_SHIFT     14
> >  #define SWAP_ADDRESS_SPACE_PAGES     (1 << SWAP_ADDRESS_SPACE_SHIFT)
> > +#define SWAP_ADDRESS_SPACE_MASK              (BIT(SWAP_ADDRESS_SPACE_S=
HIFT) - 1)
>
> #define SWAP_ADDRESS_SPACE_MASK         (SWAP_ADDRESS_SPACE_PAGES - 1)
> ?
>
> We can use BIT() in SWAP_ADDRESS_SPACE_PAGES definition.
>

I'll just use (SWAP_ADDRESS_SPACE_PAGES - 1) then, I was trying to
make the changes minimal, but prefered the BIT macro, a trivial
change.

> >  extern struct address_space *swapper_spaces[];
> >  #define swap_address_space(entry)                        \
> >       (&swapper_spaces[swp_type(entry)][swp_offset(entry) \
> > @@ -40,6 +41,15 @@ static inline loff_t swap_dev_pos(swp_entry_t entry)
> >       return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
> >  }
> >
> > +/*
> > + * Return the swap cache index of the swap entry.
> > + */
> > +static inline pgoff_t swap_cache_index(swp_entry_t entry)
> > +{
> > +     BUILD_BUG_ON((SWP_OFFSET_MASK | SWAP_ADDRESS_SPACE_MASK) !=3D SWP=
_OFFSET_MASK);
> > +     return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
> > +}
> > +
> >  void show_swap_cache_info(void);
> >  bool add_to_swap(struct folio *folio);
> >  void *get_shadow_from_swap_cache(swp_entry_t entry);
> > @@ -86,6 +96,11 @@ static inline struct address_space *swap_address_spa=
ce(swp_entry_t entry)
> >       return NULL;
> >  }
> >
> > +static inline pgoff_t swap_cache_index(swp_entry_t entry)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline void show_swap_cache_info(void)
> >  {
> >  }
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 642c30d8376c..09415d4c7843 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -72,7 +72,7 @@ void show_swap_cache_info(void)
> >  void *get_shadow_from_swap_cache(swp_entry_t entry)
> >  {
> >       struct address_space *address_space =3D swap_address_space(entry)=
;
> > -     pgoff_t idx =3D swp_offset(entry);
> > +     pgoff_t idx =3D swap_cache_index(entry);
> >       void *shadow;
> >
> >       shadow =3D xa_load(&address_space->i_pages, idx);
> > @@ -89,7 +89,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_=
t entry,
> >                       gfp_t gfp, void **shadowp)
> >  {
> >       struct address_space *address_space =3D swap_address_space(entry)=
;
> > -     pgoff_t idx =3D swp_offset(entry);
> > +     pgoff_t idx =3D swap_cache_index(entry);
> >       XA_STATE_ORDER(xas, &address_space->i_pages, idx, folio_order(fol=
io));
> >       unsigned long i, nr =3D folio_nr_pages(folio);
> >       void *old;
> > @@ -144,7 +144,7 @@ void __delete_from_swap_cache(struct folio *folio,
> >       struct address_space *address_space =3D swap_address_space(entry)=
;
> >       int i;
> >       long nr =3D folio_nr_pages(folio);
> > -     pgoff_t idx =3D swp_offset(entry);
> > +     pgoff_t idx =3D swap_cache_index(entry);
> >       XA_STATE(xas, &address_space->i_pages, idx);
> >
> >       xas_set_update(&xas, workingset_update_node);
> > @@ -248,18 +248,19 @@ void delete_from_swap_cache(struct folio *folio)
> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >                               unsigned long end)
> >  {
> > -     unsigned long curr =3D begin;
> > +     unsigned long curr =3D begin, offset;
>
> Better to rename "offset" as "index" to avoid confusion?

Good idea.

> >       void *old;
> >
> >       for (;;) {
> > +             offset =3D curr & SWAP_ADDRESS_SPACE_MASK;
> >               swp_entry_t entry =3D swp_entry(type, curr);
> >               struct address_space *address_space =3D swap_address_spac=
e(entry);
> > -             XA_STATE(xas, &address_space->i_pages, curr);
> > +             XA_STATE(xas, &address_space->i_pages, offset);
> >
> >               xas_set_update(&xas, workingset_update_node);
> >
> >               xa_lock_irq(&address_space->i_pages);
> > -             xas_for_each(&xas, old, end) {
> > +             xas_for_each(&xas, old, offset + min(end - curr, SWAP_ADD=
RESS_SPACE_PAGES)) {
>
> Is there a bug in the original code?  It doesn't check SWAP_ADDRESS_SPACE=
_PAGES.

That's OK, if the (end - curr) goes above SWAP_ADDRESS_SPACE_PAGES, it
means all content in current address_space needs to be purged.
xas_for_each will stop after it iterated all content in the current
address space. This is a bit hackish though.

>
> And should it be changed to
>
>         xas_for_each(&xas, old, min(offset + end - curr, SWAP_ADDRESS_SPA=
CE_PAGES))

It should be equivalent, as described above, but yeah, this looks
cleaner. I'll use your suggested code.

> ?
>
> >                       if (!xa_is_value(old))
> >                               continue;
> >                       xas_store(&xas, NULL);
> > @@ -350,7 +351,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entr=
y,
> >  {
> >       struct folio *folio;
> >
> > -     folio =3D filemap_get_folio(swap_address_space(entry), swp_offset=
(entry));
> > +     folio =3D filemap_get_folio(swap_address_space(entry), swap_cache=
_index(entry));
> >       if (!IS_ERR(folio)) {
> >               bool vma_ra =3D swap_use_vma_readahead();
> >               bool readahead;
> > @@ -420,7 +421,7 @@ struct folio *filemap_get_incore_folio(struct addre=
ss_space *mapping,
> >       si =3D get_swap_device(swp);
> >       if (!si)
> >               return ERR_PTR(-ENOENT);
> > -     index =3D swp_offset(swp);
> > +     index =3D swap_cache_index(swp);
> >       folio =3D filemap_get_folio(swap_address_space(swp), index);
> >       put_swap_device(si);
> >       return folio;
> > @@ -447,7 +448,7 @@ struct folio *__read_swap_cache_async(swp_entry_t e=
ntry, gfp_t gfp_mask,
> >                * that would confuse statistics.
> >                */
> >               folio =3D filemap_get_folio(swap_address_space(entry),
> > -                                             swp_offset(entry));
> > +                                       swap_cache_index(entry));
> >               if (!IS_ERR(folio))
> >                       goto got_folio;
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 0b0ae6e8c764..4f0e8b2ac8aa 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -142,7 +142,7 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
> >       struct folio *folio;
> >       int ret =3D 0;
> >
> > -     folio =3D filemap_get_folio(swap_address_space(entry), offset);
> > +     folio =3D filemap_get_folio(swap_address_space(entry), swap_cache=
_index(entry));
> >       if (IS_ERR(folio))
> >               return 0;
> >       /*
> > @@ -2158,7 +2158,7 @@ static int try_to_unuse(unsigned int type)
> >              (i =3D find_next_to_unuse(si, i)) !=3D 0) {
> >
> >               entry =3D swp_entry(type, i);
> > -             folio =3D filemap_get_folio(swap_address_space(entry), i)=
;
> > +             folio =3D filemap_get_folio(swap_address_space(entry), sw=
ap_cache_index(entry));
> >               if (IS_ERR(folio))
> >                       continue;
> >
> > @@ -3476,7 +3476,7 @@ EXPORT_SYMBOL_GPL(swapcache_mapping);
> >
> >  pgoff_t __folio_swap_cache_index(struct folio *folio)
> >  {
> > -     return swp_offset(folio->swap);
> > +     return swap_cache_index(folio->swap);
> >  }
> >  EXPORT_SYMBOL_GPL(__folio_swap_cache_index);

Thanks for the suggestions!

>
> --
> Best Regards,
> Huang, Ying

