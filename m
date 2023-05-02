Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D386F4B55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjEBUY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 16:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjEBUY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 16:24:57 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF8D1BCD
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 13:24:50 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so6109504276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683059090; x=1685651090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rocmb1807rrqmHexWgUhMdukatSY3k3dt0DBoDYQQ84=;
        b=MU+gfSqaJcZXaDLvILYPcen+DJlOMwNmFrBFbKRSovZHxrvdwaG8OD3LLS//dpin/v
         VbPxpiE8cU1T7vAtmTF6dYeGjFpACQQOGybH9aHKcC5v1qu8tP75Rjq53IDWmffZjJrr
         tKsDUFpXswHNSV7LNAYl9HashXePGs8/8q+rr+D9/JqV7QS7JaaLeNaw5z/oiHChIdRk
         UE4s9//C6tXLhlQyVF3+Z1jXTOQHY1Ua2URA+4E6vRPa6Kxru/WjNmMPKUxKaXgwJiRm
         sq3XUJ1lzzhLAW3l6HbWMcyldde6rUUvXKLuFkUxWSDQY/iFYdWKz2F0FVyb5kq4I/a/
         JBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059090; x=1685651090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rocmb1807rrqmHexWgUhMdukatSY3k3dt0DBoDYQQ84=;
        b=FWWcja1X9swYqvdnWE1mlEj4X9ihhyBaePFBC2fT+76U9CeN4rqt2XqYmIGU3MfJye
         fiU+WrfQfeBF9vBUyGsEbV2K6wpe9dNBw9t5CyAlxkbN5Ud2GJVu/O1XIZHAC5II1gwh
         DVqtXfEIQiqVtyviOo5O/x74TPxC+fTUEy9Xo9KIDWrDysmlXwS/PFQ/2iJ6wsVSDWxx
         n4jqhkhM+D4LsSxL+zyUbdkhdZB8T2enjkz922SQBgA4q3zvS4REOf7heGUOpdmC4Ck/
         aisQvzG0mK/CDdfqWWSFqsJ19d/gLdgVR0Wmc87dSi5SzCv1KKv5TTl8jn6R7QhRl+Cg
         pljA==
X-Gm-Message-State: AC+VfDzcQ7BAMSwZ+j26oL8snCXm7voQIDQnDWh0BNZ+g4hsVvX9uJ8c
        z1jlpTeug5YWRIaVJHau924jEhHr40gkdr1GQDVcUg==
X-Google-Smtp-Source: ACHHUZ498EUoOwRRn2rdDuuuK5krmC/as1ueUrWM+kQJuCKq0a3B5NsZWZU/qAtq+dCO/VPCb+cyeEH8kNx+l9uLzbE=
X-Received: by 2002:a25:588:0:b0:b87:d47e:9bcb with SMTP id
 130-20020a250588000000b00b87d47e9bcbmr17713528ybf.42.1683059089603; Tue, 02
 May 2023 13:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-20-surenb@google.com>
 <20230502175052.43814202@meshulam.tesarici.cz> <CAJuCfpGSLK50eKQ2-CE41qz1oDPM6kC8RmqF=usZKwFXgTBe8g@mail.gmail.com>
 <20230502220909.3f55ae41@meshulam.tesarici.cz>
In-Reply-To: <20230502220909.3f55ae41@meshulam.tesarici.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 13:24:37 -0700
Message-ID: <CAJuCfpGGB204PKuqjjkPBn_XHL-xLPkn0bF6xc12Bfj8=Qzcrw@mail.gmail.com>
Subject: Re: [PATCH 19/40] change alloc_pages name in dma_map_ops to avoid
 name conflicts
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 2, 2023 at 1:09=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
>
> On Tue, 2 May 2023 11:38:49 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > On Tue, May 2, 2023 at 8:50=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tes=
arici.cz> wrote:
> > >
> > > On Mon,  1 May 2023 09:54:29 -0700
> > > Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > After redefining alloc_pages, all uses of that name are being repla=
ced.
> > > > Change the conflicting names to prevent preprocessor from replacing=
 them
