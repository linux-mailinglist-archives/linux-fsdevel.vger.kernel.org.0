Return-Path: <linux-fsdevel+bounces-11592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE078550DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C2B29112D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949912883B;
	Wed, 14 Feb 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IUp0RzOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F091272BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933158; cv=none; b=bUSujvhmxHhFAv+GDjMgsfm88M9UBc3XkUjOHisO79epf/pEMAfgs/+w+Z1pU0OJYobMJ0URS3XIRGmn6h4EYrclK6sVRF+ZHs7rW22B1eN3xh8ofTrqMfLWg9nBO+ZYN9rX4wsQV/w/FC8lG+b1LLkOHwxfnV8S9CNw1pbTfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933158; c=relaxed/simple;
	bh=ludUKPauweTDD8POxHffFJwhelusk8jo87YHW7heVtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQeGze7oHpNv73v5fAP9LY86d4SZyTaizsJW+mjMGPC2vIPo8yUAZG8ZvJYWBjzCgBXbODfQBhbQECAy0910kCPviFy4gE98BsRcRe0pIBzlMAppBTCCx+a4PsB+6pHyFPqPExSACySTboazKgaXPyr7PVtxx/CNvY+iETakqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IUp0RzOj; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 12:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707933154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leY9N3alrQ22C+fXPazgCJacTsU7ND5Lt0yRBT6Nl7E=;
	b=IUp0RzOjGR+ggmt5QyQRdV5SyNmk5BeYvtJPmMdFZ/0gdArxfBF61ir/qJD7o6ZZlPI1fa
	T++b6tnGr9lt+Pc8uqq9a0m6P/fzXGm/Y4Z0gDlSz3GfalRNyLUnqF6AUPN+VvXSj2JW0v
	2fUSwnZl9xW1aSObJLfJA6MLK5YNJzA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, axboe@kernel.dk, 
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, 
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <7c3walgmzmcygchqaylcz2un5dandlnzdqcohyooryurx6utxr@66adcw7f26c3>
References: <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <20240214085548.d3608627739269459480d86e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214085548.d3608627739269459480d86e@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 08:55:48AM -0800, Andrew Morton wrote:
> On Tue, 13 Feb 2024 14:59:11 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > > > If you think you can easily achieve what Michal requested without all that,
> > > > good.
> > >
> > > He requested something?
> > 
> > Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
> > possible until the compiler feature is developed and deployed. And it
> > still would require changes to the headers, so don't think it's worth
> > delaying the feature for years.
> 
> Can we please be told much more about this compiler feature? 
> Description of what it is, what it does, how it will affect this kernel
> feature, etc.
> 
> Who is developing it and when can we expect it to become available?
> 
> Will we be able to migrate to it without back-compatibility concerns? 
> (I think "you need quite recent gcc for memory profiling" is
> reasonable).
> 
> 
> 
> Because: if the maintainability issues which Michel describes will be
> significantly addressed with the gcc support then we're kinda reviewing
> the wrong patchset.  Yes, it may be a maintenance burden initially, but
> at some (yet to be revealed) time in the future, this will be addressed
> with the gcc support?

Even if we had compiler magic, after considering it more I don't think
the patchset would be improved by it - I would still prefer to stick
with the macro approach.

There's also a lot of unresolved questions about whether the compiler
approach would even end being what we need; we need macro expansion to
happen in the caller of the allocation function, and that's another
level of hooking that I don't think the compiler people are even
considering yet, since cpp runs before the main part of the compiler; if
C macros worked and were implemented more like Rust macros I'm sure it
could be done - in fact, I think this could all be done in Rust
_without_ any new compiler support - but in C, this is a lot to ask.

Let's look at the instrumentation again. There's two steps:

- Renaming the original function to _noprof
- Adding a hooked version of the original function.

We need to do the renaming regardless of what approach we take in order
to correctly handle allocations that happen inside the context of an
existing alloc tag hook but should not be accounted to the outer
context; we do that by selecting the alloc_foo() or alloc_foo_noprof()
version as appropriate.

It's important to get this right; consider slab object extension
vectors or the slab allocator allocating pages from the page allocator.

Second step, adding a hooked version of the original function. We do
that with

#define alloc_foo(...) alloc_hooks(alloc_foo_noprof(__VA_ARGS__))

That's pretty clean, if you ask me. The only way to make it more succint
be if it were possible for a C macro to define a new macro, then it
could be just

alloc_fn(alloc_foo);

But honestly, the former is probably preferable anyways from a ctags/cscope POV.

