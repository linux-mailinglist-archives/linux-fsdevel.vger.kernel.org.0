Return-Path: <linux-fsdevel+bounces-16074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E41897A71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD35282837
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42976156670;
	Wed,  3 Apr 2024 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvVi8LMC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE75DF0E;
	Wed,  3 Apr 2024 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178766; cv=none; b=Bny2k+UmT8PAEEW3PyRu7QIALA53HYWPTT7j8COy5WUvgI51/IxlVdKvguft1cb/fmbGk+3lg/1c2/GNpD+Ygz0gRvoZq8Rwv1UkvLtWYOeQ5slrAwHs34hoKKfI7fqbBX4p9V/AktHwWNUczrTw2cA3ALR26ZaUEYgH940l3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178766; c=relaxed/simple;
	bh=eAxmNahq0qz4MjguPAZcqC0KPuy9iIiFN/TD17zLp6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqmLIkAWp+8WuvT6Y1hZED1BHuinEdoe52jifK7r/QahXOpucjCH4WE4ISReD5Ja2gu5TJZC8qM2xatfYZU8D6S8cE1fPKRghRpxpZePciFRyQWHSW4pc/HwPjVoPv6u3u1REOsv5KQvKJ1zgU0XEju4uZtU2k33ZtCHkvs9DL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvVi8LMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A6C433C7;
	Wed,  3 Apr 2024 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712178766;
	bh=eAxmNahq0qz4MjguPAZcqC0KPuy9iIiFN/TD17zLp6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvVi8LMCPmD4vtizYlqbbrKdv6QHneAbgdsDhvVCwOCKlEjxORkOrxxsJaVKKe7ib
	 YfLM/rXrgmOgLEfBvFZMk7h4uuO1i9LQJ8M/6UOuM3j1UhfgLRc8vtGUdYkyvOB7qF
	 FK0zIrKPLUKf2X5PFEHqblNLkN3++ZGBDxB0Ckhu7GEuMY1ENqC6PtyP4PptCVwaCA
	 a2tbItT4M2CDmlu7PtN/anCWs0FKgXZEkpfh6sPHkTM077WDUkJUHG5B3YhvYpuPju
	 xPxmHBxAuN4+ZSpTgL2wp6f5XhRGsP7bV4GU68Ip1Yj2vPHXgYGKnLcD5SyRvdfCp0
	 PZSDJCo+DH2qQ==
Date: Wed, 3 Apr 2024 14:12:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, songmuchun@bytedance.com,
	jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v6 01/37] fix missing vmalloc.h includes
Message-ID: <20240403211240.GA307137@dev-arch.thelio-3990X>
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163705.3067592-2-surenb@google.com>

On Thu, Mar 21, 2024 at 09:36:23AM -0700, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> The next patch drops vmalloc.h from a system header in order to fix
> a circular dependency; this adds it to all the files that were pulling
> it in implicitly.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

I bisected an error that I see when building ARCH=loongarch allmodconfig
to commit 302519d9e80a ("asm-generic/io.h: kill vmalloc.h dependency")
in -next, which tells me that this patch likely needs to contain
something along the following lines, as LoongArch was getting
include/linux/sizes.h transitively through the vmalloc.h include in
include/asm-generic/io.h.

Cheers,
Nathan

  In file included from arch/loongarch/include/asm/io.h:11,
                   from include/linux/io.h:13,
                   from arch/loongarch/mm/mmap.c:6:
  include/asm-generic/io.h: In function 'ioport_map':
  arch/loongarch/include/asm/addrspace.h:124:25: error: 'SZ_32M' undeclared (first use in this function); did you mean 'PS_32M'?
    124 | #define PCI_IOSIZE      SZ_32M
        |                         ^~~~~~
  arch/loongarch/include/asm/addrspace.h:126:26: note: in expansion of macro 'PCI_IOSIZE'
    126 | #define IO_SPACE_LIMIT  (PCI_IOSIZE - 1)
        |                          ^~~~~~~~~~
  include/asm-generic/io.h:1113:17: note: in expansion of macro 'IO_SPACE_LIMIT'
   1113 |         port &= IO_SPACE_LIMIT;
        |                 ^~~~~~~~~~~~~~
  arch/loongarch/include/asm/addrspace.h:124:25: note: each undeclared identifier is reported only once for each function it appears in
    124 | #define PCI_IOSIZE      SZ_32M
        |                         ^~~~~~
  arch/loongarch/include/asm/addrspace.h:126:26: note: in expansion of macro 'PCI_IOSIZE'
    126 | #define IO_SPACE_LIMIT  (PCI_IOSIZE - 1)
        |                          ^~~~~~~~~~
  include/asm-generic/io.h:1113:17: note: in expansion of macro 'IO_SPACE_LIMIT'
   1113 |         port &= IO_SPACE_LIMIT;
        |                 ^~~~~~~~~~~~~~

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index b24437e28c6e..7bd47d65bf7a 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -11,6 +11,7 @@
 #define _ASM_ADDRSPACE_H
 
 #include <linux/const.h>
+#include <linux/sizes.h>
 
 #include <asm/loongarch.h>
 

