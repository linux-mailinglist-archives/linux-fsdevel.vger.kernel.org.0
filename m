Return-Path: <linux-fsdevel+bounces-11776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC41857129
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B2D283C14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DB314534D;
	Thu, 15 Feb 2024 23:06:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440E1E4AE;
	Thu, 15 Feb 2024 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038376; cv=none; b=t4nbKaMEnHb+cgGX+Lxa3qci7COIpToUl0oQs0RNbzgg4qhO67Gi/hoN7g271o/Uov6J8yexYBilC3HdITrmvQsmMX2KI/ZKB5AvV7APjiL/yQUGHSOaQEbjVov+Pdy3rOzEmldSUBm9PBu465w5H+1I2euT9ryRVj2bdRzR2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038376; c=relaxed/simple;
	bh=Yr+w1U4Y8wjwgyflICnZduU/mzsMv8LUiVO1kjJAeNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWlYOBOKY6yGE3d0pOdlxRe6h4NRxUiP0cJ9HLjUvjOH8IMEydYaUwNJOHmhoDoMWrxO+96pEqUaKBEuOr4T9q5oegZiaG+3oGYiPPedVf6A0mmHAewB5m0uqB6D3eUJy5/KIyTaetUOhzeZadtcuGBU+qk5yI/2y9zMyfaD19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28195C433F1;
	Thu, 15 Feb 2024 23:06:08 +0000 (UTC)
Date: Thu, 15 Feb 2024 18:07:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in
 show_mem()
Message-ID: <20240215180742.34470209@gandalf.local.home>
In-Reply-To: <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
References: <20240212213922.783301-1-surenb@google.com>
	<20240212213922.783301-32-surenb@google.com>
	<Zc3X8XlnrZmh2mgN@tiehlicka>
	<CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
	<Zc4_i_ED6qjGDmhR@tiehlicka>
	<CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
	<ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
	<320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
	<efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 15:33:30 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> > Well, I think without __GFP_NOWARN it will cause a warning and thus
> > recursion into __show_mem(), potentially infinite? Which is of course
> > trivial to fix, but I'd myself rather sacrifice a bit of memory to get
> > this potentially very useful output, if I enabled the profiling. The
> > necessary memory overhead of page_ext and slabobj_ext makes the
> > printing buffer overhead negligible in comparison?  
> 
> __GFP_NOWARN is a good point, we should have that.
> 
> But - and correct me if I'm wrong here - doesn't an OOM kick in well
> before GFP_ATOMIC 4k allocations are failing? I'd expect the system to
> be well and truly hosed at that point.
> 
> If we want this report to be 100% reliable, then yes the preallocated
> buffer makes sense - but I don't think 100% makes sense here; I think we
> can accept ~99% and give back that 4k.

I just compiled v6.8-rc4 vanilla (with a fedora localmodconfig build) and
saved it off (vmlinux.orig), then I compiled with the following:

Applied the patches but did not enable anything:	vmlinux.memtag-off
Enabled MEM_ALLOC_PROFILING:				vmlinux.memtag
Enabled MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT:		vmlinux.memtag-default-on
Enabled MEM_ALLOC_PROFILING_DEBUG:			vmlinux.memtag-debug

And here's what I got:

   text         data            bss     dec             hex filename
29161847        18352730        5619716 53134293        32ac3d5 vmlinux.orig
29162286        18382638        5595140 53140064        32ada60 vmlinux.memtag-off		(+5771)
29230868        18887662        5275652 53394182        32ebb06 vmlinux.memtag			(+259889)
29230746        18887662        5275652 53394060        32eba8c vmlinux.memtag-default-on	(+259767) dropped?
29276214        18946374        5177348 53399936        32ed180 vmlinux.memtag-debug		(+265643)

Just adding the patches increases the size by 5k. But the rest shows an
increase of 259k, and you are worried about 4k (and possibly less?)???

-- Steve

