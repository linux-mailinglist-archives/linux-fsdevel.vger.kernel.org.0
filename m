Return-Path: <linux-fsdevel+bounces-14025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245AC876B9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 21:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD91F21E60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164E5B5D6;
	Fri,  8 Mar 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qXO5oOqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0825B03A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928752; cv=none; b=ng5xMrv7/s1hJruJov2ELJeUOf7MvalkjjLG9PowQMUudncd61wUFoUiGQHUK2xUDH1M9TL5w6z6bE99he5wauNsQQ9FKK/BFWPlF9Z5g6N45ystfXjLfEYBiushkAoggg/+Txx+zs57oEy7RHgS1s8xtHbSGaiHwmeyMpVXZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928752; c=relaxed/simple;
	bh=556dOT2cRmRT53CXo4Ap57p5yA0li5b4PRDyS7IFRsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShunOgS2UR6+Ui5CkRovy2cSlMXs8ikKMI1uBRxtVlzDJE5PatYv3UrLpZhBLjrvM4ZhLl8tloeJKs5GGY+YzZUIms5swveXFtdastqc/kwyQXWpOdVZUVV3q3Dp+0iaRc7uyipEdOntBjTZeOBsnJ40hdKfw0QiiU/2BXIc1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qXO5oOqv; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Try4z0KmLznbD;
	Fri,  8 Mar 2024 21:12:19 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Try4x5pXvz3Y;
	Fri,  8 Mar 2024 21:12:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709928738;
	bh=556dOT2cRmRT53CXo4Ap57p5yA0li5b4PRDyS7IFRsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXO5oOqvBsCaRboRctAS7R8vK+HWwKC6Ub8u8YeMeUJ5v12As3CqXifR27p8k350Q
	 6vSVR7ZtnddLoYD/o5uhaaOnTViMIh7FSNGIqEPzGY8Q06wjeFS1WRBAG1ag7ysKdr
	 O6BjptWBpv+I/qvznTA+rNu8Y+qS7iDSP7hgT8PY=
Date: Fri, 8 Mar 2024 21:12:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <20240308.eeZ1uungeeSa@digikod.net>
References: <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
 <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <20240308.saiheoxai7eT@digikod.net>
 <CAHC9VhSjMLzfjm8re+3GN4PrAjO2qQW4Rf4o1wLchPDuqD-0Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSjMLzfjm8re+3GN4PrAjO2qQW4Rf4o1wLchPDuqD-0Pw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Mar 08, 2024 at 02:22:58PM -0500, Paul Moore wrote:
> On Fri, Mar 8, 2024 at 4:29 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> > > On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > > > On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
> > > >> On Thu, Mar 7, 2024 at 7:57 AM Günther Noack <gnoack@google.com> wrote:
> > > >> I need some more convincing as to why we need to introduce these new
> > > >> hooks, or even the vfs_masked_device_ioctl() classifier as originally
> > > >> proposed at the top of this thread.  I believe I understand why
> > > >> Landlock wants this, but I worry that we all might have different
> > > >> definitions of a "safe" ioctl list, and encoding a definition into the
> > > >> LSM hooks seems like a bad idea to me.
> > > >
> > > > I have no idea what a "safe" ioctl means here. Subsystems already
> > > > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > > > "safe" clearly means something different here.
> > >
> > > That was my problem with the first version as well, but I think
> > > drawing the line between "implemented in fs/ioctl.c" and
> > > "implemented in a random device driver fops->unlock_ioctl()"
> > > seems like a more helpful definition.
> > >
> > > This won't just protect from calling into drivers that are lacking
> > > a CAP_SYS_ADMIN check, but also from those that end up being
> > > harmful regardless of the ioctl command code passed into them
> > > because of stupid driver bugs.
> >
> > Indeed.
> >
> > "safe" is definitely not the right word, it is too broad, relative to
> > use cases and threat models.  There is no "safe" IOCTL.
> >
> > Let's replace "safe IOCTL" with "IOCTL always allowed in a Landlock
> > sandbox".
> 
> Which is a problem from a LSM perspective as we want to avoid hooks
> which are tightly bound to a single LSM or security model.  It's okay
> if a new hook only has a single LSM implementation, but the hook's
> definition should be such that it is reasonably generalized to support
> multiple LSM/models.

