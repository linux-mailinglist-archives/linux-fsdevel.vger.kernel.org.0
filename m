Return-Path: <linux-fsdevel+bounces-50488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8A0ACC882
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B1B7A171A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD29233701;
	Tue,  3 Jun 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="AYrTttel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DC26290
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958830; cv=none; b=V/fMjcv6/0wrbx5pmYvaHvl3W/Vp0+XBpFcZyORukgkoK6QTEHgJjZfDYhTvxEt4pat1hTedSYUQuZ7Yj3YduIhn3ZZjbEPv4EmQJqCdCNQcijB1U1VT+BphbvPNIwt4xy1hrr0MEs7T+u43IDzkuEYFtgLB2ETfsoDqUtvod6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958830; c=relaxed/simple;
	bh=sz+4Ijtjmw3OPU2BAqK1+/QQYYRzFhTGmNiUTkfs14o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2STW/dPExihv01O0iMITVxiF6bet2oB6lN8YfyxAfHLR60yH69S4638Jfh9vmJKqayS5X7lWM3sMUUPNCERgyvZhAAvQCSuPZmnsC0q8tLxzRAfCNpMiU5eanAzlkEe8wqFrfSbw2ykGG9Y8SAiI+I8DQJfcz9HQmgbxXp1w7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=AYrTttel; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5534edc6493so2333156e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1748958825; x=1749563625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jxsm4yckOCTSiu+cFFqh17OeLncVglVzVijigk9EvSk=;
        b=AYrTttel9vooSFu3+Smrxkm4t+MlsrxQHaFQaNSkH4YTsU+AkEymscp1sbjcfPFOBl
         Uws7nGryUXjbA8f5TwJJpZe4HczISW5pMXqTINVsiBGS3SPFsQ1MyaObOW2ueVXiKyq1
         L763swfhGvhlUg9ZHdro1MKjxS9Ncyn34hrYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958825; x=1749563625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxsm4yckOCTSiu+cFFqh17OeLncVglVzVijigk9EvSk=;
        b=njJGSzzgxHa4z8BctbJUgIngcc3qxt2gys6xGs5LffvC9C7w89r8SfPJxmOjwrKKBj
         5s6e5W7TjDuojQP54H0eQrG3DjRCl+rR4wCEGkodM4quKAHOG/7+x79qKy8L4uQp/pmD
         mnJ8wk5tyeyNU/kGXIueOngiXjtShKZHIvFEt/5kkyUD52BQd38wMiTOtfkeW7ifoFk1
         LCStL3B77HqN0NZiANxoHyszRVkB6wrxMz9Kh8YZ/ZW72offdxXsd9Jd/DMFglb1sDO6
         /KdD0yogS+SgYQaWc9L2QH2/9E4MVMqoI1NvBtZT3NhTlYmbPApxyHnNBoHrI+dGa45W
         CZ7g==
X-Gm-Message-State: AOJu0YyQw1ig4JGHw0plZJ89ygiJgwQfSJhz1wpzgeLy/KrMteJs5VHQ
	UGmQ58Ghe87tkfzmSTPTcLOcCJxvmNwE8dd3MtWLYZLdTFMZS3Flt+ariIvENvIi5AoV/gFu+q0
	CLm4+P333lJ5Yj23QaB3AFNxzZ+hMWztxx/dkp0yfEQ==
X-Gm-Gg: ASbGncvu8tq3iJTaMpZMra/1MRx7g2+mIfD2dURMQdt/zL1+Vw+SOE+l8ADd9l2V/6w
	4LFh2Jk+fOMKyej5TBm5JUUj6JVQCBKmBG4V9nvdQjp/M5ibL0SrYjVS3DEeMNYyLCEFrL4/tb9
	N/ojMPokUqbZXSR/fVfLdoq9ZSL1rhzZrmWGFqQhdRHjq7
