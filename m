Return-Path: <linux-fsdevel+bounces-15029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E57DC8861CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 21:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862471F22D1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F25135A5C;
	Thu, 21 Mar 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sk1DY3Jk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F513540C;
	Thu, 21 Mar 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053721; cv=none; b=BQj80c/5cj6cHZJgWLlTSlBscgNTBM9mBl6Q41jUunh3RqvZ3yKiN5OOrDX7jR8MIsDctAzQmsEPuXBhfXUAhlAbbrVzBj0G9bPrVtZWqHiQRFt4LEvUdCags5cmJazBhtEO6r0OYpHQVERZ4Lm1kdXcOGLdzxAlh17DMOYUnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053721; c=relaxed/simple;
	bh=bsLnMq6f9MuSXEybZlFqoUeze7bLA8PKxbpvqrgPFq0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pB3VB3z1YCcuIA1tOCtM1XwQ+udvkGE78M+1ikN2PkF2eObQiyaoFTAkSsYL6w7gjOtlWW4g5K2yKYJHKx33fA21QfJnyxY9mSS4zw8JEvIUrswHG30P5qEFnXiUSbyyjvFDGd2kVIiz0uBNehjlpZVHwL3xqYySy2wBelZFUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sk1DY3Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D384C433C7;
	Thu, 21 Mar 2024 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711053720;
	bh=bsLnMq6f9MuSXEybZlFqoUeze7bLA8PKxbpvqrgPFq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sk1DY3JksFP68PjXEwOnUAq1Vd5lNUolSDYThGrqzyyqLQr4fombyuh40LdrgfYbW
	 Ac/65wSglYIyyBBtUS08I78shDAf7A7GSt+MOEK7LRTFv12fDEKGSsGGb3if8rK0ti
	 YWcirP5763C8DrAMcFLznADKk78RtFDyLeMAKgoA=
Date: Thu, 21 Mar 2024 13:41:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
Message-Id: <20240321134157.212f0fbe1c03479c01e8a69e@linux-foundation.org>
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 09:36:22 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Low overhead [1] per-callsite memory allocation profiling. Not just for
> debug kernels, overhead low enough to be deployed in production.
> 
> Example output:
>   root@moria-kvm:~# sort -rn /proc/allocinfo
>    127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
>     56373248     4737 mm/slub.c:2259 func:alloc_slab_page
>     14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
>     14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
>     13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
>     11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
>      9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
>      4206592        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct_alloc_hashtable
>      4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] func:ctagmod_start
>      3940352      962 mm/memory.c:4214 func:alloc_anon_folio
>      2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node

Did you consider adding a knob to permit all the data to be wiped out? 
So people can zap everything, run the chosen workload then go see what
happened?

Of course, this can be done in userspace by taking a snapshot before
and after, then crunching on the two....

