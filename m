Return-Path: <linux-fsdevel+bounces-37201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905489EF7A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513D8283C7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1715223C58;
	Thu, 12 Dec 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJBrhGYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB4213E6F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024929; cv=none; b=M5RBgioooB1ThxG6D7Vo8OjTp5H1nCx/0n00Qju3NHMW8cAqxq0lQv1+DKWWukk6vSwtLyxFgNc/P24vN3P1QNGTpK1XeqdBMBHSsXT14VFBenrPyLvjXdKHltBsF1z7v6w7wum6DH05vTi+CphXkLc1ciP1s8qkCa/tt35CKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024929; c=relaxed/simple;
	bh=tiLgbfyR2cfECo/zs6bV0I54cASZm5k04NlFBgQ46MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPFP6ELMwz4e2lgIy2sEhGQ9JHfQMUuHj7b2keZ8Wn2NohiZiIqmBmEJUWb4Gssxp1pfH5aOqfbZAkkV5RqY7nJ14sc15OsxI0h+FxZ+8ZOg5k/K3pEaOOJ209C+DsiJD42RwyhBLOnExZF4hld0AAbbBTbplWCt4tK4obJoDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJBrhGYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365B6C4CECE;
	Thu, 12 Dec 2024 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734024927;
	bh=tiLgbfyR2cfECo/zs6bV0I54cASZm5k04NlFBgQ46MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJBrhGYeIK7lGN2OfXfKWpZN+AN36Guof3Y8Zd7eE7sR1gVMTtS5RVuUq3yQK30nh
	 8fvmL2OSWQgqm9qcaYhoGZzUFK1gmw+s+4bdAK1KG9sFsKhCNODUFBjVm2sM3rnITd
	 cLX/gU8rOoEUpoQLPZ56T4v5/EGDVmo+HVb0ZTRaDn5jmlrZ6Vc71vAz0JPDwf4rxU
	 +/VKN/8q1yN0VWnM07rLZIi5JrUbmoyyJiOxMfDuUN2qY//YpZy03NygwVMbHOkD3F
	 Getw8N2HlKjGN+z52dWo49xiWZIcZhap5wZ1nA/xK+p9MySaI+fnJv9m19Ovtuk3NL
	 q6ZPV6bUBZ3+w==
Date: Thu, 12 Dec 2024 18:35:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] fs: lockless mntns rbtree lookup
Message-ID: <20241212-getobt-liege-1546c6a854b3@brauner>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
 <20241212-work-mount-rbtree-lockless-v2-3-4fe6cef02534@kernel.org>
 <20241212120929.GY21636@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212120929.GY21636@noisy.programming.kicks-ass.net>

On Thu, Dec 12, 2024 at 01:09:29PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 12, 2024 at 12:56:02PM +0100, Christian Brauner wrote:
> 
> 
> > @@ -16,7 +16,10 @@ struct mnt_namespace {
> >  	u64 event;
> >  	unsigned int		nr_mounts; /* # of mounts in the namespace */
> >  	unsigned int		pending_mounts;
> > -	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
> > +	union {
> > +		struct rb_node	mnt_ns_tree_node; /* node in the mnt_ns_tree */
> > +		struct rcu_head mnt_ns_rcu;
> > +	};
> >  	refcount_t		passive; /* number references not pinning @mounts */
> >  } __randomize_layout;
> 
> >  static void mnt_ns_tree_remove(struct mnt_namespace *ns)
> >  {
> >  	/* remove from global mount namespace list */
> >  	if (!is_anon_ns(ns)) {
> > -		guard(write_lock)(&mnt_ns_tree_lock);
> > +		mnt_ns_tree_write_lock();
> >  		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
> > +		mnt_ns_tree_write_unlock();
> >  	}
> >  
> > -	mnt_ns_release(ns);
> > +	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
> >  }
> 
> I'm not sure that union is sane; the above means you're overwriting the
> tree node while a concurrent lookup might still see the node and want to
> decent from it.

Though, you're right. I'll fix this up. Thanks for the reviews!

