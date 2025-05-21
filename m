Return-Path: <linux-fsdevel+bounces-49597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97145ABFCD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C44817495C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C59928ECEE;
	Wed, 21 May 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGqykEn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320911A5B86
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852119; cv=none; b=V44th4noa6zsqFMmDHBH9m+schPkEI/b4YJjbZrzLaMwNN3kQYfERjfuTOuWmnHk26dtKvR+8UCQkBSEbUsbCQByEAyA92S2megLWApqNDpFVFBsLyjsqUw/T3v+NzpN3VTDtTjzoWAJWnnXainknhUnAPCeIW9Hykee3JrowFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852119; c=relaxed/simple;
	bh=Q4DTrgnzbZNV6UVIr8mJmj9kPEgmhtAOJivglIuEklM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuu1Lt5WUPoBkDMStKk6NQ03YLq2AbnV+bCNxi0oPk0HVB9UQa0qyz+H5uM5l1mg+XfXegYGKYWDwmA8+vtXqHLynvyWJWgZ/F+ovrV7rd/pGnvO1JPrJhNSQjZsXc9vT8B3VoewDsH5zTzrWh3tAy5q7yi9N3vFZe+b11aOIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGqykEn0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-48b7747f881so1573801cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747852117; x=1748456917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE+TGfgZP6vAxjKudjK+avRjPu3u2b6Qn6vlewX0Zww=;
        b=uGqykEn0p/a/1VSksCpeA22cCceGsV47smVUgAJ+/Uf0464Has8qdvDl5JE6EZROwa
         usFeY2UIHaATjVCeu9QZPnuiJWKiiIJjfvOZ+RsJVITVz1CAJx/8L+Iw3mOFrBUoI0Vd
         rKsCb/1VAJ/YljsdJo7Ec2bFPIkLqdXfsmtfhPocdSttwtQtdzYgSLnZMGGARqXnGQeh
         TUAZ/6v9nDWb3BaYRCwiOTV6c1v0WaAE/CbdxqNgxnnggQ20+p0smdtdESKToWiVwzjU
         M/CTU8IoBhEK47M4jtGwgCHTrs5KliUEZYzBqxV7CnfCpv6F4i4TnAgkjZjk0/yACL8P
         oW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747852117; x=1748456917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE+TGfgZP6vAxjKudjK+avRjPu3u2b6Qn6vlewX0Zww=;
        b=oUUGdGffqPE4dJWuhSP/k2hgBB6tP5x8PPJ204Cz3exm1ED/dUexwhOwU9fmg/RmII
         KhwZleg/+ZPqZ6/YdHxGX+vGiLvC1kPf+aGUYBHEW9fvqLYcWvz+RsU8y2h7/hGGzRqB
         HBVTQW7+WMWFqNpaR+nibfqz+N9Ghd9K12s34Xk7AKndOD3mGCiySfYMMJJ353D31GKr
         DqC6HupV5hNyI8vEiW/3DuVoC5mQ5rXJqVyFfJTF7j9a4jXsW2A6yNyWCLtsqmJEvfmi
         OWKMC9F5AtyeY/fXOn8zp0AflKyYQxgy7BYJRUf4APD9yJKRE7LZKqi50Xbmid3eA7tq
         mNbA==
X-Forwarded-Encrypted: i=1; AJvYcCXUKLOhcCLLC1yHML4ZvZwwKHlu9XbxqrE5cc4zmMizHPIore3oOjbBjdZfMI2kp3tQfw2rBZzVqOLFWxMe@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuu5SjJIvX4G366G6UD+namVDwfmITXbjmOIyIOuafRxi9iVk8
	5hfjQxj66oUwxArejUXIDEkJEHzhEBC0kqLdOm7GnThHVwVN+xLUl7NPYfhATrOv/7+J0rXlZNT
	2yCgFfROlK3db+kA5c86E3te4IbL7nXsPXu8ghPNF
