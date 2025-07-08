Return-Path: <linux-fsdevel+bounces-54286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE70AFD54A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1CF564DD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253282E6D02;
	Tue,  8 Jul 2025 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DX4hKLQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150E2BD590
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995518; cv=none; b=Nsg/zj0SPbrncQDt5xUeKE72ErGtwKyWGCrgq1F2BmdHyd4kshAhd3ws7cnwEtNfkimEAZzpxV0c8vH7lL2CTHuV8EZoca8HR8qOzfNTD5On4Hw9Zm3WEafpAag4VBNZjL0nYLli36pBudNXn3rZPAzn33xwdG7huQQl/KtzGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995518; c=relaxed/simple;
	bh=2dpzcIMoo5kncn4prSd58X6gAiB5Ct+J0whAQjT0KUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TO9drMOOsLrpfqX4edP0MM1PpdOe/lvbiDrzE+W8H+UtQMgMS8PcMuiZk8aJCx1Xo+xqdjbUbBHz/ElQ0A6SmH6Lwm/XtYHBCYQYkjvIlcyGsSc/tpnsuzR+70d1OSXvJkchfzumgvBeuGrLPiZflHc+loXfW+gnDghj4Lz+hkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DX4hKLQK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74d15d90cdbso1856883b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751995516; x=1752600316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOwqio/U6duro56etG9g9gjBoY7irnx3UEwaemXddiQ=;
        b=DX4hKLQKIEGaSUCYwK4P+4Ckx/4lJX7bAZzoAJsXfvHpccsbncYh7E3yMQfoP05Q4M
         xt1s0i/PNLIfQ6cJknkgk5FHsrv8dfEpMvhrxdLz0tdfjeqWOtnuLhEXpO9Oaem9/zhY
         K01zT8QxLgDnvP7ycFGeU4KVdVQtCMXPceJoqMwdCJegQEH2X5O9Oirk70iz1xBpG1yI
         CdHf5AKgpUxVDg2d7gDubXrscCHJLgcJbQEO1v1sKPB5E8EdlSDm7k4uiKq4RF5KUV5r
         3+CVq+rcpFX8LpbOoLeEoFq7hQqNEQmxm7hGsJSMtBsDJUJeYUEX1DL/j2eY/6YkmhaA
         jfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995516; x=1752600316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOwqio/U6duro56etG9g9gjBoY7irnx3UEwaemXddiQ=;
        b=T+F8/4Y11C9JMMS3GmhSk1lGvUVuWNDBAHcRHwvEKy2q4+WtNq8pmtUx6jrMLIiWJD
         nPBlWZAK9PnDtlOxAGEyGxK2EE3NMdJ0ZABMjV7Sbe+RUR66OeOXJ13jZz+D8H1I7Tp2
         f/MJLfYFBf8O1EydmqNawSuA6JVjy7wXQOdbzq8M1Eynw1GalXzBG2x1fl+JnEPd6QbU
         8SQJw66wwmllMtUB/idI3MFac26F8oaz9f8PxNriX08e9Ff48QKHajA3rj3RWv/nf4ss
         Uq+hBCuonTtRtEyRsImhcUoL/Ob3ejqyKyJD6RZMQR0sLXcEVbIEUZkeUchz7njzhX0L
         abXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhpHSz5nD9Cz4PKoWs9hduWBPO3XPe4VVdxi+HleIx0EdVJFTmvjUJJvTlaEIGzKacC+yxRXCAebeFxGJo@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIh+cSoQOM7zdZFeQWJb0ujGXSqVwsmjU63oYOeSJTXZjk11H
	rWXDHMLl+NNF48mh529xa1PpVKufeDlEHeUxwtWKlCRux9Nuv/Uc6Y4OTfq52UNZtiM3jmqZz9r
	4vfFlmQ==
X-Google-Smtp-Source: AGHT+IGkRB4yNgSMgfNT0NPmR/wV1gl+lHkhWIKL4jLtjZNROIxI7LYo/8fgTwMpPUWfFv4LNZrzk2dg4WY=
X-Received: from pfbei35.prod.google.com ([2002:a05:6a00:80e3:b0:746:2897:67e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b4b:b0:748:68dd:eb8c
 with SMTP id d2e1a72fcca58-74ce8ad5fd4mr21303958b3a.23.1751995515731; Tue, 08
 Jul 2025 10:25:15 -0700 (PDT)
Date: Tue, 8 Jul 2025 10:25:14 -0700
In-Reply-To: <CA+EHjTx0UkYSduDxe13dFi4+J5L28H+wB4FBXLsMRC5HaHaaFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com> <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com> <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <aG07j4Pfkd5EEobQ@google.com> <CA+EHjTx0UkYSduDxe13dFi4+J5L28H+wB4FBXLsMRC5HaHaaFg@mail.gmail.com>
Message-ID: <aG1UenipkaGyVUz-@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
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
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 08, 2025, Fuad Tabba wrote:
> > > I don't think we need a flag to preserve memory as I mentioned in [2]. IIUC,
> > > 1) Conversions are always content-preserving for pKVM.
> >
> > No?  Perserving contents on private => shared is a security vulnerability waiting
> > to happen.
> 
> Actually it is one of the requirements for pKVM as well as its current
> behavior. We would like to preserve contents both ways, private <=>
> shared, since it is required by some of the potential use cases (e.g.,
> guest handling video encoding/decoding).
> 
> To make it clear, I'm talking about explicit sharing from the guest,
> not relinquishing memory back to the host. In the case of
> relinquishing (and guest teardown), relinquished memory is poisoned
> (zeroed) in pKVM.

I forget, what's the "explicit sharing" flow look like?  E.g. how/when does pKVM
know it's ok to convert memory from private to shared?  I think we'd still want
to make data preservation optional, e.g. to avoid potential leakage with setups
where memory is private by default, but a flag in KVM's uAPI might not be a good
fit since whether or not to preserve data is more of a guest decision (or at least
needs to be ok'd by the guest).

