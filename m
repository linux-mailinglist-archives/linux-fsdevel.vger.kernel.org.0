Return-Path: <linux-fsdevel+bounces-49146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93678AB8994
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70C74E54C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA521F4E34;
	Thu, 15 May 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="dwjYS4LT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EFF1E47AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319877; cv=none; b=UlX0TDiLgRZqQrv5KYj6OrWe9GPi6/a7uieGhDAc2ZvVANXGzwCaDw7wf1+jqWnjD6SnkOUTivPlSEwW4acNwkSrz1vi3RKWxAR4nfaprne7zSySUkvlR0d1ljwTKZKp1M5pUV5USMtLZkUu9AryvDjB5OpThvv9YzQo2+LsJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319877; c=relaxed/simple;
	bh=3X5sko4Nwntj/peXWF9aJDG3UL9bSh5GIx4Fd527vKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I34V+IfPEiES0fEV6SgLkMZsNhQ0HqdRdKewMQp1S/z4VJN14mx1ZXfKZZoKUFvJcmhDkHc0tEwYEa5OJj2giSL6XGUyGJM9Xa2iZI8CnDz9s6CDVMjlHawdJiIJg50tyDzYG/tLhuQkcT1M0iukIcFt9eWe9Cb+bCm172/WRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=dwjYS4LT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d6f93316dso1101024e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747319872; x=1747924672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DLWxBncY3MQiODrTcOgN2iyGuvC/s1EoJ4HfsOmMJYE=;
        b=dwjYS4LT2sZAmY0ihlmXYSIg2I8BxZvaDaYXdum6Cpz61xOO2T5fn3uFKWQI93pQwW
         aJjL582NDThd+U9CUIGDUAtI8TTomiegjeP+/6RQ1c1TTPCiRAu69IuG13pvcJ0k8V8D
         RrA78/4Z066Yn54qzB/YRPjK7BY4ploMUPlbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747319872; x=1747924672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLWxBncY3MQiODrTcOgN2iyGuvC/s1EoJ4HfsOmMJYE=;
        b=F450qORDkCrfCRWkzYJpZF8ZX1uyBDI5dUWJ32YmBM8g1KJzxq2Okj9YcEsZTe5/El
         y/vqJgDw+r+RVm3pQ9uSOHM2LeDtB+Yn+WyAXfIb6XZoJj1Z9s+l+96S4ebW02/DQ2XZ
         QU+jhbJ098MsaOauGUy5HP0Gpfx/zkOiFoH01Lf0d9AQ1ElNcb6ZL+8ThE8ZAcOoFtmq
         NZ6JcuUTJHQGHIJ7n5bSqbNlH0eeoNf5I0j/0PBYdeamgG4V/hUG9G/ZlaWbbDN0UcBv
         NrH0PBk6oNEkkBu7brpqjD35YHQxDMcbjloTZvnzhXMo/gs5Q0i3WkvnXHVfYp5Ea5NI
         hDiA==
X-Gm-Message-State: AOJu0YzMS8xEImg0LRvAlHJQrNo8p+OB/e3JpKYfhu2/iQpSWwJd1ha5
	rqv/dkQFx+gal0+vywrsG5D69bq7nrrdF5EQ359gGz963s/3ThC0zeABbTjbnw2cEhzN8V8EQxx
	lpR7faYnhcEcOjgZ11vF3N7nCqJU7lTCsDnXwuw==
X-Gm-Gg: ASbGnct7QZMlGZKE/DjgiwRmmIEQ6C0KLcba9BHioipRRysXEJPXIt6yztfPN8XTuse
	+N5d8ZmwNQfyQ4IGD2OxbMwzSafSMd7c8er+KAaF2g1iRCXBMKFYP/jOv7wiVsB0y3P7lLMWLfc
	yTG2zrMoxMGzoy2WYjaE7JsYvZLUNmI7pohA==
X-Google-Smtp-Source: AGHT+IGs+xMJJuCwF4iYMa6FQJdBL8q8BniGjGgSR2O0W6M1de6ueJ35Ugysa/FTuz2YL3zSlBWZAjD7Qf2qdI7LP1w=
X-Received: by 2002:a05:6512:620c:b0:545:e2e:843a with SMTP id
 2adb3069b0e04-550d5fdaf2fmr3073738e87.38.1747319871767; Thu, 15 May 2025
 07:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-9-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-9-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 16:37:40 +0200
