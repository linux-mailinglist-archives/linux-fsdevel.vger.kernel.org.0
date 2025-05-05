Return-Path: <linux-fsdevel+bounces-48117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373A8AA9B96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 20:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4027A1B7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D5D26E15F;
	Mon,  5 May 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qs2smi/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0434CF5;
	Mon,  5 May 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470012; cv=none; b=s0x3MczJ/IYK79Y+St3BnvZJXklqWTc2EoQlBwiuKsYKVVc6sFAE40n05/jZDGd5zK9loc60IqWBCkvV3MRCwB6BUM4Cf+mwvWqQUmXMDY86ipNcuiAMQrhsrLhpp/FOx9G+kcZn7zBNaMVMYaz6x3EAGH8RV71ioPW5qDiBXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470012; c=relaxed/simple;
	bh=HXO5JcDo80JaOhk9cK0Fhw9BSR/xmOMPB4eD9xgN0xI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsnOLEr/a1ph0OC4HvFL7khpG7+Q2jOKXo7ynmhppUCs3aWXk8+uzcunhPJm/UrZH3gTUiYvTrD7iNSSJyxg8tiHGRElVOVd2JPmR5n2cjARFWgSlnwRRf2AtfjK6nPF4MjR43ka0MjmoknmEkdeCnQvnisKOpuxJ+sBfEmQUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qs2smi/h; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746470011; x=1778006011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmnKyyPy8iUgcNbmIz3b3IApAhNbCnLedsjN4F9Uwb0=;
  b=qs2smi/hdp+Hg2DcoQK/DkOIQt7IvquaZ1E0XAgmkEF2EtxTAw4maH0V
   VBgZbQb+IlZCh2R1iVo/enHBieGfSSrOXTcLNjQ7A9C3tiQi3aP+9/z2d
   6V3XVu/89brAqOCodWOVE8yhGGeHuiuVul80QUFLgdU5irTthjgcJgfF+
   M=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="90169577"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 18:33:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:46279]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.21:2525] with esmtp (Farcaster)
 id bf9ed52f-b5c4-4af4-80e5-24084eff4961; Mon, 5 May 2025 18:33:16 +0000 (UTC)
X-Farcaster-Flow-ID: bf9ed52f-b5c4-4af4-80e5-24084eff4961
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 18:33:15 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 18:33:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <jannh@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <lennart@poettering.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH RFC v3 00/10] coredump: add coredump socket
Date: Mon, 5 May 2025 11:33:00 -0700
Message-ID: <20250505183303.14126-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:38 +0200
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
>         @linuxafsk/coredump_socket
> 
> The "@" at the beginning indicates to the kernel that the abstract
> AF_UNIX coredump socket will be used to process coredumps.
> 
> The coredump socket uses the fixed address "linuxafsk/coredump.socket"
> for now.

What's behind this dicision from v2 ?

/proc/sys/kernel/core_pattern can only be set by Administrator
and I don't see the point in having this limitation on the
AF_UNIX side.



> 
> The coredump socket is located in the initial network namespace.

I understand this is a reasonable decision to avoid complicated
path management in the mount ns but keep connectivity from any
namespace.


> To bind
> the coredump socket userspace must hold CAP_SYS_ADMIN in the initial
> user namespace. Listening and reading can happen from whatever
> unprivileged context is necessary to safely process coredumps.
> 
> When a task coredumps it opens a client socket in the initial network
> namespace and connects to the coredump socket. For now only tasks that
> are acctually coredumping are allowed to connect to the initial coredump
> socket.

This can be controlled by BPF (cgroup sockops or LSM) if a user
really cares about spam clients.

I think how to set up coredump is userspace responsibility.


> 
> - The coredump server should use SO_PEERPIDFD to get a stable handle on
>   the connected crashing task. The retrieved pidfd will provide a stable
>   reference even if the crashing task gets SIGKILLed while generating
>   the coredump.
> 
> - By setting core_pipe_limit non-zero userspace can guarantee that the
>   crashing task cannot be reaped behind it's back and thus process all
>   necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
>   detect whether /proc/<pid> still refers to the same process.
> 
>   The core_pipe_limit isn't used to rate-limit connections to the
>   socket. This can simply be done via AF_UNIX socket directly.
> 
> - The pidfd for the crashing task will contain information how the task
>   coredumps. The PIDFD_GET_INFO ioctl gained a new flag
>   PIDFD_INFO_COREDUMP which can be used to retreive the coredump
>   information.
> 
>   If the coredump gets a new coredump client connection the kernel
>   guarantees that PIDFD_INFO_COREDUMP information is available.
>   Currently the following information is provided in the new
>   @coredump_mask extension to struct pidfd_info:
> 
>   * PIDFD_COREDUMPED is raised if the task did actually coredump.
>   * PIDFD_COREDUMP_SKIP	is raised if the task skipped coredumping (e.g.,
>     undumpable).
>   * PIDFD_COREDUMP_USER	is raised if this is a regular coredump and
>     doesn't need special care by the coredump server.
>   * IDFD_COREDUMP_ROOT is raised if the generated coredump should be
>     treated as sensitive and the coredump server should restrict to the
>     generated coredump to sufficiently privileged users.
> 
> - Since unix_stream_connect() runs bpf programs during connect it's
>   possible to even redirect or multiplex coredumps to other sockets.

If the socket is in a cgroup, yes, and even if not, BPF LSM can
reject some requests.


> 
> - The coredump server should mark itself as non-dumpable.
>   To capture coredumps for the coredump server itself a bpf program
>   should be run at connect to redirect it to another socket in
>   userspace. This can be useful for debugging crashing coredump servers.
> 
> - A container coredump server in a separate network namespace can simply
>   bind to linuxafsk/coredump.socket and systemd-coredump fowards
>   coredumps to the container.

I think the name should be also configurable in non-initial netns.


> 
> - Fwiw, one idea is to handle coredumps via per-user/session coredump
>   servers that run with that users privileges.
> 
>   The coredump server listens on the coredump socket and accepts a
>   new coredump connection. It then retrieves SO_PEERPIDFD for the
>   client, inspects uid/gid and hands the accepted client to the users
>   own coredump handler which runs with the users privileges only.
> 
> The new coredump socket will allow userspace to not have to rely on
> usermode helpers for processing coredumps and provides a safer way to
> handle them instead of relying on super privileged coredumping helpers.
> 
> This will also be significantly more lightweight since no fork()+exec()
> for the usermodehelper is required for each crashing process. The
> coredump server in userspace can just keep a worker pool.
> 
> This is easy to test:
> 
> (a) coredump processing (we're using socat):
> 
>     > cat coredump_socket.sh
>     #!/bin/bash
> 
>     set -x
> 
>     sudo bash -c "echo '@linuxafsk/coredump.socket' > /proc/sys/kernel/core_pattern"
>     sudo socat --statistics abstract-listen:linuxafsk/coredump.socket,fork FILE:core_file,create,append,trunc
> 
> (b) trigger a coredump:
> 
>     user1@localhost:~/data/scripts$ cat crash.c
>     #include <stdio.h>
>     #include <unistd.h>
> 
>     int main(int argc, char *argv[])
>     {
>             fprintf(stderr, "%u\n", (1 / 0));
>             _exit(0);
>     }

