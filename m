Return-Path: <linux-fsdevel+bounces-54313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D4AFDB6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 00:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837A41722EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 22:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E222A4DA;
	Tue,  8 Jul 2025 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqNP7R7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924F1FF1A1
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015305; cv=none; b=GYJ8lA5oXjBudvvA0+pGLFyM9WijyKWHA7A+Urhi9iZbiaOXMVWh0pEGBgyrvr2Asx7IjUNxOuNx/VlaZ8fRPz10BSvTOjS4Lw0OUVTVWJvhJSRYcF+7Ik2LeM+oTl0il+IUDfPY2LKHKLbCojzn9+x9tixR9i1gwiqTtDloq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015305; c=relaxed/simple;
	bh=azscrZ4AZfsZtzg45YIlsj3hKxFzj165H2cs57Ej3pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmxZ34nSasbbVwq1waCL4wYQXHOh52aw0DiJu2JQXXE56VbqDNdE96AF6Aaci8ql3oNBsOsBJh+IHPgY5xJB0kTfzOBKJSxBSchsi723KKJfVd5PgInAoWfbg0xjazhmVHlb2vXH75TBjrLcM1R1NNOf3sCA7nmpmF+igUm48rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqNP7R7d; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235e389599fso86205ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 15:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752015303; x=1752620103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVRWLCIynL9morDWnQADm8WuJ5jAoeJ4mXqExkRmYFA=;
        b=PqNP7R7dxPjb8OCYDA3Ekph+4+7+ocyZYbekhDyYGSnFQMHSLBo/RHje24oc6svjxm
         6bGn1GgntwhkbD9opJevUa/CQNiBueEuQSUoScwmUWnEUKA6tclaPjmzGzgdcuXUnJcf
         T3QGMUCDZD+EesMN5CPGUVaG3epP47+PDCACI6JP/4eUAzdWUBr3khQsX9NXWXVpgbPA
         5JhgXGek9NmUl7Npv0hStagVTtXCY0vtYco2YavO9/EWbu6Ob/tTAdsBB/aAesCo0Zry
         hOg9Tb3f0Nj25yQU1USZIzGiAvMhuYbtJMEFAuT28qjLRqLO020c4+AkxHWKBHXPOTzM
         Lbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752015303; x=1752620103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVRWLCIynL9morDWnQADm8WuJ5jAoeJ4mXqExkRmYFA=;
        b=r0qMw31zZUyHLyu+h3ywVZFTVQjZ4tU1fpOPozBEawsX+dkQ4Poktv+GV6FfHPlbdb
         aphrvZWa9Nj/poObBu5YVd+nCheSdBimH8BrhUtak6pgbJqrCKGBlA7tzsjqyunXVzwy
         /dZZJ/zr11Mll4UJ2rjePlwyiU7UHVsbwAj7TrmI43szgoSPnfh7i8JLeSbL4H2DV3pm
         TgPGPCDJDL2E21lToTSnw/aw1ga9bAp2HU+aaUxMXTjyrZamFkX7Qe2/LDKui0wXKBlh
         Q/R/bWKtsekG1uAtClWVb9cVxzelT+7PQLIsYg8lRlGodM8iJZmZD8vsxY4uq8WRuvVU
         q1hw==
X-Forwarded-Encrypted: i=1; AJvYcCUFpxEHSaImeZhVmUe0Oi0KnkCFccoxLYnOaMhbzZ5+vSORnj7et6u/ckZTBQYX2D4BQRp9I0FCnnSoSXJA@vger.kernel.org
X-Gm-Message-State: AOJu0YwqrV3KF3iaDFF97vO+zFB22K1WtSIZ/KGR42sXEY+WIGHhcpF9
	ydMkTBQ7um4qSWwem6FgctJqJtIkrph/XflfK+015Z/tkWz3Oa/j728hMWlOcqq6+7nipd6Sfdl
	ipDyOgAxTNlXlQURi1DPNQrNb60TvWo7Z6fbeRzPQ
X-Gm-Gg: ASbGncvwkdz3srQ9s6Jjx3z7LE1cqRSWOYz29tZxTBsDdQH3fPrZ/fu53WYo9EvCiN3
	/lqaCA6BWEbG4SOwff/Rixgl05iFHuIq1sp/6F68VGxm2k2i/n5aCP5KeULtSzzGN2kUsiOU0yr
	KLKZt3a7f3SvrMAibVvtPuZ3utbg7vCmYnk0KypoQXCxpWzYuqIsQceMcVfoQm4tHxV2ZnlQuSO
	k9TTO2WIotJ