X-Gm-Gg: ASbGncs7HeMPzkz3rzpmWmt6QVXy4Lapu6Mw4pFmsLnf6AR6uMKTDaNKiatqSAi38mV
	J28Xe7knY14WhbjgCdsNL+0xWIegmvO1k8D3qwz/GMrv5unnk6rLWsHRFRfwYPpeQ/GfQ02iptd
	BsKEgSXQ6lzhRdbyqRasgNRz3XqxP1QT26Y87y677wlDg=
X-Google-Smtp-Source: AGHT+IGZid6ZSwp6ECf/sysAwwsVHxmx53LALy1SypT4adky3X6cr5p2m6ZAau9iUxYfvXGZ9udv6VpTLQeFJ9CfCY0=
X-Received: by 2002:ac8:7d8b:0:b0:49b:72e2:4058 with SMTP id
 d75a77b69052e-49b72e24109mr5409741cf.11.1747852116701; Wed, 21 May 2025
 11:28:36 -0700 (PDT)
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
 <CAGtprH-fE=G923ctBAcq5zFna+2WULhmHDSbXUsZKUrin29b4g@mail.gmail.com>
 <CA+EHjTxvufYVA8LQWRKEX7zA0gWLQUHVO2LvwKc5JXVu-XAEEA@mail.gmail.com> <CAGtprH_TfKT3oRPCLbh-ojLGXSfOQ2XA39pVhr47gb3ikPtUkw@mail.gmail.com>
In-Reply-To: <CAGtprH_TfKT3oRPCLbh-ojLGXSfOQ2XA39pVhr47gb3ikPtUkw@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 21 May 2025 19:27:59 +0100
X-Gm-Features: AX0GCFvKwIuCerI-UVymdfO2So4kET6He8NY_WhPOEmZF51aoWgYNRN9VC95aCs
Message-ID: <CA+EHjTxJZ_pb7+chRoZxvkxuib2YjbiHg=_+f4bpRt2xDFNCzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Vishal Annapurve <vannapurve@google.com>
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

Hi Vishal,

On Wed, 21 May 2025 at 16:51, Vishal Annapurve <vannapurve@google.com> wrot=
e:
>
> On Wed, May 21, 2025 at 8:22=E2=80=AFAM Fuad Tabba <tabba@google.com> wro=
te:
> >
> > Hi Vishal,
> >
> > On Wed, 21 May 2025 at 15:42, Vishal Annapurve <vannapurve@google.com> =
wrote:
> > >
> > > On Wed, May 21, 2025 at 5:36=E2=80=AFAM Fuad Tabba <tabba@google.com>=
 wrote:
> > > > ....
> > > > > When rebooting, the memslots may not yet be bound to the guest_me=
mfd,
> > > > > but we want to reset the guest_memfd's to private. If we use
> > > > > KVM_SET_MEMORY_ATTRIBUTES to convert, we'd be forced to first bin=
d, then
> > > > > convert. If we had a direct ioctl, we don't have this restriction=
.
> > > > >
> > > > > If we do the conversion via vcpu_run() we would be forced to hand=
le
> > > > > conversions only with a vcpu_run() and only the guest can initiat=
e a
> > > > > conversion.
> > > > >
> > > > > On a guest boot for TDX, the memory is assumed to be private. If =
the we
> > > > > gave it memory set as shared, we'd just have a bunch of
> > > > > KVM_EXIT_MEMORY_FAULTs that slow down boot. Hence on a guest rebo=
ot, we
> > > > > will want to reset the guest memory to private.
> > > > >
> > > > > We could say the firmware should reset memory to private on guest
> > > > > reboot, but we can't force all guests to update firmware.
> > > >
> > > > Here is where I disagree. I do think that this is the CoCo guest's
> > > > responsibility (and by guest I include its firmware) to fix its own
> > > > state after a reboot. How would the host even know that a guest is
> > > > rebooting if it's a CoCo guest?
> > >
> > > There are a bunch of complexities here, reboot sequence on x86 can be
> > > triggered using multiple ways that I don't fully understand, but few
> > > of them include reading/writing to "reset register" in MMIO/PCI confi=
g
> > > space that are emulated by the host userspace directly. Host has to
> > > know when the guest is shutting down to manage it's lifecycle.
> >
> > In that case, I think we need to fully understand these complexities
> > before adding new IOCTLs. It could be that once we understand these
> > issues, we find that we don't need these IOCTLs. It's hard to justify
> > adding an IOCTL for something we don't understand.
> >
>
> I don't understand all the ways x86 guest can trigger reboot but I do
> know that x86 CoCo linux guest kernel triggers reset using MMIO/PCI
> config register write that is emulated by host userspace.
>
> > > x86 CoCo VM firmwares don't support warm/soft reboot and even if it
> > > does in future, guest kernel can choose a different reboot mechanism.
> > > So guest reboot needs to be emulated by always starting from scratch.
> > > This sequence needs initial guest firmware payload to be installed
> > > into private ranges of guest_memfd.
> > >
> > > >
> > > > Either the host doesn't (or cannot even) know that the guest is
> > > > rebooting, in which case I don't see how having an IOCTL would help=
.
> > >
> > > Host does know that the guest is rebooting.
> >
> > In that case, that (i.e., the host finding out that the guest is
> > rebooting) could trigger the conversion back to private. No need for
> > an IOCTL.
>
> In the reboot scenarios, it's the host userspace finding out that the
> guest kernel wants to reboot.

