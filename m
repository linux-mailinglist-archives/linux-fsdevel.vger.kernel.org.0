Return-Path: <linux-fsdevel+bounces-11561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0371F854C19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CD21C27E58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B65D489;
	Wed, 14 Feb 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ntCXoZ0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0A55CDDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922890; cv=none; b=Yc7QUrQgXFObL/LyOAg+v8P8mX+COXnofLUioqN33G9ktrjYTZA4CI651M1/kubDlkhGQ4yEuraSjS58WgDzRJ3vtV7zQb+EfwkoRZ3y0ZaSe4IdIgTCQTUZyxfnIJME89+y9bmt7myGMquTq0kDoW2K3Ut6Djl+EMqzvV73j0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922890; c=relaxed/simple;
	bh=NtSv8J+99riBcAJlhZXyLjUBO+73SEMOIxIgW1tEnlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZOJK9EZ95Xv/PwAph+yDWX67UWJ/4/oRaBDZD+6dPpWnKfIQyChwUnUy581BvpM6Y2aBMX7ZSci+tzxlz7GC5Lpi0+60Cj4HXm7tyRc52CD/MGwTvnxm3HpxbuiR25GV1+Wk6IhEktQCvCpMYciZtx8oZz87ikSNxakOOYx40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ntCXoZ0V; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 10:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707922886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/AETcYHznmpv4/j2syV358dOWN8/yUI1GROKTci8BI=;
	b=ntCXoZ0VMMCAIYtsPiibjtpORudbEFoAtU1qYcguvGF7mSfGX7qoRUBfyl4bB4idy/W63v
	fvLCK5XGJcO/TsFo6VG2fL+RXP2HusW2uO949y7vUaBPjM7wvWHNvrysfaEyXdkkF/pz8M
	wHqh5GWyZyyGIKiP8Dc8AerWtRI9mCY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
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
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <ifz44lao4dbvvpzt7zha3ho7xnddcdxgp4fkeacqleu5lo43bn@f3dbrmcuticz>
References: <20240212213922.783301-1-surenb@google.com>
 <20240214062020.GA989328@cmpxchg.org>
 <ZczSSZOWMlqfvDg8@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZczSSZOWMlqfvDg8@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 03:46:33PM +0100, Michal Hocko wrote:
> On Wed 14-02-24 01:20:20, Johannes Weiner wrote:
> [...]
> > I agree we should discuss how the annotations are implemented on a
> > technical basis, but my take is that we need something like this.
> 
> I do not think there is any disagreement on usefulness of a better
> memory allocation tracking. At least for me the primary problem is the
> implementation. At LFSMM last year we have heard that existing tracing
> infrastructure hasn't really been explored much. Cover letter doesn't
> really talk much about those alternatives so it is really hard to
> evaluate whether the proposed solution is indeed our best way to
> approach this.

Michal, we covered this before.

To do this with tracing you'd have to build up data structures
separately, in userspace, that would mirror the allocator's data
structures; you would have to track every single allocation so that you
could match up the free event to the place it was allocated.

Even if it could be built, which I doubt, it'd be completely non viable
because the performance would be terrible.

Like I said, we covered all this before; if you're going to spend so
much time on these threads you really should be making a better attempt
at keeping up with what's been talked about.

