Return-Path: <linux-fsdevel+bounces-58413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42422B2E859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB5A7B98C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F02DCBE6;
	Wed, 20 Aug 2025 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="cP0Bgbwz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ce//kq7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443372DBF45;
	Wed, 20 Aug 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730315; cv=none; b=lnZFyQqkAx2TpdrlYDhx359Yxxs5zFExNrBjA3BkQQ0FT3vxrykRD037qPFSxihyyi+HQGyKiWG5FXZBQYiJMrCZgszhUdJv1ZWrMGXm3Wxr0a/9kNq6KYyQ8TEuFNiIFzWJKze5EVG8XI9XMboxr2pu5y1f9EpCai/KXZOSVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730315; c=relaxed/simple;
	bh=endgv1r6paCfgpgVmPvqYtY/kEYVe27uOVJ78MhT2mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgo2Ft/bFNdjzW4Rd+U0ociHZ7CgCS9vjbHg0EA9/V7gsnzNN7PRxHtVfrUQIXZhqG7+K2FEdtKRrNJJ3NwL9JzGbfIn49ErOLHF6TDZLT9HGfQGS7Wrrjs6MkSTRNrF/6k/Ppz62oDnG18dhFFKXjAHpnPi2IN8YbQL7M4zwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=cP0Bgbwz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ce//kq7w; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 68C65EC00EA;
	Wed, 20 Aug 2025 18:51:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 Aug 2025 18:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755730311; x=1755816711; bh=GYELK3sLAe
	m5w454Cp/0n0CLOcN6EiAn4tEXPGWU5nI=; b=cP0Bgbwzu3+6hwtQG48A2+dYdx
	YJjsh+zmOTPVpqLe9Nx13lCpp9THO8DfEln2+TNmHfhWv00HAARfrY0qvnZgHFqK
	fIcxwgt4PsOaQ8wRFq/wxB1zE583sAgKSq7GLF2+jDXplzQ0voSqeV/jDwDM0HYf
	vjakcQFa8kiHauzQTBe9sfKNYsPAQCtMUOgkakw3Xl4cHCIFybW00eiloWdggEnI
	2QtTemCdoyn14jEFbwoPgQ5hvlwTdTX0V5dOhzXhJdds3mbDgFyvZNI1k1B3aQcB
	9hr1JlJn6X66uwvzlS27CXdg49qCAhQXlFq0p1FFlruFsPfgf1qmYTEfTRMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755730311; x=1755816711; bh=GYELK3sLAem5w454Cp/0n0CLOcN6EiAn4tE
	XPGWU5nI=; b=Ce//kq7wQq8mydfRtrd6xPATHXC0CaxTSBGcIDS3GshZCkX0AVn
	XcmB0UpPK0JllH4S7LXYwX5CphbzZTKy9pB/Abh+HvJIjfN3OpSyXR3CjKArw7Z0
	J9ftBUuVFncUyWpR5P9ADZxZXDR6UPW9OhGcPatgHwxMXt5dYo6TR7BQf6rzO+jp
	jKWzguCbu7+ox5qQec5fMoDDqwFBp6HyN+NQsmzDUmc+Qdcl0kT6bPzdqPTqfg9j
	fIzRPMEnGPIWnju+yojqwz+unIPctmoqdEd4Zk67O6Yc7YqFIoMcPObWSQwBPUJ3
	FMAbEnLHCppAqQtKwKkHkDJwjBqANE8r+tw==
X-ME-Sender: <xms:hlGmaKSxGC3FYSS7H6W9_aydyJs2D3UGfYa39fP45BBtvxKPa1ShQw>
    <xme:hlGmaJ0FN_f3OaVw7U4LzQNvDx9lSTR4wdxvOaVwwwOB5v_VSAWoz37boaToGsDZF
    qpDAqcDhFJ_AmxlDNg>
X-ME-Received: <xmr:hlGmaMy93hHk98iqNWaZilbwJwpTqYWqEbrwzS46a7Wtop2n0l1xewxlD_ZkpqWRUkGnhVVL9IhHurS7tVH1KENVsrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtd
    fhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedu
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhlrghrrghsmhhoughinhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepshhh
    rghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepfihquhesshhush
    gvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:hlGmaNz6WRSWIAhCgO8woQrsZB9VtDwzmr9ooW4fa1mN0e4iZS8G_w>
    <xmx:hlGmaA9rRyrPI6FzNszrm3M4ohbKIm0TalcxKZvEBhczSOdX6G97hQ>
    <xmx:hlGmaP9c46Xza_41e5AHbtATa74vqczDVDazFo4au5xcjufUn9ljTw>
    <xmx:hlGmaA767_SLPq0-lEMAritrualcYWUA3zRC2UptXgPA1Vvpyg--zQ>
    <xmx:h1GmaN2ANOqIQNNYqhAAY2z3M40RsXB-fVZPduHqyqHxg2k_n6kEu6TT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 18:51:50 -0400 (EDT)
