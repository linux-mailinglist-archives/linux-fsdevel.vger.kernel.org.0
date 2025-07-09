Return-Path: <linux-fsdevel+bounces-54379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D78BAFF01F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 19:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C755A7A84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47D2356CB;
	Wed,  9 Jul 2025 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nxOYpGdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F522687C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083379; cv=none; b=DirFN3yH15nmdqA3w4kecXDsnwlfxWYgAut5sP2yavmP8VB4egzU0qlRzh+RW6vVaYWvCqrMyO4y4QoHzu8UB122A62wPXfXeUtgf+nR4tLfGimDLwJFH/zA0d9Cjxj+DBfrtwtFF1/SOwxRk2bmipjOiSDrLIl8yifMaVkHEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083379; c=relaxed/simple;
	bh=O2COwCVuJdzgOw6OpvXMgyjCNr+fnukRUw64/d9W5ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmbgJ3v1Qd+Gi7RYxL2S8i702pfrjOn0qBctgIAKPyO1/npGG7xuON+SbBrd13SoJrILR3Wel/QeBUm29rsGjdkHhDIawnspnT7HGhdliBk3y5JnfYwoVUCcgHRPShGDJ/rrQHj5BSUlzU+jPzK2/xMERhSJH1Q0hjgzNfcqw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nxOYpGdf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Jul 2025 13:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752083364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqDUS4BBDM+csIlPWx+TszLLC9bq/xJu9mUJf/EWg0s=;
	b=nxOYpGdfTMPJVXG5huvcmm3wX800iKwgvi9EibH7o8WPbGD0IbJnuT8Xfh49BzCs2NNRiI
	l7YWbWGNS8/XY+4jyd7qjYN5zK+VF2fi6LvcD3n2iQlxfIicgfoo+0Ab8aH3ZqPTI1/j4M
	/GaxGdzpYELaL0glMe+tv7VhZuKHsRo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <y2rpp6u6pksjrzgxsn5rtcsl2vspffkcbtu6tfzgo7thn7g23p@7quhaixfx5yh>
References: <343vlonfhw76mnbjnysejihoxsjyp2kzwvedhjjjml4ccaygbq@72m67s3e2ped>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343vlonfhw76mnbjnysejihoxsjyp2kzwvedhjjjml4ccaygbq@72m67s3e2ped>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 09, 2025 at 07:23:07PM +0200, Jan Kara wrote:
> On Wed 09-07-25 08:59:42, Dave Chinner wrote:
> > This means that device removal processing can be performed
> > without global filesystem/VFS locks needing to be held. Hence issues
> > like re-entrancy deadlocks when there are concurrent/cascading
> > device failures (e.g. a HBA dies, taking out multiple devices
> > simultaneously) are completely avoided...
> 
> Funnily enough how about:
> 
> bch2_fs_bdev_mark_dead()		umount()
>   bdev_get_fs()
>     bch2_ro_ref_tryget() -> grabs bch_fs->ro_ref
>     mutex_unlock(&bdev->bd_holder_lock);
> 					deactivate_super()
> 					  down_write(&sb->s_umount);
> 					  deactivate_locked_super()
> 					    bch2_kill_sb()
> 					      generic_shutdown_super()
> 					        bch2_put_super()
> 						  __bch2_fs_stop()
> 						    bch2_ro_ref_put()
> 						    wait_event(c->ro_ref_wait, !refcount_read(&c->ro_ref));
>   sb = c->vfs_sb;
>   down_read(&sb->s_umount); -> deadlock
> 
> Which is a case in point why I would like to have a shared infrastructure
> for bdev -> sb transition that's used as widely as possible. Because it
> isn't easy to get the lock ordering right given all the constraints in the
> VFS and block layer code paths for this transition that's going contrary to
> the usual ordering sb -> bdev. And yes I do realize bcachefs grabs s_umount
> not because it itself needs it but because it calls some VFS helpers
> (sync_filesystem()) which expect it to be held so the pain is inflicted
> by VFS here but that just demostrates the fact that VFS and FS locking are
> deeply intertwined and you can hardly avoid dealing with VFS locking rules
> in the filesystem itself.

Getting rid of the s_umount use looks like the much saner and easier
fix - like the comment notes, it's only taken to avoid the warning in
sync_filesystem, we don't actually need it.

Locking gets easier when locks are private to individual subsystems,
protecting specific data structures that are private to those
subsystems.

> > It also avoids the problem of ->mark_dead events being generated
> > from a context that holds filesystem/vfs locks and then deadlocking
> > waiting for those locks to be released.
> > 
> > IOWs, a multi-device filesystem should really be implementing
> > ->mark_dead itself, and should not be depending on being able to
> > lock the superblock to take an active reference to it.
> > 
> > It should be pretty clear that these are not issues that the generic
> > filesystem ->mark_dead implementation should be trying to
> > handle.....
> 
> Well, IMO every fs implementation needs to do the bdev -> sb transition and
> make sb somehow stable. It may be that grabbing s_umount and active sb
> reference is not what everybody wants but AFAIU btrfs as the second
> multi-device filesystem would be fine with that and for bcachefs this
> doesn't work only because they have special superblock instantiation
> behavior on mount for independent reasons (i.e., not because active ref
> + s_umount would be problematic for them) if I understand Kent right.
> So I'm still not fully convinced each multi-device filesystem should be
> shipping their special method to get from device to stable sb reference.

Honestly, the sync_filesystem() call seems bogus.

If the block device is truly dead, what's it going to accomplish?

It's not like we get callbacks for "this device is going to be going
away soon", we only get that in reaction to something that's already
happened.

> > > The shutdown method is implemented only by block-based filesystems and
> > > arguably shutdown was always a misnomer because it assumed that the
> > > filesystem needs to actually shut down when it is called.
> > 
> > Shutdown was not -assumed- as the operation that needed to be
> > performed. That was the feature that was *required* to fix
> > filesystem level problems that occur when the device underneath it
> > disappears.
> > 
> > ->mark_dead() is the abstract filesystem notification from the block
> > device, fs_bdfev_mark_dead() is the -generic implementation- of the
> > functionality required by single block device filesystems. Part of
> > that functionality is shutting down the filesystem because it can
> > *no longer function without a backing device*.
> > 
> > multi-block device filesystems require compeltely different
> > implementations, and we already have one that -does not use active
> > superblock references-. IOWs, even if we add ->remove_bdev(sb)
> > callout, bcachefs will continue to use ->mark_dead() because low
> > level filesystem device management isn't (and shouldn't be!)
> > dependent on high level VFS structure reference counting....
> 
> I have to admit I don't get why device management shouldn't be dependent on
> VFS refcounts / locking. IMO it is often dependent although I agree with
> multiple devices you likely have to do *additional* locking. And yes, I can
> imagine VFS locking could get in your way but the only tangible example we
> have is bcachefs and btrfs seems to be a counter example showing even multi
> device filesystem can live with VFS locking. So I don't think the case is
> as clear as you try to frame it.

Individual devices coming and going has nothing to do with the VFS. If a
single device goes away and we're continuing in RW mode, _no_ VFS state
is affected whatsoever.

The only thing that's needed is a ref to prevent the filesystem from
going away, not a lock. But again given that a bch_fs doesn't
necessarily even have a VFS superblock it's not something we'd use
directly in .mark_dead, that synchronization is handled directly via
kill_sb -> generic_shutdown_super -> and all that...

We don't want bch_fs to outlive the VFS superblock if we do have a VFS
sb, because asynchronous shutdown and releasing of resources causes very
real problems (which already exist for other reasons...)

