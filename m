Return-Path: <linux-fsdevel+bounces-58411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32AB2E7ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 700344E169A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 22:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782A23F413;
	Wed, 20 Aug 2025 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcaOCGVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3F6FBF;
	Wed, 20 Aug 2025 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727607; cv=none; b=FMqf5BGsp99rJvHkJulUSjf2aEn40yWuu1oRZBVqgNGpbA3X4S9LTecMMh7C197NMfznt7oLufPbVpGlua41JiJ+Lk5CbbOaniAmxthxOXpGHE7FZtzsztHP9jO2xaHt7+2Rnb1tATruIrgwh85srps8lJMpVH7eSbehjoqppeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727607; c=relaxed/simple;
	bh=MUgFzI3l7extWQyx/AJ0eGaPSdG0wQjETNGxHeJC0Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oss1zVdpQujWGaImcaoB3TJI0pDepomoSJrRJrcOm7py8m+mbQce6nCAgVTNX4LST4ZteYUMpLvnt4uI7Vk6m+WEZEUClep10oBq17LIPihOsWmDJU3uu3VFkGXRVAVULkmTS8z4l11t0v6UXctpuDvP/SDFsiBtl/EVeSr7hB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcaOCGVy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f9160c21so2783061fa.2;
        Wed, 20 Aug 2025 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755727604; x=1756332404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NMBndnzKPT1NoZpmX7E2y1iqzOsAWdhRbNpoiP8UFI=;
        b=PcaOCGVyzT9GYxPGbI39cI+l/d0H7/gI/k1p60QsccQiuvprjvWKPd/QrVSaJeB+ZD
         cfZ34KB6GfKmAa5vE0cTHdCTb3+RAGpUK3VmBpSRxdXdmiU/xqsusj/84c9gjgXh8eWu
         GTgrh9LXv/pOBTgLmE6othb54cszbJdtbgFp24v0hdCjlP1TYVqKF3+tJbe18TgmyO7m
         5qcbfERDobsmBO9b4ZHk3W4O4m6dOsxeFungUEromf45Oh8AqdEqtfDgcMEQ5OVvufM5
         OQpEK9aF+gVZrFeefR+SXtGoVNZkTw4bjmz42x6jiJgiBYzL1ynw6EX8qqEsVicvaSHS
         a5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755727604; x=1756332404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NMBndnzKPT1NoZpmX7E2y1iqzOsAWdhRbNpoiP8UFI=;
        b=LhZNXrI4/cc9+x5nWVTxKVOeE6WqxQmdg59VnoXRd1Iy//W3LP409cPE1y9w6rNrEV
         qG3mymgPpaiI8Y3qRrZHtN8jHm45ryNC3PUgbXkPJRrwOdvDzHAbSxAgx/yG0a/bDDeY
         XBEuI+srBnGSpTwFiGLUzWcITy6oCU8QoFWvoJOwZZ4sMZiZGC33ooLOqJS2XC0Vm40p
         b14sSV56EUSmmBqy5gGDlzMH6MrMciSEEcX9Nc0jOLPsW/tYR3DaEAUhrcyrBmSgTcUu
         Ic/X+jaJnY8GZ6QkndI5jpaBM798bq08s5vtXi/K8PCdwUbttdGumIkPjSpk7S1i5Ka1
         lPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXh0NCJ2CFlfOiQ7+fNwHCe3v+C7qkeQcq9A1c3C9+uYO4oJ6JWxjtUsDLrHJu+goAPDPM9ZzJpHm0L1phfA==@vger.kernel.org, AJvYcCWlJCBEkr33c+nFHeqtJ4MJS6zpEYKRCKpzpNl+ABJSqcBSsQVxDug4Jd5TSBfnCwu4noMPzYrUt0N38A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUz3M3I8ZmZg/xcx0kjI30gSuJrBY746EZcMG4+yUvunfGyWh
	mc6hc4WmmFtMUhfYs4Eb6OD2LaZ5utRv69ao2XIuAd4vbndn7JHuk1kG
X-Gm-Gg: ASbGncubosgnqon6pHsaOTIZLmcOY85iQ5OEEOZhaAbrsyA/HHcT5FY1hhRdhhzBiZ2
	a1tsEy5rvZplyPbQD4uptSbnZejwpBdAB+nwnGR1G1W92A7zncS2+bWcTj53Qj4qwYZO6e4lMJg
	YUM90irk6D8tNG5bzH1dPYcaZiGdZO994xkYEOwPxnMbxtlbWPswPL4lx774T46k156QlNCHwuP
	GK20knt1blCXlVqfCfvcFSSV9kKmdW1weeN/rxMYnkw/wb1CW3pF3zWcvnMB1hGT9PFjepQyjc8
	r7VV2TMUE2y1whw0QWV19+JtUOg9ytfPWEdS0ViS/G92W93ke5WgGoPoZLpuarPK5Tpvj3umSzp
	rE/meY8KnkcAyCye5lrRSeej8pnZGS8hWk7pDLCZaj3AkEpE=
