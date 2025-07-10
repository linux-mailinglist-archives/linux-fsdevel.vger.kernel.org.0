Return-Path: <linux-fsdevel+bounces-54543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B0B00AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE1B4E340A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB142F4A1B;
	Thu, 10 Jul 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XHBQaFvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E862F1FD6
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170342; cv=none; b=u8yyJxjEWJSL7T2YM1Tf8XZsNeNZ3V5d03mi1t8VOc1AQ8GylcKYs5agCUfnbrXT6b2N5JGO9TDd5fslk7GRLpwVHxI3D5kvGoHCVogRofaDdVKEpbYPQfKv5VbevrwTjUVWo9WS/lCoXDRT6nDm5vif1EEc6DjlftGfGckSwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170342; c=relaxed/simple;
	bh=gLPvs5+RdTSlZIaCs47AFBkItVYL7SyZ9thIkYN5Zw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkup011v7NvUa7DLKdEvgXvxUrcvj9P0PvZcrVStj6QGtR9WAHfj2U2/aqghtP2nIiuZb0nA/vOMEXxapCxOFD8vhpfPnObrKw0s5rvKiq5df8sf7uib3JFxhy30Re8IMKBK69R7+/bvgM6TN0B6hkoB2mEsLe1LP8O1ax+U1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XHBQaFvP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236470b2dceso13142915ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752170340; x=1752775140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLPvs5+RdTSlZIaCs47AFBkItVYL7SyZ9thIkYN5Zw4=;
        b=XHBQaFvPWERoQNfUPE+zxG7PgAD5HW3hss1V6nZjJt0bzQA92vJEQ/ZMRDorl++IhT
         V2OziG+V7hGucwRj+W5gFxEfaTFE7cODtwJJeFe0f7SEf2G7000yhXnsPdS2O8fWUdJ5
         8U/RhKqGk0AytqKMCenGYM6weZR5p5NLINSjlHHltuBe91skLJBceuMkOh7C2U0XjIdk
         jh43jvpb03KqG4hxugNurUxsA5FguOZ4L7sCHaUKWfljiEuCJ40bpDkyuqUSK3IopeGc
         H4+9nGmqHnTlIpcLH9K2LP8pSpiqTMfYihmNuQDF/y5f4pLeOMi5L5VLFmBfkDi/7KRJ
         tiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752170340; x=1752775140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLPvs5+RdTSlZIaCs47AFBkItVYL7SyZ9thIkYN5Zw4=;
        b=C4acvxOe8iIsOoGkKBUL5uCU5uuDed0sGxvXv39SPvnDeJtfRtk1lZcXI0qzN5tLoj
         P8iKcBwKgYoH1P95T5yHRPzp4pTbNDloh7TzuvYlfd0ZQwADd7b3SSXNjpmgL/HmAo7J
         3jV2lffOxzfn+v3oIL8RBGEqSCngkIamNrqMND6t/X3TX5KjWswIm6FrvsIGhqFbnUPd
         2j9Kpwpcn33HUsdAT13yxabb1iyV+6wzjTFtpw2mYkbWhz12H+wzczuc6MaasPL8k2gJ
         TkfY2F0N8Gk+ePMXogpo5dST2srgcVsZhQIRAuzCr2ePV6bEgtttU229DXkfKbiU40z9
         NHfA==
X-Forwarded-Encrypted: i=1; AJvYcCVBseYsUsuuVlhAvLIOw4OR8TtIzTqnYUzFMBDbkrQ9URio4L3yxY/ppc1aoQ1eRzT1cdCjtTZfDcIvkV7J@vger.kernel.org
X-Gm-Message-State: AOJu0YzVAJEKe5neUWLRx0YtCIxiy7CGRknJaiGid6O2fz63izU3M8wC
	2KqM7kusNdR4jy8JcCCRFOSIN2p26SnRinsD2pVbp+aL0ef2Llgi1fQF5I9AtNfIVjI=
X-Gm-Gg: ASbGnct4iwtVkr4j9q4V8maWrgnHwHgZXhdWvKqCkcNO6hLxMqc0fYmupGiBSWRFNsI
	U/QVmlHB9iUx0DHiBNXIGoE864AT5hh+6E5yz2np2Z5EKE5SQ95k4+/xrV1pYHECnM3/wdc3OTG
	otkH5iPL+imuW92q/Dj9HDcp3COx08HnTxb2LfB+nRL/Jm4qbPPN69MoepAKUaAOQBLiojSlMR6
	rCjA6oC6U+gQKfkoRInr3yMsLR2LfjoQP6XxDBp0SDwDbXQ6P3aocGQ3bDH/8YG7zGGB/+ColoE
	L7NG0+qSNWmL3NRwnf+qNYby9h8X41d+WPRK
X-Google-Smtp-Source: AGHT+IGsdYCi7RfWhcH25FuRFcSoC6JS2JrRDFNCNj7y5398JhpEwT92bbA8QjM5IB5UpkxovQPYtQ==
X-Received: by 2002:a17:902:e78d:b0:234:a139:1215 with SMTP id d9443c01a7336-23dee28fa46mr823515ad.35.1752170340041;
        Thu, 10 Jul 2025 10:59:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aef8fsm29025605ad.76.2025.07.10.10.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:58:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uZvXu-00000007x6B-22YZ;
	Thu, 10 Jul 2025 14:58:58 -0300
Date: Thu, 10 Jul 2025 14:58:58 -0300
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
Message-ID: <20250710175858.GB1870174@ziepe.ca>
References: <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <31beeed3-b1be-439b-8a5b-db8c06dadc30@amd.com>
 <CAGtprH9gojp6hit2SZ0jJBJnzuRvpfRhSa334UhAMFYPZzp4PA@mail.gmail.com>
 <8f04f1df-d68d-4ef8-b176-595bbf00a9d1@amd.com>
 <CAGtprH-KhEM6=zegq-36yomZ8PX22EmaZpMPkLnkyzn51EF25w@mail.gmail.com>
 <09db374e-fa7d-4c1d-bf03-aaaafd93bd01@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09db374e-fa7d-4c1d-bf03-aaaafd93bd01@amd.com>

On Thu, Jul 10, 2025 at 04:57:25PM +1000, Alexey Kardashevskiy wrote:

> Currently I handle this from the KVM with a hack to get IOPDE from
> AMD IOMMU so both 2MB RMP entry and IOPDE entries are smashed in one
> go in one of many firmwares running on EPYC, and atm this is too
> hacky to be posted even as an RFC. This likely needs to move to
> IOMMUFD then (via some callbacks) which could call AMD IOMMU which
> then would call that firmware (called "TMPM" and it is not the PSP
> which is "TSM), probably. Thanks,

Wasn't the issue with the iommu that it needed to have a PTE break
whenever the shared/private changed in the RMP? Because the HW can't
handle an IOPTE that crosses more than one RMP entry? Or do I
misunderstand the problem?

If this is the problem I was expecting the page table code that
translates the guest memfd into the iommu PTEs would respect the
shared/private conversion boundaries and break up the PTEs
automatically.

I had thought there were three versions of of how to copy from guest
memfd into the IOPTEs:
 - HW must never have a private physaddr in an IOPTE
 - HW must have IOPTEs entirely private or shared
 - HW handles everything and IOPTEs should be maximally sized

Is this right? Is AMD #2?

Jason

