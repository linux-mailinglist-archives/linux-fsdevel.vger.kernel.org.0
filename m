Return-Path: <linux-fsdevel+bounces-13327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655086E8CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 19:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95D9283DA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2339FDA;
	Fri,  1 Mar 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gn7rELY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815811C88
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319231; cv=none; b=XjxWgWFdGZmxrorPdOyjlDUATfAnMGU25K98GYxtXDeJ2fchLEixw/x9S1qaLLUM7Pw+stREo7TzgOwaqst1eEK+1ZjI8c4x5zb5zIN9CwXs/NABZCCiA569ddcVfxs4keSZIlCnZvA01WGOhYiqkzVzSiVh04p0L//Nm15Oh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319231; c=relaxed/simple;
	bh=+xh/f4G1lcC7OOYBLDSVnmlxyJIX8rUdOfve7xEoQZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZGLcM9EIW7y7TQhN6Xt2Pe2fRx/mAMU3HGYw15vKGQ5d4yyJtOV48G4ej/+ljObQg2PIF3f58nI22Ng78kbAOnlF7/LreZk8k/gE/tTvw+CP5SLXjF5geQ7ZhgNSrCl4wbPaOYB7uS6cdZTwDsDgG7jGF7BloSS1XTOo3vJg5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gn7rELY1; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Mar 2024 10:53:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709319226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWBU7wfenw5GY8snfrhpUtl/VpqnsNlazcQskb2ijoE=;
	b=gn7rELY1u3fct2iRcbLSiaFrreySSkXP5ifRGFhjrkx+a6/PEGsm66m4/fEeeq1Sngh7QT
	xWzEkkTe12Sb7X25cK2QB2o8B5n+ye/j01hRxqXPVJqzXs7JRk52awHqGmMGKP2DkTyqgI
	fw7Z2bVSVnnZdJa7ObS6mxnFMPy11Rk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
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
Message-ID: <ZeIkKrS7HK6ENwbw@P9FQF9L96D.corp.robot.car>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
 <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 09:51:18AM -0800, Linus Torvalds wrote:
> On Fri, 1 Mar 2024 at 09:07, Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > This is just an example of using the kmem_cache_charge() API.  I think
> > it's placed in a place that's applicable for Linus's example [1]
> > although he mentions do_dentry_open() - I have followed from strace()
> > showing openat(2) to path_openat() doing the alloc_empty_file().
> 
> Thanks. This is not the right patch,  but yes, patches 1-3 look very nice to me.
> 
> > The idea is that filp_cachep stops being SLAB_ACCOUNT. Allocations that
> > want to be accounted immediately can use GFP_KERNEL_ACCOUNT. I did that
> > in alloc_empty_file_noaccount() (despite the contradictory name but the
> > noaccount refers to something else, right?) as IIUC it's about
> > kernel-internal opens.
> 
> Yeah, the "noaccount" function is about not accounting it towards nr_files.
> 
> That said, I don't think it necessarily needs to do the memory
> accounting either - it's literally for cases where we're never going
> to install the file descriptor in any user space.
> 
> Your change to use GFP_KERNEL_ACCOUNT isn't exactly wrong, but I don't
> think it's really the right thing either, because
> 
> > Why is this unfinished:
> >
> > - there are other callers of alloc_empty_file() which I didn't adjust so
> >   they simply became memcg-unaccounted. I haven't investigated for which
> >   ones it would make also sense to separate the allocation and accounting.
> >   Maybe alloc_empty_file() would need to get a parameter to control
> >   this.
> 
> Right. I think the natural and logical way to deal with this is to
> just say "we account when we add the file to the fdtable".
> 
> IOW, just have fd_install() do it. That's the really natural point,
> and also makes it very logical why alloc_empty_file_noaccount()
> wouldn't need to do the GFP_KERNEL_ACCOUNT.
> 
> > - I don't know how to properly unwind the accounting failure case. It
> >   seems like a new case because when we succeed the open, there's no
> >   further error path at least in path_openat().
> 
> Yeah, let me think about this part. Becasue fd_install() is the right
> point, but that too does not really allow for error handling.
> 
> Yes, we could close things and fail it, but it really is much too late
> at this point.
> 
> What I *think* I'd want for this case is
> 
>  (a) allow the accounting to go over by a bit
> 
>  (b) make sure there's a cheap way to ask (before) about "did we go
> over the limit"
> 
> IOW, the accounting never needed to be byte-accurate to begin with,
> and making it fail (cheaply and early) on the next file allocation is
> fine.
> 
> Just make it really cheap. Can we do that?
> 
> For example, maybe don't bother with the whole "bytes and pages"
> stuff. Just a simple "are we more than one page over?" kind of
> question. Without the 'stock_lock' mess for sub-page bytes etc
> 
> How would that look? Would it result in something that can be done
> cheaply without locking and atomics and without excessive pointer
> indirection through many levels of memcg data structures?

I think it's possible and I'm currently looking into batching charge,
objcg refcnt management and vmstats using per-task caching. It should
speed up things for the majority of allocations.
For allocations from an irq context and targeted allocations
(where the target memcg != memcg of the current task) we'd probably need to
keep the old scheme. I hope to post some patches relatively soon.

I tried to optimize the current implementation but failed to get any
significant gains. It seems that the overhead is very evenly spread across
objcg pointer access, charge management, objcg refcnt management and vmstats.

Thanks!

