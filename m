Return-Path: <linux-fsdevel+bounces-54293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F36AFD699
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 20:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDEA18886DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13FA2E6D1A;
	Tue,  8 Jul 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yC39OMey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF621F0E55
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999919; cv=none; b=cGLEl7vPob9EaaMBve4FLuJHNkDNukdbG1gvNxLdhZklRAI++497yyQesAtcoBRg4dmNOIqKfLS60zr9WsEMv5UaaKjGbOBi+ReFVrEBwAJ5AdBHiFh2Z0zGIfx9TJWMPPlZ2c3LDiM7r5Y3p/eaiehRoCyPoBAIq3f8rBrOPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999919; c=relaxed/simple;
	bh=2+com1G9ZklhZ2ukEIDRDdsjQqkHF0dZ5BYb3p3/qWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCWgCXJyKMGx/GV/aD8TyZ8M4Ky5pN21mxCZzxvre5tSy03SFsFqj9wm0A3HwAbxLQADx02NoaXtr8Spync9kdQOBai4t/z1kF1EUfSr1ESZ8Wb0KbmDq1z3xfhoeO0jwiFbAsDlN+cN0FRFABM9ePW6mKAT9bywNcgm5te/XB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yC39OMey; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a5ac8fae12so80641cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751999916; x=1752604716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SK7lrk7xIi5tD0jrlmCDVWKn5xeGvg9C1giWU24k6Z8=;
        b=yC39OMeyIme6C4XODHCpRbKE447Yhf8dA/sj/xmnfDyxg9nebtQhlFnp5BcMhNZR47
         OmT2BPBeEu+9l16Ue+NOdprRoU9/r8thwQhCKZxQ+alDBERQXK00t5hp0xL1qfeW5G6J
         +2PkHexZAHy1kBGvgW6GfK17QOcgF+YSSLc0AOmrZZfZgxMAb+obR0COFkLd7iPhTrTs
         h/2puUpxqJYIMwn+WJ9ZMV0O95i4YbdAYSDu5YA3JQysH36gPGov87qj1adPzi2yXbEH
         wOct00xozj5Yy3vOTG6tpMQ653DsIe028S3+a01Sw09ydDG3WjIIHAlxO1K4SYceNtWG
         hEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751999917; x=1752604717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK7lrk7xIi5tD0jrlmCDVWKn5xeGvg9C1giWU24k6Z8=;
        b=JBJ1DWqWbFbLTvTevoqCQJ1fh7ZeXpUfSXjDGKtUNEnr+0CwcVl5X0Wg3L1QZiFNhN
         oUYEq0s8fSi2S9pf0sl2Mksug4i5ytwJrveXhtP6sOV+Lt0GAGd018ClyTOrE2APGvO5
         criLyVaku1dVVm8gRkKAirTLqXuZYoFKkDUEY54b/te4FvQptH/PXeVP4Wza6lkUNV+m
         Q2CGgNHOdeR5p5bBdMj7NsIwo3rH9p0le/jv5m8QV6ek8igeezF7G0DteseopWE3nlwg
         NJjnj/ThWw68p19BM+vJYNHOg/B24IUERmG3s4Bcfe5TSDlvYtSLSX36lGLUPuKDg+BX
         AmRA==
X-Forwarded-Encrypted: i=1; AJvYcCUjFJKcgfzKBEN2ioNI60Ez/1aSbF4x49nioMCfAturXj9p/KeiiVMpvFtdXG02vlhblWFiNLzMT1MnpTdH@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkDBnmwuduW74nL9C/NxIab3lohZ8nrHc/XGpcydOP7mRgUVV
	ceLOMZtOgRSeD6amdbncCNbG4Ue8IP9sqE3qW/4us7j+o7d3brJyfxc8d9v5SugUmB2VBZD1xRP
	NtccRhEghllUfAqOwqa8NM266WVFdlLrUSG0H05Ql
X-Gm-Gg: ASbGncstEKsx2ZlX/VCmtlK2nB01bIvW+cOUoSw2RBq3NwFoiCM9SRSqFF/ZxWV+S7l
	C/M3Zu7tx63+n0cRjbzBT89D3Zjog/PVXfTujeNurfRgwZI0TSg8cUgbgnClp8hgqQnWyWlobBt
	GwmeISGtgomxtVm0Fg5NtmbxgJCU+nVJ60g6GdDnrL2Jc=
