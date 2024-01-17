Return-Path: <linux-fsdevel+bounces-8157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324968306E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 14:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC561F2657C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3350B1F610;
	Wed, 17 Jan 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQGWDOx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181A1EB57;
	Wed, 17 Jan 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497589; cv=none; b=bx4wDioZ6d6bEugF8HB0z7yw8jg0AMjoaDXn7G1DDutMV/xMl3MiI7k850/HAsPUkryl8MlnvbxrDfaxkZaEDKxz4E4eoY2y+ivjRHvo5ZPSwTzAcG2EZAX6gMkz4PcwGtpW3zl3Elt/nI8TEHm6HBN9S3iEqdUaSXjfP7AuSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497589; c=relaxed/simple;
	bh=PFwWNdCAPHdz4P1b3gtmw5Cqqs2CPi48jQ7oai7GPro=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=SpCJWq97YWvqt3RSFisgTcPxbZTWof/N7s6LyHPSqQ/Qy8rsSRNT7+gfqGFwJ09ho1XZr0netpmL1JVBXT+MS7Ue0IeLLBTRNcu7sxWt3jwkMFrf0PW/GyGPUYBucQv7f95FCswP4foH/Q+AoZ2FQ5T83bLkHXKTHps5lwjpAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQGWDOx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C2EC433C7;
	Wed, 17 Jan 2024 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705497589;
	bh=PFwWNdCAPHdz4P1b3gtmw5Cqqs2CPi48jQ7oai7GPro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQGWDOx+k9/gtTlV55SvHK6YUjTw+wm+xhLrBjx2MlYgoVwNOaP6nf+m+kaLdejFf
	 Y04Pvgx7/3X0l9L+mXg+6fqLwiCM/sXrhvNsbMi5BbNUVLEhcW9aUUUgaAwVwszxlL
	 dw9ebqaY/u3Uir4vJfV6W/2XgsDF/sh8O1vMAuPyhBW4uvOOoajXFLJ5sxioqM+uU+
	 cAhUxThfI3aHqjpB4W4InYUByKDpGo8g9iDvRLMHas78O3VIqNtyf51LflG1wvnK1x
	 Fi1zqzl7t5A0R667dcj8bg07nID9RXzniHIuZwT4Ak+RmfKsVouaxBDJBlsR5nz1nu
	 kk4xNvM9wyRww==
Date: Wed, 17 Jan 2024 14:19:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	adrianvovk@gmail.com
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <20240117-yuppie-unflexibel-dbbb281cb948@brauner>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <ZabtYQqakvxJVYjM@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZabtYQqakvxJVYjM@dread.disaster.area>

On Wed, Jan 17, 2024 at 07:56:01AM +1100, Dave Chinner wrote:
> On Tue, Jan 16, 2024 at 11:50:32AM +0100, Christian Brauner wrote:
> > Hey,
> > 
> > I'm not sure this even needs a full LSFMM discussion but since I
> > currently don't have time to work on the patch I may as well submit it.
> > 
> > Gnome recently got awared 1M Euro by the Sovereign Tech Fund (STF). The
> > STF was created by the German government to fund public infrastructure:
> > 
> > "The Sovereign Tech Fund supports the development, improvement and
> >  maintenance of open digital infrastructure. Our goal is to sustainably
> >  strengthen the open source ecosystem. We focus on security, resilience,
> >  technological diversity, and the people behind the code." (cf. [1])
> > 
> > Gnome has proposed various specific projects including integrating
> > systemd-homed with Gnome. Systemd-homed provides various features and if
> > you're interested in details then you might find it useful to read [2].
> > It makes use of various new VFS and fs specific developments over the
> > last years.
> > 
> > One feature is encrypting the home directory via LUKS. An approriate
> > image or device must contain a GPT partition table. Currently there's
> > only one partition which is a LUKS2 volume. Inside that LUKS2 volume is
> > a Linux filesystem. Currently supported are btrfs (see [4] though),
> > ext4, and xfs.
> > 
> > The following issue isn't specific to systemd-homed. Gnome wants to be
> > able to support locking encrypted home directories. For example, when
> > the laptop is suspended. To do this the luksSuspend command can be used.
> > 
> > The luksSuspend call is nothing else than a device mapper ioctl to
> > suspend the block device and it's owning superblock/filesystem. Which in
> > turn is nothing but a freeze initiated from the block layer:
> > 
> > dm_suspend()
> > -> __dm_suspend()
> >    -> lock_fs()
> >       -> bdev_freeze()
> > 
> > So when we say luksSuspend we really mean block layer initiated freeze.
> > The overall goal or expectation of userspace is that after a luksSuspend
> > call all sensitive material has been evicted from relevant caches to
> > harden against various attacks. And luksSuspend does wipe the encryption
> > key and suspend the block device. However, the encryption key can still
> > be available clear-text in the page cache.
> 
> The wiping of secrets is completely orthogonal to the freezing of
> the device and filesystem - the freeze does not need to occur to
> allow the encryption keys and decrypted data to be purged. They
> should not be conflated; purging needs to be a completely separate
> operation that can be run regardless of device/fs freeze status.

