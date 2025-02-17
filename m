Return-Path: <linux-fsdevel+bounces-41841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C8FA3814E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 12:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C67516CB9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC1218580;
	Mon, 17 Feb 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0u0S/xs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE3217739;
	Mon, 17 Feb 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790056; cv=none; b=Rqpl71KbQkmnVsjIuDwXiKnsRsHSP2BkjJarH5W4CmTNzE5MgajBDJmjHbJNYKbUJ+cF6Wa1yQqp4SMOpnfUXSH30vfyahOHoIk5xp3jJYnuSYQMFD4dRZvNPfvxJxxjuAbv+afJe5Acq0SXMOBqkTRBqNt6w6IsDhCNqbo6XrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790056; c=relaxed/simple;
	bh=yvY7wSNYM+q1g5xbneZ7RjxIG7NBIVYyEAcFGkjex9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYd8F/u7Hn0SbJKuCo+m5juzZjXkgdCEmY5Wfy0L5sf9jguSCI9Y7CCu92PND4JbLHKogq8Lmuuh45YltVRP9FmRVW3NkaQJ6uS6E5nCRrD0nyg0m3ykOpuvSFpNFIAPBAlkePyXUOl1OA9Iy48Y9YwdGWSinQZNOrQXGa8ny8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0u0S/xs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so536784766b.3;
        Mon, 17 Feb 2025 03:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739790051; x=1740394851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puqvgYI7RbihufeGMK75lUm2mmnKRlybwe2m7us4Rps=;
        b=C0u0S/xsf25BIDtGoyqg7b5SDostgY8QBZ5mcMGy6rZry2mVn3o7Q3zY5Vybli/ZlR
         3l3NNssU9Vwo1w8qIzZ/tVMaKSx6l+U+cAPj91vbQRKccK/VE/bRtS4P4lxmiMtIMks+
         6wa4C2f0f3Ej0DcEbz4wStFuoKcg2HpKEVjhj8qfaoYUVzUvo1lgEgGG8H7m+lEocPlN
         GU9+H5c83QkyWJhV+2fbTIvz2EBLmSMiwPUulRH3wLFEfNlDAc0OP8qtGkJtkxlp/F7A
         r1kZ64XXHFvsTVM9ynBANfa7qMtA6CK1n2XvY/hOWgVcDZIC5MN69cnMn1upABRqagfb
         2m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790051; x=1740394851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puqvgYI7RbihufeGMK75lUm2mmnKRlybwe2m7us4Rps=;
        b=k/KLXHv63snibMqXyGhK1EUpxJsvfpU7vXLabPpYwgfI5fzbg5YlW5ASFKwnQE2+nF
         16sKcCrGZ0N8FdaOQwwt9VM+onnFmyohB/o20A3+XbK8KMuCA+1TqQW4LLQOHy323ejd
         +02KXRzH2QqyD6UGacFI1V2rT816XXT8nwP05uhVD5Fs8Zve8g8tug0xmoJ7/trMVNYu
         QtFWhUQp9My1Rec+ZQKwD1kvFb8Vf7hUJPLJY3OVz3kQ9k441iUcmu0+h7CTzqPq/sPh
         TeanYywh89DXDR+Yvx8AJX2o862TUXc7oDoGgHc4tXzX+mB+8nzV3qjoS7rCn7Qxbes1
         kmbw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Qpfe5p3ENBKQX8nFoOHaao7ZvERChclGx6TP5QDwNnCv/drx+rgam3Ilk69clG2dOPrHp5LcGulbXZU1@vger.kernel.org, AJvYcCXAbeha07UsGKFOl/DBHXsp5efnYQ2NiP8lBtOY92S3zAdzEl83mq5/GcUXKGUq+xUgHf9XwXKENc6LLW1dpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQywbaPyAWb1cIf8PS0dKitpQlKA9DoWMAmF/r5xeLyAFR2LNx
	8XUoYwNGZt4UOJny6HUyEq5N8uMJZxeCz1zqK61yeeuVmzT3C5wLOn0eQQd6yC4H/hFHkbw8eyp
	1YNsQbg4Hc8EGpTvbdpcyt1RceaU=
