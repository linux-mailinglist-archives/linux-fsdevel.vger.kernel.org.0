Return-Path: <linux-fsdevel+bounces-49553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61BABE898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 02:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774FD4E17D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7B7E105;
	Wed, 21 May 2025 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MO66rSpd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4246632;
	Wed, 21 May 2025 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747788146; cv=none; b=hCNsbkACdpx5pnWFk6FBckkyUETTust00XMrI4ooOuYcinW8r2g9alE1w7SmJdXXGSfuf8Fy5F3z7vSR3q8BAZnJFIrhnxFJIQOkcFnkGvGAH8QW3hhuZtN/VaivC1BLRTr4+qwQNYO4PCa5cGNNF6TFK58ThajN4+Zj7COgEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747788146; c=relaxed/simple;
	bh=JwuXcIJf4i76I1tCA4AmICXNLN6bpvr5vhDsldPaZj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj7jp5oXP8q9Ot7VwK9N9H5EkyF1PHw3zeX78ppnznEQ3VKkuQCAcnDqbHnxXNstGAUGsB9Oa4e2rBXx4Jrp3LouFvtiFliRFUSW4L54coekQZBRcLcwwhkyR5BB2+Nw2wxJiQtasxHiH8fVnFPdRFsUpp2BLdYBNeDfwiByuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MO66rSpd; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747788146; x=1779324146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9lVsmYxOW62soy44KdVJkVW7koejhz4/tgmlApVUKS8=;
  b=MO66rSpdv0klA7RcJ+Ka/gakG0oUkgybgkGgwbWHuSYj0n0yKRcVAXxU
   0oDxCBrPWLL7OCyle34dE6MtHmq722KEUbPdDiGkz5OsaYsbHXpNF7I/T
   PjuL4p1EtrV8gYQX9e1Cq2PrsMplf9rrOlItizwNsTmJ8XMgPtSjd/DuC
   sHO/puuuxxpf+EewVx9VBxExz96qiPhNvMAB4PR7CAWZuDfCDaf4wP+8W
   UbEIRWCiFvGNiaQrSSVB9MWRCzag0CxDlUpyIs5boR9eKex//zT0nyAuh
   /ersy2CevY7axGFKUstk3SJBPs79FMf/RBLR4W45XAu6Q4rBEus/6AXfB
   A==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="724880082"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 00:42:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:53710]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id e61ff1ca-97b4-4607-8771-aa879e1cc1a9; Wed, 21 May 2025 00:42:19 +0000 (UTC)
X-Farcaster-Flow-ID: e61ff1ca-97b4-4607-8771-aa879e1cc1a9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:42:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:42:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stephen@networkplumber.org>
CC: <alexander@mihalicyn.com>, <brauner@kernel.org>,
	<daan.j.demeyer@gmail.com>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<david@readahead.eu>, <edumazet@google.com>, <horms@kernel.org>,
	<jack@suse.cz>, <jannh@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<luca.boccassi@gmail.com>, <me@yhndnzj.com>, <netdev@vger.kernel.org>,
	<oleg@redhat.com>, <pabeni@redhat.com>, <serge@hallyn.com>,
	<viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH v8 0/9] coredump: add coredump socket
Date: Tue, 20 May 2025 17:41:58 -0700
Message-ID: <20250521004207.10514-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520122838.29131f04@hermes.local>
References: <20250520122838.29131f04@hermes.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 20 May 2025 12:28:38 -0700
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
> And will the new coredump socekt allow use of abstrace unix
> domain sockets?

The coredump only works with the pathname socket, so ideally
the prefix should be '/', but it's same with the direct-file
coredump.  We can distinguish the socket by S_ISSOCK() though.

