Return-Path: <linux-fsdevel+bounces-49581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2705ABF811
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFDE3B3C1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4BC1E1E0B;
	Wed, 21 May 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yl8rcKfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6521D7999
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838537; cv=none; b=TJlGC+lXu6F6V1Mky/WmDnId/Tqtf8yfdp+njw6E7FzjIILUrKW8uyBOq51P/k7axTlaLtO4foYKvWJdrsLzEVAjZdY0mgAn52138ukXYvPWGEllEbpvEJxfxLr8F0L4jJktVTSVx318UKsU0JFW7fz8G8ZIE7bypzQgDPv3ALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838537; c=relaxed/simple;
	bh=MeIreJ0VzWT2UiLJVYu37D2mNjDEruPiWRZcit3nFDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENYRSu5wFGMjIaf5uOzbIFzgXV2nGMvmfS2Ncf2FbC00/RRxmLLfvccOzzHCRp3HI9Pg/RUA/5wMzSgXyKhE9zq6RRJC6OvgOAF9Q8+Fv5RrH7uSy2qBMl7MVMumZIi/pexri96qN2DS5eqduhS4kKTht95y5YfY6WokTK+2kGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yl8rcKfd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231ba6da557so720515ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747838534; x=1748443334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeIreJ0VzWT2UiLJVYu37D2mNjDEruPiWRZcit3nFDU=;
        b=yl8rcKfdmTnA2glzI6CDGMGJzJw8woIbVZ8oU12U1HYxR0M+dHGBOg1/oZBPgw3taM
         q78cYU+YditqGcWoM4IZaarAIrEjwctqzPzWgsUhbjNrGBs+n9KUsnlWAJG0Qyss1Lhh
         faaymkhMilJAab4/EkZWaqAQ0h58S4Qj4ANwc1nixAp88y1gR4Y6Bz3CJP9OoXhge9ru
         r/mvEKPlouRMG8uQwGCODWs/WZoUM38cZqMEWGZWB3SsrnKQVjirPvE4g78Pjfb/rcGi
         /3EaG2O5vDGOxlD/gfhLE89kSCVbpHVpNhHdnV4luS3eOBp/SRS3RZdK3dOUWQWy4Qag
         h9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747838534; x=1748443334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeIreJ0VzWT2UiLJVYu37D2mNjDEruPiWRZcit3nFDU=;
        b=f7Bi82p4y6DyEsHTj6yeVJTvd88U1JLvyZXZ889nhFmmVkAeL/RalLBjDTJdYDQNu1
         g8jibmWXY2JoidBdm43gkVwNsxJOFlDRVZu225mxlNtuUn/CnfxH1lDMqLK+e6ub6OFL
         8heTuu+2Ip6lEmEJnKp2kAC5EX0RIsNZAyL/jj218Dw8iWR95nRhCIX3fRJeiKd9rt5/
         QhHWnJnA9l9dL4L9lr6ClvSDWZKodt/AHDNiJtI+N+WVM8JYtt4cYw7H/dOAce3M5eyf
         3GN8vG6ZTCYNxvBHzGY61mgrM9jYlqTMq3Je4sNL5Ib9KT7e4RnDm0P6OTCAx257If04
         0UaA==
X-Forwarded-Encrypted: i=1; AJvYcCWh4kpSkVMQif2PRggTizVHruqcpMoF+fp6usxt4L3zK4mExGxKZUP4e50JiRtqzQoaYMJLfbImBvxi9wJk@vger.kernel.org
X-Gm-Message-State: AOJu0YytFip3dPL3iGJV+MjPntJAX2Tf5MH5PfYPJvj/5DKMXfYS4oU8
	ZbbYOG2Z6vtMIBVbpJv5IvC2jQbY3ZPLCpSfrEQ3fazAwDJhi9Jxulb6fvFXnommZJFSu8dwdwD
	bl3ENgZYAQQpBeFggLaoHMh5NN20F5CK5Tkt09DDe
