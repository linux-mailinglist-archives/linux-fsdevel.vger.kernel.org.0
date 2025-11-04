Return-Path: <linux-fsdevel+bounces-66910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC16AC303BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1784189019B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6303329C48;
	Tue,  4 Nov 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="fYHehwHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81D313548
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247615; cv=none; b=IKEvcC9dvex5ulE8DBdVEFbrcZxZc2Z6Qdqfb/b4WPE8noLJPfA7FJjEPNpGSbn/MSMNStkukvDq7Sgu9igSw5Ps1ehp85uBQ+2SQq8bpTUCCUKYGEqgC6Jw76ZQ4ygE/vvstZOIcAKHmz+Fp9qesBtohLy/23UYRkvuK69vosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247615; c=relaxed/simple;
	bh=X3saQ01HvAadyE0U0yxTSLkzNUPaSlSNgq7Nvk1Fyr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKXLsmyZQernpFOHPSWfT12QBUx04lDK7a2UXKqmTdAcMxhLxGkuy+zAdAnQE4X6J0d8oEiXz9iZlRZjhqwie2LFfhZvqhOjm7HKXSsI6h1fyqC4b8ktSNILvBBUFL2HsfJYizrdg+p42UYSxIdiKBraj35ggKVZUe6R+6tflG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=fYHehwHJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594285c6509so2161212e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247611; x=1762852411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yC5ZbkKSZm/d/xkH+mRhsiaCkR8T/+9iGxUGIpCNOpo=;
        b=fYHehwHJWuLJe3Dc/x7jQssgEh90WPjJ3LXvxt0B0QfG6DuunS2XucREt6PQ9hYXXM
         gmwSyEvPfYjwJPeULvl0C5HpOhyXToP9tNd9q9whdcWOVfdthblSQ8jJXiqTFqjc0nkR
         MBOyE83zdlFwASkoox6dmyQKM3w/4UbIW36A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247611; x=1762852411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yC5ZbkKSZm/d/xkH+mRhsiaCkR8T/+9iGxUGIpCNOpo=;
        b=Z0OiRNzJjBaHxeOtQABHGITHHU6EvgZO/p7vec1IACNfkUdi4bWV2tqh9cplrEtbMM
         AQa+IKeyytfnusA0D59pQmq0hsUySlX/LfRZRWtt/Q7nRELtqrljgAvLWziFIN7kea/d
         sJu9FkqegaUolzH2KeDG0VIcQzkCSJ8BGW687U54KmN6rnxyOIPL/sn0SP1Lj/aoadqI
         CX+eUF5Z7OBn06Y3VpQS0hRX5yLVmQssC5Mr2xREm3whcN0pTVhyjOCDEo1ufUWUIdkW
         CkSInT8VIleWr2vVjwKC1h43pAe4qTwQjtr3dDZo6CTDaZSythnB873iSmalG9ptNcK8
         L1dA==
X-Gm-Message-State: AOJu0YwQhBUbCUG9h4ZvyisOCvvdrmqiLTL6zTt+CsfJPJYlzTHKaLE2
	BpywkD2PYDfrHWc1I8i3SpGgwtVOSP1iw4RGMUZiAeZuFz5GsPw9rWccwiYxagvT8OaTSymfEJ7
	udUAT1ua/vIOijAhC1Xqc5TCX3nslITXYMDMeRsIJhA==
X-Gm-Gg: ASbGncvN6eHLVY6Z7ZE2VKQH9BKfjKc+urx1C/R6k/BzhzZXqwrPrs4Q4kQW623C4Rh
	DqFqyAjBSPpau/c8ujtnsuBuaLxD55KBbvUApCZI3sGwnzv9sGvchgxb8BF9rnZKtnEHxKejl8q
	nJEjSCFuwV9bBbJhdyXIyawM+KR0NL7awMVdJSyI8iBDaoQ6RRVbniGDMzkb6XmOz1C7FKGajPC
	qkBuloM1jFfuoSHZEbWIUQDAcD2+zQB+LjyRowAQJTBFOFKCHTg1a4mU9oUZpG/kK/5dU4=
X-Google-Smtp-Source: AGHT+IHmEn+S+vJ02GNEiM+x2ag5QTVD0QFKLXPxHM6pgjwcpgFALU+ffxa+ka06Oxk3WmhLU61d1LG5jGxn7fZgGh4=
X-Received: by 2002:a05:6512:3f06:b0:592:f6ec:112c with SMTP id
 2adb3069b0e04-5941d5827bdmr6234166e87.55.1762247611189; Tue, 04 Nov 2025
 01:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-18-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-18-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:13:18 +0100
