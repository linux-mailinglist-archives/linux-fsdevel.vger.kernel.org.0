Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1CA6F4B86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 22:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjEBUmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 16:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBUmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 16:42:05 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E191BDF
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 13:42:02 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so27754276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683060121; x=1685652121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jeq6+nx3g2wrW78uPfEerLbf18qIDqHe8kQ7v5/JI60=;
        b=USgXLop66yK89JWxFP/fxzpFn6QCWIJ873ogcbMDaInHtoy86T0N+nDV3beDNUkq/4
         7c06Jya3MtjCRVJM+uNiMRs8RsEjcuOOGWIJrQZZueHpb8sE4DfQf9CM/q0ZS2jcLOLw
         Zxz0Iz+Ftxu+bdb4q4rBZ/RbfwNX8QwPVZ0QhmH+LWE19e3eVerx9UKRt0gEIZVUeoQU
         bQ9rPDFBUQenVP8rXbU2Tw3/ndUSRGc8QMnj9BCeiemAFsvcZKGpt9grfpkHrYcao6rB
         iJHXwyF5Ilbx83HWZbdXNDDSJARcklUlVWFftnhagZVtN2T4a20Nb9A365j2QrPSNgF4
         B25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683060121; x=1685652121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jeq6+nx3g2wrW78uPfEerLbf18qIDqHe8kQ7v5/JI60=;
        b=I7j2qzrpWB+Dtdv13eWvnDgK9phQR7O0+pz+1+ZJJ/Bj5c8wzj8w6HMfH9NYnSAZqD
         +HE62FByOrSkHyc5SozwP1T2vJV+uqjT1bhWho+y0yRu8V/1Stwk98CEjb1/s5VE8YFN
         KYp6B6l3nLjcCRRxGU8GnO51Jpyxp7k7N3hOabgRzrJ+ytbl3i7hD0b70q7hvxb6fNoO
         XARPZOh3za9aX0Bh+L6V65EOE8Lo4Lp4Zxyku/qlgV22Lvpjx5U+Mo51aeb367fs8mk1
         MxAQk7Ym1JvbruTqxAi1q6WaQdhs5zEh7L4jCSF3n4MeGdKCzMGHeyCHA2GB5Ouw3lBu
         vx5g==
X-Gm-Message-State: AC+VfDxX4jaUaoDYtyZu5jbQ+OyHVpFMPSB6FNvBQTrESlkx7HCmHSpV
        GZcB3VaxYVsqCRwHDN1KHEyS9TfIWAznc4YOWsA0PA==
X-Google-Smtp-Source: ACHHUZ5z82SFE/PhvG4ajlwJ05a6eit0o1Z0+SeptnZWzVgvcEwXXhJXalbNVj9VFFQTqZovBYcxLn2M5RryyqnhyFQ=
X-Received: by 2002:a25:e78d:0:b0:b9a:6a19:8153 with SMTP id
 e135-20020a25e78d000000b00b9a6a198153mr17807199ybh.5.1683060120872; Tue, 02
 May 2023 13:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-20-surenb@google.com>
 <20230502175052.43814202@meshulam.tesarici.cz> <CAJuCfpGSLK50eKQ2-CE41qz1oDPM6kC8RmqF=usZKwFXgTBe8g@mail.gmail.com>
 <20230502220909.3f55ae41@meshulam.tesarici.cz> <CAJuCfpGGB204PKuqjjkPBn_XHL-xLPkn0bF6xc12Bfj8=Qzcrw@mail.gmail.com>
 <20230502223915.6b38f8c4@meshulam.tesarici.cz>
In-Reply-To: <20230502223915.6b38f8c4@meshulam.tesarici.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 13:41:49 -0700
Message-ID: <CAJuCfpE2wBnekxOTNpCaHRwnMznPgBkSUJNHk5y1-togkAtkHw@mail.gmail.com>
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

