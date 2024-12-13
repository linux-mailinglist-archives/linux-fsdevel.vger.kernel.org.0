Return-Path: <linux-fsdevel+bounces-37291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD29F0DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA02216A8F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32C1E04A1;
	Fri, 13 Dec 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzl/6QvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44B1E048E
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097776; cv=none; b=jBlQ/KWivqmh2gXGvhU7O4/I7RqnpwIuworY6fT5NX5gqorx7YNOe6b94dqPfqlDZ0HyM8CVN9I4eZwVfdZFOzKI96BcWL5Y6AyTmTn071rx6Km8nEYUUG0PHKjr7CKzx3dR39CRMX3UWdgKWgiFFecD/uRrZRmwloYf7TFdlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097776; c=relaxed/simple;
	bh=xZZmaImhHa80mZkAsCSqri5iP8tcp4beDc0hEJN7i28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHfQsTOzToqT+DGSZmt04B1NtFR3vFZ/nT2DP5zU3HiBydbZUJKWdDBZmAb6AEFWzMnxNyNNdOGPuC1p5bdaahGozI4F+5aYisoeD9xIiJpRAw1xXOIJOafrVB9FcvkMc0b/Iv9tEbD3onx7UsmCGr/VLan18UmYdIk8+wQMMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzl/6QvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA03DC4CED2;
	Fri, 13 Dec 2024 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097776;
	bh=xZZmaImhHa80mZkAsCSqri5iP8tcp4beDc0hEJN7i28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzl/6QvHdz314bltz2Tqqaezox62mj/7wghnoMUg6HQN02TjEfPl/OxGo1Rg0PLf3
	 +8lN9VfFK0lucZ5/Mh9guWvOakzPCXHk85muPwJgY0nXOSnmWS9PL5nY+2DOeSHEyZ
	 /BtDQSS8QjXDG4L2yhhITyvouuX02Va3lMuVLZ9/vE9zHMe4vmRD4C6mLEw9xL+fsv
	 b8ufvTz7DHaGxqUDLn+OcYdIMbCcA1Pgkcnyz6xdn3jcWMMy6/Rd6ByUa2MSmXe5+O
	 WsEI1Q8ahYuhu1lN8KkVmkvtGPi6GrO81kILcJaNTc20NrI2zFUMnl6RDzNgUXMnoS
	 ACR4VlP8n4sfA==
Date: Fri, 13 Dec 2024 14:49:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] rculist: add list_bidir_{del,prev}_rcu()
Message-ID: <20241213-giraffe-gewimmel-fb90d44b6299@brauner>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
 <20241213-work-mount-rbtree-lockless-v3-4-6e3cdaf9b280@kernel.org>
 <45e6d720-7a23-4b6e-8c63-6e20dbdc69d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45e6d720-7a23-4b6e-8c63-6e20dbdc69d6@paulmck-laptop>

On Thu, Dec 12, 2024 at 04:42:54PM -0800, Paul E. McKenney wrote:
> On Fri, Dec 13, 2024 at 12:03:43AM +0100, Christian Brauner wrote:
> > Currently there is no primitive for retrieving the previous list member.
> > To do this we need a new deletion primitive that doesn't poison the prev
> > pointer and a corresponding retrieval helper. Note that it is not valid
> > to ues both list_del_rcu() and list_bidir_del_rcu() on the same list.
> > 
> > Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> One additional nit below.  With that fixed:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thansk, Paul!

> 
> > ---
> >  include/linux/rculist.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index 14dfa6008467e803d57f98cfa0275569f1c6a181..270a9ee2f7976b1736545667973265a3bfb7ec41 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -30,6 +30,17 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> >   * way, we must not access it directly
> >   */
> >  #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
> > +/*
> > + * Return the ->prev pointer of a list_head in an rcu safe way. Don't
> > + * access it directly.
> > + *
> > + * Any list traversed with list_bidir_prev_rcu() must never use
> > + * list_del_rcu().  Doing so will poison the ->prev pointer that
> > + * list_bidir_prev_rcu() relies on, which will result in segfaults.
> > + * To prevent these segfaults, use list_bidir_del_rcu() instead
> > + * of list_del_rcu().
> > + */
> > +#define list_bidir_prev_rcu(list) (*((struct list_head __rcu **)(&(list)->prev)))
> >  
> >  /**
> >   * list_tail_rcu - returns the prev pointer of the head of the list
> > @@ -158,6 +169,42 @@ static inline void list_del_rcu(struct list_head *entry)
> >  	entry->prev = LIST_POISON2;
> >  }
> >  
> > +/**
> > + * list_bidir_del_rcu - deletes entry from list without re-initialization
> > + * @entry: the element to delete from the list.
> > + *
> > + * In contrast to list_del_rcu() doesn't poison the prev pointer thus
> > + * allowing backwards traversal via list_bidir_prev_rcu().
> > + *
> > + * Note: list_empty() on entry does not return true after this because
> > + * the entry is in a special undefined state that permits RCU-based
> > + * lockfree reverse traversal. In particular this means that we can not
> > + * poison the forward and backwards pointers that may still be used for
> > + * walking the list.
> > + *
> > + * The caller must take whatever precautions are necessary (such as
> > + * holding appropriate locks) to avoid racing with another list-mutation
> > + * primitive, such as list_bidir_del_rcu() or list_add_rcu(), running on
> > + * this same list. However, it is perfectly legal to run concurrently
> > + * with the _rcu list-traversal primitives, such as
> > + * list_for_each_entry_rcu().
> > + *
> > + * Noe that the it is not allowed to use list_del_rcu() and
> > + * list_bidir_del_rcu() on the same list.
> 
> I am guessing that the above paragraph is a leftover?

Indeed, fixed!

