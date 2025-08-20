Return-Path: <linux-fsdevel+bounces-58416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABBAB2E883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D261C87AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD7B2DAFD9;
	Wed, 20 Aug 2025 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+1yZND+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208852DA76E;
	Wed, 20 Aug 2025 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731712; cv=none; b=MQNrD+pxJuzkl5UUP9nsoMFxuY3x3YpE3nRwj/GyoZfTG+a0Y6oKo0AG9gQKcwjDXJudOLg7nFW1YkDQfss88aS5S1sIMVYdA6XSExAuAyk45BcROagTVJ77ZazmIY2NUiuT6RtzV9skWiT1mzMaG2fljAfuKLxG14s8B+n0/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731712; c=relaxed/simple;
	bh=sHQmMQiqsfazcEx6DGrnvGA0FTGg8dCBIYx09gd4lRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc2fRzqqp8yKvdUy4yBehfbAlrUbCPdBxAWZqfmImd43a+B9nfiQQ+djWZiyoxMLSTGorvplwWYU38hTLmi8/8sixb6Zy4kDR4g2/w6UALog+tp6umTlTNemgtfRWz8Ce26TF5Bv1e2io5Vc3Rln01J1ziwBYXUnoJpG7pP+WLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+1yZND+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so47420866b.2;
        Wed, 20 Aug 2025 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755731708; x=1756336508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UV6v+hA7ETw4OnW1K7B2JjLnbGY2L5npfHyuCaE7NdM=;
        b=H+1yZND+zVPKbjs8ZMZQN9Ubi1tCRBpX5wuODfblIOeYqdRFd7CB6n++//EHIx6AAK
         ZqwAiTD5Nmopvy0X+ACxTH9G1vh5G7W8LypZDlFYEUp376kX+tXrJZvsnVFwOCG1jIQi
         mZvkuOXBMbAMfV+LM27Yl2zK121BuW+tXf4sA1wG/h6W7MXDAa9Etg9b+JN8ICrQED9v
         2TVLcomI2ZYe6m7UdqLucAuEEQSUs8lwL02bosLv4rn+x0qw4pqm1EBvSGzF9DaB+jVP
         g/RuT1ubiKBK4h8ASBip9bUa4TIDJ+M97bvhnK0qPetDVRhXOci6DaUscPftebm5Rc+R
         5Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731708; x=1756336508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV6v+hA7ETw4OnW1K7B2JjLnbGY2L5npfHyuCaE7NdM=;
        b=CJMv9sEtA4oBq6nugVJdCQS/Hpxi+wlBKHBVhW3b/TTAby0iAA+Irr209TkygggPxY
         +Az8KcpmEaN/dDrj7jGE1FMumpXB7fhRZ2cGcI2HbnO+u+3NCmcR34xWEgSaNgNXqklu
         9Y11PZhyZjqiXfJC16Vtbs5VXHyySsBAKswk3GDVmpNmnXQcQ6iHACJON/vU+wouiflp
         ucYCh10UqMeBJhNuUyooscWDfjQlUDN9pCr0OXfeMdKz9UlJM2tilwjuAhODGgZb+0bi
         RkJLPoZ+fMVmHWR/vIiwceV3+vBiEZ+I9F8GAFJ4w80mZDPSnJDHnOaIw0F0jxGeyB2y
         4GFw==
X-Forwarded-Encrypted: i=1; AJvYcCW+wR1VHQU7zT8RtRYy0SlwT3h7IU9lavD89wcWVBHSPsjozyGZRpIjQn05SOEyz3cHvjE8EcMN6RT1xA==@vger.kernel.org, AJvYcCXbVAklGz4ac9CxqAcbVKJU7IaIHhDk3uPbblTFFEGBHGtkwBnmKO+lzwrgZdik3odLqs6CaV8wit9iKHRUhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/W/ssNxfoLA3Kea0XR/M/Gs3c06jVelroQJrCeoTheNPadAse
	/YyIJjFeXOeXFfy0WVRCkashHXieXU0s0sPyamOu/SuIXAVG+ME3aT6HpJIZgw==
X-Gm-Gg: ASbGnctLZr73K5dhBwUxSq7frmCG76RnbQQwLZwV18f2aPjbZmeqYSQNpGpoJLLqWH3
	QKzysHSW5Akb3gKiKUhPmzcRgllErlL4e/hXwoH1WfqptVJrZy8Y8WyU+0cCF9kl8CkVu4xLQuf
	oL7KJ+94/l1pvVaFqToI3jKs8TAuVK/1BCKzHX3ZTQJNeZHz7NC3VkeW8RWlwyQ3Psgi+CMYRR3
	B9ZL82fDEKv/NKgzeHHWXkwyo6rhJBIh/zg9hiVk7fVZVVeN/tkENK9oizxBDzvYMA21T6UQum/
	+tweSEv2R3lzGeprP+9T2J66x83DCTlM+WewQ2HaTyXsFZ3Sc/gUqk6ljC9QS4idTT7wo3Mxkbh
	VpYFtRucI6Rh9dga9Quq+5H/rhiFQMvO0oSzpzgtjJmwPc8Y=
X-Google-Smtp-Source: AGHT+IE95DMlWsMOOkaL7V1fyRiNQ52ythYky+7mNXcwgfPGGRtcFwV9dSv+UJfeXogBRMwgzQmgbw==
X-Received: by 2002:a17:907:7254:b0:af9:116c:61cf with SMTP id a640c23a62f3a-afe07d40350mr43722066b.43.1755731708104;
        Wed, 20 Aug 2025 16:15:08 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded478b13sm272533766b.71.2025.08.20.16.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:15:07 -0700 (PDT)
