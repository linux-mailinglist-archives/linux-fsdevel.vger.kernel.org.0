Return-Path: <linux-fsdevel+bounces-13241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60C86DA08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187D8B22C41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDDA40C1F;
	Fri,  1 Mar 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wqDaVUra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A483FE36
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263727; cv=none; b=eqsRoKsLkaBQuvABU32TZ5F+3XRCz7OdYTTc1vM43rUABcO9voPiyq4JO1R4YCLd4/7tkiwkiV6z0FXHdn7OmKGtSbU9gaDMrzjm5Go08UZxAP2H1gtXFsRH/zcHnu4Ipc6ztwh/9NNgWiPjeAYX/GtGrn9lXOY+TPxvT9IH4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263727; c=relaxed/simple;
	bh=Fi70G4pkumDilJU3g2YoDjE6xXbrhuxSdsYfs84QP14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptvyuF3RxhOCm03hYdLBJKHHq7bmsG9ea1jY0e2afrHV2JxgsGrg+mx7OJ1Izvaucpl1tWW+ummxYTJMjgWE19j+6i7T9s2drl2Kr8oPf64PqmrAMNVFflQo6y7VhDqf0nTh/RoTL8flsm4jzNO1TK8ALj+zcaa4zsyIatwkvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wqDaVUra; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 22:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709263723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzrkXcFl3rQIY+ikNeM0Wr3ys6+rWyOMJgwkAPjSi+8=;
	b=wqDaVUraQk8wLdVKd/NBwm6DJ31A9k5JoDnQ9iXq+aUw7EydKsONhiYrviC7CB4qsesuwv
	wlY5pEQ4kVh9/+245RcRhqie5fBt25nGxhG40M8df5Tfov/+CA9xzynGF8bVlklfIXmXBu
	v0tFltbA0tKQdlwpUnu5RgoWjKr0eQY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <aq2mefny5fahoggtgfmxwufanwsqmwideyioiiatg777i6quk4@fy72ug5aszzt>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <d4cc365a-6217-4c99-a055-2a0bf34350dc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4cc365a-6217-4c99-a055-2a0bf34350dc@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 02:59:33PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> > On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > Recent discussions [1] suggest that greater mutual understanding between
> > > memory reclaim on the one hand and RCU on the other might be in order.
> > >
> > > One possibility would be an open discussion.  If it would help, I would
> > > be happy to describe how RCU reacts and responds to heavy load, along with
> > > some ways that RCU's reactions and responses could be enhanced if needed.
> > 
> > Adding fsdevel as this should probably be a cross track session.
> 
> The more, the merrier!  ;-)

Starting to look at the practicalities of freeing pages via rcu.

Where to stick the rcu_head might be a problem. I think by the time
we're in free_unref_page() enough of struct page isn't in use that we
can just... throw it in the struct page union somewhere (ok, actually
there's one already for ZONE_DEVICE pages; we just have to make sure it
doesn't collide with anything - probably just compound page metadata).

But it'd be more efficient if we weren't using linked lists for this.
It's premature to ask for this before I've tested or profiled anything,
but I just wanted to throw it out there that we might want to look using
a dequeue for pending frees (and perhaps other things?).

Willy and I were just chatting about this and I think the conclusion
we're coming to is that we'll probably want to try just RCU freeing
_everything_ at first, the reason being that anonymous pages are
probably going to get included and that may end up being most of the
allocations and frees - so why not just do everything.

Meaning - _lots _of memory cycling through RCU, not bounded by device
bandwidth like I initially thought.

Another relevant topic: https://kernelnewbies.org/MatthewWilcox/Memdescs

The plan has been to eventually get an actual enum/type tag for our
different page types, and that would be really helpful for system
visibility/introspection in general, and in particular for this project
where we're going to want to be able to put numbers on different things
for performance analysis and then later probably excluding things from
RCU freeing in a sane standard way (slab, at least).

I wonder if anyone wants to solve this. The problem with doing it now is
that we've got no more page flags on 32 bit, but it'd be _very_ helpful
in future cleanups if we could figure out a way to make it hapen.

That'd help with another wrinkle, which is non compound higher order
pages. Those are tricky to handle, because how do we know the order from
the RCU callback? If we just don't RCU free them, that's sketchy without
the page type enum because we have no way to have a master
definition/list of "these types of pages are RCU freed, these aren't".

Possibly we can just fake-compound them - store the order like it is in
compound pages but don't initialize every page like happens for compound
pages.

