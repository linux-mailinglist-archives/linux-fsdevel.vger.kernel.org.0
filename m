Return-Path: <linux-fsdevel+bounces-49836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B31AC3979
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 07:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DCE189181A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 05:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3156D1C861D;
	Mon, 26 May 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1zMflKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E5189B80;
	Mon, 26 May 2025 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239105; cv=none; b=LkS0xIV/Lr/wlyWiKVxqmKzxTRwhQfft1L/riHG1aTBl7T6zX/mkGRFQGMxIgygk1heGar0EZisHLgUdRuR2mk6Ycc+vKqzDl31YiM4hW/BGlZ8nSesoMIONxenzcc+/qA2Tkc5iFL5Bcu8YbAB6BLBeAOZK5qW692mMpnBMdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239105; c=relaxed/simple;
	bh=Nofov7s8dZf8Hg3lJMJaJJMLTFrNmkuCfxBDBPxm+mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuJf10W0wiDSB29ZNw2IeLP/b4ZHHJ/CSg9j7qLE8aDTGk0oeiXSFWJ4IouvN86A4gn9rVX0rCK40eNt9ABcoKqPOU6lAqVGvZ+QOhIFzYHy1/HqJamIhljuqo5QcpMIx8TR38pQTixUu2GHswf4Vsv8+8DkRPimIWNNCzz9X2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1zMflKs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acacb8743a7so351201066b.1;
        Sun, 25 May 2025 22:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748239102; x=1748843902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8muxlJ9QQ5RsN4xaq/pJ7Lx6DjenCrKy/oIxsSIu3o=;
        b=H1zMflKs+oFPvQelyHvnzYpf0BuxBoHLuIxiSkCt6I1sErBZrd+k0Ocyfs1ELCQnja
         hIBOqqWggdxQMwUrtUT1/ximKIujMapenMV8lk4mxkQcAe9c+K1028nmZ7lsFCSEE9DC
         sJwoZ/K0YzUW9zwrJwACkXjSAfZrwf4IByeI50PcvS+T3/seT0BmAi0Hky5bILDa2NwX
         vykGXTwr23HgMtMrUcmL2zsSs//JcTLqJ1iukHkmiMSXkRPHs/T8r8dVOuaTLuo33Q72
         Au5HIycEnzqYUa3HVLChto5f9zpTosbyXBqKBhAvzkXTJD7+wuGghqZAtQwP04Y5VOdh
         ++jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748239102; x=1748843902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8muxlJ9QQ5RsN4xaq/pJ7Lx6DjenCrKy/oIxsSIu3o=;
        b=LTBAOIAjhauJAfdadqIOiVeolE3KkZpPSA42p3YTQPexp+kaeV+43o6GZ3qzDvGYyf
         /iDZlspPdFtBe8VXtTH6lWhjDSalvpzn8nh9ssPGE+zUrqWV2d4ySr6qpSIjqK+cWxL/
         EI2HLphJbx6Xm+w8f3HU2Kq9l56scI23z/tInVI9Va1Hi1IxU4CVTdw0ojbBi0Df584J
         Um2jvXeixI+LAmLe5oZJ2jKCk6YjtsKGUm74vSMuIi6zDRUe7dFQiFtfQYcW6+qQstqU
         3gacBpsDYX2kDRyus1jDeaaAGHqnZVwF8f5NCMXE9J7KlXptJmVrzwaoy9f7EMzOYvqf
         GZlg==
X-Forwarded-Encrypted: i=1; AJvYcCUB+wWoTaY+oDwW5yP0N5u8YBoIzNkSVPlNsqoF22EYjSTsD+v+A+Qctf8YZPJyiDGlm9i23DRvr/6va/E0@vger.kernel.org, AJvYcCVjmCrMbBQJ9jZdYbZB3uibhrWj6BeAkXfKQQpdcDqJxu+c0aA+rosdBvCozMEAXKCLo2puDW5g7cJUH3XP@vger.kernel.org, AJvYcCVormvemVTydzEpbGyvswLRwhSWkqJWpDxJGmEhs4kyMsuHXN5VT6zGCaqa9rtzaSyuGB4V3BDpGb2Aqo2ktz47@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPEB6DIivnroMPtM2WK8HXR9z6qUE2R+Buntm1xxcnWnDU0Jl
	8pyXw8sFnyTfsAOllcLMbUh8sDLb+m18yWIJBdr9o6u2rwYWJPU72sk9bg7JbaRwCKTqkTvsPQi
	Kp+osBScyE+hA7DFaJA3JKfOhifI+ECFR2Qro5+DsFw==
