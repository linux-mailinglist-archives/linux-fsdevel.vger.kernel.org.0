Return-Path: <linux-fsdevel+bounces-54276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7473CAFD08A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B759188925C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA52E540C;
	Tue,  8 Jul 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5rQ67AQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C42E091E
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991784; cv=none; b=Sh/gCc9m1gtKIEIV3syvNrUmPe1QpQkuorULKwVX1wNmHfIho0J8BkcIPV20QFzBQRr8XhmX4577OkBJZKgyZpg9nhzsGZVnP/ZJDfbMcOgTjml9GxqgafBK/S3OWvZP62CT8r9eEXU8mNyvQsbP0dm25acw+p/TL+qc5c8w1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991784; c=relaxed/simple;
	bh=PegidGIXf4VgLnfxOSMFf1lrcQ3ujs0Sqx5iFYA5RE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz/Heh66rNZ3cXmZw0qQWu4fRThH9DB/nVhVQUrQq+gDxvrQo/mMNMDf2lkDtSa4R2eXVgQSYn5XsGaYgDZpt25x72oFjHlmqUk9zqFKpL3iQ0WIzL4oh1x2/NSPArwrVIZdrI8Suy188TbMVNsNkp5MlmXBJtn2TxJFsVM8Uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5rQ67AQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58197794eso215701cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751991782; x=1752596582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXzt9vd5Q0HkrVVprucwZQ4sITBiPzYABNC21pbVYVY=;
        b=W5rQ67AQuMMOwuE0N8jwqk5cfkTjxnuCxPdwi2kB0/XQ1fA23TSSbPBOrGh7IKol2P
         wUjMUKoRJjO0Dpp3fl3JLoN0kbnDRmzPZVhzDs7BP0sBwONcW6NERbeqfP3PXwmZs8ps
         PbKD3YD7J9sRXZxULZgjLHfsd7a4HXMwkHP7ah4XEw/CAn7F9dt9WwdyD+EwBEINuJQ7
         UC93KMhisIEQn9I0FlxPuGy/LHdGgCSnj/+2xde0KiTvOvJfjd6zACnoY3PuMsK2XM49
         KG/trApDMt+SQsfV4KHYTU8S4dpm+kK9HH/eBLpBbFJcOPc7K22iID+NzAC2WtaMcrxE
         W5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751991782; x=1752596582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXzt9vd5Q0HkrVVprucwZQ4sITBiPzYABNC21pbVYVY=;
        b=VYmDXLtIStzSd9aaIzNHxmW2Wu0Les/aXJMtALaa0b4EJDX57u8EG7pNPyv6dmUKHg
         pQ7fUllbktsjYGncwTH9Bjc2iAVGC7cCr6BC9Vwt9jF1siKLRWW88UGZFuPaiKK9B1tR
         r8XLC2h0SiCWhtl1LMg7a1GNPa53p4n7qRcIU5i7sfbJ5ED4cRMxkNd+cEXMYEFdVLZk
         bfHYm0Lk8mvu3njXWPMqW8WpBXMSWkYkpjcbxYwQW0OTBsnb8qKu288HEHtNXj9CSvKw
         BUGohbdR1ppT45wUIw0gIG9ZrWcqRpSMxGd/zJfTu10yEeKeSNVZ7KtKgSNDxwZ4D5yZ
         v4dg==
X-Forwarded-Encrypted: i=1; AJvYcCWs+CHfuK7u9w4ljeuHkjKOlTaysvhZt+yYilSeyoaSCaBgYb6hi+KDcf9NbCrchLlC45rsKN/2OEkbRIY+@vger.kernel.org
X-Gm-Message-State: AOJu0YzxatZLqnG7Y0ishi1GClcwAue9JL+lC5mf6B+XECxQN2rYLVjf
	1PvyXBMb9cP7rN+2XckxdeuuHY+MGsZRfFB8vpayS3iT8nrAsMMiVL8SztUyJny82HlUFgLGmi+
	Ck/J5RlwK1O3qwAYsWV0ppXrcAY49IC/qtdg7Wtms
X-Gm-Gg: ASbGncu86hjaip3ZoVS2BbucUqcZdfUokLd4n4sfElyFnDKMALWCRSErpTTZh6XKMF4
	mYIZAYTQ5FqfZfUC6UG51+E0n2icb63dzvwS5VdDRnGgSE7AJO/qHUix0JNSPuk3eU1eJeZsboZ
	jVhAw1jVy2xcuzS7pJOaXtkZIwuV5/S1XTUjabLvDJwk8=