X-Google-Smtp-Source: AGHT+IF8q3EOilMMZn6w1YadAvZXVrqgXu54pbYwks8gwAO14G9NBCldCXVPQPbBOIbj8OfT6v70GQ==
X-Received: by 2002:a05:651c:19a0:b0:332:3562:9734 with SMTP id 38308e7fff4ca-33549e15f16mr507791fa.8.1755727603283;
        Wed, 20 Aug 2025 15:06:43 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-3340a41d588sm31320351fa.3.2025.08.20.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:06:42 -0700 (PDT)
Date: Thu, 21 Aug 2025 00:06:42 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Boris Burkov <boris@bur.io>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com, 
	shakeel.butt@linux.dev, wqu@suse.com, willy@infradead.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Message-ID: <hbdekl37pkdsvdvzgsz5prg5nlmyr67zrkqgucq3gdtepqjilh@ovc6untybhbg>
References: <cover.1755562487.git.boris@bur.io>
 <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>

Hi,

On 2025-08-18 17:36:53 -0700, Boris Burkov wrote:
> Btrfs currently tracks its metadata pages in the page cache, using a
> fake inode (fs_info->btree_inode) with offsets corresponding to where
> the metadata is stored in the filesystem's full logical address space.
> 
> A consequence of this is that when btrfs uses filemap_add_folio(), this
> usage is charged to the cgroup of whichever task happens to be running
> at the time. These folios don't belong to any particular user cgroup, so
> I don't think it makes much sense for them to be charged in that way.
> Some negative consequences as a result:
> - A task can be holding some important btrfs locks, then need to lookup
>   some metadata and go into reclaim, extending the duration it holds
>   that lock for, and unfairly pushing its own reclaim pain onto other
>   cgroups.
> - If that cgroup goes into reclaim, it might reclaim these folios a
>   different non-reclaiming cgroup might need soon. This is naturally
>   offset by LRU reclaim, but still.
> 
> A very similar proposal to use the root cgroup was previously made by
> Qu, where he eventually proposed the idea of setting it per
> address_space. This makes good sense for the btrfs use case, as the
> uncharged behavior should apply to all use of the address_space, not
> select allocations. I.e., if someone adds another filemap_add_folio()
> call using btrfs's btree_inode, we would almost certainly want the
> uncharged behavior.
> 
> Link: https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Boris Burkov <boris@bur.io>

