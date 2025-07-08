Return-Path: <linux-fsdevel+bounces-54303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B2AFD7BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA90567A83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4923D28E;
	Tue,  8 Jul 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMGwHSev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22323AB95
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004741; cv=none; b=O4yfCtGv9+Cvo9J23HK4sUwkQw86ZKJZDyVYvX2AyGuTF4ZzD8FcW2dZjENMhmTXvqQ9AKpK7SiNUHYbtzCiZWlT+QWln1gg176bwF/vCZHpHK/3AJpq2eRK4IWxJeMnJQkDwlxMvs2/2cjUqAiPphY4hUOcGRj3bBWk45JaTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004741; c=relaxed/simple;
	bh=qeaevY/WBAqE5QxM+YJ+9KYZuYqdnkSGgPZgsl4/+24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VOwxp43V4KBAZKlHNNJ9+9RJ12SPVLATwcNdwXX2RJGnBYSm/bbdjFYmb6+OgSZ4l63SXc01BuE3fgmm63aLeMfZVXXSt1czGfkuUaO+fGUTs5bS7LNM67wT/0iIL9XujnC3J5dZtowP4RtuHSISx7z2ZOQglVP65ZIKYD480f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMGwHSev; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3122368d82bso7266139a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752004739; x=1752609539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bK9rO788tLxJ4WTQcJIR4xppsNUsK51AEUh9HOz+/ZU=;
        b=SMGwHSevuBX8uNe7gV8O9YfcpuqqnWDeXaCNOcST83AMAhqcZ1XSHq9ViVw+uCImZu
         y6jO2HTl0Q3Z5v0szokGSVipKrWbC02Jy+/cQzTNlop4v3dV6KApdRmVM8lkj9xVq9IH
         yJapcaDc5QPvQZnRd4toVcrEK6LwzJXvoH0RYoyq7ii5rSFZQkeuwgrk7LTta2QTtRGa
         pu488oT8uOBeYu15u/NzlvE8MUV/tetecR38brWhYV5VRsKMq3llnnu6Rd9/OFToySN5
         cUnFC0w3wJEZ/0NBPMy9x52a6w4M0Updzosw1m0i92BS4XOAbW92bW1pfPEway0ml1bk
         ao2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752004739; x=1752609539;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bK9rO788tLxJ4WTQcJIR4xppsNUsK51AEUh9HOz+/ZU=;
        b=N1Nkwu3Fr2naBudqDs0ubMkOqFj+Qr2EDE+hmC+fOpkMwRbB+646QUwMToKdtIFY7z
         Oiq2sO2owRzZPLme3Tz0ogLE3sDAIRjnv25rNMdFH4+rOzO2yZVpDA1Moyf0g3p2tKmp
         DMaLuqTHY7uT0B8Bm4ni0O7s9g7tYPngXlP723S2Z/MbH18ODyL1XSL7LldvOakA9pRR
         b7EgJ4rKscoyWZwAZ+NMKdqRPXjIxwTxY1lnibLSDtHNymed/KNB380Hrj3AsPx9cBgw
         B4eYkfMCw/QOFWZdClhOXL0sxXgJBa5BS+blZ5ETvA1r9sISEUJBJ44VyX/FPlf6Hhom
         zS8A==
X-Forwarded-Encrypted: i=1; AJvYcCVfYCDLpKfoMi6rAMewSqZcDksPzfkCcFvaQABLG2zFW0GA5tRCp5W2AEzgd+0mvwC/7s7M6Eb2gXUqT75U@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7COKVRPdJEwxK5+h6lGV5vvXsIxdUD1594NipdbQfOkPYfUW
	pTnnlhKx2UFHwx3pyweMee0voqS7FAMgYWWn3urEdG4FcOKO/6WwwIT1o4kDsSpaGvHIynCiaac
	xQkSTxw==
X-Google-Smtp-Source: AGHT+IFkETqYRl85TaDCY+mhRsKj3yh+DlVRrd5kJgA8yrUlr1VJNZkXzaK8N5MZ0Opd+f6mnf+G32B45Fc=
X-Received: from pja6.prod.google.com ([2002:a17:90b:5486:b0:2ff:84e6:b2bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f83:b0:311:df4b:4b94
 with SMTP id 98e67ed59e1d1-31aac432a89mr24009325a91.4.1752004738302; Tue, 08
 Jul 2025 12:58:58 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:58:56 -0700
In-Reply-To: <CAGtprH-ESrdhCeHkuRtiDoaqxCS9JVKu_CC9fbDRo+k+3jKCcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
 <aG1dbD2Xnpi_Cqf_@google.com> <CAGtprH-ESrdhCeHkuRtiDoaqxCS9JVKu_CC9fbDRo+k+3jKCcQ@mail.gmail.com>
Message-ID: <aG14gLz9C_601TJ3@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2025, Vishal Annapurve wrote:
> On Tue, Jul 8, 2025 at 11:03=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> Few points that seem important here:
> 1) Userspace can and should be able to only dictate if memory contents
> need to be preserved on shared to private conversion.

No, I was wrong, pKVM has use cases where it's desirable to preserve data o=
n
private =3D> shared conversions.

Side topic, if you're going to use fancy indentation, align the indentation=
 so
it's actually readable.

>   -> For SNP/TDX VMs:
>        * Only usecase for preserving contents is initial memory
>          population, which can be achieved by:
>               -  Userspace converting the ranges to shared, populating th=
e contents,
>                  converting them back to private and then calling SNP/TDX=
 specific
>                  existing ABI functions.
>        * For runtime conversions, guest_memfd can't ensure memory content=
s are
>          preserved during shared to private conversions as the architectu=
res
>          don't support that behavior.
>        * So IMO, this "preserve" flag doesn't make sense for SNP/TDX VMs,=
 even

It makes sense, it's just not supported by the architecture *at runtime*.  =
Case
in point, *something* needs to allow preserving data prior to launching the=
 VM.
If we want to go with the PRIVATE =3D> SHARED =3D> FILL =3D> PRIVATE approa=
ch for TDX
and SNP, then we'll probably want to allow PRESERVE only until the VM image=
 is
finalized.

>          if we add this flag, today guest_memfd should effectively mark t=
his
>          unsupported based on the backing architecture support.
>
> 2) For pKVM, if userspace wants to specify a "preserve" flag then this

There is no "For pKVM".  We are defining uAPI for guest_memfd.  I.e. this s=
tatement
holds true for all implementations: PRESERVE is allowed based on the capabi=
lities
of the architecture.

> So this topic is still orthogonal to "zeroing on private to shared conver=
sion".

As above, no.  pKVM might not expose PRESERVE to _userspace_ since all curr=
ent
conversions are initiated by the guest, but for guest_memfd itself, this is=
 all
one and the same.

