Return-Path: <linux-fsdevel+bounces-11243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33255852196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD09F1F22A81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A65C4E1C5;
	Mon, 12 Feb 2024 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0UUxwyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499F4DA1F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777618; cv=none; b=PfxcCrDsh22gI7vbaQw0rUcLpH5TF9tUznjdE60ifS+Th6UkesJLLtZpkhiQ7NiBSduo8uzGxoIYV3jBoWAw4Sc8QWtXOhee4/VXrc3JbwvNTUOCewjOeFSc5RGA0eheP4CD9Q1bhJ30Nufq1Dj+qecdmTRJcIXZmHgnTTx27DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777618; c=relaxed/simple;
	bh=bhCwGIkHoaG4LQ6MECcP536cCmSst//pelqxPajFtqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLwqO/zBpirwYkg/skAzMzR7KIafPOjKQZZTxIaQEsEx2Ljj2kCrjyxrRzY0spJDUIbqCf1+NfZD+saS0N3Yk7d4VCf+EqfdDrwgIMndcIJlvGQbjLCuDZmlK8kDBrApkZOAK3SCIBlPoamPYx6TtbK2rIPd/enE0RpOTjvHQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q0UUxwyg; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2dfc98664so1114366a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 14:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707777614; x=1708382414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hczO4cJiUHC8ASa5scEplagLmB2u+1lBcHrJWJ9tWV0=;
        b=Q0UUxwygyirdnY3xsCU1CdIvsIjoIPUKuHsCOQxjjMuMx6T2sNFFsy3YZnQSIisoCn
         IJy/ijqDeQSJwyTP59Nizn4/nBdfzmnsfsRfDXDGU2PHC3i9FAtJ1K8Y46dDTApFtB6e
         ptP4hH/G5Eee0aeVf9hsOzHIAdvfjFjjP7iS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777614; x=1708382414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hczO4cJiUHC8ASa5scEplagLmB2u+1lBcHrJWJ9tWV0=;
        b=sjmLhHG43MPT9C4wQA8AkdeX80Kx9voC6v3VO6Gba3x5+lCOdqYfI37NkSH438zdSE
         FY/Idvmu3LyiBvZQXu30VdE756bkM3bOTbDJub+yah49qpZG2MQsviH6JOEPvM7mh557
         Bk1X0bYcyMbGIj1BP2kAm4E5QMKtOvyvJy+GtDSKh00d06x/ONuc+oXBZgWFgr1+PpSU
         JsWOgD0fVdV8Bb4s/SGytDZlBnn+asHYq1rkTC8m1xFg2RcamH+HpYQhHPtYpL12+vzT
         o53VUKyop9Sdr+R+PheM8vkarfXO3UTLqviUBHX/MkKyqxYbkXxRmwNHNs9vCuOCRvz9
         4K7g==
X-Gm-Message-State: AOJu0YzaI501uvOa8eEAE7Z6brGVqQwP9xkqWXC6N/2Z1e994Wwj8xza
	Rnc+PTmjQEZWECb5IZ3yTD3U1uNM9UJP7XP6BSNYkEu5//Ua01hrCvL1dFrl0A==
