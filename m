Return-Path: <linux-fsdevel+bounces-54449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32089AFFC89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7351717E0EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BFF28C86D;
	Thu, 10 Jul 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFfss6a6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D8B221F13;
	Thu, 10 Jul 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136825; cv=none; b=n5lX9B8d2YCxUZfe9NLQjx0wk6uBLgC6ewqbCIume7evywwnvZadqD5OzuhtSYvtmj4B1WmHWLJGlOShvjXpATnAtGvkR8InsMpNTA2pSKvgiioh37iUNCGLwzuWnK0R44U1+RRUg5+whK21OCnHMwAXcLkMsvKuhZ+rLUkTELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136825; c=relaxed/simple;
	bh=9PLxogK3nJE98NYsYw4ic0UVw1bmrgsymXuv+M30YcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAMtO5Oyg7nQbACCvKzVlAVFdLEsQyOx5wK+80hxsRINTTHyYcvcudk/8YlTo4Ki2WJpTD1M0PcyThGlnb2me6tSGUOGW3Ur5WSJYGt2vOTVZUCE6xcntstMIpGRo8tkUE0NklRC6i0TCJK5MWe/doZSjiQ8QYqkFfdFikEk78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFfss6a6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C612CC4CEE3;
	Thu, 10 Jul 2025 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752136824;
	bh=9PLxogK3nJE98NYsYw4ic0UVw1bmrgsymXuv+M30YcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFfss6a6kaDr4H6voAveuCONryrANTdjYoagQas0dkX3aEb6gXvqCFcEuBMH+gqnV
	 gtlEjVA2c5XYLEuswbn+kaVvfSHZSmSSczlZOcu8/cbhGVVq5JJCLilSEGPQNStH86
	 oeLE7XlFXLWgb5gg6Pkt/WON3j1nIVRaYyuNiCXSqUcJqXdEv9AQmOSLeICba9p6nR
	 /RnPb04ir1PJSWKC1IiAO8p8YKRykF8pXNdbBogCfmc3s7wZV0na0H9zZsNzV1JTlX
	 E+lB1K5gFQNR/isOq3ZqEJF4CVvymIfNA9KkXRLX4GMg/vAlt29nbVQvv48/MauA+8
	 sv4UXr1v3dckA==
Date: Thu, 10 Jul 2025 10:40:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <20250710-sitzung-gelaufen-4ee804949772@brauner>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <2dm6bsup7vxwl4vwmllkvt5erncirr272bov4ehd5gix7n2vnw@bkagb26tjtj5>
 <20250708202050.GG2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708202050.GG2672049@frogsfrogsfrogs>

