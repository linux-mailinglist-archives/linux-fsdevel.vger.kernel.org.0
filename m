Return-Path: <linux-fsdevel+bounces-37036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FA89EC82F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2570E287558
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CBE23EA90;
	Wed, 11 Dec 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fAb1uwWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51C23DE95
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907737; cv=none; b=hvz5xFV/C3WbPNsJXyVgo3CjFVwDhNVhDDoCTH1uVgLEtAL7+aeu/XnDb8FkxAmGhH6IeeWR1Nxq+9nkowGJfghtQmExtpk0gnj878IFyrOLncuJa6AS0I/V9C2SKF1qLlHGJK6hlT108z8/4G97x3B2Jsxd1+XUXtu0jtJVY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907737; c=relaxed/simple;
	bh=uRdWfHiBDNOQd8/h8XOO1yHeIn4U/2f0r4FrR926ns4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUokJJn2zeCS6e6RQ11fpK8c5s0l0z0RlD98VnqsPMxUfKshj4EQntFev8E8O4LUMTYjammRRgLQljnIhY1r1Q2ZIecesSYpUQk7siIBV6zvDD3WkCI8LKK6w6huYuGs3aexfLvXhm6GO9J+EyCpfV3gluqw/8MelHEKHveY2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fAb1uwWy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rmYfVcxXWxyu+jjolTzsI3+jDJaJBwG1y5mAmQwHu6Y=; b=fAb1uwWyNrZxXlpx4N7IYkcVVY
	U84GbwHAsBdoyiDnwX5vuAn9H1WBOIK+qxpyt65rBitNX8n5M5J0lZkzA3VXQQgQXtiT68Z6PHlbA
	VrZ3NCyHxpujJg3Znijb5Wtp3C1Bb/0HtyJLfrkrqlcV4ar+5Dds8T9dJ5wyZHKi4I16Z2EUdl44i
	XS1k0QQ/D52ctyZP8wpdsBh8ffaUp9fBMgZ8QvlJx8/CEF4GEM0PISA/WERwVxKX1bOypuEQD84Xn
	Uc9m3wvNGhnu5v1nU4SJSmypWFQWU9nZah3rGtCfE53KoeFQS1K0hJQ4n0xv/HR0BdWmeJVjXwt3h
	E5U4+gVg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIbk-0000000F8Ch-2mVM;
	Wed, 11 Dec 2024 09:02:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A4A030035F; Wed, 11 Dec 2024 10:02:12 +0100 (CET)
Date: Wed, 11 Dec 2024 10:02:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: lockless mntns rbtree lookup
Message-ID: <20241211090212.GR21636@noisy.programming.kicks-ass.net>
References: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
 <20241210-work-mount-rbtree-lockless-v1-3-338366b9bbe4@kernel.org>
 <20241211-agieren-leiblich-3b6f866f27bf@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-agieren-leiblich-3b6f866f27bf@brauner>

On Wed, Dec 11, 2024 at 09:13:16AM +0100, Christian Brauner wrote:
> Hey Peter,
> 
> I had a question for you and meant to Cc you but forgot. This makes one
> of our rbtree uses lockless using the seqlock pattern. See below.
> 
> I saw that in 50a38035ed5c ("rbtree: provide rb_find_rcu() /
> rb_find_add_rcu()") you added new _rcu() variants.

The original patches are much older, see:

  d72da4a4d973 ("rbtree: Make lockless searches non-fatal")
  ade3f510f93a ("rbtree: Implement generic latch_tree")

(aw gawd, almost 10 years)

> We're using another search function that allows us to walk the tree in
> either direction:
> 
>         guard(read_lock)(&mnt_ns_tree_lock);
>         for (;;) {
>                 struct rb_node *node;
> 
>                 if (previous)
>                         node = rb_prev(&mntns->mnt_ns_tree_node);
>                 else
>                         node = rb_next(&mntns->mnt_ns_tree_node);
>                 if (!node)
>                         return ERR_PTR(-ENOENT);
> 
>                 mntns = node_to_mnt_ns(node);
>                 node = &mntns->mnt_ns_tree_node;
> 
> But afaict neither rb_prev() nor rb_next() are rcu safe. Have you ever
> considered adding rcu safe variants for those two as well?

Urgh, those are hard :-(

So back when I did the lockless lookups, I only ensured the child
pointers were 'stable'. I did not deal with the parent (and colour)
pointer.

The next/prev iterators very much rely on the parent pointer.

Someone would have to go through the tree rotations again and see if it
is possible to also update the parent pointers in such a way as to not
create temporary loops.

Notably, the thing you want to avoid is an interrupt doing a tree
traversal on the CPU that's doing the tree rotation getting stuck.

The other, possibly even harder option would be to (finally) implement
threaded RB trees, where the current NULL child pointers become a 'list'
pointer to the next (in-order) element. But that too makes rotations
'interesting' and must avoid creating loops.

But in all those cases you have to also consider the ramifications of
rb_next/prev hitting a modification, I suspect like with the simple
lookup, you can miss entire subtrees. So depending on the requirements,
this might not be suitable for you.

The far easier option might be to simply add a list_head along with the
rb_node and iterate that -- normally the problem with this is that you
can't easily move elements around in an RCU-list, but luck will have it
you don't move elements around. Your tree location is very static
afaict.