X-Google-Smtp-Source: AGHT+IG9KJK0AjmD3ofHI/IoGzZorJQkMHxWZCTQYWQ+oeIbR/dIChUQH09cl8uv/WKmTr+ga9e2Xw==
X-Received: by 2002:a05:6358:e4a1:b0:17a:e9fd:fe23 with SMTP id by33-20020a056358e4a100b0017ae9fdfe23mr2523168rwb.3.1707777614393;
        Mon, 12 Feb 2024 14:40:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWB4m332uQ2jpTqeqcNX/ypOsN2XNU8hzW9FBETzjY4yeTtfk8qCXoSG1dIKUhLtSGKK+EkDJXigJEP9jqSQuXFNmpZRVo4DgaJDTmm/C6TE9rTj6mm5/asNTRxrhCpan0AsgrQmW8EYyf+FEjD2sW9fMRcNZMSzbXyKDz9ihShVunQiEAzuTJmeSggfATl2XMpaTEXw7yQGo/BjzH0P9IU4YDSm5z9Jxnwyt79ZBMR5Kp5mzP1J+CgDMf3sJ7ekymBgxOeUISJSisqO6EX3l5+9HAxdec2IqIOr1iwwX9Ntz7MrpMc6s7oWadC6pUzpH21+ekYNc46nRb6aUhQykvl05hptyHf7CA+3jkkfvN34U98FPdFXQFoo6kyuvyCj1uTrHbhYS7PbemFDt6ibA2sTtcvBQcOTgw3Gsm1IEaHyEDcPDHVM2wVidy4CpWCHGNUeESROATmfmOQYu2NLLW2mLb2skTsLbMocicLkT937m9kCv1PtmFqZUPfK7NnZ21IAeN/9YVzLIJ7Gg9txBflJDy1zA7ybpJfb1ovtaoyaroMkMj0bf+yrfg7P7dj+mRpy3dvmrFVC7BsPAK8QFpbsGTkvkk7Jugv16vfgpKY2w/CDE7kHU/rOVPsPg0JDdZnjU+1/XQWECTPEhQ+/wRJEfn+Ct+ikC7vb9NeLwrxGfVnO0p27OSnsTF2IUbywB4Y8Afae+gDiAK7Jzuf6pdrTP9pShi0Xiwa7dYe/877s10lA11N2g==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y29-20020aa793dd000000b006dd6bb57a2asm6025136pff.114.2024.02.12.14.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:40:12 -0800 (PST)
Date: Mon, 12 Feb 2024 14:40:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
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
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <202402121433.5CC66F34B@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-14-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:59PM -0800, Suren Baghdasaryan wrote:
> Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easily
> instrument memory allocators. It registers an "alloc_tags" codetag type
> with /proc/allocinfo interface to output allocation tag information when

Please don't add anything new to the top-level /proc directory. This
should likely live in /sys.

