Return-Path: <linux-fsdevel+bounces-64557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E425BEC027
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 01:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14A804E7A93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 23:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150472F12CC;
	Fri, 17 Oct 2025 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBbgnEg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D42DA77E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744024; cv=none; b=LwspJtFjsTPkK83dlyr0CxC3P/CUzz8t7cA0aAzmYhZ346SSF3wTAgZA3A7d0I1IxI4WGd1u9DlGv7aK0Tv8IdY4REw6m9S7RBm9fT+NgsSMSy/u0X6nRgtFtFPmRkSPQR5u/AbW7wAsqEYkWUr59LpBWXwktytuDqlNH3fs7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744024; c=relaxed/simple;
	bh=O4poxL3uV+mMir/NtnbsQIIOJ7Lzn0S5rcHjXTbpNqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cBVJocpb0rqUNVqy6azNiz4yZ8vH4M6bEFER4j3XDdOvbc4UMQM8CXw+QT1vEfP5SzEt1fwFuREdqr+4VBaH3Ww2VBshSf52Tt5RKnG1Gx5kIPqUczNMZEQ+Pycy6DPYgGPQuvqBaFi/KTkaiUIGdSxuysbo482oxtwRCpVp8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBbgnEg6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befbbaso2925399a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760744020; x=1761348820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwfPpMJqaisEQVUu9wiIDJQK1raYpWFG3P+DdjsMb18=;
        b=HBbgnEg6RbTmkM0oHDhclWTglR9/RcvlluitBHJlbWV+6iQLqgU3Jax56TCvgjYTEd
         IER/G2+2FrtFGXFQSxYiwfG1MF3ty65zfiCKQlgHYEbod7W5kAVd68VNoamcycl2HeaM
         bj454Ytv83+xSufqfkEo039p5LLoCFYihXQ27Qwh0KFDqAylAzAhzdsDcbGosHkW/2qy
         n6LKmJRHok2Bu+LaOFqzEYNNKYZSrgLJJABXzjVeNJYflK1KArnj03ujkACwJ9m/euoA
         WsENt9WdJxyNlSmhdryHCrUDJCXgn90qiy2HjAWUGCovXjN97hT3ZMfVQVbvh76uxLXc
         /Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760744020; x=1761348820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwfPpMJqaisEQVUu9wiIDJQK1raYpWFG3P+DdjsMb18=;
        b=Rrb1I1DO/HMOPp4NxDM6hW23dzLl+ODx4NvhMNU/14AxfbE1qzgVehvSyhIsdrcb5R
         DlUdjzaBXKqLKsQSSHbEl5C4HE0QQahHuw69yFD3K5ta6nq19k5qw3EINI1JYZYZpsXz
         twlcLGes4rutBIhT57+ELqtDorZAuzACRDgPTn8Eh7Ex7OHHu9TF34qPw1hNWX8WC0xf
         DqTP5e39+N8rHI42JlRbEfOHEhYWaTjoaKTtXL7JFfbOP1i+mf7C08cz/T2pvXEJ3f4r
         5h3Hd0Jwo+sL5Cn9EEYIwJDgs+P4wlquHzoHyzPnUqA7Js57I5upLBFLRZCHlW0H4kso
         We3A==
X-Forwarded-Encrypted: i=1; AJvYcCUe9Md6cG+X94A8jUFGiuJIrp2niK/GE0dFgjBrfgvF3g93DjON0X9jqrBuPiysjHfdUKHn/c81koqo2hL/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1MLZG9AgeLlZePzUK/ntRKH6y823wOjXKCXf74S3ivTZVgCa
	ilqBaK8iwEifuCFR/O/ydkPKbvrSpTCC+8M3ghyGlhoG+GbkcpquJExOQVWeuwtEVVnZjE/7C89
	yyUkRJGduMOq2VuNyg02tUa3aNA==
X-Google-Smtp-Source: AGHT+IEJkm1Y/xUQeOW9OSrw7fOIA8LhUvRSTlkRcfM+UNWeMSJmrld0H6KUJsXbTWNmxyDTB1XySSWqNmUDg7YYhA==
X-Received: from pjtn11.prod.google.com ([2002:a17:90a:c68b:b0:32b:8eda:24e8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d88:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-33bcf90e86cmr6755629a91.34.1760744020326;
 Fri, 17 Oct 2025 16:33:40 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:33:38 -0700
In-Reply-To: <bb336979b10ee5b9c6b3c3934ec3aff19330b3e7.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <bb336979b10ee5b9c6b3c3934ec3aff19330b3e7.1760731772.git.ackerleytng@google.com>
Message-ID: <diqzcy6lp0h9.fsf@google.com>
Subject: Re: [RFC PATCH v1 26/37] KVM: selftests: guest_memfd: Test that
 shared/private status is consistent across processes
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maobibo@loongson.cn, 
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org, 
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, 
	qperret@google.com, richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org, 
	steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, wyihan@google.com, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> From: Sean Christopherson <seanjc@google.com>
>
> Add a test to verify that a guest_memfd's shared/private status is
> consistent across processes.
>

Missed copying Sean's note from [1]. Rephrased:

Test that on shared to private conversion, any shared pages previously
mapped in any process are unmapped from all processes.

[1] https://lore.kernel.org/all/aN7U1ewx8dNOKl1n@google.com/

> The test forks a child process after creating the shared guest_memfd
> region so that the second process exists alongside the main process for the
> entire test.
>
> The processes then take turns to access memory to check that the
> shared/private status is consistent across processes.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  .../kvm/guest_memfd_conversions_test.c        | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> 
> [...snip...]
> 

