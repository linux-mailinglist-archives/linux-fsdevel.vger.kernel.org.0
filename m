Return-Path: <linux-fsdevel+bounces-52769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AD7AE65DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D073A6E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3168E2BE7AF;
	Tue, 24 Jun 2025 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O1VND6E1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20852139E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770496; cv=none; b=GvNRBwuVlsfzSusBVI7YM+HljQbIVapqAbnSR0r2Z+Imm+EltW+BzhPS569+bxZrk590E4xjuPA239PISU1nVT+q1jLhIGpBL7quH5q30ef2sH5iP5141/cs/HpSXYlBg6EmWmju2zFf4TGOx25qWzx1145QtP/mPvboN/vwLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770496; c=relaxed/simple;
	bh=UKxlJQaFnl6/rA88dWIe9uoyiDa1SHW784EYsw3dMrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unDcczdDSS1UuHBh0KkyzfCT+fwGz0TnisMVNy1iUHw7j/jr65Wx9w9fnzI0LQRluWprqju2ejqJ1TGselfD6eFPoHqsEnxy30aXjdTTwPLFyvJDzi1Nq8TI4gBrN4u0EtvDIQRYSvWMRVF07FBfn3HnBu5nSP4WANgl50eFzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O1VND6E1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f6d52af7so3662371cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750770494; x=1751375294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iohPe+c6ZnzjeGz7SNDU9v8Z6P04ovt1VqFpt7Vikhc=;
        b=O1VND6E1I1G6Kku1PC3mZll1oGkatGWH0Gu7RfzVgNEWWDT9SJoJyRFRY0EJnv/aTG
         61bm5NxRNyvLrG3bTapG97cYTYJ/gmH5yGOBna3A6CbRMt3St2DPTpF1XsuG+hAY1Lvy
         Drus+CtUuInH4yjnu7e0j4qwl2hVl0WTAhbTTmrCNwmEHheUIvKNMQw3Fh0/o5TQJ0PP
         GhCzJHX8WnzK8nSUGdYENFybJpA5JCJ0U0esgEM2ojsMIwKx2tMiMavIFYXCIIr3PQOY
         rb251LRy97dWdNTnZkH275BrqCqxkln17cPC+0rueoEMSQr602WN8IraD1D4DZ6E6omz
         OITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770494; x=1751375294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iohPe+c6ZnzjeGz7SNDU9v8Z6P04ovt1VqFpt7Vikhc=;
        b=qS80QbhMaSmDbGRyaZJ5rVU586fqZye1yxS7FmyocSVpwpgK77r4Ybl1T5AyuaoT2G
         xmnrR+m8rBsPT0bW+FYjgWwlHiloTrTLjq3t76obp1vUz7idlYiLA0ODlJ4r1X3dlgTq
         76dwbs+uYoEQ+U8CpThI0Xe7QdRLZkYqTYzRgBZe5e4yqEmCt1jnj6SM6ZOxwveosJCt
         LRcvi4YFT04EuETaLRCY0IVo/ok7leIJ31kHZhMGXa/HKCMBwcrB5LBPbTEPAFZUsQ1Z
         U8bnuaM2ZSoCoOujTZEL6hafB/x0MJlU3qVnYEb/zUkuWUyCZk0ihxUgdtMuxfvTMaMG
         Kg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUub1h/G7tTYfHcd1AP6i5N1rMN48X0ZNW5bpF+SPnHJrDezkQ3DBhS2lQBMMKKfMv8LJfroasUDA9OyT6a@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHDUDUBgIC8O73Wjzw3y9+oGzJUbK2Jf+CsCFRzwrrFP1iHe7
	1a+epBzDnp8BkD4KT/9r/AuvcHTG3yeDFQbVRNWumOC61AwcoBZ1Zq1MciY3pTDbDA8=
X-Gm-Gg: ASbGncunE8LQOUzCp/zmP5yPx2O70lP8teLcqGiPQagY6X+xyvU/KErehtq++10Pr7W
	z/2rfvZVKSvYXJlmo8fZpIuyHeG5c1cciMo4zaSfuaDLEnTZcvkF12IBwffs5aPY6S4coPyuDAV
	RUvSrXZ7sGd10+FEykXjePqGcBehROllENBg9AUQSm1UfynXwIZvKNk0cB9c1QqyaOWo79i0AFq
	cpS7NKvzBzXbt1zFGfhzHdEJXQiVmEPCb0NdPAtFIn/Jt2BTQO/2L24/MrNp4svwVpSTq6vAMhv
	ETFBnjb8UJPXuwv1SdkMw0WrKXDqQ807UbE0y3d79sWsPYywMAfdr+KCccsMMtRvbCw/QhDUBeD
	W3i1diXWz4FUTilma/iJqNdDhKp80WpHK3erNfg==
X-Google-Smtp-Source: AGHT+IHef3kdB4cDi6psPYyte+3aNmtbl/eIlBlt7fvZpJKrO+q9+X8gBnos6r+TRXvWNp7iSK1pIg==
X-Received: by 2002:a05:620a:1a06:b0:7c5:562d:cd02 with SMTP id af79cd13be357-7d3f992de50mr2307168585a.41.1750770493042;
        Tue, 24 Jun 2025 06:08:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99a80adsm499866985a.46.2025.06.24.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 06:08:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uU3Nj-00000000dPJ-362W;
	Tue, 24 Jun 2025 10:08:11 -0300
Date: Tue, 24 Jun 2025 10:08:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Fuad Tabba <tabba@google.com>,
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
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Message-ID: <20250624130811.GB72557@ziepe.ca>
References: <cover.1747264138.git.ackerleytng@google.com>
 <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>

On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:

> Now, I am rebasing my RFC on top of this patchset and it fails in
> kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> folios in my RFC.
> 
> So what is the expected sequence here? The userspace unmaps a DMA
> page and maps it back right away, all from the userspace? The end
> result will be the exactly same which seems useless. And IOMMU TLB
> is going to be flushed on a page conversion anyway (the RMPUPDATE
> instruction does that). All this is about AMD's x86 though.

The iommu should not be using the VMA to manage the mapping. It should
be directly linked to the guestmemfd in some way that does not disturb
its operations. I imagine there would be some kind of invalidation
callback directly to the iommu.

Presumably that invalidation call back can include a reason for the
invalidation (addr change, shared/private conversion, etc)

I'm not sure how we will figure out which case is which but guestmemfd
should allow the iommu to plug in either invalidation scheme..

Probably invalidation should be a global to the FD thing, I imagine
that once invalidation is established the iommu will not be
incrementing page refcounts.

Jason