X-Gm-Features: AX0GCFtrGV-A5-J_ULGS4Xel3JuBrliCKkWxAO8426zXTklGUPBQJetOa3ixe_w
Message-ID: <CAJqdLrq3sy2LWiRpQtqnFXiONxo4Sx9oC0ZMc3pfRh7TS424ow@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] selftests/coredump: add tests for AF_UNIX coredumps
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Add a simple test for generating coredumps via AF_UNIX sockets.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/stackdump_test.c | 514 +++++++++++++++++++++-
>  1 file changed, 513 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
> index fe3c728cd6be..42ddcf0bdaf2 100644
> --- a/tools/testing/selftests/coredump/stackdump_test.c
> +++ b/tools/testing/selftests/coredump/stackdump_test.c
> @@ -1,14 +1,20 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <fcntl.h>
> +#include <inttypes.h>
>  #include <libgen.h>
>  #include <linux/limits.h>
>  #include <pthread.h>
>  #include <string.h>
> +#include <sys/mount.h>
>  #include <sys/resource.h>
> +#include <sys/stat.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
>  #include <unistd.h>
>
>  #include "../kselftest_harness.h"
> +#include "../pidfd/pidfd.h"
>
>  #define STACKDUMP_FILE "stack_values"
>  #define STACKDUMP_SCRIPT "stackdump"
> @@ -35,6 +41,7 @@ static void crashing_child(void)
>  FIXTURE(coredump)
>  {
>         char original_core_pattern[256];
> +       pid_t pid_coredump_server;
>  };
>
>  FIXTURE_SETUP(coredump)
> @@ -44,6 +51,7 @@ FIXTURE_SETUP(coredump)
>         char *dir;
>         int ret;
>
> +       self->pid_coredump_server = -ESRCH;
>         file = fopen("/proc/sys/kernel/core_pattern", "r");
>         ASSERT_NE(NULL, file);
>
> @@ -61,10 +69,17 @@ FIXTURE_TEARDOWN(coredump)
>  {
>         const char *reason;
>         FILE *file;
> -       int ret;
> +       int ret, status;
>
>         unlink(STACKDUMP_FILE);
>
> +       if (self->pid_coredump_server > 0) {
> +               kill(self->pid_coredump_server, SIGTERM);
> +               waitpid(self->pid_coredump_server, &status, 0);
> +       }
> +       unlink("/tmp/coredump.file");
> +       unlink("/tmp/coredump.socket");
> +
>         file = fopen("/proc/sys/kernel/core_pattern", "w");
>         if (!file) {
>                 reason = "Unable to open core_pattern";
> @@ -154,4 +169,501 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
>         fclose(file);
>  }
>
> +TEST_F(coredump, socket)
> +{
> +       int fd, pidfd, ret, status;
> +       FILE *file;
> +       pid_t pid, pid_coredump_server;
> +       struct stat st;
> +       char core_file[PATH_MAX];
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +       const struct sockaddr_un coredump_sk = {
> +               .sun_family = AF_UNIX,
> +               .sun_path = "/tmp/coredump.socket",
> +       };
> +       size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
> +                                sizeof("/tmp/coredump.socket");
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       file = fopen("/proc/sys/kernel/core_pattern", "w");
> +       ASSERT_NE(file, NULL);
> +
> +       ret = fprintf(file, "@/tmp/coredump.socket");
> +       ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
> +       ASSERT_EQ(fclose(file), 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
> +               __u64 peer_cookie;
> +               socklen_t fd_peer_pidfd_len, peer_cookie_len;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +               if (fd_server < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +               ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to bind coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               ret = listen(fd_server, 1);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to listen on coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "Failed to accept coredump socket connection\n");
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               peer_cookie_len = sizeof(peer_cookie);
> +               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
> +                                &peer_cookie, &peer_cookie_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
> +               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
> +                                &fd_peer_pidfd, &fd_peer_pidfd_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               memset(&info, 0, sizeof(info));
> +               info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +               ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "Missing coredump information from coredumping task\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "Received connection from non-coredumping task\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!info.coredump_cookie) {
> +                       fprintf(stderr, "Missing coredump cookie\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (info.coredump_cookie != peer_cookie) {
> +                       fprintf(stderr, "Mismatching coredump cookies\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               fd_core_file = creat("/tmp/coredump.file", 0644);
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "Failed to create coredump file\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read, bytes_write;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read < 0) {
> +                               close(fd_coredump);
> +                               close(fd_server);
> +                               close(fd_peer_pidfd);
> +                               close(fd_core_file);
> +                               _exit(EXIT_FAILURE);
> +                       }
> +
> +                       if (bytes_read == 0)
> +                               break;
> +
> +                       bytes_write = write(fd_core_file, buffer, bytes_read);
> +                       if (bytes_read != bytes_write) {
> +                               close(fd_coredump);
> +                               close(fd_server);
> +                               close(fd_peer_pidfd);
> +                               close(fd_core_file);
> +                               _exit(EXIT_FAILURE);
> +                       }
> +               }
> +
> +               close(fd_coredump);
> +               close(fd_server);
> +               close(fd_peer_pidfd);
> +               close(fd_core_file);
> +               _exit(EXIT_SUCCESS);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +       ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       waitpid(pid_coredump_server, &status, 0);
> +       self->pid_coredump_server = -ESRCH;
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
> +       ASSERT_GT(st.st_size, 0);
> +       /*
> +        * We should somehow validate the produced core file.
> +        * For now just allow for visual inspection
> +        */
> +       system("file /tmp/coredump.file");
> +}
> +
> +TEST_F(coredump, socket_detect_userspace_client)
> +{
> +       int fd, pidfd, ret, status;
> +       FILE *file;
> +       pid_t pid, pid_coredump_server;
> +       struct stat st;
> +       char core_file[PATH_MAX];
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +       const struct sockaddr_un coredump_sk = {
> +               .sun_family = AF_UNIX,
> +               .sun_path = "/tmp/coredump.socket",
> +       };
> +       size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
> +                                sizeof("/tmp/coredump.socket");
> +
> +       file = fopen("/proc/sys/kernel/core_pattern", "w");
> +       ASSERT_NE(file, NULL);
> +
> +       ret = fprintf(file, "@/tmp/coredump.socket");
> +       ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
> +       ASSERT_EQ(fclose(file), 0);
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
> +               __u64 peer_cookie;
> +               socklen_t fd_peer_pidfd_len, peer_cookie_len;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +               if (fd_server < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +               ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to bind coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               ret = listen(fd_server, 1);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to listen on coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "Failed to accept coredump socket connection\n");
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               peer_cookie_len = sizeof(peer_cookie);
> +               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
> +                                &peer_cookie, &peer_cookie_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
> +               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
> +                                &fd_peer_pidfd, &fd_peer_pidfd_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               memset(&info, 0, sizeof(info));
> +               info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +               ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "Missing coredump information from coredumping task\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (info.coredump_mask & PIDFD_COREDUMPED) {
> +                       fprintf(stderr, "Received unexpected connection from coredumping task\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (info.coredump_cookie) {
> +                       fprintf(stderr, "Received unexpected coredump cookie\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               close(fd_coredump);
> +               close(fd_server);
> +               close(fd_peer_pidfd);
> +               close(fd_core_file);
> +               _exit(EXIT_SUCCESS);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0) {
> +               int fd_socket;
> +               ssize_t ret;
> +
> +               fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
> +               if (fd_socket < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +
> +               ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> +               if (ret < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +               (void *)write(fd_socket, &(char){ 0 }, 1);
> +               close(fd_socket);
> +               _exit(EXIT_SUCCESS);
> +       }
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +       ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       waitpid(pid_coredump_server, &status, 0);
> +       self->pid_coredump_server = -ESRCH;
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
> +       ASSERT_EQ(errno, ENOENT);
> +}
> +
> +TEST_F(coredump, socket_enoent)
> +{
> +       int pidfd, ret, status;
> +       FILE *file;
> +       pid_t pid;
> +       char core_file[PATH_MAX];
> +
> +       file = fopen("/proc/sys/kernel/core_pattern", "w");
> +       ASSERT_NE(file, NULL);
> +
> +       ret = fprintf(file, "@/tmp/coredump.socket");
> +       ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
> +       ASSERT_EQ(fclose(file), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +}
> +
> +TEST_F(coredump, socket_no_listener)
> +{
> +       int pidfd, ret, status;
> +       FILE *file;
> +       pid_t pid, pid_coredump_server;
> +       int ipc_sockets[2];
> +       char c;
> +       const struct sockaddr_un coredump_sk = {
> +               .sun_family = AF_UNIX,
> +               .sun_path = "/tmp/coredump.socket",
> +       };
> +       size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
> +                                sizeof("/tmp/coredump.socket");
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       file = fopen("/proc/sys/kernel/core_pattern", "w");
> +       ASSERT_NE(file, NULL);
> +
> +       ret = fprintf(file, "@/tmp/coredump.socket");
> +       ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
> +       ASSERT_EQ(fclose(file), 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
> +               __u64 peer_cookie;
> +               socklen_t fd_peer_pidfd_len, peer_cookie_len;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +               if (fd_server < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +               ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to bind coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               close(fd_server);
> +               close(ipc_sockets[1]);
> +               _exit(EXIT_SUCCESS);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +
> +       waitpid(pid_coredump_server, &status, 0);
> +       self->pid_coredump_server = -ESRCH;
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.47.2
>

