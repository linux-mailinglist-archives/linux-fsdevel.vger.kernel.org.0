Return-Path: <linux-fsdevel+bounces-54203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E50AFBF67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 02:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81B97AF210
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 00:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CD1DA10B;
	Tue,  8 Jul 2025 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An1g12mb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2E145B27;
	Tue,  8 Jul 2025 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935533; cv=none; b=ANHkOQBYdrHmDbrhsDAdT1MtTKP0JMfOsgANEslhwSlIVE4830OK/JZR3sIcGdDZHyDLhAWUywF+Tg7yA/FXGOhobf9jg1cdsgJ9pU4fo2Mexr9cR0nDi28dTLnGG89/KTSV5R5ragzU0A5944rLnlzY43b8fz2jHCL01wLlEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935533; c=relaxed/simple;
	bh=SyfWNoh9Z00/hpkgQeKtTe7VULbEcE6tZnu4VonKfXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeNHgcjnZNtNwbrt3J4ddPZz+9whO3jhU5cjRrsLFBoGadtFOn2dxdvAyWb6CQ24/3/5hXxnWjqwbyh8qDT6hLc9HKuGFYSKB2bcoFtkCyl8ghBX6tMvlC/xwhXW6KSMuCve2PWG1mVwoVa3aBRoMlG0jVuYMy/sVnxRXgw43eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An1g12mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4F0C4CEE3;
	Tue,  8 Jul 2025 00:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751935533;
	bh=SyfWNoh9Z00/hpkgQeKtTe7VULbEcE6tZnu4VonKfXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=An1g12mbj+OPThp27l2LzBK6Kea6/V6HUSsPuGBFzUqOcTzLXKzTOESP1Gp8cJb7I
	 vS8coYw0RH69GLJUnemTExyhystL08DjRV2f88I5+Cg/PMZq/fJqaB8HIAJrZKmYyZ
	 JVVls6+h1qG4156UWQySe6HTkDhY6zXIqi9hxDd1SL8yJ7UtR22lmk+mSGsm+BIcAf
	 RTLqBN2/BO+SeJPVIQoMhf7pxvne28//yJVkK4MX34dhu4hLLl6TY2BEeaykR4IMw8
	 l8ZJYhHrzXu0tiHFh7xJUAIgg+j2RbIg/1Bf4Rks5N17T3tGtjAiM8aMe6QHxE+Z6i
	 katjEBgQCVkOQ==
Date: Mon, 7 Jul 2025 17:45:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <20250708004532.GA2672018@frogsfrogsfrogs>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>

On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/7/8 08:32, Dave Chinner 写道:
> > On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
> > > Currently all the filesystems implementing the
> > > super_opearations::shutdown() callback can not afford losing a device.
> > > 
> > > Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> > > involved filesystem.
> > > 
> > > But it will no longer be the case, with multi-device filesystems like
> > > btrfs and bcachefs the filesystem can handle certain device loss without
> > > shutting down the whole filesystem.
> > > 
> > > To allow those multi-device filesystems to be integrated to use
> > > fs_holder_ops:
> > > 
> > > - Replace super_opearation::shutdown() with
> > >    super_opearations::remove_bdev()
> > >    To better describe when the callback is called.
> > 
> > This conflates cause with action.
> > 
> > The shutdown callout is an action that the filesystem must execute,
> > whilst "remove bdev" is a cause notification that might require an
> > action to be take.
> > 
> > Yes, the cause could be someone doing hot-unplug of the block
> > device, but it could also be something going wrong in software
> > layers below the filesystem. e.g. dm-thinp having an unrecoverable
> > corruption or ENOSPC errors.
> > 
> > We already have a "cause" notification: blk_holder_ops->mark_dead().
> > 
> > The generic fs action that is taken by this notification is
> > fs_bdev_mark_dead().  That action is to invalidate caches and shut
> > down the filesystem.
> > 
> > btrfs needs to do something different to a blk_holder_ops->mark_dead
> > notification. i.e. it needs an action that is different to
> > fs_bdev_mark_dead().
> > 
> > Indeed, this is how bcachefs already handles "single device
> > died" events for multi-device filesystems - see
> > bch2_fs_bdev_mark_dead().
> 
> I do not think it's the correct way to go, especially when there is already
> fs_holder_ops.
> 
> We're always going towards a more generic solution, other than letting the
> individual fs to do the same thing slightly differently.

On second thought -- it's weird that you'd flush the filesystem and
shrink the inode/dentry caches in a "your device went away" handler.
Fancy filesystems like bcachefs and btrfs would likely just shift IO to
a different bdev, right?  And there's no good reason to run shrinkers on
either of those fses, right?

> Yes, the naming is not perfect and mixing cause and action, but the end
> result is still a more generic and less duplicated code base.

I think dchinner makes a good point that if your filesystem can do
something clever on device removal, it should provide its own block
device holder ops instead of using fs_holder_ops.  I don't understand
why you need a "generic" solution for btrfs when it's not going to do
what the others do anyway.

Awkward naming is often a sign that further thought (or at least
separation of code) is needed.

As an aside:
'twould be nice if we could lift the *FS_IOC_SHUTDOWN dispatch out of
everyone's ioctl functions into the VFS, and then move the "I am dead"
state into super_block so that you could actually shut down any
filesystem, not just the seven that currently implement it.

--D

> > Hence Btrfs should be doing the same thing as bcachefs. The
> > bdev_handle_ops structure exists precisly because it allows the
> > filesystem to handle block device events in the exact manner they
> > require....
> > 
> > > - Add a new @bdev parameter to remove_bdev() callback
> > >    To allow the fs to determine which device is missing, and do the
> > >    proper handling when needed.
> > > 
> > > For the existing shutdown callback users, the change is minimal.
> > 
> > Except for the change in API semantics. ->shutdown is an external
> > shutdown trigger for the filesystem, not a generic "block device
> > removed" notification.
> 
> The problem is, there is no one utilizing ->shutdown() out of
> fs_bdev_mark_dead().
> 
> If shutdown ioctl is handled through super_operations::shutdown, it will be
> more meaningful to split shutdown and dev removal.
> 
> But that's not the case, and different fses even have slightly different
> handling for the shutdown flags (not all fses even utilize journal to
> protect their metadata).
> 
> Thanks,
> Qu
> 
> 
> > 
> > Hooking blk_holder_ops->mark_dead means that btrfs can also provide
> > a ->shutdown implementation for when something external other than a
> > block device removal needs to shut down the filesystem....
> > 
> > -Dave.
> 

