Return-Path: <linux-fsdevel+bounces-62220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF400B892CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 13:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFC73AD3B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904E3081AC;
	Fri, 19 Sep 2025 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7wZcw6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B5212566
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279726; cv=none; b=VDw4+iAlOZWhmamdFxFGFFoS8Rs30MrLVNpz1Ma2p/peJNznmA59PxLqW8uNiqgx4z/9y/TD+YWiMpAOUFddaX5nSKxlSCgeCuBtaLrwZcq7SSggCTnCms4FGBEZJjRx2+hQKBqwnoWbqf8e8Y1VUDSC2EPNiejzPrW0BJpn7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279726; c=relaxed/simple;
	bh=Vqkw0/yvNLmdtbPnMo8vlk0/S3XRZivhmu7LYOK8/hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3b6Z+L5DjIXh0q0QtsrLYbtokWYPeYEgeyUGj10R4GNLCwx/0RzdbKDLqRUUJyzJJkvJsdjsrSFvRRO071hHhS/upyAAQFu+gmVE6U78BK+vu6N3nz5FAJQvXY74dqACVK5FfnCVnhDn0qSKb5BkQ/JCEc5bHhmPpECc2EKP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7wZcw6k; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso5763681a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 04:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758279722; x=1758884522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiitGJNEikL60Szupuptt0a8JYhm3AbptLaQixt4ZnI=;
        b=B7wZcw6kicMgBXiGlcHWS8JzPal5bHoYiPqdEdvkPNFfRqXRBSMIm15SH2MVd5iK5u
         SNZON00RQNOLNtz+YstxqATgaVSl7/44lu2BIA5mNSQjsyGg+raFhNCrCi5bJ6vHYPaT
         qyD8b5GQmgtLQPQq1fLZqmg9HhKyC1qqsC2K/wBlDthAcUvsEd2A68D1NfXCcLldKZuD
         zSZXD/OYQQIbuwNjMP7Slma/ezC9FRrcqBSikdFeEfCJ+HfLb2M9/JHiEs9qSy2hgRIU
         03mNwoVOCbuWoUdePsWJt1/I0fSruNjs1Gtj4Rg80BlYnWSHRJfu7OzMrYnFR7MN4XYY
         SZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758279722; x=1758884522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiitGJNEikL60Szupuptt0a8JYhm3AbptLaQixt4ZnI=;
        b=XPyW4sbfTxAY10bMxPDdgBFb4lrHbBdorDwiR7vCqzYSfGX2AaIZSDenIJcWN39Wov
         Ste4KoWvPBzEoK/GIEAg5m0T1vOZ8y44JWqxKffqmh7Z3I1uk67vqd8eghPwHUVAmaeu
         YzaQGH5K/rK9JUXJn59R+rkBfpmvZEakEMMPManfG/kZZ35z+PzWijvMdfvliVNKRWPp
         0qemMM+8K8rYjLcy1j1y9rz36tEWDgF/MM6LI5SNkPvYosQa1QNILj06PWqEbLUDhkmY
         ryhsvqBrBcRSrzvSZMAsFPbkWyXitRyEksjUK1gBcX6oMdU3/MufDfQNqNSc1yinF1GD
         VYlg==
X-Gm-Message-State: AOJu0YxiTN1Pt8JS4+aWa4WyxKtxnO1S0mMlR/k7HOl9t5qBS2mqSSjE
	o12qhSWyq3HF6KmlH7y1b7FTl2nZ3C+krQf3aLjGh7YjHXnx8gcecP3wpE3sWn/NB8ubIp6zQ7b
	3KcTjKK7Kp3kvrByEWKDKXSBDAFnHz+0=
X-Gm-Gg: ASbGncuh6rN+8YeJYR2M9Y/BsvK5JNPxOdmnvcEDgOSTjp6otmZzAqvvRgEntUdzM59
	yiEYvX6+T3BdwAzpZSbOnhxBm8b1HHqlgMk84r+KOQwrpPlR5uKgvI4bwE99ho+nndVi99M+3Ue
	ppznh55burRmrZLTdezvrMFjMHxITGsQtLr73Mz23+dFgqzFvnsjwe8vg30ev5TtV5ztIoaOac4
	gAMgN06xRv6OkLcYFP1Oqomj9Sac37eQbQU
X-Google-Smtp-Source: AGHT+IG4rc9JAHQrSU/MifkSP++nle32ESdZTEdqiLD5jwLzHCvIgPyZ5wMPr2UbqLjc50x0nRg6ZT4LAvgP67HN7Ik=
X-Received: by 2002:a05:6402:5345:10b0:62e:ebb4:e6e0 with SMTP id
 4fb4d7f45d1cf-62fbe3af572mr2761521a12.1.1758279722209; Fri, 19 Sep 2025
 04:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-work-namespace-selftests-v1-1-be04cbf4bc37@kernel.org>