X-Gm-Gg: ASbGnctt/cDbBbRf9NJi8tZAZYCTcPMI5+/lMOxDpyUBF3O28EU0MihqyJNxC8JX39E
	ws2fVcOkdwgHCDpvwBnLPjlVXf2U2jJCyBHnj/ZNmYkZq+X6jlkQJNEvxY5wkRS/8Jcb8aP3bYA
	IO0rHu41r2TyKj1r3uyIk/08LqQahxF8H5N2WCzm3Z2hpukqGp1eQoCzRRZLbLYwVbXVxqEjlsM
	ak=
X-Google-Smtp-Source: AGHT+IG2dIYCeOz3RfprKj5ASeFAdVUkomyHxXDYNyHo+nRE69+av8tpRMQ+wxHyswC7YgfpsfFFUwky7GIhiFkkWlc=
X-Received: by 2002:a17:902:cecd:b0:231:d7cf:cf18 with SMTP id
 d9443c01a7336-23203eee503mr11647135ad.1.1747838533592; Wed, 21 May 2025
 07:42:13 -0700 (PDT)
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
In-Reply-To: <CA+EHjTyY5C1QgkoAqvJ0kHM4nUvKc1e1nQ0Uq+BANtVEnZH90w@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 21 May 2025 07:42:01 -0700
X-Gm-Features: AX0GCFtAT9R_Oe05rYdzQPFgRH8-_eDMLizxCLAk0K-mKF9SD9rgeSxLsWR73nE
Message-ID: <CAGtprH-fE=G923ctBAcq5zFna+2WULhmHDSbXUsZKUrin29b4g@mail.gmail.com>
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

On Wed, May 21, 2025 at 5:36=E2=80=AFAM Fuad Tabba <tabba@google.com> wrote=
:
> ....
> > When rebooting, the memslots may not yet be bound to the guest_memfd,
> > but we want to reset the guest_memfd's to private. If we use
> > KVM_SET_MEMORY_ATTRIBUTES to convert, we'd be forced to first bind, the=
n
> > convert. If we had a direct ioctl, we don't have this restriction.
> >
> > If we do the conversion via vcpu_run() we would be forced to handle
> > conversions only with a vcpu_run() and only the guest can initiate a
> > conversion.
> >
> > On a guest boot for TDX, the memory is assumed to be private. If the we
> > gave it memory set as shared, we'd just have a bunch of
> > KVM_EXIT_MEMORY_FAULTs that slow down boot. Hence on a guest reboot, we
> > will want to reset the guest memory to private.
> >
> > We could say the firmware should reset memory to private on guest
> > reboot, but we can't force all guests to update firmware.
>
> Here is where I disagree. I do think that this is the CoCo guest's
> responsibility (and by guest I include its firmware) to fix its own
> state after a reboot. How would the host even know that a guest is
> rebooting if it's a CoCo guest?

There are a bunch of complexities here, reboot sequence on x86 can be
triggered using multiple ways that I don't fully understand, but few
of them include reading/writing to "reset register" in MMIO/PCI config
space that are emulated by the host userspace directly. Host has to
know when the guest is shutting down to manage it's lifecycle.

x86 CoCo VM firmwares don't support warm/soft reboot and even if it
does in future, guest kernel can choose a different reboot mechanism.
So guest reboot needs to be emulated by always starting from scratch.
This sequence needs initial guest firmware payload to be installed
into private ranges of guest_memfd.

>
> Either the host doesn't (or cannot even) know that the guest is
> rebooting, in which case I don't see how having an IOCTL would help.

Host does know that the guest is rebooting.

> Or somehow the host does know that, i.e., via a hypercall that
> indicates that. In which case, we could have it so that for that type
> of VM, we would reconvert its pages to private on a reboot.

This possibly could be solved by resetting the ranges to private when
binding with a memslot of certain VM type. But then Google also has a
usecase to support intrahost migration where a live VM and associated
guest_memfd files are bound to new KVM VM and memslots.

Otherwise, we need an additional contract between userspace/KVM to
intercept/handle guest_memfd range reset.

