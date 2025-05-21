Return-Path: <linux-fsdevel+bounces-49575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFFABF282
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 13:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FA87A4E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963526280A;
	Wed, 21 May 2025 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMySf8Ho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB521D585;
	Wed, 21 May 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825987; cv=none; b=XsEqLm9XEZp/HExJv+C4sqyJ2Vm3rUBKHRS5SZ7yqJ4voDU9TVulnp7DcbruG1OKRayg/iyQLMiS5GOc7eNGttx7ek8QhPTNEa45UaW8fxm65scsl3d0dFor01mFAEDiUnrC0ev0imqtDFAgjzD51AA8lCjuHvChgIkacEWI234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825987; c=relaxed/simple;
	bh=KMwk5bRKMU/LebBXEB9eWTnbBr+EpsbBuq9K0VaAGrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhSAYizkA4j9ujFuz3arsAPQG/pmU5PEvJKjroIIYMbQBx1nWPhk5avvWBommd4pBjl5ZtZCyw0bw4vE1IjiUz7dq+zUX2PMJTztMgNSsib0eNf/sgTPNiJurHBZt99ujFbPEZvVmrLo3LOno1SSzuBBO2P404esM+0GB6QsA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMySf8Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDAAC4CEEA;
	Wed, 21 May 2025 11:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747825985;
	bh=KMwk5bRKMU/LebBXEB9eWTnbBr+EpsbBuq9K0VaAGrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMySf8HosZyaikPVyIScMp+hB3GqOkFWvUhUNKNKszxfbdGteSbO/Did8aatavUP/
	 IVpBECjdkejEW911PVNXLhTcN6/ZZ72r1s4qEnDO9YKo+tJta8kNRqZciZyL/5vV+2
	 ofuSl2tloNUKku7oWkrkFEPgGP22W1lrK+xhozxCOC2b1njBTke9/u9S4/pxfvYBYA
	 SVV/8v73C3z7NUcy90QNLvNCT49BRRtjpFjHEh4AHuVuLQjA+I97kwL9WZprWPpMlM
	 YXsa1+T7S7ISGFCFEBwFxwHJ8VaaJDdMuxltl60vtx+rnLAaYHamn4wkpoX6oPJtFp
	 RYv0C3ly7qyhQ==
Date: Wed, 21 May 2025 13:12:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v8 0/9] coredump: add coredump socket
Message-ID: <20250521-urenkel-panne-b19f93234e6f@brauner>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
 <20250520122838.29131f04@hermes.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520122838.29131f04@hermes.local>

On Tue, May 20, 2025 at 12:28:38PM -0700, Stephen Hemminger wrote:
> On Fri, 16 May 2025 13:25:27 +0200
> Christian Brauner <brauner@kernel.org> wrote:
> 
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
> > (3) Dumping into an AF_UNIX socket.
> > 
> > Userspace can set /proc/sys/kernel/core_pattern to:
> > 
> >         @/path/to/coredump.socket
> > 
> > The "@" at the beginning indicates to the kernel that an AF_UNIX
> > coredump socket will be used to process coredumps.
> > 
> > The coredump socket must be located in the initial mount namespace.
> > When a task coredumps it opens a client socket in the initial network
> > namespace and connects to the coredump socket.
> 
> 
> There is a problem with using @ as naming convention.
> The starting character of @ is already used to indicate abstract
> unix domain sockets in some programs like ss.

This shouldn't be a problem. First because @ isn't part of the actual
AF_UNIX path. But mostly because ss and other network related tools have
no relationship with /proc/sys/kernel/core_pattern whatsoever. I'm not
opposed to changing it if people do care strongly about it and send a
patch. But that will happen as a fixup after the merge window.

> And will the new coredump socekt allow use of abstrace unix
> domain sockets?

No. There's no safe permission model without involving LSMs.
Unprivileged attackers can recycle the socket address and use it to get
(suid) coredumps forwarded to them when the server crashes or restarts.

