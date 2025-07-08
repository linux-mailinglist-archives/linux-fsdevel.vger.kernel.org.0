Return-Path: <linux-fsdevel+bounces-54262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D9EAFCD54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E604D17E1FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E72E091A;
	Tue,  8 Jul 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbQhiJ3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1422E06EA
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984442; cv=none; b=ECESlmbliKz0H7BJ5NVAIOWQwqeYXQnXvmxi55Ap0iBk2UkKGlmesVmJ5exXSPj1PzFYlvkZOMOqp2OLko8L/CUYyiu73GWRTFZBhynLaxeWEfc1/MZR9WaW9Rz2oGv0+fiO1+c3qXHjcMvf5it+Nv9y/71HizRheWsOM+Kk7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984442; c=relaxed/simple;
	bh=SmZxv/4Ec9WWlqitOjGQheDnOuNrpp2y4zOQczrJBMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g53UcReYTwBMYjwsEDxgvbBlwN/sSjwXGxIm+9ocsnOwaw7ohKzPzfPWe7SiAnEwO9TzTA4lQ8UvRfWwkTwxtqKVZ4lThbkXU+629F2cnumYPtv6HSeDhnUjX8uwn/NWyhj3T10vS80vf1+nvkoiB+tEG2IvVsmLC5SmNzk9qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbQhiJ3Q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2369dd58602so46300575ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751984440; x=1752589240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YEjiVQlfJLOP7kVxMpQDdQ/vGMM3KscEJ6hcSffOpCY=;
        b=jbQhiJ3Q2+tVUvs/Z9GD5Igj5ncnqautndOpr4ZvsmXW2x+XtFrnJPvXvF+RUt1Z05
         YKoTMRfW5BN8eyD/dFJgEB0xC62qx38zPf4ZgRVeY6sdpT9uDOEWkdm9LZx2U9Jrnt08
         I9mIcu7KfKrhkZYRwzFLiAzfZMrjtdFkrlNSMZuOrBDdCSxO1CtHVt9WvLnZseoAEmqt
         kGT593SHgr3rU/mEFPaAJjaSTRC4h9DDqD1Y4YPCNd5MSlx+uWsQeyjnLPfyr7Wftjqr
         ZYlK4MEwDzFAwHYyWUGdrZJtk0g7YzqCT7P7nERm/DcVuejzt0dgWx73YAHhdEuQB2l/
         wW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984440; x=1752589240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEjiVQlfJLOP7kVxMpQDdQ/vGMM3KscEJ6hcSffOpCY=;
        b=I9rcD0vMesGI3T0n4wEZc7rnvQqrBao6kccgdc/r9dX7v3rfUVXyd/oSMKxduxyz3K
         VnFHGayHxJsAELzm1bI0axov9B1ZA0YWXsX8VA2Asn+zKQS7TcWO6VJAm0iY/wxO7tLB
         AAbiHv8W2GJwaX+39cIV2W4jHqVDzsmKNuoqwX027TNW/K9yUYdk8zi9U09un/JE1jNu
         SwI4+JupxLLOi2pKQE7rJjYKGkm9nhgb9Rllhj57rDL5h+JzwTltIKFlYqPKZu/oAvxs
         mHdPkjBJvCvMFcnRHUwfWdiB7qyVhgePeBKMdI2cFEdFcHGCfB7R472/QfDKpBh+JGhl
         CZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgXjZpMSJ1l/9yU0zZvpKN/jF79pfZICcKFqo5e4wgI85bzSst5+z11QbZDq8AIM1pMEBcchEOjHcqv9lj@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaEoRBzr5Wwbl2EPrv9T+YZLuU4ZtCdwDoLF+3kjmerI2CENu
	X2umvmtdUsjm+1BG5pD7x+MdRw3lOjmUvRjOSfHwQQUzbkTs1TT4Pxhc0Ko8PuE/qvsV0/mWP56
	qZrTYIw==
