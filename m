Return-Path: <linux-fsdevel+bounces-37220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10159EFAE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8BF289224
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9D215710;
	Thu, 12 Dec 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdalSToV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047581C5F07
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028069; cv=none; b=fwNSuW9XdBcwwQAyn+RrRs8vXk+W2lHb6J8zEYL5hRijOA878ozZfPxGma4nukH0znRDZY1Djz6DDwkC0+BGjthZtxTo7y3sCMCuRAFoOek+kv1HGrvwxcXmChCGdRHMZ/2J2QtXAV66v50SPziNJIVINJ1QiWYopHCjwuKtlew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028069; c=relaxed/simple;
	bh=DkgUqvyhitSfDQMtZflHMwwxwJdYvfInF8+Z0nid8+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBNPXas7SmxvgXXzx9rcscIRPNleHuYzJyG+roOXncHY71QeFK6GhjzzJ7hSnde7Fuk5kuGf7DwkmzRTKdaXTTH+QPz3K8vBx96hejlgO/9oiK/qntHeTwRn3XcuAEnArm135pElwx0G+rzSTvJ/IswJtTuV0Tq/+eA6Gk8Sh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdalSToV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B391C4CECE;
	Thu, 12 Dec 2024 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028068;
	bh=DkgUqvyhitSfDQMtZflHMwwxwJdYvfInF8+Z0nid8+Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bdalSToVqxsdgp+5tVIzDQmhc0N9TUgt/cuk4/6ZkdVFnWLk0eErPGMwG+R8jZOLW
	 9b0/TOoN9vllFsgTECyQ8cyd40L7tQYsBdUs22KUSyObDwFUPo8q8yRyQID77GPjeV
	 E6uBfcFlasW5siRApDqCGKu5Djcsdq147KAFP0AyhoozVTx1xlcI7guYYkORn0IwT0
	 uWBi+NIPpSbZU/0DP31lOKnjTp1mqKyGCtbtY0twc5uIIf2l/9Yx983zCj/XLAqu2M
	 YcpQodDAS3nPGYTgCQza07rMdUEVQsPBSNw7a0UkDdTb8Mr0isAvNDnGnLNHsSfxP9
	 +kjBEwldoF+8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E2966CE0EE1; Thu, 12 Dec 2024 10:27:47 -0800 (PST)
Date: Thu, 12 Dec 2024 10:27:47 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
	Peter Ziljstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] rculist: add list_bidir_{del,prev}_rcu()
Message-ID: <3a6b70ce-0299-443b-909d-a88b44ea2a85@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
 <20241212-work-mount-rbtree-lockless-v2-4-4fe6cef02534@kernel.org>
 <a1ca5d04-2bbf-4f2c-8099-02b1e7e400cb@paulmck-laptop>
 <20241212-landjugend-bauamt-9beeaf1562b5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-landjugend-bauamt-9beeaf1562b5@brauner>

