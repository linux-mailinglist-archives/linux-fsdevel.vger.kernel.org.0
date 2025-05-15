Return-Path: <linux-fsdevel+bounces-49121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DBDAB83C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178E67A40DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293D9297B8F;
	Thu, 15 May 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up89IEba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BF17993;
	Thu, 15 May 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304809; cv=none; b=KAWbChEY1oukBcngam4VE0bt6DXNe5sbqvmLUCg2HEjt1ArxXuCWhcUrO0gt/wYm/ezxeDNdcx6fgFrBdS9PhCsief+IWy8lfQ/W+yGbIzyflKy3T0kAI/Fuxy5ddQHxm5bZaVtxUGeeadoxyYTiZU7BZLTX16ftSAEd2LpcEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304809; c=relaxed/simple;
	bh=SGYb8s74YstOfNuFmzm31OnYn3Cbv8h1LNPiym0T9RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=en17O24TxohFyiLelevXwp6NJKQ7kogWsfX3MgiilVB+rLMsiwXVZGXEi8W9tNDPzBR8OZCt8fX1FlJpHZZBGwI3gzno72Zv33cwqINyBjP5LXta85s7x+dJrx7Qd9POwLA3vP65qt4iAO4eSdVtiuvKstp7qN6rjOrEqlx7P3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up89IEba; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad21a5466f6so372814766b.1;
        Thu, 15 May 2025 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747304806; x=1747909606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFFOReY4sm5nfI68RZ5Fy/BJSwb3mpY9zfvTHChtVSU=;
        b=Up89IEbaD/6D0Ei1c4G7h/tcqk+tkZTS/3UTnaHUiG24qhPKYmX6+X2qUDrFM3WP6/
         aEVaJAW1LMhPZ84COA3pod/KJUyqi9SuFTkp90Zi4JdM0RSo6OvMTN0PxGa3FAUnGmOS
         OvRqRdfe2z0uHJK+2Ri1L+ropP3+z/nlwDNA4hPzjTrrW4mK9OsTsyxO893LQbqIKMGB
         /fqgwrIclBmEIoxkZwJpzVyjmvE/Qu5Sxx6mLYq4Pw3eqlaZz8/d+MUs6hz4q0exIu2t
         Eed4DMireTIXA0SeMNMlPXxrUqY1XiqmyOAS/g4QWgdZFWhJ/pXx1XE9z96ho7WpXGgF
         T4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747304806; x=1747909606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFFOReY4sm5nfI68RZ5Fy/BJSwb3mpY9zfvTHChtVSU=;
        b=s7iH2TosRnB/SlH5zUzE2Gltq+T28qrKq7VuDBSOV68P6uV6CbfsLhyVMuQyZB79Sj
         xFWqp5XHh7RV/pmpv1+PU1XKR8tFIbRtFqjgWsbk+JBloQpqXdLDtuN4oL3VA750ClJE
         iyeZUq4rNcV8A7e9ENBiQms0Db4CQa3YGuOZg+RzDLPHh4OjlF/8imTz5Wl89oplo0Up
         VRkzbqAydJypjxoudNatTiiRSJUsd2D0X1QQQVQmQ5KY0QYJ5q2HJ9OXAMvXKFfsv2pL
         Ce6tei2X23QGsxyfvtLOqpA8eyDJRQ1rj5MMFfh2H4jN3KUWXFS134U7zvI3M01jN7OO
         TEMg==
X-Forwarded-Encrypted: i=1; AJvYcCU3/TqIo9yedrcDNniPokteJm7cJls27UBtZPQfb7u5ylhdCpF6P3PE1LO7a0Fz+c7Nf1rONMaKX2SulpfnHeQo@vger.kernel.org, AJvYcCV04OdSInSdO8RCRgFzyx/YapXWaDXl+3mKFSrmHNY5TUj7l/NFhSMdGftjWA8Oo8RAQu8QzVQDE+/fb9OO@vger.kernel.org, AJvYcCXqVt6TTkYC9LCzghiWnuJd0r/ge1cBrTHEuMoYVc5DicxFAI/WOPHs3BC2ev5mJnOeYdColUrPidUxVfGM@vger.kernel.org
X-Gm-Message-State: AOJu0YwWrm8yuvJwYlbqOcK414pstCJb0awe7rrLxfuF58XaW88QS9Cc
	rFImgTS5pEi2EIg6JIHSKCiCGOzDvLd8PchHdD7EUlMA69h+9MzD4QukDFQBvPlUShgiC++4HUz
	y1gKrOF9LHeRCQdnO8DpUp3eh73WchQbTlCkh/KE=
