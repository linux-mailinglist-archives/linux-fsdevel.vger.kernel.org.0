Return-Path: <linux-fsdevel+bounces-66904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E439BC30386
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7023BB45B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAFA3112D0;
	Tue,  4 Nov 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="P7VA6gwA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194228BAAC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247511; cv=none; b=fQJhWd1UjR4D4y16PM7t1I9QAObxYsOV9UaDjN7WPcsBK+bdBkQOnDU5LdKQKW1FBVm6Sguprr6kt2BN48pw/X1ET/8//1wxmfjMqc8NXFB77bI8dg1wAumc8xGHPBExTGPkavWb0NEDch9sKAZUyaVm324txpB77duggbucEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247511; c=relaxed/simple;
	bh=AHPqWzpPHwKAhaFT/OGB2thf7A8e70xCIaa3HlL2k1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDN6fgW2DnF/OFRXP4sw2+lwNL/dim4KGds6wPvSx6vCmVxPwMDGhCy9X7d6Z1mOsIG2D+PlfvmFkRz8lP5qq03jZzw/7JigHzodzHwA+XzptARSVNV4tqyaW+/l80cNLzDThESkkpk72Ewd5ZEwVjek9Pj8LHJdYJ3M6OsMTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=P7VA6gwA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-594330147efso1262812e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247508; x=1762852308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XgJorVCJuOR1wPzHzYV/7GJpyiQt6MPf1YxYv2yXZvw=;
        b=P7VA6gwArT1a8dAA4FUJbeFAwF4uZ8bBFxkiQ7FHSzWMyaXL+qxF6GDFm5MqAW+4cJ
         8On3uR9CVQQ5ZoatVhrHJI8t4pzS7Rvsowuf1Ut/YQZ419vL2S/rSFjzwPJTld9+q6Jn
         AZK8o5BjtBrwqeIg20W+0ViM1Wgtu823aCFsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247508; x=1762852308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgJorVCJuOR1wPzHzYV/7GJpyiQt6MPf1YxYv2yXZvw=;
        b=DIsfAZxcI/JfWa+v/2kAMufLphfkcoDthX6tNxjc4P9HtGQx55wHC5rJ1RtJc1vG+G
         3vOpNXfd5Y3HkQc+xVPyLZoXJSvZi8+pfh8wq/b1xmEo9QjuyGnGtmbb+sxE1PmenOaZ
         E+Sf6zz+E4Ri6n73qIWti+JIgUro2J8MukNJfzeC8ng5F0QesYYT+klB6lCl/RnMafkK
         LY6oCmZ8mrEuVzEn2hOvHB0TJpvzOnp85uCzfrCsJFi8ArQ63dmAu+k9l3UkhJ4ogoty
         pvGXOXwXoEblammM2chUVS9xC09xdq/FWfPJDPPm8kkF8+dXojT/lhPIgQDDBkh4eVaf
         Yd0A==
X-Gm-Message-State: AOJu0YyqjypmFwTZP0Q7Q4qJPTz1ShZfzY4IfUQnwIjmYPznbUqB+KRa
	DhFBFxROpP739y+nZ0s+1ikOwPL0OZE3RkWeRtpphDAj0gafeOLRtMHW1MFO5mbS+tYPdei/o5l
	SbYcnWPI7YrNPmo3Fzt9kRQQEXf+/rXe/YzxnlI9Hbw==
X-Gm-Gg: ASbGncufpdi/NW8xIJZLYi134N6yQe647+s6Nn22bthMHbr1mk4LNP80FjNb/EE07D0
	Wyaj4z2HRIAzFUWASIaCw7bfrx8iL8rKJyaQwJMOw78Of/hidvMxU+BdT1/DX5pWgLLnirQqja/
	iL5/xnnjzMQ1AyN43ntls19U2eUYJj+7TbZ9ve8a9bbWLkXntWJ1DFqdKimVKfQ5p8uQGZJQsvD
	Hax577YRU4H0plP7VJxC3JTIpbMDBx9bIiFxSiJkBraUDsgvOjdRfF07JTm
X-Google-Smtp-Source: AGHT+IH+qylmSr8S03hrVMglFYrPOb0XpdrL8Yj2JZp6G5EbDoXN6JiO/mPjXgK2gOsRyIYPj1wWm9g+Dvt2I5U8lnc=
X-Received: by 2002:a05:6512:10c4:b0:591:ec83:3183 with SMTP id
 2adb3069b0e04-5941d55ac00mr5364033e87.57.1762247507488; Tue, 04 Nov 2025
 01:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-12-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-12-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:11:35 +0100
