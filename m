Return-Path: <linux-fsdevel+bounces-31794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8999B179
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 09:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F2B1C224CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5251F13C9A9;
	Sat, 12 Oct 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k68AbDmR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AF126BE1;
	Sat, 12 Oct 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717551; cv=none; b=GYwIAjFR+t0DjTQINbyp4VKA4eUfd600wKya35k8j7h+jX6Ck+LBxdC3ImeHgyBKsqWUN2jmitWSt7n/xH3Y2kLXUorSANISd23Q8Zmp8ESkpJpsNPzAvvXirS7KLz3Dk44ZLtCl5LBnJnkzgVh0H6PF4UyTIarPqIqtYIXUNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717551; c=relaxed/simple;
	bh=Qfo9EQK76ErqcP00KRf6TIgx+TAEBQJi4jZL980MklQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUvbw/O/Oj7cFBtqqdDm2vOXcxmhGDFb044KAW4ZaVq8WcizdwZc2EKRkjw1iJwsgih6M5Lk2X4zNcH6thi7EZ0ncnlUeykb2nD+HFoMfRflbzBHQzR6xj18ka7y6taUV3eIE5EQ45peWxiK1faayGnHdqSL3ZpK0ybEn51KD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k68AbDmR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7ac83a98e5eso233908185a.0;
        Sat, 12 Oct 2024 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717549; x=1729322349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTWk7opqhOjqGO2ekzAnC4nQnKlbq9yyE9WDuYCehig=;
        b=k68AbDmROzmEVnPrnEryd9+ANremdT0muHwuN4vxR4B8t10K0GIY34ZWx/gKb2ujyY
         ewWUURnINqJW/IzrLDElH8XXp7qABK1gofY4R9w40fafnUJfzMEiOoLhOfTF+6QiG02x
         TeYBH2ew7ubgLl93UP7Cy8v3LNqCdZlsKq34UL/gVS5+C+bP5hUEO5etSepWCVpW8Sn+
         zN5M4UPBbzsbBKyEvCCfeB4O85zC7vYANOVga58ZKf16r+JBi811icRF5auKA0WUHonR
         q9wNDCg4L1mmA+QJO1thde6jragV/1U+ONBpvJfKe7O5tnvvTm9krQwdx3NjQYlf4cEh
         bHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717549; x=1729322349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTWk7opqhOjqGO2ekzAnC4nQnKlbq9yyE9WDuYCehig=;
        b=nPrFvIQliu8RZyrATdSK6nu+AIB9CDt/qA9DIJG1rvBaBDt9MKaW9PLfpQU/2bAk8l
         c3Z/TPhD86vkFm2tiDayLxDPCHYSEceziwNw7iI3AYE+xjRahnp2rqc+UsKQAkdP8Xid
         FQrxfJrOGdvoarcjmcy3w9t1+FVyjEIoGrUVa10ZUidt20ZMieHOjcHJnoLiHDzMk2df
         zcpCgVng4gh6Sru4erzvCj9xJy2L//bkqJfqPtVjGonJsMPlUBan26qboOIb16l9euUp
         lZYuJXYczSRbtlskkHJ62VA15I0Mc/HTfWeMfgu42VqogaXrTRqf5r064IlD7w4AVKRw
         loyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMytoFx2LvFyuKeUW/tVAfFUtVjb0kwqupF5F8ZZZ94xptXBveIJV6OZbKENKIfaadE1Vf8TlaRgXPmaYuTw==@vger.kernel.org, AJvYcCXXUJxp7ljbitH5IRmreZjIhYh6rDv3BCDzeAlaBGKewhG6hOJa/EjqhPm+mPW/7Dfall0WiKyg+ueFSB0n@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgl365XZ9LreWt3TpcNKam3Da5LpYcmimePVth3FXhuWqhW5F6
	7TvU1cFU90zCK5OsTTJ70df2q7QkNEeSC3HmaoSje0R9h8KBa1x9DPf1N8ktGoNlQhmPH6dpL4x
	N4mhjZQX8iB/U8LQpmOwWQueI/u/kHSinO88=
X-Google-Smtp-Source: AGHT+IFCr0S8qiwnzY2fQZKMME8ZxQ6Dhru6RJVEkYxx7rN9GAihBrXTJRPRzAJkdAfHPysM+Dam3a8ndw+oqkoINQE=
X-Received: by 2002:a05:620a:1926:b0:7b1:1216:ef33 with SMTP id
 af79cd13be357-7b1124a6247mr1387961585a.7.1728717548571; Sat, 12 Oct 2024
 00:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org> <20241011-work-overlayfs-v2-4-1b43328c5a31@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v2-4-1b43328c5a31@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Oct 2024 09:18:57 +0200
