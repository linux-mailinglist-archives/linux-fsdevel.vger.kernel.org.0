Return-Path: <linux-fsdevel+bounces-48792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25590AB4962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 04:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24B83B9D0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CB1C84CE;
	Tue, 13 May 2025 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JZC8aJVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE51B4141;
	Tue, 13 May 2025 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102609; cv=none; b=qwKD2so8u6uwFbIWpezWrFijClLEW5YlqP2f7yrKw4QwzwAmJsJpUCEj01nQyrybI2XXt8wkI6eDe4WEy2IZc/nPVXABLVE8/y2YCMh7hWfFijJOQwyOkSUGk4HjYOaFLRkY13XF1JY3Wssfh2OBr49q7SXKTGseZfOVh0cxd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102609; c=relaxed/simple;
	bh=squLWHTdlP9zj6uBU/Dw9pNTzdllHI8WXRtl7RwHSI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPY1zGHeY0czo529RDIr1ud3dkNsPYw8HeBJgkzk7mxpz4olgkEbuyTBSSjZT3QZzOyhLoCrX9fS4np5AD09BHUM4FO2OBAQ8qz+Zph3npo6K2jM5YdzPgMCwO2c22oCRi2ilFBknPKGm8G0sqwLbpDjmtvpGI8Cqw5tn03XUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JZC8aJVx; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747102608; x=1778638608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rjYkzvwGio+bty/BMJv4MrTabceHm7ehCjkTYiMnsD0=;
  b=JZC8aJVxQ4KKmptTrGLXVe1b1BLYW4ojYRlspVtjdNvxL/r3xGv5DtW6
   BhdMVmE0zi6s3ku2AEuRm70CI/VqmbVJpMcFlMji2ZR6FSD9Zpbq8KiPX
   OY7O42LxmNu2hq2hQa8sym9fIf06YuVBhQG9T7X+S4DKzPSvjk9MMez5q
   cK+tCNi6SEjcaVR1/956wrGl/zYKvtAkajutZ8yeeEWeBLQouUaR9g77j
   /WCdTVhZOgL1HlNJM/wmuGzdU3bj96+T9c1qt/FPUG4v+HMr5JwbW8Ab7
   RleMv/YMARJu0aONVE9ypxQc22uJqaNIfM2nl1MVXi4DZA1/rgj18OylA
   g==;
X-IronPort-AV: E=Sophos;i="6.15,284,1739836800"; 
   d="scan'208";a="497909089"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 02:16:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:55249]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.127:2525] with esmtp (Farcaster)
 id e929d8f1-74b0-4513-a656-2c1a647b05ed; Tue, 13 May 2025 02:16:39 +0000 (UTC)
X-Farcaster-Flow-ID: e929d8f1-74b0-4513-a656-2c1a647b05ed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 02:16:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 02:16:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <bluca@debian.org>
CC: <alexander@mihalicyn.com>, <brauner@kernel.org>,
	<daan.j.demeyer@gmail.com>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<david@readahead.eu>, <edumazet@google.com>, <horms@kernel.org>,
	<jack@suse.cz>, <jannh@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH v6 4/9] coredump: add coredump socket
