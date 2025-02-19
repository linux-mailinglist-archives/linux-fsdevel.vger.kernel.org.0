Return-Path: <linux-fsdevel+bounces-42066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE34A3BE42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D951692EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53D1D5AC0;
	Wed, 19 Feb 2025 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkM9WeFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F41BC094;
	Wed, 19 Feb 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968594; cv=none; b=Y6jnHx7mhTRzpfyzv/VsUtP9O/31e3OXujvvGHIG5f2fWLv9n8jFtfXWVeWMzBd0snTYA/IB4Y4LVsJjAe2XI1QSNUftTrghZ3AA4ZfJ1awEZXbQz+GASF2Y1d4dytcc65CfXtI9omAe+LMmAaMNXT0DG7+ZEm5sNB26LgXiPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968594; c=relaxed/simple;
	bh=L8fwd21IsefCstQcqGmKT4PTpg97Dv2TpbWQC1NJvUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PizjmdRqTbQts+beYCqiUTA6x0PnYQrjaFr+miaHiS4ceBFLR5PWC9YlhPx2eYEJuGCi4Er04DzJd69P6MIjsaLOuAgUXfDYTkb+OO24fHwW3jONe5xsHKxJK/wabN9N8mD8EU9KZvc7HoaYDc7Hnntm6SbJ4lWT2NfOX2SlNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkM9WeFs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so577281a12.0;
        Wed, 19 Feb 2025 04:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968590; x=1740573390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0xIVbPj+USq+VYmSU3xLWEpvIIW2qx6JaYKVE8KSu4=;
        b=GkM9WeFsuD5Z5pThjgVWaElJrO1lYhy7+XFvs0GzPUqTtH+/jwWb6fZOveNirMV9nv
         g3Q2JSe5oCLzZwFo7gm3e2L/EuqYHV0mbTirxwnaz4W7O3+KFfOwgKMffSTJ+bkPAiz9
         GKgZqOrUVj3NyVyUurpDAqX+0Bcs2vB4mw7sJKuBdnvHYQ02xU0tYC6Rrm6pjL6MXSWn
         GeCukkbwcREPkIqtbZN01YKnJ1ywKS1Xm3mKNpUDKsho5KBeYZ9OeWEe0ljMgUeMIg/E
         kf4m1vaGjswaj2mBnaSPde2Z1JVPA0LZHPCgsWcaciK0PK4ZnlJabjXncP/f2xlZNHuo
         a/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968590; x=1740573390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0xIVbPj+USq+VYmSU3xLWEpvIIW2qx6JaYKVE8KSu4=;
        b=fWhOKGe3kEvvDut0lKiB7fMPHNqLY0qL/9F/Gq8Xxk+t4Gut+Ml4sh0205YzalwRiW
         s10fTwBaW1CzJdDH3/dOAqb0AVpkaEQuo75xH542AiDWM2j2LZ1gTfeUG2WqthcD3CXY
         coYANR2igcQA9Vs+o5OLLIobvEjCGPIIjaDAD8g4W4LBleQ009sDpxknF1w5j1h0W4iT
         847Ghcail044gAMC1zk3KwxfNEQGjDMW7ISyCq+iiVqmACjZoszbcN5TNYkLR5gZ8JHB
         Edy9CjkMtCq6DIhvIm9V9rlVKY6qBTkQQ4tloJErahbU3Dxu4OPH7xhwFtupdv5YQafc
         AyLw==
X-Forwarded-Encrypted: i=1; AJvYcCUhqjWEGuDkDIzR7E07hdIGVrKntcuILfxISbw8GFiEkkGgm0VBAlFs6Gucv0EmVaB5Kl8fFkrEJluh0nVE@vger.kernel.org, AJvYcCWdIAUHlAuwkd1hHASRkYwH4nUjPhw50fEQVn1fItAPixzHjcDA7F0skk+p9GUh/TWrhShYBJSd6lyyBDE1AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxinC/kj91hrIf+HIMfjXRqznKIxytndRPtsYXRkUNZavmRXju
	EU6laGuCMbytDCcodPpZ1LvFXvJCMjC/4jrMMq51ID+Paan3YzcvHm3cpTS1gkprFXv1vrg5VqU
	m67eg/VRmrbE60cPLaN/S7e/kY9Y=