Message-ID: <CAOQ4uxjqwh3jzxrZFBdivsAjeB0d9BumN4ur9A53u07q=A7Kkg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/4] selftests: add overlayfs fd mounting selftests
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:46=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Very cool!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../selftests/filesystems/overlayfs/.gitignore     |   1 +
>  .../selftests/filesystems/overlayfs/Makefile       |   2 +-
>  .../filesystems/overlayfs/set_layers_via_fds.c     | 122 +++++++++++++++=
++++++
>  .../selftests/filesystems/overlayfs/wrappers.h     |   4 +
>  4 files changed, 128 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/.gitignore b/t=
ools/testing/selftests/filesystems/overlayfs/.gitignore
> index 52ae618fdd980ee22424d35d79f077077b132401..e23a18c8b37f2cdbb121496b1=
df1faffd729ad79 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/.gitignore
> +++ b/tools/testing/selftests/filesystems/overlayfs/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  dev_in_maps
> +set_layers_via_fds
> diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/too=
ls/testing/selftests/filesystems/overlayfs/Makefile
> index 56b2b48a765b1d6706faee14616597ed0315f267..e8d1adb021af44588dd7af104=
9de66833bb584ce 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/Makefile
> +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -TEST_GEN_PROGS :=3D dev_in_maps
> +TEST_GEN_PROGS :=3D dev_in_maps set_layers_via_fds
>
>  CFLAGS :=3D -Wall -Werror
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via=
_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d3b497eea5e5c9f718caa4957=
f7fec7c40970502
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
> +
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/mount.h>
> +#include <unistd.h>
> +
> +#include "../../kselftest_harness.h"
> +#include "log.h"
> +#include "wrappers.h"
> +
> +FIXTURE(set_layers_via_fds) {
> +};
> +
> +FIXTURE_SETUP(set_layers_via_fds)
> +{
> +       ASSERT_EQ(mkdir("/set_layers_via_fds", 0755), 0);
> +}
> +
> +FIXTURE_TEARDOWN(set_layers_via_fds)
> +{
> +       umount2("/set_layers_via_fds", 0);
> +       ASSERT_EQ(rmdir("/set_layers_via_fds"), 0);
> +}
> +
> +TEST_F(set_layers_via_fds, set_layers_via_fds)
> +{
> +       int fd_context, fd_tmpfs, fd_overlay;
> +       int layer_fds[5] =3D { -EBADF, -EBADF, -EBADF, -EBADF, -EBADF };
> +       bool layers_found[5] =3D { false, false, false, false, false };
> +       size_t len =3D 0;
> +       char *line =3D NULL;
> +       FILE *f_mountinfo;
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
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "l3", 0755), 0);
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
> +       layer_fds[4] =3D openat(fd_tmpfs, "l3", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[4], 0);
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
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir", NU=
LL, layer_fds[0]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir", N=
ULL, layer_fds[1]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[2]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[3]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[4]), 0);
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
> +       f_mountinfo =3D fopen("/proc/self/mountinfo", "r");
> +       ASSERT_NE(f_mountinfo, NULL);
> +
> +       while (getline(&line, &len, f_mountinfo) !=3D -1) {
> +               char *haystack =3D line;
> +
> +               if (strstr(haystack, "workdir=3D/tmp/w"))
> +                       layers_found[0] =3D true;
> +               if (strstr(haystack, "upperdir=3D/tmp/u"))
> +                       layers_found[1] =3D true;
> +               if (strstr(haystack, "lowerdir+=3D/tmp/l1"))
> +                       layers_found[2] =3D true;
> +               if (strstr(haystack, "lowerdir+=3D/tmp/l2"))
> +                       layers_found[3] =3D true;
> +               if (strstr(haystack, "lowerdir+=3D/tmp/l3"))
> +                       layers_found[4] =3D true;
> +       }
> +       free(line);
> +
> +       for (int i =3D 0; i < 5; i++) {
> +               ASSERT_EQ(layers_found[i], true);
> +               ASSERT_EQ(close(layer_fds[i]), 0);
> +       }
> +
> +       ASSERT_EQ(close(fd_context), 0);
> +       ASSERT_EQ(close(fd_overlay), 0);
> +       ASSERT_EQ(fclose(f_mountinfo), 0);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/filesystems/overlayfs/wrappers.h b/t=
ools/testing/selftests/filesystems/overlayfs/wrappers.h
> index 4f99e10f7f018fd9a7be5263f68d34807da4c53c..071b95fd2ac0ad7b02d90e8e8=
9df73fd27be69c3 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/wrappers.h
> +++ b/tools/testing/selftests/filesystems/overlayfs/wrappers.h
> @@ -32,6 +32,10 @@ static inline int sys_mount(const char *src, const cha=
r *tgt, const char *fst,
>         return syscall(__NR_mount, src, tgt, fst, flags, data);
>  }
>
> +#ifndef MOVE_MOUNT_F_EMPTY_PATH
> +#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted =
*/
> +#endif
> +
>  static inline int sys_move_mount(int from_dfd, const char *from_pathname=
,
>                                  int to_dfd, const char *to_pathname,
>                                  unsigned int flags)
>
> --
> 2.45.2
>

