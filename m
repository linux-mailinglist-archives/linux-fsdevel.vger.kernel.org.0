Return-Path: <linux-fsdevel+bounces-16301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8D989AD25
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C0EB217EB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 21:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1C537E1;
	Sat,  6 Apr 2024 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N4KxHh/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE394D9EC
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712440092; cv=none; b=TR6pRpbblDZye2mVzu+nCrYdYI3CUWHi0xZ/9778/3T3Mqp4Hk/gfgWMZoL2YQyyX265EYgAZ4/HhoazqJS183q9rYV4a5UzR7uy2VuFVm3l8YHLDVF+MS0jvLWsJWeqfvoYgZxn9dROfkMcvf7pxZfMQ7fFYbmFfvTCiqlUGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712440092; c=relaxed/simple;
	bh=F9S24iTwcnGWGKz+ubfXX8T4hECUmmw6+EfiXYVl3+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFReMkEsqtr5jQE7DnRYK5nWzunsz5VY9FDDfAv50ag762wfgjC4x1gfy92mNWTfs25YP0zgHZPAUETUsvTmoQfTHiC0Za5ktF9u8QzMdrbb69sy6OQHyEkaRwGwuXrZHoztac3fnZzKR9NgIcxq2f5CUSAW29YFqlO+ks98ngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N4KxHh/O; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Apr 2024 17:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712440087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zidy/ZuQ9llHF4A0yXUONl+ELs1p92Ps6Z+2FVfH0JQ=;
	b=N4KxHh/O87aO6WD/h/r5q8UlwdJoVcfJbPza8mnrpFRrkCd3NiG6ydYvvYT0bOS4m65xa9
	mNHFONZPqGuMWVm+a+/RpiFQmShel4tR7LMJPQ/+EpclHNUDvS9KApR0qxLP/+bcEWmxrV
	83fUuJvP9Z8rar/KsHD/T/F22UAYjpA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, david@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, David Howells <dhowells@redhat.com>, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 13/37] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <76nf3dl4cqptqv5oh54njnp4rizot7bej32fufjjtreizzcw3w@rkbjbgujk6pk>
References: <6b8149f3-80e6-413c-abcb-1925ecda9d8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b8149f3-80e6-413c-abcb-1925ecda9d8c@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 03:54:45PM +0200, Klara Modin wrote:
> Hi,
> 
> On 2024-03-21 17:36, Suren Baghdasaryan wrote:
> > Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easily
> > instrument memory allocators. It registers an "alloc_tags" codetag type
> > with /proc/allocinfo interface to output allocation tag information when
> > the feature is enabled.
> > CONFIG_MEM_ALLOC_PROFILING_DEBUG is provided for debugging the memory
> > allocation profiling instrumentation.
> > Memory allocation profiling can be enabled or disabled at runtime using
> > /proc/sys/vm/mem_profiling sysctl when CONFIG_MEM_ALLOC_PROFILING_DEBUG=n.
> > CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT enables memory allocation
> > profiling by default.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> With this commit (9e2dcefa791e9d14006b360fba3455510fd3325d in
> next-20240404), randconfig with KCONFIG_SEED=0xE6264236 fails to build
> with the attached error. The following patch fixes the build error for me,
> but I don't know if it's correct.

Looks good - if you sound out an official patch I'll ack it.

