Return-Path: <linux-fsdevel+bounces-48788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD9AAB4840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 02:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B4816FDD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958583FB0E;
	Tue, 13 May 2025 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WFXVjDX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16D34CF9;
	Tue, 13 May 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094836; cv=none; b=fo8NlBzjguBW1AMZSu2S/4xEi6sgkLqyTw+O5d0wxNKNlMRJVvjkU4YP0kQDHm5mJJy1TNUeAkg2ZlI1KeQtaswQZ8Qw0aXm9y874s5/PN6TfYjhFPtfXPf0Bf7DTIz6GiWzt/RJi64ODyXR4SDyi0fJVbSkq155PL2nryzc+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094836; c=relaxed/simple;
	bh=1Dv0/T1OzOI9S9kobkkQBaQjTQE082lnl34vUNXZXlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwU6EiS34S008efEBg+/Eg6uwLX3KzbzrdtJuUTK0Id4RE5TjTtQnjXaAkWtpNOUakSGa8leLTIc8oAjY6Ny0nT5vpng/JzmeXKYKyoLrzlu63DUCtehxj6LAHa3AUemjVnSfH4X2Y+usAXmAYcKjjXobfkMwBcundLch6/+k6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WFXVjDX4; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747094834; x=1778630834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gd0JbqoThOAcG9lUth2CH+SlK+agzaN7UJ8hAzpZuQ=;
  b=WFXVjDX4lRSoiC4wM/56u6wUm8A9BnNbxo28eLWA6wkruFZfUjeLm6k9
   hRf/gKYvSQ3Uj90vNZXDu0JxcDnov8WGeSbaQ+J4HwIOXxLSTk5lVje+u
   ubaZwuTkO70BT56cIgr4cEhikn4UnBIQDZc+oBT99GbvKRhnM8m9ihVWn
   connI0a1F4cCO7R3S1lh6yTz1m52E3MHO1dB6eXTJk+669JQrDIwACklu
   72s1AvL7Z8qT7weBWVOmzBiSyYP8wGOCuahRxFUnC/QlsAMBvBz1tviYT
   5Au5sxzqDtVJwa6oljnJmXTaPZeyrJSIJJcwEVBe3cWP55GdJXgPHReMK
   A==;
X-IronPort-AV: E=Sophos;i="6.15,283,1739836800"; 
   d="scan'208";a="18996074"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 00:07:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:63320]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.45:2525] with esmtp (Farcaster)
 id 5ab8e38a-bd8a-4f08-93c9-5730d015e51a; Tue, 13 May 2025 00:07:08 +0000 (UTC)
X-Farcaster-Flow-ID: 5ab8e38a-bd8a-4f08-93c9-5730d015e51a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 00:07:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 00:07:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <david@readahead.eu>,
	<edumazet@google.com>, <horms@kernel.org>, <jack@suse.cz>,
	<jannh@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH v6 4/9] coredump: add coredump socket
Date: Mon, 12 May 2025 17:06:50 -0700
Message-ID: <20250513000654.70344-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512-work-coredump-socket-v6-4-c51bc3450727@kernel.org>
References: <20250512-work-coredump-socket-v6-4-c51bc3450727@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 May 2025 10:55:23 +0200
> Coredumping currently supports two modes:
> 
> (1) Dumping directly into a file somewhere on the filesystem.
> (2) Dumping into a pipe connected to a usermode helper process
>     spawned as a child of the system_unbound_wq or kthreadd.
> 
> For simplicity I'm mostly ignoring (1). There's probably still some
> users of (1) out there but processing coredumps in this way can be
> considered adventurous especially in the face of set*id binaries.
> 
> The most common option should be (2) by now. It works by allowing
> userspace to put a string into /proc/sys/kernel/core_pattern like:
> 
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> 
> The "|" at the beginning indicates to the kernel that a pipe must be
> used. The path following the pipe indicator is a path to a binary that
> will be spawned as a usermode helper process. Any additional parameters
> pass information about the task that is generating the coredump to the
> binary that processes the coredump.
> 
> In the example core_pattern shown above systemd-coredump is spawned as a
> usermode helper. There's various conceptual consequences of this
> (non-exhaustive list):
> 
> - systemd-coredump is spawned with file descriptor number 0 (stdin)
>   connected to the read-end of the pipe. All other file descriptors are
>   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
>   already caused bugs because userspace assumed that this cannot happen
>   (Whether or not this is a sane assumption is irrelevant.).
> 
> - systemd-coredump will be spawned as a child of system_unbound_wq. So
>   it is not a child of any userspace process and specifically not a
>   child of PID 1. It cannot be waited upon and is in a weird hybrid
>   upcall which are difficult for userspace to control correctly.
> 
> - systemd-coredump is spawned with full kernel privileges. This
>   necessitates all kinds of weird privilege dropping excercises in
>   userspace to make this safe.
> 
> - A new usermode helper has to be spawned for each crashing process.
> 
> This series adds a new mode:
> 
> (3) Dumping into an abstract AF_UNIX socket.
> 
> Userspace can set /proc/sys/kernel/core_pattern to:
> 
>         @address SO_COOKIE
> 
> The "@" at the beginning indicates to the kernel that the abstract
> AF_UNIX coredump socket will be used to process coredumps. The address
> is given by @address and must be followed by the socket cookie of the
> coredump listening socket.
> 
> The socket cookie is used to verify the socket connection. If the
> coredump server restarts or crashes and someone recycles the socket
> address the kernel will detect that the address has been recycled as the
> socket cookie will have necessarily changed and refuse to connect.
> 
> The coredump socket is located in the initial network namespace. When a
> task coredumps it opens a client socket in the initial network namespace
> and connects to the coredump socket.
> 
> - The coredump server uses SO_PEERPIDFD to get a stable handle on the
>   connected crashing task. The retrieved pidfd will provide a stable
>   reference even if the crashing task gets SIGKILLed while generating
>   the coredump.
> 
> - By setting core_pipe_limit non-zero userspace can guarantee that the
>   crashing task cannot be reaped behind it's back and thus process all
>   necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
>   detect whether /proc/<pid> still refers to the same process.
> 
>   The core_pipe_limit isn't used to rate-limit connections to the
>   socket. This can simply be done via AF_UNIX sockets directly.
> 
> - The pidfd for the crashing task will grow new information how the task
>   coredumps.
> 
> - The coredump server should mark itself as non-dumpable.
> 
> - A container coredump server in a separate network namespace can simply
>   bind to another well-know address and systemd-coredump fowards
>   coredumps to the container.
> 
> - Coredumps could in the future also be handled via per-user/session
>   coredump servers that run only with that users privileges.
> 
>   The coredump server listens on the coredump socket and accepts a
>   new coredump connection. It then retrieves SO_PEERPIDFD for the
>   client, inspects uid/gid and hands the accepted client to the users
>   own coredump handler which runs with the users privileges only
>   (It must of coure pay close attention to not forward crashing suid
>   binaries.).
> 
> The new coredump socket will allow userspace to not have to rely on
> usermode helpers for processing coredumps and provides a safer way to
> handle them instead of relying on super privileged coredumping helpers
> that have and continue to cause significant CVEs.
> 
> This will also be significantly more lightweight since no fork()+exec()
> for the usermodehelper is required for each crashing process. The
> coredump server in userspace can e.g., just keep a worker pool.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

