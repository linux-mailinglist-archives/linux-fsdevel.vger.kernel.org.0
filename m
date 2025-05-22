Return-Path: <linux-fsdevel+bounces-49681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26BAC0ED4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CBCA216D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86928DB55;
	Thu, 22 May 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zdA9yKnN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8828D8D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925566; cv=none; b=ORLdT1LoZg0YWzNw2/pLiS/UDqNBIkiFOTyyEV7cYB9FZxTLTYNQc8BTFSzFGfYIWdpDl6WdGe/4vYxH5EbAdjGk7r74OcgGx6oy9XCaDNRXq/wrMkPakGb55E7Zk35LBjwghSObaxAf7MZL0r27FXV3bwn1weEewoaMQ9wKD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925566; c=relaxed/simple;
	bh=1B2UwXy+eREibFkEN65Y0H/bWVpqpUf2RZLMqTnAq5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RvBBOVcb3uncIfjIae4k21mC8oPUp2OyFGMHwT2cKfatiqRNV1fBDfz7DUanqEqx6ydEsygHYwimdZBEoTqTOXb6zrx9oWwPaUzsWN7tb+hh7EWWW2Tzp9wvgWDlMsl+4UBnZW+ve7Xr/wOjyGmFuI6TujMPRxbM4qNN5QIqYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zdA9yKnN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e9e81d4b0so7587244a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747925564; x=1748530364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZ8YmHyMaz5fBM8/QXNAl/DrlvoX+XAfi4wswaLDq3M=;
        b=zdA9yKnN1usatZmyKWAbMy7lox0ughIHEzhF1kVZhNIKCgObXq3IcSySrnI6xndpGa
         buNoRgBrF0Dq4CEahrVWJvrIs3nfiqiOF3uK+9wk4aL3MsB5hTEnU9bCfxIl+Kb+S51P
         v7tHVctUd8fhEIr6sFALS1OIxjQRqUWzTuIFqwy8yAbtyv1NA66Oqc0DPJzhl3wW5u+f
         te0+MDTYwFcBi9FvXEaQwNjwx+5mxxSumPEw5Ng3Z4hR8Jw3g4i1Eum5rfHMKdMkEhZI
         C/Bj12DM+ioK6oI6VR21o4LlOQJMkj/WXGQaGPBFU/velcjxUiKu7CIyIen3OJIhN89i
         MdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925564; x=1748530364;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BZ8YmHyMaz5fBM8/QXNAl/DrlvoX+XAfi4wswaLDq3M=;
        b=CjFRRy7jFe4DCRADQmIcvDFb/bCuw6mDlgaSZkqfmyDzoBII90CRY151Q8UcClOm3o
         zJeETLknxnC1IYDcIds4h0LWqz/v11Fp8nRmzGpQ7rLzSv1BROrIk/YoxHAhB9sfQ7bD
         GDTN7/1ENQl8xRN13Uvu8BgU1pGMF24YgfsNQHe1Qf3bd/eruYKvLJu/odL8fFSMgKTR
         UF/tJwjqg9OTnkqcDPZx4pbrIpVdZjk/phk3ms3QcoSJtILAwkiy37VTUq1fB9ClqjXz
         OgWPdk7dPqRCpESIqZz/1hdlLHjfPolsp7RJ7sD159EZQTOKxIO+OHZwT2QydEgVyf7V
         m+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBLyI0u0/4PP5cFdCX8FVujIKPeOd3SPXFNlPsRFLM4PqcNy5GEVOACsduWfXDvVvKLXJoJIPPe/3dPU86@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWEdSfinPCTzAJE4jwilhdMEgEq7LtObEJGo1H0+l4T20j4/G
	+SWePEoYOK4OgOX7mBMO8R8aa0nHIOiojr1hrn8cPGySkY6iJI1fCYYp51kVGEdubkzF5wkJ5V7
	16tNLFA==
