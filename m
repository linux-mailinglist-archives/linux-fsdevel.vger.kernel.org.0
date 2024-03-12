Return-Path: <linux-fsdevel+bounces-14194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D5E879298
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 11:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CB1C2251B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED567867B;
	Tue, 12 Mar 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RPyBcgPu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45DC69D19
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241134; cv=none; b=cWl6oxqwkyJzTu2/0qiahWpeHWeVzQTifakuowMLvUrnHSAaoAeY1A1zq8B6den4nxzoUw/mWKNxF/wTcpDlV55sPMgXAY8sMQOcdg3DCzuOTOBC778t2c04hnddzHjknpr8nKrTK3CFzTxl8a4PHtHzsTGp/q0u7LyuZng57qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241134; c=relaxed/simple;
	bh=/XL+H5ypymBBxnsYRmxklN4e8R1zQNOb293Hoqh2vdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkxL1GW4Ucy+2fmzylYzW87Q+UeovejVhYEG1EFmMgCXiBGXh14XcwHyH1y4SaiYUwuVAfPU03ZqfiViJsCiE56k4ZXsovbB8idX42bDtjn1vL6CPcLPyEEXTeW1ucRL53N5PqxRcsutvBd5qWW76HzxvI4qkh2Y6YFWs4Tb9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RPyBcgPu; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tv9cL0YhtzN0T;
	Tue, 12 Mar 2024 11:58:42 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tv9cJ6T8YzMpnPj;
	Tue, 12 Mar 2024 11:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710241121;
	bh=/XL+H5ypymBBxnsYRmxklN4e8R1zQNOb293Hoqh2vdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPyBcgPuOlwtitUJATAlMsD0ZhHi2WeleQd1w3qOjQMcbx8OFLMbzcM96kiAZu+YO
	 xlSvFtByD16fuahayK7oKrCQ6miajynwV2rWfR/iUn0fcaB5sS6y+pgPwqAjdDzxaG
	 HV3TMbnLzOdkq6wx2EwGnJX8+EjbPqjeGfJa/Z3g=
Date: Tue, 12 Mar 2024 11:58:29 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dave Chinner <david@fromorbit.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <20240312.te1phaiTieth@digikod.net>
References: <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
 <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <ZervrVoHfZzAYZy4@google.com>
 <Ze5YUUUQqaZsPjql@dread.disaster.area>
 <Ze7IbSKzvCYRl2Ox@google.com>
 <Ze+BzMyBp1vRIDKv@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze+BzMyBp1vRIDKv@dread.disaster.area>
X-Infomaniak-Routing: alpha

