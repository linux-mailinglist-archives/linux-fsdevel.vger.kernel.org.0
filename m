Return-Path: <linux-fsdevel+bounces-66914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E10C30414
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91A874FB0D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE831DDA0;
	Tue,  4 Nov 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="WJbmeNEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902631D75B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247964; cv=none; b=A8fbzATYX52GP4WvXfwE0825c8KQ/YkF4xJejuYbfojMSUyDn5m+gmkJEHufWTwbTFQEaU4b7j+IFRHdRCEXCGIyECVnXh1Z/5x5eycR3iLO1SyZhIM2kppAFy8xtCcVJqekKC2kHA6x645DBf4GZvuV3OMeDok05VExor0cISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247964; c=relaxed/simple;
	bh=pFTVfZkUF+VqpU9jGrSFHtwz4C0MOUiHGcg7AeJthdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VO9NvKUFgCy5nJMNe8LrTjptMcYKmFUDRVrZqvuc+sHGQdPSrVsMaQUfyxtWsam0dRpyVj6i4M7G83HrXP59y/nKJOWqaDrvcadQ2Y4LJZ4Oewu70AgXQGTVc1XCOYHAP9N8IRHowHPyujr+XygVnMK62Bq4yAzFfyA4rG+bUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=WJbmeNEn; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f9beb2730so2993828d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247961; x=1762852761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ComhRXEc0XhGJ+yc/8aQayu4sPVvc28d9BY1h1SNo8=;
        b=WJbmeNEnP+f2icAXTT1eFGWDGlnht6hRNqxTUpCdYRJh6MkKueBJRWicipiBtmpkX4
         qiT5Y46UC9PtIWtGPejCfMwgSisXLaRtIcnT2GfS7L6b60zqy0FjebFwYt3U7fVzSCWw
         IZNPt0GWx6yNrQvHsC3faNHFBrak/oT/hd4q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247961; x=1762852761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ComhRXEc0XhGJ+yc/8aQayu4sPVvc28d9BY1h1SNo8=;
        b=WkpJrQhFPdMLOgRmLFPY7JknB4fSbHYIZDfmCh1yCeWP5pNDP5dBpsPkxsPVGZ/MXB
         moViZZCDqPf6m56rTL+7NFtKU1/IQRg19PgFSfDbmFJbWTERmicRzFTemZ3TcCGMIgI5
         +tX4/dyeRmiDpObbLI1qo8EYBFKGBlJloymPHugHOD7n58m4kQkcQY4vGYrsVlt/n0tM
         aMp/w12jsALkj/IE3ux0XvpnsBOou77uQM71Sb9LUfZ1fRmg9/pBcPH/Q5qzXa9ae+8n
         1//0oRk53M0U5UwB321+Dw0qHCOqe2kxpZ5pRBFwxcCi5y/RK0Wow2ce5h9Q1a0gjYmp
         E0aw==
X-Gm-Message-State: AOJu0YzT1722/DDXi6eo3Lbnd/OziQY1yZKtdopua0xk0Iz4wrS0/RmA
	E9udlDbQfvNcZ4J3f2x8h2kg///wYKai9gdapZLUGN+8cmVvbYwaRheIjLEBultNr0xN7yCpjZH
	wm5R7ZcI7ntvg1GSM9ZefrsP2r8AX1JcBwB0fIAa29w==
X-Gm-Gg: ASbGncsVm4ZwGP273u1eJXeS9ud7x/5IG/IuzXii0WHq7aMoWo1eO+VHnouZ3G6VIEY
	U0q3oyzUkI7ep31T2G6Dpse1N5nlHKSmI+rFvVYFVDUUN7gBRR/DVPvGZJ8vm28E2hdRbStlJY5
	NewQ7lCNQ2xsFzHJgfJdycTGWZO5J0x3NDLoH06d5OurRkLgpuyPgq0IEUTXId4MjXzTv5bh5D/
	qkTS2JVzD0mzy7VyX6BHl36Wc1BsiJjD9/WWzq/UhuKy6/76hIZDjA9e180
