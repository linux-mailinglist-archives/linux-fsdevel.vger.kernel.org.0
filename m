Return-Path: <linux-fsdevel+bounces-17700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E18B18AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C921F24BB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9852107A6;
	Thu, 25 Apr 2024 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKH8/s3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0414107A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010344; cv=none; b=fSJ7ktSzCRV6c4oPvwA5Fz+/OZoASPfDsQxgNWW9PeLMUeEspoD9FgB+xsaQG/c0PR3gtxWh/zPSjPkHFgyQ1DYIIKbYK5UvhQlPo1j7Rh9kgfYhlYsN/Oyye/4MsU93BRS2yVo/T5eAcv6jFuSKqsB+MA2BFkytUKRbpeYpcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010344; c=relaxed/simple;
	bh=p/cGThLZ3QnfmTN7NW9NTr5bcTYchPjUIQ6WCPhs4IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7qGIqFE5RJQn4LHzclEYqqwzN0TsERQxOl5LFfzXE0ELiJXABDmPt2N9AuDAks+DuO2usNhcOjhpuxwcbRp8YrDZV5/aHQ6aORm4xA4tULnoJNXJbTpTgcN5menaIK8kqY3EVhgniigScaoPIOszJkHS3Jd6Nch6q2YL5va7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DKH8/s3J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e65a1370b7so4360335ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 18:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714010342; x=1714615142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4qlJ+DG6HoUrdCik4e+F/ZipKmWdndDCcmvcXd31J0=;
        b=DKH8/s3JRXewO3uRlUu4fCoood6Fz58WtrLazwyrSzra0mwJ9mITfxLQXdn+2npsKd
         AatPjRBUoHypnwwljhYrMkOBSBRQ25yB0gdmKwZCLwWouMGpc1BCWIwfh3ujF+UbXo0+
         jbQQehQ52/2q73gd0IoDWpbdw+s06PcKXfokQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714010342; x=1714615142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4qlJ+DG6HoUrdCik4e+F/ZipKmWdndDCcmvcXd31J0=;
        b=dJ+cQUBWT/tsT5FG/+DcWjD0Rkn4R5VRpUzrUMR0vT3KYGcekvMwLQSSs/BZi9XY7z
         8upJeiCEd6bMgF/8Nq5Bz89x5D7TaDsWMT5R7h567zoPLXz9wzDRbFGndElDG0Lz9alI
         Ch9c+YWqh1hxsdyvej11eXGB+yahHIZftBZxf731GC0pIhzZ6RsoYxVhJBW9PyfdKdr2
         ewT6bvDuKcoYdmyfOqI5J4uJ8pgpQ9o3VSWgoMXUjEoqO6aD3xA7EpwXntb5/9SFghoE
         nrBDWQzdQkKH3G4VcwsEyokOJ+wX0iUt+mf5i7Hij3sxvPIdvlrIvYo5/2mpM6J6ABbe
         8W0w==
X-Forwarded-Encrypted: i=1; AJvYcCWAGiND+69/zMKjgCL/Qubd+y4LUz7AIuHpqu5TYRpGyH7z+TkykGVRmEiw2peXEv3ULwqSl2tcZkIDCXe+CljUxQn3ufwlDNQqAv3ojA==
X-Gm-Message-State: AOJu0YynxFJRS8FR8mMNmoPf1+ck0VFgOh+jf+LArTjeEJOj2qd4MV6w
	J2iPUjAQ1zfLQ4oWOMbnzSP7ZW2o5KnX5uidfzG7iYjrCJufOOP18EJ+kWvsxQ==
X-Google-Smtp-Source: AGHT+IFgnziqKVsPlDFcaVY3O1lcKny/l/El36yYFOjaOKnKn279lG8Ph9ngGazPAxyRWX6j+oUVIg==
X-Received: by 2002:a17:903:2290:b0:1e8:92:c5e2 with SMTP id b16-20020a170903229000b001e80092c5e2mr6592452plh.47.1714010342304;
        Wed, 24 Apr 2024 18:59:02 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902934200b001e25da6f2f2sm12553004plp.68.2024.04.24.18.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:59:01 -0700 (PDT)
Date: Wed, 24 Apr 2024 18:59:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev,
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
Message-ID: <202404241852.DC4067B7@keescook>
References: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>

On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> Low overhead [1] per-callsite memory allocation profiling. Not just for
> debug kernels, overhead low enough to be deployed in production.

Okay, I think I'm holding it wrong. With next-20240424 if I set:

CONFIG_CODE_TAGGING=y
CONFIG_MEM_ALLOC_PROFILING=y
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y

My test system totally freaks out:

...
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Oops: general protection fault, probably for non-canonical address 0xc388d881e4808550: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc5-next-20240424 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
RIP: 0010:__kmalloc_node_noprof+0xcd/0x560

Which is:

__kmalloc_node_noprof+0xcd/0x560:
__slab_alloc_node at mm/slub.c:3780 (discriminator 2)
(inlined by) slab_alloc_node at mm/slub.c:3982 (discriminator 2)
(inlined by) __do_kmalloc_node at mm/slub.c:4114 (discriminator 2)
(inlined by) __kmalloc_node_noprof at mm/slub.c:4122 (discriminator 2)

Which is:

        tid = READ_ONCE(c->tid);

I haven't gotten any further than that; I'm EOD. Anyone seen anything
like this with this series?

-Kees

-- 
Kees Cook

