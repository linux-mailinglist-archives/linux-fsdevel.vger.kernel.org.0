Return-Path: <linux-fsdevel+bounces-66909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7AC30483
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F64D3B3078
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088572264DB;
	Tue,  4 Nov 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="FrBR2f7D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609552356D9
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247606; cv=none; b=nxhBLXfaQcnQjUo5PSBA/6E4E+yH9QRS796rfdMw6ZHfW9hK2hqybqzsDwuM/w3gqUcir7TF+GX5cAPpMwXA8u9r6KUZAPbdKkxfJCnjVMCE315vsSQFKYla1fcW6piOgnBhYlj1eNmYaPXVrIcuduAB0ymaXtAW6MwLx/bk8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247606; c=relaxed/simple;
	bh=ehXOSlokC20bIBLdoni9PsRvN8h14azKPpnSVKqbVkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzkPTsckp6Cml1bOg/G7mocdoTHP5KQE/S/uW7mMd+S05tomjAk8Nk0yFdhM1zAhZrmrwkENIwjEtHjWmFeR6hwF0M8dvPW5JHIwomhxcumUwFa6OqFLCpJS03d4cNYqvFHeC5Z02oorPnw8YLFxsTnO48c1lVFRX95rhKpVyrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=FrBR2f7D; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59435d82c1fso328532e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247601; x=1762852401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbTpJ2kd0vtcHnRXRerhpDDb9m7VWCKBi2OT36dhbVo=;
        b=FrBR2f7DUfJiIem2YSez54O6uhJuJNN6K4m2YavvSG7v2VNsnpw/CEMgqbvpJK3OrK
         jdji97ABfUpcWxHaBgZWLWksc1S6pMggiz8Q9X7r0uMN7bgdbX2Y9em+BQkKSdsC/rth
         o1mp7dm2QVntzfRcbtKkIhzLTRh2G0zubatYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247601; x=1762852401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbTpJ2kd0vtcHnRXRerhpDDb9m7VWCKBi2OT36dhbVo=;
        b=UsnnyoPn46p46IE9W8IGgs9cjUiY1rlpxpFoAmuEQCyXErvchb1gweMbi2YzqPvQbU
         l5eARyzfNW60Y4bau6aLr8HF9LeRyhpgmmLrR+m6jQBFIbH0ZdDmxXOxCMkJwhW/l0n4
         vel7HgIgPrjw86U60+WltaambvWsMRPF8IKOb0bnWfFysNpi5HOr9pA9AK//m8W3S2Me
         EvNk9XxBggyxrhqZOippdweHwx/hq5D10pWV0zZPTdwhTOyqoiVj+yDXNnB0HE65qpZc
         meaNadQXBhH0QFRx/29U2FgqXcBapaRX1w8YjxpJdSDHos/gxes7Q/lFu4OtKVHgncRJ
         aGAw==
X-Gm-Message-State: AOJu0YzWF1fP4mRKfqsmm4YNHDTvCfXUAl2Cyk2dEk+ZfboyD1jjhK3X
	m4HC90Qp3oxhqXZpdwQF69GlX7eM3dkMBDIXXnxHk0esAzSuuiO0fptq24dddK6CJApKtYiUmuo
	wLp4qCthy1iJXAUVC+AdKZw7YBtEn+5nRqTGtTDIcp59At0L201ym2qeCd/gNWqk=
X-Gm-Gg: ASbGncsIQS60+l3ucBAC+vKo5OkP/gK5F3eS6DqRvAlmG6tPR5KhJAY5NGaevCNgZfs
	IjPoCy/d0UBWEo/dW0kzrLTeCuWxJE290vD5Nk6yz6eS6lDCRuO1xHU9rDD62WH+uEYtqGWfPkl
	K5+QNeNaI8QjJa6+NJrZR44d1ZR7iRablR9kHJ1Oajt3hwsEaoh17lynVxkZ9MjE+r9W2XAldSU
	hXFZkaF2HsPUXCnxYru3E9LxWnRJLFXhXVaNqxqalfHNXZ2WZ45xy68+8s7
X-Google-Smtp-Source: AGHT+IHLWOjQzOq4EZEexl1y0s5TIFbR+H99TnsmW8bcHc62dykPOU9F431Ol1GwHd2wZKuQvjGDL9rD6FA5jNk+Oqo=
X-Received: by 2002:ac2:4c4f:0:b0:57e:c1e6:ba8 with SMTP id
 2adb3069b0e04-5941d50dcbcmr5053378e87.12.1762247601332; Tue, 04 Nov 2025
 01:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-17-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-17-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:13:08 +0100
