Return-Path: <linux-fsdevel+bounces-12932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B3868CA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F4C1C2102F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089281369BC;
	Tue, 27 Feb 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bnFZzcs8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA059136999
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027168; cv=none; b=p5mJine9T/ir9HRzZXwIO3DIcDYi0E1xrp3nMam/TFa1tCJb7akPSnQr2L26UBAydLvkklxxgz/GrssEIgMhXVJB0FHUqmButb6D3vTMRPByCv9lETYW7g5x+NoQ2MzNipLfqWl7FcOS7nL1oMhkP/+hP9ZDN82/l2Sl8WrI28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027168; c=relaxed/simple;
	bh=+ytKwk3NacclcWujYuHxkN3+LNPa8DzWTEDtglex9XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIGIcL9CLG3ASvK6Lt1JAcNRZ5E9o4UMjmSPsB2xzzSl25nzG6WFrjmNuin/1is3m6j+dVCVfphyce5/JNMD6olu4kpf9DOQ4yW7Egh5dfY5y2qGze0B2/NXgSdX6dKI0qnl26J2tXr+ppHXlEa1Je2JJhvskrw5m2RAv0IhDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bnFZzcs8; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 04:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709027164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nlWS0taAPbDFSntCaJ2TVsOBW7I3UD2z/xphXUPlTY=;
	b=bnFZzcs8sYgZ/WAdp0TCl6iE8mORl4n3jkZU5UpN+8Yhyt3ppzRDI0kT83L14Ajo+/3/GK
	cZPS6F/lDYPzAIXE3bk0+iyBp+ia2OM22CiV0C1VfGZKHiyciWdHzAc5YyzQQOOBpcszQR
	zOdtNjr321Tq148zhVLstoxTE62xRfM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 15/36] lib: introduce support for page allocation
 tagging
Message-ID: <z3uitmi57ccg2iifn5nb3pav6skh4zjfvemhuxqdlmwdij3242@wx2lbakzwrxc>
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-16-surenb@google.com>
 <d6141a99-3409-447b-88ac-16c24b0a892e@suse.cz>
 <CAJuCfpGZ6W-vjby=hWd5F3BOCLjdeda2iQx_Tz-HcyjCAsmKVg@mail.gmail.com>
 <72cc5f0b-90cc-48a8-a026-412fa1186acd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72cc5f0b-90cc-48a8-a026-412fa1186acd@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 10:30:53AM +0100, Vlastimil Babka wrote:
> 
> 
> On 2/26/24 18:11, Suren Baghdasaryan wrote:
> > On Mon, Feb 26, 2024 at 9:07 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> >>> Introduce helper functions to easily instrument page allocators by
> >>> storing a pointer to the allocation tag associated with the code that
> >>> allocated the page in a page_ext field.
> >>>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> >>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> >>
> >> The static key usage seems fine now. Even if the page_ext overhead is still
> >> always paid when compiled in, you mention in the cover letter there's a plan
> >> for boot-time toggle later, so
> > 
> > Yes, I already have a simple patch for that to be included in the next
> > revision: https://github.com/torvalds/linux/commit/7ca367e80232345f471b77b3ea71cf82faf50954
> 
> This opt-out logic would require a distro kernel with allocation
> profiling compiled-in to ship together with something that modifies
> kernel command line to disable it by default, so it's not very
> practical. Could the CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT be
> turned into having 3 possible choices, where one of them would
> initialize mem_profiling_enabled to false?
> 
> Or, taking a step back, is it going to be a common usecase to pay the
> memory overhead unconditionally, but only enable the profiling later
> during runtime? Also what happens if someone would enable and disable it
> multiple times during one boot? Would the statistics get all skewed
> because some frees would be not accounted while it's disabled?

I already wrote the code for fast lookup from codetag index -> codetag -
i.e. pointer compression - so this is all going away shortly.

It just won't be in the initial pull request because of other
dependencies (it requires my eytzinger code, which I was already lifting
from fs/bcachefs/ for 6.9), but it can still probably make 6.9 in a
second smaller pull.