How does the host userspace find that out? If the host userspace is
capable of finding that out, then surely KVM is also capable of
finding out the same.


> >
> > > > Or somehow the host does know that, i.e., via a hypercall that
> > > > indicates that. In which case, we could have it so that for that ty=
pe
> > > > of VM, we would reconvert its pages to private on a reboot.
> > >
> > > This possibly could be solved by resetting the ranges to private when
> > > binding with a memslot of certain VM type. But then Google also has a
> > > usecase to support intrahost migration where a live VM and associated
> > > guest_memfd files are bound to new KVM VM and memslots.
> > >
> > > Otherwise, we need an additional contract between userspace/KVM to
> > > intercept/handle guest_memfd range reset.
> >
> > Then this becomes a migration issue to be solved then, not a huge page
> > support issue. If such IOCTLs are needed for migration, it's too early
> > to add them now.
>
> The guest_memfd ioctl is not needed for migration but to change/reset
> guest_memfd range attributes. I am saying that migration usecase can
> conflict with some ways that we can solve resetting guest_memfd range
> attributes without adding a new IOCTL as migration closely resembles
> reboot scenario as both of them can/need reusing the same guest memory
> files but one needs to preserve guest memory state.
>
> Reiterating my understanding here, guest memfd ioctl can be used by
> host userspace to -
> 1) Change guest memfd range attributes during memory conversion
>      - This can be handled by KVM hypercall exits in theory as you are
> suggesting but Ackerley and me are still thinking that this is a
> memory operation that goes beyond vcpu scope and will involve
> interaction with IOMMU backend as well, it's cleaner to have a
> separate guest memfd specific ioctl for this operation as the impact
> is even beyond KVM.

The IOMMU backend needs to know about the sharing/unsharing, not
trigger it. The memory is the guest's. We already have a mechanism for
informing userspace of these kinds of events with KVM exits. This
doesn't justify adding a new IOCTL.

> 2) Reset guest memfd range attributes during guest reboot to allow
> reusing the same guest memfd files.
>     - This helps reset the range state to private as needed inline
> with initial shared/private configuration chosen at the guest memfd
> creation.
>     - This also helps reconstitute all the huge pages back to their
> original state that may have gotten split during the runtime of the
> guest.
>   This is a host initiated request for guest memfd memory conversion
> that we should not be overloading with other KVM interactions in my
> opinion.

Then, we could argue about whether we need a "reset" IOCTL (not that I
am arguing for that). But still, like I said, if the host becomes
aware that the confidential guest is rebooting, then surely KVM can be
made aware.

I wonder if this might be better suited for the biweekly guest_memfd sync.

Cheers,
/fuad
> >
> > Cheers,
> > /fuad