X-Google-Smtp-Source: AGHT+IHzXNaPQBczSLUZ2cM9qmp+nPh8k2XVabSQDtWv0v/y5gyBaS/+ETp76jHwOBS4DHAguPnj+YOZVZk=
X-Received: from pjyd4.prod.google.com ([2002:a17:90a:dfc4:b0:312:f31a:af55])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48f:b0:235:7c6:ebdb
 with SMTP id d9443c01a7336-23c8746532fmr277306715ad.10.1751984439683; Tue, 08
 Jul 2025 07:20:39 -0700 (PDT)
Date: Tue, 8 Jul 2025 07:20:38 -0700
In-Reply-To: <006899ccedf93f45082390460620753090c01914.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com> <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
 <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
 <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com> <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
 <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com> <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com> <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
Message-ID: <aG0pNijVpl0czqXu@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "jack@suse.cz" <jack@suse.cz>, "maz@kernel.org" <maz@kernel.org>, 
	"keirf@google.com" <keirf@google.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "hughd@google.com" <hughd@google.com>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, Wei W Wang <wei.w.wang@intel.com>, 
	Fan Du <fan.du@intel.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, Dave Hansen <dave.hansen@intel.com>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>, 
	"steven.price@arm.com" <steven.price@arm.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"fvdl@google.com" <fvdl@google.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"bfoster@redhat.com" <bfoster@redhat.com>, 
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"anup@brainfault.org" <anup@brainfault.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tabba@google.com" <tabba@google.com>, 
	"mic@digikod.net" <mic@digikod.net>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Zhiquan1 Li <zhiquan1.li@intel.com>, 
	"rientjes@google.com" <rientjes@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"willy@infradead.org" <willy@infradead.org>, Haibo1 Xu <haibo1.xu@intel.com>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	Kai Huang <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
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
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, 
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 08, 2025, Rick P Edgecombe wrote:
> On Mon, 2025-07-07 at 17:14 -0700, Vishal Annapurve wrote:
> > > 
> > > Some architectures, e.g. SNP and TDX, may effectively require zeroing on
> > > conversion,
> > > but that's essentially a property of the architecture, i.e. an arch/vendor
> > > specific
> > > detail.
> > 
> > Conversion operation is a unique capability supported by guest_memfd
> > files so my intention of bringing up zeroing was to better understand
> > the need and clarify the role of guest_memfd in handling zeroing
> > during conversion.
> > 
> > Not sure if I am misinterpreting you, but treating "zeroing during
> > conversion" as the responsibility of arch/vendor specific
> > implementation outside of guest_memfd sounds good to me.
> 
> For TDX if we don't zero on conversion from private->shared we will be dependent
> on behavior of the CPU when reading memory with keyid 0, which was previously
> encrypted and has some protection bits set. I don't *think* the behavior is
> architectural. So it might be prudent to either make it so, or zero it in the
> kernel in order to not make non-architectual behavior into userspace ABI.

Ya, by "vendor specific", I was also lumping in cases where the kernel would need
to zero memory in order to not end up with effectively undefined behavior.

> Up the thread Vishal says we need to support operations that use in-place
> conversion (overloaded term now I think, btw). Why exactly is pKVM using
> private/shared conversion for this private data provisioning?

Because it's literally converting memory from shared to private?  And IICU, it's
not a one-time provisioning, e.g. memory can go:

  shared => fill => private => consume => shared => fill => private => consume

> Instead of a special provisioning operation like the others? (Xiaoyao's
> suggestion)

Are you referring to this suggestion?

 : And maybe a new flag for KVM_GMEM_CONVERT_PRIVATE for user space to
 : explicitly request that the page range is converted to private and the
 : content needs to be retained. So that TDX can identify which case needs
 : to call in-place TDH.PAGE.ADD.

If so, I agree with that idea, e.g. add a PRESERVE flag or whatever.  That way
userspace has explicit control over what happens to the data during conversion,
and KVM can reject unsupported conversions, e.g. PRESERVE is only allowed for
shared => private and only for select VM types.

