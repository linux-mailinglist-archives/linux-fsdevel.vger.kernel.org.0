Return-Path: <linux-fsdevel+bounces-48530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F9AB0A0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E7E173090
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEA269AFD;
	Fri,  9 May 2025 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBQh3ztp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570117588;
	Fri,  9 May 2025 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746770090; cv=none; b=fE3pqXrfIiR4blqhC3ZouU2pZTan9logk4KhzLRo5v3dAQ0XaKp+GpHsDnCcW1/jfAPiPhVcMyGEDGYoCK9DWrJfQZ8x82oJ7gUOTqAqOgU/UmCh8JwsSa4jiSBpzcpXxLP3gv+X5UNfb9U6+Mj6/NwalkDav4W7g80PTP7Auk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746770090; c=relaxed/simple;
	bh=1tj/ncb9nuGvIlquscrVt2LrxWxbvv0mdKWP0lXEE0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AexJ9OB8wniG7+uiJoOpHvOfnbI7aEinOmEKWVHQqSHTyo3aV9zVtR48BzwTnTzlIFHsRFcY9knACqhKnwm418juMqM4oKdyiIJkFQ5hOwznRlhCNCqQ+Km9p6Dldu5McPQGm2bMnfyYHtaGnUksvu6AHYwCuBzIMFGVYmZOUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBQh3ztp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE1CC4CEE4;
	Fri,  9 May 2025 05:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746770090;
	bh=1tj/ncb9nuGvIlquscrVt2LrxWxbvv0mdKWP0lXEE0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBQh3ztpEfzxV2/DToP7PN64qDZwEp5EhhPNSWN9Waen9lYd/D+0aQBDPgLgoiH3D
	 4k9+0fAVGO/Q3D/VxnOmuNpJZ5s2aa1wi+Tz6x5/EHGcxjljJvNUYBJGXnYvwJTnec
	 uPbZBOt7ia3qLSrtX50A5+69iv872R/n/BI28oESY/5voKZPsGm9NbesCDyICbsnhd
	 nq3zaex7ZjHaa+IBGSsPvxI3qKtIDBd0pnrzC/5t0Th33KjChCXuS+p1Zw2zjl3/Dn
	 1rr6ZF+NBCd7MeihPBJm/Pr07ua1V9i0wYSq4m4BtMvgbAM2cgwlppu9WbmDtZ/c5V
	 9TaYtTWMQsdKw==
Date: Fri, 9 May 2025 07:54:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, daan.j.demeyer@gmail.com, 
	davem@davemloft.net, david@readahead.eu, edumazet@google.com, horms@kernel.org, 
	jack@suse.cz, jannh@google.com, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Subject: Re: [PATCH v4 04/11] net: reserve prefix
Message-ID: <20250509-leinwand-leiht-f1031edf9c71@brauner>
References: <20250508-vorboten-herein-4ee71336e6f7@brauner>
 <20250508214850.62973-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508214850.62973-1-kuniyu@amazon.com>

On Thu, May 08, 2025 at 02:47:45PM -0700, Kuniyuki Iwashima wrote:
> From: Christian Brauner <brauner@kernel.org>
> Date: Thu, 8 May 2025 08:16:29 +0200
> > On Wed, May 07, 2025 at 03:45:52PM -0700, Kuniyuki Iwashima wrote:
> > > From: Christian Brauner <brauner@kernel.org>
> > > Date: Wed, 07 May 2025 18:13:37 +0200
> > > > Add the reserved "linuxafsk/" prefix for AF_UNIX sockets and require
> > > > CAP_NET_ADMIN in the owning user namespace of the network namespace to
> > > > bind it. This will be used in next patches to support the coredump
> > > > socket but is a generally useful concept.
> > > 
> > > I really think we shouldn't reserve address and it should be
> > > configurable by users via core_pattern as with the other
> > > coredump types.
> > > 
> > > AF_UNIX doesn't support SO_REUSEPORT, so once the socket is
> > > dying, user can't start the new coredump listener until it's
> > > fully cleaned up, which adds unnecessary drawback.
> > 
> > This really doesn't matter.
> > 
> > > The semantic should be same with other types, and the todo
> > > for the coredump service is prepare file (file, process, socket)
> > > that can receive data and set its name to core_pattern.
> > 
> > We need to perform a capability check during bind() for the host's
> > coredump socket. Otherwise if the coredump server crashes an
> > unprivileged attacker can simply bind the address and receive all
> > coredumps from suid binaries.
> 
> As I mentioned in the previous thread, this can be better
> handled by BPF LSM with more fine-grained rule.
> 
> 1. register a socket with its name to BPF map
> 2. check if the destination socket is registered at connect
> 
> Even when LSM is not availalbe, the cgroup BPF prog can make
> connect() fail if the destination name is not registered
> in the map.
> 
> > 
> > This is also a problem for legitimate coredump server updates. To change
> > the coredump address the coredump server must first setup a new socket
> > and then update core_pattern and then shutdown the old coredump socket.
> 
> So, for completeness, the server should set up a cgroup BPF
> prog to route the request for the old name to the new one.
> 
> Here, the bpf map above can be reused to check if the socket
> name is registered in the map or route to another socket in
> the map.
> 
> Then, the unprivileged issue below and the non-dumpable issue
> mentioned in the cover letter can also be resolved.
> 
> The server is expected to have CAP_SYS_ADMIN, so BPF should
> play a role.

This has been explained by multiple people over the course of this
thread already. It is simply not acceptable for basic kernel
functionality to be unsafe without the use of additional separate
subsystems. It is not ok to require bpf for a core kernel api to be
safely usable. It's irrelevant whether that's for security or cgroup
hooks. None of which we can require.

I won't even get this past Linus for that matter because he will rightly
NAK that hard and probably ask me whether I've paid any attention to
basic kernel development requirements in the last 10 years. Let alone
for coredumping which handles crashing suid binaries. I understand the
urge to outsurce this problem to userspace but that's not ok.

Coredumping is a core kernel service and all options have to be safely
usable by themselves. In fact, that goes for any kernel API and
especially VFS apis.

Using AF_UNIX sockets will be a major step forward in both simplicity
and security. We've compromised on every front so far. It's not too much
to ask for a basic permission check on a single well-known address
that's exposed as a kernel-level service.