X-Gm-Gg: ASbGncsGWU3FE6DL396Q4lyxDNuQA5UhcRQokIkDpYNKdNHon7Rw6EZ5Vz8YCx6MaMD
	EGQOrAjpfV+35X4HzT3nDKsy7yyHd11OFvZuOmUgOO/Uc/7h9QTKPlpnREwDYAjLngNJxQTG/9U
	z+Is+R4iAH/OIEGOxrcxVtTI3BzWi9W0oJ
X-Google-Smtp-Source: AGHT+IGjMMt+s2I/UpHlSz2OZluNDLHVzMS6hYnAvP7vVYCIm7LTsP6iLLoU08NPto0o4qFXpRy0yVoiSE2gTkzPBjo=
X-Received: by 2002:a17:907:f509:b0:ad5:2e15:2a7b with SMTP id
 a640c23a62f3a-ad63f97fec8mr1326651966b.2.1748239101347; Sun, 25 May 2025
 22:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526014226.14192-1-chenlinxuan@uniontech.com>
In-Reply-To: <20250526014226.14192-1-chenlinxuan@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 26 May 2025 07:58:09 +0200
X-Gm-Features: AX0GCFvu6RQm_79akiPRVgtjyaE_cIJ4Td5S3nTqmxzUYgEUkDEVEbal4KBEVQo
Message-ID: <CAOQ4uxh6rsoXbLxnJn-We306KRSThu5boxbVGyNQ10B2fLAkZA@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: filesystems: Add functional test for the
 abort file in fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, wentao@uniontech.com, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 3:43=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontech=
.com> wrote:
>
> This patch add a simple functional test for the "abort" file
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
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v3:
> - Apply changes suggested by Amir Goldstein
>   - Rename the test subdir to filesystems/fuse
>   - Verify errno when connection is aborted
> - Apply changes suggested by Shuah Khan
>   - Update commit message
> - Link to v2: https://lore.kernel.org/all/20250517012350.10317-2-chenlinx=
uan@uniontech.com/
> Changes in v2:
> - Apply changes suggested by Amir Goldstein
>    - Check errno
> - Link to v1: https://lore.kernel.org/all/20250515073449.346774-2-chenlin=
xuan@uniontech.com/
> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/filesystems/fuse/.gitignore     |   3 +
>  .../selftests/filesystems/fuse/Makefile       |  21 +++
>  .../selftests/filesystems/fuse/fuse_mnt.c     | 146 ++++++++++++++++++
>  .../selftests/filesystems/fuse/fusectl_test.c | 116 ++++++++++++++
>  6 files changed, 288 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
>  create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_mnt.c
>  create mode 100644 tools/testing/selftests/filesystems/fuse/fusectl_test=
.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd844ac8d9107..55bf95f06dbb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9740,6 +9740,7 @@ T:        git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/mszeredi/fuse.git
>  F:     Documentation/filesystems/fuse.rst
>  F:     fs/fuse/
>  F:     include/uapi/linux/fuse.h
> +F:     tools/testing/selftests/filesystems/fuse/
>
>  FUTEX SUBSYSTEM
>  M:     Thomas Gleixner <tglx@linutronix.de>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 80fb84fa3cfcb..cadd4c217f3e0 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -36,6 +36,7 @@ TARGETS +=3D filesystems/fat
>  TARGETS +=3D filesystems/overlayfs
>  TARGETS +=3D filesystems/statmount
>  TARGETS +=3D filesystems/mount-notify
> +TARGETS +=3D filesystems/fuse
>  TARGETS +=3D firmware
>  TARGETS +=3D fpu
>  TARGETS +=3D ftrace
> diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/=
testing/selftests/filesystems/fuse/.gitignore
> new file mode 100644
> index 0000000000000..3e72e742d08e8
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fuse/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +fuse_mnt
> +fusectl_test
> diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/te=
sting/selftests/filesystems/fuse/Makefile
> new file mode 100644
> index 0000000000000..612aad69a93aa
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fuse/Makefile
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
> diff --git a/tools/testing/selftests/filesystems/fuse/fuse_mnt.c b/tools/=
testing/selftests/filesystems/fuse/fuse_mnt.c
> new file mode 100644
> index 0000000000000..d12b17f30fadc
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fuse/fuse_mnt.c
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
> diff --git a/tools/testing/selftests/filesystems/fuse/fusectl_test.c b/to=
ols/testing/selftests/filesystems/fuse/fusectl_test.c
> new file mode 100644
> index 0000000000000..7050fbe0970e7
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fuse/fusectl_test.c
> @@ -0,0 +1,116 @@
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
> +       ASSERT_EQ(ret, -1);
> +       ASSERT_EQ(errno, ENOTCONN);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.43.0
>