X-Gm-Features: AWmQ_blQJR05UGPCVijv9Rfuv6GHtCq_NarAYr4bLWSeG6gHbbN8VVrBiYQWSvE
Message-ID: <CAJqdLroBTL42zoxKS3gb0NKBxjxG4evgEHMPr3AiEmz9kuW7tA@mail.gmail.com>
Subject: Re: [PATCH 12/22] selftests/coredump: split out common helpers
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

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> into separate files.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/coredump_test.h   |  59 ++++
>  .../selftests/coredump/coredump_test_helpers.c     | 340 +++++++++++++++++++++
>  2 files changed, 399 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
> new file mode 100644
> index 000000000000..ed47f01fa53c
> --- /dev/null
> +++ b/tools/testing/selftests/coredump/coredump_test.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __COREDUMP_TEST_H
> +#define __COREDUMP_TEST_H
> +
> +#include <stdbool.h>
> +#include <sys/types.h>
> +#include <linux/coredump.h>
> +
> +#include "../kselftest_harness.h"
> +#include "../pidfd/pidfd.h"
> +
> +#ifndef PAGE_SIZE
> +#define PAGE_SIZE 4096
> +#endif
> +
> +#define NUM_THREAD_SPAWN 128
> +
> +/* Coredump fixture */
> +FIXTURE(coredump)
> +{
> +       char original_core_pattern[256];
> +       pid_t pid_coredump_server;
> +       int fd_tmpfs_detached;
> +};
> +
> +/* Shared helper function declarations */
> +void *do_nothing(void *arg);
> +void crashing_child(void);
> +int create_detached_tmpfs(void);
> +int create_and_listen_unix_socket(const char *path);
> +bool set_core_pattern(const char *pattern);
> +int get_peer_pidfd(int fd);
> +bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
> +
> +/* Inline helper that uses harness types */
> +static inline void wait_and_check_coredump_server(pid_t pid_coredump_server,
> +                                                  struct __test_metadata *const _metadata,
> +                                                  FIXTURE_DATA(coredump) *self)
> +{
> +       int status;
> +       waitpid(pid_coredump_server, &status, 0);
> +       self->pid_coredump_server = -ESRCH;
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +}
> +
> +/* Protocol helper function declarations */
> +ssize_t recv_marker(int fd);
> +bool read_marker(int fd, enum coredump_mark mark);
> +bool read_coredump_req(int fd, struct coredump_req *req);
> +bool send_coredump_ack(int fd, const struct coredump_req *req,
> +                      __u64 mask, size_t size_ack);
> +bool check_coredump_req(const struct coredump_req *req, size_t min_size,
> +                       __u64 required_mask);
> +int open_coredump_tmpfile(int fd_tmpfs_detached);
> +void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
> +
> +#endif /* __COREDUMP_TEST_H */
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> new file mode 100644
> index 000000000000..7512a8ef73d3
> --- /dev/null
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <assert.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <linux/coredump.h>
> +#include <linux/fs.h>
> +#include <pthread.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/epoll.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/un.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "../filesystems/wrappers.h"
> +#include "../pidfd/pidfd.h"
> +
> +/* Forward declarations to avoid including harness header */
> +struct __test_metadata;
> +
> +/* Match the fixture definition from coredump_test.h */
> +struct _fixture_coredump_data {
> +       char original_core_pattern[256];
> +       pid_t pid_coredump_server;
> +       int fd_tmpfs_detached;
> +};
> +
> +#ifndef PAGE_SIZE
> +#define PAGE_SIZE 4096
> +#endif
> +
> +#define NUM_THREAD_SPAWN 128
> +
> +void *do_nothing(void *arg)
> +{
> +       (void)arg;
> +       while (1)
> +               pause();
> +
> +       return NULL;
> +}
> +
> +void crashing_child(void)
> +{
> +       pthread_t thread;
> +       int i;
> +
> +       for (i = 0; i < NUM_THREAD_SPAWN; ++i)
> +               pthread_create(&thread, NULL, do_nothing, NULL);
> +
> +       /* crash on purpose */
> +       i = *(int *)NULL;
> +}
> +
> +int create_detached_tmpfs(void)
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
> +int create_and_listen_unix_socket(const char *path)
> +{
> +       struct sockaddr_un addr = {
> +               .sun_family = AF_UNIX,
> +       };
> +       assert(strlen(path) < sizeof(addr.sun_path) - 1);
> +       strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
> +       size_t addr_len =
> +               offsetof(struct sockaddr_un, sun_path) + strlen(path) + 1;
> +       int fd, ret;
> +
> +       fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +       if (fd < 0)
> +               goto out;
> +
> +       ret = bind(fd, (const struct sockaddr *)&addr, addr_len);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret = listen(fd, 128);
> +       if (ret < 0)
> +               goto out;
> +
> +       return fd;
> +
> +out:
> +       if (fd >= 0)
> +               close(fd);
> +       return -1;
> +}
> +
> +bool set_core_pattern(const char *pattern)
> +{
> +       int fd;
> +       ssize_t ret;
> +
> +       fd = open("/proc/sys/kernel/core_pattern", O_WRONLY | O_CLOEXEC);
> +       if (fd < 0)
> +               return false;
> +
> +       ret = write(fd, pattern, strlen(pattern));
> +       close(fd);
> +       if (ret < 0)
> +               return false;
> +
> +       fprintf(stderr, "Set core_pattern to '%s' | %zu == %zu\n", pattern, ret, strlen(pattern));
> +       return ret == strlen(pattern);
> +}
> +
> +int get_peer_pidfd(int fd)
> +{
> +       int fd_peer_pidfd;
> +       socklen_t fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
> +       int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd,
> +                            &fd_peer_pidfd_len);
> +       if (ret < 0) {
> +               fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
> +               return -1;
> +       }
> +       return fd_peer_pidfd;
> +}
> +
> +bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
> +{
> +       memset(info, 0, sizeof(*info));
> +       info->mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
> +       return ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info) == 0;
> +}
> +
> +/* Protocol helper functions */
> +
> +ssize_t recv_marker(int fd)
> +{
> +       enum coredump_mark mark = COREDUMP_MARK_REQACK;
> +       ssize_t ret;
> +
> +       ret = recv(fd, &mark, sizeof(mark), MSG_WAITALL);
> +       if (ret != sizeof(mark))
> +               return -1;
> +
> +       switch (mark) {
> +       case COREDUMP_MARK_REQACK:
> +               fprintf(stderr, "Received marker: ReqAck\n");
> +               return COREDUMP_MARK_REQACK;
> +       case COREDUMP_MARK_MINSIZE:
> +               fprintf(stderr, "Received marker: MinSize\n");
> +               return COREDUMP_MARK_MINSIZE;
> +       case COREDUMP_MARK_MAXSIZE:
> +               fprintf(stderr, "Received marker: MaxSize\n");
> +               return COREDUMP_MARK_MAXSIZE;
> +       case COREDUMP_MARK_UNSUPPORTED:
> +               fprintf(stderr, "Received marker: Unsupported\n");
> +               return COREDUMP_MARK_UNSUPPORTED;
> +       case COREDUMP_MARK_CONFLICTING:
> +               fprintf(stderr, "Received marker: Conflicting\n");
> +               return COREDUMP_MARK_CONFLICTING;
> +       default:
> +               fprintf(stderr, "Received unknown marker: %u\n", mark);
> +               break;
> +       }
> +       return -1;
> +}
> +
> +bool read_marker(int fd, enum coredump_mark mark)
> +{
> +       ssize_t ret;
> +
> +       ret = recv_marker(fd);
> +       if (ret < 0)
> +               return false;
> +       return ret == mark;
> +}
> +
> +bool read_coredump_req(int fd, struct coredump_req *req)
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
> +               fprintf(stderr, "Discarded %zu bytes of data after coredump request\n", remaining_size);
> +       }
> +
> +       return true;
> +}
> +
> +bool send_coredump_ack(int fd, const struct coredump_req *req,
> +                      __u64 mask, size_t size_ack)
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
> +bool check_coredump_req(const struct coredump_req *req, size_t min_size,
> +                       __u64 required_mask)
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
> +int open_coredump_tmpfile(int fd_tmpfs_detached)
> +{
> +       return openat(fd_tmpfs_detached, ".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
> +}
> +
> +void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file)
> +{
> +       int epfd = -1;
> +       int exit_code = EXIT_FAILURE;
> +       struct epoll_event ev;
> +
> +       epfd = epoll_create1(0);
> +       if (epfd < 0)
> +               goto out;
> +
> +       ev.events = EPOLLIN | EPOLLRDHUP | EPOLLET;
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
>
> --
> 2.47.3
>

