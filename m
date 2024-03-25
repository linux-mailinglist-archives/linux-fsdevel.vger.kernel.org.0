Return-Path: <linux-fsdevel+bounces-15237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA088AD90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13301C3F01B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1048CC7;
	Mon, 25 Mar 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKfexc/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C03EA95;
	Mon, 25 Mar 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388981; cv=none; b=F44Hjy9MiIE2+6XfGrAQimhGs9USdy2cYTj9hgKc879r4BWGTAmCybvgQwjfa4CVZ6eExlMcis2Fvdl7/6hNwQiZhex18Lr64oVjbgtXmrGmPiyDGPqwtxZuxkGxVhFFH7LlpFN1YsY9fz5zLw/5kqOHHD1rtn588/nmDrOrOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388981; c=relaxed/simple;
	bh=kJfO/BrlPE8tCgQXkg2kSQI8OJ92v+1fHUZt71+VhVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfYtOs6L5XE1jesijKpjTlZtNRYfxtz/XdQXXQMAcDG6USpdZUGji4fhrm6NfNdi5rnFPb4wlGTOWGN6DpK3trp7XjJcrNT/uUbdGOB0N7y2HYoSGwZvhdtRpV1unHKh7M08cmmlweo85jJB6VVUmwZDmRSNJPQktXNzgHd7Lzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKfexc/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADB6C433C7;
	Mon, 25 Mar 2024 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388981;
	bh=kJfO/BrlPE8tCgQXkg2kSQI8OJ92v+1fHUZt71+VhVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKfexc/+lfT4SRm62Lng7zX6lZq75sOyRRJUXmJKIlK+QAS+taJkEcsby4Kfz4xkr
	 YALAT4dZAnKbriRzIpLLWbSbSSRnq9e6ANpPcgklTK+s/aEdiCKBbBjt2kPW6aVcuw
	 KbBvOWooB+yiCkVCAW+EqtxXVSmIYTUhvFZNh6eEJUFUzqRwAulocVWnHSmTgpP43R
	 QbaUcExk5jihHzQqE6B1MuhEUIF0QGFsRwuoz5n4cL/Y/omAfQchozrH1NxycImg+n
	 2EMv+dn1NmOtYMPhp2TO1/FxfJ5bScasT+boWP5/5F6m1gskQ6ZkcnH3EnxU+Q0732
	 SSgtXbLrUBrDQ==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	mhocko@suse.com,
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
Date: Mon, 25 Mar 2024 10:49:34 -0700
Message-Id: <20240325174934.229745-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAJuCfpFnGmt8Q7ZT2Z+gvz=DkRzionXFZ0i5Y1B=UKF6LLqxXA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 14:56:01 +0000 Suren Baghdasaryan <surenb@google.com> wrote:

> On Sat, Mar 23, 2024 at 6:05 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Suren and Kent,
> >
> > On Thu, 21 Mar 2024 09:36:52 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > >
> > > This wrapps all external vmalloc allocation functions with the
> > > alloc_hooks() wrapper, and switches internal allocations to _noprof
> > > variants where appropriate, for the new memory allocation profiling
> > > feature.
> >
> > I just noticed latest mm-unstable fails running kunit on my machine as below.
> > 'git-bisect' says this is the first commit of the failure.
> >
> >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> >     [10:59:53] Configuring KUnit Kernel ...
> >     [10:59:53] Building KUnit Kernel ...
> >     Populating config with:
> >     $ make ARCH=um O=../kunit.out/ olddefconfig
> >     Building with:
> >     $ make ARCH=um O=../kunit.out/ --jobs=36
> >     ERROR:root:/usr/bin/ld: arch/um/os-Linux/main.o: in function `__wrap_malloc':
> >     main.c:(.text+0x10b): undefined reference to `vmalloc'
> >     collect2: error: ld returned 1 exit status
> >
> > Haven't looked into the code yet, but reporting first.  May I ask your idea?
> 
> Hi SeongJae,
> Looks like we missed adding "#include <linux/vmalloc.h>" inside
> arch/um/os-Linux/main.c in this patch:
> https://lore.kernel.org/all/20240321163705.3067592-2-surenb@google.com/.
> I'll be posing fixes for all 0-day issues found over the weekend and
> will include a fix for this. In the meantime, to work around it you
> can add that include yourself. Please let me know if the issue still
> persists after doing that.

Thank you, Suren.  The change made the error message disappears.  However, it
introduced another one.

    $ git diff
    diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
    index c8a42ecbd7a2..8fe274e9f3a4 100644
    --- a/arch/um/os-Linux/main.c
    +++ b/arch/um/os-Linux/main.c
    @@ -16,6 +16,7 @@
     #include <kern_util.h>
     #include <os.h>
     #include <um_malloc.h>
    +#include <linux/vmalloc.h>
    
     #define PGD_BOUND (4 * 1024 * 1024)
     #define STACKSIZE (8 * 1024 * 1024)
    $
    $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
    [10:43:13] Configuring KUnit Kernel ...
    [10:43:13] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=../kunit.out/ olddefconfig
    Building with:
    $ make ARCH=um O=../kunit.out/ --jobs=36
    ERROR:root:In file included from .../arch/um/kernel/asm-offsets.c:1:
    .../arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]
        9 | void foo(void)
          |      ^~~
    In file included from .../include/linux/alloc_tag.h:8,
                     from .../include/linux/vmalloc.h:5,
                     from .../arch/um/os-Linux/main.c:19:
    .../include/linux/bug.h:5:10: fatal error: asm/bug.h: No such file or directory
        5 | #include <asm/bug.h>
          |          ^~~~~~~~~~~
    compilation terminated.


Thanks,
SJ

[...]

