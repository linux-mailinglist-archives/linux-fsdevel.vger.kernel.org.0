Return-Path: <linux-fsdevel+bounces-11581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3D3854EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A880828525C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8455F6166D;
	Wed, 14 Feb 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xm+zNKCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428C60EF8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928710; cv=none; b=SOrvGk665QP0b25MELITted2maxwkK4yCd2Gia1Wm+m62Q0VXQIrCW7oWbwm7bJHoLXbGg1B2h6k33LaFR+fJuPvhZXG7AQAMDYjmn/gqgDtKdSPGJ6nbEysHYwVD8CbM+pNpribtQLKzQHJ9WpSU9pyggt00uC9qgwPn7xGt7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928710; c=relaxed/simple;
	bh=3a96hFHa9kHGgs4R7+BbKUdcoCcJIe8Xk80EXRVjjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccrsd6Gq6wISB/tGLGrYo3jU7BXU/N5G+3+Y6t82D+jVLzyTD1vwkycQStAnaOi3XCelGy0HK2UdSMgUR7GN+Gpwdgd54YP6F038os4Wyx3i4zf4PEQl0VUL0nx5fivootr8LBcIP4t6EW+0ZKifC+31C5oDDxB9P4uk0OKcHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xm+zNKCM; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 11:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707928705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GhC8U54i48aAhQsKXgUpTdpqc3Q9oBEWvXQFXanbxaU=;
	b=Xm+zNKCMeqV79v7rJ5E5an4MzgIP4PD8/8ugFWMqKQm3NKxkYrYq0OYQxclkHYIL8RZCoP
	TC2LBaoxPghcPUQzNf8N/tkj2r5IU55ThbSV14NQ/Bs/1muwGdvLMDBwjC0Nd8EVp21WU+
	XnEe90fkimXt0ALl4VLMlcoyT6d4gss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
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
Message-ID: <wbe5dfkrjpspzykhbi4dshhfgc4t3jpyymutogppyyevzxyyra@r32wpro3xrbi>
References: <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <ea5vqiv5rt5cdbrlrdep5flej2pysqbfvxau4cjjbho64652um@7rz23kesqdup>
 <4bb7b1e4-d107-4708-bb65-ac44d4af9959@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb7b1e4-d107-4708-bb65-ac44d4af9959@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 11:20:26AM +0100, Vlastimil Babka wrote:
> On 2/14/24 00:08, Kent Overstreet wrote:
> > And, as I keep saying: that alloc_hooks() macro will also get us _per
> > callsite fault injection points_, and we really need that because - if
> > you guys have been paying attention to other threads - whenever moving
> > more stuff to PF_MEMALLOC_* flags comes up (including adding
> > PF_MEMALLOC_NORECLAIM), the issue of small allocations not failing and
> > not being testable keeps coming up.
> 
> How exactly do you envision the fault injection to help here? The proposals
> are about scoping via a process flag, and the process may then call just
> about anything under that scope. So if our tool is per callsite fault
> injection points, how do we know which callsites to enable to focus the
> fault injection on the particular scope?

So the question with fault injection is - how do we integrate it into
our existing tests?

We need fault injection that we can integrate into our existing tests
because that's the only way to get the code coverage we need - writing
new tests that cover all the error paths isn't going to happen, and
wouldn't work as well anyways.

But the trouble with injecting memory allocation failures is that
they'll result in errors bubbling up to userspace, and in unpredictable
ways.

We _definitely_ cannot enable random memory allocation faults for the
entire kernel at runttme - or rather we _could_, and that would actually
be great to do as a side project; but that's not something we can do in
our existing automated tests because the results will be completely
unpredictable. If we did that the goal would be to just make sure the
kernel doesn't explode - but what we actually want is for our automated
pass/fail tests to still pass; we need to constrain what will fail.

So we need at a minumum to be able to only enable memory allocation
failures for the code we're interested in testing (file/module) -
enabling memory allocation failures in some other random subsystem we're
not developing or looking at isn't what we want.

Beyond that, it's very much subsystem dependent. For bcachefs, my main
strategy has been to flip on random (1%) memory allocation failures
after the filesystem has mounted. During startup, we do a ton of
allocations (I cover those with separate tests), but after startup we
should be able to run normally in the precence of allocation failures
without ever returning an error to userspace - so that's what I'm trying
to test.

