Return-Path: <linux-fsdevel+bounces-15239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BEB88AE89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8449C1FA4D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E5B1C692;
	Mon, 25 Mar 2024 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEkb4FbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1F54279;
	Mon, 25 Mar 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390815; cv=none; b=PoTls2y7Q52HYdMmbEWPwtTM8ca3oGeM0EquyX6ikYC4EfbcctRhOOq3BlTBuRmxX8YQsmq4axsgzsTZhJJzBJtycr/5/ZcXb/jRl7x1TZ+AkmjG9zsoa4krWLfvacx3mvm+OKbBO8LivBfF6Sf+X5htp5elAOWZ+AAif4BjOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390815; c=relaxed/simple;
	bh=Z9fYLG7lM7QRd2z1J6VDOsa2mnKl/0CwjKf7s97CFbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ8hk3j21gfz1Ig44K/1qX+QMr+YyBJcu82q7/mh5YZgw/QNcJPRfEJHSRZYaqc+tPP3uHPdbTixIAZLFvHPJ7TgbmTslnM6+g3FHpAbJDWRJiJXoZPKiYtBlKAju7bknyeubekdb1GBvPHabzQ04eRjVpuPOi7YeUaPiP+bIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEkb4FbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A0CC433F1;
	Mon, 25 Mar 2024 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711390814;
	bh=Z9fYLG7lM7QRd2z1J6VDOsa2mnKl/0CwjKf7s97CFbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEkb4FbWOn67uvoG4OVtv6eeAU5F3GTqMnsnd6vPKrCjkAKU2Fa2ZY15zDyx6e0Qt
	 Aj5NNS8ijJOk6L1H5Iivvs3F2JB4/v5GWKD8R3RbddWydHUHUxjff5crBS4mHSIAU1
	 7QuXHPDFEbPyddq7eScELmxnvylfgwSjlxBxWIfuYxnpBgRoyVeXaGV2sUCsWFm3F8
	 HpNF55tk7Q3aUQHyV0NkKzspllvZsRloFZQVN2ngZVwXevH4uWn66roa2ABgA8HFKi
	 EpkMG8QuSsPcKgcz/EWGIQIxt9sYlmspKP0eS2DCcj8W8pz8ie2DwPgILuJnVQVq8z
	 MD1BHbcKXCaLQ==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	vbabka@suse.cz,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	mgorman@suse.de,
	dave@stgolabs.net,
	willy@infradead.org,
	liam.howlett@oracle.com,
	penguin-kernel@i-love.sakura.ne.jp,
	corbet@lwn.net,
	void@manifault.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterx@redhat.com,
	david@redhat.com,
	axboe@kernel.dk,
	mcgrof@kernel.org,
	masahiroy@kernel.org,
	nathan@kernel.org,
	dennis@kernel.org,
	jhubbard@nvidia.com,
	tj@kernel.org,
	muchun.song@linux.dev,
	rppt@kernel.org,
	paulmck@kernel.org,
	pasha.tatashin@soleen.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	dhowells@redhat.com,
	hughd@google.com,
	andreyknvl@gmail.com,
	keescook@chromium.org,
	ndesaulniers@google.com,
	vvvvvv@google.com,
	gregkh@linuxfoundation.org,
	ebiggers@google.com,
	ytcoode@gmail.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	bristot@redhat.com,
	vschneid@redhat.com,
	cl@linux.com,
	penberg@kernel.org,
	iamjoonsoo.kim@lge.com,
	42.hyeyoo@gmail.com,
	glider@google.com,
	elver@google.com,
	dvyukov@google.com,
	songmuchun@bytedance.com,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rientjes@google.com,
	minchan@google.com,
	kaleshsingh@google.com,
	kernel-team@android.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v6 30/37] mm: vmalloc: Enable memory allocation profiling
