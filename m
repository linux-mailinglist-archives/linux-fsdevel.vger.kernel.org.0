Return-Path: <linux-fsdevel+bounces-44724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5791AA6BF85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB754189F4A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824122DF86;
	Fri, 21 Mar 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv3+y9CY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90B22D798
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573680; cv=none; b=VzkzK9HXDbRqfUvYOpttuLgRDcQoSompsZ2wrSd6SfDKsclsSvdTJpt4c66/rLTtfLe23QI6HqyTAKPf5z+uSiBrjDbvSqRz0SS6es22iCIqynhdf06U2w0r7HUjYVXK9Lth8l0EAgmRcOe8NL3AqvyMAU7pVU2daID0i6+DrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573680; c=relaxed/simple;
	bh=qXpYjnL6QzDKFF/vEA2avZLphl/BA8jmPIwzNSXeK7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJhHL9fFJyxSeWnKVQz7SzrZcAvAxdssDuezxAsO9W0BjUprGmGGuHL0bXYvfL73BXqTuHBIK0HcpeSCDeL9aoRpGKB5VgsqOukf93o5gt9ULq9bP2g//SKkFwu7tv3O9ZadaaibJnY8IVtVWefUkmRvsFhr83B7AsJS8Z5S6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fv3+y9CY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47666573242so492931cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742573677; x=1743178477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr1NpamvodEP6MFP3VgS0Dk87IubpsnKUE/+euMf6QU=;
        b=Fv3+y9CY8f2z8Zy2KI6pqFnQyV7BVUDrSAJNKGpTVdyOpcyNU4/FQUL4zz3+faPkaT
         oTn39Aqr1rBjdcYFvzwokw8ucOYuOiR6qNpR0xhBxlofxuKBD2A17SWui721887+jErb
         lueqHOTTfjYujWnpOrnpa5DUarH7F+TBIooG65jTgRsSgylaC3X874jRNb/uAZ/0UtEa
         RHQJyMwwwLLgnmTfRdf4Mez+HL4viGgBfv77sFS0axbQKPdYfgZ1LoK8v6DYvcKsDWnT
         5CIGlf3AVywZZKfZkUs3PSXud/k6UbXei63f8v/a3XWoKST+acnFS6g7cKySgNE6PqQF
         4QKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573677; x=1743178477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lr1NpamvodEP6MFP3VgS0Dk87IubpsnKUE/+euMf6QU=;
        b=E3t+OEX8dwZmuUgH46zjFlvjaKhJVM7iM0oWJ9uxU12kAdvLgiln50LeEA7gDHl7a+
         jdIJCDM0so/ySQuwLj6lADqDfWsvlZoPND3AEDSWz3HAPRTwjj+i6uoBuAcUFjgkHS2j
         Yfm0ZfFoX7PTIbIjNYQ7+5iSjIlkE1Jh4yfHD4ENQrtjFZPvDNTEY0O7HAynNYZAX43D
         ekd7qiowRANZHUwbN6PCMQC78EgmVwCtuNR4j+GgD9FJ2k6H1hQ966+5N5sqXkZhPpCL
         9vLnfvMX+iUMzgOBQ5HbYrQAF9WDVSVCUSTgntzq4RWTZyUDz57PEfeuH0MF33HQpHgQ
         1jDw==
X-Forwarded-Encrypted: i=1; AJvYcCUxpNhQPPUOYpmICstzJnhuJfNpOjUlyI1/cAbBZpx8EOm1fMCG5eUmPVFyDvnOJnRLlCYzlwOpIDunPf+B@vger.kernel.org
X-Gm-Message-State: AOJu0YxsA9eC0Pu6KcXtkTHRiQRrOMU9Nxx+VwPgvrFH8lCgJPNrRnOp
	8JlH6QgEcKyj24g6RsNzEvA9QEE4RpL5VTbdrHIFWDmpIk58fb9lN8Zf2RnfraNvb9MbPMQ+MlN
	81PU2OUReWv3MuZHI47Nn4kGLNgdoV5iIe2wv
X-Gm-Gg: ASbGncv056Kq42nmipSXR2L0/g0NXNJcti27DyDIi5Yb28aUMdXQnjB62oErmSEYx/F
	itg8PT2ctC97GjIs3pLn0iLyypoM1EuUmNKSXexuhepNIsUjntq3/2PnSDkG3Whgvabf+qjOFVg
	6Ye9m/NX8o17vprshWoFmqPONqeA==
