Return-Path: <linux-fsdevel+bounces-47945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C5EAA7A2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 21:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5B84C704A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 19:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B41F1534;
	Fri,  2 May 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/0JM4KW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8281A23A1;
	Fri,  2 May 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213908; cv=none; b=jI8XFFBTqPrbYWT3BN4Ke0RSeFrxYg0+JMRJUUFJbbH2rVrZJSMQql2pRzX0ranJs5kr9fEDr25MBK+XJ0OONnfZnMIheTLRCgAPU7uQbAl3WC4/OgegEooS0EFGxCEOHqS6KRIupYPtFBuOSDtacYPuaw2JSfZM/9WM01uGQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213908; c=relaxed/simple;
	bh=ve9eggb4nRrM8nLWllaJrlqck4/jFIlNS4vpcSps6XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2fqRKQeUF8xrs9wTT/ZzsbTcf4KDK0ZQhWll/P/+WtqnaNSAOxcK+FBt5FRf+vjouImAbgu59yrCFCDlmuCrBTaEkB2s82dAaH1e/X67ThMmEcSxJmszKyNVge8NwQv2N9o/xMVDm4t+wgjGx7k+jcrKMR0oB23fP4Ckc0cF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/0JM4KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2AAC4CEE4;
	Fri,  2 May 2025 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746213908;
	bh=ve9eggb4nRrM8nLWllaJrlqck4/jFIlNS4vpcSps6XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/0JM4KWDADG+6lbJpWS8x9vRk5GLMU9gSL6/RsN0z6NBYYStKNPonPKij+fbGyyD
	 8LKetfyuyhj+VxhqotJceHjL7R+hPbxG1UdvnLc5kSEiU8oeFmCZTGqDt4Db9TRCsw
	 /L9EcoF6UinviO+YQm6JulnUw/wdAYBh8/AqMbwYftph+9C4tS68Cji/nG2S3y1vuw
	 YzyrmgulLEIkvTEGN8CytnlRTF57fNYjKNBqJ9uL0zsokDUqpfYLc7Wh9gukAzQrgg
	 Fyk0YrW/QzjeTMLEsptXVPVDTYPekb5luAPRXk7pRPRTliXebNkWsazEoJkWCMAhqM
	 Hp+cPMWgbMTtQ==
Date: Fri, 2 May 2025 21:25:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/6] coredump: support AF_UNIX sockets
Message-ID: <20250502-folglich-dinge-8fa9707430ab@brauner>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
 <CAG48ez3oefetsGTOxLf50d+PGcthj3oJCiMbxtNvkDkRZ-jwEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3oefetsGTOxLf50d+PGcthj3oJCiMbxtNvkDkRZ-jwEg@mail.gmail.com>

On Fri, May 02, 2025 at 04:04:28PM +0200, Jann Horn wrote:
> On Fri, May 2, 2025 at 2:42 PM Christian Brauner <brauner@kernel.org> wrote:
> > I need some help with the following questions:
> >
> > (i) The core_pipe_limit setting is of vital importance to userspace
> >     because it allows it to a) limit the number of concurrent coredumps
> >     and b) causes the kernel to wait until userspace closes the pipe and
> >     thus prevents the process from being reaped, allowing userspace to
> >     parse information out of /proc/<pid>/.
> >
> >     Pipes already support this. I need to know from the networking
> >     people (or Oleg :)) how to wait for the userspace side to shutdown
> >     the socket/terminate the connection.
> >
> >     I don't want to just read() because then userspace can send us
> >     SCM_RIGHTS messages and it's really ugly anyway.
> >
> > (ii) The dumpability setting is of importance for userspace in order to
> >      know how a given binary is dumped: as regular user or as root user.
> >      This helps guard against exploits abusing set*id binaries. The
> >      setting needs to be the same as used at the time of the coredump.
> >
> >      I'm exposing this as part of PIDFD_GET_INFO. I would like some
> >      input whether it's fine to simply expose the dumpability this way.
> >      I'm pretty sure it is. But it'd be good to have @Jann give his
> >      thoughts here.
> 
> My only concern here is that if we expect the userspace daemon to look
> at the dumpability field and treat nondumpable tasks as "this may
> contain secret data and resources owned by various UIDs mixed
> together, only root should see the dump", we should have at least very
> clear documentation around this.
> 
> [...]
> > Userspace can get a stable handle on the task generating the coredump by
> > using the SO_PEERPIDFD socket option. SO_PEERPIDFD uses the thread-group
> > leader pid stashed during connect(). Even if the task generating the
> 
> Unrelated to this series: Huh, I think I haven't seen SO_PEERPIDFD
> before. I guess one interesting consequence of that feature is that if

It's very heavily used by dbus-broker, polkit and systemd to safely
authenticate clients instead of by PIDs. (Fyi, it's even supported for
bluetooth sockets so they could benefit from this as well I'm sure.)

> you get a unix domain socket whose peer is in another PID namespace,
> you can call pidfd_getfd() on that peer, which wouldn't normally be
> possible? Though of course it'll still be subject to the normal ptrace
> checks.

I think that was already possible because you could send pidfds via
SCM_RIGHTS. That's a lot more cooperative than SO_PEERPIDFD of course
but still.

But if that's an issue we could of course enforce that pidfd_getfd() may
only work if the target is within your pidns hierarchy just as we do for
the PIDFD_GET_INFO ioctl() already. But I'm not sure it's an issue.

