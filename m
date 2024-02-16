Return-Path: <linux-fsdevel+bounces-11900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CD9858A1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E91F21B8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1114A08D;
	Fri, 16 Feb 2024 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C1BPf5NM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14032149001
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125983; cv=none; b=NphMlhSju3sqPrr5G8PTKbNOV8yP8dikqJVvPZfLxvtgVMADjdyiHksi8MAVGPZtRzxa0QEAJW7WfBweRWrlXzcUqRQ+LOwynrHx6nkdZibtfH4LBSM7Jw3TzUxWLxUUM1ucCC89A6Vd3he0c6V08pEp7B33/xgvnOik/7G8Lcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125983; c=relaxed/simple;
	bh=HjwfytaqXF8iH9Dbpef0PBEdfS3nBXLDDCpMfB7MbjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxyqrKnVviuWhwc37jZzmLhxLhcvOzt+oJsbFU733aeyCUHoh8eBxEULWhdCBJPpeHUg0ZUjiag3zDeIwVmVT4pmgFSYf/04eLYgw9lzWZ/mY3/yxvIbMUTWGwDPydJvDcE2QsgRjN6dZ19TThNbdmMJ0xlZOoRUx3SjATIxcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C1BPf5NM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Feb 2024 18:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708125977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1dxXMhVUP1rgHFbx3bYUtrQ4Vj3OMrjAfFZh9B2nko=;
	b=C1BPf5NM9g0o4QItUPGRDmMrvEdGWmyuKm4wf1nFggUVoULHG8BShovAlb221Bb8TlJ2Ja
	KutXp2dyrtywnpnLlJsZyWbMnLgEtGr2j6xQgJwjPAMGkgKbYaLIt/Hwmsmi7ACHkQBytE
	lKW+kj7xiaratGuJKp1Q6urfXB8QmCo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <lvrwtp73y2upktswswekhhilrp2i742tmhcxi2c4gayyn24qd2@hdktbg3qutgb>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
 <202402121433.5CC66F34B@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402121433.5CC66F34B@keescook>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 12, 2024 at 02:40:12PM -0800, Kees Cook wrote:
> On Mon, Feb 12, 2024 at 01:38:59PM -0800, Suren Baghdasaryan wrote:
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index ffe8f618ab86..da68a10517c8 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -770,6 +770,10 @@ struct task_struct {
> >  	unsigned int			flags;
> >  	unsigned int			ptrace;
> >  
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +	struct alloc_tag		*alloc_tag;
> > +#endif
> 
> Normally scheduling is very sensitive to having anything early in
> task_struct. I would suggest moving this the CONFIG_SCHED_CORE ifdef
> area.

This is even hotter than the scheduler members; we actually do want it
up front.

