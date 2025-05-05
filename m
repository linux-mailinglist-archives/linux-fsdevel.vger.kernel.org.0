Return-Path: <linux-fsdevel+bounces-48104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBC2AA96A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8B23A39ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410725E838;
	Mon,  5 May 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRwqshts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC425CC5F;
	Mon,  5 May 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456971; cv=none; b=gLyJJD1lD+/2kc8XrlXg+CtTbNsPbcLo6vMdMqOsjn5d8F4cdb6w/khFVNBaHZ5eXJ0IWIHykNAVp/mx/eL/eMxArrFO+7obKwxsJPam9Mjv3RUYaWkUwyfEhp02cM2GdoWhmCfF8+6giE9wLBedZOxYbpcwzCu0ZD0tLfOhwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456971; c=relaxed/simple;
	bh=bJ1ZR3VtEee2Lfg/kc3hGzfdhOtsDj5T36f80c1czIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrhsoYBTc370mRN4wWCJckuwBftxFyGrd88pGmv1fkjV7cnY6u4ozVga9tRcFcpv+fkgxcc8zpjbdOFkWlKr0nTyt7xZxQDinkZ9eLNVV/ELGqPtlyDLpsKApyiljziP0doZGTdFYn56Xrgkj8b8q/0c/vld5Ps/PgU2e4vm93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRwqshts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85628C4CEE4;
	Mon,  5 May 2025 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746456970;
	bh=bJ1ZR3VtEee2Lfg/kc3hGzfdhOtsDj5T36f80c1czIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRwqshts24jqjgjY1AtD3qf06P0iH2vwFAk7rRhwRDq+kAF3AVGZOFjdShogWem1F
	 Ia2HiFQAmi8PwvQ5/boqKCnj+ixY751rrAWJ4VWGkIJgh9o3IHj/DXXCvmDa2fm4UE
	 HK7HsJrnuJf6WfgN+UfDAsl1AM8QSbmsLCxQWBrUSEdDluMUKWNRCtYFkjl29YOEvo
	 KOHk4vMShT3Hg5qXjxz7bf6lETU3hz1YyE/kctreCQGzfpNCywnlx52ClHTealAnSy
	 RGbkmcWx/e3j6o4lYfIbuvablzzwMC949ZlySeyIH2Qw5PwMSnlfg7muZNKzGYeW7Q
	 eCdSjNUSxKhUA==
Date: Mon, 5 May 2025 16:56:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH RFC v3 00/10] coredump: add coredump socket
Message-ID: <20250505-unberechenbar-kosenamen-da3fb108080e@brauner>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
 <20250505.aFia3choo1aw@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505.aFia3choo1aw@digikod.net>

On Mon, May 05, 2025 at 04:41:28PM +0200, Mickaël Salaün wrote:
> On Mon, May 05, 2025 at 01:13:38PM +0200, Christian Brauner wrote:
> > Coredumping currently supports two modes:
> > 
> > (1) Dumping directly into a file somewhere on the filesystem.
> > (2) Dumping into a pipe connected to a usermode helper process
> >     spawned as a child of the system_unbound_wq or kthreadd.
> > 
> > For simplicity I'm mostly ignoring (1). There's probably still some
> > users of (1) out there but processing coredumps in this way can be
> > considered adventurous especially in the face of set*id binaries.
> > 
> > The most common option should be (2) by now. It works by allowing
> > userspace to put a string into /proc/sys/kernel/core_pattern like:
> > 
> >         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> > 
> > The "|" at the beginning indicates to the kernel that a pipe must be
> > used. The path following the pipe indicator is a path to a binary that
> > will be spawned as a usermode helper process. Any additional parameters
> > pass information about the task that is generating the coredump to the
> > binary that processes the coredump.
> > 
> > In the example core_pattern shown above systemd-coredump is spawned as a
> > usermode helper. There's various conceptual consequences of this
> > (non-exhaustive list):
> > 
> > - systemd-coredump is spawned with file descriptor number 0 (stdin)
> >   connected to the read-end of the pipe. All other file descriptors are
> >   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
> >   already caused bugs because userspace assumed that this cannot happen
> >   (Whether or not this is a sane assumption is irrelevant.).
> > 
> > - systemd-coredump will be spawned as a child of system_unbound_wq. So
> >   it is not a child of any userspace process and specifically not a
> >   child of PID 1. It cannot be waited upon and is in a weird hybrid
> >   upcall which are difficult for userspace to control correctly.
> > 
> > - systemd-coredump is spawned with full kernel privileges. This
> >   necessitates all kinds of weird privilege dropping excercises in
> >   userspace to make this safe.
> > 
> > - A new usermode helper has to be spawned for each crashing process.
> > 
> > This series adds a new mode:
> > 
> > (3) Dumping into an abstract AF_UNIX socket.
> > 
> > Userspace can set /proc/sys/kernel/core_pattern to:
> > 
> >         @linuxafsk/coredump_socket
> > 
> > The "@" at the beginning indicates to the kernel that the abstract
> > AF_UNIX coredump socket will be used to process coredumps.
> > 
> > The coredump socket uses the fixed address "linuxafsk/coredump.socket"
> > for now.
> > 
> > The coredump socket is located in the initial network namespace. To bind
> > the coredump socket userspace must hold CAP_SYS_ADMIN in the initial
> > user namespace. Listening and reading can happen from whatever
> > unprivileged context is necessary to safely process coredumps.
> > 
> > When a task coredumps it opens a client socket in the initial network
> > namespace and connects to the coredump socket. For now only tasks that
> > are acctually coredumping are allowed to connect to the initial coredump
> > socket.
> 
> I think we should avoid using abstract UNIX sockets, especially for new

Abstract unix sockets are at the core of a modern Linux system. During
boot alone about 100 or so are created on a modern system when I counted
during testing. Sorry, but this is a no-show argument.