> 
> Kind regards,
> Klara Modin
> 
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 100ddf66eb8e..1c765d80298b 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -12,6 +12,7 @@
>  #include <asm/percpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/static_key.h>
> +#include <linux/irqflags.h>
> 
>  struct alloc_tag_counters {
>         u64 bytes;
> 
> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > new file mode 100644
> > index 000000000000..b970ff1c80dc
> > --- /dev/null
> > +++ b/include/linux/alloc_tag.h
> > @@ -0,0 +1,145 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * allocation tagging
> > + */
> > +#ifndef _LINUX_ALLOC_TAG_H
> > +#define _LINUX_ALLOC_TAG_H
> > +
> > +#include <linux/bug.h>
> > +#include <linux/codetag.h>
> > +#include <linux/container_of.h>
> > +#include <linux/preempt.h>
> > +#include <asm/percpu.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/static_key.h>
> > +
> > +struct alloc_tag_counters {
> > +     u64 bytes;
> > +     u64 calls;
> > +};
> > +
> > +/*
> > + * An instance of this structure is created in a special ELF section at every
> > + * allocation callsite. At runtime, the special section is treated as
> > + * an array of these. Embedded codetag utilizes codetag framework.
> > + */
> > +struct alloc_tag {
> > +     struct codetag                  ct;
> > +     struct alloc_tag_counters __percpu      *counters;
> > +} __aligned(8);
> > +
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +
> > +static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
> > +{
> > +     return container_of(ct, struct alloc_tag, ct);
> > +}
> > +
> > +#ifdef ARCH_NEEDS_WEAK_PER_CPU
> > +/*
> > + * When percpu variables are required to be defined as weak, static percpu
> > + * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
> > + */
> > +#error "Memory allocation profiling is incompatible with ARCH_NEEDS_WEAK_PER_CPU"
> > +#endif
> > +
> > +#define DEFINE_ALLOC_TAG(_alloc_tag)                                         \
> > +     static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);      \
> > +     static struct alloc_tag _alloc_tag __used __aligned(8)                  \
> > +     __section("alloc_tags") = {                                             \
> > +             .ct = CODE_TAG_INIT,                                            \
> > +             .counters = &_alloc_tag_cntr };
> > +
> > +DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
> > +                     mem_alloc_profiling_key);
> > +
> > +static inline bool mem_alloc_profiling_enabled(void)
> > +{
> > +     return static_branch_maybe(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
> > +                                &mem_alloc_profiling_key);
> > +}
> > +
> > +static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
> > +{
> > +     struct alloc_tag_counters v = { 0, 0 };
> > +     struct alloc_tag_counters *counter;
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             counter = per_cpu_ptr(tag->counters, cpu);
> > +             v.bytes += counter->bytes;
> > +             v.calls += counter->calls;
> > +     }
> > +
> > +     return v;
> > +}
> > +
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> > +static inline void alloc_tag_add_check(union codetag_ref *ref, struct alloc_tag *tag)
> > +{
> > +     WARN_ONCE(ref && ref->ct,
> > +               "alloc_tag was not cleared (got tag for %s:%u)\n",
> > +               ref->ct->filename, ref->ct->lineno);
> > +
> > +     WARN_ONCE(!tag, "current->alloc_tag not set");
> > +}
> > +
> > +static inline void alloc_tag_sub_check(union codetag_ref *ref)
> > +{
> > +     WARN_ONCE(ref && !ref->ct, "alloc_tag was not set\n");
> > +}
> > +#else
> > +static inline void alloc_tag_add_check(union codetag_ref *ref, struct alloc_tag *tag) {}
> > +static inline void alloc_tag_sub_check(union codetag_ref *ref) {}
> > +#endif
> > +
> > +/* Caller should verify both ref and tag to be valid */
> > +static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
> > +{
> > +     ref->ct = &tag->ct;
> > +     /*
> > +      * We need in increment the call counter every time we have a new
> > +      * allocation or when we split a large allocation into smaller ones.
> > +      * Each new reference for every sub-allocation needs to increment call
> > +      * counter because when we free each part the counter will be decremented.
> > +      */
> > +     this_cpu_inc(tag->counters->calls);
> > +}
> > +
> > +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
> > +{
> > +     alloc_tag_add_check(ref, tag);
> > +     if (!ref || !tag)
> > +             return;
> > +
> > +     __alloc_tag_ref_set(ref, tag);
> > +     this_cpu_add(tag->counters->bytes, bytes);
> > +}
> > +
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > +{
> > +     struct alloc_tag *tag;
> > +
> > +     alloc_tag_sub_check(ref);
> > +     if (!ref || !ref->ct)
> > +             return;
> > +
> > +     tag = ct_to_alloc_tag(ref->ct);
> > +
> > +     this_cpu_sub(tag->counters->bytes, bytes);
> > +     this_cpu_dec(tag->counters->calls);
> > +
> > +     ref->ct = NULL;
> > +}
> > +
> > +#else /* CONFIG_MEM_ALLOC_PROFILING */
> > +
> > +#define DEFINE_ALLOC_TAG(_alloc_tag)
> > +static inline bool mem_alloc_profiling_enabled(void) { return false; }
> > +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
> > +                              size_t bytes) {}
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
> > +
> > +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> > +
> > +#endif /* _LINUX_ALLOC_TAG_H */

