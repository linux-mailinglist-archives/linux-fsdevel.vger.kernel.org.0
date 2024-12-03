Return-Path: <linux-fsdevel+bounces-36320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9BF9E1711
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 10:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D9228202A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5C1DE88B;
	Tue,  3 Dec 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWb9TYpB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144A3F8F7
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217566; cv=none; b=Bpr/np0KqdL4MHn8B4OZ0pB+nkCbYAua0HTpOaICl3GazpZA0g4fpH+MR2kfzDXZiYHFCBHa1vka3CzMn27iCQXT1b/qumPTEXWbz1f+avlGT2xBdS1gAaBDNL5T77sqtWP28gulnVcVmRuxblk/QOC9pKE9OtXSI1deUa2O2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217566; c=relaxed/simple;
	bh=6ztKTB1dimRvOBjGVoGqK4LstThFNJ3Il8t7/PhV4KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiErx6WwB1T/mQtayXPj/N38512bJHi3xmaegk3UUyxZedeF4GamXd5LSBt5k11lbLaEL14OkIAvfWwQ0Ky9bFIFAjrF3FxMmxwWE0lAtwQu3LQ7aR2sMG/Ykjp8DtFDEbXF8992R6aucri0Ik6B0R8v0tvNTaqvaeXoHMd2NZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWb9TYpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CD9C4CECF;
	Tue,  3 Dec 2024 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733217566;
	bh=6ztKTB1dimRvOBjGVoGqK4LstThFNJ3Il8t7/PhV4KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWb9TYpB3Hk76XpzSd/0tnCrG9ufOBQIOqEYldx9fF4+ei3fokd2xCO/5KGn7dkBc
	 iORRqnY28CmSeuyC7boflEDCbarfD+eWgfo7Emz2oY2REWA6nW9e2N4i8ydEyAEXAO
	 /GOE3sD5/iCnUzGqVOer/+V1NF8s1fkuluKhnc/9xEaDTAtmuF1v382kOquUOi5oVi
	 sFHSeelY85jb0IHkWqMSyZ4rygP25thfaw6BuBCl47Q4okgFBGspFxhDFTvokG7KWt
	 u1JoeYzKkxUnTdlWvJMyb52myChX5i46icdFc3kdwCMOrhnOoPSxE55xZg9gIkKjSv
	 AKNxoe7k4RkkQ==
Date: Tue, 3 Dec 2024 10:19:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jon DeVree <nuxi@vault24.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] 2038 warning is not printed with new mount API
Message-ID: <20241203-huldigen-abertausende-22a14681c06e@brauner>
References: <Z00wR_eFKZvxFJFW@feynman.vault24.org>
 <20241202-natur-davor-864eb423be9c@brauner>
 <Z06TTb3Jel0QEZry@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z06TTb3Jel0QEZry@dread.disaster.area>

On Tue, Dec 03, 2024 at 04:12:45PM +1100, Dave Chinner wrote:
> On Mon, Dec 02, 2024 at 12:55:13PM +0100, Christian Brauner wrote:
> > On Sun, Dec 01, 2024 at 10:57:59PM -0500, Jon DeVree wrote:
> > > When using the old mount API, the linux kernel displays a warning for
> > > filesystems that lack support for timestamps after 2038. This same
> > > warning does not display when using the new mount API
> > > (fsopen/fsconfig/fsmount)
> > > 
> > > util-linux 2.39 and higher use the new mount API when available which
> > > means the warning is effectively invisible for distributions with the
> > > newer util-linux.
> > > 
> > > I noticed this after upgrading a box from Debian Bookworm to Trixie, but
> > > its also reproducible with stock upstream kernels.
> > > 
> > > From a box running a vanilla 6.1 kernel:
> > > 
> > > With util-linux 2.38.1 (old mount API)
> > > [11526.615241] loop0: detected capacity change from 0 to 6291456
> > > [11526.618049] XFS (loop0): Mounting V5 Filesystem
> > > [11526.621376] XFS (loop0): Ending clean mount
> > > [11526.621600] xfs filesystem being mounted at /mnt supports timestamps until 2038 (0x7fffffff)
> > > [11530.275460] XFS (loop0): Unmounting Filesystem
> > > 
> > > With util-linux 2.39.4 (new mount API)
> > > [11544.063381] loop0: detected capacity change from 0 to 6291456
> > > [11544.066295] XFS (loop0): Mounting V5 Filesystem
> > > [11544.069596] XFS (loop0): Ending clean mount
> > > [11545.527687] XFS (loop0): Unmounting Filesystem
> > > 
> > > With util-linux 2.40.2 (new mount API)
> > > [11550.718647] loop0: detected capacity change from 0 to 6291456
> > > [11550.722105] XFS (loop0): Mounting V5 Filesystem
> > > [11550.725297] XFS (loop0): Ending clean mount
> > > [11552.009042] XFS (loop0): Unmounting Filesystem
> > > 
> > > All of them were mounting the same filesystem image that was created
> > > with: mkfs.xfs -m bigtime=0
> > 
> > With the new mount api the placement of the warning isn't clear:
> > 
> > - If we warn at superblock creation time aka
> >   fsconfig(FSCONFIG_CMD_CREATE) time but it's misleading because neither
> >   a mount nor a mountpoint do exist. Hence, the format of the warning
> >   has to be different.
> > 
> > - If we warn at fsmount() time a mount exists but the
> >   mountpoint isn't known yet as the mount is detached. This again means
> >   the format of the warning has to be different.
> > 
> > - If we warn at move_mount() we know the mount and the mountpoint. So
> >   the format of the warning could be kept.
> > 
> >   But there are considerable downsides:
> > 
> >   * The fs_context isn't available to move_mount()
> >     which means we cannot log this into the fscontext as well as into
> >     dmesg which is annoying because it's likely that userspace wants to
> >     see that message in the fscontext log as well.
> > 
> >   * Once fsmount() has been called it is possible for
> >     userspace to interact with the filesystem (open and create
> >     files etc.).
> > 
> >     If userspace holds on to to the detached mount, i.e., never calls
> >     move_mount(), the warning would never be seen.
> > 
> >   * We'd have to differentiate between adding the first mount for a
> >     given filesystems and bind-mounts.
> > 
> > IMHO, the best place to log a warning is either at fsmount() time or at
> > superblock creation time
> 
> It has to be done either during or after the ->fill_super() call
> where the filesystems read their superblocks from disk and set up
> the VFS superblock timestamp limits.
> 
> Some of use filesystem developers wanted this timestamp warning to
> be implemented in each filesystem ->fill_super method for this
> reason - on-disk format information/warnings should be located with
> the code that sets up the filesystem state from the on-disk
> information.
> 
> > but then the format of the warning will have to
> > be slightly, changed.
> 
> Yes please!
> 
> This was the other main objection to a generic VFS timestamp warning
> - inconsistent mount time log message formats.  Filesytsems have
> their own message formats with consistent identifiers, and that's
> really what we should be using here.

I don't mind moving this into individual fill_super() methods for the
new mount api.

