Return-Path: <linux-fsdevel+bounces-16198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D1899F32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628A61F2437F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB516EC01;
	Fri,  5 Apr 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9cIbNdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA016EBE8
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326467; cv=none; b=Mls3VXfOf4NyEGivWkxyi7vg9D+8X415D8DTZC//0xQ7O3UXYkj5j/MkEqFb+KwPyGsK5dih4ilU1bxQgUCjpDmOgMpa68df+DAU8qJ4iSclbzESyZvIL0SwLNd7HOLaPooX8T6eS5dGzFJmx6vSx/5lZCDmn02xo22TuM7NBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326467; c=relaxed/simple;
	bh=/3Ff0ruSdSe2swlOVf02/BjidRrZyf0D/8DkjYb/ays=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQlh3reEGZJt9UYmRfsRprO3HaZ9aS2bkaAU4AWNQ+v4s+dngT/A5M1xFLS0bWpfeIxoR+D+isugS1WM7YQLPl2iuIpAbWW7PP/5X4TYKQt70fsO+903eCe/zeQNmi5z577RfdywhyJJpiwNhtjLoUbJZqdF/SrUCXbGVwRo5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9cIbNdh; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso2444941276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326465; x=1712931265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpu1q6SRpmnX63rYNMcOKU3gYj7mEiDBoir+Gp671n0=;
        b=m9cIbNdhfbiUpGNUSPqcDbHILtBQP+M5o/MovmM8BAVPq9GI/VOtL/o3RGDDPc8dtv
         Lj81qvHQsKZqY2+lN7WkFGWkSyV1KHRIYN0Af6zlIZJl5XRpqkbryrDRsBOET3UMX6az
         go+D87uWk04bZWqJzuyHK5zINSei7kY+4REtcOi/q/YzPP/V+a1r9VaeKF5EAXWfS+L2
         MOLSgmbAWbB5C7VTz4yQ6KTmTl0ljAAzc7QK0Q7eZSo0LJ6fiaKQoXiaxrCi24I6oFUg
         y1CHV5cBBnsEDB0fgKjyS7P8HWj5ZzqOia5QJzgQ6v64sFz82e44gtzY3AUCHJuTwmzF
         v5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326465; x=1712931265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpu1q6SRpmnX63rYNMcOKU3gYj7mEiDBoir+Gp671n0=;
        b=PNdzRmp3BoixAG/tsXO+38bdqEmfrLRYCCYfaiK8KvydJ6Vtc/GNK1/J+00jQXBAJK
         vqluhv3r49S3JDqj7ADoLaQe3/RliOEjD7sH48MY8rMpEoaNWN8FwRjptdr/30e7Wz6F
         k2jeWsJevkJKrpigtijAx65jjHtNFvZ7GlFRTwG771mYoW2WaEuNAxX2j2dVnscfA842
         3Az+bVcubEaH6/wsuyuLIgPJu27ol10vMUkv7qUor4JbduCFmjhYTJAldiHBKQX/Uhub
         345px770d4oiXfpTooeVvj4AveOL/2uFqHo5qaLYFTqVRw+RYpnyUhnygVCbfWc+3yz7
         D/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPddJTRIFU3bMscYf5O1slHZD0ZTELyuIs6YOso0XQjktF/36bd6U4vd9JIg9GICm1N+klPPQLumaSvSOaDHRBM3HA4+9Xvpigf0si3g==
X-Gm-Message-State: AOJu0YwH+ArsNNOmSh9GnGkxT3tv+RIUBcUE2xYSGJs/4Yk+djqMGiYq
	8smFkFJfcWxtldTX0IFx9Mxwgpw4DocH7QRpwO/VurJ93aEgoUrpIe9EHyKze8Rnag2NTDMSYKM
	hjGL4rW6SCaQ6ERsap1OMe5vzZ4JlaBgnuRq5
X-Google-Smtp-Source: AGHT+IHDoL8CyE4JI6s6nrfOOaPQHBhIqvTMcGBGoOIQ6VIDYTEmV/Kyll+3WtknG2SvBV6fBNw77eOzOIYfr57jOZQ=
X-Received: by 2002:a05:6902:4a:b0:dc7:32ea:c89f with SMTP id
 m10-20020a056902004a00b00dc732eac89fmr1241871ybh.15.1712326464281; Fri, 05
 Apr 2024 07:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <c14cd89b-c879-4474-a800-d60fc29c1820@gmail.com>