X-Google-Smtp-Source: AGHT+IFtRdtnxmYqCiNGozdyiDRgbS5XVd2/jJNIMYaa9ildizNYGE8X3N7zH+w9Lm6oeOkoQXAJJ6yRGhxNC/i547Y=
X-Received: by 2002:a05:622a:1c10:b0:476:77be:9102 with SMTP id
 d75a77b69052e-4771f510a8amr3527931cf.7.1742573676464; Fri, 21 Mar 2025
 09:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com> <20250320173931.1583800-4-surenb@google.com>
 <20250321-unhelpful-doze-791895ca5b01@spud>
In-Reply-To: <20250321-unhelpful-doze-791895ca5b01@spud>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 21 Mar 2025 09:14:24 -0700
X-Gm-Features: AQ5f1Jp8UfxX8WOnw9385d8J0NeQgt0g6OSnoez6cTxiRd2n5Bydr6rryoZB6As
Message-ID: <CAJuCfpEujbaSrk5+mR=+vWqwSu-t52fVmbPf5msnpduSB6AT2Q@mail.gmail.com>
Subject: Re: [RFC 3/3] mm: integrate GCMA with CMA using dt-bindings
To: Conor Dooley <conor@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, 
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, 
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, hch@infradead.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 7:06=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Mar 20, 2025 at 10:39:31AM -0700, Suren Baghdasaryan wrote:
> > This patch introduces a new "guarantee" property for shared-dma-pool.
> > With this property, admin can create specific memory pool as
> > GCMA-based CMA if they care about allocation success rate and latency.
> > The downside of GCMA is that it can host only clean file-backed pages
> > since it's using cleancache as its secondary user.
> >
> > Signed-off-by: Minchan Kim <minchan@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/powerpc/kernel/fadump.c |  2 +-
> >  include/linux/cma.h          |  2 +-
> >  kernel/dma/contiguous.c      | 11 ++++++++++-
> >  mm/cma.c                     | 33 ++++++++++++++++++++++++++-------
> >  mm/cma.h                     |  1 +
> >  mm/cma_sysfs.c               | 10 ++++++++++
> >  6 files changed, 49 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.=
c
> > index 4b371c738213..4eb7be0cdcdb 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -111,7 +111,7 @@ void __init fadump_cma_init(void)
> >               return;
> >       }
> >
> > -     rc =3D cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump=
_cma);
> > +     rc =3D cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump=
_cma, false);
> >       if (rc) {
> >               pr_err("Failed to init cma area for firmware-assisted dum=
p,%d\n", rc);
> >               /*
> > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > index 62d9c1cf6326..3207db979e94 100644
> > --- a/include/linux/cma.h
> > +++ b/include/linux/cma.h
> > @@ -46,7 +46,7 @@ extern int __init cma_declare_contiguous_multi(phys_a=
ddr_t size,
> >  extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
> >                                       unsigned int order_per_bit,
> >                                       const char *name,
> > -                                     struct cma **res_cma);
> > +                                     struct cma **res_cma, bool gcma);
> >  extern struct page *cma_alloc(struct cma *cma, unsigned long count, un=
signed int align,
> >                             bool no_warn);
> >  extern bool cma_pages_valid(struct cma *cma, const struct page *pages,=
 unsigned long count);
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 055da410ac71..a68b3123438c 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -459,6 +459,7 @@ static int __init rmem_cma_setup(struct reserved_me=
m *rmem)
> >       unsigned long node =3D rmem->fdt_node;
> >       bool default_cma =3D of_get_flat_dt_prop(node, "linux,cma-default=
", NULL);
> >       struct cma *cma;
> > +     bool gcma;
> >       int err;
> >
> >       if (size_cmdline !=3D -1 && default_cma) {
> > @@ -476,7 +477,15 @@ static int __init rmem_cma_setup(struct reserved_m=
em *rmem)
> >               return -EINVAL;
> >       }
> >
> > -     err =3D cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->na=
me, &cma);
> > +     gcma =3D !!of_get_flat_dt_prop(node, "guarantee", NULL);
>
> When this (or if I guess) this goes !RFC, you will need to document this
> new property that you're adding.

Definitely. I'll document the cleancache and GCMA as well.
Thanks!

