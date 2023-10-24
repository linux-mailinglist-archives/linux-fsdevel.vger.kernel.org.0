Return-Path: <linux-fsdevel+bounces-1117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EAB7D5AB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95A11F229FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01A635896;
	Tue, 24 Oct 2023 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qxmyiqZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491D2C85B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 18:38:34 +0000 (UTC)
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 11:38:32 PDT
Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6C186
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 11:38:31 -0700 (PDT)
Date: Tue, 24 Oct 2023 11:29:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698172172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJvtH1RU485LotJpakrbV9U/UfyKsr5ptSPtEPeho50=;
	b=qxmyiqZdvUbSc5OX8sJ5B56VRDGRIypt0m2ZexyNmyd2CWJuUlLqxDCgQmiWZxhgLrnEJP
	Q3PacIpe5vXTiE86jUv2kcvB2COry3b6xKIlN2wW5y2pG9dxxNOj26Rwsg8w9wjXki2GwQ
	/5zO2TFTFVb+ghWrRC0JLTshCp62Kqo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, ldufour@linux.ibm.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
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
Subject: Re: [PATCH v2 00/39] Memory allocation profiling
Message-ID: <ZTgM74EapT9mea2l@P9FQF9L96D.corp.robot.car>
References: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 24, 2023 at 06:45:57AM -0700, Suren Baghdasaryan wrote:
> Updates since the last version [1]
> - Simplified allocation tagging macros;
> - Runtime enable/disable sysctl switch (/proc/sys/vm/mem_profiling)
> instead of kernel command-line option;
> - CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT to select default enable state;
> - Changed the user-facing API from debugfs to procfs (/proc/allocinfo);
> - Removed context capture support to make patch incremental;
> - Renamed uninstrumented allocation functions to use _noprof suffix;
> - Added __GFP_LAST_BIT to make the code cleaner;
> - Removed lazy per-cpu counters; it turned out the memory savings was
> minimal and not worth the performance impact;

Hello Suren,

> Performance overhead:
> To evaluate performance we implemented an in-kernel test executing
> multiple get_free_page/free_page and kmalloc/kfree calls with allocation
> sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> affinity set to a specific CPU to minimize the noise. Below is performance
> comparison between the baseline kernel, profiling when enabled, profiling
> when disabled and (for comparison purposes) baseline with
> CONFIG_MEMCG_KMEM enabled and allocations using __GFP_ACCOUNT:
> 
>                         kmalloc                 pgalloc
> (1 baseline)            12.041s                 49.190s
> (2 default disabled)    14.970s (+24.33%)       49.684s (+1.00%)
> (3 default enabled)     16.859s (+40.01%)       56.287s (+14.43%)
> (4 runtime enabled)     16.983s (+41.04%)       55.760s (+13.36%)
> (5 memcg)               33.831s (+180.96%)      51.433s (+4.56%)

some recent changes [1] to the kmem accounting should have made it quite a bit
faster. Would be great if you can provide new numbers for the comparison.
Maybe with the next revision?

And btw thank you (and Kent): your numbers inspired me to do this kmemcg
performance work. I expect it still to be ~twice more expensive than your
stuff because on the memcg side we handle separately charge and statistics,
but hopefully the difference will be lower.

Thank you!

[1]:
  patches from next tree, so no stable hashes:
    mm: kmem: reimplement get_obj_cgroup_from_current()
    percpu: scoped objcg protection
    mm: kmem: scoped objcg protection
    mm: kmem: make memcg keep a reference to the original objcg
    mm: kmem: add direct objcg pointer to task_struct
    mm: kmem: optimize get_obj_cgroup_from_current()