In-Reply-To: <c14cd89b-c879-4474-a800-d60fc29c1820@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 5 Apr 2024 07:14:13 -0700
Message-ID: <CAJuCfpHEt2n6sA7m5zvc-F+z=3-twVEKfVGCa0+y62bT10b0Bw@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
To: Klara Modin <klarasmodin@gmail.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 6:37=E2=80=AFAM Klara Modin <klarasmodin@gmail.com> =
wrote:
>
> Hi,
>
> On 2024-03-21 17:36, Suren Baghdasaryan wrote:
> > Overview:
> > Low overhead [1] per-callsite memory allocation profiling. Not just for
> > debug kernels, overhead low enough to be deployed in production.
> >
> > Example output:
> >    root@moria-kvm:~# sort -rn /proc/allocinfo
> >     127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
> >      56373248     4737 mm/slub.c:2259 func:alloc_slab_page
> >      14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
> >      14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
> >      13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
> >      11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
> >       9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
> >       4206592        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_c=
t_alloc_hashtable
> >       4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] f=
unc:ctagmod_start
> >       3940352      962 mm/memory.c:4214 func:alloc_anon_folio
> >       2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node
> >       ...
> >
> > Since v5 [2]:
> > - Added Reviewed-by and Acked-by, per Vlastimil Babka and Miguel Ojeda
> > - Changed pgalloc_tag_{add|sub} to use number of pages instead of order=
, per Matthew Wilcox
> > - Changed pgalloc_tag_sub_bytes to pgalloc_tag_sub_pages and adjusted t=
he usage, per Matthew Wilcox
> > - Moved static key check before prepare_slab_obj_exts_hook(), per Vlast=
imil Babka
> > - Fixed RUST helper, per Miguel Ojeda
> > - Fixed documentation, per Randy Dunlap
> > - Rebased over mm-unstable
> >
> > Usage:
> > kconfig options:
> >   - CONFIG_MEM_ALLOC_PROFILING
> >   - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> >   - CONFIG_MEM_ALLOC_PROFILING_DEBUG
> >     adds warnings for allocations that weren't accounted because of a
> >     missing annotation
> >
> > sysctl:
> >    /proc/sys/vm/mem_profiling
> >
> > Runtime info:
> >    /proc/allocinfo
> >
> > Notes:
> >
> > [1]: Overhead
> > To measure the overhead we are comparing the following configurations:
> > (1) Baseline with CONFIG_MEMCG_KMEM=3Dn
> > (2) Disabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
> >      CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dn)
> > (3) Enabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
> >      CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dy)
> > (4) Enabled at runtime (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
> >      CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dn && /proc/sys/vm/mem_prof=
iling=3D1)
> > (5) Baseline with CONFIG_MEMCG_KMEM=3Dy && allocating with __GFP_ACCOUN=
T
> > (6) Disabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
> >      CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dn)  && CONFIG_MEMCG_KMEM=
=3Dy
> > (7) Enabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
> >      CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dy) && CONFIG_MEMCG_KMEM=3D=
y
> >
> > Performance overhead:
> > To evaluate performance we implemented an in-kernel test executing
> > multiple get_free_page/free_page and kmalloc/kfree calls with allocatio=
n
> > sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> > affinity set to a specific CPU to minimize the noise. Below are results
> > from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel on
> > 56 core Intel Xeon:
> >
> >                          kmalloc                 pgalloc
> > (1 baseline)            6.764s                  16.902s
> > (2 default disabled)    6.793s  (+0.43%)        17.007s (+0.62%)
> > (3 default enabled)     7.197s  (+6.40%)        23.666s (+40.02%)
> > (4 runtime enabled)     7.405s  (+9.48%)        23.901s (+41.41%)
> > (5 memcg)               13.388s (+97.94%)       48.460s (+186.71%)
> > (6 def disabled+memcg)  13.332s (+97.10%)       48.105s (+184.61%)
> > (7 def enabled+memcg)   13.446s (+98.78%)       54.963s (+225.18%)
> >
> > Memory overhead:
> > Kernel size:
> >
> >     text           data        bss         dec         diff
> > (1) 26515311        18890222    17018880    62424413
> > (2) 26524728        19423818    16740352    62688898    264485
> > (3) 26524724        19423818    16740352    62688894    264481
> > (4) 26524728        19423818    16740352    62688898    264485
> > (5) 26541782        18964374    16957440    62463596    39183
> >
> > Memory consumption on a 56 core Intel CPU with 125GB of memory:
> > Code tags:           192 kB
> > PageExts:         262144 kB (256MB)
> > SlabExts:           9876 kB (9.6MB)
> > PcpuExts:            512 kB (0.5MB)
> >
> > Total overhead is 0.2% of total memory.
> >
> > Benchmarks:
> >
> > Hackbench tests run 100 times:
> > hackbench -s 512 -l 200 -g 15 -f 25 -P
> >        baseline       disabled profiling           enabled profiling
> > avg   0.3543         0.3559 (+0.0016)             0.3566 (+0.0023)
> > stdev 0.0137         0.0188                       0.0077
> >
> >
> > hackbench -l 10000
> >        baseline       disabled profiling           enabled profiling
> > avg   6.4218         6.4306 (+0.0088)             6.5077 (+0.0859)
> > stdev 0.0933         0.0286                       0.0489
> >
> > stress-ng tests:
> > stress-ng --class memory --seq 4 -t 60
> > stress-ng --class cpu --seq 4 -t 60
> > Results posted at: https://evilpiepirate.org/~kent/memalloc_prof_v4_str=
ess-ng/
> >
> > [2] https://lore.kernel.org/all/20240306182440.2003814-1-surenb@google.=
com/
>
> If I enable this, I consistently get percpu allocation failures. I can
> occasionally reproduce it in qemu. I've attached the logs and my config,
> please let me know if there's anything else that could be relevant.

Thanks for the report!
In debug_alloc_profiling.log I see:

[    7.445127] percpu: limit reached, disable warning

That's probably the reason. I'll take a closer look at the cause of
that and how we can fix it.

 In qemu-alloc3.log I see couple of warnings:

[    1.111620] alloc_tag was not set
[    1.111880] WARNING: CPU: 0 PID: 164 at
include/linux/alloc_tag.h:118 kfree (./include/linux/alloc_tag.h:118
(discriminator 1) ./include/linux/alloc_tag.h:161 (discriminator 1)
mm/slub.c:2043 ...

[    1.161710] alloc_tag was not cleared (got tag for fs/squashfs/cache.c:4=
13)
[    1.162289] WARNING: CPU: 0 PID: 195 at
include/linux/alloc_tag.h:109 kmalloc_trace_noprof
(./include/linux/alloc_tag.h:109 (discriminator 1)
./include/linux/alloc_tag.h:149 (discriminator 1) ...

Which means we missed to instrument some allocation. Can you please
check if disabling CONFIG_MEM_ALLOC_PROFILING_DEBUG fixes QEMU case?
In the meantime I'll try to reproduce and fix this.
Thanks,
Suren.



>
> Kind regards,
> Klara Modin

