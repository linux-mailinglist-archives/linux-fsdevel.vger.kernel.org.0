Return-Path: <linux-fsdevel+bounces-37039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3D9EC953
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B4F188D41B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E21EC4C2;
	Wed, 11 Dec 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyaLI1nF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297F1EC4EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909961; cv=none; b=GQXGqZGjytfq4cvO1FfggHgZa7Oy7ymNowgW6OfEz3TxfQo6E9R7rrdnHMLmWXQXZpJw4/Uwg/7DRuCWBWtWpTjmsfUL0Q+8OTqUyIPB5m3Ond4JZDBU69gPwfpUW9N8gregxRSfahftxcIyLhMRDjsK23MzQqVLiEHAtpPIFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909961; c=relaxed/simple;
	bh=uAaVKafj36MXkuW/lu/ZlUaDGtFFkpA07JqbaIDleqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz7EyTp7cre6aR6mlPFiKHft19l7egVMlc7EsR805iG/uJIxnrRdiRMDwAZqLRM8i8uapW0IjrlbtgWy7xxwIngUEIUZJ+7aSZvXyI6aDI9gytSZKMEHauESi9UEhGk2TpmIIPl62FFvkahyhjzDnxKiZBbw0DyVwZAOpopLdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyaLI1nF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B43C4CEE1;
	Wed, 11 Dec 2024 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733909960;
	bh=uAaVKafj36MXkuW/lu/ZlUaDGtFFkpA07JqbaIDleqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyaLI1nFrwA5mg6F5TtJLbaUQVANwHwbcfrt81ufq+W/JYxvsIfc467/jAWkXHXV2
	 XjcywGyzy/ezSx/PHULu2godGv8dfJtZeutZB95w7yAse9cFir2xhQ4bX8Kc9mbdxJ
	 TqC4n98yi+yqmSkoNSAMXSVAsVYnvZYOnIXo+7t+zwm6nOSVaEmJ1wO7lzQCU/BtD3
	 pEBK+12xtmDSh0c1CnH7Zt1c0YuHgYHAdsXPfRg9JEV/1PmCa748ny5y2FkeXvrDeK
	 yvS8DHq90EIcHJ60YcbrOrZL/wR9C/R8OYFXUi2wwlr276k0JCb/FoapGUS16q+LQB
	 zLlnbKG1/gibg==
Date: Wed, 11 Dec 2024 10:39:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: lockless mntns rbtree lookup
Message-ID: <20241211-schellen-dezent-1e4b3b7d3b15@brauner>
References: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
 <20241210-work-mount-rbtree-lockless-v1-3-338366b9bbe4@kernel.org>
 <20241211-agieren-leiblich-3b6f866f27bf@brauner>
 <20241211090212.GR21636@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211090212.GR21636@noisy.programming.kicks-ass.net>

On Wed, Dec 11, 2024 at 10:02:12AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 11, 2024 at 09:13:16AM +0100, Christian Brauner wrote:
> > Hey Peter,
> > 
> > I had a question for you and meant to Cc you but forgot. This makes one
> > of our rbtree uses lockless using the seqlock pattern. See below.
> > 
> > I saw that in 50a38035ed5c ("rbtree: provide rb_find_rcu() /
> > rb_find_add_rcu()") you added new _rcu() variants.
> 
> The original patches are much older, see:
> 
>   d72da4a4d973 ("rbtree: Make lockless searches non-fatal")
>   ade3f510f93a ("rbtree: Implement generic latch_tree")
> 
> (aw gawd, almost 10 years)
> 
> > We're using another search function that allows us to walk the tree in
> > either direction:
> > 
> >         guard(read_lock)(&mnt_ns_tree_lock);
> >         for (;;) {
> >                 struct rb_node *node;
> > 
> >                 if (previous)
> >                         node = rb_prev(&mntns->mnt_ns_tree_node);
> >                 else
> >                         node = rb_next(&mntns->mnt_ns_tree_node);
> >                 if (!node)
> >                         return ERR_PTR(-ENOENT);
> > 
> >                 mntns = node_to_mnt_ns(node);
> >                 node = &mntns->mnt_ns_tree_node;
> > 
> > But afaict neither rb_prev() nor rb_next() are rcu safe. Have you ever
> > considered adding rcu safe variants for those two as well?
> 
> Urgh, those are hard :-(
> 
> So back when I did the lockless lookups, I only ensured the child
> pointers were 'stable'. I did not deal with the parent (and colour)
> pointer.
> 
> The next/prev iterators very much rely on the parent pointer.
> 
> Someone would have to go through the tree rotations again and see if it
> is possible to also update the parent pointers in such a way as to not
> create temporary loops.
> 
> Notably, the thing you want to avoid is an interrupt doing a tree
> traversal on the CPU that's doing the tree rotation getting stuck.
> 
> The other, possibly even harder option would be to (finally) implement
> threaded RB trees, where the current NULL child pointers become a 'list'
> pointer to the next (in-order) element. But that too makes rotations
> 'interesting' and must avoid creating loops.

Ah, "fun".

> 
> But in all those cases you have to also consider the ramifications of
> rb_next/prev hitting a modification, I suspect like with the simple
> lookup, you can miss entire subtrees. So depending on the requirements,

I think it's fine as long was have the ability to detect that the tree
was modified and retry - like in the simple lookup case. I was happy to
see that you guarantee that only false negatives are possible. Last I
looked at this some time ago Paul was much more pessimistic about
walking the tree with seqlock and rcu. It's good that this now work
afaik.

> this might not be suitable for you.
> 
> The far easier option might be to simply add a list_head along with the
> rb_node and iterate that -- normally the problem with this is that you
> can't easily move elements around in an RCU-list, but luck will have it
> you don't move elements around. Your tree location is very static

Good idea. Yeah, we don't move anything around. And our insertions are
done with a key that's unique - the 64bit mount id - for the system
lifetime.

> afaict.
> 

