Return-Path: <linux-fsdevel+bounces-54318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73666AFDC76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 02:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B3541855
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 00:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9A486334;
	Wed,  9 Jul 2025 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EZTkqClq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2172613
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021369; cv=none; b=lpRmdy/x4rlROORO1pY9a/6FiuemAI1lYwKxnEIHuy/Gdt/fEMv7GoYUAzm9LwtBCArbDBrrxi8wQkL5Aev1StmRZ6uYEVjVvVbn8mU8qCSGqS4vDEluHWDCc68q02JIpMftjcwuITTV/VgtYXAfiwLGeYUUKrFBAOPTU2eGkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021369; c=relaxed/simple;
	bh=fUHz3XqbUgC3WP4pUyiOq2ck9pa1aY3Zzkj+A7eHqWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ5IQZtNOfp9cXbaF6THQURMu+0quZSL37BHBzKOmLWhCe8NrNPjox71uYNwm6taVcBzDVGcspcuapyFvzIn0Lqw9/5urmf4BV8j9Fa1WrUY02Weh51XkewQv2sseX2/9/S7f1+x3Q9wfTYdYWDNlC8GjBhIaSp/7g6auVygnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EZTkqClq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Jul 2025 20:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752021353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/YwkKFMo8ji56wMQZrrfvtyN8Ysc1/P37tA3zF0r9A=;
	b=EZTkqClqL7e+ujm8CzLoqDaI+JHH9gO3M8nHG2sNs4Po8mSQx70Qg+BaKk0HywM52C/SNm
	7Jlj7CJffhurRND2JMfWCSZ7o5NP0fHzR1n6UTdko0ldi1yEFBbY3XG3gKnMX4RNhRPAJj
	tKW8f6XKSd1wuGDYZi1GvflRpevJ0t8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <lcbj2r4etktljckyv3q4mgryvwqsbl7pwe6sqdtyfwgmunhkov@4oinzvvnt44s>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <20250708-geahndet-rohmaterial-0419fd6a76b3@brauner>
 <aG2i3qP01m-vmFVE@dread.disaster.area>
 <00f5c2a2-4216-4eeb-b555-ef49f8cfd447@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00f5c2a2-4216-4eeb-b555-ef49f8cfd447@gmx.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 09, 2025 at 08:37:05AM +0930, Qu Wenruo wrote:
> 在 2025/7/9 08:29, Dave Chinner 写道:
> > On Tue, Jul 08, 2025 at 09:55:14AM +0200, Christian Brauner wrote:
> > > On Mon, Jul 07, 2025 at 05:45:32PM -0700, Darrick J. Wong wrote:
> > > > On Tue, Jul 08, 2025 at 08:52:47AM +0930, Qu Wenruo wrote:
> > > > > 
> > > > > 
> > > > > 在 2025/7/8 08:32, Dave Chinner 写道:
> > > > > > On Fri, Jul 04, 2025 at 10:12:29AM +0930, Qu Wenruo wrote:
> > > > > > > Currently all the filesystems implementing the
> > > > > > > super_opearations::shutdown() callback can not afford losing a device.
> > > > > > > 
> > > > > > > Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> > > > > > > involved filesystem.
> > > > > > > 
> > > > > > > But it will no longer be the case, with multi-device filesystems like
> > > > > > > btrfs and bcachefs the filesystem can handle certain device loss without
> > > > > > > shutting down the whole filesystem.
> > > > > > > 
> > > > > > > To allow those multi-device filesystems to be integrated to use
> > > > > > > fs_holder_ops:
> > > > > > > 
> > > > > > > - Replace super_opearation::shutdown() with
> > > > > > >     super_opearations::remove_bdev()
> > > > > > >     To better describe when the callback is called.
> > > > > > 
> > > > > > This conflates cause with action.
> > > > > > 
> > > > > > The shutdown callout is an action that the filesystem must execute,
> > > > > > whilst "remove bdev" is a cause notification that might require an
> > > > > > action to be take.
> > > > > > 
> > > > > > Yes, the cause could be someone doing hot-unplug of the block
> > > > > > device, but it could also be something going wrong in software
> > > > > > layers below the filesystem. e.g. dm-thinp having an unrecoverable
> > > > > > corruption or ENOSPC errors.
> > > > > > 
> > > > > > We already have a "cause" notification: blk_holder_ops->mark_dead().
> > > > > > 
> > > > > > The generic fs action that is taken by this notification is
> > > > > > fs_bdev_mark_dead().  That action is to invalidate caches and shut
> > > > > > down the filesystem.
> > > > > > 
> > > > > > btrfs needs to do something different to a blk_holder_ops->mark_dead
> > > > > > notification. i.e. it needs an action that is different to
> > > > > > fs_bdev_mark_dead().
> > > > > > 
> > > > > > Indeed, this is how bcachefs already handles "single device
> > > > > > died" events for multi-device filesystems - see
> > > > > > bch2_fs_bdev_mark_dead().
> > > > > 
> > > > > I do not think it's the correct way to go, especially when there is already
> > > > > fs_holder_ops.
> > > > > 
> > > > > We're always going towards a more generic solution, other than letting the
> > > > > individual fs to do the same thing slightly differently.
> > > > 
> > > > On second thought -- it's weird that you'd flush the filesystem and
> > > > shrink the inode/dentry caches in a "your device went away" handler.
> > > > Fancy filesystems like bcachefs and btrfs would likely just shift IO to
> > > > a different bdev, right?  And there's no good reason to run shrinkers on
> > > > either of those fses, right?
> > > > 
> > > > > Yes, the naming is not perfect and mixing cause and action, but the end
> > > > > result is still a more generic and less duplicated code base.
> > > > 
> > > > I think dchinner makes a good point that if your filesystem can do
> > > > something clever on device removal, it should provide its own block
> > > > device holder ops instead of using fs_holder_ops.  I don't understand
> > > > why you need a "generic" solution for btrfs when it's not going to do
> > > > what the others do anyway.
> > > 
> > > I think letting filesystems implement their own holder ops should be
> > > avoided if we can. Christoph may chime in here. I have no appettite for
> > > exporting stuff like get_bdev_super() unless absolutely necessary. We
> > > tried to move all that handling into the VFS to eliminate a slew of
> > > deadlocks we detected and fixed. I have no appetite to repeat that
> > > cycle.
> > 
> > Except it isn't actually necessary.
> > 
> > Everyone here seems to be assuming that the filesystem *must* take
> > an active superblock reference to process a device removal event,
> > and that is *simply not true*.
> > 
> > bcachefs does not use get_bdev_super() or an active superblock
> > reference to process ->mark_dead events.
> 
> Yes, bcachefs doesn't go this path, but the reason is more important.
> 
> Is it just because there is no such callback so that Kent has to come up his
> own solution, or something else?
> 
> If the former case, all your argument here makes no sense.
> 
> Adding Kent here to see if he wants a more generic s_op->remove_bdev()
> solution or the current each fs doing its own mark_dead() callback.

Consider that the thing that has a block device open might not even be a
filesystem, or at least a VFS filesystem.

It could be a stacking block device driver - md or md - and those
absolutely should be implementing .mark_dead() (likely passing it
through on up the stack), or something else entirely.

In bcachefs's case, we might not even have created the VFS super_block
yet: we don't do that until after recovery finishes, and indeed we can't
because creating a super_block and leaving it in !SB_BORN will cause
such fun as sync calls to hang for the entire system...

