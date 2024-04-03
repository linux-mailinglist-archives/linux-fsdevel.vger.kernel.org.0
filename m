Return-Path: <linux-fsdevel+bounces-16085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40215897BD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722D51C21701
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 22:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907D156253;
	Wed,  3 Apr 2024 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="altBgIa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C30156890
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185064; cv=none; b=X3FweT4T+p5Btc3AWkBs335l/Q/w9Xu+a4DoL8wYcQtIHkM0Ow/7gyOBSYIWkkaHi47CYX6asHdtJE8CSTM51aAjIKn2eSCzUCw0Gzb2d9OfLiGoacwQ1gcVe7CMcR3HU7vaLVYTqCqOxy2R0SwXLy2RdmxbbL8Xz2Wkpj84Ogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185064; c=relaxed/simple;
	bh=rSC5AEVZmjhxZcqf+HrPUcVtv4hsU7DupAfE4SmRWDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbYuBILgXEA6oBy5yE7MiYTnoXHWt53ygcdXdSTcwaziLPAe+NjZuQ4XU6gQJkWoRId/hCMRNkzMHjeH1Xln9zmIU1q01jPdTaTZJ7IRYjhIwJk77Agq/6O7h6Npeo9BFA6sv3DPmh4aYnzt93UXTlj1fx2Za5Us3RvObPVD9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=altBgIa+; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Apr 2024 18:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712185059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWtiyFTqYKwdJDHyaCD82L5617uAdz2F4Sz0PAghbhE=;
	b=altBgIa+MeRE72rlksdac4u+jogeiW19C04WbQpYqlQTv7yFrJi+DeOIswL1ev0MHQMoJz
	3P/blHm1a9ObCUExPNH7tB1oeAvKxRHvqrARJ69T91VOSSObtkLUGmQ7Nd8eHpwXRM9vPE
	nRIje5E5zoSDcqJDGAKpSrukrB99Ej0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, dennis@kernel.org, 
	jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	aliceryhl@google.com, rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH v6 01/37] fix missing vmalloc.h includes
Message-ID: <qyyo6mjctqm734utdjen4ozhoo3t4ikswzjfjnemp7olwdgyt4@qifwishdzul4>
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-2-surenb@google.com>
 <20240403211240.GA307137@dev-arch.thelio-3990X>
 <4qk7f3ra5lrqhtvmipmacgzo5qwnugrfxn5dd3j4wubzwqvmv4@vzdhpalbmob3>
 <9e2d09f8-2234-42f3-8481-87bbd9ad4def@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2d09f8-2234-42f3-8481-87bbd9ad4def@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 03, 2024 at 11:48:12PM +0200, David Hildenbrand wrote:
> On 03.04.24 23:41, Kent Overstreet wrote:
> > On Wed, Apr 03, 2024 at 02:12:40PM -0700, Nathan Chancellor wrote:
> > > On Thu, Mar 21, 2024 at 09:36:23AM -0700, Suren Baghdasaryan wrote:
> > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > > 
> > > > The next patch drops vmalloc.h from a system header in order to fix
> > > > a circular dependency; this adds it to all the files that were pulling
> > > > it in implicitly.
> > > > 
> > > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > 
> > > I bisected an error that I see when building ARCH=loongarch allmodconfig
> > > to commit 302519d9e80a ("asm-generic/io.h: kill vmalloc.h dependency")
> > > in -next, which tells me that this patch likely needs to contain
> > > something along the following lines, as LoongArch was getting
> > > include/linux/sizes.h transitively through the vmalloc.h include in
> > > include/asm-generic/io.h.
> > 
> > gcc doesn't appear to be packaged for loongarch for debian (most other
> > cross compilers are), so that's going to make it hard for me to test
> > anything...
> 
> The latest cross-compilers from Arnd [1] include a 13.2.0 one for
> loongarch64 that works for me. Just in case you haven't heard of Arnds work
> before and want to give it a shot.
> 
> [1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

Thanks for the pointer - but something seems to be busted with the
loongarch build, if I'm not mistaken; one of the included headers
references loongarch-def.h, but that's not included.

