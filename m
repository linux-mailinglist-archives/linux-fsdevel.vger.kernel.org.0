Return-Path: <linux-fsdevel+bounces-15354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0D88C7A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F58B26803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D313D535;
	Tue, 26 Mar 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyKA41Y/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE613CA98;
	Tue, 26 Mar 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467600; cv=none; b=LHyID/sSExbpmKVrXMMbveQoakX4DGhoV61/d8o/Uz2DSbdjtJvCEaPfgsZHTOeRBFujZqHmM7jBkt4Zc5j9qsll120Fa1dWLvMA+iryg8r+lya7H4rsEfz7XQqx4iMOjLiVOyk4wHEHB2Zwy5YnhZylfkL80qfX4RFq6FGB5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467600; c=relaxed/simple;
	bh=ztmkPAB0U1ULXqxkAJmpV7w+Ysid9k8KKpLkRxinnKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4SjJzMzURlofj6p5aT3RHyl2YauItKHy+EjvHDPz2o+ula0vZo0ejVqcN4iU9TagpIPZXOENPWITnjI3op2/Z5gh7HmjV9OxbFvDWAWG+xLQAWZ/7wuCn4UdmUOLGgHfbUuilOpCJQEvDfZ+bPxbO0DuY8xMy8KQTNI32bxXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyKA41Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9697C433F1;
	Tue, 26 Mar 2024 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467600;
	bh=ztmkPAB0U1ULXqxkAJmpV7w+Ysid9k8KKpLkRxinnKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qyKA41Y/u8Cszywiz7OK3FbbmiKGQ9C4dXlmSowzO0eODtV3XQMYhndL6LqSSCExc
	 gSr5KriK7AK/eduOXCzUuM9/M/JTph42YYV7yXqy/Ep5e4C8RdOMDwEY3NB+TWhosG
	 ynhFk3x5fLusreKA62Lb5K8LI+Hrn02SMQKKQERtg/F9T4BStRFCcanXEuZXn7koxg
	 lsnbct8Q5TAF/wUov8x/pcO/9j1j/+eoZC8z34hhlBPd/+k36MCtc3hIUbdc3qsQoD
	 O7ZTB0GZ/L4AyBehCj5ri1j5aP5jWLIf/OTq2a320InuObeAqCv/u7gXamunek3p0/
	 fkdWsgil6eNBQ==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
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
Date: Tue, 26 Mar 2024 08:39:54 -0700
Message-Id: <20240326153954.89199-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAJuCfpGwLRBWKegYq5XY++fCPWO4mpzrhifw9QGvzJ5Uf9S4jw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 26 Mar 2024 00:51:21 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Mon, Mar 25, 2024 at 11:20 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Mon, 25 Mar 2024 10:59:01 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > On Mon, Mar 25, 2024 at 10:49 AM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Mon, 25 Mar 2024 14:56:01 +0000 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > > On Sat, Mar 23, 2024 at 6:05 PM SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > Hi Suren and Kent,
> > > > > >
> > > > > > On Thu, 21 Mar 2024 09:36:52 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > >
> > > > > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > > > > >
> > > > > > > This wrapps all external vmalloc allocation functions with the
> > > > > > > alloc_hooks() wrapper, and switches internal allocations to _noprof
> > > > > > > variants where appropriate, for the new memory allocation profiling
> > > > > > > feature.
> > > > > >
> > > > > > I just noticed latest mm-unstable fails running kunit on my machine as below.
> > > > > > 'git-bisect' says this is the first commit of the failure.
> > > > > >
> > > > > >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > > > > >     [10:59:53] Configuring KUnit Kernel ...
> > > > > >     [10:59:53] Building KUnit Kernel ...
> > > > > >     Populating config with:
> > > > > >     $ make ARCH=um O=../kunit.out/ olddefconfig
> > > > > >     Building with:
> > > > > >     $ make ARCH=um O=../kunit.out/ --jobs=36
> > > > > >     ERROR:root:/usr/bin/ld: arch/um/os-Linux/main.o: in function `__wrap_malloc':
> > > > > >     main.c:(.text+0x10b): undefined reference to `vmalloc'
> > > > > >     collect2: error: ld returned 1 exit status
> > > > > >
> > > > > > Haven't looked into the code yet, but reporting first.  May I ask your idea?
> > > > >
> > > > > Hi SeongJae,
> > > > > Looks like we missed adding "#include <linux/vmalloc.h>" inside
> > > > > arch/um/os-Linux/main.c in this patch:
> > > > > https://lore.kernel.org/all/20240321163705.3067592-2-surenb@google.com/.
> > > > > I'll be posing fixes for all 0-day issues found over the weekend and
> > > > > will include a fix for this. In the meantime, to work around it you
> > > > > can add that include yourself. Please let me know if the issue still
> > > > > persists after doing that.
> > > >
> > > > Thank you, Suren.  The change made the error message disappears.  However, it
> > > > introduced another one.
> > >
> > > Ok, let me investigate and I'll try to get a fix for it today evening.
> >
> > Thank you for this kind reply.  Nonetheless, this is not blocking some real
> > thing from me.  So, no rush.  Plese take your time :)
> 
> I posted a fix here:
> https://lore.kernel.org/all/20240326073750.726636-1-surenb@google.com/
> Please let me know if this resolves the issue.

I confirmed it is fixing the issue, and replied to the patch with my Tested-by:
tag.  Thank you for this kind fix, Suren.


Thanks,
SJ

[...]