Yes, I'm aware. I didn't mean to imply that these things are in any way
necessarily connected. Just that there are use-cases where they are. And
the encrypted home directory case is one. One froze the block device and
filesystem one would now also like to drop the page cache which has most
of the interesting data.

The fact that after a block layer initiated freeze - again mostly a
device mapper problem - one may or may not be able to successfully read
from the filesystem is annoying. Of course one can't write, that will
hang one immediately. But if one still has some data in the page cache
one can still dump the contents of that file. That's at least odd
behavior from a users POV even if for us it's cleary why that's the
case.

And a freeze does do a sync_filesystem() and a sync_blockdev() to flush
out any dirty data for that specific filesystem. So it would be fitting
to give users an api that allows them to also drop the page cache
contents.

For some use-cases like the Gnome use-case one wants to do a freeze and
drop everything that one can from the page cache for that specific
filesystem.

And drop_caches is a big hammer simply because there are workloads where
that isn't feasible. Even on a modern boring laption system one may have
lots of services. On a large scale system one may have thousands of
services and they may all uses separate images (And the border between
isolated services and containers is fuzzy at best.). And here invoking
drop_caches penalizes every service.

One may want to drop the contents of _some_ services but not all of
them. Especially during suspend where one cares about dropping the page
cache of the home directory that gets suspended - encrypted or
unencrypted.

Ignoring the security aspect itself. Just the fact that one froze the
block device and the owning filesystem one may want to go and drop the
page cache as well without impacting every other filesystem on the
system. Which may be thousands. One doesn't want to penalize them all.

Ignoring the specific use-case I know that David has been interested in
a way to drop the page cache for afs. So this is not just for the home
directory case. I mostly wanted to make it clear that there are users of
an interface like this; even if it were just best effort.

> 
> FWIW, focussing on purging the page cache omits the fact that
> having access to the directory structure is a problem - one can
> still retrieve other user information that is stored in metadata
> (e.g. xattrs) that isn't part of the page cache. Even the directory
> structure that is cached in dentries could reveal secrets someone
> wants to keep hidden (e.g code names for operations/products).

Yes, of course but that's fine. The most sensitive data and the biggest
chunks of data will be the contents of files. We don't necessarily need
to cater to the paranoid with this.

> 
> So if we want luksSuspend to actually protect user information when
> it runs, then it effectively needs to bring the filesystem right
> back to it's "just mounted" state where the only thing in memory is
> the root directory dentry and inode and nothing else.

Yes, which we know isn't feasible.

> 
> And, of course, this is largely impossible to do because anything
> with an open file on the filesystem will prevent this robust cache
> purge from occurring....
> 
> Which brings us back to "best effort" only, and at this point we
> already have drop-caches....
> 
> Mind you, I do wonder if drop caches is fast enough for this sort of
> use case. It is single threaded, and if the filesystem/system has
> millions of cached inodes it can take minutes to run. Unmount has
> the same problem - purging large dentry/inode caches takes a *lot*
> of CPU time and these operations are single threaded.
> 
> So it may not be practical in the luks context to purge caches e.g.
> suspending a laptop shouldn't take minutes. However laptops are
> getting to the hundreds of GB of RAM these days and so they can
> cache millions of inodes, so cache purge runtime is definitely a
> consideration here.

I'm really trying to look for a practical api that doesn't require users
to drop the caches for every mounted image on the system.

FYI, I've tried to get some users to reply here so they could speak to
the fact that they don't expect this to be an optimal solution but none
of them know how to reply to lore mboxes so I can just relay
information.

