Return-Path: <linux-fsdevel+bounces-11780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A50785718F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DB51F22FF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7C145B15;
	Thu, 15 Feb 2024 23:26:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707413B2AB;
	Thu, 15 Feb 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039563; cv=none; b=rBmTRMmLwHyk6fskQHTNUzWcv20qDMxOU32C9/w3QE85W+G3la0PbIvArsgRG779zwQIkGbU2kgWQL6NfCEzTBBha3vldG2IMjtBhy85trEZ2wTz7A3eY4w3EXYasBCbVi/cZG816aX3o9jwU+LZNF133UxYz7/OUX2krmS6gUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039563; c=relaxed/simple;
	bh=XS5bJqlP4STQgp1DfmpPHfkB4RaRvPoEvv+ra766L+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gI1HFXSuCMFRc5NHOWZGJ1P9hJdHEvsoSuXX3VH88Sz9MZ1HcA8ybXqIey6j1FSz3hGEG5E4tqXSPLTVn6kyhbflJo7mbqI6TPFJrhm53IkWWaAFEGfq4b30CiNvb0qB4rIICedJNyIrGx14wm7k9egYhq+817EPlDv3CZ7bdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6610C433F1;
	Thu, 15 Feb 2024 23:25:55 +0000 (UTC)
Date: Thu, 15 Feb 2024 18:27:29 -0500
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
Message-ID: <20240215182729.659f3f1c@gandalf.local.home>
In-Reply-To: <20240215181648.67170ed5@gandalf.local.home>
References: <20240212213922.783301-1-surenb@google.com>
	<20240212213922.783301-32-surenb@google.com>
	<Zc3X8XlnrZmh2mgN@tiehlicka>
	<CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
	<Zc4_i_ED6qjGDmhR@tiehlicka>
	<CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
	<ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
	<320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
	<efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
	<20240215180742.34470209@gandalf.local.home>
	<20240215181648.67170ed5@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 18:16:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 15 Feb 2024 18:07:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >    text         data            bss     dec             hex filename
> > 29161847        18352730        5619716 53134293        32ac3d5 vmlinux.orig
> > 29162286        18382638        5595140 53140064        32ada60 vmlinux.memtag-off		(+5771)
> > 29230868        18887662        5275652 53394182        32ebb06 vmlinux.memtag			(+259889)
> > 29230746        18887662        5275652 53394060        32eba8c vmlinux.memtag-default-on	(+259767) dropped?
> > 29276214        18946374        5177348 53399936        32ed180 vmlinux.memtag-debug		(+265643)  
> 
> If you plan on running this in production, and this increases the size of
> the text by 68k, have you measured the I$ pressure that this may induce?
> That is, what is the full overhead of having this enabled, as it could
> cause more instruction cache misses?
> 
> I wonder if there has been measurements of it off. That is, having this
> configured in but default off still increases the text size by 68k. That
> can't be good on the instruction cache.
> 

I should have read the cover letter ;-)  (someone pointed me to that on IRC):

> Performance overhead:
> To evaluate performance we implemented an in-kernel test executing
> multiple get_free_page/free_page and kmalloc/kfree calls with allocation
> sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> affinity set to a specific CPU to minimize the noise. Below are results
> from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel on
> 56 core Intel Xeon:

These are micro benchmarks, were any larger benchmarks taken? As
microbenchmarks do not always show I$ issues (because the benchmark itself
will warm up the cache). The cache issue could slow down tasks at a bigger
picture, as it can cause more cache misses.

Running other benchmarks under perf and recording the cache misses between
the different configs would be a good picture to show.

> 
>                         kmalloc                 pgalloc
> (1 baseline)            6.764s                  16.902s
> (2 default disabled)    6.793s (+0.43%)         17.007s (+0.62%)
> (3 default enabled)     7.197s (+6.40%)         23.666s (+40.02%)
> (4 runtime enabled)     7.405s (+9.48%)         23.901s (+41.41%)
> (5 memcg)               13.388s (+97.94%)       48.460s (+186.71%)


> 
> Memory overhead:
> Kernel size:
> 
>    text           data        bss         dec         diff
> (1) 26515311	      18890222    17018880    62424413
> (2) 26524728	      19423818    16740352    62688898    264485
> (3) 26524724	      19423818    16740352    62688894    264481
> (4) 26524728	      19423818    16740352    62688898    264485
> (5) 26541782	      18964374    16957440    62463596    39183

Similar to my builds.


> 
> Memory consumption on a 56 core Intel CPU with 125GB of memory:
> Code tags:           192 kB
> PageExts:         262144 kB (256MB)
> SlabExts:           9876 kB (9.6MB)
> PcpuExts:            512 kB (0.5MB)
> 
> Total overhead is 0.2% of total memory.


All this, and we are still worried about 4k for useful debugging :-/

-- Steve