X-Google-Smtp-Source: AGHT+IGLCbHwaxSFHn8CeIQDkdfEgt9r9R7rbvhZFSq7p6aUS9y6cZ62ygpyHucQOa+9MZsJXcsa5Zx9qnk/L/wVN/4=
X-Received: by 2002:a05:690e:4143:b0:63f:a87b:2066 with SMTP id
 956f58d0204a3-63fa87b7aadmr6765111d50.16.1762247961138; Tue, 04 Nov 2025
 01:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-22-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-22-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:19:05 +0100
X-Gm-Features: AWmQ_blPI-NZGMqZiZIbB5MjO1ibH-88TuTdZS8FCPgXIWUJDucqAf0utuCZE3M
Message-ID: <CAJqdLrpGmJ=-kYKssC-LvaaZUzX-A5Ni19cY0qFi8TR8jFfeYg@mail.gmail.com>
Subject: Re: [PATCH 22/22] selftests/coredump: add second PIDFD_INFO_COREDUMP_SIGNAL
 test
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:47 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Verify that when using simple socket-based coredump (@ pattern),
> the coredump_signal field is correctly exposed as SIGABRT.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  .../selftests/coredump/coredump_socket_test.c      | 146 +++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 9d5507fa75ec..7e26d4a6a15d 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -576,6 +576,152 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
>         wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
>  }
>
> +/*
> + * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump with SIGABRT
> + *
> + * Verify that when using simple socket-based coredump (@ pattern),
> + * the coredump_signal field is correctly exposed as SIGABRT.
> + */
> +TEST_F(coredump, socket_coredump_signal_sigabrt)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: create_and_listen_unix_socket failed: %m\n");
> +                       goto out;
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: write_nointr to ipc socket failed: %m\n");
> +                       goto out;
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: accept4 failed: %m\n");
> +                       goto out;
> +               }
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: get_peer_pidfd failed\n");
> +                       goto out;
> +               }
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: get_pidfd_info failed\n");
> +                       goto out;
> +               }
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP not set in mask\n");
> +                       goto out;
> +               }
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_COREDUMPED not set in coredump_mask\n");
> +                       goto out;
> +               }
> +
> +               /* Verify coredump_signal is available and correct */
> +               if (!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL)) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP_SIGNAL not set in mask\n");
> +                       goto out;
> +               }
> +
> +               if (info.coredump_signal != SIGABRT) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_signal=%d, expected SIGABRT=%d\n",
> +                               info.coredump_signal, SIGABRT);
> +                       goto out;
> +               }
> +
> +               fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "socket_coredump_signal_sigabrt: open_coredump_tmpfile failed: %m\n");
> +                       goto out;
> +               }
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read, bytes_write;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket_coredump_signal_sigabrt: read from coredump socket failed: %m\n");
> +                               goto out;
> +                       }
> +
> +                       if (bytes_read == 0)
> +                               break;
> +
> +                       bytes_write = write(fd_core_file, buffer, bytes_read);
> +                       if (bytes_read != bytes_write) {
> +                               fprintf(stderr, "socket_coredump_signal_sigabrt: write to core file failed (read=%zd, write=%zd): %m\n",
> +                                       bytes_read, bytes_write);
> +                               goto out;
> +                       }
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_coredump_signal_sigabrt: completed successfully\n");
> +out:
> +               if (fd_core_file >= 0)
> +                       close(fd_core_file);
> +               if (fd_peer_pidfd >= 0)
> +                       close(fd_peer_pidfd);
> +               if (fd_coredump >= 0)
> +                       close(fd_coredump);
> +               if (fd_server >= 0)
> +                       close(fd_server);
> +               _exit(exit_code);
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
> +               abort();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_EQ(WTERMSIG(status), SIGABRT);
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
> +       ASSERT_EQ(info.coredump_signal, SIGABRT);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
>  TEST_F(coredump, socket_invalid_paths)
>  {
>         ASSERT_FALSE(set_core_pattern("@ /tmp/coredump.socket"));
>
> --
> 2.47.3
>