X-Gm-Gg: ASbGncsyQDtAYP1tE/jTFEZ/nqynBZ4IP1TbR1smqEk9wAqYTiiAsS295WQAWHlmjyB
	4RloKOp+oZyyiDQceouTfzKPzI4lTIeErJE3LYIfMRad/E4zSjNEuae6gzYqx+i3o/5JX+VoH
X-Google-Smtp-Source: AGHT+IFkfWXqfal2fEHYC4gnm3i5PHa3KJF14xt7Wp9uMnItJa8AN5+f7bnw5Gq3Y8v+jRafOpDL+pZi3WvhM5+qmQE=
X-Received: by 2002:a05:6402:3481:b0:5e0:9959:83cd with SMTP id
 4fb4d7f45d1cf-5e0995984bcmr209979a12.21.1739968589552; Wed, 19 Feb 2025
 04:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org> <20250219-work-overlayfs-v3-3-46af55e4ceda@kernel.org>
In-Reply-To: <20250219-work-overlayfs-v3-3-46af55e4ceda@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Feb 2025 13:36:17 +0100
X-Gm-Features: AWEUYZkNli0q9wqdCkFTy2VnIk9CQP3JGS5SYflXF3UfYRqqvAYnWnvDBVKK0Qk
Message-ID: <CAOQ4uxhmzcQxB+udEwsLjJVxqtof_Py9Ctn41=q6Xvi1PaaA6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selftests/ovl: add second selftest for "override_creds"
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Seth Forshee <sforshee@kernel.org>, 
	Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Add a simple test to verify that the new "override_creds" option works.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

For the added test you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

But you may want to consider splitting the large infrastructure
and the churn to the previous test to a separate patch, to make this
patch cleaner.

Thanks,
Amir.

