Return-Path: <linux-fsdevel+bounces-14239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7310B879C9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF4B229C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BB1142909;
	Tue, 12 Mar 2024 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fGa0rx+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5967CF01;
	Tue, 12 Mar 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274094; cv=none; b=d8Lw3vmkFFuf+WG57R/t87CRxxbNV6Hz3MpvJCmj8sU8ZvjmNqfH8AnmcU/moETKyHJH7uByDLfXmfB0TBn3x3RCNjXl+xrgX6K9pxvkUSwJBOkSUWXU3Adz+qpP00BFvIyqXir3vCpwRMLhYERSM6CZyJtAZqkGLQg5SfxIglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274094; c=relaxed/simple;
	bh=RLEUuRERIJXBaD1m7rMV8MoNRD7PPHojZhDIQsbKve8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzuKsvE9Dzsw8Kmxbl6n0bFQg7NDiV/V+afbNHrs4UJUu2SnmCnKZMw1oeXhz4rZH8HPy/OM2jm0nr82nD3ffTGV78NUEAsTxillvrmCLD9XIZbjo/iYoQBBpcB6z/mGI7qvppANP84Rc7lLYSir1SsmVwctSzjukA3XFuFKe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fGa0rx+R; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 16:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710274089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yVCYd35eicxoyDwHWZ5Xnl3STwUduIDprFGFDUbtbK8=;
	b=fGa0rx+RU9H7yzOC8eKrKFu17a+94OmM+4cytPi0Sy37phzuaEQ+GhJUBfxmO2TO/xIFcf
	bikGmTAjXGkm74EXvCd4e8T8K55apzctaN+Uuym6RjHufYvesaQ3hOpfnYjJpKv9uZ5LaK
	qVqU7WfUOZtpXPBVr1A9ajf9sgP3KCk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
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
Subject: Re: [PATCH v4 13/36] lib: prevent module unloading if memory is not
 freed
Message-ID: <kjg5lzzgjuls4hmyz3ym3u5ff3pu2ran7e7azabinak6oa6vrh@2vq4e73ftekk>
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-14-surenb@google.com>
 <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
 <ZfCdsbPgiARPHUkw@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfCdsbPgiARPHUkw@bombadil.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 12, 2024 at 11:23:45AM -0700, Luis Chamberlain wrote:
> On Mon, Feb 26, 2024 at 05:58:40PM +0100, Vlastimil Babka wrote:
> > On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > > Skip freeing module's data section if there are non-zero allocation tags
> > > because otherwise, once these allocations are freed, the access to their
> > > code tag would cause UAF.
> > > 
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > 
> > I know that module unloading was never considered really supported etc.
> 
> If its not supported then we should not have it on modules. Module
> loading and unloading should just work, otherwise then this should not
> work with modules and leave them in a zombie state.

Not have memory allocation profiling on modules?

