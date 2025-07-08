Return-Path: <linux-fsdevel+bounces-54230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27312AFC4C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736223A89C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B88C29CB57;
	Tue,  8 Jul 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgxuPBfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4B221282;
	Tue,  8 Jul 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961320; cv=none; b=UiZVNYDfkhpVvfDohNtu2JY/IpU106/bx2uiqCe5oTNx1YDWCtpFxZ3X7cnDFBpkS337bwIKjTh2NLqQKCZCAewTfRwGx1DxLXAjZQHJQa9eQn4FE+fFRuYqQcgfcaMdQtsRwRmgvzdwCkTDTav1M7Z+ykfvps8jZnbxcIr5dys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961320; c=relaxed/simple;
	bh=qsPSN2BpCezUCvdd+RaM6scGQ8lIU5NoJZv7E/OP/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY2gHv0KybElIM+eF7K+SrSE74pcjdUOT6OCdWyniDDI5nEPUTxfRI6LcS2+JaKpq2B3iuGfFU4PkKSP4za2il6giWfDYtUlU7dA9BiVOl37QQhjcKg1aglhBMrYeEOym/T5IFBReM9ai+ZM1jHumYzPexLNERPGkvCxRMKH12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgxuPBfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B88C4CEED;
	Tue,  8 Jul 2025 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751961320;
	bh=qsPSN2BpCezUCvdd+RaM6scGQ8lIU5NoJZv7E/OP/1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgxuPBfh3cZ0dSDKch6I5Rqryw9OXZSRJcFlBBbK2wZk7UGITXp4prgxpzNUQi6VS
	 +nmmibndMCtDY0Li8hfg7Jw/0gZudYRJblZ6FolRAubFzcLMuAsK7XEoKiSDxIgIW1
	 9qRXNQoc/ihFCGt2UwXeahyM5dgBpX/hh1PBhZEkRleJQEzgoAcBwUYxCiRTCaUC1o
	 XPGqDJKxSp5j5XzA1ld1uWapoMzVkWw9oV5u9f/lfYdSi0W1PygUXlIMOWdhVsP0C/
	 ABdtdShHTLFroT13TzZA/Ayi8o093gg45lzstPUfEDRdSAW6wkVshNvzkuIsltRaXJ
	 tIjDK/9jXsNog==
Date: Tue, 8 Jul 2025 09:55:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Dave Chinner <david@fromorbit.com>, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <20250708-geahndet-rohmaterial-0419fd6a76b3@brauner>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708004532.GA2672018@frogsfrogsfrogs>

On Mon, Jul 07, 2025 at 05:45:32PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
> > 
> > 
> > 在 2025/7/8 08:32, Dave Chinner 写道:
> > > On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
> > > > Currently all the filesystems implementing the
> > > > super_opearations::shutdown() callback can not afford losing a device.
> > > > 
> > > > Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> > > > involved filesystem.
> > > > 
> > > > But it will no longer be the case, with multi-device filesystems like
> > > > btrfs and bcachefs the filesystem can handle certain device loss without
> > > > shutting down the whole filesystem.
> > > > 
> > > > To allow those multi-device filesystems to be integrated to use
> > > > fs_holder_ops:
> > > > 
> > > > - Replace super_opearation::shutdown() with
> > > >    super_opearations::remove_bdev()
> > > >    To better describe when the callback is called.
> > > 
> > > This conflates cause with action.
> > > 
> > > The shutdown callout is an action that the filesystem must execute,
> > > whilst "remove bdev" is a cause notification that might require an
> > > action to be take.
> > > 
> > > Yes, the cause could be someone doing hot-unplug of the block
> > > device, but it could also be something going wrong in software
> > > layers below the filesystem. e.g. dm-thinp having an unrecoverable
> > > corruption or ENOSPC errors.
> > > 
> > > We already have a "cause" notification: blk_holder_ops->mark_dead().
> > > 
> > > The generic fs action that is taken by this notification is
> > > fs_bdev_mark_dead().  That action is to invalidate caches and shut
> > > down the filesystem.
> > > 
> > > btrfs needs to do something different to a blk_holder_ops->mark_dead
> > > notification. i.e. it needs an action that is different to
> > > fs_bdev_mark_dead().
> > > 
> > > Indeed, this is how bcachefs already handles "single device
> > > died" events for multi-device filesystems - see
> > > bch2_fs_bdev_mark_dead().
> > 
> > I do not think it's the correct way to go, especially when there is already
> > fs_holder_ops.
> > 
> > We're always going towards a more generic solution, other than letting the
> > individual fs to do the same thing slightly differently.
> 
> On second thought -- it's weird that you'd flush the filesystem and
> shrink the inode/dentry caches in a "your device went away" handler.
> Fancy filesystems like bcachefs and btrfs would likely just shift IO to
> a different bdev, right?  And there's no good reason to run shrinkers on
> either of those fses, right?
> 
> > Yes, the naming is not perfect and mixing cause and action, but the end
> > result is still a more generic and less duplicated code base.
> 
> I think dchinner makes a good point that if your filesystem can do
> something clever on device removal, it should provide its own block
> device holder ops instead of using fs_holder_ops.  I don't understand
> why you need a "generic" solution for btrfs when it's not going to do
> what the others do anyway.

I think letting filesystems implement their own holder ops should be
avoided if we can. Christoph may chime in here. I have no appettite for
exporting stuff like get_bdev_super() unless absolutely necessary. We
tried to move all that handling into the VFS to eliminate a slew of
deadlocks we detected and fixed. I have no appetite to repeat that
cycle.

The shutdown method is implemented only by block-based filesystems and
arguably shutdown was always a misnomer because it assumed that the
filesystem needs to actually shut down when it is called. IOW, we made
it so that it is a call to action but that doesn't have to be the case.
Calling it ->remove_bdev() is imo the correct thing because it gives
block based filesystem the ability to handle device events how they see
fit.

Once we will have non-block based filesystems that need a method to
always shut down the filesystem itself we might have to revisit this
design anyway but no one had that use-case yet.

> 
> Awkward naming is often a sign that further thought (or at least
> separation of code) is needed.
> 
> As an aside:
> 'twould be nice if we could lift the *FS_IOC_SHUTDOWN dispatch out of
> everyone's ioctl functions into the VFS, and then move the "I am dead"
> state into super_block so that you could actually shut down any
> filesystem, not just the seven that currently implement it.

That goes back to my earlier point. Fwiw, I think that's valuable work.