Date: Mon, 25 Mar 2024 11:20:07 -0700
Message-Id: <20240325182007.233780-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAJuCfpGiuCnMFtViD0xsoaLVO_gJddBQ1NpL6TpnsfN8z5P6fA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 10:59:01 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Mon, Mar 25, 2024 at 10:49 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Mon, 25 Mar 2024 14:56:01 +0000 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > On Sat, Mar 23, 2024 at 6:05 PM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > Hi Suren and Kent,
> > > >
> > > > On Thu, 21 Mar 2024 09:36:52 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > > >
> > > > > This wrapps all external vmalloc allocation functions with the
> > > > > alloc_hooks() wrapper, and switches internal allocations to _noprof
> > > > > variants where appropriate, for the new memory allocation profiling
> > > > > feature.
> > > >
> > > > I just noticed latest mm-unstable fails running kunit on my machine as below.
> > > > 'git-bisect' says this is the first commit of the failure.
> > > >
> > > >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > > >     [10:59:53] Configuring KUnit Kernel ...
> > > >     [10:59:53] Building KUnit Kernel ...
> > > >     Populating config with:
> > > >     $ make ARCH=um O=../kunit.out/ olddefconfig
> > > >     Building with:
> > > >     $ make ARCH=um O=../kunit.out/ --jobs=36
> > > >     ERROR:root:/usr/bin/ld: arch/um/os-Linux/main.o: in function `__wrap_malloc':
> > > >     main.c:(.text+0x10b): undefined reference to `vmalloc'
> > > >     collect2: error: ld returned 1 exit status
> > > >
> > > > Haven't looked into the code yet, but reporting first.  May I ask your idea?
> > >
> > > Hi SeongJae,
> > > Looks like we missed adding "#include <linux/vmalloc.h>" inside
> > > arch/um/os-Linux/main.c in this patch:
> > > https://lore.kernel.org/all/20240321163705.3067592-2-surenb@google.com/.
> > > I'll be posing fixes for all 0-day issues found over the weekend and
> > > will include a fix for this. In the meantime, to work around it you
> > > can add that include yourself. Please let me know if the issue still
> > > persists after doing that.
> >
> > Thank you, Suren.  The change made the error message disappears.  However, it
> > introduced another one.
> 
> Ok, let me investigate and I'll try to get a fix for it today evening.

Thank you for this kind reply.  Nonetheless, this is not blocking some real
thing from me.  So, no rush.  Plese take your time :)


Thanks,
SJ

> Thanks,
> Suren.
> 
> >
> >     $ git diff
> >     diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
> >     index c8a42ecbd7a2..8fe274e9f3a4 100644
> >     --- a/arch/um/os-Linux/main.c
> >     +++ b/arch/um/os-Linux/main.c
> >     @@ -16,6 +16,7 @@
> >      #include <kern_util.h>
> >      #include <os.h>
> >      #include <um_malloc.h>
> >     +#include <linux/vmalloc.h>
> >
> >      #define PGD_BOUND (4 * 1024 * 1024)
> >      #define STACKSIZE (8 * 1024 * 1024)
> >     $
> >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> >     [10:43:13] Configuring KUnit Kernel ...
> >     [10:43:13] Building KUnit Kernel ...
> >     Populating config with:
> >     $ make ARCH=um O=../kunit.out/ olddefconfig
> >     Building with:
> >     $ make ARCH=um O=../kunit.out/ --jobs=36
> >     ERROR:root:In file included from .../arch/um/kernel/asm-offsets.c:1:
> >     .../arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]
> >         9 | void foo(void)
> >           |      ^~~
> >     In file included from .../include/linux/alloc_tag.h:8,
> >                      from .../include/linux/vmalloc.h:5,
> >                      from .../arch/um/os-Linux/main.c:19:
> >     .../include/linux/bug.h:5:10: fatal error: asm/bug.h: No such file or directory
> >         5 | #include <asm/bug.h>
> >           |          ^~~~~~~~~~~
> >     compilation terminated.
> >
> >
> > Thanks,
> > SJ
> >
> > [...]
> 

