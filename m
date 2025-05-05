Return-Path: <linux-fsdevel+bounces-48105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC09AA96B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD48516992D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E225CC63;
	Mon,  5 May 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hsQtmhd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F024DFFE;
	Mon,  5 May 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457042; cv=none; b=ge4QB1uHaek3Cbzwi7mXiR73EANfjF1JDuj2/TnFMiGCXJhKsjE4m6ADa4p9TmzJwovynjLyQ9eXC+dQ99LTuE8FVMwMuQCTsdDLrnoYXGyQ3PA67tJbpsFvrn7xlWTx2OhvCwCDBZ3nrHRmfBN6dPkmfSNNHggHlJkSb0VZ+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457042; c=relaxed/simple;
	bh=rmJVoxe6JpXdnJlgrFr2iRmGnfNfaPEWutrVFR9VjQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rea0a8VNd/x6a0r1SCQin8Weja+bySMUhb0XN4NGHYepemI9kONINsM8w/NuuCTuimyeVrON9f41kkiErkys6qIID8TQKOwuvyEtNvgmdvplhC/Ek8TvNYakvRv3hzRBWXnPX9iY/YP+2YTYTqGW0vuykwYyBS+MsdJqEJcnGMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hsQtmhd5; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zrkk25Hfqzbv8;
	Mon,  5 May 2025 16:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746456090;
	bh=MC1nkmhENPqTiFdqcO3yyGjubPoyxSzyVFPPAgsdEiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsQtmhd5732QcbDRpO+NAQDAwbO+efKYwcz9xJqM9ociXjoaHMBkcOxs7vAtQLsBP
	 10gOFTa4Djyajxsro7f+KKOXAQx+kJkiro+oLmimPpUyu6fgqmJZDYRWBOQeaChn9z
	 9LDpOX6Lo0dnAIKeYrCkuvAXMEnHM8G83L/ChfL8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zrkk12dJgz36S;
	Mon,  5 May 2025 16:41:29 +0200 (CEST)
Date: Mon, 5 May 2025 16:41:28 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH RFC v3 00/10] coredump: add coredump socket
Message-ID: <20250505.aFia3choo1aw@digikod.net>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
X-Infomaniak-Routing: alpha

On Mon, May 05, 2025 at 01:13:38PM +0200, Christian Brauner wrote:
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
> 
> The coredump socket is located in the initial network namespace. To bind
> the coredump socket userspace must hold CAP_SYS_ADMIN in the initial
> user namespace. Listening and reading can happen from whatever
> unprivileged context is necessary to safely process coredumps.
> 
> When a task coredumps it opens a client socket in the initial network
> namespace and connects to the coredump socket. For now only tasks that
> are acctually coredumping are allowed to connect to the initial coredump
> socket.

I think we should avoid using abstract UNIX sockets, especially for new
interfaces, because it is hard to properly control such access.  Can we
create new dedicated AF_UNIX protocols instead?  One could be used by a
privileged process in the initial namespace to create a socket to
collect coredumps, and the other could be dedicatde to coredumped
proccesses.  Such (coredump collector) file descriptor or new (proxy)
socketpair ones could be passed to containers.

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
> 
> - The coredump server should mark itself as non-dumpable.
>   To capture coredumps for the coredump server itself a bpf program
>   should be run at connect to redirect it to another socket in
>   userspace. This can be useful for debugging crashing coredump servers.
> 
> - A container coredump server in a separate network namespace can simply
>   bind to linuxafsk/coredump.socket and systemd-coredump fowards
>   coredumps to the container.
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
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v3:
> - Use an abstract unix socket.
> - Add documentation.
> - Add selftests.
> - Link to v2: https://lore.kernel.org/20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org
> 
> Changes in v2:
> - Expose dumpability via PIDFD_GET_INFO.
> - Place COREDUMP_SOCK handling under CONFIG_UNIX.
> - Link to v1: https://lore.kernel.org/20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org
> 
> ---
> Christian Brauner (10):
>       coredump: massage format_corname()
>       coredump: massage do_coredump()
>       net: reserve prefix
>       coredump: add coredump socket
>       coredump: validate socket name as it is written
>       coredump: show supported coredump modes
>       pidfs, coredump: add PIDFD_INFO_COREDUMP
>       net, pidfs, coredump: only allow coredumping tasks to connect to coredump socket
>       selftests/pidfd: add PIDFD_INFO_COREDUMP infrastructure
>       selftests/coredump: add tests for AF_UNIX coredumps
> 
>  fs/coredump.c                                     | 358 +++++++++++++++++-----
>  fs/pidfs.c                                        |  68 ++++
>  include/linux/coredump.h                          |  12 +
>  include/linux/pidfs.h                             |   4 +
>  include/uapi/linux/pidfd.h                        |  16 +
>  include/uapi/linux/un.h                           |   2 +
>  net/unix/af_unix.c                                |  64 +++-
>  tools/testing/selftests/coredump/stackdump_test.c |  71 ++++-
>  tools/testing/selftests/pidfd/pidfd.h             |  22 ++
>  9 files changed, 528 insertions(+), 89 deletions(-)
> ---
> base-commit: 4dd6566b5a8ca1e8c9ff2652c2249715d6c64217
> change-id: 20250429-work-coredump-socket-87cc0f17729c
> 

