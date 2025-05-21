Return-Path: <linux-fsdevel+bounces-49586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BFABFAC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EB53B1B1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C6B220F41;
	Wed, 21 May 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErpZ0DhC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B72206B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842700; cv=none; b=W0z63cLreAqopIf6PQRvdNNCb9HLWgcXqDlGR7ts8ly9mT/w68lTOUP8WVbZLXLS0o5JxAApI9QNUSmdMXariGvt/rB1FEXM2IFgI8xaup81pDKxpHtYFVpaJobkhnagwTYmzJEobLJhniaaT1TxToTAbF27m2/aX8yQtWjwxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842700; c=relaxed/simple;
	bh=8sepo7ZUTMdBYzRonwxMcnqAgDClXDq596T2GjQ7rZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbgWoVbPmLOju1CsA+pq1wMNWElDlNC6ozrLAzJlIuWfTgFkS/n7u35h7kh8tOlqDbFYgPG0XZoezo7PQT+uNt4FCh6nn2e2NC4bw3MjSRLhb2AsK4GQdfAS4u3SANqO/1iYIhPwLP9VGW8IH4jUb4e21u0V01n5mQ60OMIaldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErpZ0DhC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-231f6c0b692so782565ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747842698; x=1748447498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWPZpU6WFSpfS6hmxyh7KpM+vXuIKyk4x1JorSsjETc=;
        b=ErpZ0DhCeoUaQ4pHOYArnXE1iMEoOMcHD8tEETcGGMx4Qop42AU/Mnnq6JeRVyAeZz
         p11USJBf5jpgzAmmb3cEo21g/+Uutx712owqexmw24J4++DpwK33dwWtDOTm/y02mpGo
         UFuR0MgBkzyvi2qC/15yjW94rFNv8XleOPbLGgx5IkmhoUBXixo/kSrQc8lpy7UAVpFI
         6Ix6ApWVrQweFzqYCJd5zrVNiTN4SB4txyBOgdYzKRS+QOrU900Hkw6vBB5abJxa6w7J
         Ri20scOZpOzWx+dX+xONikKTKIlapHX3Wl1iTAFyox7KV4cIHrDYoQlVIfZ7W148CLkf
         COKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747842698; x=1748447498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWPZpU6WFSpfS6hmxyh7KpM+vXuIKyk4x1JorSsjETc=;
        b=s3G7YdaOwvREfcqKkO68JHPnIyDvWoDRZs2YtQt22P4pYponzSiWUqdusvii8n7tmL
         YJiJH8T2SDnDG0hK7l9wZfBP/PX0hCFL+aXKUmMhY94u3G/TM1wctvw1qwoDf5BS6KWP
         id5y3E3W1eGDEm2IW9el546YjREBHYrZjSB5JbwB+KJTgpVMiRdGuEhV8OyNsm2tXISZ
         IdHT/TI/Xq1MPxK4sVWLznuPLRXw2+dActTCf84YVkjYU0IjQ+OjB+u1rkh3rSxJYJzM
         kg8+i1kdFmlpkq+AfVe4T1APuqsLCK/RnvZoCrny8e0U6/hNGliFFL7MF6hT2Bx+7Egu
         ClzA==
X-Forwarded-Encrypted: i=1; AJvYcCUWwx6cS+Btc1F0V/gVn9a4TVljlqMrZkIf/4soup2+kCKuCy9XOiKst4z+yms1rdW6+8gTzMqUXopXYjo4@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWVQbFi6GSWQKpkptW10iMBtMfrHcZeHqY3ejoCX9Fd1rkgLq
	LBpW6AaS3MssHObtc8sy47GDcg+ngayD6V1vavvUwVpHdfyU6Ujmvi4ch1XMe1NNDcGX+mGMP+e
	Iml1veCXcxmyjoF6Egy7CkQ0UhthxwZcE1FsY5gM3
X-Gm-Gg: ASbGncuath8Q/y0O7DlbDxERE3KSxsyr40Dw2pirHRe9gld4FMA3t3SZwoGqWC+nPRy
	GwFmVLB7nFUzqCskGIGiZcoBXKnqMtCvl3zNYEevAJWvT5NWwso9aVgPya8JfMwtMOcpAM3bur5
	TiK2hjOK2A9Ie4jvAnXQ3UtmjNpRVQ4/LXT1omLyR6oNQZgZzRk7dm4+0Hxm/eeLNAk39SQs00u
	fc=
X-Google-Smtp-Source: AGHT+IFSOrNxCp8s0BP2r14v02zKIVmyd2WKvXsGYKjroHCU10VHEe96vUn3gv/Pkk2x5Yo5Ut2ufH8Ox+PjEmVUtJY=
X-Received: by 2002:a17:902:da85:b0:223:7f8f:439b with SMTP id
 d9443c01a7336-23204175c4fmr11681965ad.29.1747842697619; Wed, 21 May 2025
 08:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <CA+EHjTy7iBNBb9DRdtgq8oYmvgykhSNvZL3FrRV4XF90t3XgBg@mail.gmail.com>
 <CAGtprH_7jSpwF77j1GW8rjSrbtZZ2OW2iGck5=Wk67+VnF9vjQ@mail.gmail.com>
 <CA+EHjTzMhKCoftfJUuL0WUZW4DdqOHgVDcn0Cmf-0r--8rBdbg@mail.gmail.com>
 <diqzecwjnk95.fsf@ackerleytng-ctop.c.googlers.com> <CA+EHjTyY5C1QgkoAqvJ0kHM4nUvKc1e1nQ0Uq+BANtVEnZH90w@mail.gmail.com>
 <CAGtprH-fE=G923ctBAcq5zFna+2WULhmHDSbXUsZKUrin29b4g@mail.gmail.com> <CA+EHjTxvufYVA8LQWRKEX7zA0gWLQUHVO2LvwKc5JXVu-XAEEA@mail.gmail.com>
