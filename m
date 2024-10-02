Return-Path: <linux-fsdevel+bounces-30664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094998D0A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5297E282A1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128C1E501C;
	Wed,  2 Oct 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvX1o9mC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D10194AE7;
	Wed,  2 Oct 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863205; cv=none; b=tFdwb5B62aopVcJEilYy0v10IfyKNsb9ardWlNLpVRg7fuvFtv3bTz6V5PcZs61AJ/AEVSeTpQODWFbqt+TQNKToxcu1apPyJFw5jd+9OQ46/tdnE5VNat+zrszh9pOWGCqQ/Yu5J1Ks6xrmXJDpRY6pJpAEEBuoo1ElppwuSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863205; c=relaxed/simple;
	bh=ijEIbLRuLXHdvztBmtXY1Q1prGK8qIef/0zXMR4Ki5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfMiO9WOqC1MyGQDivaxhUuKABkZ03muXfV4IMqTKe7yneqwtQWzPZffpeJA+r+lDxSBO8XzJ3691KlpF8iMiHrNe9qQPJ7h8uVWybBK5MCXv8fQZaKjsVK86oZfxcOh/wUSvIcpye3vuxwMz/NDcFm6Fv6+avF25wIQpxpYkJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvX1o9mC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC00C4CEC5;
	Wed,  2 Oct 2024 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727863205;
	bh=ijEIbLRuLXHdvztBmtXY1Q1prGK8qIef/0zXMR4Ki5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvX1o9mCnvepbA4kgq3/Dxk4fC8g7nVYfgmEUDM4vGvf6VYbxygrNLLIZ1c2sbhcV
	 gimLSajH3CNIU1/PDPjJ/KqPLD+X+6nmISQsqvSRabnQ6zg4TMhNg3UCq4UCrxPnCc
	 oxhwEBJWwTts30vhcM9IbFy2he7Q4gfeK4scdzwxFS7GnbxtBGd4KFExUlUonglcdk
	 vAJG2xsX0JMg1gUe56V5RVhO8JMukx5xDPd53AYozNp5X109LQg5rLx9hhEB70utMx
	 hAMLZNhvIvagQD3dccYypKgjWp+LTn958NISyhZhAG5xH18IWf2xFALtVhF1TeWlTa
	 hBSwdiJm2HcRg==
Date: Wed, 2 Oct 2024 12:00:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
References: <20241002014017.3801899-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-1-david@fromorbit.com>

