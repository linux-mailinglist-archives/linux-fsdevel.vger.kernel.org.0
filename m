Return-Path: <linux-fsdevel+bounces-31796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563699B18E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 09:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089841F2261F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 07:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B15139CE9;
	Sat, 12 Oct 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXq1FDOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7F2581;
	Sat, 12 Oct 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718411; cv=none; b=nWP5KirXb9LNeYWuNKRfTr1dXmfWzsJDjs6fq4hXcA/YqG5Erpbw5tsA9Y/Xymitn7J3MDImI2ZwzwtXEvfrbzxZQ9tG+JfJDYSa0lD0kkwBauRVaelOws2CbbAXqt0lwOEpgpDu487qvrSPB0dYAihXNW+HIUIwkJM6Yv9wQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718411; c=relaxed/simple;
	bh=i+qpCbPrO/eSoJFAMLl6qF6BBDwYHL3SK1deEDWlklY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnDjYIzBJ/aaYBUv43JRnzJDhFojpmOx/vtmOKmRD1CJXeObjyKBW3ZXev3kv9orTnwLe6FhW6YO8GjGbL9YY59LEgqtn9gtoYMLZ+PLEO0v9pzTrWbPMN8zpZSWKYFF7YzBkO8LSpMtFbNJ9qLD/3cGHnsRpk55b6aoMj9y/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXq1FDOp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4603d3e4552so28595601cf.1;
        Sat, 12 Oct 2024 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728718409; x=1729323209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfyveZ4fncvJeGQhvMdUVtprtKTMQvC7P7ns4KwktqY=;
        b=LXq1FDOpDE/7E4sI7i55nO0O9g+6zFEBUPsxEo6FxGX4SebYWNMo9pQxPA6+yxwR4X
         vBkryiieQLRqT/TY3P6lWsDC2QY/mKmO/nlLpgJcqALn3/ow6/iu3wSrGl2EruksA+xc
         1melaBVhG2ypkyWZjgsTzMdHD4m0OSjx4vKtj7vAdumbRiAP/Xav+yyhxnkSaE+vrc6n
         q6v41iqzPmmKOzvZZ/VEbMQ9B55R6+bLTPW1rvtJBVhwlstiHEtYLjDCCHXV9lb1nrI9
         fPWevv2LZgYZrm0fWpvN23vqgNehuPzmqI1cexD28HddKkuHOjXjfTCk+HifU79K1eFl
         EWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728718409; x=1729323209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfyveZ4fncvJeGQhvMdUVtprtKTMQvC7P7ns4KwktqY=;
        b=tqFfZPNSCyHrjTdCpYnfa+evJyx9gFgFM/nn1rsQ+GrNUaJRpFUjDnTNeCzmRALFD0
         Li15xdgwyaPlrHeoRCI4fNKvp3ibUZ5VHf6xU2uuwsjRusnnQercFKToB8eftqutKMVl
         8Sljb63t8ujLwNrv04u4KyAnlASZBwrPJfKMwZTLW+7Ki1EjXwVgw/Qt+FQRzmV2X96/
         sfwzwbzisIxcCLe6uiYklbxLcZIJcU7MgRpda6bWtkKMVUGOarXSNmcuB1ztuJ5x/1zN
         /uPoxp+mra5rITCx8iPR/K/9c45rMiUn+M0D7o90BNnMNcO1qguh2xGrRKSwN/zXE8Cr
         nwOg==
X-Forwarded-Encrypted: i=1; AJvYcCUGEzmW2CW6GW1Qrjt/y41t2+ltEdoOmEbcVxtUpzLU7t5AXj2xJ7pZHWv7TGmR1fCzbt7WSPdCfLFgp7+sfg==@vger.kernel.org, AJvYcCWBvl24pFJuO2ffur63O7BNpmR3SgWRRinCnKOHVSKvuazQBEHH0TTzfoK327XRhZkOEBwIvtY/VIKCAXoG@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAdX6J/gTzZMbDhCZAFyI9u1KcKsRa/MSv64ogLVW7j9S5AvQ
	zFL7BPkTj6lXUgOqrI1iwNrED/znhg9qj0f/7bGel///sU4eRtA+sYLjkUzP/viNUiCr3uuWAnu
	MKs0IQR7e/i/Ohr6e/efjh6iTYWcFRtdhcvY=
