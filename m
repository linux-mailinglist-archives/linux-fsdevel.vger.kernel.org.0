Return-Path: <linux-fsdevel+bounces-53661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E6AF5AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7EB482DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113D2BE7DB;
	Wed,  2 Jul 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b2PaRKIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A66FC5
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465606; cv=none; b=A1Of8hTWCIK6W22tyIoCW+YFly1Fw1OPi9rCHhDQqBfLllNsEvj7Cy/j078POvDgGgDLDafvp4z4PTntnyaO2JoclwIv8J4o4YFzQHxtkCZS6vD0+sRzko5x2kJ6PIG4P9ots7R4za+sWrY7UGrjKu0gNZxuUoV/6RkwYTV75Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465606; c=relaxed/simple;
	bh=T2cbnqQkqCu7yJ1ibRZfqew237LIDEtBM6zvXy3oISY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euPvtPzZPLVU/O/icuFkyThurpCCFP1sXGeIOwnWAiOJhul2SD+FuelZsilOOqWXi2xtv2XixTI7KHpees8Gk0M0sr5S2I0fDXN6ZaHE/RQzy5yhyXEW+V32QCG283pnbWuXUVwitHxVW/cdrgenSBJCHjv4T+pOkXs8DhIWgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b2PaRKIH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58c2430edso72444021cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751465603; x=1752070403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LI2D5V4EggMWsDP/C9ghbDqwYMTHQ8Upr7Uk1D8akao=;
        b=b2PaRKIHNS83igXP3/qMRz9J+6Llacyao2+jWyTXEBLy23E7u50tuB07aAONdHK9yL
         bX6+QsJpcwBlZLT2r8WVVztPiB+myLlg/aIdcKA/FYrZcjPkILIfLj8XW6Nf6G/5PEbw
         EzaantsYhzeHe8POJSFwxpkYtrUDw29BoFk2YFyWDT4hHvxBgb31szrd2dciGRriPgR7
         m5pyxwkgzLt5iYIUWEWHMbQum8TgivKQYkrO4Od5Kwk2igFFwXQk6eGAdtlCecUACW6i
         MAjXjqj2HpeTts1286h2hQSY0HmKB++2IOIgseGHYcqoCu2zokua7GnnucQQgnSanEsC
         5W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465603; x=1752070403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LI2D5V4EggMWsDP/C9ghbDqwYMTHQ8Upr7Uk1D8akao=;
        b=Yx3QGA/D4n3hHQow3fepTDC05Wh9iHS9S6ibHFRgkXr1BWU7+Mtnw/iJCPuBHYuSWx
         axq5kTTQavU2PovMkvlICmvC0ZzDGtwBjUfThp3mrJlbv4e3Y6q3OQPE631fwExpyO4x
         SNkMCaRu44MVnHE2j1gj3msHN+lXbOuxj9KOpbow+KcLuLR72Jfp40wSthCqgMAfmIH4
         5Yvwo+nxfId8qlZIJ0mb6tUNNh2zsnJwTQNGeFi5UpZJeARq2It7dEdqUfLVlWKHX0jj
         bBDrboh5QRAv1Rhu+jaA9hFWuF69BJC2xfeHIY5jpf/TG9/XbF6RYgh0MrZBlj3Lzw9j
         tDQw==
X-Forwarded-Encrypted: i=1; AJvYcCUin70CBu0paAkiF+apRFwBzRsxWpyCZ5nuu6Q0QKsNiQCUGXiZEkcykK7+IktOdLT5h83+zyd4u8OH+1Hh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+gi4LaF3qD3rQSLFp6j2SBcA4iadfQuPi4hp4UV8gviDFS++
	fD7+qC8cvqQRnzavHEYe3qVO4p5mdXBL47PdtiMtIt8HhieI8JmGfyPkTpxr7wnfMPQ=
X-Gm-Gg: ASbGnctQDwGeEbKbM1KWdeSQNL7kLw85Voa1Eqi+X7chJbO9m4sGi0cWSkpP0y0nbUQ
	js6tY7c0VC6MDthaB9WII3lgHX2VqIvTO0LMgX6vXDse4qJIB4byAIVyPGyv0UW3yej9gFqCeNZ
	ELdXcy08qGNq+ltJsAqFwC4F5SX0NMrdjpcWTgkVNbO8+QZLwhsjhvKulSm7KpO+q5enPXJJchF
	glLZja7J4dQ1Zw0wPHIDSlLSRbjf+fbQgu9Ha2Mmdm00NLVW/0Kz9mjO46jRxUm10o1zTyr3x6Y
	xOsutKDX02cyPo2wu5d1mxRTwHWK0uwECqjX
