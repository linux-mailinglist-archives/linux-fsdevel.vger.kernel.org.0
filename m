Return-Path: <linux-fsdevel+bounces-11563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DD854C56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FBC1F26AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648455F54E;
	Wed, 14 Feb 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QqnVFzdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0154729
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923605; cv=none; b=I15kd/cwsu4+DuKhDpIvYFa1i1AFeN+k/W1Tp+c6L7oo6751gHfrQkVAws95pVG9NEWp8atzwQHmA0hXhzB0vI1reOlHDOE37aE2uzt0+8L+Il7obToI1aiouh8n+RCq+RVtK/UU7eg01tUTO+OmVWrygTRdG+hS01paDH48KDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923605; c=relaxed/simple;
	bh=iLd26OvacHUz2LtzsLY81PDv5FJLEM70pEIMoNjFxWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saDCsTgqctnecQ/NHEq7oiOKiUxyL+l6p807OXYzJcJResLkBpGG5qiFw0MbInQOo+SS2lrSr/fO1lj+Yd9/U7yEnX5nw2zvwDH0r+IVc8zVYPZLag/xU5SPwfSrlW1NWB43GjJ0PlZj5EhGR5xx2hToUjT1nDOrJGHhZkT+f48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QqnVFzdf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707923600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PY07zx4xo5DT+YIldZdwTzLPFVE7nIythW2Rrqykp1E=;
	b=QqnVFzdfgyWfkP1gDQRlNaQ9Xyie0OsgEXlSv6icMe/mIY70ikjjb+WkXEP8tlb20Awecc
	eSWpRmstvlZgXVi+BSGTN5X3X9cM/puYpsElr3tKfaJBdRGgACJD6atY6S0rGhJ3jos+tq
	NUAuld4iYByfqcO+Yc2C3ZNT2XCuffA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
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
Message-ID: <lkozkbcucokzaicygwn7ym2cmmdt6bwyrluxb7ka7ygnrgyyfh@ktvirhq3hrtn>
References: <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <ea5vqiv5rt5cdbrlrdep5flej2pysqbfvxau4cjjbho64652um@7rz23kesqdup>
 <ZczVcOXtmA2C3XX8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZczVcOXtmA2C3XX8@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 03:00:00PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 13, 2024 at 06:08:45PM -0500, Kent Overstreet wrote:
> > This is what instrumenting an allocation function looks like:
> > 
> > #define krealloc_array(...)                     alloc_hooks(krealloc_array_noprof(__VA_ARGS__))
> > 
> > IOW, we have to:
> >  - rename krealloc_array to krealloc_array_noprof
> >  - replace krealloc_array with a one wrapper macro call
> > 
> > Is this really all we're getting worked up over?
> > 
> > The renaming we need regardless, because the thing that makes this
> > approach efficient enough to run in production is that we account at
> > _one_ point in the callstack, we don't save entire backtraces.
> 
> I'm probably going to regret getting involved in this thread, but since
> Suren already decided to put me on the cc ...
> 
> There might be a way to do it without renaming.  We have a bit of the
> linker script called SCHED_TEXT which lets us implement
> in_sched_functions().  ie we could have the equivalent of
> 
> include/linux/sched/debug.h:#define __sched             __section(".sched.text")
> 
> perhaps #define __memalloc __section(".memalloc.text")
> which would do all the necessary magic to know where the backtrace
> should stop.

Could we please try to get through the cover letter before proposing
alternatives? I already explained there why we need the renaming.

In addition, you can't create the per-callsite codetag with linker
magic; you nede the macro for that.

Instead of citing myself again, I'm just going to post what I was
working on last night for the documentation directory:

.. SPDX-License-Identifier: GPL-2.0

===========================
MEMORY ALLOCATION PROFILING
===========================

Low overhead (suitable for production) accounting of all memory allocations,
tracked by file and line number.

Usage:
kconfig options:
 - CONFIG_MEM_ALLOC_PROFILING
 - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
 - CONFIG_MEM_ALLOC_PROFILING_DEBUG
   adds warnings for allocations that weren't accounted because of a
   missing annotation

sysctl:
  /proc/sys/vm/mem_profiling

Runtime info:
  /proc/allocinfo

Example output:
  root@moria-kvm:~# sort -h /proc/allocinfo|tail
   3.11MiB     2850 fs/ext4/super.c:1408 module:ext4 func:ext4_alloc_inode
   3.52MiB      225 kernel/fork.c:356 module:fork func:alloc_thread_stack_node
   3.75MiB      960 mm/page_ext.c:270 module:page_ext func:alloc_page_ext
   4.00MiB        2 mm/khugepaged.c:893 module:khugepaged func:hpage_collapse_alloc_folio
   10.5MiB      168 block/blk-mq.c:3421 module:blk_mq func:blk_mq_alloc_rqs
   14.0MiB     3594 include/linux/gfp.h:295 module:filemap func:folio_alloc_noprof
   26.8MiB     6856 include/linux/gfp.h:295 module:memory func:folio_alloc_noprof
   64.5MiB    98315 fs/xfs/xfs_rmap_item.c:147 module:xfs func:xfs_rui_init
   98.7MiB    25264 include/linux/gfp.h:295 module:readahead func:folio_alloc_noprof
    125MiB     7357 mm/slub.c:2201 module:slub func:alloc_slab_page


Theory of operation:

Memory allocation profiling builds off of code tagging, which is a library for
declaring static structs (that typcially describe a file and line number in
some way, hence code tagging) and then finding and operating on them at runtime
- i.e. iterating over them to print them in debugfs/procfs.

To add accounting for an allocation call, we replace it with a macro
invocation, alloc_hooks(), that
 - declares a code tag
 - stashes a pointer to it in task_struct
 - calls the real allocation function
 - and finally, restores the task_struct alloc tag pointer to its previous value.

This allows for alloc_hooks() calls to be nested, with the most recent one
taking effect. This is important for allocations internal to the mm/ code that
do not properly belong to the outer allocation context and should be counted
separately: for example, slab object extension vectors, or when the slab
allocates pages from the page allocator.

Thus, proper usage requires determining which function in an allocation call
stack should be tagged. There are many helper functions that essentially wrap
e.g. kmalloc() and do a little more work, then are called in multiple places;
we'll generally want the accounting to happen in the callers of these helpers,
not in the helpers themselves.

To fix up a given helper, for example foo(), do the following:
 - switch its allocation call to the _noprof() version, e.g. kmalloc_noprof()
 - rename it to foo_noprof()
 - define a macro version of foo() like so:
   #define foo(...) alloc_hooks(foo_noprof(__VA_ARGS__))

