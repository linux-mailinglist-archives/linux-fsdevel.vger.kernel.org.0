Return-Path: <linux-fsdevel+bounces-15034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3B88632E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 23:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DCFB2225D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E41369AB;
	Thu, 21 Mar 2024 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FZysDbxQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39C13666D;
	Thu, 21 Mar 2024 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059459; cv=none; b=pWCX6BhYeps9frv8v4NIO7g4Lx/gyZUc/8thH5fIChT/JrtukooA2j1SXrYQv8+KIYhvn80fZE1mP7+P16bzVDQQho5cDn/xwS2nbAunmo1vEzPCRrNctZDMXvowKtFCpQfNDPoZvN/pFrbJtswtxHiBGlQjqbNsN9F6Ph3kHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059459; c=relaxed/simple;
	bh=48MDU/nc47hzkUWjchZtFQewyGLXSQIKOvEvF3GhbhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcPW0pGRk9wZ18wDHC+oLVoFDvKKx7jh06ieztPruME/13UjfOqkvEVT8DTxPOKGZBLuJPo1wYBowXtvhnswZwy99LPR4adIyKphIAOqbYrc7FpU1rxf53TCpUfe0MWOVfC1hnyHp7ddsmgel+L3eDx55GxawgfAOz5L+TvDERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FZysDbxQ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Mar 2024 18:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711059455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Avwu9Obvo7iLXBxmizf/EO08qQLthSdSW59GBeW8H+I=;
	b=FZysDbxQhjIXqR1pi+xqtUgFMzj7/eEwMfqFXVNrKP4hKoq2eMyg+mr0CCyz9L7KqFOgHR
	p5O/ufNLq1uDGvJZh6zage2q2y2AKKbqhiaE8rWYbulPbyHbczbhEbHNktWz0RHQl+5yfX
	htak4lBJXiAjgjdWctvpqD6B01G3FgE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, 
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 05/37] fs: Convert alloc_inode_sb() to a macro
Message-ID: <bliyhrwtskv5xhg3rxxszouxntrhnm3nxhcmrmdwwk4iyx5wdo@vodd22dbtn75>
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-6-surenb@google.com>
 <20240321133147.6d05af5744f9d4da88234fb4@linux-foundation.org>
 <gnqztvimdnvz2hcepdh3o3dpg4cmvlkug4sl7ns5vd4lm7hmao@dpstjnacdubq>
 <20240321150908.48283ba55a6c786dee273ec3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321150908.48283ba55a6c786dee273ec3@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 21, 2024 at 03:09:08PM -0700, Andrew Morton wrote:
> On Thu, 21 Mar 2024 17:15:39 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Thu, Mar 21, 2024 at 01:31:47PM -0700, Andrew Morton wrote:
> > > On Thu, 21 Mar 2024 09:36:27 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > > 
> > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > > 
> > > > We're introducing alloc tagging, which tracks memory allocations by
> > > > callsite. Converting alloc_inode_sb() to a macro means allocations will
> > > > be tracked by its caller, which is a bit more useful.
> > > 
> > > I'd have thought that there would be many similar
> > > inlines-which-allocate-memory.  Such as, I dunno, jbd2_alloc_inode(). 
> > > Do we have to go converting things to macros as people report
> > > misleading or less useful results, or is there some more general
> > > solution to this?
> > 
> > No, this is just what we have to do.
> 
> Well, this is something we strike in other contexts - kallsyms gives us
> an inlined function and it's rarely what we wanted.
> 
> I think kallsyms has all the data which is needed to fix this - how
> hard can it be to figure out that a particular function address lies
> within an outer function?  I haven't looked...

This is different, though - even if a function is inlined in multiple
places there's only going to be one instance of a static var defined
within that function.

