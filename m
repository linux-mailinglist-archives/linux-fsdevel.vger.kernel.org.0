Return-Path: <linux-fsdevel+bounces-60833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE4B51EF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 19:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0678F189CBA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C231DD8C;
	Wed, 10 Sep 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DttwO0Gi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905629ACC5;
	Wed, 10 Sep 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525421; cv=none; b=ItpxhF6UUEkzUCMWkXfjRaMrizAlu7Vdj+5aO9LAibNVTV4iDa14LzhAD7uYHE/pa9NbZxkmEY9cgfgpdgaFI/Y+4Ml/Lw+2ksa7O+gEgXuHjPUnfKZEf9kY3X09D4l3JxxZcRuwXOWZc8z9kDJiESzSyAweljdjWWBIouIUpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525421; c=relaxed/simple;
	bh=7ksjb6VZLD+tnxtP+E98W+MggmvbmsXQYsM9UII/I6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChVLw9GANESNlqDqmjIOGMZINvQaUiJHqYxZEpJ+z8yKy3UpWPP0j+4W4CJxQhwZ/aueuKUYcsctcuoUy3+4DmZ7TdA64Td5HA8Jixy1kMCSDpjNwzZ+hC8T8hRM2Jr1/tOEaKGYx/kTNtluRQYrLr3RBlSiUsy/49ONdNqOyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DttwO0Gi; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62733e779bbso5099524a12.1;
        Wed, 10 Sep 2025 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757525416; x=1758130216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijQq2MmaxE0rHESfDC4prGfsl57ijVqB1363ttzFk/U=;
        b=DttwO0Gi6nk0ZhFwLzBS2ejTHY4SgsEM++2d90aJzowSJl+LnqjZVvuQKNYZP+cBMw
         j54HlfBl8LEbeFjPcxbHBD3+Z9ban43/3vetZ+u0S/j+baVq0UutETjS09wElLEmGUQW
         i99jj/dgaj8IQy47/rhcz+inJKgD7LHKhRADF9x2TLF+wKyH4pt8g7QQW7JKD5tqL/JO
         17mP9VuMQuzw8gCsLpzQdGxfvIZtgzCpQ1E8mA5fJtk2uSphQzXyIoFVa+CqRRxMsRz7
         1Dj/DbOHyzmxUYos0Bs9BYAkaKxft4oXos6lwexm+bKbf+BB6tLK2N+QxOY7smgwPp7J
         eY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757525416; x=1758130216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijQq2MmaxE0rHESfDC4prGfsl57ijVqB1363ttzFk/U=;
        b=ZDdQnwISK4cxRBU30TGYi6WnAPQzr/GYereAKuY+Drx+uzCNAK8f9oN5OfP/2/pV64
         nKSUWTqn1xaKA4vdLjkT+V0gbXA+bzL7TGqwgOpz8zNzqIhSazB7fAnM1E9Bk9IbFHFo
         ZMCokP5kJk/m7AJkh5jKRLjcM6M/UabfTPh5GctK37qbedxbCiPSOdG2JRHk2X4EIIBE
         Sjdl6iN57zHELSxG3/Iv+6soX1ozRhzG4PfggZai52E5njuCUCCRyPSkRVS+dH2zQPMQ
         XpFCRzt3l0VWewhZGS+cmszjm7BPsNQsT2q6EWEXrMytnAzmRLLabCcMgOw/6mUxg9Dg
         gglg==
X-Forwarded-Encrypted: i=1; AJvYcCUIwO3ETIf542CXZjkWxbjrmtH+77SbyZ5JKodU+r7ihHcdtzb9nnhWt4f3XlIjwHCWaKLjjxZZscNOynirWQ==@vger.kernel.org, AJvYcCV5+gL7hifcUEG10v0/RPgy3wdrmycCjc3b9wtaIIg9GDnFPwNTbxIdDlvd8sDMLQ0L+m2JPRBc@vger.kernel.org, AJvYcCVOq57ZTEBiHeOdgOsZUSkeU0EkTZ/qzJwtnzWdwR2FBg8Q4j3Ka67BWM7I4cxcVhoQrrYv9T5B0UAceXmE@vger.kernel.org, AJvYcCVlPlIV7iiFQT3TurYIVCBFqmNJu25qA4dLw1zl7cjJjnqPQJeBM8gk0k8VmHm7P8YTqVUue9sc@vger.kernel.org, AJvYcCWgOIjHf69J8wFjye3mFl0P+tqc5B6NpXkm1O7mIZDMiI1P8vKGiZ+pDY2cn5wl6YO+2Tzpwi3RAydO@vger.kernel.org, AJvYcCXF53CAGuFZAD+rtBbkUzdiQaBW6sl5feZYZPoorbhEXAPlIfyYR99K9dHIxHqk5LaJpYldw0skj+FPuxI=@vger.kernel.org, AJvYcCXFIvZqj2QWLpTmj75BMGHl1U2XWbKLnvCz/oxEn6cVBp7RiSKU4945lp0leZMQ9elNJcJZBItSTIWarSVCoj6Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzv/IZ2sEfGQDqIx2GLphf7Q3xjwUyWjml9cChwFx7viWh3Lt
	HhqKj2bkyctjZa9X9bLwy/uJHTU0qQOwPp66ncyeI7FSZmYGjvVZG3m/XiJBP8bLTUP8kKDQf3J
	hQpqKOP7blDNOzznSVO0zqkGSFAH4GTg=