Date: Wed, 20 Aug 2025 15:52:22 -0700
From: Boris Burkov <boris@bur.io>
To: Klara Modin <klarasmodin@gmail.com>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, shakeel.butt@linux.dev, wqu@suse.com,
	willy@infradead.org, mhocko@kernel.org, muchun.song@linux.dev,
	roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Message-ID: <20250820225222.GA4100662@zen.localdomain>
References: <cover.1755562487.git.boris@bur.io>
 <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
 <hbdekl37pkdsvdvzgsz5prg5nlmyr67zrkqgucq3gdtepqjilh@ovc6untybhbg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hbdekl37pkdsvdvzgsz5prg5nlmyr67zrkqgucq3gdtepqjilh@ovc6untybhbg>

On Thu, Aug 21, 2025 at 12:06:42AM +0200, Klara Modin wrote:
> Hi,
> 
> On 2025-08-18 17:36:53 -0700, Boris Burkov wrote:
> > Btrfs currently tracks its metadata pages in the page cache, using a
> > fake inode (fs_info->btree_inode) with offsets corresponding to where
> > the metadata is stored in the filesystem's full logical address space.
> > 
> > A consequence of this is that when btrfs uses filemap_add_folio(), this
> > usage is charged to the cgroup of whichever task happens to be running
> > at the time. These folios don't belong to any particular user cgroup, so
> > I don't think it makes much sense for them to be charged in that way.
> > Some negative consequences as a result:
> > - A task can be holding some important btrfs locks, then need to lookup
> >   some metadata and go into reclaim, extending the duration it holds
> >   that lock for, and unfairly pushing its own reclaim pain onto other
> >   cgroups.
> > - If that cgroup goes into reclaim, it might reclaim these folios a
> >   different non-reclaiming cgroup might need soon. This is naturally
> >   offset by LRU reclaim, but still.
> > 
> > A very similar proposal to use the root cgroup was previously made by
> > Qu, where he eventually proposed the idea of setting it per
> > address_space. This makes good sense for the btrfs use case, as the
> > uncharged behavior should apply to all use of the address_space, not
> > select allocations. I.e., if someone adds another filemap_add_folio()
> > call using btrfs's btree_inode, we would almost certainly want the
> > uncharged behavior.
> > 
> > Link: https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
> > Suggested-by: Qu Wenruo <wqu@suse.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Tested-by: syzbot@syzkaller.appspotmail.com
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> I bisected the following null-dereference to 3f31e0d9912d ("btrfs: set
> AS_UNCHARGED on the btree_inode") in mm-new but I believe it's a result of
> this patch:
> 
>  Oops [#1]
>  CPU: 4 UID: 0 PID: 87 Comm: kswapd0 Not tainted 6.17.0-rc2-next-20250820-00349-gd6ecef4f9566 #511 PREEMPTLAZY
>  Hardware name: Banana Pi BPI-F3 (DT)
>  epc : workingset_eviction (include/linux/memcontrol.h:815 mm/workingset.c:257 mm/workingset.c:394) 
>  ra : __remove_mapping (mm/vmscan.c:805) 
>  epc : ffffffff802e6de8 ra : ffffffff802b4114 sp : ffffffc6006c3670
>   gp : ffffffff8227dad8 tp : ffffffd701a2cb00 t0 : ffffffff80027d00
>   t1 : 0000000000000000 t2 : 0000000000000001 s0 : ffffffc6006c3680
>   s1 : ffffffc50415a540 a0 : 0000000000000001 a1 : ffffffd700b70048
>   a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000000003f0
>   a5 : ffffffd700b70430 a6 : 0000000000000000 a7 : ffffffd77ffd1dc0
>   s2 : ffffffd705a483d8 s3 : ffffffd705a483e0 s4 : 0000000000000001
>   s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000001
>   s8 : ffffffd705a483d8 s9 : ffffffc6006c3760 s10: ffffffc50415a548
>   s11: ffffffff81e000e0 t3 : 0000000000000000 t4 : 0000000000000001
>   t5 : 0000000000000003 t6 : 0000000000000003
>  status: 0000000200000100 badaddr: 00000000000000d0 cause: 000000000000000d
>  workingset_eviction (include/linux/memcontrol.h:815 mm/workingset.c:257 mm/workingset.c:394) 
>  __remove_mapping (mm/vmscan.c:805) 
>  shrink_folio_list (mm/vmscan.c:1545 (discriminator 2)) 
>  evict_folios (mm/vmscan.c:4738) 
>  try_to_shrink_lruvec (mm/vmscan.c:4901) 
>  shrink_one (mm/vmscan.c:4947) 
>  shrink_node (include/asm-generic/preempt.h:54 (discriminator 1) include/linux/rcupdate.h:93 (discriminator 1) include/linux/rcupdate.h:839 (discriminator 1) mm/vmscan.c:5010 (discriminator 1) mm/vmscan.c:5086 (discriminator 1) mm/vmscan.c:6073 (discriminator 1)) 
>  balance_pgdat (mm/vmscan.c:6942 mm/vmscan.c:7116) 
>  kswapd (mm/vmscan.c:7381) 
>  kthread (kernel/kthread.c:463) 
>  ret_from_fork_kernel (include/linux/entry-common.h:155 (discriminator 4) include/linux/entry-common.h:210 (discriminator 4) arch/riscv/kernel/process.c:216 (discriminator 4)) 
>  ret_from_fork_kernel_asm (arch/riscv/kernel/entry.S:328) 
>  Code: 0987 060a 6633 01c6 97ba b02f 01d7 0001 0013 0000 (5503) 0d08
>  All code
>  ========
>     0:	060a0987          	.insn	4, 0x060a0987
>     4:	01c66633          	or	a2,a2,t3
>     8:	97ba                	.insn	2, 0x97ba
>     a:	01d7b02f          	amoadd.d	zero,t4,(a5)
>     e:	0001                	.insn	2, 0x0001
>    10:	00000013          	addi	zero,zero,0
>    14:*	0d085503          	lhu	a0,208(a6)		<-- trapping instruction
>  
>  Code starting with the faulting instruction
>  ===========================================
>     0:	0d085503          	lhu	a0,208(a6)
>  ---[ end trace 0000000000000000 ]---
>  note: kswapd0[87] exited with irqs disabled
>  note: kswapd0[87] exited with preempt_count 2
> 
> > ---
> >  include/linux/pagemap.h |  1 +
> >  mm/filemap.c            | 12 ++++++++----
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index c9ba69e02e3e..06dc3fae8124 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -211,6 +211,7 @@ enum mapping_flags {
> >  				   folio contents */
> >  	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
> >  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
> > +	AS_UNCHARGED = 10,	/* Do not charge usage to a cgroup */
> >  	/* Bits 16-25 are used for FOLIO_ORDER */
> >  	AS_FOLIO_ORDER_BITS = 5,
> >  	AS_FOLIO_ORDER_MIN = 16,
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index e4a5a46db89b..5004a2cfa0cc 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -960,15 +960,19 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
> >  {
> >  	void *shadow = NULL;
> >  	int ret;
> > +	bool charge_mem_cgroup = !test_bit(AS_UNCHARGED, &mapping->flags);
> >  
> > -	ret = mem_cgroup_charge(folio, NULL, gfp);
> > -	if (ret)
> > -		return ret;
> > +	if (charge_mem_cgroup) {
> > +		ret = mem_cgroup_charge(folio, NULL, gfp);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	__folio_set_locked(folio);
> >  	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
> >  	if (unlikely(ret)) {
> > -		mem_cgroup_uncharge(folio);
> > +		if (charge_mem_cgroup)
> > +			mem_cgroup_uncharge(folio);
> >  		__folio_clear_locked(folio);
> >  	} else {
> >  		/*
> > -- 
> > 2.50.1
> > 
> 
> This means that not all folios will have a memcg attached also when
> memcg is enabled. In lru_gen_eviction() mem_cgroup_id() is called
> without a NULL check which then leads to the null-dereference.
> 
> The following diff resolves the issue for me:
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fae105a9cb46..c70e789201fc 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -809,7 +809,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  
>  static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
>  {
> -	if (mem_cgroup_disabled())
> +	if (mem_cgroup_disabled() || !memcg)
>  		return 0;
>  
>  	return memcg->id.id;
> 
> However, it's mentioned in folio_memcg() that it can return NULL so this
> might be an existing bug which this patch just makes more obvious.
> 
> There's also workingset_eviction() which instead gets the memcg from
> lruvec. Doing that in lru_gen_eviction() also resolves the issue for me:
> 
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 68a76a91111f..e805eadf0ec7 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -243,6 +243,7 @@ static void *lru_gen_eviction(struct folio *folio)
>  	int tier = lru_tier_from_refs(refs, workingset);
>  	struct mem_cgroup *memcg = folio_memcg(folio);
>  	struct pglist_data *pgdat = folio_pgdat(folio);
> +	int memcgid;
>  
>  	BUILD_BUG_ON(LRU_GEN_WIDTH + LRU_REFS_WIDTH > BITS_PER_LONG - EVICTION_SHIFT);
>  
> @@ -254,7 +255,9 @@ static void *lru_gen_eviction(struct folio *folio)
>  	hist = lru_hist_from_seq(min_seq);
>  	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
>  
> -	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, workingset);
> +	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
> +
> +	return pack_shadow(memcgid, pgdat, token, workingset);
>  }
>  
>  /*
> 
> I don't really know what I'm doing here, though.

Me neither, clearly :)

Thanks so much for the report and fix! I fear there might be some other
paths that try to get memcg from lruvec or folio or whatever without
checking it. I feel like in this exact case, I would want to go to the
first sign of trouble and fix it at lruvec_memcg(). But then who knows
what else we've missed.

May I ask what you were running to trigger this? My fstests run (clearly
not exercising enough interesting memory paths) did not hit it.

This does make me wonder if the superior approach to the original patch
isn't just to go back to the very first thing Qu did and account these
to the root cgroup rather than do the whole uncharged thing.

Boris

> 
> Regards,
> Klara Modin