On Tue, Jul 08, 2025 at 01:20:50PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 08, 2025 at 12:20:00PM +0200, Jan Kara wrote:
> > On Mon 07-07-25 17:45:32, Darrick J. Wong wrote:
> > > On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
> > > > 在 2025/7/8 08:32, Dave Chinner 写道:
> > > > > On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
> > > > > > Currently all the filesystems implementing the
> > > > > > super_opearations::shutdown() callback can not afford losing a device.
> > > > > > 
> > > > > > Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> > > > > > involved filesystem.
> > > > > > 
> > > > > > But it will no longer be the case, with multi-device filesystems like
> > > > > > btrfs and bcachefs the filesystem can handle certain device loss without
> > > > > > shutting down the whole filesystem.
> > > > > > 
> > > > > > To allow those multi-device filesystems to be integrated to use
> > > > > > fs_holder_ops:
> > > > > > 
> > > > > > - Replace super_opearation::shutdown() with
> > > > > >    super_opearations::remove_bdev()
> > > > > >    To better describe when the callback is called.
> > > > > 
> > > > > This conflates cause with action.
> > > > > 
> > > > > The shutdown callout is an action that the filesystem must execute,
> > > > > whilst "remove bdev" is a cause notification that might require an
> > > > > action to be take.
> > > > > 
> > > > > Yes, the cause could be someone doing hot-unplug of the block
> > > > > device, but it could also be something going wrong in software
> > > > > layers below the filesystem. e.g. dm-thinp having an unrecoverable
> > > > > corruption or ENOSPC errors.
> > > > > 
> > > > > We already have a "cause" notification: blk_holder_ops->mark_dead().
> > > > > 
> > > > > The generic fs action that is taken by this notification is
> > > > > fs_bdev_mark_dead().  That action is to invalidate caches and shut
> > > > > down the filesystem.
> > > > > 
> > > > > btrfs needs to do something different to a blk_holder_ops->mark_dead
> > > > > notification. i.e. it needs an action that is different to
> > > > > fs_bdev_mark_dead().
> > > > > 
> > > > > Indeed, this is how bcachefs already handles "single device
> > > > > died" events for multi-device filesystems - see
> > > > > bch2_fs_bdev_mark_dead().
> > > > 
> > > > I do not think it's the correct way to go, especially when there is already
> > > > fs_holder_ops.
> > > > 
> > > > We're always going towards a more generic solution, other than letting the
> > > > individual fs to do the same thing slightly differently.
> > > 
> > > On second thought -- it's weird that you'd flush the filesystem and
> > > shrink the inode/dentry caches in a "your device went away" handler.
> > > Fancy filesystems like bcachefs and btrfs would likely just shift IO to
> > > a different bdev, right?  And there's no good reason to run shrinkers on
> > > either of those fses, right?
> > 
> > I agree it is awkward and bcachefs avoids these in case of removal it can
> > handle gracefully AFAICS.
> > 
> > > > Yes, the naming is not perfect and mixing cause and action, but the end
> > > > result is still a more generic and less duplicated code base.
> > > 
> > > I think dchinner makes a good point that if your filesystem can do
> > > something clever on device removal, it should provide its own block
> > > device holder ops instead of using fs_holder_ops.  I don't understand
> > > why you need a "generic" solution for btrfs when it's not going to do
> > > what the others do anyway.
> > 
> > Well, I'd also say just go for own fs_holder_ops if it was not for the
> > awkward "get super from bdev" step. As Christian wrote we've encapsulated
> > that in fs/super.c and bdev_super_lock() in particular but the calling
> > conventions for the fs_holder_ops are not very nice (holding
> > bdev_holder_lock, need to release it before grabbing practically anything
> > else) so I'd have much greater peace of mind if this didn't spread too
> > much. Once you call bdev_super_lock() and hold on to sb with s_umount held,
> > things are much more conventional for the fs land so I'd like if this
> > step happened before any fs hook got called. So I prefer something like
> > Qu's proposal of separate sb op for device removal over exporting
> > bdev_super_lock(). Like:
> > 
> > static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
> > {
> >         struct super_block *sb;
> > 
> >         sb = bdev_super_lock(bdev, false);
> >         if (!sb)
> >                 return;
> > 
> > 	if (sb->s_op->remove_bdev) {
> > 		sb->s_op->remove_bdev(sb, bdev, surprise);
> > 		return;
> > 	}
> 
> It feels odd but I could live with this, particularly since that's the
> direction that brauner is laying down. :)

I want to reiterate that no one is saying "under no circumstances
implement your own holder ops". But if you rely on the VFS locking then
you better not spill it's guts into your filesystem and make us export
this bloody locking that half the world had implemented wrong in their
drivers in the first places spewing endless syzbot deadlocks reports
that we had to track down and fix. That will not happen again similar
way we don't bleed all the nastiness of other locking paths.

Please all stop long philosophical treatises about things no on has ever
argued. btrfs wants to rely on the VFS infra. That is fine and well. We
will support and enable this.

I think the two method idea is fine given that they now are clearly
delineated.

Thanks for providing some clarity here, Darrick and Qu.

