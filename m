Return-Path: <linux-fsdevel+bounces-49700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE7BAC17EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 01:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C133FA4564C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 23:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66C2D29CE;
	Thu, 22 May 2025 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KLxzth7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8E2D29B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956333; cv=none; b=aSq+0eIyZknSORmvv1TEEBgEcXps1Skd78SBeHa9SmbVtkN33wsg5eSdtEgnyjLL8Hr9UiXblRWqKqJ+Hny9Qf7D/qgq+oEakT6MS68ZuvEPfqjieVI5DwVVyZLJoOLVlDunaE+vP2smKNAOBgX6j1dtk0IQY32Ww9u70629TO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956333; c=relaxed/simple;
	bh=8xTSm64CPrt3PR+sNDjw7Hs789WkFskuVsOorw0bNec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJg+tS4EndbOvTcO0zheJGTOhOoJ/s9O46GMxJ7xgchbuepwOlvckBds9+A91TFDBXLlCqBM45lp1kot8XFyVrQnwfRBCXXWgeGVDbyODyHsZ/19S/QGKTStuZ+3O+yTDgl6CMUM4QQpsrA/52cdZuyX+Sf8G2Fu7k+/cUaEZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KLxzth7O; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70ccf9a4ab3so54161467b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747956330; x=1748561130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uL4ci1WZdyZovxUefSb6XMWKQbQDoDS9sC5km2V0Pg=;
        b=KLxzth7OBXvm76zWTcuhKXa4zTiCWG3kNMLThUHAnz6qdV/1o+Me88zTXuJ8SuPVqr
         pmbLCYbc9CTHqaXnD/TiK9PAJmSXn2+RTXmXXWdhmGxoxCZk6l0hy1Ufgo5m8mgTwcTI
         lK8OX1U9i4uGuyNUjv10Y7XYz+AYeqpcbFea7ZqbJlLefwOO9Xi+luNjfw10JiwMdItW
         v8hZIuhd9eLo6IK0wFom/IauUv82DkftM7I2cq7yE2cughmfaDUzIpEzbLY/QWWuN82u
         +vKwpX6AnGZY9TAoJF5yVE9JsKTZ1XFeZwWxASohkRqZV+CJUZVq1pBmWmoar4qeYu9g
         z66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956330; x=1748561130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uL4ci1WZdyZovxUefSb6XMWKQbQDoDS9sC5km2V0Pg=;
        b=P4zAI+D7+G6kgIi2+LfPE0I+PmdlEtW4acnfnM8jDzLI1Fw2PYsxXOMRqteoo/hw0e
         aMkrcsP2TaBvLpyBypoUQfenvCcMqh1Q3RXNxUTp3k3wkkvlSJtHrpQ27BzWaFMHnzsG
         ojFIH6Qy3rG1kJemWtkXsByHJC6rkLC8pXxmMQDU9e0CzSpmasWLufBPfrpO4zUqCbqe
         cQAwvWv2gnW8lcKx/W1NQ8WXR9VCHaoNJQSU1n+bgmffoQfXn+1EBDTXDAWkzU8PDSW1
         AHYWJlC7c1QQdyz0RfWatHl39YM+K8qG2cPeEJ0efNhR0uAp8VWQSmIJnlK1JhIVQgd6
         h4aw==
X-Gm-Message-State: AOJu0YzNg8kXHkGOO02Lhw0mzZoo8Whd5Txj7tZOopyxBF7ba0NDYYsK
	QhtVYaMc5VVHjEGaIqBLkCnCa99KmmojWQpPYz4YdFMmVrkpwIgDgV451lpi+/hBtG0RFahPrsz
	wuUmvR2t9k+4GJI+SZ+/E8WH/MiyCS8J7vKSN60ZW
X-Gm-Gg: ASbGncuPc1KdysGBlI6lsrFY6ucnbiQ3aToJoXQfnNElgO4t8pu7pJnYgnJTX234c+n
	E45FoV2pvabaZ2C2EUr8S3L/LCAVveCLF49CWi5YItOVxLo4m3urJZbk4Hg1AGR3u3fccBEj+qz
	ZU+4sYxUIy4tGeOdztpdn7w5hszC1KzMdw
X-Google-Smtp-Source: AGHT+IHqIDOdvopIVKoruNZp2FA6nsIW5xRfQTbNntomxujQ5GmGe3SFUbJUdBmc/lotxuvJGdjYJkUqvIyDeOpJGDk=
X-Received: by 2002:a05:690c:6c03:b0:70e:1771:c152 with SMTP id
 00721157ae682-70e1771c5d3mr26144077b3.30.1747956330254; Thu, 22 May 2025
 16:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org> <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 May 2025 19:25:18 -0400
X-Gm-Features: AX0GCFt0FuHTqiMqvoz0ziFimdoZps9PqDLqEUMhVFo_oJsTI3jl215IOcxlhcE
Message-ID: <CAHC9VhTaaDBROL=xRBcRu4gMRK5vkPBiZRsGbxc7szacuZk26Q@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 7:27=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
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
> (3) Dumping into an AF_UNIX socket.
>
> Userspace can set /proc/sys/kernel/core_pattern to:
>
>         @/path/to/coredump.socket
>
> The "@" at the beginning indicates to the kernel that an AF_UNIX
> coredump socket will be used to process coredumps.
>
> The coredump socket must be located in the initial mount namespace.
> When a task coredumps it opens a client socket in the initial network
> namespace and connects to the coredump socket.
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
> Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/coredump.c       | 118 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  include/linux/net.h |   1 +
>  net/unix/af_unix.c  |  54 ++++++++++++++++++------
>  3 files changed, 156 insertions(+), 17 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