X-Gm-Features: AWmQ_bnwJcjiJfpzJo_3tQPvegRV8ps1oOm0HCWWp98H0G31lwRhyHQCEYGdwIY
Message-ID: <CAJqdLrrba2RtnojjWTU0=KZ1HBnNEs+9m4+5SuOkqGB9fn83QQ@mail.gmail.com>
Subject: Re: [PATCH 18/22] selftests/coredump: add debug logging to coredump
 socket tests
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
> So it's easier to figure out bugs.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  .../selftests/coredump/coredump_socket_test.c      | 93 +++++++++++++++++-----
>  1 file changed, 71 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 5103d9f13003..0a37d0456672 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -98,52 +98,74 @@ TEST_F(coredump, socket)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket test: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket test: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket test: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket test: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket test: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket test: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (!(info.coredump_mask & PIDFD_COREDUMPED))
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "socket test: PIDFD_COREDUMPED not set in coredump_mask\n");
>                         goto out;
> +               }
>
>                 fd_core_file = creat("/tmp/coredump.file", 0644);
> -               if (fd_core_file < 0)
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "socket test: creat coredump file failed: %m\n");
>                         goto out;
> +               }
>
>                 for (;;) {
>                         char buffer[4096];
>                         ssize_t bytes_read, bytes_write;
>
>                         bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> -                       if (bytes_read < 0)
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket test: read from coredump socket failed: %m\n");
>                                 goto out;
> +                       }
>
>                         if (bytes_read == 0)
>                                 break;
>
>                         bytes_write = write(fd_core_file, buffer, bytes_read);
> -                       if (bytes_read != bytes_write)
> +                       if (bytes_read != bytes_write) {
> +                               fprintf(stderr, "socket test: write to core file failed (read=%zd, write=%zd): %m\n",
> +                                       bytes_read, bytes_write);
>                                 goto out;
> +                       }
>                 }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket test: completed successfully\n");
>  out:
>                 if (fd_core_file >= 0)
>                         close(fd_core_file);
> @@ -208,32 +230,47 @@ TEST_F(coredump, socket_detect_userspace_client)
>                 close(ipc_sockets[0]);
>
>                 fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client: create_and_listen_unix_socket failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 close(ipc_sockets[1]);
>
>                 fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> -               if (fd_coredump < 0)
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client: accept4 failed: %m\n");
>                         goto out;
> +               }
>
>                 fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> -               if (fd_peer_pidfd < 0)
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client: get_peer_pidfd failed\n");
>                         goto out;
> +               }
>
> -               if (!get_pidfd_info(fd_peer_pidfd, &info))
> +               if (!get_pidfd_info(fd_peer_pidfd, &info)) {
> +                       fprintf(stderr, "socket_detect_userspace_client: get_pidfd_info failed\n");
>                         goto out;
> +               }
>
> -               if (!(info.mask & PIDFD_INFO_COREDUMP))
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "socket_detect_userspace_client: PIDFD_INFO_COREDUMP not set in mask\n");
>                         goto out;
> +               }
>
> -               if (info.coredump_mask & PIDFD_COREDUMPED)
> +               if (info.coredump_mask & PIDFD_COREDUMPED) {
> +                       fprintf(stderr, "socket_detect_userspace_client: PIDFD_COREDUMPED incorrectly set (should be userspace client)\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_detect_userspace_client: completed successfully\n");
>  out:
>                 if (fd_peer_pidfd >= 0)
>                         close(fd_peer_pidfd);
> @@ -263,15 +300,20 @@ TEST_F(coredump, socket_detect_userspace_client)
>                         sizeof("/tmp/coredump.socket");
>
>                 fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
> -               if (fd_socket < 0)
> +               if (fd_socket < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client (client): socket failed: %m\n");
>                         _exit(EXIT_FAILURE);
> +               }
>
>                 ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       fprintf(stderr, "socket_detect_userspace_client (client): connect failed: %m\n");
>                         _exit(EXIT_FAILURE);
> +               }
>
>                 close(fd_socket);
>                 pause();
> +               fprintf(stderr, "socket_detect_userspace_client (client): completed successfully\n");
>                 _exit(EXIT_SUCCESS);
>         }
>
> @@ -342,17 +384,24 @@ TEST_F(coredump, socket_no_listener)
>                 close(ipc_sockets[0]);
>
>                 fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> -               if (fd_server < 0)
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_no_listener: socket failed: %m\n");
>                         goto out;
> +               }
>
>                 ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       fprintf(stderr, "socket_no_listener: bind failed: %m\n");
>                         goto out;
> +               }
>
> -               if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_no_listener: write_nointr to ipc socket failed: %m\n");
>                         goto out;
> +               }
>
>                 exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_no_listener: completed successfully\n");
>  out:
>                 if (fd_server >= 0)
>                         close(fd_server);
>
> --
> 2.47.3
>