> ---
>  .../selftests/filesystems/overlayfs/Makefile       |  11 +-
>  .../filesystems/overlayfs/set_layers_via_fds.c     | 149 ++++++-
>  tools/testing/selftests/filesystems/utils.c        | 474 +++++++++++++++=
++++++
>  tools/testing/selftests/filesystems/utils.h        |  44 ++
>  4 files changed, 665 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/too=
ls/testing/selftests/filesystems/overlayfs/Makefile
> index e8d1adb021af..6c661232b3b5 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/Makefile
> +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> @@ -1,7 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -TEST_GEN_PROGS :=3D dev_in_maps set_layers_via_fds
> +CFLAGS +=3D -Wall
> +CFLAGS +=3D $(KHDR_INCLUDES)
> +LDLIBS +=3D -lcap
>
> -CFLAGS :=3D -Wall -Werror
> +LOCAL_HDRS +=3D wrappers.h log.h
> +
> +TEST_GEN_PROGS :=3D dev_in_maps
> +TEST_GEN_PROGS +=3D set_layers_via_fds
>
>  include ../../lib.mk
> +
> +$(OUTPUT)/set_layers_via_fds: ../utils.c
> diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via=
_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> index 70acd833581d..6b65e3610578 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> @@ -6,6 +6,7 @@
>  #include <sched.h>
>  #include <stdio.h>
>  #include <string.h>
> +#include <sys/socket.h>
>  #include <sys/stat.h>
>  #include <sys/mount.h>
>  #include <unistd.h>
> @@ -13,20 +14,27 @@
>  #include "../../kselftest_harness.h"
>  #include "../../pidfd/pidfd.h"
>  #include "log.h"
> +#include "../utils.h"
>  #include "wrappers.h"
>
>  FIXTURE(set_layers_via_fds) {
> +       int pidfd;
>  };
>
>  FIXTURE_SETUP(set_layers_via_fds)
>  {
> -       ASSERT_EQ(mkdir("/set_layers_via_fds", 0755), 0);
> +       self->pidfd =3D -EBADF;
> +       EXPECT_EQ(mkdir("/set_layers_via_fds", 0755), 0);
>  }
>
>  FIXTURE_TEARDOWN(set_layers_via_fds)
>  {
> +       if (self->pidfd >=3D 0) {
> +               EXPECT_EQ(sys_pidfd_send_signal(self->pidfd, SIGKILL, NUL=
L, 0), 0);
> +               EXPECT_EQ(close(self->pidfd), 0);
> +       }
>         umount2("/set_layers_via_fds", 0);
> -       ASSERT_EQ(rmdir("/set_layers_via_fds"), 0);
> +       EXPECT_EQ(rmdir("/set_layers_via_fds"), 0);
>  }
>
>  TEST_F(set_layers_via_fds, set_layers_via_fds)
> @@ -266,7 +274,7 @@ TEST_F(set_layers_via_fds, set_override_creds)
>         ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_STRING, "metacopy=
", "on", 0), 0);
>
>         pid =3D create_child(&pidfd, 0);
> -       EXPECT_GE(pid, 0);
> +       ASSERT_GE(pid, 0);
>         if (pid =3D=3D 0) {
>                 if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override=
_creds", NULL, 0)) {
>                         TH_LOG("sys_fsconfig should have succeeded");
> @@ -275,11 +283,11 @@ TEST_F(set_layers_via_fds, set_override_creds)
>
>                 _exit(EXIT_SUCCESS);
>         }
> -       EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> -       EXPECT_EQ(close(pidfd), 0);
> +       ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> +       ASSERT_GE(close(pidfd), 0);
>
>         pid =3D create_child(&pidfd, 0);
> -       EXPECT_GE(pid, 0);
> +       ASSERT_GE(pid, 0);
>         if (pid =3D=3D 0) {
>                 if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "nooverri=
de_creds", NULL, 0)) {
>                         TH_LOG("sys_fsconfig should have succeeded");
> @@ -288,11 +296,11 @@ TEST_F(set_layers_via_fds, set_override_creds)
>
>                 _exit(EXIT_SUCCESS);
>         }
> -       EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> -       EXPECT_EQ(close(pidfd), 0);
> +       ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> +       ASSERT_GE(close(pidfd), 0);
>
>         pid =3D create_child(&pidfd, 0);
> -       EXPECT_GE(pid, 0);
> +       ASSERT_GE(pid, 0);
>         if (pid =3D=3D 0) {
>                 if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override=
_creds", NULL, 0)) {
>                         TH_LOG("sys_fsconfig should have succeeded");
> @@ -301,8 +309,125 @@ TEST_F(set_layers_via_fds, set_override_creds)
>
>                 _exit(EXIT_SUCCESS);
>         }
> -       EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> -       EXPECT_EQ(close(pidfd), 0);
> +       ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> +       ASSERT_GE(close(pidfd), 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NUL=
L, 0), 0);
> +
> +       fd_overlay =3D sys_fsmount(fd_context, 0, 0);
> +       ASSERT_GE(fd_overlay, 0);
> +
> +       ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via=
_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
> +
> +       ASSERT_EQ(close(fd_context), 0);
> +       ASSERT_EQ(close(fd_overlay), 0);
> +}
> +
> +TEST_F(set_layers_via_fds, set_override_creds_invalid)
> +{
> +       int fd_context, fd_tmpfs, fd_overlay, ret;
> +       int layer_fds[] =3D { [0 ... 3] =3D -EBADF };
> +       pid_t pid;
> +       int fd_userns1, fd_userns2;
> +       int ipc_sockets[2];
> +       char c;
> +       const unsigned int predictable_fd_context_nr =3D 123;
> +
> +       fd_userns1 =3D get_userns_fd(0, 0, 10000);
> +       ASSERT_GE(fd_userns1, 0);
> +
> +       fd_userns2 =3D get_userns_fd(0, 1234, 10000);
> +       ASSERT_GE(fd_userns2, 0);
> +
> +       ret =3D socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_s=
ockets);
> +       ASSERT_GE(ret, 0);
> +
> +       pid =3D create_child(&self->pidfd, 0);
> +       ASSERT_GE(pid, 0);
> +       if (pid =3D=3D 0) {
> +               if (close(ipc_sockets[0])) {
> +                       TH_LOG("close should have succeeded");
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!switch_userns(fd_userns2, 0, 0, false)) {
> +                       TH_LOG("switch_userns should have succeeded");
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (read_nointr(ipc_sockets[1], &c, 1) !=3D 1) {
> +                       TH_LOG("read_nointr should have succeeded");
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (close(ipc_sockets[1])) {
> +                       TH_LOG("close should have succeeded");
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!sys_fsconfig(predictable_fd_context_nr, FSCONFIG_SET=
_FLAG, "override_creds", NULL, 0)) {
> +                       TH_LOG("sys_fsconfig should have failed");
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               _exit(EXIT_SUCCESS);
> +       }
> +
> +       ASSERT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(switch_userns(fd_userns1, 0, 0, false), true);
> +       ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +       ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0)=
;
> +
> +       fd_context =3D sys_fsopen("tmpfs", 0);
> +       ASSERT_GE(fd_context, 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NUL=
L, 0), 0);
> +       fd_tmpfs =3D sys_fsmount(fd_context, 0, 0);
> +       ASSERT_GE(fd_tmpfs, 0);
> +       ASSERT_EQ(close(fd_context), 0);
> +
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "l1", 0755), 0);
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "l2", 0755), 0);
> +
> +       layer_fds[0] =3D openat(fd_tmpfs, "w", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[0], 0);
> +
> +       layer_fds[1] =3D openat(fd_tmpfs, "u", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[1], 0);
> +
> +       layer_fds[2] =3D openat(fd_tmpfs, "l1", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[2], 0);
> +
> +       layer_fds[3] =3D openat(fd_tmpfs, "l2", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[3], 0);
> +
> +       ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT=
_F_EMPTY_PATH), 0);
> +       ASSERT_EQ(close(fd_tmpfs), 0);
> +
> +       fd_context =3D sys_fsopen("overlay", 0);
> +       ASSERT_GE(fd_context, 0);
> +       ASSERT_EQ(dup3(fd_context, predictable_fd_context_nr, 0), predict=
able_fd_context_nr);
> +       ASSERT_EQ(close(fd_context), 0);
> +       fd_context =3D predictable_fd_context_nr;
> +       ASSERT_EQ(write_nointr(ipc_sockets[0], "1", 1), 1);
> +       ASSERT_EQ(close(ipc_sockets[0]), 0);
> +
> +       ASSERT_EQ(wait_for_pid(pid), 0);
> +       ASSERT_EQ(close(self->pidfd), 0);
> +       self->pidfd =3D -EBADF;
> +
> +       ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", N=
ULL, layer_fds[2]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   =
NULL, layer_fds[0]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  =
NULL, layer_fds[1]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[2]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[3]), 0);
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(layer_fds); i++)
> +               ASSERT_EQ(close(layer_fds[i]), 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "userxattr"=
, NULL, 0), 0);
>
>         ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NUL=
L, 0), 0);
>
> @@ -313,6 +438,8 @@ TEST_F(set_layers_via_fds, set_override_creds)
>
>         ASSERT_EQ(close(fd_context), 0);
>         ASSERT_EQ(close(fd_overlay), 0);
> +       ASSERT_EQ(close(fd_userns1), 0);
> +       ASSERT_EQ(close(fd_userns2), 0);
>  }
>
>  TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/=
selftests/filesystems/utils.c
> new file mode 100644
> index 000000000000..0e8080bd0aea
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/utils.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <dirent.h>
> +#include <grp.h>
> +#include <linux/limits.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/eventfd.h>
> +#include <sys/fsuid.h>
> +#include <sys/prctl.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/xattr.h>
> +
> +#include "utils.h"
> +
> +#define MAX_USERNS_LEVEL 32
> +
> +#define syserror(format, ...)                           \
> +       ({                                              \
> +               fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__); \
> +               (-errno);                               \
> +       })
> +
> +#define syserror_set(__ret__, format, ...)                    \
> +       ({                                                    \
> +               typeof(__ret__) __internal_ret__ =3D (__ret__); \
> +               errno =3D labs(__ret__);                        \
> +               fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__);     =
  \
> +               __internal_ret__;                             \
> +       })
> +
> +#define STRLITERALLEN(x) (sizeof(""x"") - 1)
> +
> +#define INTTYPE_TO_STRLEN(type)             \
> +       (2 + (sizeof(type) <=3D 1             \
> +                 ? 3                       \
> +                 : sizeof(type) <=3D 2       \
> +                       ? 5                 \
> +                       : sizeof(type) <=3D 4 \
> +                             ? 10          \
> +                             : sizeof(type) <=3D 8 ? 20 : sizeof(int[-2 =
* (sizeof(type) > 8)])))
> +
> +#define list_for_each(__iterator, __list) \
> +       for (__iterator =3D (__list)->next; __iterator !=3D __list; __ite=
rator =3D __iterator->next)
> +
> +typedef enum idmap_type_t {
> +       ID_TYPE_UID,
> +       ID_TYPE_GID
> +} idmap_type_t;
> +
> +struct id_map {
> +       idmap_type_t map_type;
> +       __u32 nsid;
> +       __u32 hostid;
> +       __u32 range;
> +};
> +
> +struct list {
> +       void *elem;
> +       struct list *next;
> +       struct list *prev;
> +};
> +
> +struct userns_hierarchy {
> +       int fd_userns;
> +       int fd_event;
> +       unsigned int level;
> +       struct list id_map;
> +};
> +
> +static inline void list_init(struct list *list)
> +{
> +       list->elem =3D NULL;
> +       list->next =3D list->prev =3D list;
> +}
> +
> +static inline int list_empty(const struct list *list)
> +{
> +       return list =3D=3D list->next;
> +}
> +
> +static inline void __list_add(struct list *new, struct list *prev, struc=
t list *next)
> +{
> +       next->prev =3D new;
> +       new->next =3D next;
> +       new->prev =3D prev;
> +       prev->next =3D new;
> +}
> +
> +static inline void list_add_tail(struct list *head, struct list *list)
> +{
> +       __list_add(list, head->prev, head);
> +}
> +
> +static inline void list_del(struct list *list)
> +{
> +       struct list *next, *prev;
> +
> +       next =3D list->next;
> +       prev =3D list->prev;
> +       next->prev =3D prev;
> +       prev->next =3D next;
> +}
> +
> +static ssize_t read_nointr(int fd, void *buf, size_t count)
> +{
> +       ssize_t ret;
> +
> +       do {
> +               ret =3D read(fd, buf, count);
> +       } while (ret < 0 && errno =3D=3D EINTR);
> +
> +       return ret;
> +}
> +
> +static ssize_t write_nointr(int fd, const void *buf, size_t count)
> +{
> +       ssize_t ret;
> +
> +       do {
> +               ret =3D write(fd, buf, count);
> +       } while (ret < 0 && errno =3D=3D EINTR);
> +
> +       return ret;
> +}
> +
> +#define __STACK_SIZE (8 * 1024 * 1024)
> +static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
> +{
> +       void *stack;
> +
> +       stack =3D malloc(__STACK_SIZE);
> +       if (!stack)
> +               return -ENOMEM;
> +
> +#ifdef __ia64__
> +       return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NU=
LL);
> +#else
> +       return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL=
);
> +#endif
> +}
> +
> +static int get_userns_fd_cb(void *data)
> +{
> +       for (;;)
> +               pause();
> +       _exit(0);
> +}
> +
> +static int wait_for_pid(pid_t pid)
> +{
> +       int status, ret;
> +
> +again:
> +       ret =3D waitpid(pid, &status, 0);
> +       if (ret =3D=3D -1) {
> +               if (errno =3D=3D EINTR)
> +                       goto again;
> +
> +               return -1;
> +       }
> +
> +       if (!WIFEXITED(status))
> +               return -1;
> +
> +       return WEXITSTATUS(status);
> +}
> +
> +static int write_id_mapping(idmap_type_t map_type, pid_t pid, const char=
 *buf, size_t buf_size)