> the feature is enabled.
> CONFIG_MEM_ALLOC_PROFILING_DEBUG is provided for debugging the memory
> allocation profiling instrumentation.
> Memory allocation profiling can be enabled or disabled at runtime using
> /proc/sys/vm/mem_profiling sysctl when CONFIG_MEM_ALLOC_PROFILING_DEBUG=n.
> CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT enables memory allocation
> profiling by default.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  Documentation/admin-guide/sysctl/vm.rst |  16 +++
>  Documentation/filesystems/proc.rst      |  28 +++++
>  include/asm-generic/codetag.lds.h       |  14 +++
>  include/asm-generic/vmlinux.lds.h       |   3 +
>  include/linux/alloc_tag.h               | 133 ++++++++++++++++++++
>  include/linux/sched.h                   |  24 ++++
>  lib/Kconfig.debug                       |  25 ++++
>  lib/Makefile                            |   2 +
>  lib/alloc_tag.c                         | 158 ++++++++++++++++++++++++
>  scripts/module.lds.S                    |   7 ++
>  10 files changed, 410 insertions(+)
>  create mode 100644 include/asm-generic/codetag.lds.h
>  create mode 100644 include/linux/alloc_tag.h
>  create mode 100644 lib/alloc_tag.c
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index c59889de122b..a214719492ea 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -43,6 +43,7 @@ Currently, these files are in /proc/sys/vm:
>  - legacy_va_layout
>  - lowmem_reserve_ratio
>  - max_map_count
> +- mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=y)
>  - memory_failure_early_kill
>  - memory_failure_recovery
>  - min_free_kbytes
> @@ -425,6 +426,21 @@ e.g., up to one or two maps per allocation.
>  The default value is 65530.
>  
>  
> +mem_profiling
> +==============
> +
> +Enable memory profiling (when CONFIG_MEM_ALLOC_PROFILING=y)
> +
> +1: Enable memory profiling.
> +
> +0: Disabld memory profiling.
> +
> +Enabling memory profiling introduces a small performance overhead for all
> +memory allocations.
> +
> +The default value depends on CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT.
> +
> +
>  memory_failure_early_kill:
>  ==========================
>  
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 104c6d047d9b..40d6d18308e4 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -688,6 +688,7 @@ files are there, and which are missing.
>   ============ ===============================================================
>   File         Content
>   ============ ===============================================================
> + allocinfo    Memory allocations profiling information
>   apm          Advanced power management info
>   bootconfig   Kernel command line obtained from boot config,
>   	      and, if there were kernel parameters from the
> @@ -953,6 +954,33 @@ also be allocatable although a lot of filesystem metadata may have to be
>  reclaimed to achieve this.
>  
>  
> +allocinfo
> +~~~~~~~
> +
> +Provides information about memory allocations at all locations in the code
> +base. Each allocation in the code is identified by its source file, line
> +number, module and the function calling the allocation. The number of bytes
> +allocated at each location is reported.
> +
> +Example output.
> +
> +::
> +
> +    > cat /proc/allocinfo
> +
> +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_page
> +     6.08MiB     mm/slab_common.c:950 module:slab_common func:_kmalloc_order
> +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:alloc_slab_obj_exts
> +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:alloc_pages_exact
> +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtable func:__pte_alloc_one
> +     1.16MiB     fs/xfs/xfs_log_priv.h:700 module:xfs func:xlog_kvmalloc
> +     1.00MiB     mm/swap_cgroup.c:48 module:swap_cgroup func:swap_cgroup_prepare
> +      734KiB     fs/xfs/kmem.c:20 module:xfs func:kmem_alloc
> +      640KiB     kernel/rcu/tree.c:3184 module:tree func:fill_page_cache_func
> +      640KiB     drivers/char/virtio_console.c:452 module:virtio_console func:alloc_buf
> +      ...
> +
> +
>  meminfo
>  ~~~~~~~
>  
> diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
> new file mode 100644
> index 000000000000..64f536b80380
> --- /dev/null
> +++ b/include/asm-generic/codetag.lds.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_GENERIC_CODETAG_LDS_H
> +#define __ASM_GENERIC_CODETAG_LDS_H
> +
> +#define SECTION_WITH_BOUNDARIES(_name)	\
> +	. = ALIGN(8);			\
> +	__start_##_name = .;		\
> +	KEEP(*(_name))			\
> +	__stop_##_name = .;
> +
> +#define CODETAG_SECTIONS()		\
> +	SECTION_WITH_BOUNDARIES(alloc_tags)
> +
> +#endif /* __ASM_GENERIC_CODETAG_LDS_H */
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5dd3a61d673d..c9997dc50c50 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -50,6 +50,8 @@
>   *               [__nosave_begin, __nosave_end] for the nosave data
>   */
>  
> +#include <asm-generic/codetag.lds.h>
> +
>  #ifndef LOAD_OFFSET
>  #define LOAD_OFFSET 0
>  #endif
> @@ -366,6 +368,7 @@
>  	. = ALIGN(8);							\
>  	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
>  	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
> +	CODETAG_SECTIONS()						\
>  	LIKELY_PROFILE()		       				\
>  	BRANCH_PROFILE()						\
>  	TRACE_PRINTKS()							\
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> new file mode 100644
> index 000000000000..cf55a149fa84
> --- /dev/null
> +++ b/include/linux/alloc_tag.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * allocation tagging
> + */
> +#ifndef _LINUX_ALLOC_TAG_H
> +#define _LINUX_ALLOC_TAG_H
> +
> +#include <linux/bug.h>
> +#include <linux/codetag.h>
> +#include <linux/container_of.h>
> +#include <linux/preempt.h>
> +#include <asm/percpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/static_key.h>
> +
> +struct alloc_tag_counters {
> +	u64 bytes;
> +	u64 calls;
> +};
> +
> +/*
> + * An instance of this structure is created in a special ELF section at every
> + * allocation callsite. At runtime, the special section is treated as
> + * an array of these. Embedded codetag utilizes codetag framework.
> + */
> +struct alloc_tag {
> +	struct codetag			ct;
> +	struct alloc_tag_counters __percpu	*counters;
> +} __aligned(8);
> +
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +
> +static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
> +{
> +	return container_of(ct, struct alloc_tag, ct);
> +}
> +
> +#ifdef ARCH_NEEDS_WEAK_PER_CPU
> +/*
> + * When percpu variables are required to be defined as weak, static percpu
> + * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
> + */
> +#error "Memory allocation profiling is incompatible with ARCH_NEEDS_WEAK_PER_CPU"

