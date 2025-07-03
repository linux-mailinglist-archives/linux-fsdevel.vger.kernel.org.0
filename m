Return-Path: <linux-fsdevel+bounces-53751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4075FAF6704
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8181C44D56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E314B08A;
	Thu,  3 Jul 2025 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYoduaEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DDF142E67
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751503976; cv=none; b=HDubw5GZFE8F8rl9b68bIyqRqz6bUu8oujuAH+i/cEvy9bw5TfftPdpUYvdT+Z72cNTS+ipGmBmXr/UbFq+iLCcKN1sGqE/fcdxNLxTaNP3IrTBLNY228WHrzbMyhGvQFcTcIZFqleCLi4gg8ha4g5RLd9zah/hmbr/j77TV1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751503976; c=relaxed/simple;
	bh=3ip6s+5sm9dgYNEHV97RoKIsPdbndT+Fx9GX9Wu0fbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqgsKhrVXBwTrCGI3gpTn+XDtYvMTcMi43Vn0GaQOCG7ghzo1GbIWtdGJDtNtgmNo7iDMdZf5tqLdD09PoBkT6om0sGVM7IuYGeD1NkQRk4NNICF9KaRdyFTTbRbaGSlaenFB1z2y6pjJwYW3mi0zGUS9jb0qnBIAr9J40KDkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYoduaEe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2357c61cda7so48065ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751503974; x=1752108774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgLz/FoYLsgVHZArlQZ88/AwsvSWB8vESjOZVh7NJ98=;
        b=jYoduaEeK/PBIiL5Bl7n/FNYxDTirSL1kXJ72w9kYVWOCGuxAfXYZcetkcS6sAfNpq
         D28CMPrusB8oBfc634H8YpW1YMu1oVVEbAfvKxX0l92Uy737eZhrChz4C2tLJUK3oz45
         AginuNhBDBWVZzXHKn2PfKxh6dECZMB0tZbccrWjgsUMlM0V0CSMjgYqJUL5dx85AZbk
         gA38JpCEDLailiqEcNVDRVseNBdpXaWGQMAsIVL+4/PKwyjoMgTfvH9vzWz32VONnW7B
         4oqxMQQ9TgvkiwxOSMEnqpcgg4GLEo4Ty/5bXKFmHZOVkSYWZfUP/Azh15MYZyeriXrJ
         IOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751503974; x=1752108774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgLz/FoYLsgVHZArlQZ88/AwsvSWB8vESjOZVh7NJ98=;
        b=FPIIdsx23jhP/wYNavUhLvXn5RwsTR0obQtygN0GkkfIvM8n/AbpoQA0kMoAIDWsc1
         M9Cla+kZSyINXVaeo5pM9Xzd/mKGnMZ240nHoh66NpyMEsSFZZA2nMav2+lQTICH1ePQ
         7G1L+27zNMQe3ng4t5E74gkhhFfkQzLFOv+6AQDN9BAvID6xcaNVShEFO+zQy7pNAXtL
         YCt4vvwrUbqF+DfUbEWFeZ9q3rtQkENRJ0tR1B6C0KjB/+HPh22B3/PDYlL7VgOfdUBP
         oWhURe3IPCwfoUqb/3TvbGREbt6VU4F8DikPtf39rjrQGZjD6GvLftS+xJdI578dZg0O
         jNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHkZoX8yamaXXlkz1fplyFo5s8cLGzbcKbsOWhmtSKrWhEDITAwXwYadIwIDGxgLkCNkAFmDpI2tqHTi1V@vger.kernel.org
X-Gm-Message-State: AOJu0YzH2ab/fZnO/1HzQWZjJheSE3EfroU5SIQxT98YbrGa37+RnQkw
	rhpGq7zcopXP420ev42dj6N+DA1AGGQEiNOhdaClB1gaU8uso4lqi9lk2Ni8/CSABpbjUlXUj9N
	CbQbLmwm73rtoeqEmQ5RUQKRgbQ8kw3QLkRJnd79X
X-Gm-Gg: ASbGnctZ/6jR0ujLw5WwTpur99HLGywO+ICNwmYRHGYzLjJM9qmjBZ/ibZXyvqXPvsr
	+UeKg6nXQLPk3B04fN69m0w0/XRW+bRSmykjTvwu2or42LYLJ4ksKxhABY4TaMDYZUDRjYY2mdl
	9KuW8GNosUYPBMRPvsUglexCUJSAPDHVXYcx5I6loaiNuRh0Kqap2MpUm+ZIgFL2hc4yEBlrPX
X-Google-Smtp-Source: AGHT+IG198J5XmfSPZMitL9d3FcAbULBcHuVy8v8Ee5QkIR46tmXRRtU6UF3dkNRuVzPV1IlHaErLL6ia9hlIQfVVi4=
X-Received: by 2002:a17:902:e788:b0:216:4d90:47af with SMTP id
 d9443c01a7336-23c7ac47467mr572075ad.29.1751503973594; Wed, 02 Jul 2025
 17:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com> <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com> <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
In-Reply-To: <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 2 Jul 2025 17:52:40 -0700
X-Gm-Features: Ac12FXxF97bn5vvTfJb7Vj8yqVTPgeruSo8qM9fM404AQ465bIDQRHsCOPgG6vA
Message-ID: <CAGtprH8xZLqx514XxvNSb2PfK53zGiCP9ARcbv9rbpF=OpBaRg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, 
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 5:46=E2=80=AFPM Vishal Annapurve <vannapurve@google.=
com> wrote:
> ...
> >
> > 2) There are some use-cases for HugeTLB + CoCo that have come to my
> >    attention recently that put a lot of weight on still being able to
> >    maximize mapping/hugepage size when accessing shared mem from usersp=
ace,
> >    e.g. for certain DPDK workloads that accessed shared guest buffers
> >    from host userspace. We don't really have a story for this, and I
> >    wouldn't expect us to at this stage, but I think it ties into #1 so
> >    might be worth considering in that context.
>
> Major problem I see here is that if anything in the kernel does a GUP
> on shared memory ranges (which is very likely to happen), it would be
> difficult to get them to let go of the whole hugepage before it can be
> split safely.

The scenario I was alluding to here:
guest trying to convert a subpage from a shared range backed by
hugepage to private.