X-Google-Smtp-Source: AGHT+IF0KHphg7Ys07CdVI/7DuNqMspBjk+poLmS7iqB5BccOpeDBD0/HjJt4fXZRgpiJaODzpLnmsn7nlhTfreKYME=
X-Received: by 2002:a05:6512:1386:b0:553:2190:feee with SMTP id
 2adb3069b0e04-5533d14f1a2mr5133808e87.5.1748958824693; Tue, 03 Jun 2025
 06:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
 <20250603-work-coredump-socket-protocol-v2-5-05a5f0c18ecc@kernel.org>
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-5-05a5f0c18ecc@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 3 Jun 2025 15:53:31 +0200
X-Gm-Features: AX0GCFtGo1civCBrPmSMhKoq5ORM6ItEPdcpdLrXZbC4QNR5rwifJSNH1b43MLc
Message-ID: <CAJqdLrq+v3rmcTaQvRD_stmEtVDiGYiPLbyOyfTtiCSrDHyKWQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] selftests/coredump: add coredump server selftests
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 3. Juni 2025 um 15:32 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> This adds extensive tests for the coredump server.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/Makefile         |    2 +-
>  tools/testing/selftests/coredump/config           |    4 +
>  tools/testing/selftests/coredump/stackdump_test.c | 1291 ++++++++++++++++++++-
>  3 files changed, 1295 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/Makefile b/tools/testing/selftests/coredump/Makefile
> index bc287a85b825..77b3665c73c7 100644
> --- a/tools/testing/selftests/coredump/Makefile
> +++ b/tools/testing/selftests/coredump/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS = -Wall -O0 $(KHDR_INCLUDES)
> +CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>
>  TEST_GEN_PROGS := stackdump_test
>  TEST_FILES := stackdump
> diff --git a/tools/testing/selftests/coredump/config b/tools/testing/selftests/coredump/config
> new file mode 100644
> index 000000000000..6ce9610b06d0
> --- /dev/null
> +++ b/tools/testing/selftests/coredump/config
> @@ -0,0 +1,4 @@
> +CONFIG_AF_UNIX_OOB=y
> +CONFIG_COREDUMP=y
> +CONFIG_NET=y
> +CONFIG_UNIX=y
> diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
> index 4d922e5f89fe..ad0d5f271db1 100644
> --- a/tools/testing/selftests/coredump/stackdump_test.c
> +++ b/tools/testing/selftests/coredump/stackdump_test.c
> @@ -4,10 +4,15 @@
>  #include <fcntl.h>
>  #include <inttypes.h>
>  #include <libgen.h>
> +#include <limits.h>
> +#include <linux/coredump.h>
> +#include <linux/fs.h>
>  #include <linux/limits.h>
>  #include <pthread.h>
>  #include <string.h>
>  #include <sys/mount.h>
> +#include <poll.h>
> +#include <sys/epoll.h>
>  #include <sys/resource.h>
>  #include <sys/stat.h>
>  #include <sys/socket.h>
> @@ -15,6 +20,7 @@
>  #include <unistd.h>
>
>  #include "../kselftest_harness.h"
> +#include "../filesystems/wrappers.h"
>  #include "../pidfd/pidfd.h"
>
>  #define STACKDUMP_FILE "stack_values"
> @@ -49,14 +55,32 @@ FIXTURE(coredump)
>  {
>         char original_core_pattern[256];
>         pid_t pid_coredump_server;
> +       int fd_tmpfs_detached;
>  };
>
> +static int create_detached_tmpfs(void)
> +{
> +       int fd_context, fd_tmpfs;
> +
> +       fd_context = sys_fsopen("tmpfs", 0);
> +       if (fd_context < 0)
> +               return -1;
> +
> +       if (sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0) < 0)
> +               return -1;
> +
> +       fd_tmpfs = sys_fsmount(fd_context, 0, 0);
> +       close(fd_context);
> +       return fd_tmpfs;
> +}
> +
>  FIXTURE_SETUP(coredump)
>  {
>         FILE *file;
>         int ret;
>
>         self->pid_coredump_server = -ESRCH;
> +       self->fd_tmpfs_detached = -1;
>         file = fopen("/proc/sys/kernel/core_pattern", "r");
>         ASSERT_NE(NULL, file);
>
> @@ -65,6 +89,8 @@ FIXTURE_SETUP(coredump)
>         ASSERT_LT(ret, sizeof(self->original_core_pattern));
>
>         self->original_core_pattern[ret] = '\0';
> +       self->fd_tmpfs_detached = create_detached_tmpfs();
> +       ASSERT_GE(self->fd_tmpfs_detached, 0);
>
>         ret = fclose(file);
>         ASSERT_EQ(0, ret);
> @@ -103,6 +129,15 @@ FIXTURE_TEARDOWN(coredump)
>                 goto fail;
>         }
>
> +       if (self->fd_tmpfs_detached >= 0) {
> +               ret = close(self->fd_tmpfs_detached);
> +               if (ret < 0) {
> +                       reason = "Unable to close detached tmpfs";
> +                       goto fail;
> +               }
> +               self->fd_tmpfs_detached = -1;
> +       }
> +
>         return;
>  fail:
>         /* This should never happen */
> @@ -192,7 +227,7 @@ static int create_and_listen_unix_socket(const char *path)
>         if (ret < 0)
>                 goto out;
>
> -       ret = listen(fd, 1);
> +       ret = listen(fd, 128);
>         if (ret < 0)
>                 goto out;
>
> @@ -551,4 +586,1258 @@ TEST_F(coredump, socket_no_listener)
>         wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
>  }
>
> +int recv_oob_marker(int fd)
> +{
> +       uint8_t oob_marker;
> +       ssize_t ret;
> +
> +       ret = recv(fd, &oob_marker, 1, MSG_OOB);
> +       if (ret < 0)
> +               return -1;
> +       if (ret > 1 || ret == 0)
> +               return -EINVAL;
> +
> +       switch (oob_marker) {
> +       case COREDUMP_OOB_INVALIDSIZE:
> +               fprintf(stderr, "Received OOB marker: InvalidSize\n");
> +               return COREDUMP_OOB_INVALIDSIZE;
> +       case COREDUMP_OOB_UNSUPPORTED:
> +               fprintf(stderr, "Received OOB marker: Unsupported\n");
> +               return COREDUMP_OOB_UNSUPPORTED;
> +       case COREDUMP_OOB_CONFLICTING:
> +               fprintf(stderr, "Received OOB marker: Conflicting\n");
> +               return COREDUMP_OOB_CONFLICTING;
> +       default:
> +               fprintf(stderr, "Received unknown OOB marker: %u\n", oob_marker);
> +               break;
> +       }
> +       return -1;
> +}
> +
> +static bool is_msg_oob_supported(void)
> +{
> +       int sv[2];
> +       char c = 'X';
> +       int ret;
> +       static int supported = -1;
> +
> +       if (supported >= 0)
> +               return supported == 1;
> +
> +       if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
> +               return false;
> +
> +       ret = send(sv[0], &c, 1, MSG_OOB);
> +       close(sv[0]);
> +       close(sv[1]);
> +
> +       if (ret < 0) {
> +               if (errno == EINVAL || errno == EOPNOTSUPP) {
> +                       supported = 0;
> +                       return false;
> +               }
> +
> +               return false;
> +       }
> +       supported = 1;
> +       return true;
> +}
> +
> +static bool wait_for_oob_marker(int fd, enum coredump_oob oob_marker)
> +{
> +       ssize_t ret;
> +       struct pollfd pfd = {
> +               .fd = fd,
> +               .events = POLLPRI,
> +               .revents = 0,
> +       };
> +
> +       if (!is_msg_oob_supported())
> +               return true;
> +
> +       ret = poll(&pfd, 1, -1);
> +       if (ret < 0)
> +               return false;
> +       if (!(pfd.revents & POLLPRI))
> +               return false;
> +       if (pfd.revents & POLLERR)
> +               return false;
> +       if (pfd.revents & POLLHUP)
> +               return false;
> +
> +       ret = recv_oob_marker(fd);
> +       if (ret < 0)
> +               return false;
> +       return ret == oob_marker;
> +}
> +
> +static bool read_coredump_req(int fd, struct coredump_req *req)
> +{
> +       ssize_t ret;
> +       size_t field_size, user_size, ack_size, kernel_size, remaining_size;
> +
> +       memset(req, 0, sizeof(*req));
> +       field_size = sizeof(req->size);
> +
> +       /* Peek the size of the coredump request. */
> +       ret = recv(fd, req, field_size, MSG_PEEK | MSG_WAITALL);
> +       if (ret != field_size)
> +               return false;
> +       kernel_size = req->size;
> +
> +       if (kernel_size < COREDUMP_ACK_SIZE_VER0)
> +               return false;
> +       if (kernel_size >= PAGE_SIZE)
> +               return false;
> +
> +       /* Use the minimum of user and kernel size to read the full request. */
> +       user_size = sizeof(struct coredump_req);
> +       ack_size = user_size < kernel_size ? user_size : kernel_size;
> +       ret = recv(fd, req, ack_size, MSG_WAITALL);
> +       if (ret != ack_size)
> +               return false;
> +
> +       fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
> +               req->size, (unsigned long long)req->mask);
> +
> +       if (user_size > kernel_size)
> +               remaining_size = user_size - kernel_size;
> +       else
> +               remaining_size = kernel_size - user_size;
> +
> +       if (PAGE_SIZE <= remaining_size)
> +               return false;
> +
> +       /*
> +        * Discard any additional data if the kernel's request was larger than
> +        * what we knew about or cared about.
> +        */
> +       if (remaining_size) {
> +               char buffer[PAGE_SIZE];
> +
> +               ret = recv(fd, buffer, sizeof(buffer), MSG_WAITALL);
> +               if (ret != remaining_size)
> +                       return false;
> +               fprintf(stderr, "Discarded %zu bytes of non-OOB data after coredump request\n", remaining_size);
> +       }
> +
> +       return true;
> +}
> +
> +static bool send_coredump_ack(int fd, const struct coredump_req *req,
> +                             __u64 mask, size_t size_ack)
> +{
> +       ssize_t ret;
> +       /*
> +        * Wrap struct coredump_ack in a larger struct so we can
> +        * simulate sending to much data to the kernel.
> +        */
> +       struct large_ack_for_size_testing {
> +               struct coredump_ack ack;
> +               char buffer[PAGE_SIZE];
> +       } large_ack = {};
> +
> +       if (!size_ack)
> +               size_ack = sizeof(struct coredump_ack) < req->size_ack ?
> +                                  sizeof(struct coredump_ack) :
> +                                  req->size_ack;
> +       large_ack.ack.mask = mask;
> +       large_ack.ack.size = size_ack;
> +       ret = send(fd, &large_ack, size_ack, MSG_NOSIGNAL);
> +       if (ret != size_ack)
> +               return false;
> +
> +       fprintf(stderr, "Sent coredump ack with size %zu and mask 0x%llx\n",
> +               size_ack, (unsigned long long)mask);
> +       return true;
> +}
> +
> +static bool check_coredump_req(const struct coredump_req *req, size_t min_size,
> +                              __u64 required_mask)
> +{
> +       if (req->size < min_size)
> +               return false;
> +       if ((req->mask & required_mask) != required_mask)
> +               return false;
> +       if (req->mask & ~required_mask)
> +               return false;
> +       return true;
> +}
> +
> +TEST_F(coredump, socket_request_kernel)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct stat st;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               struct coredump_req req = {};
> +               int fd_server = -1, fd_coredump = -1, fd_core_file = -1, fd_peer_pidfd = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0)
> +                       goto out;
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +                       goto out;
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0)
> +                       goto out;
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0)
> +                       goto out;
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                       goto out;
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +                       goto out;
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +                       goto out;
> +
> +               fd_core_file = creat("/tmp/coredump.file", 0644);
> +               if (fd_core_file < 0)
> +                       goto out;
> +
> +               if (!read_coredump_req(fd_coredump, &req))
> +                       goto out;
> +
> +               if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                       COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                       goto out;
> +
> +               if (!send_coredump_ack(fd_coredump, &req,
> +                                      COREDUMP_KERNEL | COREDUMP_WAIT, 0))
> +                       goto out;
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read, bytes_write;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read < 0)
> +                               goto out;
> +
> +                       if (bytes_read == 0)
> +                               break;
> +
> +                       bytes_write = write(fd_core_file, buffer, bytes_read);
> +                       if (bytes_read != bytes_write)
> +                               goto out;
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
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
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +
> +       ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
> +       ASSERT_GT(st.st_size, 0);
> +       system("file /tmp/coredump.file");
> +}
> +
> +TEST_F(coredump, socket_request_userspace)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               struct coredump_req req = {};
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0)
> +                       goto out;
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +                       goto out;
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0)
> +                       goto out;
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0)
> +                       goto out;
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                       goto out;
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +                       goto out;
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +                       goto out;
> +
> +               if (!read_coredump_req(fd_coredump, &req))
> +                       goto out;
> +
> +               if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                       COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                       goto out;
> +
> +               if (!send_coredump_ack(fd_coredump, &req,
> +                                      COREDUMP_USERSPACE | COREDUMP_WAIT, 0))
> +                       goto out;
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read > 0)
> +                               goto out;
> +
> +                       if (bytes_read < 0)
> +                               goto out;
> +
> +                       if (bytes_read == 0)
> +                               break;
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
> +out:
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
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
> +TEST_F(coredump, socket_request_reject)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               struct coredump_req req = {};
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0)
> +                       goto out;
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +                       goto out;
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0)
> +                       goto out;
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0)
> +                       goto out;
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                       goto out;
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +                       goto out;
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +                       goto out;
> +
> +               if (!read_coredump_req(fd_coredump, &req))
> +                       goto out;
> +
> +               if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                       COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                       goto out;
> +
> +               if (!send_coredump_ack(fd_coredump, &req,
> +                                      COREDUMP_REJECT | COREDUMP_WAIT, 0))
> +                       goto out;
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read > 0)
> +                               goto out;
> +
> +                       if (bytes_read < 0)
> +                               goto out;
> +
> +                       if (bytes_read == 0)
> +                               break;
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
> +out:
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
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
> +TEST_F(coredump, socket_request_invalid_flag_combination)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               struct coredump_req req = {};
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0)
> +                       goto out;
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +                       goto out;
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0)
> +                       goto out;
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0)
> +                       goto out;
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                       goto out;
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +                       goto out;
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +                       goto out;
> +
> +               if (!read_coredump_req(fd_coredump, &req))
> +                       goto out;
> +
> +               if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                       COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                       goto out;
> +
> +               if (!send_coredump_ack(fd_coredump, &req,
> +                                      COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT, 0))
> +                       goto out;
> +
> +               if (!wait_for_oob_marker(fd_coredump, COREDUMP_OOB_CONFLICTING))
> +                       goto out;
> +
> +               exit_code = EXIT_SUCCESS;
> +out:
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
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
> +TEST_F(coredump, socket_request_unknown_flag)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               struct coredump_req req = {};
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0)
> +                       goto out;
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +                       goto out;
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0)
> +                       goto out;
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0)
> +                       goto out;
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                       goto out;
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +                       goto out;
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +                       goto out;
> +
> +               if (!read_coredump_req(fd_coredump, &req))
> +                       goto out;
> +
> +               if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                       COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                       goto out;
> +
> +               if (!send_coredump_ack(fd_coredump, &req, (1ULL << 63), 0))
> +                       goto out;
> +
> +               if (!wait_for_oob_marker(fd_coredump, COREDUMP_OOB_UNSUPPORTED))
> +                       goto out;
> +
> +               exit_code = EXIT_SUCCESS;
> +out:
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
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
> +TEST_F(coredump, socket_request_invalid_size_small)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               struct coredump_req req = {};
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0)
> +                       goto out;
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +                       goto out;
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0)
> +                       goto out;
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0)
> +                       goto out;
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                       goto out;
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +                       goto out;
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +                       goto out;
> +
> +               if (!read_coredump_req(fd_coredump, &req))
> +                       goto out;
> +
> +               if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                       COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                       goto out;
> +
> +               if (!send_coredump_ack(fd_coredump, &req,
> +                                      COREDUMP_REJECT | COREDUMP_WAIT,
> +                                      COREDUMP_ACK_SIZE_VER0 / 2))
> +                       goto out;
> +
> +               if (!wait_for_oob_marker(fd_coredump, COREDUMP_OOB_INVALIDSIZE))
> +                       goto out;
> +
> +               exit_code = EXIT_SUCCESS;
> +out:
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
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
> +TEST_F(coredump, socket_request_invalid_size_large)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               struct coredump_req req = {};
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0)
> +                       goto out;
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +                       goto out;
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0)
> +                       goto out;
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0)
> +                       goto out;
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                       goto out;
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +                       goto out;
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +                       goto out;
> +
> +               if (!read_coredump_req(fd_coredump, &req))
> +                       goto out;
> +
> +               if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                       COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                       COREDUMP_REJECT | COREDUMP_WAIT))
> +                       goto out;
> +
> +               if (!send_coredump_ack(fd_coredump, &req,
> +                                      COREDUMP_REJECT | COREDUMP_WAIT,
> +                                      COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE))
> +                       goto out;
> +
> +               if (!wait_for_oob_marker(fd_coredump, COREDUMP_OOB_INVALIDSIZE))
> +                       goto out;
> +
> +               exit_code = EXIT_SUCCESS;
> +out:
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
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
> +
> +static int open_coredump_tmpfile(int fd_tmpfs_detached)
> +{
> +       return openat(fd_tmpfs_detached, ".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
> +}
> +
> +#define NUM_CRASHING_COREDUMPS 5
> +
> +TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps, 500)
> +{
> +       int pidfd[NUM_CRASHING_COREDUMPS], status[NUM_CRASHING_COREDUMPS];
> +       pid_t pid[NUM_CRASHING_COREDUMPS], pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +
> +       ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
> +               int exit_code = EXIT_FAILURE;
> +               struct coredump_req req = {};
> +
> +               close(ipc_sockets[0]);
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "Failed to create and listen on unix socket\n");
> +                       goto out;
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "Failed to notify parent via ipc socket\n");
> +                       goto out;
> +               }
> +               close(ipc_sockets[1]);
> +
> +               for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
> +                       fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +                       if (fd_coredump < 0) {
> +                               fprintf(stderr, "accept4 failed: %m\n");
> +                               goto out;
> +                       }
> +
> +                       fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +                       if (fd_peer_pidfd < 0) {
> +                               fprintf(stderr, "get_peer_pidfd failed for fd %d: %m\n", fd_coredump);
> +                               goto out;
> +                       }
> +
> +                       if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                               fprintf(stderr, "get_pidfd_info failed for fd %d\n", fd_peer_pidfd);
> +                               goto out;
> +                       }
> +
> +                       if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                               fprintf(stderr, "pidfd info missing PIDFD_INFO_COREDUMP for fd %d\n", fd_peer_pidfd);
> +                               goto out;
> +                       }
> +                       if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                               fprintf(stderr, "pidfd info missing PIDFD_COREDUMPED for fd %d\n", fd_peer_pidfd);
> +                               goto out;
> +                       }
> +
> +                       if (!read_coredump_req(fd_coredump, &req)) {
> +                               fprintf(stderr, "read_coredump_req failed for fd %d\n", fd_coredump);
> +                               goto out;
> +                       }
> +
> +                       if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                               COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                               COREDUMP_REJECT | COREDUMP_WAIT)) {
> +                               fprintf(stderr, "check_coredump_req failed for fd %d\n", fd_coredump);
> +                               goto out;
> +                       }
> +
> +                       if (!send_coredump_ack(fd_coredump, &req,
> +                                              COREDUMP_KERNEL | COREDUMP_WAIT, 0)) {
> +                               fprintf(stderr, "send_coredump_ack failed for fd %d\n", fd_coredump);
> +                               goto out;
> +                       }
> +
> +                       fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
> +                       if (fd_core_file < 0) {
> +                               fprintf(stderr, "%m - open_coredump_tmpfile failed for fd %d\n", fd_coredump);
> +                               goto out;
> +                       }
> +
> +                       for (;;) {
> +                               char buffer[4096];
> +                               ssize_t bytes_read, bytes_write;
> +
> +                               bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                               if (bytes_read < 0) {
> +                                       fprintf(stderr, "read failed for fd %d: %m\n", fd_coredump);
> +                                       goto out;
> +                               }
> +
> +                               if (bytes_read == 0)
> +                                       break;
> +
> +                               bytes_write = write(fd_core_file, buffer, bytes_read);
> +                               if (bytes_read != bytes_write) {
> +                                       fprintf(stderr, "write failed for fd %d: %m\n", fd_core_file);
> +                                       goto out;
> +                               }
> +                       }
> +
> +                       close(fd_core_file);
> +                       close(fd_peer_pidfd);
> +                       close(fd_coredump);
> +                       fd_peer_pidfd = -1;
> +                       fd_coredump = -1;
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
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
> +       for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
> +               pid[i] = fork();
> +               ASSERT_GE(pid[i], 0);
> +               if (pid[i] == 0)
> +                       crashing_child();
> +               pidfd[i] = sys_pidfd_open(pid[i], 0);
> +               ASSERT_GE(pidfd[i], 0);
> +       }
> +
> +       for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
> +               waitpid(pid[i], &status[i], 0);
> +               ASSERT_TRUE(WIFSIGNALED(status[i]));
> +               ASSERT_TRUE(WCOREDUMP(status[i]));
> +       }
> +
> +       for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
> +               info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +               ASSERT_EQ(ioctl(pidfd[i], PIDFD_GET_INFO, &info), 0);
> +               ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +               ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +       }
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
> +#define MAX_EVENTS 128
> +
> +static void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file)
> +{
> +       int epfd = -1;
> +       int exit_code = EXIT_FAILURE;
> +
> +       epfd = epoll_create1(0);
> +       if (epfd < 0)
> +               goto out;
> +
> +       struct epoll_event ev;
> +       ev.events = EPOLLIN | EPOLLPRI | EPOLLRDHUP | EPOLLET;
> +       ev.data.fd = fd_coredump;
> +       if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0)
> +               goto out;
> +
> +       for (;;) {
> +               struct epoll_event events[1];
> +               int n = epoll_wait(epfd, events, 1, -1);
> +               if (n < 0)
> +                       break;
> +
> +               if (events[0].events & EPOLLPRI) {
> +                       uint8_t oob;
> +                       ssize_t oobret = recv(fd_coredump, &oob, 1, MSG_OOB);
> +                       if (oobret == 1) {
> +                               fprintf(stderr, "Worker: Received OOB marker %u on fd %d, aborting coredump\n", oob, fd_coredump);
> +                               break;
> +                       }
> +               }
> +               if (events[0].events & (EPOLLIN | EPOLLRDHUP)) {
> +                       for (;;) {
> +                               char buffer[4096];
> +                               ssize_t bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                               if (bytes_read < 0) {
> +                                       if (errno == EAGAIN || errno == EWOULDBLOCK)
> +                                               break;
> +                                       goto out;
> +                               }
> +                               if (bytes_read == 0)
> +                                       goto done;
> +                               ssize_t bytes_write = write(fd_core_file, buffer, bytes_read);
> +                               if (bytes_write != bytes_read)
> +                                       goto out;
> +                       }
> +               }
> +       }
> +
> +done:
> +       exit_code = EXIT_SUCCESS;
> +out:
> +       if (epfd >= 0)
> +               close(epfd);
> +       if (fd_core_file >= 0)
> +               close(fd_core_file);
> +       if (fd_peer_pidfd >= 0)
> +               close(fd_peer_pidfd);
> +       if (fd_coredump >= 0)
> +               close(fd_coredump);
> +       _exit(exit_code);
> +}
> +
> +TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
> +{
> +       int pidfd[NUM_CRASHING_COREDUMPS], status[NUM_CRASHING_COREDUMPS];
> +       pid_t pid[NUM_CRASHING_COREDUMPS], pid_coredump_server, worker_pids[NUM_CRASHING_COREDUMPS];
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
> +       ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server = -1, exit_code = EXIT_FAILURE, n_conns = 0;
> +               fd_server = -1;
> +               exit_code = EXIT_FAILURE;
> +               n_conns = 0;
> +               close(ipc_sockets[0]);
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0)
> +                       goto out;
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +                       goto out;
> +               close(ipc_sockets[1]);
> +
> +               while (n_conns < NUM_CRASHING_COREDUMPS) {
> +                       int fd_coredump = -1, fd_peer_pidfd = -1, fd_core_file = -1;
> +                       struct coredump_req req = {};
> +                       fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +                       if (fd_coredump < 0) {
> +                               if (errno == EAGAIN || errno == EWOULDBLOCK)
> +                                       continue;
> +                               goto out;
> +                       }
> +                       fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +                       if (fd_peer_pidfd < 0)
> +                               goto out;
> +                       if (!get_pidfd_info(fd_peer_pidfd, &info))
> +                               goto out;
> +                       if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED))
> +                               goto out;
> +                       if (!read_coredump_req(fd_coredump, &req))
> +                               goto out;
> +                       if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
> +                                               COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                               COREDUMP_REJECT | COREDUMP_WAIT))
> +                               goto out;
> +                       if (!send_coredump_ack(fd_coredump, &req, COREDUMP_KERNEL | COREDUMP_WAIT, 0))
> +                               goto out;
> +                       fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
> +                       if (fd_core_file < 0)
> +                               goto out;
> +                       pid_t worker = fork();
> +                       if (worker == 0) {
> +                               close(fd_server);
> +                               process_coredump_worker(fd_coredump, fd_peer_pidfd, fd_core_file);
> +                       }
> +                       worker_pids[n_conns] = worker;
> +                       if (fd_coredump >= 0)
> +                               close(fd_coredump);
> +                       if (fd_peer_pidfd >= 0)
> +                               close(fd_peer_pidfd);
> +                       if (fd_core_file >= 0)
> +                               close(fd_core_file);
> +                       n_conns++;
> +               }
> +               exit_code = EXIT_SUCCESS;
> +out:
> +               if (fd_server >= 0)
> +                       close(fd_server);
> +
> +               // Reap all worker processes
> +               for (int i = 0; i < n_conns; i++) {
> +                       int wstatus;
> +                       if (waitpid(worker_pids[i], &wstatus, 0) < 0) {
> +                               fprintf(stderr, "Failed to wait for worker %d: %m\n", worker_pids[i]);
> +                       } else if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != EXIT_SUCCESS) {
> +                               fprintf(stderr, "Worker %d exited with error code %d\n", worker_pids[i], WEXITSTATUS(wstatus));
> +                               exit_code = EXIT_FAILURE;
> +                       }
> +               }
> +
> +               _exit(exit_code);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
> +               pid[i] = fork();
> +               ASSERT_GE(pid[i], 0);
> +               if (pid[i] == 0)
> +                       crashing_child();
> +               pidfd[i] = sys_pidfd_open(pid[i], 0);
> +               ASSERT_GE(pidfd[i], 0);
> +       }
> +
> +       for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
> +               ASSERT_GE(waitpid(pid[i], &status[i], 0), 0);
> +               ASSERT_TRUE(WIFSIGNALED(status[i]));
> +               ASSERT_TRUE(WCOREDUMP(status[i]));
> +       }
> +
> +       for (int i = 0; i < NUM_CRASHING_COREDUMPS; i++) {
> +               info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +               ASSERT_EQ(ioctl(pidfd[i], PIDFD_GET_INFO, &info), 0);
> +               ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +               ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +       }
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.47.2
>