X-Google-Smtp-Source: AGHT+IFBdp4zmhdf7sOV/E1kyNsfw2i3sbcpdZXFP2jgFE4TcTJqwsBu6LVphdeOHM8jnyqNvSf2XaBBrOC5QRw3cSY=
X-Received: by 2002:a05:622a:4fca:b0:4a7:bed9:5251 with SMTP id
 d75a77b69052e-4a9d470e0d3mr2131411cf.9.1751991781275; Tue, 08 Jul 2025
 09:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com> <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
 <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com> <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com> <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com> <aG07j4Pfkd5EEobQ@google.com>
In-Reply-To: <aG07j4Pfkd5EEobQ@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 8 Jul 2025 17:22:24 +0100
X-Gm-Features: Ac12FXyH8_ZC6Lmmr3oQJsEuVEWXw9GEQ3K2NBG0RWnuVToRnCnb4O5e-GjDi3Q
Message-ID: <CA+EHjTx0UkYSduDxe13dFi4+J5L28H+wB4FBXLsMRC5HaHaaFg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Tue, 8 Jul 2025 at 16:39, Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jul 08, 2025, Vishal Annapurve wrote:
> > On Tue, Jul 8, 2025 at 7:52=E2=80=AFAM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > On Tue, 2025-07-08 at 07:20 -0700, Sean Christopherson wrote:
> > > > > For TDX if we don't zero on conversion from private->shared we wi=
ll be
> > > > > dependent
> > > > > on behavior of the CPU when reading memory with keyid 0, which wa=
s
> > > > > previously
> > > > > encrypted and has some protection bits set. I don't *think* the b=
ehavior is
> > > > > architectural. So it might be prudent to either make it so, or ze=
ro it in
> > > > > the
> > > > > kernel in order to not make non-architectual behavior into usersp=
ace ABI.
> > > >
> > > > Ya, by "vendor specific", I was also lumping in cases where the ker=
nel would
> > > > need to zero memory in order to not end up with effectively undefin=
ed
> > > > behavior.
> > >
> > > Yea, more of an answer to Vishal's question about if CC VMs need zero=
ing. And
> > > the answer is sort of yes, even though TDX doesn't require it. But we=
 actually
> > > don't want to zero memory when reclaiming memory. So TDX KVM code nee=
ds to know
> > > that the operation is a to-shared conversion and not another type of =
private
> > > zap. Like a callback from gmem, or maybe more simply a kernel interna=
l flag to
> > > set in gmem such that it knows it should zero it.
> >
> > If the answer is that "always zero on private to shared conversions"
> > for all CC VMs,
>
> pKVM VMs *are* CoCo VMs.  Just because pKVM doesn't rely on third party f=
irmware
> to provide confidentiality and integrity doesn't make it any less of a Co=
Co VM.



> > > >  : And maybe a new flag for KVM_GMEM_CONVERT_PRIVATE for user space=
 to
> > > >  : explicitly request that the page range is converted to private a=
nd the
> > > >  : content needs to be retained. So that TDX can identify which cas=
e needs
> > > >  : to call in-place TDH.PAGE.ADD.
> > > >
> > > > If so, I agree with that idea, e.g. add a PRESERVE flag or whatever=
.  That way
> > > > userspace has explicit control over what happens to the data during
> > > > conversion,
> > > > and KVM can reject unsupported conversions, e.g. PRESERVE is only a=
llowed for
> > > > shared =3D> private and only for select VM types.
> > >
> > > Ok, we should POC how it works with TDX.
> >
> > I don't think we need a flag to preserve memory as I mentioned in [2]. =
IIUC,
> > 1) Conversions are always content-preserving for pKVM.
>
> No?  Perserving contents on private =3D> shared is a security vulnerabili=
ty waiting
> to happen.

Actually it is one of the requirements for pKVM as well as its current
behavior. We would like to preserve contents both ways, private <=3D>
shared, since it is required by some of the potential use cases (e.g.,
guest handling video encoding/decoding).

To make it clear, I'm talking about explicit sharing from the guest,
not relinquishing memory back to the host. In the case of
relinquishing (and guest teardown), relinquished memory is poisoned
(zeroed) in pKVM.

Cheers,
/fuad

> > 2) Shared to private conversions are always content-preserving for all
> > VMs as far as guest_memfd is concerned.
>
> There is no "as far as guest_memfd is concerned".  Userspace doesn't care=
 whether
> code lives in guest_memfd.c versus arch/xxx/kvm, the only thing that matt=
ers is
> the behavior that userspace sees.  I don't want to end up with userspace =
ABI that
> is vendor/VM specific.
>
> > 3) Private to shared conversions are not content-preserving for CC VMs
> > as far as guest_memfd is concerned, subject to more discussions.
> >
> > [2] https://lore.kernel.org/lkml/CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmh=
z_gCiDS6BAFtQ@mail.gmail.com/

