Return-Path: <linux-fsdevel+bounces-15221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2478488A9CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E976A340020
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E416AFA8;
	Mon, 25 Mar 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+Ip7CtY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650F71B39
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378580; cv=none; b=U99EZYqpNG02nVUCAAa1JqARKKlOxZaT0LjRGsBOfCi6IHbZrgehABFnhD2V0cV8RpFVMb8KsD+h38Yuqutj1m2YTRd/FnmqWJDRdxXQpHIQkUJskPS9pYGmlqiYZfL9k8kUuUfmpwvlBm3yL7JKTRsLQZD1cX4WCq8Dq9YU7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378580; c=relaxed/simple;
	bh=zlhtrFbR8EQbtNaFkNYLSOd1+W7L797x6flRUbWx2vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9VHD72xKBiHVidPLsZz0AGbahekx8A3OjwGJ363jA72xM/t2VyA3qK5L0VmtdYxOupuhOJaJVkQFMJrIB4E0f0oqYOFvb+Y4qdiB5NJiJE6UzzePMzac5DehUso829Ouxu9hJiST5YS+ucVIohu9XQh/srOOe762D31GQEa1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+Ip7CtY; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so4374521276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711378575; x=1711983375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oPNUv7RDckMdIxGDWAZluCw/6HzmRVcSpvbmH1a/VM=;
        b=y+Ip7CtYAXrhhM52VH9oGLuDCZ+t+EEb3ZdPBum0AjNr47JoZygoa8s1g6i3XOY+Jc
         swzmZiO2uJrNcLlVNuF1uIKG61exE3omLdTqlVKvqIkUM4AZwth3EkSpW9IFVXJzbc8G
         IG/OyjWJKJFnQN6L+/kdVEhfbKGdFk9pAg83BDdyPfHSTqXRgbDvKbV6CC8A+/kDJRDU
         FxaMRH9h8p0xFj+GIerGSa9Qknw9/tWLeiHdEOrWtsvjCbDPsgtUopQXq1bpzQKtqGIQ
         a6kyBiZMDRw7oO9vsi7A1ZOIHjRmz7wrJxYrCtPhLPY4PymHXZ0QzPqhjuBOwsbHvRqJ
         nVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378575; x=1711983375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oPNUv7RDckMdIxGDWAZluCw/6HzmRVcSpvbmH1a/VM=;
        b=YNQr66cikLchaqvco2KpumAPdYDKqCaCP52ckzFZd5logauNA4aGLehYrV+THyZbTt
         ERtsH5LExb0BSQvdZPA1cxDfuvb60hT36xuBAewf/hoYmHgHS46/nGsU/9M/YGigwbu3
         SzudOiaTG51Qic9hi+sb0TlO0KHygx0uI1BJT5D9q8jK83/eJ/kg+VXKaY07IGRcWeaG
         KkOyle0PLjHTp5FJ5pekYXJC91OemZfAT3qqiN8Z9fo5Xb38g/XSldBLfh0VRnF0bidI
         pG7T7Pr/LdCVuxRyIfxNuOky+Yyo0LpD3U3WrIlp46TVk+7JRjjTJfxjEwOXmG/a6F8w
         7UEA==
X-Forwarded-Encrypted: i=1; AJvYcCUVNb5vb2Zd3vnX2IVUyxG6Bm14MucksLpBFa0jgtTeNhoXzrfpZSFHZ0kGAOt1HgQdv4q/TkUGEFNt6JvWr8xYQcRZsiBLfFcDfW3LHA==
X-Gm-Message-State: AOJu0YwCb3m9Pqx+VCTET4UN8Ft43v7yahiCS+WUn1NzhG7i3vsKQBy7
	p2ZSPvdwzTl/2/z1bMjRD85FTDeRwwUBZ0MRzW7JopNQDu0uOC/f+gObKtyC/g2nR95DPkaGU4j
	Yu5RKhPiwGgVCC44uXayZGeMoWcasHPbtBrlT
X-Google-Smtp-Source: AGHT+IGIKrOQzSK8Em8yGWkhUSlLAmHMOYI/HYD+caTfVYtTU6jeSUpW8129S0tsPQ8tfDSVOyUVIX9D6N6ysA9pTFo=
X-Received: by 2002:a25:4a07:0:b0:dc7:4ba0:9d24 with SMTP id
 x7-20020a254a07000000b00dc74ba09d24mr3936064yba.59.1711378574543; Mon, 25 Mar
 2024 07:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-31-surenb@google.com> <20240323180506.195396-1-sj@kernel.org>
