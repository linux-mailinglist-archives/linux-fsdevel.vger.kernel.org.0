Return-Path: <linux-fsdevel+bounces-48110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D6AA97B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B7A3BC245
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979BD25F78A;
	Mon,  5 May 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AId87KmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254F25DD16
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459876; cv=none; b=cGz+HDRZCRivJBNMHZ1FXCLLWK3G24GCTquismm23dbgsYFoGOqYWO3oe9yx3iyPBgwZlGYjkUrMRo+XGoIaFtrTP5rxiBLn6BvZ76G8FX3B44HbGljsUCwgUdt5FpQlP37tiABy1MKz5zLmXWXnu14tkV4UHHSU3HSj/X9fuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459876; c=relaxed/simple;
	bh=BsYMs8WnXsSN2AsX4JfQ2IaUBn2ookufJHLnCM/5lAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmrMvI5W24MKqqo1G0WrVfmVnO7qAcxvsanYiw5UEEy8MTB7SRCp0UeV0oh0VrhcrLelqGqYcdsT+GL4NDsY3LlA+hZsvYzakHT4WRTO1yms+n2vMs4JXZOmrE2dD+wiTDEv6mFWKYzrziPNMI8HcmiIz5ECS3c9VdfKplhR3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AId87KmO; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zrlzk5cZtzVv4;
	Mon,  5 May 2025 17:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746459506;
	bh=68OOBF5p1DncYHeXZUijCt379OyAlKkz3EBeF/6YpjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AId87KmOnan4eggIloma+UYO5IxpyYuiFVBZmwFB4HD5WvrGwY7lXHH0hZzZlkLah
	 3KBIIJ6iwlL0zLtrr4zfE/4cc8B3XP+6Da/hyXk/j1l/eOzUqojSYfT3+GxuJEL/Qh
	 19V4BhcmM9xUfB0QfAr4VMKyZtySYthU7MWgakp8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zrlzh4wPJzgm4;
	Mon,  5 May 2025 17:38:24 +0200 (CEST)
Date: Mon, 5 May 2025 17:38:23 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
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
Message-ID: <20250505.oceziek1aiHu@digikod.net>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
 <20250505.aFia3choo1aw@digikod.net>
 <20250505-unberechenbar-kosenamen-da3fb108080e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505-unberechenbar-kosenamen-da3fb108080e@brauner>
X-Infomaniak-Routing: alpha

On Mon, May 05, 2025 at 04:56:04PM +0200, Christian Brauner wrote:
> On Mon, May 05, 2025 at 04:41:28PM +0200, Mickaël Salaün wrote:
> > On Mon, May 05, 2025 at 01:13:38PM +0200, Christian Brauner wrote:
> > > Coredumping currently supports two modes:
> > > 
> > > (1) Dumping directly into a file somewhere on the filesystem.
> > > (2) Dumping into a pipe connected to a usermode helper process
> > >     spawned as a child of the system_unbound_wq or kthreadd.
> > > 
> > > For simplicity I'm mostly ignoring (1). There's probably still some
> > > users of (1) out there but processing coredumps in this way can be
> > > considered adventurous especially in the face of set*id binaries.
> > > 
> > > The most common option should be (2) by now. It works by allowing
> > > userspace to put a string into /proc/sys/kernel/core_pattern like:
> > > 
> > >         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> > > 
> > > The "|" at the beginning indicates to the kernel that a pipe must be
> > > used. The path following the pipe indicator is a path to a binary that
> > > will be spawned as a usermode helper process. Any additional parameters
> > > pass information about the task that is generating the coredump to the
> > > binary that processes the coredump.
> > > 
> > > In the example core_pattern shown above systemd-coredump is spawned as a
> > > usermode helper. There's various conceptual consequences of this
> > > (non-exhaustive list):
> > > 
> > > - systemd-coredump is spawned with file descriptor number 0 (stdin)
> > >   connected to the read-end of the pipe. All other file descriptors are
> > >   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
> > >   already caused bugs because userspace assumed that this cannot happen
> > >   (Whether or not this is a sane assumption is irrelevant.).
> > > 
> > > - systemd-coredump will be spawned as a child of system_unbound_wq. So
> > >   it is not a child of any userspace process and specifically not a
> > >   child of PID 1. It cannot be waited upon and is in a weird hybrid
> > >   upcall which are difficult for userspace to control correctly.
> > > 
> > > - systemd-coredump is spawned with full kernel privileges. This
> > >   necessitates all kinds of weird privilege dropping excercises in
> > >   userspace to make this safe.
> > > 
> > > - A new usermode helper has to be spawned for each crashing process.
> > > 
> > > This series adds a new mode:
> > > 
> > > (3) Dumping into an abstract AF_UNIX socket.
> > > 
> > > Userspace can set /proc/sys/kernel/core_pattern to:
> > > 
> > >         @linuxafsk/coredump_socket
> > > 
> > > The "@" at the beginning indicates to the kernel that the abstract
> > > AF_UNIX coredump socket will be used to process coredumps.
> > > 
> > > The coredump socket uses the fixed address "linuxafsk/coredump.socket"
> > > for now.
> > > 
> > > The coredump socket is located in the initial network namespace. To bind
> > > the coredump socket userspace must hold CAP_SYS_ADMIN in the initial
> > > user namespace. Listening and reading can happen from whatever
> > > unprivileged context is necessary to safely process coredumps.
> > > 
> > > When a task coredumps it opens a client socket in the initial network
> > > namespace and connects to the coredump socket. For now only tasks that
> > > are acctually coredumping are allowed to connect to the initial coredump
> > > socket.
> > 
> > I think we should avoid using abstract UNIX sockets, especially for new
> 
> Abstract unix sockets are at the core of a modern Linux system. During
> boot alone about 100 or so are created on a modern system when I counted
> during testing. Sorry, but this is a no-show argument.

These kind of socket being used does not mean they should be used for
new interfaces. :)

AFAIK, these socket types are currently only used for IPC, not between a
kernel interface and user space.  This patch series changes this
assumption.

Security policies already in place can block abstract connections, and
it might not be possible to differenciate between a kernel or user space
peer with the current configuration.  Please Cc the LSM mailing list for
such new interfaces.

You cut and ignored most of my reply, which explained my reasoning and
proposed an alternative:
> > interfaces, because it is hard to properly control such access.  Can we
> > create new dedicated AF_UNIX protocols instead?  One could be used by a
> > privileged process in the initial namespace to create a socket to
> > collect coredumps, and the other could be dedicatde to coredumped
> > proccesses.  Such (coredump collector) file descriptor or new (proxy)
> > socketpair ones could be passed to containers.

Only one new "protocol" would be required though (because the client
side is created by the kernel).  That would be a backward compatible
change, and such socket type could easily be identified by other part of
the kernel, including access control mechanisms.

