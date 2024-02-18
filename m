Return-Path: <linux-fsdevel+bounces-11936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C0859404
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 03:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC0C282FDF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 02:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB017F0;
	Sun, 18 Feb 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dy0+oSSo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3F139E
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708222895; cv=none; b=Vu545qUaqGjqNmQjOVqu8CvK7jHsn5pjfuAU0FxIgVlga603YKdzk7z+E8MFOD5+UKAoZJUdnm+1Ty3YXVcacVXhbxYU8loYMOjfC+0933vdy/kUxn2oGIb4DQuvXNgx2SFZW2PBO5Ln9AnO8hvvnAuy4byqO1HbsQ5xiyf5T+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708222895; c=relaxed/simple;
	bh=sGLQWy2gJ22i5/11EUF6i6TeDZNPTR8RdMNYUPKuXtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxRV+0vQ3Hq8+9dU4NpmhRSNRun5THhosbm4Sa4OtUJ7wGtkD8elHpzk205lYJh2ihXfbpO6YCEX0dWLmI6pVC9ngtf3TBcMNJCQ0TxQnuFnwHSxwTwCQ3Ixrg2OrOktU5Uqmq4viQbTlocMUZUYRyMHB0vU3xGdN8KoSBKZ1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dy0+oSSo; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso3227200276.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 18:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708222892; x=1708827692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGwMPlFmMn7i+PsCRsmYPKBrgHwqE0wRHG6PNy5zjw0=;
        b=Dy0+oSSo/rLVLFYRNniJ8/xLna969/++gNkbWpS6mx2DBrdgoFAbwDKo7xwr5EaXEc
         BxdvFTlyenLEwcJGQy5hh7gYtHG65bMckXjyD3oskfkiunAoXiTycAClPHN6Wtun9zVN
         JD+KyRvBXIKOLfDUgllhnEXBged/RY5qcN5ZgvnvDxdQbsTWJEjnfv6/+0yPBPKJ39ld
         N1sfaXsKEwSAdu7Fcsymy3YO8aLDkEiX+qeJI4YFI7QdKWay0Q6eUnpsUmOCeYLoGYX5
         jVQMRCoKm1AlRWnExVzMTyMzwdyBte1Oka+Eh+wI18AhcMi56/IQzNmSZ3A6ClUI8o/+
         c6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708222892; x=1708827692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGwMPlFmMn7i+PsCRsmYPKBrgHwqE0wRHG6PNy5zjw0=;
        b=RDH6Fw8CwdeIi0wa8fIUWcfRvH+ZVRK7NzcG/oZJYoADklRubQF7AW4LB2yNnANVoW
         B2fmTgCJ79Y6+tuEPYOoqWNSUs/DntpDiwd6dcmUbExAKsbJm2Zb0RVz94aPxAQSMfVy
         QMQz0B6OUXvtfEgXI5cx41aDfN37jWxfj/E89jwHZ5u8UTlzn7g+1Y0sDjOn09xk8ubL
         tCuN2hFLR+LphwszQU9bRfjdFKEyGANv+E6jMD/nqM0XdTSPSNCl4edSYebLK+D/7lwo
         Fi7jnRnBrdC4lATc93XziCdmPieiFVSF1aQ8fpAVDzg41oDzTc0xaAIzXk21V08nuQ3h
         6gyg==
X-Forwarded-Encrypted: i=1; AJvYcCWCCEjnj4nj5FkvihfkOd9bAVmTT3/qwX4/GGgpX6wGjcJjJX+k9pJwlIZlFaiVbJwmQONIDtm9ihCSCiT2u45GdGIUw7YMosDPhVYF5g==
X-Gm-Message-State: AOJu0YyNnCMdQ+tjUi5l02sQd3CWvJ3vr3hGPTqJHG8Wohfph71Lh796
	hhWlKyHW9ASHrReG3JOraaXO/wQuTtCPTune2rJhFCRMjCZSFXPttMnh7zYWVlymG1BRJh3McOA
	PQkY7tyhzLUWX28dhBnhRZMXE6vdo330v8j/s
X-Google-Smtp-Source: AGHT+IFbcmWP0wuiiRTf0AlfSBMbSNfrD0N8TNtgVp/GNQHvOsL/OfZQsmBKdpZvPdO7G1/QjsP0VpRVVtpV4P/uhdk=
X-Received: by 2002:a05:6902:268a:b0:dcd:4e54:9420 with SMTP id
 dx10-20020a056902268a00b00dcd4e549420mr9768527ybb.5.1708222891980; Sat, 17
 Feb 2024 18:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-14-surenb@google.com>
 <f92ad1e3-2dde-4db2-9b76-96c6bbc6a208@suse.cz>
