Return-Path: <linux-fsdevel+bounces-55435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAEB0A5F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 16:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD71C80689
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BAD2DAFA5;
	Fri, 18 Jul 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mjuTHAEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618F126BF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848164; cv=none; b=qYQJ3D58UyIne2HR4KkQMIvdauJCydayMD7FzeQmAboQx6XU7hVhIKpOkABnxBqxF3iST9GpFQ+7c2VEh/sP5ZHpT5QmpYlWJC5zbI/70ALjSzZ6ay6JrNZ/63fgVlamA2BtV2v2xZ8CY86MwnV9sm0CJedYNYs1Qm7fSQxTuzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848164; c=relaxed/simple;
	bh=5XaE7447C9RAX+GCeN/Jf+zei+sDppnkuDDAOZmhiks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7FKayYxzxgdwwYsvgSxihJKVJLwmCA1teZnYDNDOM4k++IM72Jgh0MAg2/ZG5h9Klb2K/cVeH/aK/WOZ+qWTP5/boVVWcQ9YjdMASigzezdkHvcFDr0S/HrNXx1QV3o1DOo+Z9O0bA1oElp3/9XGEGUK3oGqQwPz7KccbvtCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mjuTHAEj; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7dfff5327fbso281827785a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752848161; x=1753452961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJjLE0UVkZ2mMP5n5MQpEv3lHcI2vw7mI8TTF/9jzI8=;
        b=mjuTHAEjVq9p5tT8aL15EowHfiE0HRBl1kHUhR4vjvid5WGvdE1A4t0A5Z8qr6I6QW
         /z/f7E3OQ32u+SyRmENMHHZzyOTH7GxekIJw3eirlyDwQEPXOFZ6qJFrSddBUIxLNOyM
         +vZpu1BZ/94olJTltKu1beswOjBohsX3XseZnNgakttKudd1QONXGAwPoc4sVMsh12qy
         lfoQeA67xQlCaOJboBLwqomDfcqvggK31eJGO1RKMlCd5WA0UNbLZ8rcLmVhYXE6ivU1
         bEz518hj1PxuEOCjb9CZe4MvyWIrsNgzCQ6gQPaTrglgCIVPIAAbQQIQaWoAutow7MPV
         hfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848161; x=1753452961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJjLE0UVkZ2mMP5n5MQpEv3lHcI2vw7mI8TTF/9jzI8=;
        b=aPnKNPber9ZMYBcr9CGyUkEShXC/k7/XUYwx9+iNf5xDm9E7yO7MptyiHxoKeZHEiN
         7UOs0HqqBFngDoR9+22eb8lalnbyCA1NLiDySZJhvelmy8ttmoySU5r/Joq60g7453lQ
         INc/Onv7Bk2u+FRgDkv/GQQQolgbdAwbDGYgbMlAeU94OczYDSW1/flrEqDSrVOnvt1L
         efcNXCEoo2wxqcsYLLxFWUKIp2rghYWKcQVDUkh5Uwr+T8y3ubihoICu1XjjykKUSFi7
         jbTz5wbmQPMyHFua2ptxS/G38CepTb8N3kEgFRX73/ckmthxzT210g2H7uwHWJSjo4AS
         XmNw==
X-Forwarded-Encrypted: i=1; AJvYcCXx4lf3YpuBwH+EA+4ms8aPwwzeLYPx1KVZ8pitzZm8IK7dq1JSaL1nmLYvcJI+kbxDcYwgY4flveD11Wkf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jMZtU6/Eiv7bGicxfPAyaMmkwbsUO1W221jNORjA+USuB3vn
	bWaYzDQflRZ2izA0A6SENI3XDZ2YnKRbHAQ/wrG1ir+eUpAHbaNZpalC4wSMdOy3cA0=
X-Gm-Gg: ASbGnctyLFTVQUjk3EFKpaPAqGNf505uAQ7pN1SOFsq42/44P0m2DGMHflDSAN+qC+H
	Q6aIZUezVMJIO3P593Vso55ijBSMk/yYZBw1n+hQJjvGiQgU77N9U98CJ6RM1OeabyvseNwKBto
	Nn8XaKeZ3L6RJX/5R7hKaLpp26BYY8VpI6F482nExXB1TV3F4siP/XUvczrP7ToWmTUoBZsAtp1
	4p/vY4UU8U7ffxmRt/R/Sh8YZy7E/UWa+5p6YF/8MD2FLkaXhCMSuUzNqs1iAmQ8bdGXznf+WBb
	lVZT0NCodn7kqjBPcM8j0E2h9XM+tNW1NB2uEz7ihfsjBvSZKTY07v/KztLq1PC0Y++bjiXUkRW
	LYkz250VK+H0OxHsBsvPKofFTJtG3HzToZ//+aRyJBPPCpBVIfmLRseeRhv0EZqsUf+sv3wz/DA
	==
X-Google-Smtp-Source: AGHT+IH83itoUa8qKHB+I069li42G5fh0+8tV6hdT0Ya4bqMV1JxQTP8HGjKpE/oLQZTw/kkZxIAXw==
X-Received: by 2002:a05:620a:4410:b0:7e1:9769:97c4 with SMTP id af79cd13be357-7e343613265mr1502291985a.47.1752848160939;
        Fri, 18 Jul 2025 07:16:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c649c0sm91045985a.73.2025.07.18.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:16:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uclsV-00000009zBs-2Dun;
	Fri, 18 Jul 2025 11:15:59 -0300
Date: Fri, 18 Jul 2025 11:15:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Yan Zhao <yan.y.zhao@intel.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
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
Message-ID: <20250718141559.GF2206214@ziepe.ca>
References: <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
 <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050>
 <diqzqzyeg3j2.fsf@ackerleytng-ctop.c.googlers.com>
 <aHm2F95XwzdD7nod@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHm2F95XwzdD7nod@yilunxu-OptiPlex-7050>

On Fri, Jul 18, 2025 at 10:48:55AM +0800, Xu Yilun wrote:
> > If by the time KVM gets the conversion request, the page is unpinned,
> > then we're all good, right?
> 
> Yes, unless guest doesn't unpin the page first by mistake. Guest would
> invoke a fw call tdg.mem.page.release to unpin the page before
> KVM_HC_MAP_GPA_RANGE.

What does guest pinning mean?

Jason

