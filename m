Return-Path: <linux-fsdevel+bounces-32814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D159AF015
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 20:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166701F22FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 18:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88933215025;
	Thu, 24 Oct 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VogRliWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6E2010E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796054; cv=none; b=V0iFbSi39x/JNHEaZ3b2hOFtcAolSUkEIvC9HYD2kKsT3xWFYX4G1v9kyRHRafpoP6ZS0SKTuaFpUE/pKcAdYIrTRuoE4jRCsMZJ+kZWe/ZzYSKnXobjuJQ+MqnfPXPFz2mgm5l+eQppaShC75NcmAnyGf+LRNMW65ajzPu7L0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796054; c=relaxed/simple;
	bh=hEYIYzGp5U5R4uXnrnJaMQg6XfPI6nfNtTSIDMgo9L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKneOfBhGBm+iiFFVZBR21ceZ1lZJTMzGRzsKYIW5QfLGKjV2kv2hwC645AfP6LI7tbSMiTporPwcjK0nZzDLbiUrLOciC/w+YWZfWEwHQrEYDW5wbJQTmyxs95fnNVvrcFxTnWPHYaUA7m4EsuzBSF1+KeRUmzRm5IMg/afA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VogRliWa; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 18:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729796046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KlqshmPXbxZTAr3w7RRmiAJaVrc05CpdJhCJXtLXB4=;
	b=VogRliWa+azQMsfmhGUG4zqTaQtU2omksMFKCMz5Qcg6h41JqOKX1fWACEZjhFf5SMKDHF
	TFdPj32qCtkRn15xJ2VGBtl/TRekR/kvyTWSMQUPzc6VWgB6yxs51ZRH4mIUGewvdT3RwO
	oBvC3UcklSbPtoGVhrqEVx46MN0qHBM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <ZxqXyQb1nT6DWPN_@google.com>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
 <ZxoQhEPXmSkM7sH_@tiehlicka>
 <kr6fjny7aqni4habduj2uqfznusozkku3xeq62bjscb5ovwxog@ccgl3kxufmma>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kr6fjny7aqni4habduj2uqfznusozkku3xeq62bjscb5ovwxog@ccgl3kxufmma>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 10:23:49AM -0700, Shakeel Butt wrote:
> On Thu, Oct 24, 2024 at 11:16:52AM GMT, Michal Hocko wrote:
> > On Wed 23-10-24 23:57:12, Shakeel Butt wrote:
> > > The memcg v1's charge move feature has been deprecated. There is no need
> > > to have any locking or protection against the moving charge. Let's
> > > proceed to remove all the locking code related to charge moving.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > > -/**
> > > - * folio_memcg_lock - Bind a folio to its memcg.
> > > - * @folio: The folio.
> > > - *
> > > - * This function prevents unlocked LRU folios from being moved to
> > > - * another cgroup.
> > > - *
> > > - * It ensures lifetime of the bound memcg.  The caller is responsible
> > > - * for the lifetime of the folio.
> > > - */
> > > -void folio_memcg_lock(struct folio *folio)
> > > -{
> > > -	struct mem_cgroup *memcg;
> > > -	unsigned long flags;
> > > -
> > > -	/*
> > > -	 * The RCU lock is held throughout the transaction.  The fast
> > > -	 * path can get away without acquiring the memcg->move_lock
> > > -	 * because page moving starts with an RCU grace period.
> > > -         */
> > > -	rcu_read_lock();
> > 
> > Is it safe to remove the implicit RCU?
> 
> Good question. I think it will be safe to keep the RCU in this patch and
> in the followup examine each place and decide to remove RCU or not.

I took a really quick look and based on it I believe it is safe.
Shakeel, can you, please, check too and preferably keep your code intact.
I think it's better to remove it all together, rather than do it in two steps.
If we really need rcu somewhere, we can replace folio_memcg_lock()/unlock()
with an explicit rcu_read_lock()/rcu_read_unlock().

Thanks!