X-Gm-Gg: ASbGncspxxHC3CkhnnpS0vDZdt36h436g0DKUkeq2pjJWc9YmfhFZVmyNZVNCtVpdyP
	alT2ugimmYyY2Ctw79zssJJiydM6SwZwQNmr5MElzIrh1OT7iISLLjYFCm3ynHzVtzjULyEWA
X-Google-Smtp-Source: AGHT+IE7k7k+/ZuigK4DzkfN3yNy5r2w8QfasmJJSf570ISLVzUwH7iRMaODYRbJnCSzz2DIDBiKV7tYjfyJ8moBgb8=
X-Received: by 2002:a17:906:31d5:b0:aa6:8cbc:8d15 with SMTP id
 a640c23a62f3a-abb70b2c3e1mr813126566b.14.1739790050288; Mon, 17 Feb 2025
 03:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-work-overlayfs-v2-0-41dfe7718963@kernel.org> <20250217-work-overlayfs-v2-2-41dfe7718963@kernel.org>
In-Reply-To: <20250217-work-overlayfs-v2-2-41dfe7718963@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Feb 2025 12:00:39 +0100
X-Gm-Features: AWEUYZmAr0dG1IYCjZjBlXAhUOSMqxQHYGmGHeUYLeNt7Yb8DeeoJR6NkYWx9AQ
Message-ID: <CAOQ4uxjT2QRSu2x5Y67sjUg+Nu0f5ktGpS-y2ONpGo6sKB35=g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] selftests/ovl: add selftests for "override_creds"
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Seth Forshee <sforshee@kernel.org>, 
	Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 11:20=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Add a simple test to verify that the new "override_creds" option works.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  .../filesystems/overlayfs/set_layers_via_fds.c     | 89 ++++++++++++++++=
++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via=
_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> index e65d95d97846..6c9f4df5df8d 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> @@ -6,11 +6,13 @@
>  #include <sched.h>
>  #include <stdio.h>
>  #include <string.h>
> +#include <sys/fsuid.h>
>  #include <sys/stat.h>
>  #include <sys/mount.h>
>  #include <unistd.h>
>
>  #include "../../kselftest_harness.h"
> +#include "../../pidfd/pidfd.h"
>  #include "log.h"
>  #include "wrappers.h"
>
> @@ -409,4 +411,91 @@ TEST_F(set_layers_via_fds, set_layers_via_detached_m=
ount_fds)
>         ASSERT_EQ(fclose(f_mountinfo), 0);
>  }
>
> +TEST_F(set_layers_via_fds, set_override_creds)
> +{
> +       int fd_context, fd_tmpfs, fd_overlay;
> +       int layer_fds[] =3D { [0 ... 3] =3D -EBADF };
> +       pid_t pid;
> +       int pidfd;
> +
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
> +
> +       ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", N=
ULL, layer_fds[2]), 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   =
NULL, layer_fds[0]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  =
NULL, layer_fds[1]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[2]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[3]), 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_STRING, "metacopy=
", "on", 0), 0);
> +
> +       pid =3D create_child(&pidfd, CLONE_NEWUSER);
> +       EXPECT_GE(pid, 0);
> +       if (pid =3D=3D 0) {
> +               if (!sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "overrid=
e_creds", NULL, 0)) {
> +                       TH_LOG("sys_fsconfig should have failed");
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               _exit(EXIT_SUCCESS);
> +       }
> +       EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> +       EXPECT_EQ(close(pidfd), 0);
> +
> +       pid =3D create_child(&pidfd, 0);
> +       EXPECT_GE(pid, 0);
> +       if (pid =3D=3D 0) {
> +               if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override=
_creds", NULL, 0)) {
> +                       TH_LOG("sys_fsconfig should have succeeded");
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               _exit(EXIT_SUCCESS);
> +       }
> +       EXPECT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> +       EXPECT_EQ(close(pidfd), 0);
> +

Suggest to verify functionality:
execute FSCONFIG_CMD_CREATE from a child which removes CAP_MKNOD...

> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NUL=
L, 0), 0);
> +
> +       fd_overlay =3D sys_fsmount(fd_context, 0, 0);
> +       ASSERT_GE(fd_overlay, 0);
> +
> +       ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via=
_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
> +

... and verify that you can mknod(2) on ovl mount.

Other than that you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

