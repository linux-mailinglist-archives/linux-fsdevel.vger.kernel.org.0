Return-Path: <linux-fsdevel+bounces-14524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE8A87D39D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28251F21BEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F2117721;
	Fri, 15 Mar 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="i8a4zBJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344BE819
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527438; cv=none; b=LioNl7kZR1BIMNMaYnmKhe3rievLsaERXoQvnzWh0+iaRsezgJ/QTLYhboow/pwmAvQRKHS6YPtGhS7bNFvOSXBShbdbez3BFchNdBAK+mzKZ2nRBN4DVA6GxevxixxwSmgWnbdWpN6UQWfOJTs07xWOI4NQ6SpvMrQdCGBV/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527438; c=relaxed/simple;
	bh=EMn+IA3ZTMiXXUDxMwGgYaBOzv2jcV8R3pS2SUYvYbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjduL5waDZOKf6NeB38Bud1J+6PPIk6kwEuOug8xS59Vk4G/ouYr6mp2yXt1YS/ALYGQj2KlntkAmeNArdpgsXMtpAl6JVJXVx0tC2+VXfFC8TZVSPJZXjWIPx2XuHGV1wCIUTUy68ehacZEczcqQWve4nt5Lk6kfhgVrk0IoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=i8a4zBJO; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TxCV729qCzMpvmc;
	Fri, 15 Mar 2024 19:30:23 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TxCV6335mzMpnPk;
	Fri, 15 Mar 2024 19:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710527423;
	bh=EMn+IA3ZTMiXXUDxMwGgYaBOzv2jcV8R3pS2SUYvYbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8a4zBJOm6T+kOSMWurMfWQE71ejql/dUt66pXzg16ZwjAWXuqjCUaUSdQ4PVeKTl
	 zFJZWwhOpnAKzcnHyo4hMejXCXYHu+UCBOp+6ofmQh8cwpXPy3vvR3VZ1szsDYJgJx
	 KQV4f3MLYyvrGNpa3RL/CMH/q/03UifT7eyLkoZI=
Date: Fri, 15 Mar 2024 19:30:19 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v10 1/9] security: Create security_file_vfs_ioctl hook
Message-ID: <20240315.Aeth0ooquoh6@digikod.net>
References: <20240309075320.160128-1-gnoack@google.com>
 <20240309075320.160128-2-gnoack@google.com>
 <CAHC9VhRojXNSU9zi2BrP8z6JmOmT3DAqGNtinvvz=tL1XhVdyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRojXNSU9zi2BrP8z6JmOmT3DAqGNtinvvz=tL1XhVdyg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Mar 14, 2024 at 01:56:25PM -0400, Paul Moore wrote:
> On Sat, Mar 9, 2024 at 2:53 AM Günther Noack <gnoack@google.com> wrote:
> >
> > This LSM hook gets called just before the fs/ioctl.c logic delegates
> > the requested IOCTL command to the file-specific implementation as
> > implemented by f_op->unlocked_ioctl (or f_op->ioctl_compat).
> >
> > It is impractical for LSMs to make security guarantees about these
> > f_op operations without having intimate knowledge of how they are
> > implemented.
> >
> > Therefore, depending on the enabled Landlock policy, Landlock aims to
> > block the calls to filp->f_op->unlocked_ioctl(), but permit the calls
> > to the IOCTL commands which are already implemented in fs/ioctl.c.
> >
> > The current call graph is:
> >
> >   * ioctl syscall
> >     * security_file_ioctl() LSM hook
> >     * do_vfs_ioctl() - standard operations
> >       * file_ioctl() - standard file operations
> >     * vfs_ioctl() - delegate to file (if do_vfs_ioctl() is a no-op)
> >       * filp->f_op->unlocked_ioctl()
> >
> > Why not use the existing security_file_ioctl() hook?
> >
> > With the existing security_file_ioctl() hook, it is technically
> > feasible to prevent the call to filp->f_op->unlocked_ioctl(), but it
> > would be difficult to maintain: security_file_ioctl() gets called
> > further up the call stack, so an implementation of it would need to
> > predict whether the logic further below will decide to call
> > f_op->unlocked_ioctl().  That can only be done by mirroring the logic
> > in do_vfs_ioctl() to some extent, and keeping this in sync.
> 
> Once again, I don't see this as an impossible task, and I would think
> that you would want to inspect each new ioctl command/op added in
> do_vfs_ioctl() anyway to ensure it doesn't introduce an unwanted
> behavior from a Landlock sandbox perspective.

About the LANDLOCK_ACCESS_FS_IOCTL_DEV semantic, we only care about the
IOCTLs that are actually delivered to device drivers, so any new IOCTL
directly handled by fs/ioctl.c should be treated the same way for this
access right.

> Looking at the git
> log/blame, it also doesn't appear that new do_vfs_ioctl() ioctls are
> added very frequently, meaning that keeping Landlock sync'd with
> fs/ioctl.c shouldn't be a terrible task.

do_vfs_ioctl() is indeed not changed often, but this doesn't mean we
should not provide strong guarantees, avoid future security bugs, lower
the maintenance cost, and improve code readability.

> 
> I'm also not excited about the overlap between the existing
> security_file_ioctl() hook and the proposed security_file_vfs_ioctl()
> hook.  There are some cases where we have no choice and we have to
> tolerate the overlap, but this doesn't look like one of those cases to
> me.
> 
> I'm sorry, but I don't agree with this new hook.

OK, I sent a new RFC (in reply to your email) as an alternative
approach.  Instead of adding a new LSM hook, this patch adds the
vfs_get_ioctl_handler() helper and some code refactoring that should be
both interesting for the VFS subsystem and for Landlock.  I guess this
could be interesting for other security mechanisms as well (e.g. BPF
LSM).  What do you think?

Arnd, Christian, would this sound good to you?

