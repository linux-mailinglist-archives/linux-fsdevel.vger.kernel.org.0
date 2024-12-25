Return-Path: <linux-fsdevel+bounces-38124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8BC9FC60D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DE018835F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3662C19258B;
	Wed, 25 Dec 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dFjyE7OZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3D256D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735144357; cv=none; b=UENqawc9IY8P4pl2ZLoQPZSh/4owhSaF4ohwxr4Y0yHn7J+rD8WKWfmZHC5QLiarJ3HVGq7ebJLyNTp1eBErxbWgcSCA3TBMVhFpE9P048SPJH/QHOIJa8kbVRK6V1laSYxI+AFx1qk1zx1RmICXmFq9/4t1ncbUhYGtBPb754Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735144357; c=relaxed/simple;
	bh=aEynyIJVLKOR8r5skvgd2qro9TWMwxNrHeant58Lxs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+kXBcKYqBFrYK4/seIZj+PR8IO0DJNySRGROs5oqMa2Rfh+8xS1dyoCIPn0MGXc1YbejUDZJt7l3y2WkvzL/xXKTEpBZ8hJV12usZnutiPYqGvvqbUfENOT6/ByVkuhO8A4qaaDFp2qnMPZ//Ayp4Xy3eAXvRhfTQCo4OlmK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dFjyE7OZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Dec 2024 11:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735144352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YapoxDcaCdsR8NhLq15jcbunp38SIWnqzkLd1YTmFhY=;
	b=dFjyE7OZVWSV/1WGiACFV66h9IaRlwj5y6iKlNYKVpk0YzBI0FspDliszFTC2u460UXZdb
	emBLfAPBdnRUBy2Kyuc42FoS/NJWYpqMnFBY99DnaE7uXNXFcTjNc+LUFGjcBCyr6j0r9f
	S+4Z6xrdvANvEL571XTIva1JsU+EToQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	WangYuli <wangyuli@uniontech.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yushengjin@uniontech.com, 
	zhangdandan@uniontech.com, guanwentao@uniontech.com, zhanjun@uniontech.com, 
	oliver.sang@intel.com, ebiederm@xmission.com, colin.king@canonical.com, 
	josh@joshtriplett.org, penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu, 
	jes@sgi.com, hch@lst.de, aia21@cantab.net, arjan@infradead.org, 
	jgarzik@pobox.com, neukum@fachschaft.cup.uni-muenchen.de, oliver@neukum.name, 
	dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de, nickpiggin@yahoo.com.au, 
	dhowells@redhat.com, nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, 
	bunk@stusta.de, pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de, 
	davem@davemloft.net, jsipek@cs.sunysb.edu
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <gspf7guqczppgfrus5lfhinyl62xezc4h7nqcnd4m7243v4mna@hxmu2wousrh7>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
 <am7mlhd67ymicifo6qi56pw4e34cj3623drir3rvtisezpl4eu@e5zpca7g5ayy>
 <4tee2rwpqjmx7jj5poxxelv4sp2jyw6nuhpiwrlpv2lurgvpmz@3paxwuit47i6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4tee2rwpqjmx7jj5poxxelv4sp2jyw6nuhpiwrlpv2lurgvpmz@3paxwuit47i6>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 25, 2024 at 05:04:46PM +0100, Mateusz Guzik wrote:
> On Wed, Dec 25, 2024 at 08:53:05AM -0500, Kent Overstreet wrote:
> > On Wed, Dec 25, 2024 at 03:30:05PM +0200, Andy Shevchenko wrote:
> > > Don't you think the Cc list is a bit overloaded?
> > 
> > Indeed, my mail server doesn't let me reply-all.
> > 
> > > On Wed, Dec 25, 2024 at 05:42:02PM +0800, WangYuli wrote:
> > > > +config PIPE_SKIP_SLEEPER
> > > > +	bool "Skip sleeping processes during pipe read/write"
> > > > +	default n
> > > 
> > > 'n' is the default 'default', no need to have this line.
> > 
> > Actually, I'd say to skip the kconfig option for this. Kconfig options
> > that affect the behaviour of core code increase our testing burden, and
> > are another variable to account for when chasing down bugs, and the
> > potential overhead looks negligable.
> > 
> 
> I agree the behavior should not be guarded by an option. However,
> because of how wq_has_sleeper is implemented (see below) I would argue
> this needs to show how often locking can be avoided in real workloads.
> 
> The commit message does state this comes with a slowdown for cases which
> can't avoid wakeups, but as is I thought the submitter just meant an
> extra branch.
> 
> > Also, did you look at adding this optimization to wake_up()? No-op
> > wakeups are very common, I think this has wider applicability.
> 
> I was going to suggest it myself, but then:
> 
> static inline bool wq_has_sleeper(struct wait_queue_head *wq_head)
> {
>         /*
>          * We need to be sure we are in sync with the
>          * add_wait_queue modifications to the wait queue.
>          *
>          * This memory barrier should be paired with one on the
>          * waiting side.
>          */
>         smp_mb();
>         return waitqueue_active(wq_head);
> }
> 
> Which means this is in fact quite expensive.
>
> Since wakeup is a lock + an interrupt trip, it would still be
> cheaper single-threaded to "merely" suffer a full fence and for cases
> where the queue is empty often enough this is definitely the right thing
> to do.

We're comparing against no-op wakeup. A real wakeup does an IPI, which
completely dwarfs the cost of a barrier.

And note that wake_up() is spin_lock_irqsave(), not spin_lock(). I
assume it's gotten better, but back when I was looking at waitqueues
nested pushf/popf was horrifically expensive.

But perhaps can we do this with just a release barrier? Similar to how
list_empty_careful() works.

> On the other hand this executing when the queue is mostly *not* empty
> would combat the point.
> 
> So unfortunately embedding this in wake_up is a no-go.

You definitely can't say that without knowing how often no-op
wake_up()s occur. It wouldn't be hard to gather that (write a patch to
add a pair of percpu counters, throw it on a few machines running random
workloads) and I think the results might surprise you.