In-Reply-To: <CA+EHjTxvufYVA8LQWRKEX7zA0gWLQUHVO2LvwKc5JXVu-XAEEA@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 21 May 2025 08:51:25 -0700
X-Gm-Features: AX0GCFv_OcRDXXTTFCAqZtA9lE-fYkL67Fg0315KprRAbyvEL7EBvd9v52zlvyg
Message-ID: <CAGtprH_TfKT3oRPCLbh-ojLGXSfOQ2XA39pVhr47gb3ikPtUkw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Fuad Tabba <tabba@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
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
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 8:22=E2=80=AFAM Fuad Tabba <tabba@google.com> wrote=
:
>
> Hi Vishal,
>
> On Wed, 21 May 2025 at 15:42, Vishal Annapurve <vannapurve@google.com> wr=
ote:
> >
> > On Wed, May 21, 2025 at 5:36=E2=80=AFAM Fuad Tabba <tabba@google.com> w=
rote:
> > > ....
> > > > When rebooting, the memslots may not yet be bound to the guest_memf=
d,
> > > > but we want to reset the guest_memfd's to private. If we use
> > > > KVM_SET_MEMORY_ATTRIBUTES to convert, we'd be forced to first bind,=
 then
> > > > convert. If we had a direct ioctl, we don't have this restriction.
> > > >
> > > > If we do the conversion via vcpu_run() we would be forced to handle
> > > > conversions only with a vcpu_run() and only the guest can initiate =
a
> > > > conversion.
> > > >
> > > > On a guest boot for TDX, the memory is assumed to be private. If th=
e we
> > > > gave it memory set as shared, we'd just have a bunch of
> > > > KVM_EXIT_MEMORY_FAULTs that slow down boot. Hence on a guest reboot=
, we
> > > > will want to reset the guest memory to private.
> > > >
> > > > We could say the firmware should reset memory to private on guest
> > > > reboot, but we can't force all guests to update firmware.
> > >
> > > Here is where I disagree. I do think that this is the CoCo guest's
> > > responsibility (and by guest I include its firmware) to fix its own
> > > state after a reboot. How would the host even know that a guest is
> > > rebooting if it's a CoCo guest?
> >
> > There are a bunch of complexities here, reboot sequence on x86 can be
> > triggered using multiple ways that I don't fully understand, but few
> > of them include reading/writing to "reset register" in MMIO/PCI config
> > space that are emulated by the host userspace directly. Host has to
> > know when the guest is shutting down to manage it's lifecycle.
>
> In that case, I think we need to fully understand these complexities
> before adding new IOCTLs. It could be that once we understand these
> issues, we find that we don't need these IOCTLs. It's hard to justify
> adding an IOCTL for something we don't understand.
>

I don't understand all the ways x86 guest can trigger reboot but I do
know that x86 CoCo linux guest kernel triggers reset using MMIO/PCI
config register write that is emulated by host userspace.

> > x86 CoCo VM firmwares don't support warm/soft reboot and even if it
> > does in future, guest kernel can choose a different reboot mechanism.
> > So guest reboot needs to be emulated by always starting from scratch.
> > This sequence needs initial guest firmware payload to be installed
> > into private ranges of guest_memfd.
> >
> > >
> > > Either the host doesn't (or cannot even) know that the guest is
> > > rebooting, in which case I don't see how having an IOCTL would help.
> >
> > Host does know that the guest is rebooting.
>
> In that case, that (i.e., the host finding out that the guest is
> rebooting) could trigger the conversion back to private. No need for
> an IOCTL.

In the reboot scenarios, it's the host userspace finding out that the
guest kernel wants to reboot.

>
> > > Or somehow the host does know that, i.e., via a hypercall that
> > > indicates that. In which case, we could have it so that for that type
> > > of VM, we would reconvert its pages to private on a reboot.
> >
> > This possibly could be solved by resetting the ranges to private when
> > binding with a memslot of certain VM type. But then Google also has a
> > usecase to support intrahost migration where a live VM and associated
> > guest_memfd files are bound to new KVM VM and memslots.
> >
> > Otherwise, we need an additional contract between userspace/KVM to
> > intercept/handle guest_memfd range reset.
>
> Then this becomes a migration issue to be solved then, not a huge page
> support issue. If such IOCTLs are needed for migration, it's too early
> to add them now.

The guest_memfd ioctl is not needed for migration but to change/reset
guest_memfd range attributes. I am saying that migration usecase can
conflict with some ways that we can solve resetting guest_memfd range
attributes without adding a new IOCTL as migration closely resembles
reboot scenario as both of them can/need reusing the same guest memory
files but one needs to preserve guest memory state.

Reiterating my understanding here, guest memfd ioctl can be used by
host userspace to -
1) Change guest memfd range attributes during memory conversion
     - This can be handled by KVM hypercall exits in theory as you are
suggesting but Ackerley and me are still thinking that this is a
memory operation that goes beyond vcpu scope and will involve
interaction with IOMMU backend as well, it's cleaner to have a
separate guest memfd specific ioctl for this operation as the impact
is even beyond KVM.

2) Reset guest memfd range attributes during guest reboot to allow
reusing the same guest memfd files.
    - This helps reset the range state to private as needed inline
with initial shared/private configuration chosen at the guest memfd
creation.
    - This also helps reconstitute all the huge pages back to their
original state that may have gotten split during the runtime of the
guest.
  This is a host initiated request for guest memfd memory conversion
that we should not be overloading with other KVM interactions in my
opinion.

>
> Cheers,
> /fuad

