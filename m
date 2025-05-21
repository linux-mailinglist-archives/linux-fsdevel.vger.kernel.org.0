Return-Path: <linux-fsdevel+bounces-49584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2488ABF918
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06589E4C33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1071EB1BC;
	Wed, 21 May 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wz/dvelT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2FF1E2848
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840947; cv=none; b=A8Ft2hNFSJ0idLc6Gf4clzINi45kLNuwj6kzjIVuG6PXFcR+NHZUpB9EMdbxyoQMkjLwHqP+4l4XysI+qOUHAtlFCbdqzWcqy/5WSziFfcJnT1or2YPj+g7wnJUEcJ1xEdhucOZ9aZh6CEbNMZPgTJxXpbIsAmpyfWz1kRtRJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840947; c=relaxed/simple;
	bh=cyorVbV+bvd3pMFT0Pcn7XPfJZwPAhId89v8L031Ymo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUaKBKIEtlD6shIjyznEWT03vA/EQWwYlfvViBezm6zo8pKG6no1Ay3pSEll/1GipypoqTpov+W1Uv+/9zJjsy8C0G/A50AZ2sY+DzmoXwzWqraEpiJow+VtBtaJpxBLYLeh9czAJrxrn2afy4G9NEqtMapPiltCs6En6GxKHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wz/dvelT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-48b7747f881so1488581cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747840944; x=1748445744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyorVbV+bvd3pMFT0Pcn7XPfJZwPAhId89v8L031Ymo=;
        b=wz/dvelTbEq7Aiu/k2VyQ2d5GdHjoH0Qv3Suw8HGNvOm89E/ZiNXe5ARoIf6mRR4Zo
         jRaIKCPBCCJ/quBLD6RvXi+fJkBmOqnY1G75ili4y3YHsgo9Dx1pJsNxydlptHhRjR9P
         B1wAHk9PQGZXoyYyREL/x/5qf4fK61xdA0mP1Xyw5goEnowds+xa2sh/U43jM/bawv99
         fL3+moPXP8Y9cNCGy5hvqubX2b3SC9SGZV3xDax6uo1MZNj9+PQB9DX3Hh0DeO3DRVFS
         nMCj2vYU+pv4t/mnICalk1ChBtUAzx1WjZ7Wi5v/zeNEXtw0ryEblBKRcwcQA1OKJ5FB
         xfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840944; x=1748445744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyorVbV+bvd3pMFT0Pcn7XPfJZwPAhId89v8L031Ymo=;
        b=c453+on6GIZsffCQPE7RFpgT8bXaRh7QjRzhP8NurtMDxvEU8NAYHVYbtq1nofvxhX
         K6t5G6YFdnz1oa5eATaHbKuo0B/U2lOB00ueigGeKjgpSdV+lOCFEMl8LPqGCFqAGuNH
         RCkkIyDBJ9HbBpu0hlTBhJCLdcBKpL57HXGGfDCsINcDlAHQuSc4Q/5Kf5F9e5a2ce3b
         dPlNUfBbci+r8LzhZri6CasPBYTRnKjavF2aJ/XUpZ6q+b5emgnCSM9y7HZkyokgx5zW
         YM0C3Ilhkjxuwii8NlkaQ1YihnAy5eeI0NQVtJx8cYW6L/fMYeeH6Op2aBmMsg54VC+Z
         HOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVchELtwgM/8sPkRtHWQWAaQJtlWqxu0VOe/v/GBWWO8Li3m8ZFsifF08Dw8ZWCGjKfkXDszvrNNRQJWog7@vger.kernel.org
X-Gm-Message-State: AOJu0YwTR9JBHRRA1bAPVNBqNWOsl40yRuZTLi3HJXOwZKIKPGgg/qbS
	aqYuuoRFQU2m9fH3zM8HdTMmqS0ivKQ9Tn4S6x8WBJLrYf7ZzWuXg2sWgENIPTC1lIsM5zIuXJG
	RZlALANQuqcEfPG6cAT7/qJEt4UInWbPnDNDJZZSE
X-Gm-Gg: ASbGncsRx270JkCWj0MSg4/JefyP46wPGcBPQ7/NSJkwztnqPYjDq6kAbiK1BwHOkam
	6KND2X4AISKZf512fCh2XmDfSyPCF6PZ83nsJDNliz3cCMvTFT/sJtK/s21Nvu0emJIJDObfTx3
	IqQto6cTnklxxVrsGsQDj1ph7GKRPBB53ovlgrBtOY7VPRNA9+lhmT0Q==
