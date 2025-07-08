Return-Path: <linux-fsdevel+bounces-54273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B47AFCF6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433B77B538D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C62E1737;
	Tue,  8 Jul 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLFm8dNI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C052DFF04
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989145; cv=none; b=QFo/SV1qDgP7kl84c/FQBPJf6hBNMRfj8uDOxmWdb+0JrVqyaOyccIu863epgMMopa+uEIllFyT37aiycRrld/Q8rDBMP7GNXgYmM4PX93JMB8ct37FpriV/DNTOIEWxFTJS7zyL/qYn/TnqKjnv/gzKgd/fsIKb1WqWS9AO1m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989145; c=relaxed/simple;
	bh=ay6a3q8ckTPpxsDcQsPqS7Qt5vS8hnlo8TH9PCcpMBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R6CSLFYloRhUMezxZthU4vGT5N+NkIIP8xRwSeZO9zEf22tELsI519FI7zsKtxy/VFpE3Rt1copq0pR3epwPX8ZdQuFVO+xOOHT0MN/imCcqvMKAOO6GluyMODJowHrNQPsgT6WF5RoO19PfrPbMQjA+UdW54qc2Zr+I2zXkkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLFm8dNI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fa1a84566so3147717a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751989143; x=1752593943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJ6Trmj44z6pMJddwVQzuI+dtUG3teA4UW/36PaybfA=;
        b=lLFm8dNIcn48xcNpxryCk91Jy3hZfBJzgSa7rk8Smy8St1K8OA/IsITwtlaZ8mpHA8
         WCMJuu52xBApDHikBm92hsuwspGJScGqBSTjAYbI5mVrZeTKFeJNRWNN2KNIZsrFobQa
         9pF4camFheCB5hcaByl31PeH5j8DcPXiBsF0NtSBvA1jVDPIz4hi3MmrIC0pPeqMOKOe
         U225Zje90EfSqyy9avi7s+GPtRkSDMhXEJjJ837v8sD7+5S+sWtvt62NR9bHX/zyXgJ4
         JaEbixW+RwO81UpvIL1Kk2e3ngZyOpO6AF1VImxgkQNYTQ7NsK8MKd2rHxUGFU6uELiR
         WrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989143; x=1752593943;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fJ6Trmj44z6pMJddwVQzuI+dtUG3teA4UW/36PaybfA=;
        b=jSUNQOTzqPwHmLN/CcjGIZdBqGmD40B5X9NfjUgh6+TxHJpyNY/UtT9oTtvDmvjwiV
         4tXfzvDeOW27Mw8mquFo2p2ohymTgXBmTB3IsIS8CHz2B/khA6cLwuKvOBy4YMbm7R02
         MYfwujFzlBJ5sQPSO4QzfX5ce7sUUlLn4te8vSfI65Hn7IR5KUzIlpgrEpaUeGd2rg8H
         wvb1WFfnef9lFCQ6XTnMPg2cCtjlQMWJEhC+QggWoZC0/MoNem2tMhR1tn9jZ9FdZksO
         Is8qYLqJ/uvJeh9dJhbZnzygcwRshYVrgU2LtBJEQNBPY5Unsn59bNSPoB/F/uQKVn/r
         ju2w==
X-Forwarded-Encrypted: i=1; AJvYcCU/IjtdDVB25CIKn0RPe027NaR+l57C8I36To6MjxJMQJJNKkRLoPTYZKhGz79nWuYp/sJJYxphWpHVjJ93@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qo0P/WuSMREfko6IIfLRNc8wAgS82w34RHUlX/lI/gpP/5yr
	2YqVyW2iKlXoYS/pkn9yHUP4X59RvaTA12GoDeIDJBwdRjv5zDcbNMJEupZ7tw/GQLaKi+6X9Hq
	Inpm1VQ==
