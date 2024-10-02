Return-Path: <linux-fsdevel+bounces-30812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF4F98E6B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4843C1F23958
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD2919E968;
	Wed,  2 Oct 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DwhyTsWl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95F19CC23
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911229; cv=none; b=sX+/2lr64rdirDwqB2INbdWhi47PDg/rMsja/Z/3SFwWlu3IZLeWTbPwt6g30rA8amdCdk2SAGANOiNxFsiI8WT3kL4MMVThQ/ewBVAlqUnVRLwi6wsLjLHo6U4hw+D07NDiM+4qTD5M/9dw61cuaEKk7WHay1lU6VJfZ8b5d4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911229; c=relaxed/simple;
	bh=pp/slid8/O0c/UUtwXTxwhz36Kfe3RUUKLzNWVaALF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDD2MtMp+nn35SLft7R+V8UVO1zqFwqZ9fGDA4jxu8ZFjr2McjEfnZAJ9c6eo+MsvJZmJhTQSuIEoFEjlzbAC6XJ0SNdWgp/9DweT6N1OWFTBCZYUpOxTeerKks4/6fS7WdGUe1DUVZC0BGUW0XIqICNiug0Gs5BZ4ve8DYMnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DwhyTsWl; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Oct 2024 19:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727911224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xLkwMxr7ZkJaXqXvZL4m90RK+g1vxaiEOpeHKPxXofk=;
	b=DwhyTsWlLm61NFgVm+hIwrWLOyFmMz5qSPtcmQ38VCGKoaSlZchGb0TGq4I6P1WvfvoWb7
	lMTSYXVG0IY/l69/rRUJ/PW7A7YRQJMdSiF1BJngMeZZ/11IVg14ve5m7lWGfCbP6/wOp6
	AzU4O+DsK19q15UGu+NAZkUeNCanWsE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <lngs2n3kfwermwuadhrfq2loff3k4psydbjullhecuutthpqz3@4w6cybx7boxw>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <3lukwhxkfyqz5xsp4r7byjejrgvccm76azw37pmudohvxcxqld@kiwf5f5vjshk>
 <Zv3H8BxJX2GwNW2Y@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv3H8BxJX2GwNW2Y@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 03, 2024 at 08:23:44AM GMT, Dave Chinner wrote:
> On Wed, Oct 02, 2024 at 03:29:10PM -0400, Kent Overstreet wrote:
> > On Wed, Oct 02, 2024 at 10:34:58PM GMT, Dave Chinner wrote:
> > > On Wed, Oct 02, 2024 at 12:00:01PM +0200, Christian Brauner wrote:
> > > > On Wed, Oct 02, 2024 at 11:33:17AM GMT, Dave Chinner wrote:
> > > > > What do people think of moving towards per-sb inode caching and
> > > > > traversal mechanisms like this?
> > > > 
> > > > Patches 1-4 are great cleanups that I would like us to merge even
> > > > independent of the rest.
> > > 
> > > Yes, they make it much easier to manage the iteration code.
> > > 
> > > > I don't have big conceptual issues with the series otherwise. The only
> > > > thing that makes me a bit uneasy is that we are now providing an api
> > > > that may encourage filesystems to do their own inode caching even if
> > > > they don't really have a need for it just because it's there.  So really
> > > > a way that would've solved this issue generically would have been my
> > > > preference.
> > > 
> > > Well, that's the problem, isn't it? :/
> > > 
> > > There really isn't a good generic solution for global list access
> > > and management.  The dlist stuff kinda works, but it still has
> > > significant overhead and doesn't get rid of spinlock contention
> > > completely because of the lack of locality between list add and
> > > remove operations.
> > 
> > There is though; I haven't posted it yet because it still needs some
> > work, but the concept works and performs about the same as dlock-list.
> > 
> > https://evilpiepirate.org/git/bcachefs.git/log/?h=fast_list
> > 
> > The thing that needs to be sorted before posting is that it can't shrink
> > the radix tree. generic-radix-tree doesn't support shrinking, and I
> > could add that, but then ida doesn't provide a way to query the highest
> > id allocated (xarray doesn't support backwards iteration).
> 
> That's an interesting construct, but...
> 
> > So I'm going to try it using idr and see how that performs (idr is not
> > really the right data structure for this, split ida and item radix tree
> > is better, so might end up doing something else).
> > 
> > But - this approach with more work will work for the list_lru lock
> > contention as well.
> 
> ....  it isn't a generic solution because it is dependent on
> blocking memory allocation succeeding for list_add() operations.
> 
> Hence this cannot do list operations under external synchronisation
> constructs like spinlocks or rcu_read_lock(). It also introduces
> interesting interactions with memory reclaim - what happens we have
> to add an object to one of these lists from memory reclaim context?
> 
> Taking the example of list_lru, this list construct will not work
> for a variety of reasons. Some of them are:
> 
> - list_lru_add() being called from list_lru_add_obj() under RCU for
>   memcg aware LRUs so cannot block and must not fail.
> - list_lru_add_obj() is called under spinlocks from inode_lru_add(),
>   the xfs buffer and dquot caches, the workingset code from under
>   the address space mapping xarray lock, etc. Again, this must not
>   fail.
> - list_lru_add() operations take can place in large numbers in
>   memory reclaim context (e.g. dentry reclaim drops inodes which
>   adds them to the inode lru). Hence memory reclaim becomes even
>   more dependent on PF_MEMALLOC memory allocation making forwards
>   progress.
> - adding long tail list latency to what are currently O(1) fast path
>   operations (e.g.  mulitple allocations tree splits for LRUs
>   tracking millions of objects) is not desirable.
> 
> So while I think this is an interesting idea that might be useful in
> some cases, I don't think it is a viable generic scalable list
> construct we can use in areas like list_lru or global list
> management that run under external synchronisation mechanisms.

There are difficulties, but given the fundamental scalability and
locking issues with linked lists, I think this is the approach we want
if we can make it work.

A couple things that help - we've already determined that the inode LRU
can go away for most filesystems, and we can preallocate slots without
actually adding objects. Iteration will see NULLs that they skip over,
so we can't simply preallocate a slot for everything if nr_live_objects
/ nr_lru_objects is too big. But, we can certainly preallocate slots on
a given code path and then release them back to the percpu buffer if
they're not used.

> - LRU lists are -ordered- (it's right there in the name!) and this
>   appears to be an unordered list construct.

Yes, it is. But in actual practice cache replacement policy tends not to
matter nearly as much as people think; there's many papers showing real
world hit ratio of common algorithms is only a fudge factor from random
replacement - the main thing you want is an accessed bit (or counter, if
you want the analagous version of n-lru for n > 2), and we'll still have
that.