In-Reply-To: <f92ad1e3-2dde-4db2-9b76-96c6bbc6a208@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 18 Feb 2024 02:21:18 +0000
Message-ID: <CAJuCfpGemg-aXyiK1fHavdKuW+-9+DM5_4krLAdg+DQh=24Dvg@mail.gmail.com>
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 8:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/12/24 22:38, Suren Baghdasaryan wrote:
> > Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easi=
ly
> > instrument memory allocators. It registers an "alloc_tags" codetag type
> > with /proc/allocinfo interface to output allocation tag information whe=
n
> > the feature is enabled.
> > CONFIG_MEM_ALLOC_PROFILING_DEBUG is provided for debugging the memory
> > allocation profiling instrumentation.
> > Memory allocation profiling can be enabled or disabled at runtime using
> > /proc/sys/vm/mem_profiling sysctl when CONFIG_MEM_ALLOC_PROFILING_DEBUG=
=3Dn.
> > CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT enables memory allocation
> > profiling by default.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst |  16 +++
> >  Documentation/filesystems/proc.rst      |  28 +++++
> >  include/asm-generic/codetag.lds.h       |  14 +++
> >  include/asm-generic/vmlinux.lds.h       |   3 +
> >  include/linux/alloc_tag.h               | 133 ++++++++++++++++++++
> >  include/linux/sched.h                   |  24 ++++
> >  lib/Kconfig.debug                       |  25 ++++
> >  lib/Makefile                            |   2 +
> >  lib/alloc_tag.c                         | 158 ++++++++++++++++++++++++
> >  scripts/module.lds.S                    |   7 ++
> >  10 files changed, 410 insertions(+)
> >  create mode 100644 include/asm-generic/codetag.lds.h
> >  create mode 100644 include/linux/alloc_tag.h
> >  create mode 100644 lib/alloc_tag.c
> >
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/ad=
min-guide/sysctl/vm.rst
> > index c59889de122b..a214719492ea 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -43,6 +43,7 @@ Currently, these files are in /proc/sys/vm:
> >  - legacy_va_layout
> >  - lowmem_reserve_ratio
> >  - max_map_count
> > +- mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=3Dy)
> >  - memory_failure_early_kill
> >  - memory_failure_recovery
> >  - min_free_kbytes
> > @@ -425,6 +426,21 @@ e.g., up to one or two maps per allocation.
> >  The default value is 65530.
> >
> >
> > +mem_profiling
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Enable memory profiling (when CONFIG_MEM_ALLOC_PROFILING=3Dy)
> > +
> > +1: Enable memory profiling.
> > +
> > +0: Disabld memory profiling.
>
>       Disable

Ack.

>
> ...
>
> > +allocinfo
> > +~~~~~~~
> > +
> > +Provides information about memory allocations at all locations in the =
code
> > +base. Each allocation in the code is identified by its source file, li=
ne
> > +number, module and the function calling the allocation. The number of =
bytes
> > +allocated at each location is reported.
>
> See, it even says "number of bytes" :)

Yes, we are changing the output to bytes.

>
> > +
> > +Example output.
> > +
> > +::
> > +
> > +    > cat /proc/allocinfo
> > +
> > +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_page
>
> Is "module" meant in the usual kernel module sense? In that case IIRC is
> more common to annotate things e.g. [xfs] in case it's really a module, a=
nd
> nothing if it's built it, such as slub. Is that "slub" simply derived fro=
m
> "mm/slub.c"? Then it's just redundant?

Sounds good. The new example would look like this:

    > sort -rn /proc/allocinfo
   127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
    56373248     4737 mm/slub.c:2259 func:alloc_slab_page
    14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
    14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
    13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
    11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
     9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
     4206592        4 net/netfilter/nf_conntrack_core.c:2567
func:nf_ct_alloc_hashtable
     4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod]
func:ctagmod_start
     3940352      962 mm/memory.c:4214 func:alloc_anon_folio
     2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node
     ...

Note that [ctagmod] is the only allocation from a module in this example.

>
> > +     6.08MiB     mm/slab_common.c:950 module:slab_common func:_kmalloc=
_order
> > +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:alloc_sla=
b_obj_exts
> > +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:alloc_pag=
es_exact
> > +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtable func:=
__pte_alloc_one
> > +     1.16MiB     fs/xfs/xfs_log_priv.h:700 module:xfs func:xlog_kvmall=
oc
> > +     1.00MiB     mm/swap_cgroup.c:48 module:swap_cgroup func:swap_cgro=
up_prepare
> > +      734KiB     fs/xfs/kmem.c:20 module:xfs func:kmem_alloc
> > +      640KiB     kernel/rcu/tree.c:3184 module:tree func:fill_page_cac=
he_func
> > +      640KiB     drivers/char/virtio_console.c:452 module:virtio_conso=
le func:alloc_buf
> > +      ...
> > +
> > +
> >  meminfo
>
> ...
>
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 0be2d00c3696..78d258ca508f 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -972,6 +972,31 @@ config CODE_TAGGING
> >       bool
> >       select KALLSYMS
> >
> > +config MEM_ALLOC_PROFILING
> > +     bool "Enable memory allocation profiling"
> > +     default n
> > +     depends on PROC_FS
> > +     depends on !DEBUG_FORCE_WEAK_PER_CPU
> > +     select CODE_TAGGING
> > +     help
> > +       Track allocation source code and record total allocation size
> > +       initiated at that code location. The mechanism can be used to t=
rack
> > +       memory leaks with a low performance and memory impact.
> > +
> > +config MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> > +     bool "Enable memory allocation profiling by default"
> > +     default y
>
> I'd go with default n as that I'd select for a general distro.

Well, we have MEM_ALLOC_PROFILING=3Dn by default, so if it was switched
on manually, that is a strong sign that the user wants it enabled IMO.
So, enabling this switch by default seems logical to me. If a distro
wants to have the feature compiled in but disabled by default then
this is perfectly doable, just need to set both options appropriately.
Does my logic make sense?

>
> > +     depends on MEM_ALLOC_PROFILING
> > +
> > +config MEM_ALLOC_PROFILING_DEBUG
> > +     bool "Memory allocation profiler debugging"
> > +     default n
> > +     depends on MEM_ALLOC_PROFILING
> > +     select MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> > +     help
> > +       Adds warnings with helpful error messages for memory allocation
> > +       profiling.
> > +
>