In-Reply-To: <20250919-work-namespace-selftests-v1-1-be04cbf4bc37@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Sep 2025 13:01:49 +0200
X-Gm-Features: AS18NWAxTN2ZuMn2ygGmaQmxju3q5POUIY5Sl05DpCTPYM5L6oXOZAzIPPjArPw
Message-ID: <CAOQ4uxgELYuPBafrb9XpdyKah1JKKCzygxZ_5x6HLNXnv2Y+QQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/namespaces: verify initial namespace inode numbers
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 12:01=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Make sure that all works correctly.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks sane!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  tools/testing/selftests/namespaces/.gitignore      |  1 +
>  tools/testing/selftests/namespaces/Makefile        |  2 +-
>  tools/testing/selftests/namespaces/init_ino_test.c | 60 ++++++++++++++++=
++++++
>  3 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testin=
g/selftests/namespaces/.gitignore
> index 7639dbf58bbf..ccfb40837a73 100644
> --- a/tools/testing/selftests/namespaces/.gitignore
> +++ b/tools/testing/selftests/namespaces/.gitignore
> @@ -1,2 +1,3 @@
>  nsid_test
>  file_handle_test
> +init_ino_test
> diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/=
selftests/namespaces/Makefile
> index f6c117ce2c2b..5fe4b3dc07d3 100644
> --- a/tools/testing/selftests/namespaces/Makefile
> +++ b/tools/testing/selftests/namespaces/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS +=3D -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>
> -TEST_GEN_PROGS :=3D nsid_test file_handle_test
> +TEST_GEN_PROGS :=3D nsid_test file_handle_test init_ino_test
>
>  include ../lib.mk
>
> diff --git a/tools/testing/selftests/namespaces/init_ino_test.c b/tools/t=
esting/selftests/namespaces/init_ino_test.c
> new file mode 100644
> index 000000000000..ddd5008d46a6
> --- /dev/null
> +++ b/tools/testing/selftests/namespaces/init_ino_test.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2025 Christian Brauner <brauner@kernel.org>
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <linux/nsfs.h>
> +
> +#include "../kselftest_harness.h"
> +
> +struct ns_info {
> +       const char *name;
> +       const char *proc_path;
> +       unsigned int expected_ino;
> +};
> +
> +static struct ns_info namespaces[] =3D {
> +       { "ipc",    "/proc/1/ns/ipc",    IPC_NS_INIT_INO },
> +       { "uts",    "/proc/1/ns/uts",    UTS_NS_INIT_INO },
> +       { "user",   "/proc/1/ns/user",   USER_NS_INIT_INO },
> +       { "pid",    "/proc/1/ns/pid",    PID_NS_INIT_INO },
> +       { "cgroup", "/proc/1/ns/cgroup", CGROUP_NS_INIT_INO },
> +       { "time",   "/proc/1/ns/time",   TIME_NS_INIT_INO },
> +       { "net",    "/proc/1/ns/net",    NET_NS_INIT_INO },
> +       { "mnt",    "/proc/1/ns/mnt",    MNT_NS_INIT_INO },
> +};
> +
> +TEST(init_namespace_inodes)
> +{
> +       struct stat st;
> +
> +       for (int i =3D 0; i < sizeof(namespaces) / sizeof(namespaces[0]);=
 i++) {
> +               int ret =3D stat(namespaces[i].proc_path, &st);
> +
> +               /* Some namespaces might not be available (e.g., time nam=
espace on older kernels) */
> +               if (ret < 0) {
> +                       if (errno =3D=3D ENOENT) {
> +                               ksft_test_result_skip("%s namespace not a=
vailable\n", namespaces[i].name);
> +                               continue;
> +                       }
> +                       ASSERT_GE(ret, 0)
> +                               TH_LOG("Failed to stat %s: %s", namespace=
s[i].proc_path, strerror(errno));
> +               }
> +
> +               ASSERT_EQ(st.st_ino, namespaces[i].expected_ino) {
> +                       TH_LOG("Namespace %s has inode 0x%lx, expected 0x=
%x",
> +                              namespaces[i].name, st.st_ino, namespaces[=
i].expected_ino);
> +               }
> +
> +               ksft_print_msg("Namespace %s: inode 0x%lx matches expecte=
d 0x%x\n",
> +                              namespaces[i].name, st.st_ino, namespaces[=
i].expected_ino);
> +       }
> +}
> +
> +TEST_HARNESS_MAIN
>
> ---
> base-commit: 5a9b4dfe901cecd4e06692bb877b393459e4d50d
> change-id: 20250919-work-namespace-selftests-7b478f415792
>

