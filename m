Return-Path: <linux-fsdevel+bounces-11599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA78552BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF80E1F2C446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE513B782;
	Wed, 14 Feb 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObjzzCqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08369133438;
	Wed, 14 Feb 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936842; cv=none; b=rU6DSMr8078/516NKGeEu0aYMillys4tht4ROL2sC7bQF3w8z5MvPmLR3z9TBwQ+I9hm3kcOmGEyPI2pVELzUjoPRmLMuhif79VWPnJHtjPM7SbRjlJQih/EeVjbiVYkvI0ZOgXkK+ukmF9+Fnf4emMadSo+EDazHxvNDrT7ZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936842; c=relaxed/simple;
	bh=UOkF8QOipvPnQfr/zLHdbACDQEqVEeAbGnpVM7OMNJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nt6uCLroXMeWKJo5So20wN2WXnFXCoLcnSaamiRkc+baGOfo4TerPjR0by3YIIIphVtRNy4Q7/TgtJXFyU446vBQrdag+7taAwwHSZ+oQSmI9gBh+doFvNBMFLlTBp4yMCC4auVrgLTwf7uByDgdtA+adDZ/1N13PYgpzQ/i53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObjzzCqA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707936840; x=1739472840;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UOkF8QOipvPnQfr/zLHdbACDQEqVEeAbGnpVM7OMNJA=;
  b=ObjzzCqAQWHt2/aYlycAVcxicOj7lC6fYfd2buMkgsqj9g7lIYXTg3hg
   ISVerszMOtLyteSo7W/f0kpX1lT/k74AfJ5V6/Dsup+xvy0JAvY+EoZsk
   DX7674vuDFhB4M3s8n0fUA+udPDiMIyLDLR5uvPkj4EmHL6Qa7b5/NeuI
   qqw0+QS/lJDknwx+po08O7enoBHbdUDoXYVyZMa2yDhilTJCxSnPhMen2
   eVdWI9ad1c1ODW5AG2+RDYuEsOaOtZY5TQuTcyQENMRurV1SRy28cokNg
   XQcFExOICKTc3A5Gi/anNLhbnKjSFpDX4cU7oYEzE60oYQH6Jt3T7eASM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1873606"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1873606"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7891287"
Received: from wfaimone-mobl.amr.corp.intel.com (HELO [10.209.29.231]) ([10.209.29.231])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:53:54 -0800
Message-ID: <4f24986587b53be3f9ece187a3105774eb27c12f.camel@linux.intel.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net,  willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com,  peterz@infradead.org,
 juri.lelli@redhat.com, catalin.marinas@arm.com,  will@kernel.org,
 arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com,  axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org,  dennis@kernel.org, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org,  paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com,  yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com,  elver@google.com, dvyukov@google.com,
 shakeelb@google.com,  songmuchun@bytedance.com, jbaron@akamai.com,
 rientjes@google.com,  minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org,  linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com,  cgroups@vger.kernel.org
Date: Wed, 14 Feb 2024 10:53:53 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
References: <20240212213922.783301-1-surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 13:38 -0800, Suren Baghdasaryan wrote:
> Memory allocation, v3 and final:
>=20
> Overview:
> Low overhead [1] per-callsite memory allocation profiling. Not just for d=
ebug
> kernels, overhead low enough to be deployed in production.
>=20
> We're aiming to get this in the next merge window, for 6.9. The feedback
> we've gotten has been that even out of tree this patchset has already
> been useful, and there's a significant amount of other work gated on the
> code tagging functionality included in this patchset [2].
>=20
> Example output:
>   root@moria-kvm:~# sort -h /proc/allocinfo|tail
>    3.11MiB     2850 fs/ext4/super.c:1408 module:ext4 func:ext4_alloc_inod=
e
>    3.52MiB      225 kernel/fork.c:356 module:fork func:alloc_thread_stack=
_node
>    3.75MiB      960 mm/page_ext.c:270 module:page_ext func:alloc_page_ext
>    4.00MiB        2 mm/khugepaged.c:893 module:khugepaged func:hpage_coll=
apse_alloc_folio
>    10.5MiB      168 block/blk-mq.c:3421 module:blk_mq func:blk_mq_alloc_r=
qs
>    14.0MiB     3594 include/linux/gfp.h:295 module:filemap func:folio_all=
oc_noprof
>    26.8MiB     6856 include/linux/gfp.h:295 module:memory func:folio_allo=
c_noprof
>    64.5MiB    98315 fs/xfs/xfs_rmap_item.c:147 module:xfs func:xfs_rui_in=
it
>    98.7MiB    25264 include/linux/gfp.h:295 module:readahead func:folio_a=
lloc_noprof
>     125MiB     7357 mm/slub.c:2201 module:slub func:alloc_slab_page
>=20
> Since v2:
>  - tglx noticed a circular header dependency between sched.h and percpu.h=
;
>    a bunch of header cleanups were merged into 6.8 to ameliorate this [3]=
.
>=20
>  - a number of improvements, moving alloc_hooks() annotations to the
>    correct place for better tracking (mempool), and bugfixes.
>=20
>  - looked at alternate hooking methods.
>    There were suggestions on alternate methods (compiler attribute,
>    trampolines), but they wouldn't have made the patchset any cleaner
>    (we still need to have different function versions for accounting vs. =
no
>    accounting to control at which point in a call chain the accounting
>    happens), and they would have added a dependency on toolchain
>    support.
>=20
> Usage:
> kconfig options:
>  - CONFIG_MEM_ALLOC_PROFILING
>  - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
>  - CONFIG_MEM_ALLOC_PROFILING_DEBUG
>    adds warnings for allocations that weren't accounted because of a
>    missing annotation
>=20
> sysctl:
>   /proc/sys/vm/mem_profiling
>=20
> Runtime info:
>   /proc/allocinfo
>=20
> Notes:
>=20
> [1]: Overhead
> To measure the overhead we are comparing the following configurations:
> (1) Baseline with CONFIG_MEMCG_KMEM=3Dn
> (2) Disabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
>     CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dn)
> (3) Enabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
>     CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dy)
> (4) Enabled at runtime (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
>     CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dn && /proc/sys/vm/mem_profili=
ng=3D1)
> (5) Baseline with CONFIG_MEMCG_KMEM=3Dy && allocating with __GFP_ACCOUNT
>=20

Thanks for the work on this patchset and it is quite useful.
A clarification question on the data:

I assume Config (2), (3) and (4) has CONFIG_MEMCG_KMEM=3Dn, right?
If so do you have similar data for config (2), (3) and (4) but with
CONFIG_MEMCG_KMEM=3Dy for comparison with (5)?

Tim

> Performance overhead:
> To evaluate performance we implemented an in-kernel test executing
> multiple get_free_page/free_page and kmalloc/kfree calls with allocation
> sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> affinity set to a specific CPU to minimize the noise. Below are results
> from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel on
> 56 core Intel Xeon:
>=20
>                         kmalloc                 pgalloc
> (1 baseline)            6.764s                  16.902s
> (2 default disabled)    6.793s (+0.43%)         17.007s (+0.62%)
> (3 default enabled)     7.197s (+6.40%)         23.666s (+40.02%)
> (4 runtime enabled)     7.405s (+9.48%)         23.901s (+41.41%)
> (5 memcg)               13.388s (+97.94%)       48.460s (+186.71%)
>=20