> > > > when it's not intended.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  arch/x86/kernel/amd_gart_64.c | 2 +-
> > > >  drivers/iommu/dma-iommu.c     | 2 +-
> > > >  drivers/xen/grant-dma-ops.c   | 2 +-
> > > >  drivers/xen/swiotlb-xen.c     | 2 +-
> > > >  include/linux/dma-map-ops.h   | 2 +-
> > > >  kernel/dma/mapping.c          | 4 ++--
> > > >  6 files changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_ga=
rt_64.c
> > > > index 56a917df410d..842a0ec5eaa9 100644
> > > > --- a/arch/x86/kernel/amd_gart_64.c
> > > > +++ b/arch/x86/kernel/amd_gart_64.c
> > > > @@ -676,7 +676,7 @@ static const struct dma_map_ops gart_dma_ops =
=3D {
> > > >       .get_sgtable                    =3D dma_common_get_sgtable,
> > > >       .dma_supported                  =3D dma_direct_supported,
> > > >       .get_required_mask              =3D dma_direct_get_required_m=
ask,
> > > > -     .alloc_pages                    =3D dma_direct_alloc_pages,
> > > > +     .alloc_pages_op                 =3D dma_direct_alloc_pages,
> > > >       .free_pages                     =3D dma_direct_free_pages,
> > > >  };
> > > >
> > > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > > index 7a9f0b0bddbd..76a9d5ca4eee 100644
> > > > --- a/drivers/iommu/dma-iommu.c
> > > > +++ b/drivers/iommu/dma-iommu.c
> > > > @@ -1556,7 +1556,7 @@ static const struct dma_map_ops iommu_dma_ops=
 =3D {
> > > >       .flags                  =3D DMA_F_PCI_P2PDMA_SUPPORTED,
> > > >       .alloc                  =3D iommu_dma_alloc,
> > > >       .free                   =3D iommu_dma_free,
> > > > -     .alloc_pages            =3D dma_common_alloc_pages,
> > > > +     .alloc_pages_op         =3D dma_common_alloc_pages,
> > > >       .free_pages             =3D dma_common_free_pages,
> > > >       .alloc_noncontiguous    =3D iommu_dma_alloc_noncontiguous,
> > > >       .free_noncontiguous     =3D iommu_dma_free_noncontiguous,
> > > > diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-op=
s.c
> > > > index 9784a77fa3c9..6c7d984f164d 100644
> > > > --- a/drivers/xen/grant-dma-ops.c
> > > > +++ b/drivers/xen/grant-dma-ops.c
> > > > @@ -282,7 +282,7 @@ static int xen_grant_dma_supported(struct devic=
e *dev, u64 mask)
> > > >  static const struct dma_map_ops xen_grant_dma_ops =3D {
> > > >       .alloc =3D xen_grant_dma_alloc,
> > > >       .free =3D xen_grant_dma_free,
> > > > -     .alloc_pages =3D xen_grant_dma_alloc_pages,
> > > > +     .alloc_pages_op =3D xen_grant_dma_alloc_pages,
> > > >       .free_pages =3D xen_grant_dma_free_pages,
> > > >       .mmap =3D dma_common_mmap,
> > > >       .get_sgtable =3D dma_common_get_sgtable,
> > > > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > > > index 67aa74d20162..5ab2616153f0 100644
> > > > --- a/drivers/xen/swiotlb-xen.c
> > > > +++ b/drivers/xen/swiotlb-xen.c
> > > > @@ -403,6 +403,6 @@ const struct dma_map_ops xen_swiotlb_dma_ops =
=3D {
> > > >       .dma_supported =3D xen_swiotlb_dma_supported,
> > > >       .mmap =3D dma_common_mmap,
> > > >       .get_sgtable =3D dma_common_get_sgtable,
> > > > -     .alloc_pages =3D dma_common_alloc_pages,
> > > > +     .alloc_pages_op =3D dma_common_alloc_pages,
> > > >       .free_pages =3D dma_common_free_pages,
> > > >  };
> > > > diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-op=
s.h
> > > > index 31f114f486c4..d741940dcb3b 100644
> > > > --- a/include/linux/dma-map-ops.h
> > > > +++ b/include/linux/dma-map-ops.h
> > > > @@ -27,7 +27,7 @@ struct dma_map_ops {
> > > >                       unsigned long attrs);
> > > >       void (*free)(struct device *dev, size_t size, void *vaddr,
> > > >                       dma_addr_t dma_handle, unsigned long attrs);
> > > > -     struct page *(*alloc_pages)(struct device *dev, size_t size,
> > > > +     struct page *(*alloc_pages_op)(struct device *dev, size_t siz=
e,
> > > >                       dma_addr_t *dma_handle, enum dma_data_directi=
on dir,
> > > >                       gfp_t gfp);
> > > >       void (*free_pages)(struct device *dev, size_t size, struct pa=
ge *vaddr,
> > > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > > index 9a4db5cce600..fc42930af14b 100644
> > > > --- a/kernel/dma/mapping.c
> > > > +++ b/kernel/dma/mapping.c
> > > > @@ -570,9 +570,9 @@ static struct page *__dma_alloc_pages(struct de=
vice *dev, size_t size,
> > > >       size =3D PAGE_ALIGN(size);
> > > >       if (dma_alloc_direct(dev, ops))
> > > >               return dma_direct_alloc_pages(dev, size, dma_handle, =
dir, gfp);
> > > > -     if (!ops->alloc_pages)
> > > > +     if (!ops->alloc_pages_op)
> > > >               return NULL;
> > > > -     return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
> > > > +     return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
> > > >  }
> > > >
> > > >  struct page *dma_alloc_pages(struct device *dev, size_t size,
> > >
> > > I'm not impressed. This patch increases churn for code which does not
> > > (directly) benefit from the change, and that for limitations in your
> > > tooling?
> > >
> > > Why not just rename the conflicting uses in your local tree, but then
> > > remove the rename from the final patch series?
> >
> > With alloc_pages function becoming a macro, the preprocessor ends up
> > replacing all instances of that name, even when it's not used as a
> > function. That what necessitates this change. If there is a way to
> > work around this issue without changing all alloc_pages() calls in the
> > source base I would love to learn it but I'm not quite clear about
> > your suggestion and if it solves the issue. Could you please provide
> > more details?
>
> Ah, right, I admit I did not quite understand why this change is
> needed. However, this is exactly what I don't like about preprocessor
> macros. Each macro effectively adds a new keyword to the language.
>
> I believe everything can be solved with inline functions. What exactly
> does not work if you rename alloc_pages() to e.g. alloc_pages_caller()
> and then add an alloc_pages() inline function which calls
> alloc_pages_caller() with _RET_IP_ as a parameter?

I don't think that would work because we need to inject the codetag at
the file/line of the actual allocation call. If we pass _REP_IT_ then
we would have to lookup the codetag associated with that _RET_IP_
which results in additional runtime overhead.

>
> Petr T
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
