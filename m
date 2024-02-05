Return-Path: <linux-fsdevel+bounces-10395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CC084AA83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14673B20A75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331248CD2;
	Mon,  5 Feb 2024 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLDN+XsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679FC433B0;
	Mon,  5 Feb 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175714; cv=none; b=eMCMI4gkVEXvhMojLOzI3U6FiZdfKNCa022IjQBaTr0l3CnZ8aHVGw8bsNqqVWLYQdZknFQjigM2hqiYTzStxE60uHeMSrVObbHzCtcVbwh9VT3GxUQnR3A+12Oh2bc3+ix2pgIHre3NC0xfwP2HEJBCpDaL5BBfVSJz6JbhnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175714; c=relaxed/simple;
	bh=Fk0+oZAIDRthG+u8dq99dvPRt7uamgSucpDNlvNnMYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBMkGJCc6p0PrcNWw+KRuVSFYoBbCYXrbPkWD4d5X0/GErucPgRmubR36GxDDnQN5xadI6GdvNXBCBn5UvnsJPNzHkaMoUbvgwNYC0+pQH0WyKcAwTmRfFd64ze4n11JVcSeeb9P48DJyW9Wgk+iNkRNjcocc9vc5u4yyeTcCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pLDN+XsQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JIIsFta4gl+5qv0d4n9e230yiIydCO8J8/m+BzgHJY4=; b=pLDN+XsQvO7t2QiBwVAsF2exSg
	43QXbQgnOVnj1mYSjjWUqhQQIaxoabHGaq5NTkkUc3GWBbtub4I9WvDfCJ4SDXiDQMRY2eCs9WAxh
	h2Pr+dqnB24mjyDc7TAC5To74Gv5fyz1fZOAzz+wp95uGCssm5mC+T6Bnji08cIZrNUzvFEOlTWPa
	UItzDxkf1fGV/Rn/LShITEeTKCPhrUrpSSSYkjxbG0K+nr2zUconALB0abQAMr3SIhpMYoOV65Hbc
	Zq3wqKl7ex4LL/MbLFfxBj69gDS8zs3JSv8ES963hqgLJuYQe+rHhwo3gTNK/aVEhKPrwLRmH/d+9
	eJWsmJ8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX8O5-0000000AhsX-1yEZ;
	Mon, 05 Feb 2024 23:28:29 +0000
Date: Mon, 5 Feb 2024 23:28:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	LouisQi@zhaoxin.com, JonasZhou@zhaoxin.com
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <ZcFvHfYGH7EwGBRK@casper.infradead.org>
References: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>
 <Zb0EV8rTpfJVNAJA@casper.infradead.org>
 <Zb1DVNGaorZCDS7R@casper.infradead.org>
 <ZcBUat4yjByQC7zg@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcBUat4yjByQC7zg@dread.disaster.area>

On Mon, Feb 05, 2024 at 02:22:18PM +1100, Dave Chinner wrote:
> Intuition tells me that what the OP is seeing is the opposite case
> to above: there is significant contention on the lock. In that case,
> optimal "contention performance" comes from separating the lock and
> the objects it protects into different cachelines.
> 
> The reason for this is that if the lock and objects it protects are
> on the same cacheline, lock contention affects both the lock and the
> objects being manipulated inside the critical section. i.e. attempts
> to grab the lock pull the cacheline away from the CPU that holds the
> lock, and then accesses to the object that are protected by the lock
> then have to pull the cacheline back.
> 
> i.e. the cost of the extra memory fetch from an uncontended
> cacheline is less than the cost of having to repeatedly fetch the
> memory inside a critical section on a contended cacheline.
> 
> I consider optimisation attempts like this the canary in the mine:
> it won't be long before these or similar workloads report
> catastrophic lock contention on the lock in question.  Moving items
> in the structure is equivalent to re-arranging the deck chairs
> whilst the ship sinks - we might keep our heads above water a
> little longer, but the ship is still sinking and we're still going
> to have to fix the leak sooner rather than later...

So the fundamental problem is our data structure.  It's actually two
problems wrapped up in one bad idea.

i_mmap is a struct rb_root_cached:

struct rb_root_cached {
        struct rb_root rb_root;
        struct rb_node *rb_leftmost;
};

struct rb_root {
        struct rb_node *rb_node;
};

so it's two pointers into the tree; one to the leftmost node, one
to the topmost node.  That means we're modifying one or both of these
pointers frequently.  I imagine it's the rb_root, which is being modified
frequently because we're always ... appending to the right?  And so
we're rotating frequently.  Worst case would be if we're appending to
the left and modifying both pointers.

There are things we could do to address this by making rotations less
frequent for the common case, which I suspect is mapping the entire file.
And perhaps we should do these things as a stopgap.

The larger problem is that rbtrees suck.  They suck the same way that
linked lists suck; the CPU can't prefetch very far ahead (or in this
case down).  It can do a little more work in that it can prefetch both
the left & right pointers, but it can't fetch the grandchildren until the
children fetches have finished, so the dependent reads have us stumped.

The solution to this problem is to change the interval tree data structure
from an Red-Black tree to a B-tree, or something similar where we use
an array of pointers instead of a single pointer.  Not the Maple Tree;
that is designed for non-overlapping ranges.  One could take inspiration
from the Maple Tree and design a very similar data structure that can
store and iterate over overlapping ranges.  I can't understand the macros
this late at night, so I don't fully understand what the interval tree
is doing, but I can probably make a more fully informed observation by
the end of the week.

