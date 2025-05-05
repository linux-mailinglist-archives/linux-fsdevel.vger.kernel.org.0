Return-Path: <linux-fsdevel+bounces-48111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0EAA97DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A473A7121
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928A12609E1;
	Mon,  5 May 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nUWm3bhJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FCA259CA4
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460176; cv=none; b=Z5XagMyTYmXpwLmELMwdv6PoEkqTCiud2C5oX6ArGanKQUsTJVerEh79hxXBlh3+wmSQ6SeVQoxf8oMkvW1bUcAUvO0PoyVJ+gPf41sZ4+6p1Go3DFHv2Q308U/M5sAbi34CEdnXhkhwF/N0vaeoJB5INwpiCgagm8rdCUPEJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460176; c=relaxed/simple;
	bh=HfDy/HkyH9OE4BdyiLFSHkuBVpYPTVkooXLx5f3rZOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avbBko9FGWOuPHE0k0kVd89xH6lco2qPSfdkPFww3L5URWwu3Pd/opGDuj91eEEwyOhqvfNX3ix+C6fiFIiO1H6Z/uRg36nl6Ym6rIAJmWfZbXI2R6zUskpwCohueHgVG9m86t+UGLqkgVpyEIUtKtFgZsl76vuNJztb+8WUfTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nUWm3bhJ; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zrm150CSJzYMl;
	Mon,  5 May 2025 17:39:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746459576;
	bh=2rr0NxT3YygR9iTO8oBRTuCPuvHO/u8bPQjZ4fJ4Dmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUWm3bhJWq419tUFjizOeRUyHfqL1Ps0Bp0obcoIHzLGMUEs7xv+vVf6XmVNsmKvV
	 wH9r8SMThoIJnMs9qG2cF5fm99NtOCWlGhihJTREL47QhIulH762DJBS1raj+bSvfd
	 1Wvsw7/AXtuQSbncvRxa75Y+GzPBAPZ9bWztxg5M=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zrm134TtlzTc8;
	Mon,  5 May 2025 17:39:35 +0200 (CEST)
Date: Mon, 5 May 2025 17:39:34 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH RFC v3 00/10] coredump: add coredump socket
Message-ID: <20250505.ej2ephiNg7Ve@digikod.net>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
 <20250505.aFia3choo1aw@digikod.net>
 <CAG48ez0Ti8y5GzZFhdf5cmZWH1XMmz0Q_3y8RCn6ca8UL-jrcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0Ti8y5GzZFhdf5cmZWH1XMmz0Q_3y8RCn6ca8UL-jrcA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, May 05, 2025 at 04:59:41PM +0200, Jann Horn wrote:
> On Mon, May 5, 2025 at 4:41 PM Mickaël Salaün <mic@digikod.net> wrote:
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
> > interfaces, because it is hard to properly control such access.  Can we
> > create new dedicated AF_UNIX protocols instead?  One could be used by a
> > privileged process in the initial namespace to create a socket to
> > collect coredumps, and the other could be dedicatde to coredumped
> > proccesses.  Such (coredump collector) file descriptor or new (proxy)
> > socketpair ones could be passed to containers.
> 
> I would agree with you if we were talking about designing a pure
> userspace thing; but I think the limits that Christian added on bind()
> and connect() to these special abstract names in this series
> effectively make it behave as if they were dedicated AF_UNIX
> protocols, and prevent things like random unprivileged userspace
> processes bind()ing to them.

OK, so why not create a proper protocol?  That should also simplify the
interface.