X-Gm-Gg: ASbGncuz59JsQ55fMYaQWZfN0p388bz3K/Wu0uG6tdrTapbLrHoJLBOlJXXFklZ3q9T
	3A6czj+5iyKj4AOiDO3Azdu7D7xtt3+rzS4n8tmXQM2MsTVmaDIlzjYCu81ctFGFPGiDnxOsVgj
	oNSafLQGqxjOuLNqlEFVMQZaJpptg6N/W8
X-Google-Smtp-Source: AGHT+IGk1Z1UO/ipS6ENcgDpHblpxtgLMTlgiNoI6FsWp1+jlrLPOQ9ixsLDeo0qoG/x7GaUqHPADf5ZBzfeBbAc5Bc=
X-Received: by 2002:a17:907:3f92:b0:aca:c699:8d3c with SMTP id
 a640c23a62f3a-ad50f613040mr299816066b.2.1747304805338; Thu, 15 May 2025
 03:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515073449.346774-2-chenlinxuan@uniontech.com>
In-Reply-To: <20250515073449.346774-2-chenlinxuan@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 May 2025 12:26:33 +0200
X-Gm-Features: AX0GCFuvkFFqffFrfN1N0FqM0kCTPhfTovaXjGahmfHWs2Pi0lykEL3tLQjU8iA
Message-ID: <CAOQ4uxja322ZuOaHm2rLU1mPsqHsuSbAe=0g5Rc_oh=DmBcn0Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: Add functional test for the abort file in fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, wentao@uniontech.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:35=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontech=
.com> wrote:
>
> This patch add a simple functional test for the "about" file
> in fusectlfs (/sys/fs/fuse/connections/ID/about).
>
> A simple fuse daemon is added for testing.
>
> Related discussion can be found in the link below.
>
> Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68U=
cWg_OBhmSY=3DQ@mail.gmail.com/
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/filesystems/fusectl/.gitignore  |   3 +
>  .../selftests/filesystems/fusectl/Makefile    |  21 +++
>  .../selftests/filesystems/fusectl/fuse_mnt.c  | 146 ++++++++++++++++++
>  .../filesystems/fusectl/fusectl_test.c        | 115 ++++++++++++++
>  6 files changed, 287 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/fusectl/.gitignor=
e
>  create mode 100644 tools/testing/selftests/filesystems/fusectl/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/fusectl/fuse_mnt.=
c
>  create mode 100644 tools/testing/selftests/filesystems/fusectl/fusectl_t=
est.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f21f1dabb5fe1..efc6c89113b95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9740,6 +9740,7 @@ T:        git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/mszeredi/fuse.git
>  F:     Documentation/filesystems/fuse.rst
>  F:     fs/fuse/
>  F:     include/uapi/linux/fuse.h
> +F:     tools/testing/selftests/filesystems/fusectl
>
>  FUTEX SUBSYSTEM
>  M:     Thomas Gleixner <tglx@linutronix.de>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 80fb84fa3cfcb..a9bfefa961889 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -36,6 +36,7 @@ TARGETS +=3D filesystems/fat
>  TARGETS +=3D filesystems/overlayfs
>  TARGETS +=3D filesystems/statmount
>  TARGETS +=3D filesystems/mount-notify
> +TARGETS +=3D filesystems/fusectl
>  TARGETS +=3D firmware
>  TARGETS +=3D fpu
>  TARGETS +=3D ftrace
> diff --git a/tools/testing/selftests/filesystems/fusectl/.gitignore b/too=
ls/testing/selftests/filesystems/fusectl/.gitignore
> new file mode 100644
> index 0000000000000..3e72e742d08e8
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fusectl/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +fuse_mnt
> +fusectl_test
> diff --git a/tools/testing/selftests/filesystems/fusectl/Makefile b/tools=
/testing/selftests/filesystems/fusectl/Makefile
> new file mode 100644
> index 0000000000000..612aad69a93aa
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fusectl/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES)
> +
> +TEST_GEN_PROGS :=3D fusectl_test
> +TEST_GEN_FILES :=3D fuse_mnt
> +
> +include ../../lib.mk
> +
> +VAR_CFLAGS :=3D $(shell pkg-config fuse --cflags 2>/dev/null)
> +ifeq ($(VAR_CFLAGS),)
> +VAR_CFLAGS :=3D -D_FILE_OFFSET_BITS=3D64 -I/usr/include/fuse
> +endif
> +
> +VAR_LDLIBS :=3D $(shell pkg-config fuse --libs 2>/dev/null)
> +ifeq ($(VAR_LDLIBS),)
> +VAR_LDLIBS :=3D -lfuse -pthread
> +endif
> +
> +$(OUTPUT)/fuse_mnt: CFLAGS +=3D $(VAR_CFLAGS)
> +$(OUTPUT)/fuse_mnt: LDLIBS +=3D $(VAR_LDLIBS)
> diff --git a/tools/testing/selftests/filesystems/fusectl/fuse_mnt.c b/too=
ls/testing/selftests/filesystems/fusectl/fuse_mnt.c
> new file mode 100644
> index 0000000000000..d12b17f30fadc
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fusectl/fuse_mnt.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * fusectl test file-system
> + * Creates a simple FUSE filesystem with a single read-write file (/test=
)
> + */
> +
> +#define FUSE_USE_VERSION 26
> +
> +#include <fuse.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> +
> +static char *content;
> +static size_t content_size =3D 0;
> +static const char test_path[] =3D "/test";
> +
> +static int test_getattr(const char *path, struct stat *st)
> +{
> +       memset(st, 0, sizeof(*st));
> +
> +       if (!strcmp(path, "/")) {
> +               st->st_mode =3D S_IFDIR | 0755;
> +               st->st_nlink =3D 2;
> +               return 0;
> +       }
> +
> +       if (!strcmp(path, test_path)) {
> +               st->st_mode =3D S_IFREG | 0664;
> +               st->st_nlink =3D 1;
> +               st->st_size =3D content_size;
> +               return 0;
> +       }
> +
> +       return -ENOENT;
> +}
> +
> +static int test_readdir(const char *path, void *buf, fuse_fill_dir_t fil=
ler,
> +                       off_t offset, struct fuse_file_info *fi)
> +{
> +       if (strcmp(path, "/"))
> +               return -ENOENT;
> +
> +       filler(buf, ".", NULL, 0);
> +       filler(buf, "..", NULL, 0);
> +       filler(buf, test_path + 1, NULL, 0);
> +
> +       return 0;
> +}
> +
> +static int test_open(const char *path, struct fuse_file_info *fi)
> +{
> +       if (strcmp(path, test_path))
> +               return -ENOENT;
> +
> +       return 0;
> +}
> +
> +static int test_read(const char *path, char *buf, size_t size, off_t off=
set,
> +                    struct fuse_file_info *fi)
> +{
> +       if (strcmp(path, test_path) !=3D 0)
> +               return -ENOENT;
> +
> +       if (!content || content_size =3D=3D 0)
> +               return 0;
> +
> +       if (offset >=3D content_size)
> +               return 0;
> +
> +       if (offset + size > content_size)
> +               size =3D content_size - offset;
> +
> +       memcpy(buf, content + offset, size);
> +
> +       return size;
> +}
> +
> +static int test_write(const char *path, const char *buf, size_t size,
> +                     off_t offset, struct fuse_file_info *fi)
> +{
> +       size_t new_size;
> +
> +       if (strcmp(path, test_path) !=3D 0)
> +               return -ENOENT;
> +
> +       if(offset > content_size)
> +               return -EINVAL;
> +
> +       new_size =3D MAX(offset + size, content_size);
> +
> +       if (new_size > content_size)
> +               content =3D realloc(content, new_size);
> +
> +       content_size =3D new_size;
> +
> +       if (!content)
> +               return -ENOMEM;
> +
> +       memcpy(content + offset, buf, size);
> +
> +       return size;
> +}
> +
> +static int test_truncate(const char *path, off_t size)
> +{
> +       if (strcmp(path, test_path) !=3D 0)
> +               return -ENOENT;
> +
> +       if (size =3D=3D 0) {
> +               free(content);
> +               content =3D NULL;
> +               content_size =3D 0;
> +               return 0;
> +       }
> +
> +       content =3D realloc(content, size);
> +
> +       if (!content)
> +               return -ENOMEM;
> +
> +       if (size > content_size)
> +               memset(content + content_size, 0, size - content_size);
> +
> +       content_size =3D size;
> +       return 0;
> +}
> +
> +static struct fuse_operations memfd_ops =3D {
> +       .getattr =3D test_getattr,
> +       .readdir =3D test_readdir,
> +       .open =3D test_open,
> +       .read =3D test_read,
> +       .write =3D test_write,
> +       .truncate =3D test_truncate,
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +       return fuse_main(argc, argv, &memfd_ops, NULL);
> +}
> diff --git a/tools/testing/selftests/filesystems/fusectl/fusectl_test.c b=
/tools/testing/selftests/filesystems/fusectl/fusectl_test.c
> new file mode 100644
> index 0000000000000..8ff130ae43122
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fusectl/fusectl_test.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2025 Chen Linxuan <chenlinxuan@uniontech.com>
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <dirent.h>
> +#include <linux/limits.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define FUSECTL_MOUNTPOINT "/sys/fs/fuse/connections"
> +#define FUSE_MOUNTPOINT "/tmp/fuse_mnt_XXXXXX"
> +#define FUSE_DEVICE "/dev/fuse"
> +#define FUSECTL_TEST_VALUE "1"
> +
> +FIXTURE(fusectl){
> +       char fuse_mountpoint[sizeof(FUSE_MOUNTPOINT)];
> +       int connection;
> +};
> +
> +FIXTURE_SETUP(fusectl)
> +{
> +       const char *fuse_mnt_prog =3D "./fuse_mnt";
> +       int status, pid;
> +       struct stat statbuf;
> +
> +       strcpy(self->fuse_mountpoint, FUSE_MOUNTPOINT);
> +
> +       if (!mkdtemp(self->fuse_mountpoint))
> +               SKIP(return,
> +                    "Failed to create FUSE mountpoint %s",
> +                    strerror(errno));
> +
> +       if (access(FUSECTL_MOUNTPOINT, F_OK))
> +               SKIP(return,
> +                    "FUSE control filesystem not mounted");
> +
> +       pid =3D fork();
> +       if (pid < 0)
> +               SKIP(return,
> +                    "Failed to fork FUSE daemon process: %s",
> +                    strerror(errno));
> +
> +       if (pid =3D=3D 0) {
> +               execlp(fuse_mnt_prog, fuse_mnt_prog, self->fuse_mountpoin=
t, NULL);
> +               exit(errno);
> +       }
> +
> +       waitpid(pid, &status, 0);
> +       if (!WIFEXITED(status) || WEXITSTATUS(status) !=3D 0) {
> +               SKIP(return,
> +                    "Failed to start FUSE daemon %s",
> +                    strerror(WEXITSTATUS(status)));
> +       }
> +
> +       if (stat(self->fuse_mountpoint, &statbuf))
> +               SKIP(return,
> +                    "Failed to stat FUSE mountpoint %s",
> +                    strerror(errno));
> +
> +       self->connection =3D statbuf.st_dev;
> +}
> +
> +FIXTURE_TEARDOWN(fusectl)
> +{
> +       umount(self->fuse_mountpoint);
> +       rmdir(self->fuse_mountpoint);
> +}
> +
> +TEST_F(fusectl, abort)
> +{
> +       char path_buf[PATH_MAX];
> +       int abort_fd, test_fd, ret;
> +
> +       sprintf(path_buf, "/sys/fs/fuse/connections/%d/abort", self->conn=
ection);
> +
> +       ASSERT_EQ(0, access(path_buf, F_OK));
> +
> +       abort_fd =3D open(path_buf, O_WRONLY);
> +       ASSERT_GE(abort_fd, 0);
> +
> +       sprintf(path_buf, "%s/test", self->fuse_mountpoint);
> +
> +       test_fd =3D open(path_buf, O_RDWR);
> +       ASSERT_GE(test_fd, 0);
> +
> +       ret =3D read(test_fd, path_buf, sizeof(path_buf));
> +       ASSERT_EQ(ret, 0);
> +
> +       ret =3D write(test_fd, "test", sizeof("test"));
> +       ASSERT_EQ(ret, sizeof("test"));
> +
> +       ret =3D lseek(test_fd, 0, SEEK_SET);
> +       ASSERT_GE(ret, 0);
> +
> +       ret =3D write(abort_fd, FUSECTL_TEST_VALUE, sizeof(FUSECTL_TEST_V=
ALUE));
> +       ASSERT_GT(ret, 0);
> +
> +       close(abort_fd);
> +
> +       ret =3D read(test_fd, path_buf, sizeof(path_buf));
> +       ASSERT_LT(ret, 0);

Nice!
I guess you could also verify errno =3D=3D ENOTCONN or whatever it is
in this case.

Thanks,
Amir.