X-Gm-Gg: ASbGncvbQqf1z5xEn6vwVS8PbJe8ESIERk236tld7+TsxWBvI3nvZgj2wF2km8C82N5
	Z1kLXctDDsJobT/1RDp5vulT7HW15bUcbM4MkQqoViEWLNKdAg3/gFgaKkEOu5hTkBVtkquGlPV
	0lqDv9nnb1HGu+yxFfaN4P+S/ePoxIDomo0zUH4L49LQh3qLHSvwHzBC/UtoSwjbkmJrEMMkcYU
	Rcs9oA=
X-Google-Smtp-Source: AGHT+IF/kSpvgxpMFr7z/pqzrqX7HroNg36kcFo/pXltIB0NGQxLUtZF88G5OIqyFTE8GM1tI2ctbWuAoBOwM/U3IKc=
X-Received: by 2002:a05:6402:d0d:b0:628:79f4:b050 with SMTP id
 4fb4d7f45d1cf-62879f4b986mr9648891a12.30.1757525415693; Wed, 10 Sep 2025
 10:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org> <20250910-work-namespace-v1-32-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-32-4dd56e7359d8@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Sep 2025 19:30:03 +0200
X-Gm-Features: AS18NWDxW6JTWqT4RCe5H_x6IXY4E-emwUFbLYLV_O5URPqKDZoOZ-SG5YEp7f8
Message-ID: <CAOQ4uxhwJBLCzfKs0dVFOpcgP=LQU5hkRxVeLLR6g-qOxb9ocQ@mail.gmail.com>
Subject: Re: [PATCH 32/32] selftests/namespaces: add file handle selftests
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:40=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Add a bunch of selftests for namespace file handles.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Obviously, I did not go over every single line, but for the general
test template and test coverage you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

However, see my comment on file handle support patch.
The test matrix is incomplete.
Maybe it would be complete if test is run as root and then
as non root, but then I think the test needs some changes
for running as root and opening non-self ns.

I am not sure what the standard is wrt running the selftests
as root /non-root.

I see that the userns isolation tests do:
/* Map current uid/gid to root in the new namespace */

Are you assuming that non root is running this test
or am I missing something?

Wouldn't mapping uid 0 to uid 0 in the new userns cause
the test to fail because opening by handle will succeed?

Thanks,
Amir.