Date: Thu, 21 Aug 2025 01:15:06 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Boris Burkov <boris@bur.io>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com, 
	shakeel.butt@linux.dev, wqu@suse.com, willy@infradead.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Message-ID: <rhnvd3ohg3hludr4auyhezfiut3qdbdzxdfggpzehtmojxsym2@kfczkgovrtg3>
References: <cover.1755562487.git.boris@bur.io>
 <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
 <hbdekl37pkdsvdvzgsz5prg5nlmyr67zrkqgucq3gdtepqjilh@ovc6untybhbg>
 <20250820225222.GA4100662@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820225222.GA4100662@zen.localdomain>

Hi,

On 2025-08-20 15:52:22 -0700, Boris Burkov wrote:
> On Thu, Aug 21, 2025 at 12:06:42AM +0200, Klara Modin wrote:
> > Hi,
> > 
> > On 2025-08-18 17:36:53 -0700, Boris Burkov wrote:
> > > Btrfs currently tracks its metadata pages in the page cache, using a
> > > fake inode (fs_info->btree_inode) with offsets corresponding to where
> > > the metadata is stored in the filesystem's full logical address space.
> > > 
> > > A consequence of this is that when btrfs uses filemap_add_folio(), this
> > > usage is charged to the cgroup of whichever task happens to be running
> > > at the time. These folios don't belong to any particular user cgroup, so
> > > I don't think it makes much sense for them to be charged in that way.
> > > Some negative consequences as a result:
> > > - A task can be holding some important btrfs locks, then need to lookup
> > >   some metadata and go into reclaim, extending the duration it holds
> > >   that lock for, and unfairly pushing its own reclaim pain onto other
> > >   cgroups.
> > > - If that cgroup goes into reclaim, it might reclaim these folios a
> > >   different non-reclaiming cgroup might need soon. This is naturally
> > >   offset by LRU reclaim, but still.
> > > 
> > > A very similar proposal to use the root cgroup was previously made by
> > > Qu, where he eventually proposed the idea of setting it per
> > > address_space. This makes good sense for the btrfs use case, as the
> > > uncharged behavior should apply to all use of the address_space, not
> > > select allocations. I.e., if someone adds another filemap_add_folio()
> > > call using btrfs's btree_inode, we would almost certainly want the
> > > uncharged behavior.
> > > 
> > > Link: https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
> > > Suggested-by: Qu Wenruo <wqu@suse.com>
> > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Tested-by: syzbot@syzkaller.appspotmail.com
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > 
> > I bisected the following null-dereference to 3f31e0d9912d ("btrfs: set
> > AS_UNCHARGED on the btree_inode") in mm-new but I believe it's a result of
> > this patch:
> > 

...

> > 
> > This means that not all folios will have a memcg attached also when
> > memcg is enabled. In lru_gen_eviction() mem_cgroup_id() is called
> > without a NULL check which then leads to the null-dereference.
> > 
> > The following diff resolves the issue for me:
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index fae105a9cb46..c70e789201fc 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -809,7 +809,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> >  
> >  static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
> >  {
> > -	if (mem_cgroup_disabled())
> > +	if (mem_cgroup_disabled() || !memcg)
> >  		return 0;
> >  
> >  	return memcg->id.id;
> > 
> > However, it's mentioned in folio_memcg() that it can return NULL so this
> > might be an existing bug which this patch just makes more obvious.
> > 
> > There's also workingset_eviction() which instead gets the memcg from
> > lruvec. Doing that in lru_gen_eviction() also resolves the issue for me:
> > 
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index 68a76a91111f..e805eadf0ec7 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -243,6 +243,7 @@ static void *lru_gen_eviction(struct folio *folio)
> >  	int tier = lru_tier_from_refs(refs, workingset);
> >  	struct mem_cgroup *memcg = folio_memcg(folio);
> >  	struct pglist_data *pgdat = folio_pgdat(folio);
> > +	int memcgid;
> >  
> >  	BUILD_BUG_ON(LRU_GEN_WIDTH + LRU_REFS_WIDTH > BITS_PER_LONG - EVICTION_SHIFT);
> >  
> > @@ -254,7 +255,9 @@ static void *lru_gen_eviction(struct folio *folio)
> >  	hist = lru_hist_from_seq(min_seq);
> >  	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
> >  
> > -	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, workingset);
> > +	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
> > +
> > +	return pack_shadow(memcgid, pgdat, token, workingset);
> >  }
> >  
> >  /*
> > 
> > I don't really know what I'm doing here, though.
> 
> Me neither, clearly :)
> 
> Thanks so much for the report and fix! I fear there might be some other
> paths that try to get memcg from lruvec or folio or whatever without
> checking it. I feel like in this exact case, I would want to go to the
> first sign of trouble and fix it at lruvec_memcg(). But then who knows
> what else we've missed.
> 
> May I ask what you were running to trigger this? My fstests run (clearly
> not exercising enough interesting memory paths) did not hit it.
> 
> This does make me wonder if the superior approach to the original patch
> isn't just to go back to the very first thing Qu did and account these
> to the root cgroup rather than do the whole uncharged thing.
> 
> Boris
> 
> > 
> > Regards,
> > Klara Modin

For me it's easiest to trigger when cloning a large repository, e.g. the
kernel or gcc, with low-ish amount of RAM (maybe 1-4 GiB) so under memory
pressure. Also:

CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y


Shakeel:

I think I'll wait a little before submitting a patch to see if there are
any more comments.

Regards,
Klara Modin