> In file included from ./arch/x86/include/asm/percpu.h:615,
>                  from ./arch/x86/include/asm/preempt.h:6,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/alloc_tag.h:11,
>                  from lib/alloc_tag.c:2:
> ./include/linux/alloc_tag.h: In function ‘__alloc_tag_ref_set’:
> ./include/asm-generic/percpu.h:155:9: error: implicit declaration of function ‘raw_local_irq_save’ [-Werror=implicit-function-declaration]
>   155 |         raw_local_irq_save(__flags);                                    \
>       |         ^~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:410:41: note: in expansion of macro ‘this_cpu_generic_to_op’
>   410 | #define this_cpu_add_8(pcp, val)        this_cpu_generic_to_op(pcp, val, +=)
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:368:25: note: in expansion of macro ‘this_cpu_add_8’
>   368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
>       |                         ^~~~
> ./include/linux/percpu-defs.h:491:41: note: in expansion of macro ‘__pcpu_size_call’
>   491 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
>       |                                         ^~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:501:41: note: in expansion of macro ‘this_cpu_add’
>   501 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
>       |                                         ^~~~~~~~~~~~
> ./include/linux/alloc_tag.h:106:9: note: in expansion of macro ‘this_cpu_inc’
>   106 |         this_cpu_inc(tag->counters->calls);
>       |         ^~~~~~~~~~~~
> ./include/asm-generic/percpu.h:157:9: error: implicit declaration of function ‘raw_local_irq_restore’ [-Werror=implicit-function-declaration]
>   157 |         raw_local_irq_restore(__flags);                                 \
>       |         ^~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/percpu.h:410:41: note: in expansion of macro ‘this_cpu_generic_to_op’
>   410 | #define this_cpu_add_8(pcp, val)        this_cpu_generic_to_op(pcp, val, +=)
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:368:25: note: in expansion of macro ‘this_cpu_add_8’
>   368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
>       |                         ^~~~
> ./include/linux/percpu-defs.h:491:41: note: in expansion of macro ‘__pcpu_size_call’
>   491 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
>       |                                         ^~~~~~~~~~~~~~~~
> ./include/linux/percpu-defs.h:501:41: note: in expansion of macro ‘this_cpu_add’
>   501 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
>       |                                         ^~~~~~~~~~~~
> ./include/linux/alloc_tag.h:106:9: note: in expansion of macro ‘this_cpu_inc’
>   106 |         this_cpu_inc(tag->counters->calls);
>       |         ^~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:244: lib/alloc_tag.o] Error 1
> make[2]: *** [scripts/Makefile.build:485: lib] Error 2
> make[1]: *** [/home/klara/git/linux/Makefile:1919: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2


> # bad: [2b3d5988ae2cb5cd945ddbc653f0a71706231fdd] Add linux-next specific files for 20240404
> git bisect start 'next/master'
> # status: waiting for good commit(s), bad commit known
> # good: [39cd87c4eb2b893354f3b850f916353f2658ae6f] Linux 6.9-rc2
> git bisect good 39cd87c4eb2b893354f3b850f916353f2658ae6f
> # bad: [cc7b62666779616ff52d389a344ffe2c041e36e2] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> git bisect bad cc7b62666779616ff52d389a344ffe2c041e36e2
> # bad: [d6b7dd0f8d84f9fdf2af65fceb608e3206276e81] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
> git bisect bad d6b7dd0f8d84f9fdf2af65fceb608e3206276e81
> # bad: [ad6a31687713a8f12165e730e0eb6e0de3beae56] Merge branch 'mm-everything' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad ad6a31687713a8f12165e730e0eb6e0de3beae56
> # good: [59266d9886adb5c9e240129ccc606727fd3a881d] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
> git bisect good 59266d9886adb5c9e240129ccc606727fd3a881d
> # bad: [085e5fe7388cf36ab5c02d91022229e5fade5b30] mm: merge folio_is_secretmem() and folio_fast_pin_allowed() into gup_fast_folio_allowed()
> git bisect bad 085e5fe7388cf36ab5c02d91022229e5fade5b30
> # bad: [f6a61baa9139d174170acdae8667b3246ce44db6] lib: add memory allocations report in show_mem()
> git bisect bad f6a61baa9139d174170acdae8667b3246ce44db6
> # good: [302519d9e80a7fbf2cf8d0b8961d491af648759f] asm-generic/io.h: kill vmalloc.h dependency
> git bisect good 302519d9e80a7fbf2cf8d0b8961d491af648759f
> # bad: [e6942003e682e3883847459c3d07e23c796a2782] mm: create new codetag references during page splitting
> git bisect bad e6942003e682e3883847459c3d07e23c796a2782
> # good: [ed97151dec736c1541bfac2b801108d54ebee5bc] lib: code tagging module support
> git bisect good ed97151dec736c1541bfac2b801108d54ebee5bc
> # bad: [95767bde5020afefef4205b60e71f4ebf96da74e] lib: introduce early boot parameter to avoid page_ext memory overhead
> git bisect bad 95767bde5020afefef4205b60e71f4ebf96da74e
> # bad: [9e2dcefa791e9d14006b360fba3455510fd3325d] lib: add allocation tagging support for memory allocation profiling
> git bisect bad 9e2dcefa791e9d14006b360fba3455510fd3325d
> # good: [0eccd42fbf9d7c4ae0cbec48cce637da89813c2c] lib: prevent module unloading if memory is not freed
> git bisect good 0eccd42fbf9d7c4ae0cbec48cce637da89813c2c
> # first bad commit: [9e2dcefa791e9d14006b360fba3455510fd3325d] lib: add allocation tagging support for memory allocation profiling


