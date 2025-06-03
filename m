Return-Path: <linux-fsdevel+bounces-50485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A9DACC87A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B205D17520A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56488238C27;
	Tue,  3 Jun 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="TC11JgFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ABC239085
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958715; cv=none; b=LziNnXpvuKprTkYXsRosO0b8yqPlhumTZ1t/b8AR69B737qpUc7X8+q0hVD18pP18apab0rSCLdy5vo/oH52AX17mcX+RE7u+Z03MCCQDLyV/od7uAnmh54NHBiXv51kUpotGm/sPPsZqj3mesKnS7TX2GZ6JQ+sjm0n021zS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958715; c=relaxed/simple;
	bh=ptuarA4z+kiYIuNgkjdP2y5XwmOnDy1pnNjbTmkFCZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1PgdIjY14kULA5mknHd8V65oD8ecBR/J4e2DzBlqoQJnd6dYWL9NkYjXb7nYmMttBAYVVKIOl2gCPgMgCiVaGurW6LXSrtffnvJW1/5h0ZPXgRQuYdKdePiSCy1Brf1yJNPB/NRaa72LjEEiiaW/rV7VfEg05yF8x9IY3GRnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=TC11JgFG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55320ddb9edso6092442e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1748958712; x=1749563512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EUmys8Y0oKS9U4Lj6BnBwVWUkygcOs9KYbv+qjegSf8=;
        b=TC11JgFGbWigd1aL/ChKghdXxPU2e6Oua708GcsXY12RGG+/XEMCGVf4IPOavps0oO
         GcYLhwTIn0pAz2uiWBa3YzMnaJUWgJMOXR10XYS95i/bH0egVB4j/0sQbh13svK2KzAe
         KhSH3oOP1wsCsaTH3tQWnVBWtuMqyyeilzHhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958712; x=1749563512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUmys8Y0oKS9U4Lj6BnBwVWUkygcOs9KYbv+qjegSf8=;
        b=EXXJ0/KUv3lxAjlgXGLMofYn68IGTYSSEuxnayZtQB4kSwArNMOh/A/6xn8q8003YJ
         NUJHOQPiPvfhe9Apxh+F2aMW1PlxZWa3zvE2Tfjn+KhoYNnIc3P7Qp30CVn2R2ffAJgS
         eIva0JHyzPE5BpYxpZ23ZihclxfxTRaoIljGD1dvXwlUgwnddxS+pPRtxfi4Yqxx793+
         Xc+/qKS3s0f7R4GNVLo+uhKos3Cpizwx63rwtuYHBGetNUDpg6bD/mELMSvhZoH7cPV2
         SbgHTMhYUxXsQq0ndhR7can8H1fZ6moXFpIRZ/M6mkvSqKsY92QxiMr1FxWRxC7sFPxk
         z+Xw==
X-Gm-Message-State: AOJu0Yx5Ci4BOLCNrbgPuii3IGTj5HiZygHi2UXHNwbfMG8btJ0A9WLs
	nLvGThBW4Gef8CUDfvPuSdDC3fDH0J1ijoQpQfH26Jl2ILUU0AxWMBkj20fjclSetYK4ob8cf+T
	6z1KssEjtIfaD/kkKwx09o12PIzHTPAGJc5QlejI7OcTN0c7H/uPB3v4yrw==
X-Gm-Gg: ASbGncvFmrr1C0g70G80mfZ1ZncWU7Ne+h7k50Y+hid+EADeTuZJjg+xxkXKxuTPI10
	EX8nlisrWVTEHzdP3bpy5f02AJdbDIaVHNH2DUEm+ysQzWxahBv7eMI79/ScflwTRz6WQxPS0gd
	nSC//9KmOITwBZibb73pJ52IdiAf+8un0m0qdPryP2gAkI