On Tue, May 2, 2023 at 1:39=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
>
> On Tue, 2 May 2023 13:24:37 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > On Tue, May 2, 2023 at 1:09=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tes=
arici.cz> wrote:
> > >
> > > On Tue, 2 May 2023 11:38:49 -0700
> > > Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > On Tue, May 2, 2023 at 8:50=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr=
@tesarici.cz> wrote:
> > > > >
> > > > > On Mon,  1 May 2023 09:54:29 -0700
> > > > > Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > > After redefining alloc_pages, all uses of that name are being r=
eplaced.
> > > > > > Change the conflicting names to prevent preprocessor from repla=
cing them
> > > > > > when it's not intended.
> > > > > >
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > ---
> > > > > >  arch/x86/kernel/amd_gart_64.c | 2 +-
> > > > > >  drivers/iommu/dma-iommu.c     | 2 +-
> > > > > >  drivers/xen/grant-dma-ops.c   | 2 +-
> > > > > >  drivers/xen/swiotlb-xen.c     | 2 +-
> > > > > >  include/linux/dma-map-ops.h   | 2 +-
> > > > > >  kernel/dma/mapping.c          | 4 ++--
> > > > > >  6 files changed, 7 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/am=
d_gart_64.c
> > > > > > index 56a917df410d..842a0ec5eaa9 100644
> > > > > > --- a/arch/x86/kernel/amd_gart_64.c
> > > > > > +++ b/arch/x86/kernel/amd_gart_64.c
> > > > > > @@ -676,7 +676,7 @@ static const struct dma_map_ops gart_dma_op=
s =3D {
> > > > > >       .get_sgtable                    =3D dma_common_get_sgtabl=
e,
> > > > > >       .dma_supported                  =3D dma_direct_supported,
> > > > > >       .get_required_mask              =3D dma_direct_get_requir=
ed_mask,
> > > > > > -     .alloc_pages                    =3D dma_direct_alloc_page=
s,
> > > > > > +     .alloc_pages_op                 =3D dma_direct_alloc_page=
s,
> > > > > >       .free_pages                     =3D dma_direct_free_pages=
,
> > > > > >  };
> > > > > >
> > > > > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iomm=
u.c
> > > > > > index 7a9f0b0bddbd..76a9d5ca4eee 100644
> > > > > > --- a/drivers/iommu/dma-iommu.c
> > > > > > +++ b/drivers/iommu/dma-iommu.c
> > > > > > @@ -1556,7 +1556,7 @@ static const struct dma_map_ops iommu_dma=
_ops =3D {
> > > > > >       .flags                  =3D DMA_F_PCI_P2PDMA_SUPPORTED,
> > > > > >       .alloc                  =3D iommu_dma_alloc,
> > > > > >       .free                   =3D iommu_dma_free,
> > > > > > -     .alloc_pages            =3D dma_common_alloc_pages,
> > > > > > +     .alloc_pages_op         =3D dma_common_alloc_pages,
> > > > > >       .free_pages             =3D dma_common_free_pages,
> > > > > >       .alloc_noncontiguous    =3D iommu_dma_alloc_noncontiguous=
,
> > > > > >       .free_noncontiguous     =3D iommu_dma_free_noncontiguous,
> > > > > > diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dm=
a-ops.c
> > > > > > index 9784a77fa3c9..6c7d984f164d 100644
> > > > > > --- a/drivers/xen/grant-dma-ops.c
> > > > > > +++ b/drivers/xen/grant-dma-ops.c
> > > > > > @@ -282,7 +282,7 @@ static int xen_grant_dma_supported(struct d=
evice *dev, u64 mask)
> > > > > >  static const struct dma_map_ops xen_grant_dma_ops =3D {
> > > > > >       .alloc =3D xen_grant_dma_alloc,
> > > > > >       .free =3D xen_grant_dma_free,
> > > > > > -     .alloc_pages =3D xen_grant_dma_alloc_pages,
> > > > > > +     .alloc_pages_op =3D xen_grant_dma_alloc_pages,
> > > > > >       .free_pages =3D xen_grant_dma_free_pages,
> > > > > >       .mmap =3D dma_common_mmap,
> > > > > >       .get_sgtable =3D dma_common_get_sgtable,
> > > > > > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xe=
n.c
> > > > > > index 67aa74d20162..5ab2616153f0 100644
> > > > > > --- a/drivers/xen/swiotlb-xen.c
> > > > > > +++ b/drivers/xen/swiotlb-xen.c
> > > > > > @@ -403,6 +403,6 @@ const struct dma_map_ops xen_swiotlb_dma_op=
s =3D {
> > > > > >       .dma_supported =3D xen_swiotlb_dma_supported,
> > > > > >       .mmap =3D dma_common_mmap,
> > > > > >       .get_sgtable =3D dma_common_get_sgtable,
> > > > > > -     .alloc_pages =3D dma_common_alloc_pages,
> > > > > > +     .alloc_pages_op =3D dma_common_alloc_pages,
> > > > > >       .free_pages =3D dma_common_free_pages,
> > > > > >  };
> > > > > > diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-ma=
p-ops.h
> > > > > > index 31f114f486c4..d741940dcb3b 100644
> > > > > > --- a/include/linux/dma-map-ops.h
> > > > > > +++ b/include/linux/dma-map-ops.h
> > > > > > @@ -27,7 +27,7 @@ struct dma_map_ops {
> > > > > >                       unsigned long attrs);
> > > > > >       void (*free)(struct device *dev, size_t size, void *vaddr=
,
> > > > > >                       dma_addr_t dma_handle, unsigned long attr=
s);
> > > > > > -     struct page *(*alloc_pages)(struct device *dev, size_t si=
ze,
> > > > > > +     struct page *(*alloc_pages_op)(struct device *dev, size_t=
 size,
> > > > > >                       dma_addr_t *dma_handle, enum dma_data_dir=
ection dir,
> > > > > >                       gfp_t gfp);
> > > > > >       void (*free_pages)(struct device *dev, size_t size, struc=
t page *vaddr,
> > > > > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > > > > index 9a4db5cce600..fc42930af14b 100644
> > > > > > --- a/kernel/dma/mapping.c
> > > > > > +++ b/kernel/dma/mapping.c
> > > > > > @@ -570,9 +570,9 @@ static struct page *__dma_alloc_pages(struc=
t device *dev, size_t size,
> > > > > >       size =3D PAGE_ALIGN(size);
> > > > > >       if (dma_alloc_direct(dev, ops))
> > > > > >               return dma_direct_alloc_pages(dev, size, dma_hand=
le, dir, gfp);
> > > > > > -     if (!ops->alloc_pages)
> > > > > > +     if (!ops->alloc_pages_op)
> > > > > >               return NULL;
> > > > > > -     return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
> > > > > > +     return ops->alloc_pages_op(dev, size, dma_handle, dir, gf=
p);
> > > > > >  }
> > > > > >
> > > > > >  struct page *dma_alloc_pages(struct device *dev, size_t size,
> > > > >
> > > > > I'm not impressed. This patch increases churn for code which does=
 not
> > > > > (directly) benefit from the change, and that for limitations in y=
our
> > > > > tooling?
> > > > >
> > > > > Why not just rename the conflicting uses in your local tree, but =
then
> > > > > remove the rename from the final patch series?
> > > >
> > > > With alloc_pages function becoming a macro, the preprocessor ends u=
p
> > > > replacing all instances of that name, even when it's not used as a
> > > > function. That what necessitates this change. If there is a way to
> > > > work around this issue without changing all alloc_pages() calls in =
the
> > > > source base I would love to learn it but I'm not quite clear about
> > > > your suggestion and if it solves the issue. Could you please provid=
e
> > > > more details?
> > >
> > > Ah, right, I admit I did not quite understand why this change is
> > > needed. However, this is exactly what I don't like about preprocessor
> > > macros. Each macro effectively adds a new keyword to the language.
> > >
> > > I believe everything can be solved with inline functions. What exactl=
y
> > > does not work if you rename alloc_pages() to e.g. alloc_pages_caller(=
)
> > > and then add an alloc_pages() inline function which calls
> > > alloc_pages_caller() with _RET_IP_ as a parameter?
> >
> > I don't think that would work because we need to inject the codetag at
> > the file/line of the actual allocation call. If we pass _REP_IT_ then
> > we would have to lookup the codetag associated with that _RET_IP_
> > which results in additional runtime overhead.
>
> OK. If the reference to source code itself must be recorded in the
> kernel, and not resolved later (either by the debugfs read fops, or by
> a tool which reads the file), then this information can only be
> obtained with a preprocessor macro.
>
> I was hoping that a debugging feature could be less intrusive. OTOH
> it's not my call to balance the tradeoffs.
>
> Thank you for your patient explanations.

Thanks for reviewing and the suggestions! I'll address the actionable
ones in the next version.
Suren.

>
> Petr T
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
