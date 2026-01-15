Return-Path: <linux-fsdevel+bounces-73946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD1D2605A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD355306DA96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53839B4BF;
	Thu, 15 Jan 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wT445DsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965882D3733
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496422; cv=none; b=sKUs+awQ0IBftN05P3b9yTjVUC1pfB2CTwYNB4KERZs6i5E7sqDGlB6PSI6K6/Ous2Im9Xnq5uZBKnkzklCVQKkrorSCOErAPKZHIGTJ3REeUzfoYl2HozAcyLq2/+ow3UaBLpM6SjhpmCR5zAAz9cWG9ueK7FATXSGM94Aq2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496422; c=relaxed/simple;
	bh=BtokHh4+lGUXhkRc80WbQQozqtSuNo+ZLaEDaAPJVvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgfOrwf+e9RDNQ5bhTn5Pbod6IUNROaXIZgWMwn+MehlV6ZIX52KYeSr4H9tGTrMWdC6Pn2+gJB09Xsb05B4s+1/VHIf+yCW3lBYfrYVHGRcoxcDZnLEMyNzenPfllZdo79HdumfXiFyV0GpvmSbDYb9dWiVRKVkLq5+yuR4tp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wT445DsQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Jan 2026 17:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768496417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFhntWShXHgOAIorUq2E/j9pvFsqctkiMpQmDw8UuZQ=;
	b=wT445DsQd4/3Xmj+RvJ2Ntg8GFkTgTIfwuwltdPW2wrMKBYK1L/wQAA7vFELJHski3hyGh
	MmBUfmpJyjXE7E7f69igcg9ZrmSZjp6krqT/hyIEEmg+mPBDUzac1RCa+KgWCgebP2ws3G
	mIFyVcZuKu0Q3CLBz6F5nVMY3RU3Z6Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com, david@kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, rientjes@google.com, shakeel.butt@linux.dev, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	osalvador@suse.de, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <e6eydzdvuiktmalhcmoiwsgzjbw5v7t4532fkbroylwr5cqetx@v6pgjaoxgmyz>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
 <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
 <CAKEwX=MftJXOE8H=m1C=_RVL8cu516efixTwcaQMBB9pdj=K+g@mail.gmail.com>
 <CAKEwX=M8=vDO_pg5EJWiaNnJQpob8=NWvbZzssKKPpzs24wj+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=M8=vDO_pg5EJWiaNnJQpob8=NWvbZzssKKPpzs24wj+A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 13, 2026 at 04:49:20PM +0900, Nhat Pham wrote:
> On Tue, Jan 13, 2026 at 4:35 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > > This part needs more thought. Zswap cannot charge a full page because
> > > then from the memcg perspective reclaim is not making any progress.
> > > OTOH, as you mention, from the system perspective we just consumed a
> > > full page, so not charging that would be inconsistent.
> > >
> > > This is not a zswap-specific thing though, even with cram.c we have to
> > > figure out how to charge memory on the compressed node to the memcg.
> > > It's perhaps not as much of a problem as with zswap because we are not
> > > dealing with reclaim not making progress.
> > >
> > > Maybe the memcg limits need to be "enlightened" about different tiers?
> > > We did have such discussions in the past outside the context of
> > > compressed memory, for memory tiering in general.
> >
> > What if we add a reclaim flag that says "hey, we are hitting actual
> > memory limit and need to make memory reclaim forward progress".
> >
> > Then, we can have zswap skip compressed cxl backend and fall back to
> > real compression.
> >
> > (Maybe also demotion, which only move memory from one node to another,
> > as well as the new cram.c stuff? This will technically also save some
> > wasted work, as in the status quo we will need to do a demotion pass
> > first, before having to reclaiom memory from the bottom tier anyway?
> > But not sure if we want this).
> 
> Some more thoughts - right now demotion is kinda similar, right? We
> move pages from one node (fast tier) to another (slow tier). This
> frees up space in the fast tier, but it actually doesn't change the
> memcg memory usage. So we are not making "forward progress" with this
> either.
> 
> I suppose this is fine-ish, because reclaim subsystem can then proceed
> by reclaiming from the bottom tier, which will now go to disk swap,
> zswap, etc.
> 
> Can we achieve the same effect by making pages in
> zswap-backed-by-compressed-cxl reclaimable:
> 
> 1. Recompression - take them off compressed cxl and store them in
> zswap proper (i.e in-memory compression).

I think the whole point of using compressed cxl with zswap is saving
memory in the top-tier, so this would be counter-productive (probably
even if we use slightly less memory in the top-tier).

> 
> 2. Just enable zswap shrinker and have memory reclaim move these pages
> into disk swap. This will have a much more drastic performance
> implications though :)

I think what you're getting it as that we can still make forward
progress after memory lands in compressed cxl. But moving memory to
compressed cxl is already forward progress that reclaim won't capture if
we charge memory as a full page. I think this is the crux of the issue.

We need to figure out how to make accounting work such that moving
memory to compressed cxl is forward progress, but make sure we don't
break the overall accounting consisteny. If we only charge the actual
compressed size, then from the system perspective there is a page that
is only partially charged and the rest of it is more-or-less leaked.