Is this enforced via Kconfig as well? (Looks like only alpha and s390?)

> +#endif
> +
> +#define DEFINE_ALLOC_TAG(_alloc_tag, _old)					\
> +	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
> +	static struct alloc_tag _alloc_tag __used __aligned(8)			\
> +	__section("alloc_tags") = {						\
> +		.ct = CODE_TAG_INIT,						\
> +		.counters = &_alloc_tag_cntr };					\
> +	struct alloc_tag * __maybe_unused _old = alloc_tag_save(&_alloc_tag)
> +
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
> +			mem_alloc_profiling_key);
> +
> +static inline bool mem_alloc_profiling_enabled(void)
> +{
> +	return static_branch_maybe(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
> +				   &mem_alloc_profiling_key);
> +}
> +
> +static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
> +{
> +	struct alloc_tag_counters v = { 0, 0 };
> +	struct alloc_tag_counters *counter;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		counter = per_cpu_ptr(tag->counters, cpu);
> +		v.bytes += counter->bytes;
> +		v.calls += counter->calls;
> +	}
> +
> +	return v;
> +}
> +
> +static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> +{
> +	struct alloc_tag *tag;
> +
> +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +	WARN_ONCE(ref && !ref->ct, "alloc_tag was not set\n");
> +#endif
> +	if (!ref || !ref->ct)
> +		return;
> +
> +	tag = ct_to_alloc_tag(ref->ct);
> +
> +	this_cpu_sub(tag->counters->bytes, bytes);
> +	this_cpu_dec(tag->counters->calls);
> +
> +	ref->ct = NULL;
> +}
> +
> +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> +{
> +	__alloc_tag_sub(ref, bytes);
> +}
> +
> +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_t bytes)
> +{
> +	__alloc_tag_sub(ref, bytes);
> +}
> +
> +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
> +{
> +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +	WARN_ONCE(ref && ref->ct,
> +		  "alloc_tag was not cleared (got tag for %s:%u)\n",\
> +		  ref->ct->filename, ref->ct->lineno);
> +
> +	WARN_ONCE(!tag, "current->alloc_tag not set");
> +#endif
> +	if (!ref || !tag)
> +		return;
> +
> +	ref->ct = &tag->ct;
> +	this_cpu_add(tag->counters->bytes, bytes);
> +	this_cpu_inc(tag->counters->calls);
> +}
> +
> +#else
> +
> +#define DEFINE_ALLOC_TAG(_alloc_tag, _old)
> +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
> +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_t bytes) {}
> +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
> +				 size_t bytes) {}
> +
> +#endif
> +
> +#endif /* _LINUX_ALLOC_TAG_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ffe8f618ab86..da68a10517c8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -770,6 +770,10 @@ struct task_struct {
>  	unsigned int			flags;
>  	unsigned int			ptrace;
>  
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +	struct alloc_tag		*alloc_tag;
> +#endif

Normally scheduling is very sensitive to having anything early in
task_struct. I would suggest moving this the CONFIG_SCHED_CORE ifdef
area.