X-Google-Smtp-Source: AGHT+IF41f/hEDuNuA09VXbvGPxQNXbKGxA34LGVDDyoOV/7cGhIV3x5DLuwYtaeSPBxKEM3yRLjJM9SZjLNovd7gB4=
X-Received: by 2002:a05:622a:5514:b0:4a9:d263:dbc5 with SMTP id
 d75a77b69052e-4a9dcd2238fmr290521cf.20.1751999916086; Tue, 08 Jul 2025
 11:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com> <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com> <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <aG07j4Pfkd5EEobQ@google.com> <CA+EHjTx0UkYSduDxe13dFi4+J5L28H+wB4FBXLsMRC5HaHaaFg@mail.gmail.com>
 <aG1UenipkaGyVUz-@google.com>
In-Reply-To: <aG1UenipkaGyVUz-@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 8 Jul 2025 19:37:58 +0100
X-Gm-Features: Ac12FXz2ea5j5gW9dhHxsUTG3z5TMtb4pNBOQU8cekFqn3Ye8zgo2zFcr57HDR8
Message-ID: <CA+EHjTzQwt4Xux7AtB_eiuerKXeCmann2PFBoJTDZ8+qvFuX+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: Sean Christopherson <seanjc@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, Jun Miao <jun.miao@intel.com>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "jack@suse.cz" <jack@suse.cz>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "keirf@google.com" <keirf@google.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, Wei W Wang <wei.w.wang@intel.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org" <willy@infradead.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, Dave Hansen <dave.hansen@intel.com>, 
	"fvdl@google.com" <fvdl@google.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"bfoster@redhat.com" <bfoster@redhat.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	"anup@brainfault.org" <anup@brainfault.org>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, "steven.price@arm.com" <steven.price@arm.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hughd@google.com" <hughd@google.com>, 
	Zhiquan1 Li <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, Erdem Aktas <erdemaktas@google.com>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, Haibo1 Xu <haibo1.xu@intel.com>, Fan Du <fan.du@intel.com>, 
	"maz@kernel.org" <maz@kernel.org>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	Chao P Peng <chao.p.peng@intel.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	Alexander Graf <graf@amazon.com>, "nikunj@amd.com" <nikunj@amd.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "jroedel@suse.de" <jroedel@suse.de>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, 
	Yilun Xu <yilun.xu@intel.com>, "liam.merwick@oracle.com" <liam.merwick@oracle.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	Ira Weiny <ira.weiny@intel.com>, 
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

On Tue, 8 Jul 2025 at 18:25, Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jul 08, 2025, Fuad Tabba wrote:
> > > > I don't think we need a flag to preserve memory as I mentioned in [2]. IIUC,
> > > > 1) Conversions are always content-preserving for pKVM.
> > >
> > > No?  Perserving contents on private => shared is a security vulnerability waiting
> > > to happen.
> >
> > Actually it is one of the requirements for pKVM as well as its current
> > behavior. We would like to preserve contents both ways, private <=>
> > shared, since it is required by some of the potential use cases (e.g.,
> > guest handling video encoding/decoding).
> >
> > To make it clear, I'm talking about explicit sharing from the guest,
> > not relinquishing memory back to the host. In the case of
> > relinquishing (and guest teardown), relinquished memory is poisoned
> > (zeroed) in pKVM.
>
> I forget, what's the "explicit sharing" flow look like?  E.g. how/when does pKVM
> know it's ok to convert memory from private to shared?  I think we'd still want
> to make data preservation optional, e.g. to avoid potential leakage with setups
> where memory is private by default, but a flag in KVM's uAPI might not be a good
> fit since whether or not to preserve data is more of a guest decision (or at least
> needs to be ok'd by the guest).

In pKVM all sharing and unsharing is triggered by the guest via
hypercalls. The host cannot unshare. That said, making data
preservation optional works for pKVM and is a good idea, for the
reasons that you've mentioned.

Cheers,
/fuad

