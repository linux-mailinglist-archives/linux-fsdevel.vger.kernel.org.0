Return-Path: <linux-fsdevel+bounces-37252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84229F0135
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 01:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415B4188A98A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709564A21;
	Fri, 13 Dec 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTKSzEMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC31854
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050575; cv=none; b=T6lEN8vXNN1FhH9w3AMRwxlWDGxk1Tlkn5y8UysiocqWWLh9JtbfpWu3Rr43IXoZLJqkN7UMsfj1d8Ywn6uMW87WTfVREf0B+zCfzXZO6Lf7gh6r0vrpl8M3o1rNJhWvYb5wBX5Fi8xHEBSmzbgh9MiPxLZpQlOFWX2kdEWvUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050575; c=relaxed/simple;
	bh=tgqS6hYMnmVG4C+qN/8RCubVpMdib2fxN3Wz5vfVNBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhFwUiZF1ej9v9xxf8VDnkP8sef3rvMtWplIrAX84o8yzrrzueiAs/m7V8Xd23rSdcUH8l4izz3UPqAI4vw9++deHD7c26xUwIAV/2AH0YRubffpT3XQ9TJrzu0hw6QzRCiXhe6CerGudyYu3aWiNveN6+kwmtObfKKKMDiJwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTKSzEMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5094CC4CECE;
	Fri, 13 Dec 2024 00:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734050575;
	bh=tgqS6hYMnmVG4C+qN/8RCubVpMdib2fxN3Wz5vfVNBM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZTKSzEMn0wGfc6DwCOzNu+JDCUD7ZbU7EV18BwpP0yF4xek6Z1auHuRLqSl+0S806
	 SwByElVceAJ5OGN0QmnwB46U5ghf387mh+36qnII+9nIgshKYM3nQVA0gqxKdaTAvh
	 IitolzrAcH++2qANKKd82D6x1ddhabJtrjY11OgmuusZqRGmr5BahGTv/DuIv4nXcf
	 7gfKOeboWxCCb4uU6UlAlgBpLokipb935vWliUEg4F5XdyjcwmThi+cXc0Vv9/vLtT
	 NUnbOGOCcAPNmGOk8hHSTigDJ9X4ks4c8mSE/nH9B4RF5cSxM8RxHH1ymNV6W/6Ns/
	 gZOljUUxBpsRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B3134CE0E58; Thu, 12 Dec 2024 16:42:54 -0800 (PST)
Date: Thu, 12 Dec 2024 16:42:54 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
	Peter Ziljstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] rculist: add list_bidir_{del,prev}_rcu()
Message-ID: <45e6d720-7a23-4b6e-8c63-6e20dbdc69d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
 <20241213-work-mount-rbtree-lockless-v3-4-6e3cdaf9b280@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-4-6e3cdaf9b280@kernel.org>

On Fri, Dec 13, 2024 at 12:03:43AM +0100, Christian Brauner wrote:
> Currently there is no primitive for retrieving the previous list member.
> To do this we need a new deletion primitive that doesn't poison the prev
> pointer and a corresponding retrieval helper. Note that it is not valid
> to ues both list_del_rcu() and list_bidir_del_rcu() on the same list.
> 
> Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

One additional nit below.  With that fixed:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rculist.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 14dfa6008467e803d57f98cfa0275569f1c6a181..270a9ee2f7976b1736545667973265a3bfb7ec41 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -30,6 +30,17 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>   * way, we must not access it directly
>   */
>  #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
> +/*
> + * Return the ->prev pointer of a list_head in an rcu safe way. Don't
> + * access it directly.
> + *
> + * Any list traversed with list_bidir_prev_rcu() must never use
> + * list_del_rcu().  Doing so will poison the ->prev pointer that
> + * list_bidir_prev_rcu() relies on, which will result in segfaults.
> + * To prevent these segfaults, use list_bidir_del_rcu() instead
> + * of list_del_rcu().
> + */
> +#define list_bidir_prev_rcu(list) (*((struct list_head __rcu **)(&(list)->prev)))
>  
>  /**
>   * list_tail_rcu - returns the prev pointer of the head of the list
> @@ -158,6 +169,42 @@ static inline void list_del_rcu(struct list_head *entry)
>  	entry->prev = LIST_POISON2;
>  }
>  
> +/**
> + * list_bidir_del_rcu - deletes entry from list without re-initialization
> + * @entry: the element to delete from the list.
> + *
> + * In contrast to list_del_rcu() doesn't poison the prev pointer thus
> + * allowing backwards traversal via list_bidir_prev_rcu().
> + *
> + * Note: list_empty() on entry does not return true after this because
> + * the entry is in a special undefined state that permits RCU-based
> + * lockfree reverse traversal. In particular this means that we can not
> + * poison the forward and backwards pointers that may still be used for
> + * walking the list.
> + *
> + * The caller must take whatever precautions are necessary (such as
> + * holding appropriate locks) to avoid racing with another list-mutation
> + * primitive, such as list_bidir_del_rcu() or list_add_rcu(), running on
> + * this same list. However, it is perfectly legal to run concurrently
> + * with the _rcu list-traversal primitives, such as
> + * list_for_each_entry_rcu().
> + *
> + * Noe that the it is not allowed to use list_del_rcu() and
> + * list_bidir_del_rcu() on the same list.

I am guessing that the above paragraph is a leftover?

> + * Note that list_del_rcu() and list_bidir_del_rcu() must not be used on
> + * the same list.
> + *
> + * Note that the caller is not permitted to immediately free
> + * the newly deleted entry.  Instead, either synchronize_rcu()
> + * or call_rcu() must be used to defer freeing until an RCU
> + * grace period has elapsed.
> + */
> +static inline void list_bidir_del_rcu(struct list_head *entry)
> +{
> +	__list_del_entry(entry);
> +}
> +
>  /**
>   * hlist_del_init_rcu - deletes entry from hash list with re-initialization
>   * @n: the element to delete from the hash list.
> 
> -- 
> 2.45.2
> 