Date: Mon, 12 May 2025 19:14:48 -0700
Message-ID: <20250513021626.86287-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAMw=ZnRC7Okmew=rrEocFuFn8hhrcergHciPjxFPuG4c6qH_Bw@mail.gmail.com>
References: <CAMw=ZnRC7Okmew=rrEocFuFn8hhrcergHciPjxFPuG4c6qH_Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Luca Boccassi <bluca@debian.org>
Date: Tue, 13 May 2025 02:09:24 +0100
> On Tue, 13 May 2025 at 01:18, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Luca Boccassi <bluca@debian.org>
> > Date: Mon, 12 May 2025 11:58:54 +0100
> > > On Mon, 12 May 2025 at 09:56, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > Coredumping currently supports two modes:
> > > >
> > > > (1) Dumping directly into a file somewhere on the filesystem.
> > > > (2) Dumping into a pipe connected to a usermode helper process
> > > >     spawned as a child of the system_unbound_wq or kthreadd.
> > > >
> > > > For simplicity I'm mostly ignoring (1). There's probably still some
> > > > users of (1) out there but processing coredumps in this way can be
> > > > considered adventurous especially in the face of set*id binaries.
> > > >
> > > > The most common option should be (2) by now. It works by allowing
> > > > userspace to put a string into /proc/sys/kernel/core_pattern like:
> > > >
> > > >         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> > > >
> > > > The "|" at the beginning indicates to the kernel that a pipe must be
> > > > used. The path following the pipe indicator is a path to a binary that
> > > > will be spawned as a usermode helper process. Any additional parameters
> > > > pass information about the task that is generating the coredump to the
> > > > binary that processes the coredump.
> > > >
> > > > In the example core_pattern shown above systemd-coredump is spawned as a
> > > > usermode helper. There's various conceptual consequences of this
> > > > (non-exhaustive list):
> > > >
> > > > - systemd-coredump is spawned with file descriptor number 0 (stdin)
> > > >   connected to the read-end of the pipe. All other file descriptors are
> > > >   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
> > > >   already caused bugs because userspace assumed that this cannot happen
> > > >   (Whether or not this is a sane assumption is irrelevant.).
> > > >
> > > > - systemd-coredump will be spawned as a child of system_unbound_wq. So
> > > >   it is not a child of any userspace process and specifically not a
> > > >   child of PID 1. It cannot be waited upon and is in a weird hybrid
> > > >   upcall which are difficult for userspace to control correctly.
> > > >
> > > > - systemd-coredump is spawned with full kernel privileges. This
> > > >   necessitates all kinds of weird privilege dropping excercises in
> > > >   userspace to make this safe.
> > > >
> > > > - A new usermode helper has to be spawned for each crashing process.
> > > >
> > > > This series adds a new mode:
> > > >
> > > > (3) Dumping into an abstract AF_UNIX socket.
> > > >
> > > > Userspace can set /proc/sys/kernel/core_pattern to:
> > > >
> > > >         @address SO_COOKIE
> > > >
> > > > The "@" at the beginning indicates to the kernel that the abstract
> > > > AF_UNIX coredump socket will be used to process coredumps. The address
> > > > is given by @address and must be followed by the socket cookie of the
> > > > coredump listening socket.
> > > >
> > > > The socket cookie is used to verify the socket connection. If the
> > > > coredump server restarts or crashes and someone recycles the socket
> > > > address the kernel will detect that the address has been recycled as the
> > > > socket cookie will have necessarily changed and refuse to connect.
> > >
> > > This dynamic/cookie prefix makes it impossible to use this with socket
> > > activation units. The way systemd-coredump works is that every
> > > instance is an independent templated unit, spawned when there's a
> > > connection to the private socket. If the path was fixed, we could just
> > > reuse the same mechanism, it would fit very nicely with minimal
> > > changes.
> >
> > Note this version does not use prefix.  Now it requires users to
> > just pass the socket cookie via core_pattern so that the kernel
> > can verify the peer.
> 
> Exactly - this means the pattern cannot be static in a sysctl.d early
> on boot anymore, and has to be set dynamically by <something>.

You missed the socket has to be created dynamically by <something>.


> This is
> a severe degradation over the status quo.
> 
> > > But because you need a "server" to be permanently running, this means
> > > socket-based activation can no longer work, and systemd-coredump must
> > > switch to a persistently-running mode.
> >
> > The only thing for systemd to do is assign a cookie after socket creation.
> >
> > As long as systemd hold the file descriptor of the socket, you don't need
> > a dedicated "server" running permanently, and the fd can be passed around
> > to a spawned/activated process.
> 
> There is no such facility, a socket is just a socket and there's no
> infrastructure to randomly extract random information from one and
> write it to some other random file in procfs,

As only one socket can be registered to core_pattern, the socket
must not be a random.


> and I don't see why we
> should add some super-special-case just for this,

Because this is a new special use case.


> it sounds really
> messy.
> Also sockets can be and in fact are routinely restarted (eg: on
> package upgrades), which would invalidate this whole scheme, and
> result in a very racy setup. When packages are upgraded it's one of
> the most complex workflows in modern distros, and it's very likely
> that things start crashing exactly at that point, and with this
> workflow it would mean we'll lose core files due to the race between
> restarting the socket unit and <something> updating the pattern
> accordingly.

Looks like you misunderstood the series.

As you need to specify the socket in core_pattern, there must be
only one socket that can receive core data, so the problem statement
is always true throughout the series.

kernel_connect() does not connect() to a random one out of sockets
that have the common prefix.

That's why the BPF was mentioned in the previous cover letter:

- Since unix_stream_connect() runs bpf programs during connect it's
  possible to even redirect or multiplex coredumps to other sockets.


> Also we very much want to be able to spawn as many core handlers at
> the same time as needed, which I don't see how can work with a cookie
> that has to be unique per socket.

As said, you can just pass the fd of the coredump listener or a fd
accept()ed from the listener, depending on how you want to handle
this in userspace.

