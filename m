Return-Path: <linux-fsdevel+bounces-54576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21AEB00FC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDFF761B27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA57D2BEFF3;
	Thu, 10 Jul 2025 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ica1XMWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE441FBEA2
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190412; cv=none; b=QgP1or+MPubn58VeG8pCxEBUXJXA0nf2uqV/XFu64FaOwuzw+OmWrETCjbxCZtx+pEAANzYx9IwI978bnQHotqjjffQLdoDiMYYUAk3hq39aCmekBADuw6a8bn/3LHNcjR64/a4Hsr9ysbvj7nQjTHSPaf26OyMuagWIaNKxtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190412; c=relaxed/simple;
	bh=fs/stzFOkuNqoivUoaT1zQiwHUcb7MvE90+6wUsGHiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmxpE+vr1Q7bZJDd5TBin/wqTVgUmxU2HNqJxQVUoDlrMGjDIJij6H86UUdASDX2IeBXF7NuKYMDssw4V3Uj4cVd9dQ+SdnA7Rq27kciosgILUs5z2OJWZFq6TngEo3z36qFMFvQA+kJf5JFDmEpMOqpQV1wk9kRcl8ldmc2i+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ica1XMWk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so1478778a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752190410; x=1752795210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xMGtELqGDIVKylpj3gkVi9KRmy7ceHP1p00FimnrPg=;
        b=Ica1XMWkCzYcBkJEr0u3ixopYfpMkzZlafhw9nFOZuU+u76A5nunV8D92YHzAhbNPs
         XaDxvgU0X74Xxo/q7aRyoGdnjjUpAa2eRYYzEuwmLiLI0IZOYhd1KiiuR7mKbFaNe19Y
         vXU8ohrTiIVx1y/KcREPbO5rIpNlKHA1N5bgSJr0rg+liRvBkaF1GCd/f95TR8sdKk6p
         Pg9cy0lDRoUTQPvvk2dPETWknEVCuqyVlbWdb5u45tuP2pzw6XcgAxbNe4nV3XRoR/zT
         pZUYhTKJUaBdV8y/OPerVz/8ffo7VVCiO67v41pPEGRIiRv55KmC0PG5iyXBfV3grTv2
         2vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752190410; x=1752795210;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7xMGtELqGDIVKylpj3gkVi9KRmy7ceHP1p00FimnrPg=;
        b=WBRhrkoudbPtHLJBpzPeNvPdIw+Dul/WCsjs92iE2Cad2GzLWhB5Sn8SjQMGwHiGOn
         WiHhQ3U0QBSOO6o/TnR9SJCHB81YRORx7N/0nrslb9XofSl35oX4xniqCtzzQ7tllX5z
         fIsU+hRjQv4mRoIe/kmvLZMJS8H7gMaUwkEZ3qC/Amwq3teV8muNNP0GbcBmUlVzBbfi
         H12cl2J2mk0jSI09VPFyVAd8HrdQegqnRs6uplqEzrgZ33XWL3/BE/2zRbmtn+OYB9jI
         6UvG4A8hgnC3mTP4EA9DjRmP8g500S1+pTfe6Xp4JptidT0I8aRc3Ga7ukZXaspD9IUh
         YXhA==
X-Forwarded-Encrypted: i=1; AJvYcCURBFWeuegKOSD/AXWemZU2SDwY4PdIlpXUOEP6WOkBdFxq0P4bLPPbkb4G1i1Od05/6u329dTfBq//gllI@vger.kernel.org
X-Gm-Message-State: AOJu0YzJn90e7HKyu3aTYgXaFJGxrN9bU9AN4S+m4NLTTBbkLd3OniDc
	CaPFFet/+gIL93HG/SHRyXBD1c0Osu3AjTWlT8znxW33OwIWZLzUIKJThopOZJ9z7jUFw9VOPGz
	zHfpuhw==
X-Google-Smtp-Source: AGHT+IEjkpnTRHviySEJP6oNLJNYcaCJfnt+ly8nM389x4kL3s2cpQb6nNjPDRQ5qUt24OyTevtzQci/lmQ=
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:312:ea08:fa64])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e4c:b0:30e:5c7f:5d26
 with SMTP id 98e67ed59e1d1-31c50e2c4dcmr205822a91.24.1752190409836; Thu, 10
 Jul 2025 16:33:29 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:33:28 -0700
In-Reply-To: <CAGtprH_DY=Sjeh32NCc7Y3t2Vug8LKz+-=df4oSw09cRbb6QZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
 <aG1dbD2Xnpi_Cqf_@google.com> <5decd42b3239d665d5e6c5c23e58c16c86488ca8.camel@intel.com>
 <aG1ps4uC4jyr8ED1@google.com> <CAGtprH86N7XgEXq0UyOexjVRXYV1KdOguURVOYXTnQzsTHPrJQ@mail.gmail.com>
 <aG6D9NqG0r6iKPL0@google.com> <CAGtprH_DY=Sjeh32NCc7Y3t2Vug8LKz+-=df4oSw09cRbb6QZw@mail.gmail.com>
Message-ID: <aHBNyEabRZVp7vtl@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "tabba@google.com" <tabba@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "maz@kernel.org" <maz@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, Wei W Wang <wei.w.wang@intel.com>, 
	Fan Du <fan.du@intel.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, Dave Hansen <dave.hansen@intel.com>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "fvdl@google.com" <fvdl@google.com>, 
	"jack@suse.cz" <jack@suse.cz>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, "willy@infradead.org" <willy@infradead.org>, 
	"steven.price@arm.com" <steven.price@arm.com>, "anup@brainfault.org" <anup@brainfault.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "keirf@google.com" <keirf@google.com>, 
	"mic@digikod.net" <mic@digikod.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	Zhiquan1 Li <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	Erdem Aktas <erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hughd@google.com" <hughd@google.com>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, 
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
	"brauner@kernel.org" <brauner@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"hch@infradead.org" <hch@infradead.org>, "will@kernel.org" <will@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025, Vishal Annapurve wrote:
> On Wed, Jul 9, 2025 at 8:00=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Wed, Jul 09, 2025, Vishal Annapurve wrote:
> > > I think we can simplify the role of guest_memfd in line with discussi=
on [1]:
> >
> > I genuinely don't understand what you're trying to "simplify".  We need=
 to define
> > an ABI that is flexible and robust, but beyond that most of these guide=
lines boil
> > down to "don't write bad code".
>=20
> My goal for bringing this discussion up is to see if we can better
> define the role of guest_memfd and how it interacts with other layers,
> as I see some scenarios that can be improved like kvm_gmem_populate[1]
> where guest_memfd is trying to fault in pages on behalf of KVM.

Ah, gotcha.  From my perspective, it's all just KVM, which is why I'm not f=
eeling
the same sense of urgency to formally define anything.  We want to encapsul=
ate
code, have separate of concerns, etc., but I don't see that as being anythi=
ng
unique or special to guest_memfd.  We try to achieve the same for all major=
 areas
of KVM, though obviously with mixed results :-)