On Tue, Mar 12, 2024 at 09:12:28AM +1100, Dave Chinner wrote:
> On Mon, Mar 11, 2024 at 10:01:33AM +0100, Günther Noack wrote:
> > On Mon, Mar 11, 2024 at 12:03:13PM +1100, Dave Chinner wrote:
> > > On Fri, Mar 08, 2024 at 12:03:01PM +0100, Günther Noack wrote:
> > > > On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> > > > > On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > > > > > I have no idea what a "safe" ioctl means here. Subsystems already
> > > > > > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > > > > > "safe" clearly means something different here.
> > > > > 
> > > > > That was my problem with the first version as well, but I think
> > > > > drawing the line between "implemented in fs/ioctl.c" and
> > > > > "implemented in a random device driver fops->unlock_ioctl()"
> > > > > seems like a more helpful definition.
> > > > 
> > > > Yes, sorry for the confusion - that is exactly what I meant to say with "safe".:
> > > > 
> > > > Those are the IOCTL commands implemented in fs/ioctl.c which do not go through
> > > > f_ops->unlocked_ioctl (or the compat equivalent).
> > > 
> > > Which means all the ioctls we wrequire for to manage filesystems are
> > > going to be considered "unsafe" and barred, yes?
> > > 
> > > That means you'll break basic commands like 'xfs_info' that tell you
> > > the configuration of the filesystem. It will prevent things like
> > > online growing and shrinking, online defrag, fstrim, online
> > > scrubbing and repair, etc will not worki anymore. It will break
> > > backup utilities like xfsdump, and break -all- the device management
> > > of btrfs and bcachefs filesystems.
> > > 
> > > Further, all the setup and management of -VFS functionality- like
> > > fsverity and fscrypt is actually done at the filesystem level (i.e
> > > through ->unlocked_ioctl, no do_vfs_ioctl()) so those are all going
> > > to get broken as well despite them being "vfs features".
> > > 
> > > Hence from a filesystem perspective, this is a fundamentally
> > > unworkable definition of "safe".
> > 
> > As discussed further up in this thread[1], we want to only apply the IOCTL
> > command filtering to block and character devices.  I think this should resolve
> > your concerns about file system specific IOCTLs?  This is implemented in patch
> > V10 going forward[2].
> 
> I think you misunderstand. I used filesystem ioctls as an obvious
> counter argument to this "VFS-only ioctls are safe" proposal to show
> that it fundamentally breaks core filesystem boot and management
> interfaces. Operations to prepare filesystems for mount may require
> block device ioctls to be run. i.e. block device ioctls are required
> core boot and management interfaces.
> 
> Disallowing ioctls on block devices will break udev rules that set
> up block devices on kernel device instantiation events. It will
> break partitioning tools that need to read/modify/rescan the
> partition table. This will prevent discard, block zeroing and
> *secure erase* operations. It may prevent libblkid from reporting
> optimal device IO parameters to filesystem utilities like mkfs. You
> won't be able to mark block devices as read only.  Management of
> zoned block devices will be impossible.
> 
> Then stuff like DM and MD devices (e.g. LVM, RAID, etc) simply won't
> appear on the system because they can't be scanned, configured,
> assembled, etc.
> 
> And so on.
> 
> The fundamental fact is that system critical block device ioctls are
> implemented by generic infrastructure below the VFS layer. They have
> their own generic ioctl layer - blkdev_ioctl() is equivalent of
> do_vfs_ioctl() for the block layer.  But if we cut off everything
> below ->unlocked_ioctl() at the VFS, then we simply can't run any
> of these generic block device ioctls.
> 
> As I said: this proposal is fundamentally unworkable without
> extensive white- and black-listing of individual ioctls in the
> security policies. That's not really a viable situation, because
> we're going to change code and hence likely silently break those
> security policy lists regularly....

Landlock is an optional sandboxing mechanism targeting unprivileged
users/processes (even if it can of course be used by privileged ones).
This means that there is no global security policy for the whole system
(unlike SELinux, AppArmor...).  System administrators that need to
manage a file system or any block devices would just not sandbox
themselves.  Moreover, most block devices should only be accessible to
the root user (which makes root the only one able to send IOCTL commands
to these block devices).  In a nutshell, processes using boot and
management interfaces are already privileged and they don't use
Landlock.  For instance, a landlocked process cannot do any mount
action, which is documented and it makes sense for the sandboxing use
case (to avoid sandbox bypass).

However, it would be interesting to know if unprivileged users can
request legitimate IOCTL commands on block devices (on a generic
distro), and if this is required for a common file system use (i.e.
excluding administration tasks).  I think all required IOCTL for common
file system use are available through the file system, not block devices,
but please correct me if I'm wrong.  What is nice with this
LANDLOCK_ACCESS_FS_IOCTL_DEV approach is that user space can identify
(with path and dev major/minor) on which device IOCTLs should be
allowed.  This is simple to understand and the information to identify
such devices is already well known.  We can also allow IOCTLs on a set
of devices, e.g. /dev/snd/.

The goal of this patch series is to enable applications to sandbox
themselves and avoid an attacker (exploiting a bug in this application)
to send arbitrary IOCTL commands to any devices available to the user
running this application.  For this sandboxing use case, I think it
wouldn't be useful to differentiate between blkdev_ioctl()'s commands
and device-specific commands because we want to either allow all IOCTL
on a block device or deny most of them (not those handled by
do_vfs_ioctl(), e.g. FIOCLEX, but that's a detail because of the file
access rights).  This is a trade off to ease sandboxing while being able
to limit access to unneeded features (which could potentially be used to
bypass the sandbox, e.g. TTY's IOCTLs).