On Thu, Dec 12, 2024 at 06:40:48PM +0100, Christian Brauner wrote:
> On Thu, Dec 12, 2024 at 07:18:44AM -0800, Paul E. McKenney wrote:
> > On Thu, Dec 12, 2024 at 12:56:03PM +0100, Christian Brauner wrote:
> > > Currently there is no primite for retrieving the previous list member.
> > 
> > s/primite/primitive/g
> > 
> > To my surprise, there is an English word "primite".  According to Merriam
> > Webster, this is "the anterior member of a pair of gregarines in syzygy".
> > I fervently hope not to have much opportunity to use this word, especially
> > in reference to myself.  But I cannot escape the suspicion that Merriam
> > Webster might be engaging in a little trolling.  ;-)
> 
> :)
> 
> > 
> > > To do this we need a new deletion primite that doesn't poison the prev
> > > pointer and a corresponding retrieval helper. Note that it is not valid
> > > to ues both list_del_rcu() and list_bidir_del_rcu() on the same list.
> > > 
> > > Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > Looks good!  I have a few suggestions below, mostly grammar nits.
> 
> Yes to all.
> 
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  include/linux/rculist.h | 43 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > > 
> > > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > > index 14dfa6008467e803d57f98cfa0275569f1c6a181..c81f9e5a789928ae6825c89325396d638b3e48c5 100644
> > > --- a/include/linux/rculist.h
> > > +++ b/include/linux/rculist.h
> > > @@ -30,6 +30,14 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> > >   * way, we must not access it directly
> > >   */
> > >  #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
> > > +/*
> > > + * Return the ->prev pointer of a list_head in an rcu safe way. Don't
> > > + * access it directly.
> > > + *
> > > + * In order to use list_bidir_prev_rcu() deletions must only be done via
> > > + * list_bidir_del() to avoid poisoning the ->prev pointer.
> > 
> > This should be list_bidir_del_rcu(), right?  If so, I suggest wording
> > this as follows or similar:
> > 
> >  * Any list traversed with list_bidir_prev_rcu() must never use
> >  * list_del_rcu().  Doing so will poison the ->prev pointer that
> >  * list_bidir_prev_rcu() relies on, which will result in segfaults.
> >  * To prevent these segfaults, use list_bidir_del_rcu() instead
> >  * of list_del_rcu().
> > 
> > > + */
> > > +#define list_bidir_prev_rcu(list) (*((struct list_head __rcu **)(&(list)->prev)))
> > 
> > We need a rcu_dereference() in there somewhere, otherwise the compiler
> > might ruin your day.
> > 
> > Huh.  You (quite reasonably) copy-pasta'd list_next_rcu().  So the
> 
> I expect the caller to do the rcu_dereference() just like with
> list_next_rcu():
> 
> At first I made it include a rcu_dereference. But then I realized that
> the api becomes rather wonky because list_next_rcu() would have to be
> called with rcu_dereference() (most caller's do) and
> list_bidir_prev_rcu() wouldn't.
> 
> That seemed very confusing to me so I just kept it aligned with
> list_next_rcu(). Now, the correct follow-up cleanup would obviously be
> to port both helpers to include the rcu_dereference() and thereby simply
> all callers. For the few (mostly inside the header itself) we could just
> add a __list_next_rcu() thing that doesn't include the
> rcu_dereference().

I am not sure what others think, but that sound better than status quo
to me.  And it is not like rcu_dereference() is costly, other than on
DEC Alpha, so we likely don't even need that __list_next_rcu().  Of
course, the opinion of actual hardware overrides my own, as always.

							Thanx, Paul

> > restriction is the same, the caller must use rcu_dereference.  Unless,
> > like seq_list_next_rcu(), you are never dereferencing it.  That said,
> > I am not so sure about the callers of unloaded_tainted_modules_seq_next()
> > and rxrpc_call_seq_next(), which inherit the same restriction.
> > 
> > If those two are used properly with rcu_dereference(), we have empirical
> > evidence indicating that things might be OK.  Otherwise, both need at
> > least an upgrade of their header comments.  ;-)
> > 
> > >  /**
> > >   * list_tail_rcu - returns the prev pointer of the head of the list
> > > @@ -158,6 +166,41 @@ static inline void list_del_rcu(struct list_head *entry)
> > >  	entry->prev = LIST_POISON2;
> > >  }
> > >  
> > > +/**
> > > + * list_bidir_del_rcu - deletes entry from list without re-initialization
> > > + * @entry: the element to delete from the list.
> > > + *
> > > + * In contrat to list_del_rcu() doesn't poison the previous pointer thus
> > 
> > Looks good, but while I am here, I might as well nitpick...
> > 
> > "In constrast".
> > 
> > > + * allowing to go backwards via list_prev_bidir_rcu().
> > 
> > "allowing backwards traversal via"
> > 
> > > + * Note: list_empty() on entry does not return true after this,
> > > + * the entry is in an undefined state. It is useful for RCU based
> > 
> > "because the entry is in a special undefined state that permits
> > RCU-based lockfree reverse traversal."
> > 
> > > + * lockfree traversal.
> > 
> > At which point, you don't need this paragraph break.
> > 
> > > + * In particular, it means that we can not poison the forward
> > 
> > "this means that ... forward and backwards"
> > 
> > > + * pointers that may still be used for walking the list.
> > > + *
> > > + * The caller must take whatever precautions are necessary
> > > + * (such as holding appropriate locks) to avoid racing
> > > + * with another list-mutation primitive, such as list_bidir_del_rcu()
> > > + * or list_add_rcu(), running on this same list.
> > > + * However, it is perfectly legal to run concurrently with
> > > + * the _rcu list-traversal primitives, such as
> > > + * list_for_each_entry_rcu().
> > > + *
> > > + * Noe that the it is not allowed to use list_del_rcu() and
> > 
> > "Note that list_del_rcu() and list_bidir_del_rcu() must not be used on
> > the same list at the same time."
> > 
> > If you want to leave off the "at the same time", I am good.  One could
> > argue that we should not call attention to the possibility of adding
> > this sort of complexity.  Let them need it badly first.  ;-)
> > 
> > > + * list_bidir_del_rcu() on the same list.
> > > + *
> > > + * Note that the caller is not permitted to immediately free
> > > + * the newly deleted entry.  Instead, either synchronize_rcu()
> > > + * or call_rcu() must be used to defer freeing until an RCU
> > > + * grace period has elapsed.
> > > + */
> > > +static inline void list_bidir_del_rcu(struct list_head *entry)
> > > +{
> > > +	__list_del_entry(entry);
> > > +}
> > > +
> > >  /**
> > >   * hlist_del_init_rcu - deletes entry from hash list with re-initialization
> > >   * @n: the element to delete from the hash list.
> > > 
> > > -- 
> > > 2.45.2
> > > 

