Return-Path: <linux-fsdevel+bounces-58636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37154B30310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779106821F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 19:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44134AAF6;
	Thu, 21 Aug 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f6lHv4Ea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6F4345752
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805065; cv=none; b=CYB6UpAGYG4Zxo1ICJNmqL5xZ+lJ16rNSik4C7LRgDrELhxFiGE7oFTiLRKX5NJ4PpU4qYJc5awsgcpmTPaqKrmDdNttdABufrNOu1aQwNo2kv2NTMHnRjKwzKc42vMFatdwDd4IqF7cnQjL0KPOh9lFmy4mym1wpmCAP21UObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805065; c=relaxed/simple;
	bh=B+uEjhInfGB7hkP8pqGSroW61xpgF6sGneODEFFgLYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoI0BFqkaVIJ4nvJzS03fGoi96PrXjAULn97j2ZMcv+AHVgzwKaixJktFMkDpWakkjFa0vbxyD8S5zEwJlJm3jwjKg4OZQ3uakuWv4j1vbsG5MA8gMYjubfvFncBVmwsY6EYc6LKxcsY5cHErO22k4wn8KNPY1OcFpHLeUoelRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f6lHv4Ea; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 12:37:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755805060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbcsp/HYAITfGuo2SXY/LG2h8CV6ti2SdCWAHkmo3yU=;
	b=f6lHv4Eaw6bRrMmsg1ePkmBAFmqMjou73pU0z8ovbs+rKATqeaaDENg7sZDADG5f9XhQ21
	8xgKJTX3fZM44T8tqukNb1IG45fTEJ2evsqB8Ms8WH2STndSR3678yyHb1ASpWqe/3KJBO
	ZEfQWqDlyKUcXnTDtlQy6c/p7mFdDSg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>
Cc: Klara Modin <klarasmodin@gmail.com>, akpm@linux-foundation.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com, wqu@suse.com, willy@infradead.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Message-ID: <jewggm6jdhjmd2hlnxr4qgaqelst5ue4hviza6v6hgiivkxmiz@eiyng4pg2ilk>
References: <cover.1755562487.git.boris@bur.io>
 <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
 <hbdekl37pkdsvdvzgsz5prg5nlmyr67zrkqgucq3gdtepqjilh@ovc6untybhbg>
 <20250820225222.GA4100662@zen.localdomain>
 <p7uqfmtrl5duh4zekgtf3vtl4jsstbdefar5nramp4aflcn25t@7pmvft4zmsid>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7uqfmtrl5duh4zekgtf3vtl4jsstbdefar5nramp4aflcn25t@7pmvft4zmsid>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 20, 2025 at 04:53:08PM -0700, Shakeel Butt wrote:
> On Wed, Aug 20, 2025 at 03:52:22PM -0700, Boris Burkov wrote:
> [...]
> > 
> > Thanks so much for the report and fix! I fear there might be some other
> > paths that try to get memcg from lruvec or folio or whatever without
> > checking it. I feel like in this exact case, I would want to go to the
> > first sign of trouble and fix it at lruvec_memcg(). But then who knows
> > what else we've missed.
> 
> lruvec_memcg() is not an issue but folio_memcg() can be. I found
> following instances of folio_memcg() which are problematic (on
> next-20250819):
> 
> mm/memcontrol.c:3246:   css_get_many(&__folio_memcg(folio)->css, new_refs);
> 
> include/trace/events/writeback.h:269:           __entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
> 
> mm/workingset.c:244:    struct mem_cgroup *memcg = folio_memcg(folio);
> 
> mm/huge_memory.c:4020:  WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
> 
> > 
> > May I ask what you were running to trigger this? My fstests run (clearly
> > not exercising enough interesting memory paths) did not hit it.
> > 
> > This does make me wonder if the superior approach to the original patch
> > isn't just to go back to the very first thing Qu did and account these
> > to the root cgroup rather than do the whole uncharged thing.
> 
> I don't have any strong preference one way or the other.

After thinking a bit more, I think root memcg approach by Qu should be
preferred. Using that we will avoid this unnecessary code churn for NULL
memcg checks and I am pretty sure I might have missed some places I
listed above.

