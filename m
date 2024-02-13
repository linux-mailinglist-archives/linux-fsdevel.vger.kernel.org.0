Return-Path: <linux-fsdevel+bounces-11292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C648527FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 05:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71F8B24740
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 04:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49494125B2;
	Tue, 13 Feb 2024 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QwlyriZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D601119F;
	Tue, 13 Feb 2024 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707798842; cv=none; b=KMrSAtG7scZGuB5BxqRrN+il7dpS7GiEg7Hj4wjF4qTXVnYS1AYC6z7jDaB88mOhXoq2qOJUNm0xtvWIfTseTxF3P4gq7x5FpWSmDpqaOcPW1QY5upRuRSEL2RY+dTFIerYp0FxEQz7dEVD3pQuR9vMq6y/OyIWjV/Y4bAYe37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707798842; c=relaxed/simple;
	bh=sG6EaxazJxZQbK5lrByqzfuE2WehLsylAZ4xr7wN43U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN2F1AmNigfZXHlQJPnY5lyZhrJIfcaMNa/gybwx2EaQ52GTwMd17UDXUiHZXKmzpDyUsoIvaM4xXK0WO5VL+DGlu9wuROYQKGAJqno4M2pz3GXGzU2VMXbLKkEINqkXMVFCoYIY+YKY9sbfvwzv1TNYCrV+FFDhvRjvxFf8Kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QwlyriZv; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Feb 2024 23:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707798838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvjY8M+9GsBv1uGSt+JuoCXswHcqrEcE4jibODW0tFs=;
	b=QwlyriZvvUgEDsqDWM3/Goy6W6fpTusJKVxYVQG5crPdH4ZbzhmUYA2feK+/zjZ86yJTrY
	XATKCb+pnbT/aSunErorIF2g2P2QqZtIIfXF6eJUlBLMn/zeLgLoihNGacEQ0wos+JcJ4x
	o2fTwQd7WKn6r0nEY1D0LzT7vDzxvyg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, david@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <wvn5hh63omtqvs4e3jy7vfu7fvkikkzkhqbmcd7vdtmm7jta7s@qjagmjwle2z3>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-32-surenb@google.com>
 <202402121606.687E798B@keescook>
 <20240212192242.44493392@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212192242.44493392@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 12, 2024 at 07:22:42PM -0500, Steven Rostedt wrote:
> On Mon, 12 Feb 2024 16:10:02 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > >  #endif
> > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > +	{
> > > +		struct seq_buf s;
> > > +		char *buf = kmalloc(4096, GFP_ATOMIC);  
> > 
> > Why 4096? Maybe use PAGE_SIZE instead?
> 
> Will it make a difference for architectures that don't have 4096 PAGE_SIZE?
> Like PowerPC which has PAGE_SIZE of anywhere between 4K to 256K!

it's just a string buffer