On Wed, Oct 02, 2024 at 11:33:17AM GMT, Dave Chinner wrote:
> The management of the sb->s_inodes list is a scalability limitation;
> it is protected by a single lock and every inode that is
> instantiated has to be added to the list. Those inodes then need to
> be removed from the list when evicted from cache. Hence every inode
> that moves through the VFS inode cache must take this global scope
> lock twice.
> 
> This proves to be a significant limiting factor for concurrent file
> access workloads that repeatedly miss the dentry cache on lookup.
> Directory search and traversal workloads are particularly prone to
> these issues, though on XFS we have enough concurrency capability
> in file creation and unlink for the sb->s_inodes list to be a
> limitation there as well.
> 
> Previous efforts to solve this problem have
> largely centered around reworking the sb->s_inodes list into
> something more scalable such as this longstanding patchset does:
> 
> https://lore.kernel.org/linux-fsdevel/20231206060629.2827226-1-david@fromorbit.com/
> 
> However, a recent discussion about inode cache behaviour that arose
> from the bcachefs 6.12-rc1 pull request opened a new direction for
> us to explore. With both XFS and bcachefs now providing their own
> per-superblock inode cache implementations, we should try to make
> use of these inode caches as first class citizens.
> 
> With that new direction in mind, it became obvious that XFS could
> elide the sb->s_inodes list completely - "the best part is no part"
> - if iteration was not reliant on open-coded sb->s_inodes list
> walks.
> 
> We already use the internal inode cache for iteration, and we have
> filters for selecting specific inodes to operate on with specific
> callback operations. If we had an abstraction for iterating
> all VFS inodes, we can easily implement that directly on the XFS
> inode cache.
> 
> This is what this patchset aims to implement.
> 
> There are two superblock iterator functions provided. The first is a
> generic iterator that provides safe, reference counted inodes for
> the callback to operate on. This is generally what most sb->s_inodes
> iterators use, and it allows the iterator to drop locks and perform
> blocking operations on the inode before moving to the next inode in
> the sb->s_inodes list.
> 
> There is one quirk to this interface - INO_ITER_REFERENCE - because
> fsnotify iterates the inode cache -after- evict_inodes() has been
> called during superblock shutdown to evict all non-referenced
> inodes. Hence it should only find referenced inodes, and it has
> a check to skip unreferenced inodes. This flag does the same.
> 
> However, I suspect this is now somewhat sub-optimal because LSMs can
> hold references to inodes beyond evict_inodes(), and they don't get
> torn down until after fsnotify evicts the referenced inodes it
> holds. However, the landlock LSM doesn't have checks for
> unreferenced inodes (i.e. doesn't use INO_ITER_REFERENCE), so this
> guard is not consistently applied.
> 
> I'm undecided on how best to handle this, but it does not need to be
> solved for this patchset to work. fsnotify and
> landlock don't need to run -after- evict_inodes(), but moving them
> to before evict_inodes() mean we now do three full inode cache
> iterations to evict all the inodes from the cache. That doesn't seem
> like a good idea when there might be hundreds of millions of cached
> inodes at unmount.
> 
> Similarly, needing the iterator to be aware that there should be no
> unreferenced inodes left when they run doesn't seem like a good
> idea, either. So perhaps the answer is that the iterator checks for
> SB_ACTIVE (or some other similar flag) that indicates the superblock
> is being torn down and so will skip zero-referenced inodes
> automatically in this case. Like I said - this doesn't need to be
> solved right now, it's just something to be aware of.
> 
> The second iterator is the "unsafe" iterator variant that only
> provides the callback with an existence guarantee. It does this by
> holding the rcu_read_lock() to guarantee that the inode is not freed
> from under the callback. There are no validity checks performed on
> the inode - it is entirely up to the callback to validate the inode
> can be operated on safely.
> 
> Hence the "unsafe" variant is only for very specific internal uses
> only. Nobody should be adding new uses of this function without
> as there are very few good reasons for external access to inodes
> without holding a valid reference. I have not decided whether the
> unsafe callbacks should require a lockdep_assert_in_rcu_read_lock()
> check in them to clearly document the context under which they are
> running.
> 
> The patchset converts all the open coded iterators to use these
> new iterator functions, which means the only use of sb->s_inodes
> is now confined to fs/super.c (iterator API) and fs/inode.c
> (add/remove API). A new superblock operation is then added to
> call out from the iterators into the filesystem to allow them to run
> the iteration instead of walking the sb->s_inodes list.
> 
> XFS is then converted to use this new superblock operation. I didn't
> use the existing iterator function for this functionality right now
> as it is currently based on radix tree tag lookups. It also uses a
> batched 'lookup and lock' mechanism that complicated matters as I
> developed this code. Hence I open coded a new, simpler cache walk
> for testing purposes.
> 
> Now that I have stuff working and I think I have the callback API
> semantics settled, batched radix tree lookups should still work to
> minimise the iteration overhead. Also, we might want to tag VFS
> inodes in the radix tree so that we can filter them efficiently for
> traversals. This would allow us to use the existing generic inode
> cache walker rather than a separate variant as this patch set
> implements. This can be done as future work, though.
> 
> In terms of scalability improvements, a quick 'will it scale' test
> demonstrates where the sb->s_inodes list hurts. Running a sharded,
> share-nothing cold cache workload with 100,000 files per thread in
> per-thread directories gives the following results on a 4-node 64p
> machine with 128GB RAM.
> 
> The workloads "walk", "chmod" and "unlink" are all directory
> traversal workloads that stream cold cache inodes into the cache.
> There is enough memory on this test machine that these indoes are
> not being reclaimed during the workload, and are being freed between
> steps via drop_caches (which iterates the inode cache and so
> explicitly tests the new iteration APIs!). Hence the sb->s_inodes
> scalability issues aren't as bad in these tests as when memory is
> tight and inodes are being reclaimed (i.e. the issues are worse in
> real workloads).
> 
> The "bulkstat" workload uses the XFS bulkstat ioctl to iterate
> inodes via walking the internal inode btrees. It uses
> d_mark_dontcache() so it is actually tearing down each inode as soon
> as it has been sampled by the bulkstat code. Hence it is doing two
> sb->s_inodes list manipulations per inode and so shows scalability
> issues much earlier than the other workloads.
> 
> Before:
> 
> Filesystem      Files  Threads  Create       Walk      Chmod      Unlink     Bulkstat
>        xfs     400000     4      4.269      3.225      4.557      7.316      1.306
>        xfs     800000     8      4.844      3.227      4.702      7.905      1.908
>        xfs    1600000    16      6.286      3.296      5.592      8.838      4.392
>        xfs    3200000    32      8.912      5.681      8.505     11.724      7.085
>        xfs    6400000    64     15.344     11.144     14.162     18.604     15.494
> 
> Bulkstat starts to show issues at 8 threads, walk and chmod between
> 16 and 32 threads, and unlink is limited by internal XFS stuff.
> Bulkstat is bottlenecked at about 400-450 thousand inodes/s by the
> sb->s_inodes list management.
> 
> After:
> 
> Filesystem      Files  Threads  Create       Walk      Chmod      Unlink     Bulkstat
>        xfs     400000     4      4.140      3.502      4.154      7.242      1.164
>        xfs     800000     8      4.637      2.836      4.444      7.896      1.093
>        xfs    1600000    16      5.549      3.054      5.213      8.696      1.107
>        xfs    3200000    32      8.387      3.218      6.867     10.668      1.125
>        xfs    6400000    64     14.112      3.953     10.365     18.620      1.270
> 
> When patched, walk shows little in way of scalability degradation
> out to 64 threads, chmod is significantly improved at 32-64 threads,
> and bulkstat shows perfect scalability out to 64 threads now.
> 
> I did a couple of other longer running, higher inode count tests
> with bulkstat to get an idea of inode cache streaming rates - 32
> million inodes scanned in 4.4 seconds at 64 threads. That's about
> 7.2 million inodes/s being streamed through the inode cache with the
> IO rates are peaking well above 5.5GB/s (near IO bound).
> 
> Hence raw VFS inode cache throughput sees a ~17x scalability
> improvement on XFS at 64 threads (and probably a -lot- more on
> higher CPU count machines).  That's far better performance than I
> ever got from the dlist conversion of the sb->s_inodes list in
> previous patchsets, so this seems like a much better direction to be
> heading for optimising the way we cache inodes.
> 
> I haven't done a lot of testing on this patchset yet - it boots and
> appears to work OK for block devices, ext4 and XFS, but checking
> stuff like quota on/off is still working properly on ext4 hasn't
> been done yet.
> 
> What do people think of moving towards per-sb inode caching and
> traversal mechanisms like this?

Patches 1-4 are great cleanups that I would like us to merge even
independent of the rest.

I don't have big conceptual issues with the series otherwise. The only
thing that makes me a bit uneasy is that we are now providing an api
that may encourage filesystems to do their own inode caching even if
they don't really have a need for it just because it's there. So really
a way that would've solved this issue generically would have been my
preference.

But the reality is that xfs has been doing that private inode cache for
a long time and reading through 5/7 and 6/7 it clearly provides value
for xfs. So I find it hard to object to adding ->iter_vfs_inodes()
(Though I would like to s/iter_vfs_inodes/iter_inodes/g).

