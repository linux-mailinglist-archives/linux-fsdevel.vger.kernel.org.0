Return-Path: <linux-fsdevel+bounces-13574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7A8713BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 03:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40DD1C2092A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22224286B3;
	Tue,  5 Mar 2024 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbRLY+uH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570E11183
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606609; cv=none; b=dybgsQmEokqzezsy7vvA5/cDwpzAQJ/W7tE228tYhzkW8OcysEtHPfE/25DBdk18No8EIt/ivN1WzwSIriCA7H3MmHDflqE/DwafE/SAvPrCYj+L/FD/Eqh/p/m5xmJ0P5L+Yolw8O9uYIuzlhFrqnsSfIRZNsTFJQyB8H1AJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606609; c=relaxed/simple;
	bh=omdC2EN0vy5GVb5GhWUAVkH2ocO5NFBlpObWPw/YSK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4rRdpaL0ggvsgKdXPsaIYSWPhqJxBOkQhQNAt/J/d3gmHpgHQjugdaPRabNDOIamt0Fc65nIcYvY7MIVYLZmWwrjeCB+wArCKrSiRmHgOppPeWVDCJZrzqjGFqyih4UlsDXiM94MqZZUCiHnoqqu6WejGbStewKLl9E9Wh/T0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbRLY+uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59E9C433F1;
	Tue,  5 Mar 2024 02:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709606608;
	bh=omdC2EN0vy5GVb5GhWUAVkH2ocO5NFBlpObWPw/YSK8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BbRLY+uHdSrPfC6z84LFdliGI9L9DY/2VwG0JJKSXiVVrg8HotBEXv5iHX4yLSIEy
	 yZMlN4X+sZt+BxSp+uUznTLL17Dxn9oQQkUwT2TWov6SSUSX2+RU7Wlnd6srslSuHv
	 y7t85R2uFCRjI66UdZ/pXVsiN4PGWcKJ+WomoAaLRmeG04nlsj5Kh339AawULP5Re5
	 dPSzIUEzJuKvBpt+YbDVSYJ7LSj93C6tyYku7w/ETvZI3gowooxJ15dfyTpGJIBho0
	 uxNcA/Tz1ksNlboWoMYYn/oCMET6rORh0Yc80F7lx7x26Aj+UX3nKGZHbxDNV9ix6s
	 Ou0y3zinIbScA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83B8CCE04AE; Mon,  4 Mar 2024 18:43:27 -0800 (PST)
Date: Mon, 4 Mar 2024 18:43:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <00cc9c30-866b-4832-821c-e5a1f860b6db@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <d4cc365a-6217-4c99-a055-2a0bf34350dc@paulmck-laptop>
 <aq2mefny5fahoggtgfmxwufanwsqmwideyioiiatg777i6quk4@fy72ug5aszzt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aq2mefny5fahoggtgfmxwufanwsqmwideyioiiatg777i6quk4@fy72ug5aszzt>

On Thu, Feb 29, 2024 at 10:28:33PM -0500, Kent Overstreet wrote:
> On Tue, Feb 27, 2024 at 02:59:33PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> > > On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > Recent discussions [1] suggest that greater mutual understanding between
> > > > memory reclaim on the one hand and RCU on the other might be in order.
> > > >
> > > > One possibility would be an open discussion.  If it would help, I would
> > > > be happy to describe how RCU reacts and responds to heavy load, along with
> > > > some ways that RCU's reactions and responses could be enhanced if needed.
> > > 
> > > Adding fsdevel as this should probably be a cross track session.
> > 
> > The more, the merrier!  ;-)
> 
> Starting to look at the practicalities of freeing pages via rcu.
> 
> Where to stick the rcu_head might be a problem. I think by the time
> we're in free_unref_page() enough of struct page isn't in use that we
> can just... throw it in the struct page union somewhere (ok, actually
> there's one already for ZONE_DEVICE pages; we just have to make sure it
> doesn't collide with anything - probably just compound page metadata).
> 
> But it'd be more efficient if we weren't using linked lists for this.
> It's premature to ask for this before I've tested or profiled anything,
> but I just wanted to throw it out there that we might want to look using
> a dequeue for pending frees (and perhaps other things?).

You could certainly use pages of pointers like kfree_rcu() does, at
least when there is ample memory.  You could go further and allocate
those pages as the structures are being allocated in order to guarantee
that you never run short.  The accounting is likely to be a bit tricky,
but definitely doable.

You could also use polled grace periods:

o	start_poll_synchronize_rcu_full() to get a "cookie".  If you
	already have a batch for that cookie, add the new block to
	that batch.  The cookie is then associated with the batch,
	not the individual block.

	The batch could be tied together by a non-linked-list data
	structure, if desired, and need not have any storage overhead
	at all within the blocks themselves.

o	poll_state_synchronize_rcu_full() to check if a batch's
	cookie corresponds to a completed grace period.  Free
	up the batch if so.

o	cond_synchronize_rcu_full() to block until the specified
	cookie's grace period ends.  (I suspect you won't want to
	do this, but just in case.)

o	cond_synchronize_rcu_expedited_full() is as above, but
	it uses an expedited grace period to do the waiting.

o	NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE gives the maximum number
	of cookies that can correspond to a grace period that has
	not yet completed.  This is a numerical constant that can
	be used to size an array.

If things are piling up, you can call synchronize_rcu_expedited(),
and that will cause all cookies collected before that call to suddenly
correspond to completed grace periods.  Where "suddenly" is give or take
long RCU readers elsewhere in the kernel.

Does this help?

> Willy and I were just chatting about this and I think the conclusion
> we're coming to is that we'll probably want to try just RCU freeing
> _everything_ at first, the reason being that anonymous pages are
> probably going to get included and that may end up being most of the
> allocations and frees - so why not just do everything.
> 
> Meaning - _lots _of memory cycling through RCU, not bounded by device
> bandwidth like I initially thought.

There already is the possibility of users doing close(open(...)) in a
tight loop, which is why rcutorture does callback flooding.  But each
new use case brings a parcel of risk, so I do not claim that either of
these mean that further adjustments, up to and including inventing a
new synchronization primitive, won't be needed.

> Another relevant topic: https://kernelnewbies.org/MatthewWilcox/Memdescs

Not sure how this relates, but good to know.

> The plan has been to eventually get an actual enum/type tag for our
> different page types, and that would be really helpful for system
> visibility/introspection in general, and in particular for this project
> where we're going to want to be able to put numbers on different things
> for performance analysis and then later probably excluding things from
> RCU freeing in a sane standard way (slab, at least).
> 
> I wonder if anyone wants to solve this. The problem with doing it now is
> that we've got no more page flags on 32 bit, but it'd be _very_ helpful
> in future cleanups if we could figure out a way to make it hapen.
> 
> That'd help with another wrinkle, which is non compound higher order
> pages. Those are tricky to handle, because how do we know the order from
> the RCU callback? If we just don't RCU free them, that's sketchy without
> the page type enum because we have no way to have a master
> definition/list of "these types of pages are RCU freed, these aren't".

If I understand correctly, this might be another reason for using pages
of pointers rather than rcu_head structures.

> Possibly we can just fake-compound them - store the order like it is in
> compound pages but don't initialize every page like happens for compound
> pages.

I must defer to you guys on this one.

							Thanx, Paul