X-Google-Smtp-Source: AGHT+IEVTH1cDHrDrkBM9ANruotfYiflC/Rn/GMmhs6k3Qn6zxl4FY9ZL04L/ybWIyiK/dNj58MjPa3dDVo=
X-Received: from pfbfi39.prod.google.com ([2002:a05:6a00:39a7:b0:747:b682:5cc0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:929e:b0:742:8d52:62f1
 with SMTP id d2e1a72fcca58-74ce6419a9emr28472954b3a.8.1751989142330; Tue, 08
 Jul 2025 08:39:02 -0700 (PDT)
Date: Tue, 8 Jul 2025 08:38:55 -0700
In-Reply-To: <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com> <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
 <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com> <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com> <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
Message-ID: <aG07j4Pfkd5EEobQ@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, Kirill Shutemov <kirill.shutemov@intel.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "jack@suse.cz" <jack@suse.cz>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "keirf@google.com" <keirf@google.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, Wei W Wang <wei.w.wang@intel.com>, 
	"tabba@google.com" <tabba@google.com>, 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2025, Vishal Annapurve wrote:
> On Tue, Jul 8, 2025 at 7:52=E2=80=AFAM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
> >
> > On Tue, 2025-07-08 at 07:20 -0700, Sean Christopherson wrote:
> > > > For TDX if we don't zero on conversion from private->shared we will=
 be
> > > > dependent
> > > > on behavior of the CPU when reading memory with keyid 0, which was
> > > > previously
> > > > encrypted and has some protection bits set. I don't *think* the beh=
avior is
> > > > architectural. So it might be prudent to either make it so, or zero=
 it in
> > > > the
> > > > kernel in order to not make non-architectual behavior into userspac=
e ABI.
> > >
> > > Ya, by "vendor specific", I was also lumping in cases where the kerne=
l would
> > > need to zero memory in order to not end up with effectively undefined
> > > behavior.
> >
> > Yea, more of an answer to Vishal's question about if CC VMs need zeroin=
g. And
> > the answer is sort of yes, even though TDX doesn't require it. But we a=
ctually
> > don't want to zero memory when reclaiming memory. So TDX KVM code needs=
 to know
> > that the operation is a to-shared conversion and not another type of pr=
ivate
> > zap. Like a callback from gmem, or maybe more simply a kernel internal =
flag to
> > set in gmem such that it knows it should zero it.
>=20
> If the answer is that "always zero on private to shared conversions"
> for all CC VMs,

pKVM VMs *are* CoCo VMs.  Just because pKVM doesn't rely on third party fir=
mware
to provide confidentiality and integrity doesn't make it any less of a CoCo=
 VM.

> > >  : And maybe a new flag for KVM_GMEM_CONVERT_PRIVATE for user space t=
o
> > >  : explicitly request that the page range is converted to private and=
 the
> > >  : content needs to be retained. So that TDX can identify which case =
needs
> > >  : to call in-place TDH.PAGE.ADD.
> > >
> > > If so, I agree with that idea, e.g. add a PRESERVE flag or whatever. =
 That way
> > > userspace has explicit control over what happens to the data during
> > > conversion,
> > > and KVM can reject unsupported conversions, e.g. PRESERVE is only all=
owed for
> > > shared =3D> private and only for select VM types.
> >
> > Ok, we should POC how it works with TDX.
>=20
> I don't think we need a flag to preserve memory as I mentioned in [2]. II=
UC,
> 1) Conversions are always content-preserving for pKVM.

No?  Perserving contents on private =3D> shared is a security vulnerability=
 waiting
to happen.

> 2) Shared to private conversions are always content-preserving for all
> VMs as far as guest_memfd is concerned.

There is no "as far as guest_memfd is concerned".  Userspace doesn't care w=
hether
code lives in guest_memfd.c versus arch/xxx/kvm, the only thing that matter=
s is
the behavior that userspace sees.  I don't want to end up with userspace AB=
I that
is vendor/VM specific.

> 3) Private to shared conversions are not content-preserving for CC VMs
> as far as guest_memfd is concerned, subject to more discussions.
>=20
> [2] https://lore.kernel.org/lkml/CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_=
gCiDS6BAFtQ@mail.gmail.com/