X-Google-Smtp-Source: AGHT+IH6dSKwONukdUjhtWFhjab0FtRZWxuPu1zX7OD7y7TwYxuOt8+e/aDFipclPQz9NthM8Y+ytQdaMI7jCn0nSz8=
X-Received: by 2002:a05:6512:3b9f:b0:553:2f8c:e618 with SMTP id
 2adb3069b0e04-5533b8e59b4mr4852743e87.7.1748958711563; Tue, 03 Jun 2025
 06:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
 <20250603-work-coredump-socket-protocol-v2-2-05a5f0c18ecc@kernel.org>
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-2-05a5f0c18ecc@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 3 Jun 2025 15:51:39 +0200
X-Gm-Features: AX0GCFv-_ZSOpzJJ3ZLsLmk1uBiqm6lcoGaakMftV6kBBT3bqzmpiBa1lZGjlkQ
Message-ID: <CAJqdLrpHFEk1q62OPgiZuLjtQg2UewOT6j-sVNrGxABZo1JApw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] selftests/coredump: fix build
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
> Fix various warnings in the selftest build.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/Makefile         |  2 +-
>  tools/testing/selftests/coredump/stackdump_test.c | 17 +++++------------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/Makefile b/tools/testing/selftests/coredump/Makefile
> index ed210037b29d..bc287a85b825 100644
> --- a/tools/testing/selftests/coredump/Makefile
> +++ b/tools/testing/selftests/coredump/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS = $(KHDR_INCLUDES)
> +CFLAGS = -Wall -O0 $(KHDR_INCLUDES)
>
>  TEST_GEN_PROGS := stackdump_test
>  TEST_FILES := stackdump
> diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
> index 9984413be9f0..aa366e6f13a7 100644
> --- a/tools/testing/selftests/coredump/stackdump_test.c
> +++ b/tools/testing/selftests/coredump/stackdump_test.c
> @@ -24,6 +24,8 @@ static void *do_nothing(void *)
>  {
>         while (1)
>                 pause();
> +
> +       return NULL;
>  }
>
>  static void crashing_child(void)
> @@ -46,9 +48,7 @@ FIXTURE(coredump)
>
>  FIXTURE_SETUP(coredump)
>  {
> -       char buf[PATH_MAX];
>         FILE *file;
> -       char *dir;
>         int ret;
>
>         self->pid_coredump_server = -ESRCH;
> @@ -106,7 +106,6 @@ FIXTURE_TEARDOWN(coredump)
>
>  TEST_F_TIMEOUT(coredump, stackdump, 120)
>  {
> -       struct sigaction action = {};
>         unsigned long long stack;
>         char *test_dir, *line;
>         size_t line_length;
> @@ -171,11 +170,10 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
>
>  TEST_F(coredump, socket)
>  {
> -       int fd, pidfd, ret, status;
> +       int pidfd, ret, status;
>         FILE *file;
>         pid_t pid, pid_coredump_server;
>         struct stat st;
> -       char core_file[PATH_MAX];
>         struct pidfd_info info = {};
>         int ipc_sockets[2];
>         char c;
> @@ -356,11 +354,10 @@ TEST_F(coredump, socket)
>
>  TEST_F(coredump, socket_detect_userspace_client)
>  {
> -       int fd, pidfd, ret, status;
> +       int pidfd, ret, status;
>         FILE *file;
>         pid_t pid, pid_coredump_server;
>         struct stat st;
> -       char core_file[PATH_MAX];
>         struct pidfd_info info = {};
>         int ipc_sockets[2];
>         char c;
> @@ -384,7 +381,7 @@ TEST_F(coredump, socket_detect_userspace_client)
>         pid_coredump_server = fork();
>         ASSERT_GE(pid_coredump_server, 0);
>         if (pid_coredump_server == 0) {
> -               int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
> +               int fd_server, fd_coredump, fd_peer_pidfd;
>                 socklen_t fd_peer_pidfd_len;
>
>                 close(ipc_sockets[0]);
> @@ -464,7 +461,6 @@ TEST_F(coredump, socket_detect_userspace_client)
>                 close(fd_coredump);
>                 close(fd_server);
>                 close(fd_peer_pidfd);
> -               close(fd_core_file);
>                 _exit(EXIT_SUCCESS);
>         }
>         self->pid_coredump_server = pid_coredump_server;
> @@ -488,7 +484,6 @@ TEST_F(coredump, socket_detect_userspace_client)
>                 if (ret < 0)
>                         _exit(EXIT_FAILURE);
>
> -               (void *)write(fd_socket, &(char){ 0 }, 1);
>                 close(fd_socket);
>                 _exit(EXIT_SUCCESS);
>         }
> @@ -519,7 +514,6 @@ TEST_F(coredump, socket_enoent)
>         int pidfd, ret, status;
>         FILE *file;
>         pid_t pid;
> -       char core_file[PATH_MAX];
>
>         file = fopen("/proc/sys/kernel/core_pattern", "w");
>         ASSERT_NE(file, NULL);
> @@ -569,7 +563,6 @@ TEST_F(coredump, socket_no_listener)
>         ASSERT_GE(pid_coredump_server, 0);
>         if (pid_coredump_server == 0) {
>                 int fd_server;
> -               socklen_t fd_peer_pidfd_len;
>
>                 close(ipc_sockets[0]);
>
>
> --
> 2.47.2
>

