Return-Path: <linux-fsdevel+bounces-33338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559C79B7901
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 11:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192F5285ABB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57673199FA7;
	Thu, 31 Oct 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB4+0v/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245B13A25F
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371868; cv=none; b=TDIZADvgwlokzb9YY9QBS7dIzCq1zcoESGFFrcOpz5Hq+INm5eprN0jVdfCjE4e9QuMqEJgoZtyFvs5wNKtbqPpQzdKCSeLk68SgnlwQsmtDhpcNX0egPs03YM/6DSDjUyq5zMT8rsjTgL+A3NPn0CY3IhPNwaIHyo2yaHl815U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371868; c=relaxed/simple;
	bh=uh9+w29J7T5ImrWhnSAaEfztZF7N3Bb4bZAX+Lkmx1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOEV1Vf0wHtIXQIcdgpS+ILm3fEu+ESnzAaUVi838IV7fmBItYkSBb9uFrsTfv4Rqpb7aEH0J2w2VW3ZNkdDFXUiy1W947MqMFdscREQlJdiIXVTVPv4u2RwtYphzFEXh860pG74Rhlt/9ZomSKgd+L6wmNc/5zbSTO6ewPI3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cB4+0v/k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730371865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AXLe6BNzWvyIS2X556SHcAm5RhCKXQ2/dARiTIO1wE=;
	b=cB4+0v/kbOCKqnRBDxeJfrXNfafKGEIVwUuhqJK844Wc38TOD7x/6G0iCy9PGy+8d/g9ov
	gH68u9cIYNJ6CPVGJQC8WDJ6JMoRYoxxvNZ/fGHsqvd8ZRK3nMTqMrNh9tf+HCqoZ19cNk
	oov31ylY2Ffn0DDS26jt20yBgxL6v0I=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-OiP80DIHNhGEOuKTfJgsUA-1; Thu, 31 Oct 2024 06:51:04 -0400
X-MC-Unique: OiP80DIHNhGEOuKTfJgsUA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4a48cd8d3e5so302405137.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 03:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371864; x=1730976664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AXLe6BNzWvyIS2X556SHcAm5RhCKXQ2/dARiTIO1wE=;
        b=w/nsiR4cd16c6qCK2dlPl/38glUS3fB36vCIwvfP5MJIveiH8nRCxfNWvJuZtnaeBo
         XBL/kl57D8IPdRpn1KVVF+6Wh/bpT6OxSDk9421FxsBaCkWJRJ8e13t/eyzete5+MN8t
         pfjqafq499FXitUIIqChSLO6qSUUb7O6sUOsiuKHC7nWvFBdHcnTBM+X1Ea7y/kmvsiI
         DPsoICOo/xVVAIOP8N2TERu8KfNZWu5PmYojROHxD4wjpDtTqYVG9JeYwIknB45tzmHz
         ElPu71D18bnA7LvGZgSVht3zYWYmT5+mx/ND0/d5PP6gx3GDsNyVUO3HyGLMRSPu5iXn
         JIpA==
X-Forwarded-Encrypted: i=1; AJvYcCVPrA77fqMDwE/Q1Q4X2ICzNjsfuYoL7YEL+Z2Es7y0fMFdt2ehNYcYJ1nNPHPBB3mtT0Cg4reYBkmvOfZP@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNfDDbWQL7iooyIKrfBoCSONjvET8IF2R+lvNNBUzjOZ3SOdq
	bAL26r6+xVPv7GrF+eFg90h7rJfeDkEaDaMf8ruv0wbq+/YtI4uEMroy8yRlMMrBlya/We4iWQE
	BlgxzNySO0irYotXfCVOW/YQn5/Hz2tj21Lepeu+5FQ1OayeELTSoth9GR91ZmZ6HV/HThH3Z3W
	TrlZ83XgigSBIAGUc8Tfape6g1FHShtLOFt/Oetw==
X-Received: by 2002:a05:6102:e0e:b0:4a4:72f0:793e with SMTP id ada2fe7eead31-4a95437210amr3812152137.20.1730371864239;
        Thu, 31 Oct 2024 03:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwfzEyODsd5Ja8ZyzC6TH+ukrerObDa1tg1mi7WbgzDduWTc2C+QNy9WoO6WjMViQRFfbhvhDuBNxMti+84S8=
X-Received: by 2002:a05:6102:e0e:b0:4a4:72f0:793e with SMTP id
 ada2fe7eead31-4a95437210amr3812123137.20.1730371863840; Thu, 31 Oct 2024
 03:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
 <20241031074618.3585491-2-guanjun@linux.alibaba.com> <87v7x8woeq.ffs@tglx>
In-Reply-To: <87v7x8woeq.ffs@tglx>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 31 Oct 2024 18:50:51 +0800
Message-ID: <CAFj5m9KZRjupM+bsuc-r_kTu1h8+wtc_fdmkHWS=cNbg4aU03g@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/2] genirq/affinity: add support for limiting
 managed interrupts
To: Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Cc: Guanjun <guanjun@linux.alibaba.com>, corbet@lwn.net, axboe@kernel.dk, 
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, vgoyal@redhat.com, stefanha@redhat.com, 
	miklos@szeredi.hu, peterz@infradead.org, akpm@linux-foundation.org, 
	paulmck@kernel.org, thuth@redhat.com, rostedt@goodmis.org, bp@alien8.de, 
	xiongwei.song@windriver.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:35=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Oct 31 2024 at 15:46, guanjun@linux.alibaba.com wrote:
> >  #ifdef CONFIG_SMP
> >
> > +static unsigned int __read_mostly managed_irqs_per_node;
> > +static struct cpumask managed_irqs_cpumsk[MAX_NUMNODES] __cacheline_al=
igned_in_smp =3D {
> > +     [0 ... MAX_NUMNODES-1] =3D {CPU_BITS_ALL}
> > +};
> >
> > +static void __group_prepare_affinity(struct cpumask *premask,
> > +                                  cpumask_var_t *node_to_cpumask)
> > +{
> > +     nodemask_t nodemsk =3D NODE_MASK_NONE;
> > +     unsigned int ncpus, n;
> > +
> > +     get_nodes_in_cpumask(node_to_cpumask, premask, &nodemsk);
> > +
> > +     for_each_node_mask(n, nodemsk) {
> > +             cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk=
[n], premask);
> > +             cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk=
[n], node_to_cpumask[n]);
>
> How is this managed_irqs_cpumsk array protected against concurrency?
>
> > +             ncpus =3D cpumask_weight(&managed_irqs_cpumsk[n]);
> > +             if (ncpus < managed_irqs_per_node) {
> > +                     /* Reset node n to current node cpumask */
> > +                     cpumask_copy(&managed_irqs_cpumsk[n], node_to_cpu=
mask[n]);
>
> This whole logic is incomprehensible and aside of the concurrency
> problem it's broken when CPUs are made present at run-time because these
> cpu masks are static and represent the stale state of the last
> invocation.
>
> Given the limitations of the x86 vector space, which is not going away
> anytime soon, there are only two options IMO to handle such a scenario.
>
>    1) Tell the nvme/block layer to disable queue affinity management

+1

There are other use cases, such as cpu isolation, which can benefit from
this way too.

https://lore.kernel.org/linux-nvme/20240702104112.4123810-1-ming.lei@redhat=
.com/

Thanks,