X-Gm-Features: AWmQ_bn8XS0POXmBLNCfkFpdbJSrLm2S0Y6hVDKz6kn0uAZYZj2a91Sws73mBO4
Message-ID: <CAJqdLroCjAwveicSftrf9BjCSZUdR3X_oG3pvkV-_cWuP4qfAA@mail.gmail.com>
Subject: Re: [PATCH 17/22] selftests/coredump: add debug logging to test helpers
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
> so we can easily figure out why something failed.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  .../selftests/coredump/coredump_test_helpers.c     | 55 +++++++++++++++++-----
>  1 file changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 116c797090a1..65deb3cfbe1b 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -131,17 +131,26 @@ int get_peer_pidfd(int fd)
>         int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd,
>                              &fd_peer_pidfd_len);
>         if (ret < 0) {
> -               fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
> +               fprintf(stderr, "get_peer_pidfd: getsockopt(SO_PEERPIDFD) failed: %m\n");
>                 return -1;
>         }
> +       fprintf(stderr, "get_peer_pidfd: successfully retrieved pidfd %d\n", fd_peer_pidfd);
>         return fd_peer_pidfd;
>  }
>
>  bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
>  {
> +       int ret;
>         memset(info, 0, sizeof(*info));
>         info->mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
> -       return ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info) == 0;
> +       ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, info);
> +       if (ret < 0) {
> +               fprintf(stderr, "get_pidfd_info: ioctl(PIDFD_GET_INFO) failed: %m\n");
> +               return false;
> +       }
> +       fprintf(stderr, "get_pidfd_info: mask=0x%llx, coredump_mask=0x%x, coredump_signal=%d\n",
> +               (unsigned long long)info->mask, info->coredump_mask, info->coredump_signal);
> +       return true;
>  }
>
>  /* Protocol helper functions */
> @@ -198,14 +207,23 @@ bool read_coredump_req(int fd, struct coredump_req *req)
>
>         /* Peek the size of the coredump request. */
>         ret = recv(fd, req, field_size, MSG_PEEK | MSG_WAITALL);
> -       if (ret != field_size)
> +       if (ret != field_size) {
> +               fprintf(stderr, "read_coredump_req: peek failed (got %zd, expected %zu): %m\n",
> +                       ret, field_size);
>                 return false;
> +       }
>         kernel_size = req->size;
>
> -       if (kernel_size < COREDUMP_ACK_SIZE_VER0)
> +       if (kernel_size < COREDUMP_ACK_SIZE_VER0) {
> +               fprintf(stderr, "read_coredump_req: kernel_size %zu < min %d\n",
> +                       kernel_size, COREDUMP_ACK_SIZE_VER0);
>                 return false;
> -       if (kernel_size >= PAGE_SIZE)
> +       }
> +       if (kernel_size >= PAGE_SIZE) {
> +               fprintf(stderr, "read_coredump_req: kernel_size %zu >= PAGE_SIZE %d\n",
> +                       kernel_size, PAGE_SIZE);
>                 return false;
> +       }
>
>         /* Use the minimum of user and kernel size to read the full request. */
>         user_size = sizeof(struct coredump_req);
> @@ -295,25 +313,35 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
>
>         /* Set socket to non-blocking mode for edge-triggered epoll */
>         flags = fcntl(fd_coredump, F_GETFL, 0);
> -       if (flags < 0)
> +       if (flags < 0) {
> +               fprintf(stderr, "Worker: fcntl(F_GETFL) failed: %m\n");
>                 goto out;
> -       if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0)
> +       }
> +       if (fcntl(fd_coredump, F_SETFL, flags | O_NONBLOCK) < 0) {
> +               fprintf(stderr, "Worker: fcntl(F_SETFL, O_NONBLOCK) failed: %m\n");
>                 goto out;
> +       }
>
>         epfd = epoll_create1(0);
> -       if (epfd < 0)
> +       if (epfd < 0) {
> +               fprintf(stderr, "Worker: epoll_create1() failed: %m\n");
>                 goto out;
> +       }
>
>         ev.events = EPOLLIN | EPOLLRDHUP | EPOLLET;
>         ev.data.fd = fd_coredump;
> -       if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0)
> +       if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd_coredump, &ev) < 0) {
> +               fprintf(stderr, "Worker: epoll_ctl(EPOLL_CTL_ADD) failed: %m\n");
>                 goto out;
> +       }
>
>         for (;;) {
>                 struct epoll_event events[1];
>                 int n = epoll_wait(epfd, events, 1, -1);
> -               if (n < 0)
> +               if (n < 0) {
> +                       fprintf(stderr, "Worker: epoll_wait() failed: %m\n");
>                         break;
> +               }
>
>                 if (events[0].events & (EPOLLIN | EPOLLRDHUP)) {
>                         for (;;) {
> @@ -322,19 +350,24 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
>                                 if (bytes_read < 0) {
>                                         if (errno == EAGAIN || errno == EWOULDBLOCK)
>                                                 break;
> +                                       fprintf(stderr, "Worker: read() failed: %m\n");
>                                         goto out;
>                                 }
>                                 if (bytes_read == 0)
>                                         goto done;
>                                 ssize_t bytes_write = write(fd_core_file, buffer, bytes_read);
> -                               if (bytes_write != bytes_read)
> +                               if (bytes_write != bytes_read) {
> +                                       fprintf(stderr, "Worker: write() failed (read=%zd, write=%zd): %m\n",
> +                                               bytes_read, bytes_write);
>                                         goto out;
> +                               }
>                         }
>                 }
>         }
>
>  done:
>         exit_code = EXIT_SUCCESS;
> +       fprintf(stderr, "Worker: completed successfully\n");
>  out:
>         if (epfd >= 0)
>                 close(epfd);
>
> --
> 2.47.3
>

