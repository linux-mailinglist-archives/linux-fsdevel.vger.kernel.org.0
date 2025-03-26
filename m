Return-Path: <linux-fsdevel+bounces-45096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E591A71BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 17:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487C87A5B44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504A1F4629;
	Wed, 26 Mar 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OxbWhJla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB621B3950
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005978; cv=none; b=qnKqKiPN6532zasF1Thix+Ff2Xb2Kb12g7ic7afz0wdBVYHU/FhBkur9lAJ/wTBFENbQYSjTepUgYwxXNhQtXkkaYaEw7sLaeAke9tI4qnEXf3jjD/cbOxrknx/SafZuGk5ir7XVmlEUCo4n4/8LyOPfsEIZUPSkzxpT9zwICjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005978; c=relaxed/simple;
	bh=qgZbKSnEvgoQnXo2J4YioZUMk7IGk74PJxTbllrHXcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3uzHODqVwFdwi2aa9cE3SpHhQYyLc+uw+tP5hHcqydPaRhGDIlDMlA90DayC273SNNUbLASFEvVKzTT+HWzZBqJkNphA9mnA1xToTge4J5YE59Y+HwJI8pZadkX4nocYXa5BLwzQCWW0N3gLy3UYthCGJnO8CtYduMRwBoqV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OxbWhJla; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+FL4jQ7jfJtYr+rNauc09f/kXOG4xRAMPJ7WWh6wqkA=; b=OxbWhJlatg2vMRMEI2PqoacR4w
	PNAN1Q+jJKNoF5opvZJZuAgbsldApO2bbqnhNiAgD8482gq5cJsplie1vV0EQmlj7zmZDgQA/MHqC
	ujZFQNzJlq4p3chCNCe4RSq0axcr9qOz46xGRQoBZlt1I8yqwmSq0eVeUuoimZlckYblbMB/kotzH
	5S0gN0x4Ua886so6qUSjAY3mTKyNnUO2eRmCx/3ReLJlQ4Hy0GN4iVJ4Xgt7EvqONRUKwZUBJy7R/
	Bugrk9ntB7Zdkq/v+QJYu1vj9Xr/DmrzBIRLQry/OP6AZ0Fbxtq0OEmdxMqATmND6cQuR0WBI2r3q
	W63/+jfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txTTZ-00000000ps7-0FO1;
	Wed, 26 Mar 2025 16:19:33 +0000
Date: Wed, 26 Mar 2025 16:19:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [LSF/MM/BPF Topic] Filesystem reclaim & memory allocation BOF
Message-ID: <Z-QpFN4sW6wNXNBP@casper.infradead.org>
References: <Z-QcUwDHHfAXl9mK@casper.infradead.org>
 <20250326155522.GB1459574@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326155522.GB1459574@mit.edu>

On Wed, Mar 26, 2025 at 11:55:22AM -0400, Theodore Ts'o wrote:
> On Wed, Mar 26, 2025 at 03:25:07PM +0000, Matthew Wilcox wrote:
> > 
> > We've got three reports now (two are syzkaller kiddie stuff, but one's a
> > real workload) of a warning in the page allocator from filesystems
> > doing reclaim.  Essentially they're using GFP_NOFAIL from reclaim
> > context.  This got me thinking about bs>PS and I realised that if we fix
> > this, then we're going to end up trying to do high order GFP_NOFAIL allocations
> > in the memory reclaim path, and that is really no bueno.
> > 
> > https://lore.kernel.org/linux-mm/20250326105914.3803197-1-matt@readmodwrite.com/
> > 
> > I'll prepare a better explainer of the problem in advance of this.
> 
> Thanks for proposing this as a last-minute LSF/MM topic!
> 
> I was looking at this myself, and was going to reply to the mail
> thread above, but I'll do it here.
> 
> >From my perspective, the problem is that as part of memory reclaim,
> there is an attempt to shrink the inode cache, and there are cases
> where an inode's refcount was elevated (for example, because it was
> referenced by a dentry), and when the dentry gets flushed, now the
> inode can get evicted.  But if the inode is one that has been deleted,
> then at eviction time the file system will try to release the blocks
> associated with the deleted-file.  This operation will require memory
> allocation, potential I/O, and perhaps waiting for a journal
> transaction to complete.
> 
> So basically, there are a class of inodes where if we are in reclaim,
> we should probably skip trying to evict them because there are very
> likely other inodes that will be more likely to result in memory
> getting released expeditiously.  And if we take a look at
> inode_lru_isolate(), there's logic there already about when inodes
> should skipped getting evicted.  It's probably just a matter of adding
> some additional coditions there.

This is a helpful way of looking at the problem.  I was looking at the
problem further down where we've already entered evict_inode().  At that
point we can't fail.  My proposal was going to be that the filesystem pin
the metadata that it would need to modify in order to evict the inode.
But avoiding entering evict_inode() is even better.

However, I can't see how inode_lru_isolate() can know whether (looking
at the three reports):

 - the ext4 inode table has been reclaimed and ext4 would need to
   allocate memory in order to reload the table from disc in order to
   evict this inode
 - the ext4 block bitmap has been reclaimed and ext4 would need to
   allocate memory in order to reload the bitmap from disc to
   discard the preallocation
 - the fat cluster information has been reclaimed and fat would
   need to allocate memory in order to reload the cluster from
   disc to update the cluster information

If we did have, say, a callback from inode_lru_isolate() to the filesystem
to find out if the inode can be dropped without memory allocation, that
callback would have to pin the underlying memory in order for it to not
be reclaimed between inode_lru_isolate() and evict_inode().

So maybe it makes sense for ->evict_inode() to change from void to
being able to return an errno, and then change the filesystems to not
set GFP_NOFAIL, and instead just decline to evict the inode.

