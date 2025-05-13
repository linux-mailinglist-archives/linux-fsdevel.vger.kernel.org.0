Return-Path: <linux-fsdevel+bounces-48818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B7AB4E99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870F64A0B14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96363211499;
	Tue, 13 May 2025 08:56:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAE1F0E37;
	Tue, 13 May 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126577; cv=none; b=fRKpI9SiHvUwFVHunrRLXM6RrkkV5ig9wvu0vnwf5dzlj8RtJot0KpUZ9wF8XYk3o7uD+MQkIo8RmkS9yQOFqVClg3MrHPC0zzDr4/b7v5Wqp4sb9HV3OWgqz4IcpVoys0ebt5x1A5FSR+no6ABsR4onNl0dL0W0o9k1mJ8e8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126577; c=relaxed/simple;
	bh=zZTpu2x0DINzlXYtgvXJEmz5tKs30LbnIJmPA4gFFm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVfx5hUh0047IMaAo3wA9ph17QDDYBPlEPGXwedv1guzt/inU2cYdkjLJUk7BrGtVVBOCiSjVS/Uh2/gGr0+G+cecZoPKD/Dz9zvnp33Fd1gcXtsPxPVqzObwyyjTOz07/BBYK4jSBjLf37gPMUpCyuPm3GC2VFsi2Ev5tEtzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id EE5F7E803E2;
	Tue, 13 May 2025 10:56:04 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 22F8F16005E; Tue, 13 May 2025 10:56:03 +0200 (CEST)
Date: Tue, 13 May 2025 10:56:03 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bluca@debian.org, alexander@mihalicyn.com, brauner@kernel.org,
	daan.j.demeyer@gmail.com, daniel@iogearbox.net, davem@davemloft.net,
	david@readahead.eu, edumazet@google.com, horms@kernel.org,
	jack@suse.cz, jannh@google.com, kuba@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, me@yhndnzj.com,
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com,
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Subject: Re: [PATCH v6 4/9] coredump: add coredump socket
Message-ID: <aCMJI-2goig2VBDX@gardel-login>
References: <CAMw=ZnRC7Okmew=rrEocFuFn8hhrcergHciPjxFPuG4c6qH_Bw@mail.gmail.com>
 <20250513021626.86287-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513021626.86287-1-kuniyu@amazon.com>

On Mo, 12.05.25 19:14, Kuniyuki Iwashima (kuniyu@amazon.com) wrote:

> > > Note this version does not use prefix.  Now it requires users to
> > > just pass the socket cookie via core_pattern so that the kernel
> > > can verify the peer.
> >
> > Exactly - this means the pattern cannot be static in a sysctl.d early
> > on boot anymore, and has to be set dynamically by <something>.
>
> You missed the socket has to be created dynamically by <something>.

systemd implements socket activation: the generic code in PID 1 can
bind a socket, and then generically forks off a process (or instances
of processes for connection-based sockets) once traffic is seen on
that socket. On a typical, current systemd system, PID 1 does this for
~40 sockets by default. The code to bind AF_UNIX or AF_INET/AF_INET6
sockets is entirely generic.

Currently, in the existing systemd codebase coredumping is implemented
via socket activation: the core_pattern handler binary quickly hands
off the coredump fds to an AF_UNIX socket bound that way, and the
service behind that does the heavy lifting. Our hope is that with
Christian's work we can make the kernel deliver the coredumps directly
to the socket PID1 generically binds, getting rid of one middle man.

By requiring userspace to echo the SO_COOKIE value into the
core_pattern sysctl in a special formatting, you define a bespoke
protocol: it's not just enough to bind a socket (for which the generic
code in PID1 is good enough), and to write a fixed
string into a sysctl (for which the generic code in the current
/etc/sysctl.d/ manager, i.e. systemd-sysctl, works fine). But you
suddenly are asking from userspace, that some specific tool runs at
early boot, extracts the socket cookie from PID1 somehow, and writes
that into sysctl. We'd have to come up with a new tool for that, we
can no longer use generic tools. And that's the part that Luca doesn't
like.

To a large degree I agree with Luca about this. I would much prefer
Christian's earlier proposal (i.e. to simply define some prefix of
AF_UNIX abstract namespace addresses as requiring privs to bind),
because that would enable us to do generic handling in userspace: the
existing socket binding logic in PID 1, and the existing sysctl.d
handling in the systemd suite would be good enough to set up
everything for the coredump handling.

That said, I'd take what we can get. If enforcing privs on some
abstract namespace socket address prefix is not acceptable, then we
can probably make the SO_COOKIE proposal work (Luca: we'd just hook
some small tool into ExecStartPost= of the .socket unit, and make PID1
pass the cookie in some env var or so to it; the tool would then just
echo that env var into the sysctl with the fixed prefix). In my eyes,
it's not ideal though: it would mean the sysctl data on every instance
of the system system image would necessarily deviate (because the
socket cookie is going to be different), which mgmt tools won't like
(as you cannot compare sysctl state anymore), and we'd have a weak
conflict of ownership: right now most sysctl settings are managed by
/etc/sysctl.d/, but the core_pattern suddenly wouldn't be
anymore. This will create conflicts because suddenly two components
write to the thing, and will start fighting.

Hence: I'd *much* prefer Christian's original approach as it does not
have these issues. But I'll take what I can get, we can make the
cookie thing work, but it's much uglier.

I am not sure I understand why enforcing privs on some abstract
namespace socke address prefix is such an unacceptable idea though.

Lennart

--
Lennart Poettering, Berlin