I bisected the following null-dereference to 3f31e0d9912d ("btrfs: set
AS_UNCHARGED on the btree_inode") in mm-new but I believe it's a result of
this patch:

 Oops [#1]
 CPU: 4 UID: 0 PID: 87 Comm: kswapd0 Not tainted 6.17.0-rc2-next-20250820-00349-gd6ecef4f9566 #511 PREEMPTLAZY
 Hardware name: Banana Pi BPI-F3 (DT)
 epc : workingset_eviction (include/linux/memcontrol.h:815 mm/workingset.c:257 mm/workingset.c:394) 
 ra : __remove_mapping (mm/vmscan.c:805) 
 epc : ffffffff802e6de8 ra : ffffffff802b4114 sp : ffffffc6006c3670
  gp : ffffffff8227dad8 tp : ffffffd701a2cb00 t0 : ffffffff80027d00
  t1 : 0000000000000000 t2 : 0000000000000001 s0 : ffffffc6006c3680
  s1 : ffffffc50415a540 a0 : 0000000000000001 a1 : ffffffd700b70048
  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000000003f0
  a5 : ffffffd700b70430 a6 : 0000000000000000 a7 : ffffffd77ffd1dc0
  s2 : ffffffd705a483d8 s3 : ffffffd705a483e0 s4 : 0000000000000001
  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000001
  s8 : ffffffd705a483d8 s9 : ffffffc6006c3760 s10: ffffffc50415a548
  s11: ffffffff81e000e0 t3 : 0000000000000000 t4 : 0000000000000001
  t5 : 0000000000000003 t6 : 0000000000000003
 status: 0000000200000100 badaddr: 00000000000000d0 cause: 000000000000000d
 workingset_eviction (include/linux/memcontrol.h:815 mm/workingset.c:257 mm/workingset.c:394) 
 __remove_mapping (mm/vmscan.c:805) 
 shrink_folio_list (mm/vmscan.c:1545 (discriminator 2)) 
 evict_folios (mm/vmscan.c:4738) 
 try_to_shrink_lruvec (mm/vmscan.c:4901) 
 shrink_one (mm/vmscan.c:4947) 
 shrink_node (include/asm-generic/preempt.h:54 (discriminator 1) include/linux/rcupdate.h:93 (discriminator 1) include/linux/rcupdate.h:839 (discriminator 1) mm/vmscan.c:5010 (discriminator 1) mm/vmscan.c:5086 (discriminator 1) mm/vmscan.c:6073 (discriminator 1)) 
 balance_pgdat (mm/vmscan.c:6942 mm/vmscan.c:7116) 
 kswapd (mm/vmscan.c:7381) 
 kthread (kernel/kthread.c:463) 
 ret_from_fork_kernel (include/linux/entry-common.h:155 (discriminator 4) include/linux/entry-common.h:210 (discriminator 4) arch/riscv/kernel/process.c:216 (discriminator 4)) 
 ret_from_fork_kernel_asm (arch/riscv/kernel/entry.S:328) 
 Code: 0987 060a 6633 01c6 97ba b02f 01d7 0001 0013 0000 (5503) 0d08
 All code
 ========
    0:	060a0987          	.insn	4, 0x060a0987
    4:	01c66633          	or	a2,a2,t3
    8:	97ba                	.insn	2, 0x97ba
    a:	01d7b02f          	amoadd.d	zero,t4,(a5)
    e:	0001                	.insn	2, 0x0001
   10:	00000013          	addi	zero,zero,0
   14:*	0d085503          	lhu	a0,208(a6)		<-- trapping instruction
 
 Code starting with the faulting instruction
 ===========================================
    0:	0d085503          	lhu	a0,208(a6)
 ---[ end trace 0000000000000000 ]---
 note: kswapd0[87] exited with irqs disabled
 note: kswapd0[87] exited with preempt_count 2

> ---
>  include/linux/pagemap.h |  1 +
>  mm/filemap.c            | 12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c9ba69e02e3e..06dc3fae8124 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -211,6 +211,7 @@ enum mapping_flags {
>  				   folio contents */
>  	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
>  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
> +	AS_UNCHARGED = 10,	/* Do not charge usage to a cgroup */
>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index e4a5a46db89b..5004a2cfa0cc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -960,15 +960,19 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>  {
>  	void *shadow = NULL;
>  	int ret;
> +	bool charge_mem_cgroup = !test_bit(AS_UNCHARGED, &mapping->flags);
>  
> -	ret = mem_cgroup_charge(folio, NULL, gfp);
> -	if (ret)
> -		return ret;
> +	if (charge_mem_cgroup) {
> +		ret = mem_cgroup_charge(folio, NULL, gfp);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	__folio_set_locked(folio);
>  	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
>  	if (unlikely(ret)) {
> -		mem_cgroup_uncharge(folio);
> +		if (charge_mem_cgroup)
> +			mem_cgroup_uncharge(folio);
>  		__folio_clear_locked(folio);
>  	} else {
>  		/*
> -- 
> 2.50.1
> 

This means that not all folios will have a memcg attached also when
memcg is enabled. In lru_gen_eviction() mem_cgroup_id() is called
without a NULL check which then leads to the null-dereference.

The following diff resolves the issue for me:

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fae105a9cb46..c70e789201fc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -809,7 +809,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 {
-	if (mem_cgroup_disabled())
+	if (mem_cgroup_disabled() || !memcg)
 		return 0;
 
 	return memcg->id.id;

However, it's mentioned in folio_memcg() that it can return NULL so this
might be an existing bug which this patch just makes more obvious.

There's also workingset_eviction() which instead gets the memcg from
lruvec. Doing that in lru_gen_eviction() also resolves the issue for me:

diff --git a/mm/workingset.c b/mm/workingset.c
index 68a76a91111f..e805eadf0ec7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -243,6 +243,7 @@ static void *lru_gen_eviction(struct folio *folio)
 	int tier = lru_tier_from_refs(refs, workingset);
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct pglist_data *pgdat = folio_pgdat(folio);
+	int memcgid;
 
 	BUILD_BUG_ON(LRU_GEN_WIDTH + LRU_REFS_WIDTH > BITS_PER_LONG - EVICTION_SHIFT);
 
@@ -254,7 +255,9 @@ static void *lru_gen_eviction(struct folio *folio)
 	hist = lru_hist_from_seq(min_seq);
 	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
 
-	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, workingset);
+	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
+
+	return pack_shadow(memcgid, pgdat, token, workingset);
 }
 
 /*

I don't really know what I'm doing here, though.

Regards,
Klara Modin

