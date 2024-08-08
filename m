Return-Path: <linux-fsdevel+bounces-25424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D294C03D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578382841F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C4189B95;
	Thu,  8 Aug 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmWM/3j2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DE4A33
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128703; cv=none; b=fNHCefsG+5GWApR2DzVeAC73r9ppfbiDOl9cuAUqH1zb99MJw58emCYISARpX7QYu81hg1dIzPGbQ1NCBCAK6VV9EjCX6qcxKyJlqctRXoFOPi2Ac5gpi+9HsBI3YsWQq0wTSKi65sQSVsN9lA7auxJqYTUOJt1fDMcBpA0HXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128703; c=relaxed/simple;
	bh=QJJE2Qd5/2zVnrK1/pNiytzDCOKqiykTGMrCPXAlPBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYyv81csxfgyusyTGWwmtfP9z/rG6gCz9LhCBn8R0Lk/I2jalpEeMolIvTBAyyCmtPWDh2sIvKhHrph6GyWCJ9/w7tTyf1A3/MxJ9i0NHqzEk9UX7GdR0MRqdUQsRZVB4QiAt4iq5uCxrIEbyj2aZY9Lg5x7hBycvAmIOwUb+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmWM/3j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA76C32782;
	Thu,  8 Aug 2024 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723128702;
	bh=QJJE2Qd5/2zVnrK1/pNiytzDCOKqiykTGMrCPXAlPBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmWM/3j2Yq5n50jELAlIfIFNY2tSqHgtbtpMKu6u3KVjKmzl8WtsKvmUbL2cpk+FI
	 O6MQay5yp3GwbfhMM2qrYkHU4zBwIW+MHSsi3q9gkorlC6x8GsJn1ua1pj0qV0msCz
	 3AZEAAQhyzjhe5y9OCRb6Jqhn0bUFcw9jl47L0Xko9aXkO8SzIJ0uIK3tpy+cyYAt6
	 vmYznVLRZKysVgEhgeFxwEjCOpp9NVn2Z5IIsml0mRpI0wk6QNQX2hewChsnqW9T9S
	 bDD+zuFSaBNBFfUZ+4tzkecnYx6dmSjQxgaUBBg2Gjoor4rWB/fkZZR1ocHph9k7qf
	 Zt9dgTzE4h14Q==
Date: Thu, 8 Aug 2024 07:51:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH RFC 0/13] fs: generic filesystem shutdown handling
Message-ID: <20240808145141.GC6043@frogsfrogsfrogs>
References: <20240807180706.30713-1-jack@suse.cz>
 <ZrQA2/fkHdSReAcv@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQA2/fkHdSReAcv@dread.disaster.area>

On Thu, Aug 08, 2024 at 09:18:51AM +1000, Dave Chinner wrote:
> On Wed, Aug 07, 2024 at 08:29:45PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > this patch series implements generic handling of filesystem shutdown. The idea
> > is very simple: Have a superblock flag, which when set, will make VFS refuse
> > modifications to the filesystem. The patch series consists of several parts.
> > Patches 1-6 cleanup handling of SB_I_ flags which is currently messy (different
> > flags seem to have different locks protecting them although they are modified
> > by plain stores). Patches 7-12 gradually convert code to be able to handle
> > errors from sb_start_write() / sb_start_pagefault(). Patch 13 then shows how
> > filesystems can use this generic flag. Additionally, we could remove some
> > shutdown checks from within ext4 code and rely on checks in VFS but I didn't
> > want to complicate the series with ext4 specific things.
> 
> Overall this looks good. Two things that I noticed that we should
> nail down before anything else:
> 
> 1. The original definition of a 'shutdown filesystem' (i.e. from the
> XFS origins) is that a shutdown filesystem must *never* do -physical
> IO- after the shutdown is initiated. This is a protection mechanism
> for the underlying storage to prevent potential propagation of
> problems in the storage media once a serious issue has been
> detected. (e.g. suspect physical media can be made worse by
> continually trying to read it.) It also allows the block device to
> go away and we won't try to access issue new IO to it once the
> ->shutdown call has been complete.
> 
> IOWs, XFS implements a "no new IO after shutdown" architecture, and
> this is also largely what ext4 implements as well.

I don't think it quite does -- for EXT4_GOING_FLAGS_DEFAULT, it sets the
shutdown flag, but it doesn't actually abort the journal.  I think
that's an implementation bug since XFS /does/ shut down the log.

But looking at XFS_FSOP_GOING_FLAGS_DEFAULT, I also notice that if the
bdev_freeze fails, it returns 0 and the fs isn't shut down.  ext4, otoh,
actually does pass bdev_freeze's errno along.  I think ext4's behavior
is the correct one, right?

> However, this isn't what this generic shutdown infrastructure
> implements. It only prevents new user modifications from being
> started - it is effectively a "instant RO" mechanism rather than an
> "instant no more IO" architecture.

I thought pagefaults are still allowed on a shutdown xfs?  Curiously I
don't see a prohibition on write faults, but iirc we still allowed read
faults so that a shutdown on the rootfs doesn't immediately crash the
whole machine?

> Hence we have an impedence mismatch between existing shutdown
> implementations that currently return -EIO on shutdown for all
> operations (both read and write) and this generic implementation
> which returns -EROFS only for write operations.
> 
> Hence the proposed generic shutdown model doesn't really solve the
> inconsistent shutdown behaviour problem across filesystems - it just
> adds a new inconsistency between existing filesystem shutdown
> implementations and the generic infrastructure.
> 
> 2. On shutdown, this patchset returns -EROFS.
> 
> As per #1, returning -EROFS on shutdown will be a significant change
> of behaviour for some filesystems as they currently return -EIO when
> the filesystem is shut down.
> 
> I don't think -EROFS is right, because existing shutdown behaviour
> also impacts read-only operations and will return -EIO for them,
> too.
> 
> I think the error returned by a shutdown filesystem should always be
> consistent and that really means -EIO needs to be returned rather
> than -EROFS.
> 
> However, given this is new generic infrastructure, we can define a
> new error like -ESHUTDOWN (to reuse an existing errno) or even a
> new errno like -EFSSHUTDOWN for this, document it man pages and then
> convert all the existing filesystem shutdown checks to return this
> error instead of -EIO...

Agree.

> > Also, as Dave suggested, we can lift *_IOC_{SHUTDOWN|GOINGDOWN} ioctl handling
> > to VFS (currently in 5 filesystems) and just call new ->shutdown op for
> > the filesystem abort handling itself. But that is kind of independent thing
> > and this series is long enough as is.
> 
> Agreed - that can be done separately once we've sorted out the
> little details of what a shutdown filesystem actually means and how
> that gets reported consistently to userspace...

I would define it as:

No more writes to the filesystem or its underlying storage; file IO
and stat* calls return ESHUTDOWN; read faults still allowed.

I like the idea of hoisting this to the vfs and defining how one figures
out if the fs is shut down; thank you for working on this, Jan.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

