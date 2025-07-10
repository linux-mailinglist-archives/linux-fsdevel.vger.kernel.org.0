Return-Path: <linux-fsdevel+bounces-54447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4628AFFC7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F71D7BA6B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE3E21FF3C;
	Thu, 10 Jul 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4wYb/wJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547328C2B8;
	Thu, 10 Jul 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136414; cv=none; b=WeotfSEyvek3zyW1mXBHha6Ilog8F0tdAunxMp2lQmFGio7gTtWG3Q6zWEsohROrOl067KL4s3NHjHNMZRYtt2zCOojo+jgIWC7HUqrGr/7JA9ZAsT6Y6NPnNunwEGcpjOtz6jOiDLrzPOJlen6WhRc/wsJcRSPCNJR0VzoI7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136414; c=relaxed/simple;
	bh=R9b7+hWyJ6gpe2+oeqJYo/68ZSLNbj8perkTo8oGBwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxjF2ceA10kBpBOD/EnLkT2AsD14QwYlgmQsglbImzgomeZkHE03dsOI282fs71doAdFx92xPt7LjMWEUCzpYv9707iN0RsmueppJfXjF6cCb45K0xRdDJb5MWfJlrKt61YttgqdpsZv2eeG2BGwXUfrwCkofqvX6xXIn/cQtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4wYb/wJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77394C4CEE3;
	Thu, 10 Jul 2025 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752136414;
	bh=R9b7+hWyJ6gpe2+oeqJYo/68ZSLNbj8perkTo8oGBwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4wYb/wJqU7WvJJS+HWpf+MLbR4QdL3k6V9v1TTBW0gSIbyziqUP77aR5nlTEsLj6
	 ql7ifdWjFUYsBjZnUVXuVU1DlrR++M7jlytzAZHlLuGAEFjGCGnevtsRmBnKta2E0d
	 IV4NUe1U5YRS7bFHuNAkYLG1WusQB1wHNIVm2tIed7LZSEpj7mPoCLVkfRo0opGOX4
	 qw+Nvfp+eSBpOHuEhpPuzsuEhRtuI29DOn/H5yY5UDm5GMsxT8Y3DUrYAVnrOTzy2j
	 F0bO9JcYT1vjE/JPysLLt+3cYSQwUnctap/qv9Ob1QpRo4MbnrV9f+Fkmzu3E1Hyqf
	 i6YqXhl34iobw==
Date: Thu, 10 Jul 2025 10:33:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <20250710-laufkundschaft-watscheln-2b1ea9ee4519@brauner>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <20250708-geahndet-rohmaterial-0419fd6a76b3@brauner>
 <aG2i3qP01m-vmFVE@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG2i3qP01m-vmFVE@dread.disaster.area>

On Wed, Jul 09, 2025 at 08:59:42AM +1000, Dave Chinner wrote:
> On Tue, Jul 08, 2025 at 09:55:14AM +0200, Christian Brauner wrote:
> > On Mon, Jul 07, 2025 at 05:45:32PM -0700, Darrick J. Wong wrote:
> > > On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
> > > > 
> > > > 
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
> > > 
> > > > Yes, the naming is not perfect and mixing cause and action, but the end
> > > > result is still a more generic and less duplicated code base.
> > > 
> > > I think dchinner makes a good point that if your filesystem can do
> > > something clever on device removal, it should provide its own block
> > > device holder ops instead of using fs_holder_ops.  I don't understand
> > > why you need a "generic" solution for btrfs when it's not going to do
> > > what the others do anyway.
> > 
> > I think letting filesystems implement their own holder ops should be
> > avoided if we can. Christoph may chime in here. I have no appettite for
> > exporting stuff like get_bdev_super() unless absolutely necessary. We
> > tried to move all that handling into the VFS to eliminate a slew of
> > deadlocks we detected and fixed. I have no appetite to repeat that
> > cycle.
> 
> Except it isn't actually necessary.
> 
> Everyone here seems to be assuming that the filesystem *must* take
> an active superblock reference to process a device removal event,
> and that is *simply not true*.
> 
> bcachefs does not use get_bdev_super() or an active superblock
> reference to process ->mark_dead events.
> 
> It has it's own internal reference counting on the struct bch_fs
> attached to the bdev that ensures the filesystem structures can't go
> away whilst ->mark_dead is being processed.  i.e. bcachefs is only
> dependent on the bdev->bd_holder_lock() being held when
> ->mark_dead() is called and does not rely on the VFS for anything.
> 
> This means that device removal processing can be performed
> without global filesystem/VFS locks needing to be held. Hence issues
> like re-entrancy deadlocks when there are concurrent/cascading
> device failures (e.g. a HBA dies, taking out multiple devices
> simultaneously) are completely avoided...
> 
> It also avoids the problem of ->mark_dead events being generated
> from a context that holds filesystem/vfs locks and then deadlocking
> waiting for those locks to be released.
> 
> IOWs, a multi-device filesystem should really be implementing
> ->mark_dead itself, and should not be depending on being able to
> lock the superblock to take an active reference to it.
> 
> It should be pretty clear that these are not issues that the generic
> filesystem ->mark_dead implementation should be trying to
> handle.....
> 
> > The shutdown method is implemented only by block-based filesystems and
> > arguably shutdown was always a misnomer because it assumed that the
> > filesystem needs to actually shut down when it is called.
> 
> Shutdown was not -assumed- as the operation that needed to be
> performed. That was the feature that was *required* to fix
> filesystem level problems that occur when the device underneath it
> disappears.
> 
> ->mark_dead() is the abstract filesystem notification from the block
> device, fs_bdfev_mark_dead() is the -generic implementation- of the
> functionality required by single block device filesystems. Part of
> that functionality is shutting down the filesystem because it can
> *no longer function without a backing device*.
> 
> multi-block device filesystems require compeltely different
> implementations, and we already have one that -does not use active
> superblock references-. IOWs, even if we add ->remove_bdev(sb)
> callout, bcachefs will continue to use ->mark_dead() because low
> level filesystem device management isn't (and shouldn't be!)
> dependent on high level VFS structure reference counting....
> 
> > IOW, we made
> > it so that it is a call to action but that doesn't have to be the case.
> > Calling it ->remove_bdev() is imo the correct thing because it gives
> > block based filesystem the ability to handle device events how they see
> > fit.
> 
> And that's exactly what ->mark_dead already provides. 
> 
> And, as I've pointed out above, multi-device filesystems don't
> actually need actively referenced superblocks to process device
> removal notifications. Hence ->mark_dead is the correct interface
> for them to use.

I'm not sure what this is trying to argue about as we agree.

All current filesystems that use the fs_holder_ops require an active
superblock reference. If they want to rewrite themselves to not need an
active superblock reference and switch to custom holder ops then the VFS
doesn't care.

This is about what is currently the case. Everyone is aware that a
filesystem can do this differently.

If btrfs wants to rely on the VFS infrastructure then we will enable it
and we will help them move along and the only requirement is that we
don't have to bleed the VFS locking requirements into the specific
filesystem unnecessarily. That's all this is.

