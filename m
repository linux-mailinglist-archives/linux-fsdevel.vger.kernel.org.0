Return-Path: <linux-fsdevel+bounces-6607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215881A854
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3002286F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 21:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF84B5A2;
	Wed, 20 Dec 2023 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uaVoJ0eD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AD4B15B
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Dec 2023 16:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703108358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uADafuqFMCeXQ5Fj4WVSnQJ6HfedZAFlxNtI1icEQik=;
	b=uaVoJ0eDqHKMMDAL7U6wiyolJ/49uVE0BquJe7BEbhDIHsjESiLiEaDkoqvThJNjWSAnLw
	a1zqGof93sisOLTnFcGT1eL1RpMElAuGISwQHypQHp9Obg8YSYVm/LA7JLD6Mhna42NcIs
	GAR5tiTADYICiDh7d4NacvzxpGj7y2g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 42/50] sem: Split out sem_types.h
Message-ID: <20231220213913.gptbcbpwb4q3prtf@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-10-kent.overstreet@linux.dev>
 <CAMuHMdVRDQQmeO0ggyW-O+de45abyktwYH3ZFF1=mqd2iQXE1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVRDQQmeO0ggyW-O+de45abyktwYH3ZFF1=mqd2iQXE1Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 20, 2023 at 12:53:46PM +0100, Geert Uytterhoeven wrote:
> Hi Kent,
> 
> On Sat, Dec 16, 2023 at 4:37 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > More sched.h dependency pruning.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> Thanks for your patch, which is now commit eb72d60ccaed883a ("sem:
> Split out sem_types.h") in next-20231220.
> 
> $ make ARCH=m68k defconfig arch/m68k/kernel/asm-offsets.i
> *** Default configuration is based on 'multi_defconfig'
> #
> # No change to .config
> #
>   UPD     include/config/kernel.release
>   UPD     include/generated/utsrelease.h
>   CC      arch/m68k/kernel/asm-offsets.s
> In file included from arch/m68k/kernel/asm-offsets.c:15:
> ./include/linux/sched.h:551:3: error: conflicting types for
> ‘____cacheline_aligned’
>   551 | } ____cacheline_aligned;
>       |   ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/sched.h:509:3: note: previous declaration of
> ‘____cacheline_aligned’ was here
>   509 | } ____cacheline_aligned;
>       |   ^~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:116:
> arch/m68k/kernel/asm-offsets.s] Error 1
> make[2]: *** [Makefile:1191: prepare0] Error 2
> make[1]: *** [Makefile:350: __build_one_by_one] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

Is this a build failure on linux-next, or that specific commit?

It looks like this should be fixed in a later commit that includes
cache.h in sched.h; I'll move that include back to this patch.