> +
>  #ifdef CONFIG_SMP
>  	int				on_cpu;
>  	struct __call_single_node	wake_entry;
> @@ -810,6 +814,7 @@ struct task_struct {
>  	struct task_group		*sched_task_group;
>  #endif
>  
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  	/*
>  	 * Clamp values requested for a scheduling entity.
> @@ -2183,4 +2188,23 @@ static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
>  
>  extern void sched_set_stop_task(int cpu, struct task_struct *stop);
>  
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
> +{
> +	swap(current->alloc_tag, tag);
> +	return tag;
> +}
> +
> +static inline void alloc_tag_restore(struct alloc_tag *tag, struct alloc_tag *old)
> +{
> +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +	WARN(current->alloc_tag != tag, "current->alloc_tag was changed:\n");
> +#endif
> +	current->alloc_tag = old;
> +}
> +#else
> +static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag) { return NULL; }
> +#define alloc_tag_restore(_tag, _old)
> +#endif
> +
>  #endif
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 0be2d00c3696..78d258ca508f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -972,6 +972,31 @@ config CODE_TAGGING
>  	bool
>  	select KALLSYMS
>  
> +config MEM_ALLOC_PROFILING
> +	bool "Enable memory allocation profiling"
> +	default n
> +	depends on PROC_FS
> +	depends on !DEBUG_FORCE_WEAK_PER_CPU
> +	select CODE_TAGGING
> +	help
> +	  Track allocation source code and record total allocation size
> +	  initiated at that code location. The mechanism can be used to track
> +	  memory leaks with a low performance and memory impact.
> +
> +config MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> +	bool "Enable memory allocation profiling by default"
> +	default y
> +	depends on MEM_ALLOC_PROFILING
> +
> +config MEM_ALLOC_PROFILING_DEBUG
> +	bool "Memory allocation profiler debugging"
> +	default n
> +	depends on MEM_ALLOC_PROFILING
> +	select MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> +	help
> +	  Adds warnings with helpful error messages for memory allocation
> +	  profiling.
> +
>  source "lib/Kconfig.kasan"
>  source "lib/Kconfig.kfence"
>  source "lib/Kconfig.kmsan"
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b48b22fdfac..859112f09bf5 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -236,6 +236,8 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) += \
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>  
>  obj-$(CONFIG_CODE_TAGGING) += codetag.o
> +obj-$(CONFIG_MEM_ALLOC_PROFILING) += alloc_tag.o
> +
>  lib-$(CONFIG_GENERIC_BUG) += bug.o
>  
>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> new file mode 100644
> index 000000000000..4fc031f9cefd
> --- /dev/null
> +++ b/lib/alloc_tag.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/alloc_tag.h>
> +#include <linux/fs.h>
> +#include <linux/gfp.h>
> +#include <linux/module.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_buf.h>
> +#include <linux/seq_file.h>
> +
> +static struct codetag_type *alloc_tag_cttype;
> +
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
> +			mem_alloc_profiling_key);
> +
> +static void *allocinfo_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct codetag_iterator *iter;
> +	struct codetag *ct;
> +	loff_t node = *pos;
> +
> +	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
> +	m->private = iter;
> +	if (!iter)
> +		return NULL;
> +
> +	codetag_lock_module_list(alloc_tag_cttype, true);
> +	*iter = codetag_get_ct_iter(alloc_tag_cttype);
> +	while ((ct = codetag_next_ct(iter)) != NULL && node)
> +		node--;
> +
> +	return ct ? iter : NULL;
> +}
> +
> +static void *allocinfo_next(struct seq_file *m, void *arg, loff_t *pos)
> +{
> +	struct codetag_iterator *iter = (struct codetag_iterator *)arg;
> +	struct codetag *ct = codetag_next_ct(iter);
> +
> +	(*pos)++;
> +	if (!ct)
> +		return NULL;
> +
> +	return iter;
> +}
> +
> +static void allocinfo_stop(struct seq_file *m, void *arg)
> +{
> +	struct codetag_iterator *iter = (struct codetag_iterator *)m->private;
> +
> +	if (iter) {
> +		codetag_lock_module_list(alloc_tag_cttype, false);
> +		kfree(iter);
> +	}
> +}
> +
> +static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
> +{
> +	struct alloc_tag *tag = ct_to_alloc_tag(ct);
> +	struct alloc_tag_counters counter = alloc_tag_read(tag);
> +	s64 bytes = counter.bytes;
> +	char val[10], *p = val;
> +
> +	if (bytes < 0) {
> +		*p++ = '-';
> +		bytes = -bytes;
> +	}
> +
> +	string_get_size(bytes, 1,
> +			STRING_SIZE_BASE2|STRING_SIZE_NOSPACE,
> +			p, val + ARRAY_SIZE(val) - p);
> +
> +	seq_buf_printf(out, "%8s %8llu ", val, counter.calls);
> +	codetag_to_text(out, ct);
> +	seq_buf_putc(out, ' ');
> +	seq_buf_putc(out, '\n');
> +}

/me does happy seq_buf dance!

> +
> +static int allocinfo_show(struct seq_file *m, void *arg)
> +{
> +	struct codetag_iterator *iter = (struct codetag_iterator *)arg;
> +	char *bufp;
> +	size_t n = seq_get_buf(m, &bufp);
> +	struct seq_buf buf;
> +
> +	seq_buf_init(&buf, bufp, n);
> +	alloc_tag_to_text(&buf, iter->ct);
> +	seq_commit(m, seq_buf_used(&buf));
> +	return 0;
> +}
> +
> +static const struct seq_operations allocinfo_seq_op = {
> +	.start	= allocinfo_start,
> +	.next	= allocinfo_next,
> +	.stop	= allocinfo_stop,
> +	.show	= allocinfo_show,
> +};
> +
> +static void __init procfs_init(void)
> +{
> +	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
> +}

As mentioned, this really should be in /sys somewhere.

> +
> +static bool alloc_tag_module_unload(struct codetag_type *cttype,
> +				    struct codetag_module *cmod)
> +{
> +	struct codetag_iterator iter = codetag_get_ct_iter(cttype);
> +	struct alloc_tag_counters counter;
> +	bool module_unused = true;
> +	struct alloc_tag *tag;
> +	struct codetag *ct;
> +
> +	for (ct = codetag_next_ct(&iter); ct; ct = codetag_next_ct(&iter)) {
> +		if (iter.cmod != cmod)
> +			continue;
> +
> +		tag = ct_to_alloc_tag(ct);
> +		counter = alloc_tag_read(tag);
> +
> +		if (WARN(counter.bytes, "%s:%u module %s func:%s has %llu allocated at module unload",
> +			  ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes))
> +			module_unused = false;
> +	}
> +
> +	return module_unused;
> +}
> +
> +static struct ctl_table memory_allocation_profiling_sysctls[] = {
> +	{
> +		.procname	= "mem_profiling",
> +		.data		= &mem_alloc_profiling_key,
> +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +		.mode		= 0444,
> +#else
> +		.mode		= 0644,
> +#endif
> +		.proc_handler	= proc_do_static_key,
> +	},
> +	{ }
> +};
> +
> +static int __init alloc_tag_init(void)
> +{
> +	const struct codetag_type_desc desc = {
> +		.section	= "alloc_tags",
> +		.tag_size	= sizeof(struct alloc_tag),
> +		.module_unload	= alloc_tag_module_unload,
> +	};
> +
> +	alloc_tag_cttype = codetag_register_type(&desc);
> +	if (IS_ERR_OR_NULL(alloc_tag_cttype))
> +		return PTR_ERR(alloc_tag_cttype);
> +
> +	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
> +	procfs_init();
> +
> +	return 0;
> +}
> +module_init(alloc_tag_init);
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index bf5bcf2836d8..45c67a0994f3 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -9,6 +9,8 @@
>  #define DISCARD_EH_FRAME	*(.eh_frame)
>  #endif
>  
> +#include <asm-generic/codetag.lds.h>
> +
>  SECTIONS {
>  	/DISCARD/ : {
>  		*(.discard)
> @@ -47,12 +49,17 @@ SECTIONS {
>  	.data : {
>  		*(.data .data.[0-9a-zA-Z_]*)
>  		*(.data..L*)
> +		CODETAG_SECTIONS()
>  	}
>  
>  	.rodata : {
>  		*(.rodata .rodata.[0-9a-zA-Z_]*)
>  		*(.rodata..L*)
>  	}
> +#else
> +	.data : {
> +		CODETAG_SECTIONS()
> +	}
>  #endif
>  }

Otherwise, looks good.

-- 
Kees Cook

