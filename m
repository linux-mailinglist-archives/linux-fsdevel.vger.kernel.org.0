Return-Path: <linux-fsdevel+bounces-11494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7AD853FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1242C289F77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11F762A12;
	Tue, 13 Feb 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fgDMRJQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAB63064
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865740; cv=none; b=ZHr/q2vOTBdx1CjfmRq/MlyYySUVfjoCsVGNAWVlQ7JjUDhOSXwMa3j6ENkxxdlt6NGKVWtEDY88hZ5KCCkahU2PJfZnJu31D5S04/Q1/mLf+eXzo1vI9fdJcRZHZQZkXFGJDSsiGFhM7bMMhY28eNsEi5n3puEG9DJsj2LK2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865740; c=relaxed/simple;
	bh=oSEYpaQQXIFBmm8j7pPX8SQEbcBxd6Q82+KoVb/vVlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khVA1UO8XeLe3k2A5KtATNmrmft5z/FWRbPVsvCY4NLjGF+SCGkveTYJBavjyIoVNzDOEs7qYtZDDqkDRcP7NWyoM7En1phiKCK3GPlz81u+kedEKDT3+2C1TY770UxtNP6ISY3B3M8rGN6d4PLYxiCnSqG1C9vXBTMhj+xGVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fgDMRJQx; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 18:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707865736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mzqjn1+my5U+9pn6lTJcYt1NGpNIWi5Z/k5UXgeN0+U=;
	b=fgDMRJQxyg5ZaQ70wbvauQeVygT0FUfeMQ0qsWNmo4yVngfupLaBrifbmmB+NDciVw113f
	tg8T47r7vMzyQ7sfjXo6vLQrPP7wW35nMBVJrJoXBgP/YacFTsuXiEfZo2MVbtwEd3WQkY
	dJ6BjWexLTLrv4mambztuLxFKiGSJdE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, 
	akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <ea5vqiv5rt5cdbrlrdep5flej2pysqbfvxau4cjjbho64652um@7rz23kesqdup>
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 02:59:11PM -0800, Suren Baghdasaryan wrote:
> On Tue, Feb 13, 2024 at 2:50 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
> > > On 13.02.24 23:30, Suren Baghdasaryan wrote:
> > > > On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
> > > If you think you can easily achieve what Michal requested without all that,
> > > good.
> >
> > He requested something?
> 
> Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
> possible until the compiler feature is developed and deployed. And it
> still would require changes to the headers, so don't think it's worth
> delaying the feature for years.

Hang on, let's look at the actual code.

This is what instrumenting an allocation function looks like:

#define krealloc_array(...)                     alloc_hooks(krealloc_array_noprof(__VA_ARGS__))

IOW, we have to:
 - rename krealloc_array to krealloc_array_noprof
 - replace krealloc_array with a one wrapper macro call

Is this really all we're getting worked up over?

The renaming we need regardless, because the thing that makes this
approach efficient enough to run in production is that we account at
_one_ point in the callstack, we don't save entire backtraces.

And thus we need to explicitly annotate which one that is; which means
we need _noprof() versions of functions for when the accounting is done
by an outer wraper (e.g. mempool).

And, as I keep saying: that alloc_hooks() macro will also get us _per
callsite fault injection points_, and we really need that because - if
you guys have been paying attention to other threads - whenever moving
more stuff to PF_MEMALLOC_* flags comes up (including adding
PF_MEMALLOC_NORECLAIM), the issue of small allocations not failing and
not being testable keeps coming up.