> +{
> +       int fd =3D -EBADF, setgroups_fd =3D -EBADF;
> +       int fret =3D -1;
> +       int ret;
> +       char path[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
> +                 STRLITERALLEN("/setgroups") + 1];
> +
> +       if (geteuid() !=3D 0 && map_type =3D=3D ID_TYPE_GID) {
> +               ret =3D snprintf(path, sizeof(path), "/proc/%d/setgroups"=
, pid);
> +               if (ret < 0 || ret >=3D sizeof(path))
> +                       goto out;
> +
> +               setgroups_fd =3D open(path, O_WRONLY | O_CLOEXEC);
> +               if (setgroups_fd < 0 && errno !=3D ENOENT) {
> +                       syserror("Failed to open \"%s\"", path);
> +                       goto out;
> +               }
> +
> +               if (setgroups_fd >=3D 0) {
> +                       ret =3D write_nointr(setgroups_fd, "deny\n", STRL=
ITERALLEN("deny\n"));
> +                       if (ret !=3D STRLITERALLEN("deny\n")) {
> +                               syserror("Failed to write \"deny\" to \"/=
proc/%d/setgroups\"", pid);
> +                               goto out;
> +                       }
> +               }
> +       }
> +
> +       ret =3D snprintf(path, sizeof(path), "/proc/%d/%cid_map", pid, ma=
p_type =3D=3D ID_TYPE_UID ? 'u' : 'g');
> +       if (ret < 0 || ret >=3D sizeof(path))
> +               goto out;
> +
> +       fd =3D open(path, O_WRONLY | O_CLOEXEC);
> +       if (fd < 0) {
> +               syserror("Failed to open \"%s\"", path);
> +               goto out;
> +       }
> +
> +       ret =3D write_nointr(fd, buf, buf_size);
> +       if (ret !=3D buf_size) {
> +               syserror("Failed to write %cid mapping to \"%s\"",
> +                        map_type =3D=3D ID_TYPE_UID ? 'u' : 'g', path);
> +               goto out;
> +       }
> +
> +       fret =3D 0;
> +out:
> +       close(fd);
> +       close(setgroups_fd);
> +
> +       return fret;
> +}
> +
> +static int map_ids_from_idmap(struct list *idmap, pid_t pid)
> +{
> +       int fill, left;
> +       char mapbuf[4096] =3D {};
> +       bool had_entry =3D false;
> +       idmap_type_t map_type, u_or_g;
> +
> +       if (list_empty(idmap))
> +               return 0;
> +
> +       for (map_type =3D ID_TYPE_UID, u_or_g =3D 'u';
> +            map_type <=3D ID_TYPE_GID; map_type++, u_or_g =3D 'g') {
> +               char *pos =3D mapbuf;
> +               int ret;
> +               struct list *iterator;
> +
> +
> +               list_for_each(iterator, idmap) {
> +                       struct id_map *map =3D iterator->elem;
> +                       if (map->map_type !=3D map_type)
> +                               continue;
> +
> +                       had_entry =3D true;
> +
> +                       left =3D 4096 - (pos - mapbuf);
> +                       fill =3D snprintf(pos, left, "%u %u %u\n", map->n=
sid, map->hostid, map->range);
> +                       /*
> +                        * The kernel only takes <=3D 4k for writes to
> +                        * /proc/<pid>/{g,u}id_map
> +                        */
> +                       if (fill <=3D 0 || fill >=3D left)
> +                               return syserror_set(-E2BIG, "Too many %ci=
d mappings defined", u_or_g);
> +
> +                       pos +=3D fill;
> +               }
> +               if (!had_entry)
> +                       continue;
> +
> +               ret =3D write_id_mapping(map_type, pid, mapbuf, pos - map=
buf);
> +               if (ret < 0)
> +                       return syserror("Failed to write mapping: %s", ma=
pbuf);
> +
> +               memset(mapbuf, 0, sizeof(mapbuf));
> +       }
> +
> +       return 0;
> +}
> +
> +static int get_userns_fd_from_idmap(struct list *idmap)
> +{
> +       int ret;
> +       pid_t pid;
> +       char path_ns[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
> +                    STRLITERALLEN("/ns/user") + 1];
> +
> +       pid =3D do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NE=
WNS);
> +       if (pid < 0)
> +               return -errno;
> +
> +       ret =3D map_ids_from_idmap(idmap, pid);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D snprintf(path_ns, sizeof(path_ns), "/proc/%d/ns/user", pi=
d);
> +       if (ret < 0 || (size_t)ret >=3D sizeof(path_ns))
> +               ret =3D -EIO;
> +       else
> +               ret =3D open(path_ns, O_RDONLY | O_CLOEXEC | O_NOCTTY);
> +
> +       (void)kill(pid, SIGKILL);
> +       (void)wait_for_pid(pid);
> +       return ret;
> +}
> +
> +int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned lon=
g range)
> +{
> +       struct list head, uid_mapl, gid_mapl;
> +       struct id_map uid_map =3D {
> +               .map_type       =3D ID_TYPE_UID,
> +               .nsid           =3D nsid,
> +               .hostid         =3D hostid,
> +               .range          =3D range,
> +       };
> +       struct id_map gid_map =3D {
> +               .map_type       =3D ID_TYPE_GID,
> +               .nsid           =3D nsid,
> +               .hostid         =3D hostid,
> +               .range          =3D range,
> +       };
> +
> +       list_init(&head);
> +       uid_mapl.elem =3D &uid_map;
> +       gid_mapl.elem =3D &gid_map;
> +       list_add_tail(&head, &uid_mapl);
> +       list_add_tail(&head, &gid_mapl);
> +
> +       return get_userns_fd_from_idmap(&head);
> +}
> +
> +bool switch_ids(uid_t uid, gid_t gid)
> +{
> +       if (setgroups(0, NULL))
> +               return syserror("failure: setgroups");
> +
> +       if (setresgid(gid, gid, gid))
> +               return syserror("failure: setresgid");
> +
> +       if (setresuid(uid, uid, uid))
> +               return syserror("failure: setresuid");
> +
> +       /* Ensure we can access proc files from processes we can ptrace. =
*/
> +       if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
> +               return syserror("failure: make dumpable");
> +
> +       return true;
> +}
> +
> +static int create_userns_hierarchy(struct userns_hierarchy *h);
> +
> +static int userns_fd_cb(void *data)
> +{
> +       struct userns_hierarchy *h =3D data;
> +       char c;
> +       int ret;
> +
> +       ret =3D read_nointr(h->fd_event, &c, 1);
> +       if (ret < 0)
> +               return syserror("failure: read from socketpair");
> +
> +       /* Only switch ids if someone actually wrote a mapping for us. */
> +       if (c =3D=3D '1') {
> +               if (!switch_ids(0, 0))
> +                       return syserror("failure: switch ids to 0");
> +       }
> +
> +       ret =3D write_nointr(h->fd_event, "1", 1);
> +       if (ret < 0)
> +               return syserror("failure: write to socketpair");
> +
> +       ret =3D create_userns_hierarchy(++h);
> +       if (ret < 0)
> +               return syserror("failure: userns level %d", h->level);
> +
> +       return 0;
> +}
> +
> +static int create_userns_hierarchy(struct userns_hierarchy *h)
> +{
> +       int fret =3D -1;
> +       char c;
> +       int fd_socket[2];
> +       int fd_userns =3D -EBADF, ret =3D -1;
> +       ssize_t bytes;
> +       pid_t pid;
> +       char path[256];
> +
> +       if (h->level =3D=3D MAX_USERNS_LEVEL)
> +               return 0;
> +
> +       ret =3D socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, fd_so=
cket);
> +       if (ret < 0)
> +               return syserror("failure: create socketpair");
> +
> +       /* Note the CLONE_FILES | CLONE_VM when mucking with fds and memo=
ry. */
> +       h->fd_event =3D fd_socket[1];
> +       pid =3D do_clone(userns_fd_cb, h, CLONE_NEWUSER | CLONE_FILES | C=
LONE_VM);
> +       if (pid < 0) {
> +               syserror("failure: userns level %d", h->level);
> +               goto out_close;
> +       }
> +
> +       ret =3D map_ids_from_idmap(&h->id_map, pid);
> +       if (ret < 0) {
> +               kill(pid, SIGKILL);
> +               syserror("failure: writing id mapping for userns level %d=
 for %d", h->level, pid);
> +               goto out_wait;
> +       }
> +
> +       if (!list_empty(&h->id_map))
> +               bytes =3D write_nointr(fd_socket[0], "1", 1); /* Inform t=
he child we wrote a mapping. */
> +       else
> +               bytes =3D write_nointr(fd_socket[0], "0", 1); /* Inform t=
he child we didn't write a mapping. */
> +       if (bytes < 0) {
> +               kill(pid, SIGKILL);
> +               syserror("failure: write to socketpair");
> +               goto out_wait;
> +       }
> +
> +       /* Wait for child to set*id() and become dumpable. */
> +       bytes =3D read_nointr(fd_socket[0], &c, 1);
> +       if (bytes < 0) {
> +               kill(pid, SIGKILL);
> +               syserror("failure: read from socketpair");
> +               goto out_wait;
> +       }
> +
> +       snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
> +       fd_userns =3D open(path, O_RDONLY | O_CLOEXEC);
> +       if (fd_userns < 0) {
> +               kill(pid, SIGKILL);
> +               syserror("failure: open userns level %d for %d", h->level=
, pid);
> +               goto out_wait;
> +       }
> +
> +       fret =3D 0;
> +
> +out_wait:
> +       if (!wait_for_pid(pid) && !fret) {
> +               h->fd_userns =3D fd_userns;
> +               fd_userns =3D -EBADF;
> +       }
> +
> +out_close:
> +       if (fd_userns >=3D 0)
> +               close(fd_userns);
> +       close(fd_socket[0]);
> +       close(fd_socket[1]);
> +       return fret;
> +}
> +
> +/* caps_down - lower all effective caps */
> +int caps_down(void)
> +{
> +       bool fret =3D false;
> +       cap_t caps =3D NULL;
> +       int ret =3D -1;
> +
> +       caps =3D cap_get_proc();
> +       if (!caps)
> +               goto out;
> +
> +       ret =3D cap_clear_flag(caps, CAP_EFFECTIVE);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D cap_set_proc(caps);
> +       if (ret)
> +               goto out;
> +
> +       fret =3D true;
> +
> +out:
> +       cap_free(caps);
> +       return fret;
> +}
> diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/=
selftests/filesystems/utils.h
> new file mode 100644
> index 000000000000..f35001a75f99
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/utils.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __IDMAP_UTILS_H
> +#define __IDMAP_UTILS_H
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <errno.h>
> +#include <linux/types.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syscall.h>
> +#include <sys/capability.h>
> +#include <sys/fsuid.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +extern int get_userns_fd(unsigned long nsid, unsigned long hostid,
> +                        unsigned long range);
> +
> +extern int caps_down(void);
> +
> +extern bool switch_ids(uid_t uid, gid_t gid);
> +
> +static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop=
_caps)
> +{
> +       if (setns(fd, CLONE_NEWUSER))
> +               return false;
> +
> +       if (!switch_ids(uid, gid))
> +               return false;
> +
> +       if (drop_caps && !caps_down())
> +               return false;
> +
> +       return true;
> +}
> +
> +#endif /* __IDMAP_UTILS_H */
>
> --
> 2.47.2
>