> ---
>  tools/testing/selftests/namespaces/.gitignore      |    1 +
>  tools/testing/selftests/namespaces/Makefile        |    2 +-
>  .../selftests/namespaces/file_handle_test.c        | 1410 ++++++++++++++=
++++++
>  3 files changed, 1412 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testin=
g/selftests/namespaces/.gitignore
> index c1e8d634dd21..7639dbf58bbf 100644
> --- a/tools/testing/selftests/namespaces/.gitignore
> +++ b/tools/testing/selftests/namespaces/.gitignore
> @@ -1 +1,2 @@
>  nsid_test
> +file_handle_test
> diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/=
selftests/namespaces/Makefile
> index 9280c703533e..f6c117ce2c2b 100644
> --- a/tools/testing/selftests/namespaces/Makefile
> +++ b/tools/testing/selftests/namespaces/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS +=3D -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>
> -TEST_GEN_PROGS :=3D nsid_test
> +TEST_GEN_PROGS :=3D nsid_test file_handle_test
>
>  include ../lib.mk
>
> diff --git a/tools/testing/selftests/namespaces/file_handle_test.c b/tool=
s/testing/selftests/namespaces/file_handle_test.c
> new file mode 100644
> index 000000000000..87573fa06990
> --- /dev/null
> +++ b/tools/testing/selftests/namespaces/file_handle_test.c
> @@ -0,0 +1,1410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <grp.h>
> +#include <limits.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <linux/unistd.h>
> +#include "../kselftest_harness.h"
> +
> +#ifndef FD_NSFS_ROOT
> +#define FD_NSFS_ROOT -10003 /* Root of the nsfs filesystem */
> +#endif
> +
> +TEST(nsfs_net_handle)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +       struct stat st1, st2;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open a namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/net");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Try to open using FD_NSFS_ROOT */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +       if (fd < 0 && (errno =3D=3D EINVAL || errno =3D=3D EOPNOTSUPP)) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return,
> +                          "open_by_handle_at with FD_NSFS_ROOT not suppo=
rted");
> +       }
> +       ASSERT_GE(fd, 0);
> +
> +       /* Verify we opened the correct namespace */
> +       ASSERT_EQ(fstat(ns_fd, &st1), 0);
> +       ASSERT_EQ(fstat(fd, &st2), 0);
> +       ASSERT_EQ(st1.st_ino, st2.st_ino);
> +       ASSERT_EQ(st1.st_dev, st2.st_dev);
> +
> +       close(fd);
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST(nsfs_uts_handle)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +       struct stat st1, st2;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open UTS namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/uts");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Try to open using FD_NSFS_ROOT */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +       if (fd < 0 && (errno =3D=3D EINVAL || errno =3D=3D EOPNOTSUPP)) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return,
> +                          "open_by_handle_at with FD_NSFS_ROOT not suppo=
rted");
> +       }
> +       ASSERT_GE(fd, 0);
> +
> +       /* Verify we opened the correct namespace */
> +       ASSERT_EQ(fstat(ns_fd, &st1), 0);
> +       ASSERT_EQ(fstat(fd, &st2), 0);
> +       ASSERT_EQ(st1.st_ino, st2.st_ino);
> +       ASSERT_EQ(st1.st_dev, st2.st_dev);
> +
> +       close(fd);
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST(nsfs_ipc_handle)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +       struct stat st1, st2;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open IPC namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/ipc");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Try to open using FD_NSFS_ROOT */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +       if (fd < 0 && (errno =3D=3D EINVAL || errno =3D=3D EOPNOTSUPP)) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return,
> +                          "open_by_handle_at with FD_NSFS_ROOT not suppo=
rted");
> +       }
> +       ASSERT_GE(fd, 0);
> +
> +       /* Verify we opened the correct namespace */
> +       ASSERT_EQ(fstat(ns_fd, &st1), 0);
> +       ASSERT_EQ(fstat(fd, &st2), 0);
> +       ASSERT_EQ(st1.st_ino, st2.st_ino);
> +       ASSERT_EQ(st1.st_dev, st2.st_dev);
> +
> +       close(fd);
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST(nsfs_pid_handle)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +       struct stat st1, st2;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open PID namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/pid");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Try to open using FD_NSFS_ROOT */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +       if (fd < 0 && (errno =3D=3D EINVAL || errno =3D=3D EOPNOTSUPP)) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return,
> +                          "open_by_handle_at with FD_NSFS_ROOT not suppo=
rted");
> +       }
> +       ASSERT_GE(fd, 0);
> +
> +       /* Verify we opened the correct namespace */
> +       ASSERT_EQ(fstat(ns_fd, &st1), 0);
> +       ASSERT_EQ(fstat(fd, &st2), 0);
> +       ASSERT_EQ(st1.st_ino, st2.st_ino);
> +       ASSERT_EQ(st1.st_dev, st2.st_dev);
> +
> +       close(fd);
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST(nsfs_mnt_handle)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +       struct stat st1, st2;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open mount namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/mnt");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Try to open using FD_NSFS_ROOT */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +       if (fd < 0 && (errno =3D=3D EINVAL || errno =3D=3D EOPNOTSUPP)) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return,
> +                          "open_by_handle_at with FD_NSFS_ROOT not suppo=
rted");
> +       }
> +       ASSERT_GE(fd, 0);
> +
> +       /* Verify we opened the correct namespace */
> +       ASSERT_EQ(fstat(ns_fd, &st1), 0);
> +       ASSERT_EQ(fstat(fd, &st2), 0);
> +       ASSERT_EQ(st1.st_ino, st2.st_ino);
> +       ASSERT_EQ(st1.st_dev, st2.st_dev);
> +
> +       close(fd);
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST(nsfs_user_handle)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +       struct stat st1, st2;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open user namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/user");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Try to open using FD_NSFS_ROOT */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +       if (fd < 0 && (errno =3D=3D EINVAL || errno =3D=3D EOPNOTSUPP)) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return,
> +                          "open_by_handle_at with FD_NSFS_ROOT not suppo=
rted");
> +       }
> +       ASSERT_GE(fd, 0);
> +
> +       /* Verify we opened the correct namespace */
> +       ASSERT_EQ(fstat(ns_fd, &st1), 0);
> +       ASSERT_EQ(fstat(fd, &st2), 0);
> +       ASSERT_EQ(st1.st_ino, st2.st_ino);
> +       ASSERT_EQ(st1.st_dev, st2.st_dev);
> +
> +       close(fd);
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST(nsfs_cgroup_handle)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +       struct stat st1, st2;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open cgroup namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/cgroup");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       if (ns_fd < 0) {
> +               SKIP(free(handle); return, "cgroup namespace not availabl=
e");
> +       }
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Try to open using FD_NSFS_ROOT */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +       if (fd < 0 && (errno =3D=3D EINVAL || errno =3D=3D EOPNOTSUPP)) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return,
> +                          "open_by_handle_at with FD_NSFS_ROOT not suppo=
rted");
> +       }
> +       ASSERT_GE(fd, 0);
> +
> +       /* Verify we opened the correct namespace */
> +       ASSERT_EQ(fstat(ns_fd, &st1), 0);
> +       ASSERT_EQ(fstat(fd, &st2), 0);
> +       ASSERT_EQ(st1.st_ino, st2.st_ino);
> +       ASSERT_EQ(st1.st_dev, st2.st_dev);
> +
> +       close(fd);
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST(nsfs_time_handle)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +       struct stat st1, st2;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open time namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/time");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       if (ns_fd < 0) {
> +               SKIP(free(handle); return, "time namespace not available"=
);
> +       }
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Try to open using FD_NSFS_ROOT */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +       if (fd < 0 && (errno =3D=3D EINVAL || errno =3D=3D EOPNOTSUPP)) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return,
> +                          "open_by_handle_at with FD_NSFS_ROOT not suppo=
rted");
> +       }
> +       ASSERT_GE(fd, 0);
> +
> +       /* Verify we opened the correct namespace */
> +       ASSERT_EQ(fstat(ns_fd, &st1), 0);
> +       ASSERT_EQ(fstat(fd, &st2), 0);
> +       ASSERT_EQ(st1.st_ino, st2.st_ino);
> +       ASSERT_EQ(st1.st_dev, st2.st_dev);
> +
> +       close(fd);
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST(nsfs_user_net_namespace_isolation)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       pid_t pid;
> +       int status;
> +       int pipefd[2];
> +       char result;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Create pipe for communication */
> +       ASSERT_EQ(pipe(pipefd), 0);
> +
> +       /* Get handle for current network namespace */
> +       ns_fd =3D open("/proc/self/ns/net", O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd); close(pipefd[0]);
> +                    close(pipefd[1]);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       close(ns_fd);
> +
> +       pid =3D fork();
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid =3D=3D 0) {
> +               /* Child process */
> +               close(pipefd[0]);
> +
> +               /* First create new user namespace to drop privileges */
> +               ret =3D unshare(CLONE_NEWUSER);
> +               if (ret < 0) {
> +                       write(pipefd[1], "U",
> +                             1); /* Unable to create user namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Write uid/gid mappings to maintain some capabilities *=
/
> +               int uid_map_fd =3D open("/proc/self/uid_map", O_WRONLY);
> +               int gid_map_fd =3D open("/proc/self/gid_map", O_WRONLY);
> +               int setgroups_fd =3D open("/proc/self/setgroups", O_WRONL=
Y);
> +
> +               if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0)=
 {
> +                       write(pipefd[1], "M", 1); /* Unable to set mappin=
gs */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Disable setgroups to allow gid mapping */
> +               write(setgroups_fd, "deny", 4);
> +               close(setgroups_fd);
> +
> +               /* Map current uid/gid to root in the new namespace */
> +               char mapping[64];
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
> +               write(uid_map_fd, mapping, strlen(mapping));
> +               close(uid_map_fd);
> +
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
> +               write(gid_map_fd, mapping, strlen(mapping));
> +               close(gid_map_fd);
> +
> +               /* Now create new network namespace */
> +               ret =3D unshare(CLONE_NEWNET);
> +               if (ret < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to create network namespace *=
/
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Try to open parent's network namespace handle from new=
 user+net namespace */
> +               fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +
> +               if (fd >=3D 0) {
> +                       /* Should NOT succeed - we're in a different user=
 namespace */
> +                       write(pipefd[1], "S", 1); /* Unexpected success *=
/
> +                       close(fd);
> +               } else if (errno =3D=3D ESTALE) {
> +                       /* Expected: Stale file handle */
> +                       write(pipefd[1], "P", 1);
> +               } else {
> +                       /* Other error */
> +                       write(pipefd[1], "F", 1);
> +               }
> +
> +               close(pipefd[1]);
> +               exit(0);
> +       }
> +
> +       /* Parent process */
> +       close(pipefd[1]);
> +       ASSERT_EQ(read(pipefd[0], &result, 1), 1);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       if (result =3D=3D 'U') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new user namespace");
> +       }
> +       if (result =3D=3D 'M') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot set uid/gid mappings");
> +       }
> +       if (result =3D=3D 'N') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new network namespace");
> +       }
> +
> +       /* Should fail with permission denied since we're in a different =
user namespace */
> +       ASSERT_EQ(result, 'P');
> +
> +       close(pipefd[0]);
> +       free(handle);
> +}
> +
> +TEST(nsfs_user_uts_namespace_isolation)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       pid_t pid;
> +       int status;
> +       int pipefd[2];
> +       char result;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Create pipe for communication */
> +       ASSERT_EQ(pipe(pipefd), 0);
> +
> +       /* Get handle for current UTS namespace */
> +       ns_fd =3D open("/proc/self/ns/uts", O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd); close(pipefd[0]);
> +                    close(pipefd[1]);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       close(ns_fd);
> +
> +       pid =3D fork();
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid =3D=3D 0) {
> +               /* Child process */
> +               close(pipefd[0]);
> +
> +               /* First create new user namespace to drop privileges */
> +               ret =3D unshare(CLONE_NEWUSER);
> +               if (ret < 0) {
> +                       write(pipefd[1], "U",
> +                             1); /* Unable to create user namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Write uid/gid mappings to maintain some capabilities *=
/
> +               int uid_map_fd =3D open("/proc/self/uid_map", O_WRONLY);
> +               int gid_map_fd =3D open("/proc/self/gid_map", O_WRONLY);
> +               int setgroups_fd =3D open("/proc/self/setgroups", O_WRONL=
Y);
> +
> +               if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0)=
 {
> +                       write(pipefd[1], "M", 1); /* Unable to set mappin=
gs */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Disable setgroups to allow gid mapping */
> +               write(setgroups_fd, "deny", 4);
> +               close(setgroups_fd);
> +
> +               /* Map current uid/gid to root in the new namespace */
> +               char mapping[64];
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
> +               write(uid_map_fd, mapping, strlen(mapping));
> +               close(uid_map_fd);
> +
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
> +               write(gid_map_fd, mapping, strlen(mapping));
> +               close(gid_map_fd);
> +
> +               /* Now create new UTS namespace */
> +               ret =3D unshare(CLONE_NEWUTS);
> +               if (ret < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to create UTS namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Try to open parent's UTS namespace handle from new use=
r+uts namespace */
> +               fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +
> +               if (fd >=3D 0) {
> +                       /* Should NOT succeed - we're in a different user=
 namespace */
> +                       write(pipefd[1], "S", 1); /* Unexpected success *=
/
> +                       close(fd);
> +               } else if (errno =3D=3D ESTALE) {
> +                       /* Expected: Stale file handle */
> +                       write(pipefd[1], "P", 1);
> +               } else {
> +                       /* Other error */
> +                       write(pipefd[1], "F", 1);
> +               }
> +
> +               close(pipefd[1]);
> +               exit(0);
> +       }
> +
> +       /* Parent process */
> +       close(pipefd[1]);
> +       ASSERT_EQ(read(pipefd[0], &result, 1), 1);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       if (result =3D=3D 'U') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new user namespace");
> +       }
> +       if (result =3D=3D 'M') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot set uid/gid mappings");
> +       }
> +       if (result =3D=3D 'N') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new UTS namespace");
> +       }
> +
> +       /* Should fail with ESTALE since we're in a different user namesp=
ace */
> +       ASSERT_EQ(result, 'P');
> +
> +       close(pipefd[0]);
> +       free(handle);
> +}
> +
> +TEST(nsfs_user_ipc_namespace_isolation)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       pid_t pid;
> +       int status;
> +       int pipefd[2];
> +       char result;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Create pipe for communication */
> +       ASSERT_EQ(pipe(pipefd), 0);
> +
> +       /* Get handle for current IPC namespace */
> +       ns_fd =3D open("/proc/self/ns/ipc", O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd); close(pipefd[0]);
> +                    close(pipefd[1]);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       close(ns_fd);
> +
> +       pid =3D fork();
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid =3D=3D 0) {
> +               /* Child process */
> +               close(pipefd[0]);
> +
> +               /* First create new user namespace to drop privileges */
> +               ret =3D unshare(CLONE_NEWUSER);
> +               if (ret < 0) {
> +                       write(pipefd[1], "U",
> +                             1); /* Unable to create user namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Write uid/gid mappings to maintain some capabilities *=
/
> +               int uid_map_fd =3D open("/proc/self/uid_map", O_WRONLY);
> +               int gid_map_fd =3D open("/proc/self/gid_map", O_WRONLY);
> +               int setgroups_fd =3D open("/proc/self/setgroups", O_WRONL=
Y);
> +
> +               if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0)=
 {
> +                       write(pipefd[1], "M", 1); /* Unable to set mappin=
gs */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Disable setgroups to allow gid mapping */
> +               write(setgroups_fd, "deny", 4);
> +               close(setgroups_fd);
> +
> +               /* Map current uid/gid to root in the new namespace */
> +               char mapping[64];
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
> +               write(uid_map_fd, mapping, strlen(mapping));
> +               close(uid_map_fd);
> +
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
> +               write(gid_map_fd, mapping, strlen(mapping));
> +               close(gid_map_fd);
> +
> +               /* Now create new IPC namespace */
> +               ret =3D unshare(CLONE_NEWIPC);
> +               if (ret < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to create IPC namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Try to open parent's IPC namespace handle from new use=
r+ipc namespace */
> +               fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +
> +               if (fd >=3D 0) {
> +                       /* Should NOT succeed - we're in a different user=
 namespace */
> +                       write(pipefd[1], "S", 1); /* Unexpected success *=
/
> +                       close(fd);
> +               } else if (errno =3D=3D ESTALE) {
> +                       /* Expected: Stale file handle */
> +                       write(pipefd[1], "P", 1);
> +               } else {
> +                       /* Other error */
> +                       write(pipefd[1], "F", 1);
> +               }
> +
> +               close(pipefd[1]);
> +               exit(0);
> +       }
> +
> +       /* Parent process */
> +       close(pipefd[1]);
> +       ASSERT_EQ(read(pipefd[0], &result, 1), 1);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       if (result =3D=3D 'U') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new user namespace");
> +       }
> +       if (result =3D=3D 'M') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot set uid/gid mappings");
> +       }
> +       if (result =3D=3D 'N') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new IPC namespace");
> +       }
> +
> +       /* Should fail with ESTALE since we're in a different user namesp=
ace */
> +       ASSERT_EQ(result, 'P');
> +
> +       close(pipefd[0]);
> +       free(handle);
> +}
> +
> +TEST(nsfs_user_mnt_namespace_isolation)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       pid_t pid;
> +       int status;
> +       int pipefd[2];
> +       char result;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Create pipe for communication */
> +       ASSERT_EQ(pipe(pipefd), 0);
> +
> +       /* Get handle for current mount namespace */
> +       ns_fd =3D open("/proc/self/ns/mnt", O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd); close(pipefd[0]);
> +                    close(pipefd[1]);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       close(ns_fd);
> +
> +       pid =3D fork();
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid =3D=3D 0) {
> +               /* Child process */
> +               close(pipefd[0]);
> +
> +               /* First create new user namespace to drop privileges */
> +               ret =3D unshare(CLONE_NEWUSER);
> +               if (ret < 0) {
> +                       write(pipefd[1], "U",
> +                             1); /* Unable to create user namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Write uid/gid mappings to maintain some capabilities *=
/
> +               int uid_map_fd =3D open("/proc/self/uid_map", O_WRONLY);
> +               int gid_map_fd =3D open("/proc/self/gid_map", O_WRONLY);
> +               int setgroups_fd =3D open("/proc/self/setgroups", O_WRONL=
Y);
> +
> +               if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0)=
 {
> +                       write(pipefd[1], "M", 1); /* Unable to set mappin=
gs */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Disable setgroups to allow gid mapping */
> +               write(setgroups_fd, "deny", 4);
> +               close(setgroups_fd);
> +
> +               /* Map current uid/gid to root in the new namespace */
> +               char mapping[64];
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
> +               write(uid_map_fd, mapping, strlen(mapping));
> +               close(uid_map_fd);
> +
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
> +               write(gid_map_fd, mapping, strlen(mapping));
> +               close(gid_map_fd);
> +
> +               /* Now create new mount namespace */
> +               ret =3D unshare(CLONE_NEWNS);
> +               if (ret < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to create mount namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Try to open parent's mount namespace handle from new u=
ser+mnt namespace */
> +               fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +
> +               if (fd >=3D 0) {
> +                       /* Should NOT succeed - we're in a different user=
 namespace */
> +                       write(pipefd[1], "S", 1); /* Unexpected success *=
/
> +                       close(fd);
> +               } else if (errno =3D=3D ESTALE) {
> +                       /* Expected: Stale file handle */
> +                       write(pipefd[1], "P", 1);
> +               } else {
> +                       /* Other error */
> +                       write(pipefd[1], "F", 1);
> +               }
> +
> +               close(pipefd[1]);
> +               exit(0);
> +       }
> +
> +       /* Parent process */
> +       close(pipefd[1]);
> +       ASSERT_EQ(read(pipefd[0], &result, 1), 1);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       if (result =3D=3D 'U') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new user namespace");
> +       }
> +       if (result =3D=3D 'M') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot set uid/gid mappings");
> +       }
> +       if (result =3D=3D 'N') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new mount namespace");
> +       }
> +
> +       /* Should fail with ESTALE since we're in a different user namesp=
ace */
> +       ASSERT_EQ(result, 'P');
> +
> +       close(pipefd[0]);
> +       free(handle);
> +}
> +
> +TEST(nsfs_user_cgroup_namespace_isolation)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       pid_t pid;
> +       int status;
> +       int pipefd[2];
> +       char result;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Create pipe for communication */
> +       ASSERT_EQ(pipe(pipefd), 0);
> +
> +       /* Get handle for current cgroup namespace */
> +       ns_fd =3D open("/proc/self/ns/cgroup", O_RDONLY);
> +       if (ns_fd < 0) {
> +               SKIP(free(handle); close(pipefd[0]); close(pipefd[1]);
> +                    return, "cgroup namespace not available");
> +       }
> +
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd); close(pipefd[0]);
> +                    close(pipefd[1]);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       close(ns_fd);
> +
> +       pid =3D fork();
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid =3D=3D 0) {
> +               /* Child process */
> +               close(pipefd[0]);
> +
> +               /* First create new user namespace to drop privileges */
> +               ret =3D unshare(CLONE_NEWUSER);
> +               if (ret < 0) {
> +                       write(pipefd[1], "U",
> +                             1); /* Unable to create user namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Write uid/gid mappings to maintain some capabilities *=
/
> +               int uid_map_fd =3D open("/proc/self/uid_map", O_WRONLY);
> +               int gid_map_fd =3D open("/proc/self/gid_map", O_WRONLY);
> +               int setgroups_fd =3D open("/proc/self/setgroups", O_WRONL=
Y);
> +
> +               if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0)=
 {
> +                       write(pipefd[1], "M", 1); /* Unable to set mappin=
gs */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Disable setgroups to allow gid mapping */
> +               write(setgroups_fd, "deny", 4);
> +               close(setgroups_fd);
> +
> +               /* Map current uid/gid to root in the new namespace */
> +               char mapping[64];
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
> +               write(uid_map_fd, mapping, strlen(mapping));
> +               close(uid_map_fd);
> +
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
> +               write(gid_map_fd, mapping, strlen(mapping));
> +               close(gid_map_fd);
> +
> +               /* Now create new cgroup namespace */
> +               ret =3D unshare(CLONE_NEWCGROUP);
> +               if (ret < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to create cgroup namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Try to open parent's cgroup namespace handle from new =
user+cgroup namespace */
> +               fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDONLY);
> +
> +               if (fd >=3D 0) {
> +                       /* Should NOT succeed - we're in a different user=
 namespace */
> +                       write(pipefd[1], "S", 1); /* Unexpected success *=
/
> +                       close(fd);
> +               } else if (errno =3D=3D ESTALE) {
> +                       /* Expected: Stale file handle */
> +                       write(pipefd[1], "P", 1);
> +               } else {
> +                       /* Other error */
> +                       write(pipefd[1], "F", 1);
> +               }
> +
> +               close(pipefd[1]);
> +               exit(0);
> +       }
> +
> +       /* Parent process */
> +       close(pipefd[1]);
> +       ASSERT_EQ(read(pipefd[0], &result, 1), 1);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       if (result =3D=3D 'U') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new user namespace");
> +       }
> +       if (result =3D=3D 'M') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot set uid/gid mappings");
> +       }
> +       if (result =3D=3D 'N') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new cgroup namespace");
> +       }
> +
> +       /* Should fail with ESTALE since we're in a different user namesp=
ace */
> +       ASSERT_EQ(result, 'P');
> +
> +       close(pipefd[0]);
> +       free(handle);
> +}
> +
> +TEST(nsfs_user_pid_namespace_isolation)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       pid_t pid;
> +       int status;
> +       int pipefd[2];
> +       char result;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Create pipe for communication */
> +       ASSERT_EQ(pipe(pipefd), 0);
> +
> +       /* Get handle for current PID namespace */
> +       ns_fd =3D open("/proc/self/ns/pid", O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd); close(pipefd[0]);
> +                    close(pipefd[1]);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       close(ns_fd);
> +
> +       pid =3D fork();
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid =3D=3D 0) {
> +               /* Child process */
> +               close(pipefd[0]);
> +
> +               /* First create new user namespace to drop privileges */
> +               ret =3D unshare(CLONE_NEWUSER);
> +               if (ret < 0) {
> +                       write(pipefd[1], "U",
> +                             1); /* Unable to create user namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Write uid/gid mappings to maintain some capabilities *=
/
> +               int uid_map_fd =3D open("/proc/self/uid_map", O_WRONLY);
> +               int gid_map_fd =3D open("/proc/self/gid_map", O_WRONLY);
> +               int setgroups_fd =3D open("/proc/self/setgroups", O_WRONL=
Y);
> +
> +               if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0)=
 {
> +                       write(pipefd[1], "M", 1); /* Unable to set mappin=
gs */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Disable setgroups to allow gid mapping */
> +               write(setgroups_fd, "deny", 4);
> +               close(setgroups_fd);
> +
> +               /* Map current uid/gid to root in the new namespace */
> +               char mapping[64];
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
> +               write(uid_map_fd, mapping, strlen(mapping));
> +               close(uid_map_fd);
> +
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
> +               write(gid_map_fd, mapping, strlen(mapping));
> +               close(gid_map_fd);
> +
> +               /* Now create new PID namespace - requires fork to take e=
ffect */
> +               ret =3D unshare(CLONE_NEWPID);
> +               if (ret < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to create PID namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Fork again for PID namespace to take effect */
> +               pid_t child_pid =3D fork();
> +               if (child_pid < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to fork in PID namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               if (child_pid =3D=3D 0) {
> +                       /* Grandchild in new PID namespace */
> +                       /* Try to open parent's PID namespace handle from=
 new user+pid namespace */
> +                       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_=
RDONLY);
> +
> +                       if (fd >=3D 0) {
> +                               /* Should NOT succeed - we're in a differ=
ent user namespace */
> +                               write(pipefd[1], "S",
> +                                     1); /* Unexpected success */
> +                               close(fd);
> +                       } else if (errno =3D=3D ESTALE) {
> +                               /* Expected: Stale file handle */
> +                               write(pipefd[1], "P", 1);
> +                       } else {
> +                               /* Other error */
> +                               write(pipefd[1], "F", 1);
> +                       }
> +
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Wait for grandchild */
> +               waitpid(child_pid, NULL, 0);
> +               exit(0);
> +       }
> +
> +       /* Parent process */
> +       close(pipefd[1]);
> +       ASSERT_EQ(read(pipefd[0], &result, 1), 1);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       if (result =3D=3D 'U') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new user namespace");
> +       }
> +       if (result =3D=3D 'M') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot set uid/gid mappings");
> +       }
> +       if (result =3D=3D 'N') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new PID namespace");
> +       }
> +
> +       /* Should fail with ESTALE since we're in a different user namesp=
ace */
> +       ASSERT_EQ(result, 'P');
> +
> +       close(pipefd[0]);
> +       free(handle);
> +}
> +
> +TEST(nsfs_user_time_namespace_isolation)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       pid_t pid;
> +       int status;
> +       int pipefd[2];
> +       char result;
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Create pipe for communication */
> +       ASSERT_EQ(pipe(pipefd), 0);
> +
> +       /* Get handle for current time namespace */
> +       ns_fd =3D open("/proc/self/ns/time", O_RDONLY);
> +       if (ns_fd < 0) {
> +               SKIP(free(handle); close(pipefd[0]); close(pipefd[1]);
> +                    return, "time namespace not available");
> +       }
> +
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd); close(pipefd[0]);
> +                    close(pipefd[1]);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       close(ns_fd);
> +
> +       pid =3D fork();
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid =3D=3D 0) {
> +               /* Child process */
> +               close(pipefd[0]);
> +
> +               /* First create new user namespace to drop privileges */
> +               ret =3D unshare(CLONE_NEWUSER);
> +               if (ret < 0) {
> +                       write(pipefd[1], "U",
> +                             1); /* Unable to create user namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Write uid/gid mappings to maintain some capabilities *=
/
> +               int uid_map_fd =3D open("/proc/self/uid_map", O_WRONLY);
> +               int gid_map_fd =3D open("/proc/self/gid_map", O_WRONLY);
> +               int setgroups_fd =3D open("/proc/self/setgroups", O_WRONL=
Y);
> +
> +               if (uid_map_fd < 0 || gid_map_fd < 0 || setgroups_fd < 0)=
 {
> +                       write(pipefd[1], "M", 1); /* Unable to set mappin=
gs */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Disable setgroups to allow gid mapping */
> +               write(setgroups_fd, "deny", 4);
> +               close(setgroups_fd);
> +
> +               /* Map current uid/gid to root in the new namespace */
> +               char mapping[64];
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getuid());
> +               write(uid_map_fd, mapping, strlen(mapping));
> +               close(uid_map_fd);
> +
> +               snprintf(mapping, sizeof(mapping), "0 %d 1", getgid());
> +               write(gid_map_fd, mapping, strlen(mapping));
> +               close(gid_map_fd);
> +
> +               /* Now create new time namespace - requires fork to take =
effect */
> +               ret =3D unshare(CLONE_NEWTIME);
> +               if (ret < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to create time namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Fork again for time namespace to take effect */
> +               pid_t child_pid =3D fork();
> +               if (child_pid < 0) {
> +                       write(pipefd[1], "N",
> +                             1); /* Unable to fork in time namespace */
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               if (child_pid =3D=3D 0) {
> +                       /* Grandchild in new time namespace */
> +                       /* Try to open parent's time namespace handle fro=
m new user+time namespace */
> +                       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_=
RDONLY);
> +
> +                       if (fd >=3D 0) {
> +                               /* Should NOT succeed - we're in a differ=
ent user namespace */
> +                               write(pipefd[1], "S",
> +                                     1); /* Unexpected success */
> +                               close(fd);
> +                       } else if (errno =3D=3D ESTALE) {
> +                               /* Expected: Stale file handle */
> +                               write(pipefd[1], "P", 1);
> +                       } else {
> +                               /* Other error */
> +                               write(pipefd[1], "F", 1);
> +                       }
> +
> +                       close(pipefd[1]);
> +                       exit(0);
> +               }
> +
> +               /* Wait for grandchild */
> +               waitpid(child_pid, NULL, 0);
> +               exit(0);
> +       }
> +
> +       /* Parent process */
> +       close(pipefd[1]);
> +       ASSERT_EQ(read(pipefd[0], &result, 1), 1);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       if (result =3D=3D 'U') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new user namespace");
> +       }
> +       if (result =3D=3D 'M') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot set uid/gid mappings");
> +       }
> +       if (result =3D=3D 'N') {
> +               SKIP(free(handle); close(pipefd[0]);
> +                    return, "Cannot create new time namespace");
> +       }
> +
> +       /* Should fail with ESTALE since we're in a different user namesp=
ace */
> +       ASSERT_EQ(result, 'P');
> +
> +       close(pipefd[0]);
> +       free(handle);
> +}
> +
> +TEST(nsfs_open_flags)
> +{
> +       struct file_handle *handle;
> +       int mount_id;
> +       int ret;
> +       int fd;
> +       int ns_fd;
> +       char ns_path[256];
> +
> +       handle =3D malloc(sizeof(*handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(handle, NULL);
> +
> +       /* Open a namespace file descriptor */
> +       snprintf(ns_path, sizeof(ns_path), "/proc/self/ns/net");
> +       ns_fd =3D open(ns_path, O_RDONLY);
> +       ASSERT_GE(ns_fd, 0);
> +
> +       /* Get handle for the namespace */
> +       handle->handle_bytes =3D MAX_HANDLE_SZ;
> +       ret =3D name_to_handle_at(ns_fd, "", handle, &mount_id, AT_EMPTY_=
PATH);
> +       if (ret < 0 && errno =3D=3D EOPNOTSUPP) {
> +               SKIP(free(handle); close(ns_fd);
> +                    return, "nsfs doesn't support file handles");
> +       }
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_GT(handle->handle_bytes, 0);
> +
> +       /* Test invalid flags that should fail */
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_WRONLY);
> +       ASSERT_LT(fd, 0);
> +       ASSERT_EQ(errno, EPERM);
> +
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_RDWR);
> +       ASSERT_LT(fd, 0);
> +       ASSERT_EQ(errno, EPERM);
> +
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_CREAT);
> +       ASSERT_LT(fd, 0);
> +       ASSERT_EQ(errno, EINVAL);
> +
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_TRUNC);
> +       ASSERT_LT(fd, 0);
> +       ASSERT_EQ(errno, EINVAL);
> +
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_APPEND);
> +       ASSERT_LT(fd, 0);
> +       ASSERT_EQ(errno, EINVAL);
> +
> +       fd =3D open_by_handle_at(FD_NSFS_ROOT, handle, O_DIRECT);
> +       ASSERT_LT(fd, 0);
> +       ASSERT_EQ(errno, EINVAL);
> +
> +       close(ns_fd);
> +       free(handle);
> +}
> +
> +TEST_HARNESS_MAIN
>
> --
> 2.47.3
>