In-Reply-To: <20240323180506.195396-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Mar 2024 14:56:01 +0000
Message-ID: <CAJuCfpFnGmt8Q7ZT2Z+gvz=DkRzionXFZ0i5Y1B=UKF6LLqxXA@mail.gmail.com>
Subject: Re: [PATCH v6 30/37] mm: vmalloc: Enable memory allocation profiling
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz, 
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
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 6:05=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Suren and Kent,
>
> On Thu, 21 Mar 2024 09:36:52 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > This wrapps all external vmalloc allocation functions with the
> > alloc_hooks() wrapper, and switches internal allocations to _noprof
> > variants where appropriate, for the new memory allocation profiling
> > feature.
>
> I just noticed latest mm-unstable fails running kunit on my machine as be=
low.
> 'git-bisect' says this is the first commit of the failure.
>
>     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
>     [10:59:53] Configuring KUnit Kernel ...
>     [10:59:53] Building KUnit Kernel ...
>     Populating config with:
>     $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
>     Building with:
>     $ make ARCH=3Dum O=3D../kunit.out/ --jobs=3D36
>     ERROR:root:/usr/bin/ld: arch/um/os-Linux/main.o: in function `__wrap_=
malloc':
>     main.c:(.text+0x10b): undefined reference to `vmalloc'
>     collect2: error: ld returned 1 exit status
>
> Haven't looked into the code yet, but reporting first.  May I ask your id=
ea?

Hi SeongJae,
Looks like we missed adding "#include <linux/vmalloc.h>" inside
arch/um/os-Linux/main.c in this patch:
https://lore.kernel.org/all/20240321163705.3067592-2-surenb@google.com/.
I'll be posing fixes for all 0-day issues found over the weekend and
will include a fix for this. In the meantime, to work around it you
can add that include yourself. Please let me know if the issue still
persists after doing that.
Thanks,
Suren.





