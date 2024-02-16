Return-Path: <linux-fsdevel+bounces-11805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389F7857353
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 02:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E883E281C38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405BDDA7;
	Fri, 16 Feb 2024 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VvLy9G9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17522C157;
	Fri, 16 Feb 2024 01:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046305; cv=none; b=W/gQ4eYE7b6Auoz5q+02dkFNCItbk8vwm5ZvWc9gF7MEJIs5VbP3GkAQ1nDxrEmV48w+3oCKH3GTKJh0eepE3c8Nsp2jH2GEH0ld3QIQzBqRBHiNAEAhWZd1enQKa9uwzbGqHs/+6D41noYICtZX69nSGbWhhoRsG83jwkxZyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046305; c=relaxed/simple;
	bh=SImHmNOJ0uQjKIEfS74x0xc8FDTiX10aCgs9NMy9nsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XleTU48xSkKroDBTdGZnTI7Hn6vlTrTRo9dkNL9U1OLv/Z0NacbgHesLKUdgfY6s2WBTbTbIRDLPBIDTLteRL6QRTuNZrSMDi5Nei9xfoXBOzVmzMRsP0tRDMwcmLbfG5RIm/eT6x4JfAiBpyZ35e7dyskDEmg8Lr6i2BLtvcEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VvLy9G9e; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Feb 2024 20:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708046301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAMs9Q6+KFAg+NYYq7o0yZrwECRUxYPjpxPWeQP60LM=;
	b=VvLy9G9ezGuxGOd+eP1RYU4I0249ljs+D9z76x6+dgFg9CGUGAv2/TUEwSPhw6sps6gWmy
	i2lwoAFKg305ldYV+64iAQFT6IXMszfpijuEy7fIEEMnaOksDPcJWnmhp9kryevhjS0CXB
	JgOIZ/GAeqjz5/+7AuLvC8lRNIMvI3s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, david@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <wcvio3ad2yfsmqs3ogfau4uiz5dqc6aw6ttfnvocub7ebb2ziw@streccxstkmf>
References: <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
 <jpmlfejxcmxa7vpsuyuzykahr6kz5vjb44ecrzfylw7z4un3g7@ia3judu4xkfp>
 <20240215192141.03421b85@gandalf.local.home>
 <uhagqnpumyyqsnf4qj3fxm62i6la47yknuj4ngp6vfi7hqcwsy@lm46eypwe2lp>
 <20240215193915.2d457718@gandalf.local.home>
 <a3ha7fchkeugpthmatm5lw7chg6zxkapyimn3qio3pkoipg4tc@3j6xfdfoustw>
 <20240215201239.30ea2ca8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215201239.30ea2ca8@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 15, 2024 at 08:12:39PM -0500, Steven Rostedt wrote:
> On Thu, 15 Feb 2024 19:50:24 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > > All nice, but where are the benchmarks? This looks like it will have an
> > > affect on cache and you can talk all you want about how it will not be an
> > > issue, but without real world benchmarks, it's meaningless. Numbers talk.  
> > 
> > Steve, you're being demanding. We provided sufficient benchmarks to show
> > the overhead is low enough for production, and then I gave you a
> > detailed breakdown of where our overhead is and where it'll show up. I
> > think that's reasonable.
> 
> It's not unreasonable or demanding to ask for benchmarks. You showed only
> micro-benchmarks that do not show how cache misses may affect the system.
> Honestly, it sounds like you did run other benchmarks and didn't like the
> results and are fighting to not have to produce them. Really, how hard is
> it? There's lots of benchmarks you can run, like hackbench, stress-ng,
> dbench. Why is this so difficult for you?

Woah, this is verging into paranoid conspiracy territory.

No, we haven't done other benchmarks, and if we had we'd be sharing
them. And if I had more time to spend on performance of this patchset
that's not where I'd be spending it; the next thing I'd be looking at
would be assembly output of the hooking code and seeing if I could shave
that down.

But I already put a ton of work into shaving cycles on this patchset,
I'm happy with the results, and I have other responsibilities and other
things I need to be working on.

