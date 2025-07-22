Return-Path: <linux-fsdevel+bounces-55716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD81B0E357
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA857A43F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575B27FD7D;
	Tue, 22 Jul 2025 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u93PhvyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4671A23BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208263; cv=none; b=T/ZHl0709NbUKmQ9LvXxFLYbnEK0t/fjUcUwAnWWe8N7wWKfp2F9oBgNB7SEoETm8/5DCGM7hK3iTmjhAh9mi0sVQvgEcV8qUjv0QI04pBCeW+4DlZ9ark926JdjGcwtYxKJq2Fr4hnNnWj2Zy5XLdED0WzHSQ/laNJOvP8JE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208263; c=relaxed/simple;
	bh=2f+84DwTTfKGBlhXcojMr2iRvuLhc2YGodSIxuLtokw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2WqFbBssE64i1e8Dn3BERBocC4QYllNl+ACsTVl5tVN+cZEzdao33wwNv4v64MVmGlmyRAhBN+DNdyupongQgIEvdTZ0qPR3p+qu73HcHmmNwvvpp8P4iND+KYI941l0Cm8ojEv2CHY8O8DqakByn5eoBDOAd7mRomKQFjE/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u93PhvyU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74ea5d9982cso4192157b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753208262; x=1753813062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0uhWfOICElzP/Lw68mkivYLCjTmw/FAHTOP1H5PpS5c=;
        b=u93PhvyUPJp+PHfG57ulsEHvkXiD3sfyNoTEAjDYa4rmqk9aLV3uHPvrL7/yM4cjf6
         tm1ZO4Wf1rr+lrMY9r43bEBLQUwlGbBq4PAEtOHW2k/ALGggx3MI0UaQZo7Le/Jk9DOe
         Hs82G8o/j3QxY85a5NGWeOEr/h05C7ntbyVZlD10sK+fFPYym8r0yEjP4tjR4tLM772m
         AoJWemZMi3i+0LpAEZqVrNkRKBntuipcjGRB8cciqWlD6U5ALLo+umQDT5gTTtWgjP+u
         AQAjS/Klx0n1IQJeKGYXaTjNE+RsLXgYwTUr45wWUlgWyHsj32DZAV80STArI3TQQYB2
         eSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208262; x=1753813062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uhWfOICElzP/Lw68mkivYLCjTmw/FAHTOP1H5PpS5c=;
        b=ecgUM8M3N+WP0HIGQs5stPDU+orv9ZV4qg8jW33GjkH0YO9OZz5KNvlwtGhnYIid2/
         ztaQYwoVA6TajU5a0pevE9OKBLOcUb2Pp1X/Fn012aUcOOqCnyGRTWqGZk/MMD0kpJdY
         OSh20doqA3/M940kL6Bu2RmegySDSbgy9icOcM+mXf4Kn7CUIyB35SYKiuRyqMpF4+ae
         jITMCKBJ+WW4BnZoF6jz9CNaQ0O5E5rqFfwHEcst2GKPXKfj1b/l6eQ2sdI8pVO41dSi
         ep7skPB6HVHovEbn1bHw8CU+6RJ8BPJWSoowX4R9jfQO0Ds5cARxek8fXeLrkfTKyT1M
         bBDA==
X-Forwarded-Encrypted: i=1; AJvYcCWWHz14O1uG4pHepZSap+FFHEr5iDg7fv/WrNWBj4Vkf+IrHfQHZDBqRqijiAADXUw1ggKoA0ua6jeKH+nR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JtuOFuMPJtWV1HNlXbYtBwud3QstKj/8wFElXcCDM7ucw3Xl
	WTYqRzBQ0prdVr+z1sSn/kLWmDV1M+b7yX84X6WK7fsZ80u4+B66iemVXNNBjKy1ZsYUIpUpwXJ
	sRQdBeHMPmHvZ5fm+F5ijYQ4lJQ==
X-Google-Smtp-Source: AGHT+IEZPq9JAZBfv/HDTaiqlxwio+gpwy5VWQkFScjzBWu4+U5mfVT+UUJR8YyZ7zO116a8IO9RMjZ+2gQY1usLMg==
X-Received: from pfbcj22.prod.google.com ([2002:a05:6a00:2996:b0:747:a9de:9998])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88c8:0:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-76034c56938mr377906b3a.7.1753208261268;
 Tue, 22 Jul 2025 11:17:41 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:17:39 -0700
In-Reply-To: <aH4PRnuztKTqgEYo@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com> <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com> <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
 <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050> <diqzqzyeg3j2.fsf@ackerleytng-ctop.c.googlers.com>
 <aHm2F95XwzdD7nod@yilunxu-OptiPlex-7050> <687a6483506f2_3c6f1d2945a@iweiny-mobl.notmuch>
 <aH4PRnuztKTqgEYo@yilunxu-OptiPlex-7050>
Message-ID: <diqzwm803xa4.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
From: Ackerley Tng <ackerleytng@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

>> > > >> Yan, Yilun, would it work if, on conversion,
>> > > >> 
>> > > >> 1. guest_memfd notifies IOMMU that a conversion is about to happen for a
>> > > >>    PFN range
>> > > >
>> > > > It is the Guest fw call to release the pinning.
>> > > 
>> > > I see, thanks for explaining.
>> > > 
>> > > > By the time VMM get the
>> > > > conversion requirement, the page is already physically unpinned. So I
>> > > > agree with Jason the pinning doesn't have to reach to iommu from SW POV.
>> > > >
>> > > 
>> > > If by the time KVM gets the conversion request, the page is unpinned,
>> > > then we're all good, right?
>> > 
>> > Yes, unless guest doesn't unpin the page first by mistake.
>> 
>> Or maliciously?  :-(
>
> Yes.
>
>> 
>> My initial response to this was that this is a bug and we don't need to be
>> concerned with it.  However, can't this be a DOS from one TD to crash the
>> system if the host uses the private page for something else and the
>> machine #MC's?
>
> I think we are already doing something to prevent vcpus from executing
> then destroy VM, so no further TD accessing. But I assume there is
> concern a TD could just leak a lot of resources, and we are
> investigating if host can reclaim them.
>
> Thanks,
> Yilun

Sounds like a malicious guest could skip unpinning private memory, and
guest_memfd's unmap will fail, leading to a KVM_BUG_ON() as Yan/Rick
suggested here [1].

Actually it seems like a legacy guest would also lead to unmap failures
and the KVM_BUG_ON(), since when TDX connect is enabled, the pinning
mode is enforced, even for non-IO private pages?

I hope your team's investigations find a good way for the host to
reclaim memory, at least from dead TDs! Otherwise this would be an open
hole for guests to leak a host's memory.

Circling back to the original topic [2], it sounds like we're okay for
IOMMU to *not* take any refcounts on pages and can rely on guest_memfd
to keep the page around on behalf of the VM?

[1] https://lore.kernel.org/all/diqzcya13x2j.fsf@ackerleytng-ctop.c.googlers.com/
[2] https://lore.kernel.org/all/CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com/