>
>
> Thanks,
> SJ
>
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  drivers/staging/media/atomisp/pci/hmm/hmm.c |  2 +-
> >  include/linux/vmalloc.h                     | 60 ++++++++++----
> >  kernel/kallsyms_selftest.c                  |  2 +-
> >  mm/nommu.c                                  | 64 +++++++--------
> >  mm/util.c                                   | 24 +++---
> >  mm/vmalloc.c                                | 88 ++++++++++-----------
> >  6 files changed, 135 insertions(+), 105 deletions(-)
> >
> > diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/stag=
ing/media/atomisp/pci/hmm/hmm.c
> > index bb12644fd033..3e2899ad8517 100644
> > --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> > @@ -205,7 +205,7 @@ static ia_css_ptr __hmm_alloc(size_t bytes, enum hm=
m_bo_type type,
> >       }
> >
> >       dev_dbg(atomisp_dev, "pages: 0x%08x (%zu bytes), type: %d, vmallo=
c %p\n",
> > -             bo->start, bytes, type, vmalloc);
> > +             bo->start, bytes, type, vmalloc_noprof);
> >
> >       return bo->start;
> >
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 98ea90e90439..e4a631ec430b 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -2,6 +2,8 @@
> >  #ifndef _LINUX_VMALLOC_H
> >  #define _LINUX_VMALLOC_H
> >
> > +#include <linux/alloc_tag.h>
> > +#include <linux/sched.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/init.h>
> >  #include <linux/list.h>
> > @@ -138,26 +140,54 @@ extern unsigned long vmalloc_nr_pages(void);
> >  static inline unsigned long vmalloc_nr_pages(void) { return 0; }
> >  #endif
> >
> > -extern void *vmalloc(unsigned long size) __alloc_size(1);
> > -extern void *vzalloc(unsigned long size) __alloc_size(1);
> > -extern void *vmalloc_user(unsigned long size) __alloc_size(1);
> > -extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1=
);
> > -extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1=
);
> > -extern void *vmalloc_32(unsigned long size) __alloc_size(1);
> > -extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
> > -extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_siz=
e(1);
> > -extern void *__vmalloc_node_range(unsigned long size, unsigned long al=
ign,
> > +extern void *vmalloc_noprof(unsigned long size) __alloc_size(1);
> > +#define vmalloc(...)         alloc_hooks(vmalloc_noprof(__VA_ARGS__))
> > +
> > +extern void *vzalloc_noprof(unsigned long size) __alloc_size(1);
> > +#define vzalloc(...)         alloc_hooks(vzalloc_noprof(__VA_ARGS__))
> > +
> > +extern void *vmalloc_user_noprof(unsigned long size) __alloc_size(1);
> > +#define vmalloc_user(...)    alloc_hooks(vmalloc_user_noprof(__VA_ARGS=
__))
> > +
> > +extern void *vmalloc_node_noprof(unsigned long size, int node) __alloc=
_size(1);
> > +#define vmalloc_node(...)    alloc_hooks(vmalloc_node_noprof(__VA_ARGS=
__))
> > +
> > +extern void *vzalloc_node_noprof(unsigned long size, int node) __alloc=
_size(1);
> > +#define vzalloc_node(...)    alloc_hooks(vzalloc_node_noprof(__VA_ARGS=
__))
> > +
> > +extern void *vmalloc_32_noprof(unsigned long size) __alloc_size(1);
> > +#define vmalloc_32(...)              alloc_hooks(vmalloc_32_noprof(__V=
A_ARGS__))
> > +
> > +extern void *vmalloc_32_user_noprof(unsigned long size) __alloc_size(1=
);
> > +#define vmalloc_32_user(...) alloc_hooks(vmalloc_32_user_noprof(__VA_A=
RGS__))
> > +
> > +extern void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask) __al=
loc_size(1);
> > +#define __vmalloc(...)               alloc_hooks(__vmalloc_noprof(__VA=
_ARGS__))
> > +
> > +extern void *__vmalloc_node_range_noprof(unsigned long size, unsigned =
long align,
> >                       unsigned long start, unsigned long end, gfp_t gfp=
_mask,
> >                       pgprot_t prot, unsigned long vm_flags, int node,
> >                       const void *caller) __alloc_size(1);
> > -void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gf=
p_mask,
> > +#define __vmalloc_node_range(...)    alloc_hooks(__vmalloc_node_range_=
noprof(__VA_ARGS__))
> > +
> > +void *__vmalloc_node_noprof(unsigned long size, unsigned long align, g=
fp_t gfp_mask,
> >               int node, const void *caller) __alloc_size(1);
> > -void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1)=
;
> > +#define __vmalloc_node(...)  alloc_hooks(__vmalloc_node_noprof(__VA_AR=
GS__))
> > +
> > +void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __alloc_=
size(1);
> > +#define vmalloc_huge(...)    alloc_hooks(vmalloc_huge_noprof(__VA_ARGS=
__))
> > +
> > +extern void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags=
) __alloc_size(1, 2);
> > +#define __vmalloc_array(...) alloc_hooks(__vmalloc_array_noprof(__VA_A=
RGS__))
> > +
> > +extern void *vmalloc_array_noprof(size_t n, size_t size) __alloc_size(=
1, 2);
> > +#define vmalloc_array(...)   alloc_hooks(vmalloc_array_noprof(__VA_ARG=
S__))
> > +
> > +extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __al=
loc_size(1, 2);
> > +#define __vcalloc(...)               alloc_hooks(__vcalloc_noprof(__VA=
_ARGS__))
> >
> > -extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __all=
oc_size(1, 2);
> > -extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
> > -extern void *__vcalloc(size_t n, size_t size, gfp_t flags) __alloc_siz=
e(1, 2);
> > -extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
> > +extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
> > +#define vcalloc(...)         alloc_hooks(vcalloc_noprof(__VA_ARGS__))
> >
> >  extern void vfree(const void *addr);
> >  extern void vfree_atomic(const void *addr);
> > diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
> > index 8a689b4ff4f9..2f84896a7bcb 100644
> > --- a/kernel/kallsyms_selftest.c
> > +++ b/kernel/kallsyms_selftest.c
> > @@ -82,7 +82,7 @@ static struct test_item test_items[] =3D {
> >       ITEM_FUNC(kallsyms_test_func_static),
> >       ITEM_FUNC(kallsyms_test_func),
> >       ITEM_FUNC(kallsyms_test_func_weak),
> > -     ITEM_FUNC(vmalloc),
> > +     ITEM_FUNC(vmalloc_noprof),
> >       ITEM_FUNC(vfree),
> >  #ifdef CONFIG_KALLSYMS_ALL
> >       ITEM_DATA(kallsyms_test_var_bss_static),
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 5ec8f44e7ce9..69a6f3b4d156 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -137,28 +137,28 @@ void vfree(const void *addr)
> >  }
> >  EXPORT_SYMBOL(vfree);
> >
> > -void *__vmalloc(unsigned long size, gfp_t gfp_mask)
> > +void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
> >  {
> >       /*
> >        *  You can't specify __GFP_HIGHMEM with kmalloc() since kmalloc(=
)
> >        * returns only a logical address.
> >        */
> > -     return kmalloc(size, (gfp_mask | __GFP_COMP) & ~__GFP_HIGHMEM);
> > +     return kmalloc_noprof(size, (gfp_mask | __GFP_COMP) & ~__GFP_HIGH=
MEM);
> >  }
> > -EXPORT_SYMBOL(__vmalloc);
> > +EXPORT_SYMBOL(__vmalloc_noprof);
> >
> > -void *__vmalloc_node_range(unsigned long size, unsigned long align,
> > +void *__vmalloc_node_range_noprof(unsigned long size, unsigned long al=
ign,
> >               unsigned long start, unsigned long end, gfp_t gfp_mask,
> >               pgprot_t prot, unsigned long vm_flags, int node,
> >               const void *caller)
> >  {
> > -     return __vmalloc(size, gfp_mask);
> > +     return __vmalloc_noprof(size, gfp_mask);
> >  }
> >
> > -void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gf=
p_mask,
> > +void *__vmalloc_node_noprof(unsigned long size, unsigned long align, g=
fp_t gfp_mask,
> >               int node, const void *caller)
> >  {
> > -     return __vmalloc(size, gfp_mask);
> > +     return __vmalloc_noprof(size, gfp_mask);
> >  }
> >
> >  static void *__vmalloc_user_flags(unsigned long size, gfp_t flags)
> > @@ -179,11 +179,11 @@ static void *__vmalloc_user_flags(unsigned long s=
ize, gfp_t flags)
> >       return ret;
> >  }
> >
> > -void *vmalloc_user(unsigned long size)
> > +void *vmalloc_user_noprof(unsigned long size)
> >  {
> >       return __vmalloc_user_flags(size, GFP_KERNEL | __GFP_ZERO);
> >  }
> > -EXPORT_SYMBOL(vmalloc_user);
> > +EXPORT_SYMBOL(vmalloc_user_noprof);
> >
> >  struct page *vmalloc_to_page(const void *addr)
> >  {
> > @@ -217,13 +217,13 @@ long vread_iter(struct iov_iter *iter, const char=
 *addr, size_t count)
> >   *   For tight control over page level allocator and protection flags
> >   *   use __vmalloc() instead.
> >   */
> > -void *vmalloc(unsigned long size)
> > +void *vmalloc_noprof(unsigned long size)
> >  {
> > -     return __vmalloc(size, GFP_KERNEL);
> > +     return __vmalloc_noprof(size, GFP_KERNEL);
> >  }
> > -EXPORT_SYMBOL(vmalloc);
> > +EXPORT_SYMBOL(vmalloc_noprof);
> >
> > -void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __weak __alias(=
__vmalloc);
> > +void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __weak _=
_alias(__vmalloc_noprof);
> >
> >  /*
> >   *   vzalloc - allocate virtually contiguous memory with zero fill
> > @@ -237,14 +237,14 @@ void *vmalloc_huge(unsigned long size, gfp_t gfp_=
mask) __weak __alias(__vmalloc)
> >   *   For tight control over page level allocator and protection flags
> >   *   use __vmalloc() instead.
> >   */
> > -void *vzalloc(unsigned long size)
> > +void *vzalloc_noprof(unsigned long size)
> >  {
> > -     return __vmalloc(size, GFP_KERNEL | __GFP_ZERO);
> > +     return __vmalloc_noprof(size, GFP_KERNEL | __GFP_ZERO);
> >  }
> > -EXPORT_SYMBOL(vzalloc);
> > +EXPORT_SYMBOL(vzalloc_noprof);
> >
> >  /**
> > - * vmalloc_node - allocate memory on a specific node
> > + * vmalloc_node_noprof - allocate memory on a specific node
> >   * @size:    allocation size
> >   * @node:    numa node
> >   *
> > @@ -254,14 +254,14 @@ EXPORT_SYMBOL(vzalloc);
> >   * For tight control over page level allocator and protection flags
> >   * use __vmalloc() instead.
> >   */
> > -void *vmalloc_node(unsigned long size, int node)
> > +void *vmalloc_node_noprof(unsigned long size, int node)
> >  {
> > -     return vmalloc(size);
> > +     return vmalloc_noprof(size);
> >  }
> > -EXPORT_SYMBOL(vmalloc_node);
> > +EXPORT_SYMBOL(vmalloc_node_noprof);
> >
> >  /**
> > - * vzalloc_node - allocate memory on a specific node with zero fill
> > + * vzalloc_node_noprof - allocate memory on a specific node with zero =
fill
> >   * @size:    allocation size
> >   * @node:    numa node
> >   *
> > @@ -272,27 +272,27 @@ EXPORT_SYMBOL(vmalloc_node);
> >   * For tight control over page level allocator and protection flags
> >   * use __vmalloc() instead.
> >   */
> > -void *vzalloc_node(unsigned long size, int node)
> > +void *vzalloc_node_noprof(unsigned long size, int node)
> >  {
> > -     return vzalloc(size);
> > +     return vzalloc_noprof(size);
> >  }
> > -EXPORT_SYMBOL(vzalloc_node);
> > +EXPORT_SYMBOL(vzalloc_node_noprof);
> >
> >  /**
> > - * vmalloc_32  -  allocate virtually contiguous memory (32bit addressa=
ble)
> > + * vmalloc_32_noprof  -  allocate virtually contiguous memory (32bit a=
ddressable)
> >   *   @size:          allocation size
> >   *
> >   *   Allocate enough 32bit PA addressable pages to cover @size from th=
e
> >   *   page level allocator and map them into contiguous kernel virtual =
space.
> >   */
> > -void *vmalloc_32(unsigned long size)
> > +void *vmalloc_32_noprof(unsigned long size)
> >  {
> > -     return __vmalloc(size, GFP_KERNEL);
> > +     return __vmalloc_noprof(size, GFP_KERNEL);
> >  }
> > -EXPORT_SYMBOL(vmalloc_32);
> > +EXPORT_SYMBOL(vmalloc_32_noprof);
> >
> >  /**
> > - * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
> > + * vmalloc_32_user_noprof - allocate zeroed virtually contiguous 32bit=
 memory
> >   *   @size:          allocation size
> >   *
> >   * The resulting memory area is 32bit addressable and zeroed so it can=
 be
> > @@ -301,15 +301,15 @@ EXPORT_SYMBOL(vmalloc_32);
> >   * VM_USERMAP is set on the corresponding VMA so that subsequent calls=
 to
> >   * remap_vmalloc_range() are permissible.
> >   */
> > -void *vmalloc_32_user(unsigned long size)
> > +void *vmalloc_32_user_noprof(unsigned long size)
> >  {
> >       /*
> >        * We'll have to sort out the ZONE_DMA bits for 64-bit,
> >        * but for now this can simply use vmalloc_user() directly.
> >        */
> > -     return vmalloc_user(size);
> > +     return vmalloc_user_noprof(size);
> >  }
> > -EXPORT_SYMBOL(vmalloc_32_user);
> > +EXPORT_SYMBOL(vmalloc_32_user_noprof);
> >
> >  void *vmap(struct page **pages, unsigned int count, unsigned long flag=
s, pgprot_t prot)
> >  {
> > diff --git a/mm/util.c b/mm/util.c
> > index a79dce7546f1..157b5edcba75 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -656,7 +656,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags=
, int node)
> >        * about the resulting pointer, and cannot play
> >        * protection games.
> >        */
> > -     return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> > +     return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLO=
C_END,
> >                       flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> >                       node, __builtin_return_address(0));
> >  }
> > @@ -715,12 +715,12 @@ void *kvrealloc_noprof(const void *p, size_t olds=
ize, size_t newsize, gfp_t flag
> >  EXPORT_SYMBOL(kvrealloc_noprof);
> >
> >  /**
> > - * __vmalloc_array - allocate memory for a virtually contiguous array.
> > + * __vmalloc_array_noprof - allocate memory for a virtually contiguous=
 array.
> >   * @n: number of elements.
> >   * @size: element size.
> >   * @flags: the type of memory to allocate (see kmalloc).
> >   */
> > -void *__vmalloc_array(size_t n, size_t size, gfp_t flags)
> > +void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
> >  {
> >       size_t bytes;
> >
> > @@ -728,18 +728,18 @@ void *__vmalloc_array(size_t n, size_t size, gfp_=
t flags)
> >               return NULL;
> >       return __vmalloc(bytes, flags);
> >  }
> > -EXPORT_SYMBOL(__vmalloc_array);
> > +EXPORT_SYMBOL(__vmalloc_array_noprof);
> >
> >  /**
> > - * vmalloc_array - allocate memory for a virtually contiguous array.
> > + * vmalloc_array_noprof - allocate memory for a virtually contiguous a=
rray.
> >   * @n: number of elements.
> >   * @size: element size.
> >   */
> > -void *vmalloc_array(size_t n, size_t size)
> > +void *vmalloc_array_noprof(size_t n, size_t size)
> >  {
> >       return __vmalloc_array(n, size, GFP_KERNEL);
> >  }
> > -EXPORT_SYMBOL(vmalloc_array);
> > +EXPORT_SYMBOL(vmalloc_array_noprof);
> >
> >  /**
> >   * __vcalloc - allocate and zero memory for a virtually contiguous arr=
ay.
> > @@ -747,22 +747,22 @@ EXPORT_SYMBOL(vmalloc_array);
> >   * @size: element size.
> >   * @flags: the type of memory to allocate (see kmalloc).
> >   */
> > -void *__vcalloc(size_t n, size_t size, gfp_t flags)
> > +void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags)
> >  {
> >       return __vmalloc_array(n, size, flags | __GFP_ZERO);
> >  }
> > -EXPORT_SYMBOL(__vcalloc);
> > +EXPORT_SYMBOL(__vcalloc_noprof);
> >
> >  /**
> > - * vcalloc - allocate and zero memory for a virtually contiguous array=
.
> > + * vcalloc_noprof - allocate and zero memory for a virtually contiguou=
s array.
> >   * @n: number of elements.
> >   * @size: element size.
> >   */
> > -void *vcalloc(size_t n, size_t size)
> > +void *vcalloc_noprof(size_t n, size_t size)
> >  {
> >       return __vmalloc_array(n, size, GFP_KERNEL | __GFP_ZERO);
> >  }
> > -EXPORT_SYMBOL(vcalloc);
> > +EXPORT_SYMBOL(vcalloc_noprof);
> >
> >  struct anon_vma *folio_anon_vma(struct folio *folio)
> >  {
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..b2f2248d85a9 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3507,12 +3507,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >                        * but mempolicy wants to alloc memory by interle=
aving.
> >                        */
> >                       if (IS_ENABLED(CONFIG_NUMA) && nid =3D=3D NUMA_NO=
_NODE)
> > -                             nr =3D alloc_pages_bulk_array_mempolicy(b=
ulk_gfp,
> > +                             nr =3D alloc_pages_bulk_array_mempolicy_n=
oprof(bulk_gfp,
> >                                                       nr_pages_request,
> >                                                       pages + nr_alloca=
ted);
> >
> >                       else
> > -                             nr =3D alloc_pages_bulk_array_node(bulk_g=
fp, nid,
> > +                             nr =3D alloc_pages_bulk_array_node_noprof=
(bulk_gfp, nid,
> >                                                       nr_pages_request,
> >                                                       pages + nr_alloca=
ted);
> >
> > @@ -3542,9 +3542,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >                       break;
> >
> >               if (nid =3D=3D NUMA_NO_NODE)
> > -                     page =3D alloc_pages(alloc_gfp, order);
> > +                     page =3D alloc_pages_noprof(alloc_gfp, order);
> >               else
> > -                     page =3D alloc_pages_node(nid, alloc_gfp, order);
> > +                     page =3D alloc_pages_node_noprof(nid, alloc_gfp, =
order);
> >               if (unlikely(!page)) {
> >                       if (!nofail)
> >                               break;
> > @@ -3601,10 +3601,10 @@ static void *__vmalloc_area_node(struct vm_stru=
ct *area, gfp_t gfp_mask,
> >
> >       /* Please note that the recursion is strictly bounded. */
> >       if (array_size > PAGE_SIZE) {
> > -             area->pages =3D __vmalloc_node(array_size, 1, nested_gfp,=
 node,
> > +             area->pages =3D __vmalloc_node_noprof(array_size, 1, nest=
ed_gfp, node,
> >                                       area->caller);
> >       } else {
> > -             area->pages =3D kmalloc_node(array_size, nested_gfp, node=
);
> > +             area->pages =3D kmalloc_node_noprof(array_size, nested_gf=
p, node);
> >       }
> >
> >       if (!area->pages) {
> > @@ -3687,7 +3687,7 @@ static void *__vmalloc_area_node(struct vm_struct=
 *area, gfp_t gfp_mask,
> >  }
> >
> >  /**
> > - * __vmalloc_node_range - allocate virtually contiguous memory
> > + * __vmalloc_node_range_noprof - allocate virtually contiguous memory
> >   * @size:              allocation size
> >   * @align:             desired alignment
> >   * @start:             vm area range start
> > @@ -3714,7 +3714,7 @@ static void *__vmalloc_area_node(struct vm_struct=
 *area, gfp_t gfp_mask,
> >   *
> >   * Return: the address of the area or %NULL on failure
> >   */
> > -void *__vmalloc_node_range(unsigned long size, unsigned long align,
> > +void *__vmalloc_node_range_noprof(unsigned long size, unsigned long al=
ign,
> >                       unsigned long start, unsigned long end, gfp_t gfp=
_mask,
> >                       pgprot_t prot, unsigned long vm_flags, int node,
> >                       const void *caller)
> > @@ -3843,7 +3843,7 @@ void *__vmalloc_node_range(unsigned long size, un=
signed long align,
> >  }
> >
> >  /**
> > - * __vmalloc_node - allocate virtually contiguous memory
> > + * __vmalloc_node_noprof - allocate virtually contiguous memory
> >   * @size:        allocation size
> >   * @align:       desired alignment
> >   * @gfp_mask:            flags for the page level allocator
> > @@ -3861,10 +3861,10 @@ void *__vmalloc_node_range(unsigned long size, =
unsigned long align,
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *__vmalloc_node(unsigned long size, unsigned long align,
> > +void *__vmalloc_node_noprof(unsigned long size, unsigned long align,
> >                           gfp_t gfp_mask, int node, const void *caller)
> >  {
> > -     return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_E=
ND,
> > +     return __vmalloc_node_range_noprof(size, align, VMALLOC_START, VM=
ALLOC_END,
> >                               gfp_mask, PAGE_KERNEL, 0, node, caller);
> >  }
> >  /*
> > @@ -3873,15 +3873,15 @@ void *__vmalloc_node(unsigned long size, unsign=
ed long align,
> >   * than that.
> >   */
> >  #ifdef CONFIG_TEST_VMALLOC_MODULE
> > -EXPORT_SYMBOL_GPL(__vmalloc_node);
> > +EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
> >  #endif
> >
> > -void *__vmalloc(unsigned long size, gfp_t gfp_mask)
> > +void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
> >  {
> > -     return __vmalloc_node(size, 1, gfp_mask, NUMA_NO_NODE,
> > +     return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
> >                               __builtin_return_address(0));
> >  }
> > -EXPORT_SYMBOL(__vmalloc);
> > +EXPORT_SYMBOL(__vmalloc_noprof);
> >
> >  /**
> >   * vmalloc - allocate virtually contiguous memory
> > @@ -3895,12 +3895,12 @@ EXPORT_SYMBOL(__vmalloc);
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *vmalloc(unsigned long size)
> > +void *vmalloc_noprof(unsigned long size)
> >  {
> > -     return __vmalloc_node(size, 1, GFP_KERNEL, NUMA_NO_NODE,
> > +     return __vmalloc_node_noprof(size, 1, GFP_KERNEL, NUMA_NO_NODE,
> >                               __builtin_return_address(0));
> >  }
> > -EXPORT_SYMBOL(vmalloc);
> > +EXPORT_SYMBOL(vmalloc_noprof);
> >
> >  /**
> >   * vmalloc_huge - allocate virtually contiguous memory, allow huge pag=
es
> > @@ -3914,16 +3914,16 @@ EXPORT_SYMBOL(vmalloc);
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
> > +void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
> >  {
> > -     return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> > +     return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLO=
C_END,
> >                                   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_=
VMAP,
> >                                   NUMA_NO_NODE, __builtin_return_addres=
s(0));
> >  }
> > -EXPORT_SYMBOL_GPL(vmalloc_huge);
> > +EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
> >
> >  /**
> > - * vzalloc - allocate virtually contiguous memory with zero fill
> > + * vzalloc_noprof - allocate virtually contiguous memory with zero fil=
l
> >   * @size:    allocation size
> >   *
> >   * Allocate enough pages to cover @size from the page level
> > @@ -3935,12 +3935,12 @@ EXPORT_SYMBOL_GPL(vmalloc_huge);
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *vzalloc(unsigned long size)
> > +void *vzalloc_noprof(unsigned long size)
> >  {
> > -     return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, NUMA_NO_N=
ODE,
> > +     return __vmalloc_node_noprof(size, 1, GFP_KERNEL | __GFP_ZERO, NU=
MA_NO_NODE,
> >                               __builtin_return_address(0));
> >  }
> > -EXPORT_SYMBOL(vzalloc);
> > +EXPORT_SYMBOL(vzalloc_noprof);
> >
> >  /**
> >   * vmalloc_user - allocate zeroed virtually contiguous memory for user=
space
> > @@ -3951,17 +3951,17 @@ EXPORT_SYMBOL(vzalloc);
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *vmalloc_user(unsigned long size)
> > +void *vmalloc_user_noprof(unsigned long size)
> >  {
> > -     return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC=
_END,
> > +     return __vmalloc_node_range_noprof(size, SHMLBA,  VMALLOC_START, =
VMALLOC_END,
> >                                   GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
> >                                   VM_USERMAP, NUMA_NO_NODE,
> >                                   __builtin_return_address(0));
> >  }
> > -EXPORT_SYMBOL(vmalloc_user);
> > +EXPORT_SYMBOL(vmalloc_user_noprof);
> >
> >  /**
> > - * vmalloc_node - allocate memory on a specific node
> > + * vmalloc_node_noprof - allocate memory on a specific node
> >   * @size:      allocation size
> >   * @node:      numa node
> >   *
> > @@ -3973,15 +3973,15 @@ EXPORT_SYMBOL(vmalloc_user);
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *vmalloc_node(unsigned long size, int node)
> > +void *vmalloc_node_noprof(unsigned long size, int node)
> >  {
> > -     return __vmalloc_node(size, 1, GFP_KERNEL, node,
> > +     return __vmalloc_node_noprof(size, 1, GFP_KERNEL, node,
> >                       __builtin_return_address(0));
> >  }
> > -EXPORT_SYMBOL(vmalloc_node);
> > +EXPORT_SYMBOL(vmalloc_node_noprof);
> >
> >  /**
> > - * vzalloc_node - allocate memory on a specific node with zero fill
> > + * vzalloc_node_noprof - allocate memory on a specific node with zero =
fill
> >   * @size:    allocation size
> >   * @node:    numa node
> >   *
> > @@ -3991,12 +3991,12 @@ EXPORT_SYMBOL(vmalloc_node);
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *vzalloc_node(unsigned long size, int node)
> > +void *vzalloc_node_noprof(unsigned long size, int node)
> >  {
> > -     return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, node,
> > +     return __vmalloc_node_noprof(size, 1, GFP_KERNEL | __GFP_ZERO, no=
de,
> >                               __builtin_return_address(0));
> >  }
> > -EXPORT_SYMBOL(vzalloc_node);
> > +EXPORT_SYMBOL(vzalloc_node_noprof);
> >
> >  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
> >  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
> > @@ -4011,7 +4011,7 @@ EXPORT_SYMBOL(vzalloc_node);
> >  #endif
> >
> >  /**
> > - * vmalloc_32 - allocate virtually contiguous memory (32bit addressabl=
e)
> > + * vmalloc_32_noprof - allocate virtually contiguous memory (32bit add=
ressable)
> >   * @size:    allocation size
> >   *
> >   * Allocate enough 32bit PA addressable pages to cover @size from the
> > @@ -4019,15 +4019,15 @@ EXPORT_SYMBOL(vzalloc_node);
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *vmalloc_32(unsigned long size)
> > +void *vmalloc_32_noprof(unsigned long size)
> >  {
> > -     return __vmalloc_node(size, 1, GFP_VMALLOC32, NUMA_NO_NODE,
> > +     return __vmalloc_node_noprof(size, 1, GFP_VMALLOC32, NUMA_NO_NODE=
,
> >                       __builtin_return_address(0));
> >  }
> > -EXPORT_SYMBOL(vmalloc_32);
> > +EXPORT_SYMBOL(vmalloc_32_noprof);
> >
> >  /**
> > - * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
> > + * vmalloc_32_user_noprof - allocate zeroed virtually contiguous 32bit=
 memory
> >   * @size:         allocation size
> >   *
> >   * The resulting memory area is 32bit addressable and zeroed so it can=
 be
> > @@ -4035,14 +4035,14 @@ EXPORT_SYMBOL(vmalloc_32);
> >   *
> >   * Return: pointer to the allocated memory or %NULL on error
> >   */
> > -void *vmalloc_32_user(unsigned long size)
> > +void *vmalloc_32_user_noprof(unsigned long size)
> >  {
> > -     return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC=
_END,
> > +     return __vmalloc_node_range_noprof(size, SHMLBA,  VMALLOC_START, =
VMALLOC_END,
> >                                   GFP_VMALLOC32 | __GFP_ZERO, PAGE_KERN=
EL,
> >                                   VM_USERMAP, NUMA_NO_NODE,
> >                                   __builtin_return_address(0));
> >  }
> > -EXPORT_SYMBOL(vmalloc_32_user);
> > +EXPORT_SYMBOL(vmalloc_32_user_noprof);
> >
> >  /*
> >   * Atomically zero bytes in the iterator.
> > --
> > 2.44.0.291.gc1ea87d7ee-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