As any new hook, there is a first user.  Obviously this new hook would
not be restricted to Landlock, it is a generic approach.  I'm pretty
sure a few hooks are only used by one LSM though. ;)

> 
> > Our assumptions are (in the context of Landlock):
> >
> > 1. There are IOCTLs tied to file types (e.g. block device with
> >    major/minor) that can easily be identified from user space (e.g. with
> >    the path name and file's metadata).  /dev/* files make sense for user
> >    space and they scope to a specific use case (with relative
> >    privileges).  This category of IOCTLs is implemented in standalone
> >    device drivers (for most of them).
> >
> > 2. Most user space processes should not be denied access to IOCTLs that
> >    are managed by the VFS layer or the underlying filesystem
> >    implementations.  For instance, the do_vfs_ioctl()'s ones (e.g.
> >    FIOCLEX, FIONREAD) should always be allowed because they may be
> >    required to legitimately use files, and for performance and security
> >    reasons (e.g. fs-crypt, fsverity implemented at the filesystem layer).
> >    Moreover, these IOCTLs should already check the read/write permission
> >    (on the related FD), which is not the case for most block/char device
> >    IOCTL.
> >
> > 3. IOCTLs to pipes and sockets are out of scope.  They should always be
> >    allowed for now because they don't directly expose files' data but
> >    IPCs instead, and we are focusing on FS access rights for now.
> >
> > We want to add a new LANDLOCK_ACCESS_FS_IOCTL_DEV right that could match
> > on char/block device's specific IOCTLs, but it would not have any impact
> > on other IOCTLs which would then always be allowed (if the sandboxed
> > process is allowed to open the file).
> >
> > Because IOCTLs are implemented in layers and all IOCTLs commands live in
> > the same 32-bit namespace, we need a way to identify the layer
> > implemented by block and character devices.  The new LSM hook proposal
> > enables us to cleanly and efficiently identify the char/block device
> > IOCTL layer with an additional check on the file type.
> 
> I guess I should wait until there is an actual patch, but as of right
> now a VFS ioctl specific LSM hook looks far too limited to me and
> isn't something I can support at this point in time.  It's obviously
> limited to only a subset of the ioctls, meaning that in order to have
> comprehensive coverage we would either need to implement a full range
> of subsystem ioctl hooks (ugh), or just use the existing
> security_file_ioctl().

I think there is a misunderstanding.  The subset of IOCTL commands the
new hook will see would be 99% of them (i.e. all except those
implemented in fs/ioctl.c).  Being able to only handle this (big) subset
would empower LSMs to control IOCTL commands without collision (e.g. the
same command/value may have different meanings according to the
implementation/layer), which is not currently possible (without manual
tweaking).

This proposal is to add a new hook for the layer just beneath the VFS
catch-all IOCTL implementation.  This layer can then differentiate
between the underlying implementation according to the file properties.
There is no need for additional hooks for other layers/subsystems.

The existing security_file_ioctl() hook is useful to catch all IOCTL
commands, but it doesn't enable to identify the underlying target and
then the semantic of the command.  Furthermore, as Günther said, an
IOCTL call can already do kernel operations without looking at the
command, but we would then be able to identify that by looking at the
char/block device file for instance.

> I understand that this makes things a bit more
> complicated for Landlock's initial ioctl implementation, but
> considering my thoughts above and the fact that Landlock's ioctl
> protections are still evolving I'd rather not add a lot of extra hooks
> right now.

Without this hook, we'll need to rely on a list of allowed IOCTLs, which
will be out-of-sync eventually.  It would be a maintenance burden and an
hacky approach.

We're definitely open to new proposals, but until now this is the best
approach we found from a maintenance, performance, and security point of
view.

