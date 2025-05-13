Return-Path: <linux-fsdevel+bounces-48789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFABAB4858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 02:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CAF166A8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74033B7A8;
	Tue, 13 May 2025 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="edFefTng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9328F3;
	Tue, 13 May 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095490; cv=none; b=N5nTrhhNHQvkB0yv7CBVTk86wM6yxPAbKe996nxF1bMsiSwZ3Hz1HBlYslT6EjPvxMzzCotouFVzHYDvpTUZefZIydrgKVvk1gbWHUR4CfX6DwG9RcxkcJv4GGKSHSdUGqpR34f14WNklu8KSrv1INrMlBrNqPz1zNwVgxGWZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095490; c=relaxed/simple;
	bh=SsVMbcIv3zVzCdAnix7sRxmHxtkf9TkXt3Sbd72U9PU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmIa2iIUyKgcH3Apsb2GuRrZXde7iXu3VUrCj5JhI7cuAw2eaxhwMKMn1KbWi2uIq0GMPUdZzEJt6Hcm0Pf3LS4dC+ZYECLMDwmLqxkIyIMnhyqb2sqJ57Q2jGmqOqfRq3oafcfAZi8ZE6svJap0jvvn7vvu7A38nfLZXmjmU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=edFefTng; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747095489; x=1778631489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/O6pzhVKHaw/TXHTk58VZBH72gJWEpxM01lZaMwbpc=;
  b=edFefTngE3GVjt3Gvn/EwecX6DNgvS/RNO3GKrEXGlewaIotA6D2QRTq
   j4el3Ww4nxzlRquI3Vnk1wailzF/iQ0uvy8Q1PUGBDoZ2G1uVIjImFzza
   l3GPAutVtuvqjAGJAX7sy/QVWrT+6e1rYf3DQ8bnnnDCGWJdayZow2kmb
   4JxBSd/ssgNq6LNli9UV+5KnOvHOLeBfet7IxSM92A6o4LBUJcBkG84Ao
   84OReEEdJHTvSxjpk5RFqN5heimQZDSzWkTwukMjIwZ/L2gTqiMyBLuJ/
   GT1sPLZjhh8MDIiGXHQwQgY+8Q3dLOXfJ5OtAyy6c1mw61ylVtGNAJt6d
   g==;
X-IronPort-AV: E=Sophos;i="6.15,283,1739836800"; 
   d="scan'208";a="722057387"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 00:18:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:64555]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.68:2525] with esmtp (Farcaster)
 id f44233c5-dd2b-4c7c-bdca-3a8a74545c69; Tue, 13 May 2025 00:18:03 +0000 (UTC)
X-Farcaster-Flow-ID: f44233c5-dd2b-4c7c-bdca-3a8a74545c69
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 00:18:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 00:17:59 +0000
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
Date: Mon, 12 May 2025 17:17:36 -0700
Message-ID: <20250513001751.71660-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAMw=ZnTF9EVV+E+bXTz1je3VT+OwDPAzbbFy7G02zBjeCpqxFA@mail.gmail.com>
References: <CAMw=ZnTF9EVV+E+bXTz1je3VT+OwDPAzbbFy7G02zBjeCpqxFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Luca Boccassi <bluca@debian.org>
Date: Mon, 12 May 2025 11:58:54 +0100
> On Mon, 12 May 2025 at 09:56, Christian Brauner <brauner@kernel.org> wrote:
> >
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
> >         @address SO_COOKIE
> >
> > The "@" at the beginning indicates to the kernel that the abstract
> > AF_UNIX coredump socket will be used to process coredumps. The address
> > is given by @address and must be followed by the socket cookie of the
> > coredump listening socket.
> >
> > The socket cookie is used to verify the socket connection. If the
> > coredump server restarts or crashes and someone recycles the socket
> > address the kernel will detect that the address has been recycled as the
> > socket cookie will have necessarily changed and refuse to connect.
> 
> This dynamic/cookie prefix makes it impossible to use this with socket
> activation units. The way systemd-coredump works is that every
> instance is an independent templated unit, spawned when there's a
> connection to the private socket. If the path was fixed, we could just
> reuse the same mechanism, it would fit very nicely with minimal
> changes.

Note this version does not use prefix.  Now it requires users to
just pass the socket cookie via core_pattern so that the kernel
can verify the peer.


> 
> But because you need a "server" to be permanently running, this means
> socket-based activation can no longer work, and systemd-coredump must
> switch to a persistently-running mode.

The only thing for systemd to do is assign a cookie after socket creation.

As long as systemd hold the file descriptor of the socket, you don't need
a dedicated "server" running permanently, and the fd can be passed around
to a spawned/activated process.


> This is a severe degradation of
> functionality, will continuously waste CPU/memory resources for no
> good reasons, and makes the whole thing more fragile and complex, as
> if there are any issues with this server, you start losing core files.
> And honestly I don't really see the point? Setting the pattern is a
> privileged operation anyway. systemd manages the socket with a socket
> unit and again that's privileged already.
> 
> Could we drop this cookie prefix and go back to the previous version
> (v5), please? Or if there is some specific non-systemd use case in
> mind that I am not aware of, have both options, so that we can use the
> simpler and more straightforward one with systemd-coredump.

