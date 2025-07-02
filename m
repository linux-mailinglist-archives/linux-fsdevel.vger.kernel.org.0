Return-Path: <linux-fsdevel+bounces-53655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DEAF5A41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D03444FBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846E27EFFD;
	Wed,  2 Jul 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vW5p+89B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CA27A477
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464465; cv=none; b=A0geDrhsYim1KdRMUIDyU/Sd28QPhQlUbiqulOYsSmsS4SiCgMUgDFQh//0JFFw1TdGV/ltZZtYzfcq/6QjJTOhaXLLtTv10D0/WME5wn++MtAQPrvdLhVEnPZ4vmaGT2sVXvu7ePXIRF3W67MV5S68IBCQuhg49XzLD2PB125k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464465; c=relaxed/simple;
	bh=JYcMfo/FRV0MXHDD6f3JXpyZw1uOm6GKaDPQ9wemazA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptC3QwdRcerysrOBIqyyC0sF06wBEt3oK43zlVb7AB0sPT9ompXiSllXx88fb7JIR5qrz1H0YSa8j385KGMwt7nxiaNRCgL+wL2LlXiS6enHQTGngVgDrd0nL3MF8h8vzEtiz1mWercpzoEatS+Ez51E15J0b8vmBoB5IicGHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vW5p+89B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f270513bso377445ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751464463; x=1752069263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJKh0bhmf7f4ICuPLjZddH/eg+QtQRmvEhkym3b4VZM=;
        b=vW5p+89BxMEqixi/n3Unclc2DoAPPx7T0yzcZIbQMWq+fgM9MupOABCb3C63QIPNy8
         3NNXf/r5Tzk/fHKVTrklfRXjMsbk9p88aLChECA4u5JmSau48iJk6aaEPTC/XVl/x2V/
         iA4/Ucl3LS95JVVzIjPU1hYBTosJp2D5afZVk0zxsp5+a5VJS51pnL/fo0NqUnvzzrcs
         PCRYewa2ENjR+WvisU6K/OwebjDX8uiv8GeNNmyrmra69KgHM4IAeGMBy6p5/mBZt+qO
         Qy0alvNaZUOIFx9GX2+jcttyIG+aYFKn6XgYJG3ccEreFo7qbr+xbzOcwHcVF01MXiP6
         D+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464463; x=1752069263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJKh0bhmf7f4ICuPLjZddH/eg+QtQRmvEhkym3b4VZM=;
        b=TAGNkpmonCi16V/DK8Tau8u5muGXzesDIkMsHXjoPl7S+AiAlzcdem2K4xVLIN/vcj
         60fb+Rg9/kJBSV0V5lcYTcTbnmFPKqrRNhYW/oMq4m+a22cnHPoyd4XiYdV/goYlpJb7
         x9xHg/kwhQ/1yWaBCXYhzXbzTxOwG98LU8V8jFcAdv6yjKmOXLRuh+ZPybbAoPmDUneI
         iYPNBzRC2Z41jyTE/7VtthkszBJcosQUuI9Ej9asK8QhUSUFKA4BdjF1B3IAWnnr+T1A
         MVn03OEDg7GWm4DnR2kuliqBVgn1GgC8ImDSc3jIaEDBRhTzooQ0yGyB1az8Uy6nUdBU
         n9uA==
X-Forwarded-Encrypted: i=1; AJvYcCV4+AToJUwnVqGeNHMl22sbG/KHR7qxRepIgTnFuC8AFrAlVPpxeGRdiECk59NZqIbU/Tsw7R4XoCBESTA2@vger.kernel.org
X-Gm-Message-State: AOJu0YyTximRwi5h0+yGv+z2SZI/BrWXoipLlJXQTv3JEfSZ4bNKVW1N
	tfEvZZwnBu6Mg1tc41O29bMZGX0Xhl4ko/V3H1ygnOk0ti1/E9fjDgkRRHJDGiijNJyjMUGpGwZ
	sK4dhtylUngjrPzKB7mx/X6A5+ObxPPWgXquzWIAF
X-Gm-Gg: ASbGnctwT0SdHjs9SctKVLELF4VX9+TynWJFkIyCxMBOsvH3MZfpn33b/ESnybwQqVE
	wpPZYhK0XuBqYV+q+D+aqpglXCo1JuaR8n/07j11OJvgTVAavgX+m0SlS3gCB6iGhyRcXqmSV/1
	MfR+0dus8dkOioVsA+K8wOvg+HsY++nVRdKWczPh789LiIhWX3eUFGaqye+Mevntz+jRJmytPPC
	lqU
X-Google-Smtp-Source: AGHT+IHkpkBgJvS1R3RkrtvsvOEZZf/jKPLYOGmrsQsZdhoqLh6xPOUqe8mNaDmp8JgFozGwZ+2Sa6aXZMCU210+49A=
X-Received: by 2002:a17:903:1ac5:b0:215:9ab0:402 with SMTP id
 d9443c01a7336-23c5ffc0004mr6060785ad.18.1751464462881; Wed, 02 Jul 2025
 06:54:22 -0700 (PDT)
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
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com> <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com> <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
In-Reply-To: <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 2 Jul 2025 06:54:10 -0700
X-Gm-Features: Ac12FXydqjoi-wuuZAMsDh9iHHkaJIooZH0B4_yVoZTkA8pqs4QeyD27Ae8Anyg
Message-ID: <CAGtprH9-njcgQjGZvGbbVX+i8D-qPUOkKFHbOWA20962niLTcw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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
	willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:38=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:
>
> On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
> > On Tue, Jun 24, 2025 at 6:08=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
> > >
> > > > Now, I am rebasing my RFC on top of this patchset and it fails in
> > > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> > > > folios in my RFC.
> > > >
> > > > So what is the expected sequence here? The userspace unmaps a DMA
> > > > page and maps it back right away, all from the userspace? The end
> > > > result will be the exactly same which seems useless. And IOMMU TLB
> >
> >  As Jason described, ideally IOMMU just like KVM, should just:
> > 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> > by IOMMU stack
> In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to =
inform
> TDX module about which pages are used by it for DMAs purposes.
> So, if a page is regarded as pinned by TDs for DMA, the TDX module will f=
ail the
> unmap of the pages from S-EPT.
>
> If IOMMU side does not increase refcount, IMHO, some way to indicate that
> certain PFNs are used by TDs for DMA is still required, so guest_memfd ca=
n
> reject the request before attempting the actual unmap.

So it looks like guest_memfd will need an interface with KVM/IOMMU
backends to check if unmapping can succeed. And if unmapping still
fails, there should be a way for KVM/IOMMU backends to kill the TD and
any TDIs bound to that TD.

> Otherwise, the unmap of TD-DMA-pinned pages will fail.
>
> Upon this kind of unmapping failure, it also doesn't help for host to ret=
ry
> unmapping without unpinning from TD.
>

