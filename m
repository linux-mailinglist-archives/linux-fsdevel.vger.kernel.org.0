Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B06F4AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjEBUJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEBUJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 16:09:21 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EE01BD4;
        Tue,  2 May 2023 13:09:16 -0700 (PDT)
Received: from meshulam.tesarici.cz (nat-97.starnet.cz [178.255.168.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 9F0D614C262;
        Tue,  2 May 2023 22:09:11 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1683058152; bh=OQQDbaT1g8f2dPLm5XSkHxMIreXJIprIWNp5xqPtyjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ACEe9aMV7KAl5vtSygiD0xbm7GHaT9Eqyv4H5MpZy91H692eziATAh+Lllc4/9nF3
         9e+F1G490J0hwPn2UyqIwUJB1EH4TqQrl+IsVypjDznWCqQ5uXNN5ITXEdhlYC04z/
         xrT7brhbQqzJVnJhe0lj2PAIkzmIpYLQO5D13JOi/pXsgd3wv8CWwPcpd8CN8wKdXP
         X1wLEGxjC6cJJSdqG/m4XGAZK8W7DskDc/fFABNpCko/6HHqnxg3JJO8vtiG4/XE9H
         Q6YBS5/HHT1gl8+fWrS81CUQeFjzzEkOOTPV62RwgA77/pe3jfDZ4V6bi4OMBzKBTo
         1Ci/3VokWKu1A==
Date:   Tue, 2 May 2023 22:09:09 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [PATCH 19/40] change alloc_pages name in dma_map_ops to avoid
 name conflicts
Message-ID: <20230502220909.3f55ae41@meshulam.tesarici.cz>
In-Reply-To: <CAJuCfpGSLK50eKQ2-CE41qz1oDPM6kC8RmqF=usZKwFXgTBe8g@mail.gmail.com>
References: <20230501165450.15352-1-surenb@google.com>
        <20230501165450.15352-20-surenb@google.com>
        <20230502175052.43814202@meshulam.tesarici.cz>
        <CAJuCfpGSLK50eKQ2-CE41qz1oDPM6kC8RmqF=usZKwFXgTBe8g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2 May 2023 11:38:49 -0700
Suren Baghdasaryan <surenb@google.com> wrote:

> On Tue, May 2, 2023 at 8:50=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesar=
ici.cz> wrote:
> >
> > On Mon,  1 May 2023 09:54:29 -0700
> > Suren Baghdasaryan <surenb@google.com> wrote:
> > =20
> > > After redefining alloc_pages, all uses of that name are being replace=
d.
> > > Change the conflicting names to prevent preprocessor from replacing t=
hem
> > > when it's not intended.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  arch/x86/kernel/amd_gart_64.c | 2 +-
> > >  drivers/iommu/dma-iommu.c     | 2 +-
> > >  drivers/xen/grant-dma-ops.c   | 2 +-
> > >  drivers/xen/swiotlb-xen.c     | 2 +-
> > >  include/linux/dma-map-ops.h   | 2 +-
> > >  kernel/dma/mapping.c          | 4 ++--
> > >  6 files changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart=
_64.c
> > > index 56a917df410d..842a0ec5eaa9 100644
> > > --- a/arch/x86/kernel/amd_gart_64.c
> > > +++ b/arch/x86/kernel/amd_gart_64.c
> > > @@ -676,7 +676,7 @@ static const struct dma_map_ops gart_dma_ops =3D {
> > >       .get_sgtable                    =3D dma_common_get_sgtable,
> > >       .dma_supported                  =3D dma_direct_supported,
> > >       .get_required_mask              =3D dma_direct_get_required_mas=
k,
> > > -     .alloc_pages                    =3D dma_direct_alloc_pages,
> > > +     .alloc_pages_op                 =3D dma_direct_alloc_pages,
> > >       .free_pages                     =3D dma_direct_free_pages,
> > >  };
> > >
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index 7a9f0b0bddbd..76a9d5ca4eee 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -1556,7 +1556,7 @@ static const struct dma_map_ops iommu_dma_ops =
=3D {
> > >       .flags                  =3D DMA_F_PCI_P2PDMA_SUPPORTED,
> > >       .alloc                  =3D iommu_dma_alloc,
> > >       .free                   =3D iommu_dma_free,
> > > -     .alloc_pages            =3D dma_common_alloc_pages,
> > > +     .alloc_pages_op         =3D dma_common_alloc_pages,
> > >       .free_pages             =3D dma_common_free_pages,
> > >       .alloc_noncontiguous    =3D iommu_dma_alloc_noncontiguous,
> > >       .free_noncontiguous     =3D iommu_dma_free_noncontiguous,
> > > diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> > > index 9784a77fa3c9..6c7d984f164d 100644
> > > --- a/drivers/xen/grant-dma-ops.c
> > > +++ b/drivers/xen/grant-dma-ops.c
> > > @@ -282,7 +282,7 @@ static int xen_grant_dma_supported(struct device =
*dev, u64 mask)
> > >  static const struct dma_map_ops xen_grant_dma_ops =3D {
> > >       .alloc =3D xen_grant_dma_alloc,
> > >       .free =3D xen_grant_dma_free,
> > > -     .alloc_pages =3D xen_grant_dma_alloc_pages,
> > > +     .alloc_pages_op =3D xen_grant_dma_alloc_pages,
> > >       .free_pages =3D xen_grant_dma_free_pages,
> > >       .mmap =3D dma_common_mmap,
> > >       .get_sgtable =3D dma_common_get_sgtable,
> > > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > > index 67aa74d20162..5ab2616153f0 100644
> > > --- a/drivers/xen/swiotlb-xen.c
> > > +++ b/drivers/xen/swiotlb-xen.c
> > > @@ -403,6 +403,6 @@ const struct dma_map_ops xen_swiotlb_dma_ops =3D {
> > >       .dma_supported =3D xen_swiotlb_dma_supported,
> > >       .mmap =3D dma_common_mmap,
> > >       .get_sgtable =3D dma_common_get_sgtable,
> > > -     .alloc_pages =3D dma_common_alloc_pages,
> > > +     .alloc_pages_op =3D dma_common_alloc_pages,
> > >       .free_pages =3D dma_common_free_pages,
> > >  };
> > > diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> > > index 31f114f486c4..d741940dcb3b 100644
> > > --- a/include/linux/dma-map-ops.h
> > > +++ b/include/linux/dma-map-ops.h
> > > @@ -27,7 +27,7 @@ struct dma_map_ops {
> > >                       unsigned long attrs);
> > >       void (*free)(struct device *dev, size_t size, void *vaddr,
> > >                       dma_addr_t dma_handle, unsigned long attrs);
> > > -     struct page *(*alloc_pages)(struct device *dev, size_t size,
> > > +     struct page *(*alloc_pages_op)(struct device *dev, size_t size,
> > >                       dma_addr_t *dma_handle, enum dma_data_direction=
 dir,
> > >                       gfp_t gfp);
> > >       void (*free_pages)(struct device *dev, size_t size, struct page=
 *vaddr,
> > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > index 9a4db5cce600..fc42930af14b 100644
> > > --- a/kernel/dma/mapping.c
> > > +++ b/kernel/dma/mapping.c
> > > @@ -570,9 +570,9 @@ static struct page *__dma_alloc_pages(struct devi=
ce *dev, size_t size,
> > >       size =3D PAGE_ALIGN(size);
> > >       if (dma_alloc_direct(dev, ops))
> > >               return dma_direct_alloc_pages(dev, size, dma_handle, di=
r, gfp);
> > > -     if (!ops->alloc_pages)
> > > +     if (!ops->alloc_pages_op)
> > >               return NULL;
> > > -     return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
> > > +     return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
> > >  }
> > >
> > >  struct page *dma_alloc_pages(struct device *dev, size_t size, =20
> >
> > I'm not impressed. This patch increases churn for code which does not
> > (directly) benefit from the change, and that for limitations in your
> > tooling?
> >
> > Why not just rename the conflicting uses in your local tree, but then
> > remove the rename from the final patch series? =20
>=20
> With alloc_pages function becoming a macro, the preprocessor ends up
> replacing all instances of that name, even when it's not used as a
> function. That what necessitates this change. If there is a way to
> work around this issue without changing all alloc_pages() calls in the
> source base I would love to learn it but I'm not quite clear about
> your suggestion and if it solves the issue. Could you please provide
> more details?

Ah, right, I admit I did not quite understand why this change is
needed. However, this is exactly what I don't like about preprocessor
macros. Each macro effectively adds a new keyword to the language.

I believe everything can be solved with inline functions. What exactly
does not work if you rename alloc_pages() to e.g. alloc_pages_caller()
and then add an alloc_pages() inline function which calls
alloc_pages_caller() with _RET_IP_ as a parameter?

Petr T