X-Google-Smtp-Source: AGHT+IHmTGrJIsuX8DX7FPF6xj7anm5a8QzgcrjE2b6L+vmsQ7gy3otN9k2Cq927P88vBTOc0bfdhLfFkXo=
X-Received: from pjbnt17.prod.google.com ([2002:a17:90b:2491:b0:310:89d3:b3dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc2:b0:2ee:b2e6:4276
 with SMTP id 98e67ed59e1d1-30e8322593dmr36667692a91.27.1747925563833; Thu, 22
 May 2025 07:52:43 -0700 (PDT)
Date: Thu, 22 May 2025 07:52:42 -0700
In-Reply-To: <CA+EHjTxJZ_pb7+chRoZxvkxuib2YjbiHg=_+f4bpRt2xDFNCzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <CA+EHjTy7iBNBb9DRdtgq8oYmvgykhSNvZL3FrRV4XF90t3XgBg@mail.gmail.com>
 <CAGtprH_7jSpwF77j1GW8rjSrbtZZ2OW2iGck5=Wk67+VnF9vjQ@mail.gmail.com>
 <CA+EHjTzMhKCoftfJUuL0WUZW4DdqOHgVDcn0Cmf-0r--8rBdbg@mail.gmail.com>
 <diqzecwjnk95.fsf@ackerleytng-ctop.c.googlers.com> <CA+EHjTyY5C1QgkoAqvJ0kHM4nUvKc1e1nQ0Uq+BANtVEnZH90w@mail.gmail.com>
 <CAGtprH-fE=G923ctBAcq5zFna+2WULhmHDSbXUsZKUrin29b4g@mail.gmail.com>
 <CA+EHjTxvufYVA8LQWRKEX7zA0gWLQUHVO2LvwKc5JXVu-XAEEA@mail.gmail.com>
 <CAGtprH_TfKT3oRPCLbh-ojLGXSfOQ2XA39pVhr47gb3ikPtUkw@mail.gmail.com> <CA+EHjTxJZ_pb7+chRoZxvkxuib2YjbiHg=_+f4bpRt2xDFNCzQ@mail.gmail.com>
Message-ID: <aC86OsU2HSFZkJP6@google.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-fsdevel@vger.kernel.org, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025, Fuad Tabba wrote:
> On Wed, 21 May 2025 at 16:51, Vishal Annapurve <vannapurve@google.com> wr=
ote:
> > On Wed, May 21, 2025 at 8:22=E2=80=AFAM Fuad Tabba <tabba@google.com> w=
rote:
> > > On Wed, 21 May 2025 at 15:42, Vishal Annapurve <vannapurve@google.com=
> wrote:
> > > > On Wed, May 21, 2025 at 5:36=E2=80=AFAM Fuad Tabba <tabba@google.co=
m> wrote:
> > > > There are a bunch of complexities here, reboot sequence on x86 can =
be
> > > > triggered using multiple ways that I don't fully understand, but fe=
w
> > > > of them include reading/writing to "reset register" in MMIO/PCI con=
fig
> > > > space that are emulated by the host userspace directly. Host has to
> > > > know when the guest is shutting down to manage it's lifecycle.
> > >
> > > In that case, I think we need to fully understand these complexities
> > > before adding new IOCTLs. It could be that once we understand these
> > > issues, we find that we don't need these IOCTLs. It's hard to justify
> > > adding an IOCTL for something we don't understand.
> > >
> >
> > I don't understand all the ways x86 guest can trigger reboot but I do
> > know that x86 CoCo linux guest kernel triggers reset using MMIO/PCI
> > config register write that is emulated by host userspace.
> >
> > > > x86 CoCo VM firmwares don't support warm/soft reboot and even if it
> > > > does in future, guest kernel can choose a different reboot mechanis=
m.
> > > > So guest reboot needs to be emulated by always starting from scratc=
h.
> > > > This sequence needs initial guest firmware payload to be installed
> > > > into private ranges of guest_memfd.
> > > >
> > > > >
> > > > > Either the host doesn't (or cannot even) know that the guest is
> > > > > rebooting, in which case I don't see how having an IOCTL would he=
lp.
> > > >
> > > > Host does know that the guest is rebooting.
> > >
> > > In that case, that (i.e., the host finding out that the guest is
> > > rebooting) could trigger the conversion back to private. No need for =
an
> > > IOCTL.
> >
> > In the reboot scenarios, it's the host userspace finding out that the g=
uest
> > kernel wants to reboot.
>=20
> How does the host userspace find that out? If the host userspace is capab=
le
> of finding that out, then surely KVM is also capable of finding out the s=
ame.

Nope, not on x86.  Well, not without userspace invoking a new ioctl, which =
would
defeat the purpose of adding these ioctls.

KVM is only responsible for emulating/virtualizing the "CPU".  The chipset,=
 e.g.
the PCI config space, is fully owned by userspace.  KVM doesn't even know w=
hether
or not PCI exists for the VM.  And reboot may be emulated by simply creatin=
g a
new KVM instance, i.e. even if KVM was somehow aware of the reboot request,=
 the
change in state would happen in an entirely new struct kvm.

That said, Vishal and Ackerley, this patch is a bit lacking on the document=
ation
front.  The changelog asserts that:

  A guest_memfd ioctl is used because shareability is a property of the mem=
ory,
  and this property should be modifiable independently of the attached stru=
ct kvm

but then follows with a very weak and IMO largely irrelevant justification =
of:

  This allows shareability to be modified even if the memory is not yet bou=
nd
  using memslots.

Allowing userspace to change shareability without memslots is one relativel=
y minor
flow in one very specific use case.

The real justification for these ioctls is that fundamentally, shareability=
 for
in-place conversions is a property of a guest_memfd instance and not a stru=
ct kvm
instance, and so needs to owned by guest_memfd.

I.e. focus on justifying the change from a design and conceptual perspectiv=
e,
not from a mechanical perspective of a flow that likely's somewhat unique t=
o our
specific environment.  Y'all are getting deep into the weeds on a random as=
pect
of x86 platform architecture, instead of focusing on the overall design.

The other issue that's likely making this more confusing than it needs to b=
e is
that this series is actually two completely different series bundled into o=
ne,
with very little explanation.  Moving shared vs. private ownership into
guest_memfd isn't a requirement for 1GiB support, it's a requirement for in=
-place
shared/private conversion in guest_memfd.

For the current guest_memfd implementation, shared vs. private is tracked i=
n the
VM via memory attributes, because a guest_memfd instance is *only* private.=
  I.e.
shared vs. private is a property of the VM, not of the guest_memfd instance=
.  But
when in-place conversion support comes along, ownership of that particular
attribute needs to shift to the guest_memfd instance.

I know I gave feedback on earlier posting about there being too series flyi=
ng
around, but shoving two distinct concepts into a single series is not the a=
nswer.
My complaints about too much noise wasn't that there were multiple series, =
it was
that there was very little coordination and lots of chaos.

If you split this series in two, which should be trivial since you've alrea=
dy
organized the patches as a split, then sans the selftests (thank you for th=
ose!),
in-place conversion support will be its own (much smaller!) series that can=
 focus
on that specific aspect of the design, and can provide a cover letter that
expounds on the design goals and uAPI.

  KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
  KVM: Query guest_memfd for private/shared status
  KVM: guest_memfd: Skip LRU for guest_memfd folios
  KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
  KVM: guest_memfd: Introduce and use shareability to guard faulting
  KVM: guest_memfd: Make guest mem use guest mem inodes instead of anonymou=
s inodes

And then you can post the 1GiB series separately.  So long as you provide p=
ointers
to dependencies along with a link to a repo+branch with the kitchen sink, I=
 won't
complain about things being too chaotic :-)

