Return-Path: <linux-fsdevel+bounces-54268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20001AFCE8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623B117301C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AA22E0402;
	Tue,  8 Jul 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHjVpuf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435B1A288
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987257; cv=none; b=UaTHCl20EgPxOfEMi1AVvAd4aftHhpPTrPDFsuziCvZQ24aFnfZO7f+O7WudTy10RZTgd6m+3ycPruvdHFvTgoSatdP3CxKgzWAbp//4DI15rMmsUN1I2GGIGYhdODlhLG/7P5CVJMJBbPL0z7iRTOCA4raDaeDT2MfJsEHrh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987257; c=relaxed/simple;
	bh=UDTePPJ2bt3HMQ0XzALt65MdBZZ4FaYxytWDJevgOF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrubKEhXW3b5vrdMsM5VhXPsjZFSI2iRV02dxwXEoh0Y/kaOeFnYxXFpFhpBnaPOlWgaCDlp7W9mlLO2cPyz1zJknUA3lOhWNQAP5K/ZAF1VYOIkNhyW3bBZrNyYJvfjHW2lWgy00kHgcLgROS05Cn/oVQPAn6bPhM4d1nLU3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHjVpuf4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-237f270513bso167155ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751987255; x=1752592055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nyvefvRT1ifEMjTDz+E8UGUMF05RlH54ohMwb6CW+w=;
        b=zHjVpuf4c/1sCQj8wsxCw5ggN/iCs0Hy3hwmd50byaXEcJfjIKgdw7WKerlNYVisMA
         u2pwcrR8TYyEHH2TWEwxnZYaScUnFqLEyi03m0pfobFg3hIY0ocqkYQg/JK5rp0eAmhA
         7tEm0kXVdDCbQpVHHpJsP/41RKmydBxRNOvb0vwecDJ4g+ARkxqhrLPqhqLf8ePOmYEi
         zUaV/9bMti4isO6HxSIvv/3K6fdCCeUJ28XP+h0ftdwxUMe5IpQfcM81AUNgoKWLp632
         Z4G4WXC6n0g2wc+BvgPAbCQmqrUL3wssjKiVAOGwtO77uejYgobKLxgXDxCee1h5mieh
         2ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987256; x=1752592056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nyvefvRT1ifEMjTDz+E8UGUMF05RlH54ohMwb6CW+w=;
        b=gqzlEFe0FvLQQYXgp2rqwh7TTlhoZ3o8gakFVTEFwi5U11aABY4XS8rQc6hggZInNC
         4t/sscWT1b4U93b5Fo9Kndp0oVFshDLiNxwpp8f8c+c/8yQE5AHQOO30DsSopwG0Xvor
         nZXoS2h1HcdsB63ry2mAKqzKQWfVjFMXYaOSCIHJfoE1OX8bDyRioLqPgHmFF0tjvOKd
         x9KkDqcBwY91Rs8EJFCiMIQDzSYlQF7ztk8C+zypSs7GWQUWNqGj7Ts/mTJMtMIkxqWr
         dyvjsRnvrPlnOMJOG3SSfJMoN7j8wli+H/qfmbqx/JCuBlwCsQGO7YR6kGhIA0JPB6AX
         5jog==
X-Forwarded-Encrypted: i=1; AJvYcCXyL7cHhxzm7FoFvgatbc6KH7x4dhBj/n7bBsCIWPFzPWFQ/ScdziVEQ4s7zAIxurvb7uH6In+XcpD3XGLu@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSgnt948uR+2k3Q4ltbgtZ0+CA5k3kmluIbJfXbY04dv1D9Hb
	nKMagZy90AT7oRTz07SNe3QBCA+6x8r2Kykva3OXKp3dJ0AN4zLwunjg1FRqr3VsSV9PUL1w9Xo
	2H5qCgCAKV2iVp7le5GLLSN+gbwJRUFEca2+X2YAk
X-Gm-Gg: ASbGncseaBr3oFs4LghR8ytGmz+Faq9wuHPBynF9WOClzbXWjZwF0uMfX8U20/+dG45
	OjSySlhthWCqJo7TShXUT9Go7pRrpsDeK3IrpPi0enQgUU5bvyGneSwJ+mXSrNpzL5GmOpak0Kh
	w9rASGGrBSsHN+GORo02W3OVMY1z3IbVgy5OGq4Oqz0RSn6tm3zsobhPnBiGvszIzS71gpb6w+J
	zY=
X-Google-Smtp-Source: AGHT+IHIHHkHM+0ytvtoo9gUGofMfuGgGK5gNtq9SZQvZT1yBIy3HUvKR5IUQIruCWxnjDFBfqSG1DsuCiLM4veiAFQ=
X-Received: by 2002:a17:903:2b05:b0:23c:7be2:59d0 with SMTP id
 d9443c01a7336-23dd44dc8e3mr1779615ad.23.1751987255137; Tue, 08 Jul 2025
 08:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com> <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
 <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
 <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com> <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
 <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com> <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com> <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