X-Google-Smtp-Source: AGHT+IE9sWx0eO9CaSEERbSlz8WHSAH0nRVx3exSAXfCOfLTtTCtFAKZo3qwXtV1LJJtoEI1TnqjZGTpW4mH4zrZQIM=
X-Received: by 2002:a05:622a:449:b0:48a:42fa:78fa with SMTP id
 d75a77b69052e-4958cd26812mr16408901cf.2.1747840944231; Wed, 21 May 2025
 08:22:24 -0700 (PDT)
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
In-Reply-To: <CAGtprH-fE=G923ctBAcq5zFna+2WULhmHDSbXUsZKUrin29b4g@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 21 May 2025 16:21:46 +0100
X-Gm-Features: AX0GCFunsX4s_S9rg-xVdpk--w8XHiF75FQSZUzqMS7j0X8kX-1qix4ZgGpOcAc
Message-ID: <CA+EHjTxvufYVA8LQWRKEX7zA0gWLQUHVO2LvwKc5JXVu-XAEEA@mail.gmail.com>
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

On Wed, 21 May 2025 at 15:42, Vishal Annapurve <vannapurve@google.com> wrot=
e:
>
> On Wed, May 21, 2025 at 5:36=E2=80=AFAM Fuad Tabba <tabba@google.com> wro=
te:
> > ....
> > > When rebooting, the memslots may not yet be bound to the guest_memfd,
> > > but we want to reset the guest_memfd's to private. If we use
> > > KVM_SET_MEMORY_ATTRIBUTES to convert, we'd be forced to first bind, t=
hen
> > > convert. If we had a direct ioctl, we don't have this restriction.
> > >
> > > If we do the conversion via vcpu_run() we would be forced to handle
> > > conversions only with a vcpu_run() and only the guest can initiate a
> > > conversion.
> > >
> > > On a guest boot for TDX, the memory is assumed to be private. If the =
we
> > > gave it memory set as shared, we'd just have a bunch of
> > > KVM_EXIT_MEMORY_FAULTs that slow down boot. Hence on a guest reboot, =
we
> > > will want to reset the guest memory to private.
> > >
> > > We could say the firmware should reset memory to private on guest
> > > reboot, but we can't force all guests to update firmware.
> >
> > Here is where I disagree. I do think that this is the CoCo guest's
> > responsibility (and by guest I include its firmware) to fix its own
> > state after a reboot. How would the host even know that a guest is
> > rebooting if it's a CoCo guest?
>
> There are a bunch of complexities here, reboot sequence on x86 can be
> triggered using multiple ways that I don't fully understand, but few
> of them include reading/writing to "reset register" in MMIO/PCI config
> space that are emulated by the host userspace directly. Host has to
> know when the guest is shutting down to manage it's lifecycle.

In that case, I think we need to fully understand these complexities
before adding new IOCTLs. It could be that once we understand these
issues, we find that we don't need these IOCTLs. It's hard to justify
adding an IOCTL for something we don't understand.

> x86 CoCo VM firmwares don't support warm/soft reboot and even if it
> does in future, guest kernel can choose a different reboot mechanism.
> So guest reboot needs to be emulated by always starting from scratch.
> This sequence needs initial guest firmware payload to be installed
> into private ranges of guest_memfd.
>
> >
> > Either the host doesn't (or cannot even) know that the guest is
> > rebooting, in which case I don't see how having an IOCTL would help.
>
> Host does know that the guest is rebooting.

In that case, that (i.e., the host finding out that the guest is
rebooting) could trigger the conversion back to private. No need for
an IOCTL.

> > Or somehow the host does know that, i.e., via a hypercall that
> > indicates that. In which case, we could have it so that for that type
> > of VM, we would reconvert its pages to private on a reboot.
>
> This possibly could be solved by resetting the ranges to private when
> binding with a memslot of certain VM type. But then Google also has a
> usecase to support intrahost migration where a live VM and associated
> guest_memfd files are bound to new KVM VM and memslots.
>
> Otherwise, we need an additional contract between userspace/KVM to
> intercept/handle guest_memfd range reset.

Then this becomes a migration issue to be solved then, not a huge page
support issue. If such IOCTLs are needed for migration, it's too early
to add them now.

Cheers,
/fuad

