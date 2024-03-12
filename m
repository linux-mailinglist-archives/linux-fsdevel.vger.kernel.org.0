Return-Path: <linux-fsdevel+bounces-14235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FF879C0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B201C2268D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9186142640;
	Tue, 12 Mar 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HHyhMGPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D15139572
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710270351; cv=none; b=YojYgXwARAMvc5MfATR1sadWG0RH7yZXl5BTlGk8RInE4RhALU6IwU4VmMg7s1ipIvJwrMq/fGvnNlbww9cE/C+96D8kbwymHbyN0J7xyCxWEgu7WAFZSfCpUBDjgbwHXrEztTS0bOUdNQQNnZlJxLu5BxpXn9fE6DUjbF0jIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710270351; c=relaxed/simple;
	bh=2FpORzEzp4d+kBzYQcXfKFJJI4OP8kz4CQKscqTCH2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNGEhh3h4GcfDCniWGjDC8OaXaMGVRHyVcyWAj6vA7c5sH2z80870T6bPizrT4tWkyNLo+pUU15w2Dm1Sb/OHBL9mJd0edM0aPIQzdh6y42d2UgBdVagBLcY48ODYGDqn7aQXXX1ZWRlwfMgyQ+47GlyvOaU0BJIl7LKXb3rkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HHyhMGPR; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 12:05:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710270347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i2n0g7ELC5Jfz1aF+KhbZXxiuizO3RE1y/QxbejYQSE=;
	b=HHyhMGPRuH0SnoHYtwlS9XquVfzAfzCv2iAcquIE40GXvCaIuOL7dyut4T+neO59Dvr/0O
	uVp8JyXYjrlzR0tfvsDqzDmfCN2h+WRWtdOKJUPDR9WsBt8PpiJh7VrjtwRr53CAH4909m
	HCf/Dd7De4o1ZWLqYMlLdoYsAKPWEVI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in
 path_openat()
Message-ID: <ZfCnhPjU9dQfmDh7@P9FQF9L96D>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
 <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
 <ZeIkKrS7HK6ENwbw@P9FQF9L96D.corp.robot.car>
 <8aa61329-dc3c-46f2-9db5-6e0770fbedda@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa61329-dc3c-46f2-9db5-6e0770fbedda@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 12, 2024 at 10:22:54AM +0100, Vlastimil Babka wrote:
> On 3/1/24 19:53, Roman Gushchin wrote:
> > On Fri, Mar 01, 2024 at 09:51:18AM -0800, Linus Torvalds wrote:
> >> What I *think* I'd want for this case is
> >> 
> >>  (a) allow the accounting to go over by a bit
> >> 
> >>  (b) make sure there's a cheap way to ask (before) about "did we go
> >> over the limit"
> >> 
> >> IOW, the accounting never needed to be byte-accurate to begin with,
> >> and making it fail (cheaply and early) on the next file allocation is
> >> fine.
> >> 
> >> Just make it really cheap. Can we do that?
> >> 
> >> For example, maybe don't bother with the whole "bytes and pages"
> >> stuff. Just a simple "are we more than one page over?" kind of
> >> question. Without the 'stock_lock' mess for sub-page bytes etc
> >> 
> >> How would that look? Would it result in something that can be done
> >> cheaply without locking and atomics and without excessive pointer
> >> indirection through many levels of memcg data structures?
> > 
> > I think it's possible and I'm currently looking into batching charge,
> > objcg refcnt management and vmstats using per-task caching. It should
> > speed up things for the majority of allocations.
> > For allocations from an irq context and targeted allocations
> > (where the target memcg != memcg of the current task) we'd probably need to
> > keep the old scheme. I hope to post some patches relatively soon.
> 
> Do you think this will work on top of this series, i.e. patches 1+2 could be
> eventually put to slab/for-next after the merge window, or would it
> interfere with your changes?

Please, go on and merge them, I'll rebase on top of it, it will be even better
for my work. I made a couple of comments there, but overall they look very good
to me, thank you for doing this work!

> 
> > I tried to optimize the current implementation but failed to get any
> > significant gains. It seems that the overhead is very evenly spread across
> > objcg pointer access, charge management, objcg refcnt management and vmstats.

I started working on the thing, but it's a bit more complicated than I initially
thought because:
1) there are allocations made from a !in_task() context, so we need to handle
   this correctly

2) tasks can be moved between cgroups concurrently to memory allocations.
   fortunately my recent changes provide a path here, but it adds to the complexity.
   In alternative world where tasks can't move between cgroups the life would
   be so much better (and faster too, we could remove a ton of synchronization).

3) we do have per-numa-node per-memcg stats, which are less trivial to cache
   on struct task

I hope to resolve these issues somehow and post patches, but probably will need
a bit more time.

Thanks!

