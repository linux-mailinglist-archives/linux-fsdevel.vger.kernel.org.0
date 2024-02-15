Return-Path: <linux-fsdevel+bounces-11762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2163856F6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D58286FDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E4114532C;
	Thu, 15 Feb 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rnhwg+O/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7313DBA4
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033047; cv=none; b=sZLz3hUMilrEpXLx/ItGlgAc1rUDkWGmuanlr5SohyiSEgU0kXDMkDeS/vwvOoeS1viGgQ2KMBzE6LO8DJN0BuYTHGBlOV46s5SN39JQyqwU/qm8W7RDsQoFuCJHG2+0mxD7aJRk+k+YVjTc6vnW72D0OIOQpQQE1D+uIJAM52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033047; c=relaxed/simple;
	bh=6tomeDET5dYte8dARS9CJ7K826Uea8dsqGpQSkBapXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYB4CbUbga0zBKBi25BuaS67iOkFHGhimxYyw2xZAVPur00UpE+uiDAxfajkcHE7HsYPJn6PnxXNzmqQnjQmUk7Z7iUgKdldySuVEcoejyTd6ejlZR/J1QqKyP4JV1x7QHbZvcAqc7gLAQdZOCFvCjR3nOjWJT9gNMnkNda4JDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rnhwg+O/; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 16:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708033041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39zmCdbpcZTkNZlIqIoMaXRRJS4y9GsAOFJTtoi5f0I=;
	b=Rnhwg+O/fGg3InE7Iv5/dEuDz/AEL63LsTs3WOHzJhbI+Tp0Mqj1CPfI1GKmY5eOPSTVzM
	WeRBqw3S9FwgsAKOKdiLzXtsQQjE2MutvjEpVCTjrw7I3WMwInP/mysrsYUnh/9HHdE6gr
	C4/HCaIEa+ME+cB+PteBQP1XD+6Hwbg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
Message-ID: <tbqg7sowftykfj3rptpcbewoiy632fbgbkzemgwnntme4wxhut@5dlfmdniaksr>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-8-surenb@google.com>
 <fbfab72f-413d-4fc1-b10b-3373cfc6c8e9@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfab72f-413d-4fc1-b10b-3373cfc6c8e9@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 10:31:06PM +0100, Vlastimil Babka wrote:
> On 2/12/24 22:38, Suren Baghdasaryan wrote:
> > Slab extension objects can't be allocated before slab infrastructure is
> > initialized. Some caches, like kmem_cache and kmem_cache_node, are created
> > before slab infrastructure is initialized. Objects from these caches can't
> > have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
> > caches and avoid creating extensions for objects allocated from these
> > slabs.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/slab.h | 7 +++++++
> >  mm/slub.c            | 5 +++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index b5f5ee8308d0..3ac2fc830f0f 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -164,6 +164,13 @@
> >  #endif
> >  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
> >  
> > +#ifdef CONFIG_SLAB_OBJ_EXT
> > +/* Slab created using create_boot_cache */
> > +#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
> 
> There's
>    #define SLAB_SKIP_KFENCE        ((slab_flags_t __force)0x20000000U)
> already, so need some other one?

What's up with the order of flags in that file? They don't seem to
follow any particular ordering.

Seems like some cleanup is in order, but any history/context we should
know first?