X-Google-Smtp-Source: AGHT+IE7jompiXcFd9gzUdLD0vditTTdJfB1YGyP55gYpOM2NbjO1grAXZsRHmMFoUuqqz7Gfn+MQKe0nQdZMCnKGCw=
X-Received: by 2002:ac8:58c6:0:b0:45d:7987:3acb with SMTP id
 d75a77b69052e-460583aec89mr41869111cf.10.1728718408946; Sat, 12 Oct 2024
 00:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org> <20241011-work-overlayfs-v2-3-1b43328c5a31@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v2-3-1b43328c5a31@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Oct 2024 09:33:18 +0200
Message-ID: <CAOQ4uxiG47z_YE2idpuEkSc5wA5F9KzSXf3endewnVnOQZnZYA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] selftests: use shared header
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:46=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> So that we don't have to redefine the same system calls over and over.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Heh, I forgot that this selftest existed, even though I clearly reviewed it
I will even run it from now on :)

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../selftests/filesystems/overlayfs/dev_in_maps.c  | 27 +-------------
>  .../selftests/filesystems/overlayfs/wrappers.h     | 43 ++++++++++++++++=
++++++
>  2 files changed, 44 insertions(+), 26 deletions(-)
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c =
b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> index 2862aae58b79acbe175ab6b36b42798bb99a2225..3b796264223f81fc753d0adae=
ccc04077023520b 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> @@ -17,32 +17,7 @@
>
>  #include "../../kselftest.h"
>  #include "log.h"
> -
> -static int sys_fsopen(const char *fsname, unsigned int flags)
> -{
> -       return syscall(__NR_fsopen, fsname, flags);
> -}
> -
> -static int sys_fsconfig(int fd, unsigned int cmd, const char *key, const=
 char *value, int aux)
> -{
> -       return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
> -}
> -
> -static int sys_fsmount(int fd, unsigned int flags, unsigned int attr_fla=
gs)
> -{
> -       return syscall(__NR_fsmount, fd, flags, attr_flags);
> -}
> -static int sys_mount(const char *src, const char *tgt, const char *fst,
> -               unsigned long flags, const void *data)
> -{
> -       return syscall(__NR_mount, src, tgt, fst, flags, data);
> -}
> -static int sys_move_mount(int from_dfd, const char *from_pathname,
> -                         int to_dfd, const char *to_pathname,
> -                         unsigned int flags)
> -{
> -       return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, =
to_pathname, flags);
> -}
> +#include "wrappers.h"
>
>  static long get_file_dev_and_inode(void *addr, struct statx *stx)
>  {
> diff --git a/tools/testing/selftests/filesystems/overlayfs/wrappers.h b/t=
ools/testing/selftests/filesystems/overlayfs/wrappers.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..4f99e10f7f018fd9a7be5263f=
68d34807da4c53c
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/wrappers.h
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +#ifndef __SELFTEST_OVERLAYFS_WRAPPERS_H__
> +#define __SELFTEST_OVERLAYFS_WRAPPERS_H__
> +
> +#define _GNU_SOURCE
> +
> +#include <linux/types.h>
> +#include <linux/mount.h>
> +#include <sys/syscall.h>
> +
> +static inline int sys_fsopen(const char *fsname, unsigned int flags)
> +{
> +       return syscall(__NR_fsopen, fsname, flags);
> +}
> +
> +static inline int sys_fsconfig(int fd, unsigned int cmd, const char *key=
,
> +                              const char *value, int aux)
> +{
> +       return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
> +}
> +
> +static inline int sys_fsmount(int fd, unsigned int flags,
> +                             unsigned int attr_flags)
> +{
> +       return syscall(__NR_fsmount, fd, flags, attr_flags);
> +}
> +
> +static inline int sys_mount(const char *src, const char *tgt, const char=
 *fst,
> +                           unsigned long flags, const void *data)
> +{
> +       return syscall(__NR_mount, src, tgt, fst, flags, data);
> +}
> +
> +static inline int sys_move_mount(int from_dfd, const char *from_pathname=
,
> +                                int to_dfd, const char *to_pathname,
> +                                unsigned int flags)
> +{
> +       return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
> +                      to_pathname, flags);
> +}
> +
> +#endif
>
> --
> 2.45.2
>

