Return-Path: <linux-fsdevel+bounces-63321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A93BB4EAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 20:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E467F423053
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B6A27A927;
	Thu,  2 Oct 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqO99X8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36D2798EB
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430600; cv=none; b=utWwe2YOEQttAtHSrFmVqb/uhStiA5kGvEHE3emkgrYWaW1cQhEpl/jePXwqDt31i6L2fJD6IbYRF/MMMg1beIjll9oH7FzirBHtLcv2P8sBVKvfOH9KTrW17Y2NV4LkGAticc/cM7hH6ioGDwBMeb/qIBM4NwQDaEurT0xeMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430600; c=relaxed/simple;
	bh=7XyovT+QBcLHy4MPeRdMb9YVKvCLLkVo5ozVSgotKL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJB3LI6UNeeYtug671XaWmi8B3TnXSmpOzTPhKaAomFD1SKNWnlafKzOISyU2zKjOS8yO5nuISzV7FtKU0XhAXxM4t0Ey073oSE0P7hYIcoJult4gHcbbyl/demyoj8dyH5KvNmhTdDFCmzVaY45OOXGLGRFH1xFIzhwag5PisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqO99X8y; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so1924968a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759430599; x=1760035399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BF36+HuAPUu3G3takel+0xxVXkuZOozonOLvpYNbbPY=;
        b=qqO99X8y6qg49Wscwnp9bCnBcPS9Be231Uxq6bMjkgNvQax9ftGS9ia1cQQCGbJKeg
         tFqyVDiRO9FoJjQZ5AJ1yjGhnv2dIxazp+Haa0hUVq2908nOTCGf+ZtBJlt9QFH2VEcr
         ur5dx0wEL/Usa1H4oNWx8JvNFSld+o56OwEpZiqCJxJGPqYoctIgN0cSgrXVhG+oPpBd
         qwRJss/REAsITUNIfnHt+r1qlp3lohMxhS4NvIqnZvwi1s95O/5D6ga2zDmuLyjwrZST
         SBq/tQu3CmjcIswZpP0Qkzjgnr6oEfs4/f0C+bKFDnix5chgE25x7vg+DAaj4a9GFa2j
         OLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430599; x=1760035399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BF36+HuAPUu3G3takel+0xxVXkuZOozonOLvpYNbbPY=;
        b=g1S2jtD6Tv3BBpjPoDGoEP+3pgkDwCPFIaJgoGzR3tbv529SjvD9LQ0tHwBqPqWh/n
         NHnun0Q48fMWKMUEkHvPhPlAdr8xlbr+HH0UdLnBmNWvbAZ8J35xZvQ7CazmjmdOznqY
         KxtSLCUQEOnyD29lxTuRB1WkZeVZm+RK0NEzpkNDQMT6Aodt0KCIBn2s9jD5CDb7MKwl
         qT3Pq/n0zyr3WymxMHMDEd8fN5siwNEZF1Jb8FNZGLZsCeEkUFZTQ8pKGR5iqxPhY2L6
         zJVBy06kgN6wo4BVxl1LklPa8I38480DFR5KXfxh/dlpYNCfRT1Gx7FNWs4jgiKehUBs
         ftPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz21I5hqn6ls1+5BamwKtpiMWNSm0f7m3XbH3OWGDAWBUTWcOjberhHUxuFDId4ZeEzEIGtAJy/50xGjfg@vger.kernel.org
X-Gm-Message-State: AOJu0YxPC4JCmyeaWlrC/p+SdmArZ9nzkCrQEj/WRfrVzpvrALDh7YK7
	cWsuqWV5LVBCQRqCopjI91QJgcq5htugPCajY9KAvty6xana/Gkm/dB9kNf2mDRSGhcdH6AFIcY
	wzKpxpQ==
X-Google-Smtp-Source: AGHT+IHzKP+mkTV9r2F6im0ZZKYHqqWZ0dx4/6eJaCqR+H+7NxXGm68uyuJOAHQ9Qymj9O+tm0fETNVF/Vk=
X-Received: from pjre16.prod.google.com ([2002:a17:90a:b390:b0:330:a006:a384])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8c:b0:32b:cb05:849a
 with SMTP id 98e67ed59e1d1-339c27bc475mr438569a91.29.1759430598389; Thu, 02
 Oct 2025 11:43:18 -0700 (PDT)
Date: Thu, 2 Oct 2025 11:43:16 -0700
In-Reply-To: <09e75529c3f844b1bb4dd5a096ed4160905fca7f.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <09e75529c3f844b1bb4dd5a096ed4160905fca7f.1747264138.git.ackerleytng@google.com>
Message-ID: <aN7HxBgFwm2B7Cv3@google.com>
Subject: Re: [RFC PATCH v2 11/51] KVM: selftests: Allow cleanup of ucall_pool
 from host
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
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
	rppt@kernel.org, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 14, 2025, Ackerley Tng wrote:
> Many selftests use GUEST_DONE() to signal the end of guest code, which
> is handled in userspace. In most tests, the test exits and there is no
> need to clean up the ucall_pool->in_use bitmap.
> 
> If there are many guest code functions using GUEST_DONE(), or of guest
> code functions are run many times, the ucall_pool->in_use bitmap will
> fill up, causing later runs of the same guest code function to fail.
> 
> This patch allows ucall_free() to be called from userspace on uc.hva,
> which will unset and free the correct struct ucall in the pool,
> allowing ucalls to continue being used.

NAK.

The ucall thing isn't an issue with GUEST_DONE(), it's a general issue with not
completing a ucall.  The simple answer here is to not abuse GUEST_xxx().

I tried doing the same thing (jumping back to a guest's entry point) in what is
now the mmu_stress_test, and it didn't end well.  Restoring just registers mostly
works on x86, but it's not foolproof even there.  And on other architectures, the
approach is even less viable (IIRC).  E.g. if the guest code touches *anything*
that's not saved/restore, the test is hosed.

In short, while clever, the approach just doesn't work. Which is why I don't want
ucall_free() to exist: it's only useful for a pattern that is deeply flawed.

The easiest alternative is to use GUEST_SYNC(), have the guest code loop, and
use global variables to pass data.  It's ugly, but it works and is much less likely
to have arch specific quirks.   The worst of the ugliness can be mitigated by
using a struct to pass info, e.g. so that you only have to do one "sync global"
call.