X-Google-Smtp-Source: AGHT+IFGejWlBdta72VP8k4wECxNZ4C8RRbrgrTD+eMk+Zg9yBG/xm3+F7tKfuIfEoyh6KMev8oSSw==
X-Received: by 2002:a05:622a:1109:b0:4a7:81f6:331e with SMTP id d75a77b69052e-4a977bdec57mr34518361cf.6.1751465603229;
        Wed, 02 Jul 2025 07:13:23 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc1061d3sm92215001cf.15.2025.07.02.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:13:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uWyDB-00000004jk4-3JNi;
	Wed, 02 Jul 2025 11:13:21 -0300
Date: Wed, 2 Jul 2025 11:13:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Fuad Tabba <tabba@google.com>,
	Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com,
	akpm@linux-foundation.org, amoorthy@google.com,
	anthony.yznaga@oracle.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, bfoster@redhat.com,
	binbin.wu@linux.intel.com, brauner@kernel.org,
	catalin.marinas@arm.com, chao.p.peng@intel.com,
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com,
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, graf@amazon.com,
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
	james.morse@arm.com, jarkko@kernel.org, jgowans@amazon.com,
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com,
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com,
	kent.overstreet@linux.dev, kirill.shutemov@intel.com,
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev,
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
	palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
	pbonzini@redhat.com, pdurrant@amazon.co.uk, peterx@redhat.com,
	pgonda@google.com, pvorel@suse.cz, qperret@google.com,
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
	quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com,
	quic_tsoni@quicinc.com, richard.weiyang@gmail.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com,
	shuah@kernel.org, steven.price@arm.com, steven.sistare@oracle.com,
	suzuki.poulose@arm.com, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
	willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com,
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Message-ID: <20250702141321.GC904431@ziepe.ca>
References: <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <CAGtprH9-njcgQjGZvGbbVX+i8D-qPUOkKFHbOWA20962niLTcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH9-njcgQjGZvGbbVX+i8D-qPUOkKFHbOWA20962niLTcw@mail.gmail.com>

On Wed, Jul 02, 2025 at 06:54:10AM -0700, Vishal Annapurve wrote:
> On Wed, Jul 2, 2025 at 1:38 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> >
> > On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
> > > On Tue, Jun 24, 2025 at 6:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
> > > >
> > > > > Now, I am rebasing my RFC on top of this patchset and it fails in
> > > > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> > > > > folios in my RFC.
> > > > >
> > > > > So what is the expected sequence here? The userspace unmaps a DMA
> > > > > page and maps it back right away, all from the userspace? The end
> > > > > result will be the exactly same which seems useless. And IOMMU TLB
> > >
> > >  As Jason described, ideally IOMMU just like KVM, should just:
> > > 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> > > by IOMMU stack
> > In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to inform
> > TDX module about which pages are used by it for DMAs purposes.
> > So, if a page is regarded as pinned by TDs for DMA, the TDX module will fail the
> > unmap of the pages from S-EPT.

I don't see this as having much to do with iommufd.

iommufd will somehow support the T=1 iommu inside the TDX module but
it won't have an IOAS for it since the VMM does not control the
translation.

The discussion here is for the T=0 iommu which is controlled by
iommufd and does have an IOAS. It should be popoulated with all the
shared pages from the guestmemfd.

> > If IOMMU side does not increase refcount, IMHO, some way to indicate that
> > certain PFNs are used by TDs for DMA is still required, so guest_memfd can
> > reject the request before attempting the actual unmap.

This has to be delt with between the TDX module and KVM. When KVM
gives pages to become secure it may not be able to get them back..

This problem has nothing to do with iommufd.

But generally I expect that the T=1 iommu follows the S-EPT entirely
and there is no notion of pages "locked for dma". If DMA is ongoing
and a page is made non-secure then the DMA fails.

Obviously in a mode where there is a vPCI device we will need all the
pages to be pinned in the guestmemfd to prevent any kind of
migrations. Only shared/private conversions should change the page
around.

Maybe this needs to be an integral functionality in guestmemfd?

Jason