In-Reply-To: <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 8 Jul 2025 08:07:21 -0700
X-Gm-Features: Ac12FXyt1XBYeRNZAiYKl1SDg7f_kwaXaQfE6hgO1iEl8fFY0RcZlRb8c6vqHzE
Message-ID: <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"Miao, Jun" <jun.miao@intel.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "jack@suse.cz" <jack@suse.cz>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "keirf@google.com" <keirf@google.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "Wang, Wei W" <wei.w.wang@intel.com>, 
	"tabba@google.com" <tabba@google.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org" <willy@infradead.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"fvdl@google.com" <fvdl@google.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"bfoster@redhat.com" <bfoster@redhat.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	"anup@brainfault.org" <anup@brainfault.org>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, "steven.price@arm.com" <steven.price@arm.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hughd@google.com" <hughd@google.com>, 
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, "Du, Fan" <fan.du@intel.com>, 
	"maz@kernel.org" <maz@kernel.org>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang, Kai" <kai.huang@intel.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"Peng, Chao P" <chao.p.peng@intel.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"Graf, Alexander" <graf@amazon.com>, "nikunj@amd.com" <nikunj@amd.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "jroedel@suse.de" <jroedel@suse.de>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, 
	"Xu, Yilun" <yilun.xu@intel.com>, "liam.merwick@oracle.com" <liam.merwick@oracle.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, 
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"Weiny, Ira" <ira.weiny@intel.com>, 
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "qperret@google.com" <qperret@google.com>, 
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, 
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 7:52=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2025-07-08 at 07:20 -0700, Sean Christopherson wrote:
> > > For TDX if we don't zero on conversion from private->shared we will b=
e
> > > dependent
> > > on behavior of the CPU when reading memory with keyid 0, which was
> > > previously
> > > encrypted and has some protection bits set. I don't *think* the behav=
ior is
> > > architectural. So it might be prudent to either make it so, or zero i=
t in
> > > the
> > > kernel in order to not make non-architectual behavior into userspace =
ABI.
> >
> > Ya, by "vendor specific", I was also lumping in cases where the kernel =
would
> > need to zero memory in order to not end up with effectively undefined
> > behavior.
>
> Yea, more of an answer to Vishal's question about if CC VMs need zeroing.=
 And
> the answer is sort of yes, even though TDX doesn't require it. But we act=
ually
> don't want to zero memory when reclaiming memory. So TDX KVM code needs t=
o know
> that the operation is a to-shared conversion and not another type of priv=
ate
> zap. Like a callback from gmem, or maybe more simply a kernel internal fl=
ag to
> set in gmem such that it knows it should zero it.

If the answer is that "always zero on private to shared conversions"
for all CC VMs, then does the scheme outlined in [1] make sense for
handling the private -> shared conversions? For pKVM, there can be a
VM type check to avoid the zeroing during conversions and instead just
zero on allocations. This allows delaying zeroing until the fault time
for CC VMs and can be done in guest_memfd centrally. We will need more
inputs from the SEV side for this discussion.

[1] https://lore.kernel.org/lkml/CAGtprH-83EOz8rrUjE+O8m7nUDjt=3DTHyXx=3Dkf=
ft1xQry65mtQg@mail.gmail.com/

>
> >
> > > Up the thread Vishal says we need to support operations that use in-p=
lace
> > > conversion (overloaded term now I think, btw). Why exactly is pKVM us=
ing
> > > private/shared conversion for this private data provisioning?
> >
> > Because it's literally converting memory from shared to private?  And I=
ICU,
> > it's
> > not a one-time provisioning, e.g. memory can go:
> >
> >   shared =3D> fill =3D> private =3D> consume =3D> shared =3D> fill =3D>=
 private =3D> consume
> >
> > > Instead of a special provisioning operation like the others? (Xiaoyao=
's
> > > suggestion)
> >
> > Are you referring to this suggestion?
>
> Yea, in general to make it a specific operation preserving operation.
>
> >
> >  : And maybe a new flag for KVM_GMEM_CONVERT_PRIVATE for user space to
> >  : explicitly request that the page range is converted to private and t=
he
> >  : content needs to be retained. So that TDX can identify which case ne=
eds
> >  : to call in-place TDH.PAGE.ADD.
> >
> > If so, I agree with that idea, e.g. add a PRESERVE flag or whatever.  T=
hat way
> > userspace has explicit control over what happens to the data during
> > conversion,
> > and KVM can reject unsupported conversions, e.g. PRESERVE is only allow=
ed for
> > shared =3D> private and only for select VM types.
>
> Ok, we should POC how it works with TDX.

I don't think we need a flag to preserve memory as I mentioned in [2]. IIUC=
,
1) Conversions are always content-preserving for pKVM.
2) Shared to private conversions are always content-preserving for all
VMs as far as guest_memfd is concerned.
3) Private to shared conversions are not content-preserving for CC VMs
as far as guest_memfd is concerned, subject to more discussions.

[2] https://lore.kernel.org/lkml/CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gC=
iDS6BAFtQ@mail.gmail.com/