X-Google-Smtp-Source: AGHT+IFppI8EWFIKjUXPtViP+KrA09dQbTHMiXzo/hVpg329+fXbE9z6q1NN0DYucfeQOt83ReE7/FOzhTi0IjwwLl4=
X-Received: by 2002:a17:903:320d:b0:216:48d4:b3a8 with SMTP id
 d9443c01a7336-23dda3cf61dmr1101735ad.16.1752015303037; Tue, 08 Jul 2025
 15:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
 <aG1dbD2Xnpi_Cqf_@google.com> <CAGtprH-ESrdhCeHkuRtiDoaqxCS9JVKu_CC9fbDRo+k+3jKCcQ@mail.gmail.com>
 <aG14gLz9C_601TJ3@google.com>
In-Reply-To: <aG14gLz9C_601TJ3@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 8 Jul 2025 15:54:49 -0700
X-Gm-Features: Ac12FXyERUa_xOAJgG7dIrmMf4kvAAP-pOIx0wDj5UJ0uC1eIt2Bz0JJ6_rlubA
Message-ID: <CAGtprH-+gPN8J_RaEit=M_ErHWTmFHeCipC6viT6PHhG3ELg6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"tabba@google.com" <tabba@google.com>, "amoorthy@google.com" <amoorthy@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "jack@suse.cz" <jack@suse.cz>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"keirf@google.com" <keirf@google.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, Wei W Wang <wei.w.wang@intel.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org" <willy@infradead.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, Dave Hansen <dave.hansen@intel.com>, 
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	"maz@kernel.org" <maz@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"anup@brainfault.org" <anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, Fan Du <fan.du@intel.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "steven.price@arm.com" <steven.price@arm.com>, 
	"muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Zhiquan1 Li <zhiquan1.li@intel.com>, 
	"rientjes@google.com" <rientjes@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	Erdem Aktas <erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"hughd@google.com" <hughd@google.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, Chao P Peng <chao.p.peng@intel.com>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, Alexander Graf <graf@amazon.com>, 
	"nikunj@amd.com" <nikunj@amd.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"jgowans@amazon.com" <jgowans@amazon.com>, Yilun Xu <yilun.xu@intel.com>, 
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Ira Weiny <ira.weiny@intel.com>, 
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "qperret@google.com" <qperret@google.com>, 
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>, 
	"will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:59=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jul 08, 2025, Vishal Annapurve wrote:
> > On Tue, Jul 8, 2025 at 11:03=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > Few points that seem important here:
> > 1) Userspace can and should be able to only dictate if memory contents
> > need to be preserved on shared to private conversion.
>
> No, I was wrong, pKVM has use cases where it's desirable to preserve data=
 on
> private =3D> shared conversions.
>
> Side topic, if you're going to use fancy indentation, align the indentati=
on so
> it's actually readable.
>
> >   -> For SNP/TDX VMs:
> >        * Only usecase for preserving contents is initial memory
> >          population, which can be achieved by:
> >               -  Userspace converting the ranges to shared, populating =
the contents,
> >                  converting them back to private and then calling SNP/T=
DX specific
> >                  existing ABI functions.
> >        * For runtime conversions, guest_memfd can't ensure memory conte=
nts are
> >          preserved during shared to private conversions as the architec=
tures
> >          don't support that behavior.
> >        * So IMO, this "preserve" flag doesn't make sense for SNP/TDX VM=
s, even
>
> It makes sense, it's just not supported by the architecture *at runtime*.=
  Case
> in point, *something* needs to allow preserving data prior to launching t=
he VM.
> If we want to go with the PRIVATE =3D> SHARED =3D> FILL =3D> PRIVATE appr=
oach for TDX
> and SNP, then we'll probably want to allow PRESERVE only until the VM ima=
ge is
> finalized.

Maybe we can simplify the story a bit here for today, how about:
1) For shared to private conversions:
       * Is it safe to say that the conversion itself is always
content preserving, it's upto the
           architecture what it does with memory contents on the private fa=
ults?
                 - During initial memory setup, userspace can control
how private memory would
                   be faulted in by architecture supported ABI operations.
                 - After initial memory setup, userspace can't control
how private memory would
                   be faulted in.
2) For private to shared conversions:
       * Architecture decides what should be done with the memory on
shared faults.
                 - guest_memfd can query architecture whether to zero
memory or not.

-> guest_memfd will only take on the responsibility of zeroing if
needed by the architecture on shared faults.
-> Architecture is responsible for the behavior on private faults.

In future, if there is a usecase for controlling runtime behavior of
private faults, architecture can expose additional ABI that userspace
can use after initiating guest_memfd conversion.

