Return-Path: <linux-fsdevel+bounces-35660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A149D6CA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 06:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B61281597
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 05:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6915EFA1;
	Sun, 24 Nov 2024 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGUlvasj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1D1FDA;
	Sun, 24 Nov 2024 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732424835; cv=none; b=WaYr9JIAh0dUS8loXznD8Mokwsc+q6RvsmagWjBxTvXwp6h4x/v9oSCjz39CzSprS/1utlWLZrneOhX2nl3I0urzLeCO2lgo5PoTySLPKEFS1jgq8Rc+cJ060S9dxoglT51XsDIulnTLya6gXb2gdJubOP1cXndbtM51wgoDbV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732424835; c=relaxed/simple;
	bh=A5JBufp3BqZcVJebv3vOi2L6YFd1Xn8pnl7u0aBWWRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTeC9V6r/UEVlgphI8KjReOq4MVHK7hcdJjl6VhQH8XgKYihEQx+lRhlLAZFA3T/ml+0yWa9o3V0nzmgyTvNl+tV3ujp97QbuB/PCJNEotyeUE9KnIP1fiTl6G47MF5ozoXvxxTm/Vzyk0pae6DiXJAyugpkzYmHNwFMgH8V0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGUlvasj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9ec267b879so524260866b.2;
        Sat, 23 Nov 2024 21:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732424832; x=1733029632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcWLt9BzM+D5P0pawjkoXFMqoRI4kKmtgFNF6FAIvWI=;
        b=CGUlvasjtI19Hitg1UETxwh7aOOCtrkwgnNbQvJqCnkAaGJDiJR9aZ2F9z7qDuy/j3
         NuHodz/3mlxQo8SrBauAnXekUrdeW8E4fcjSaYCn9G/nnYD2NyOgF/cDZ5u3Fam5g0rl
         H3BUtnvf8eQUXNGpQoqhcHO6CT49hiHfwDHdGBZaRGct4yttADuYCHMpBjt+z7yp1fl6
         RLuG9T2Y8AfpKgY8Eo0xtoqIUkVcPRNelNyruyPOdKzuaFZHFWmLGuZ+jzLMilNKDdJ+
         mL19j1AMBJ2aX+MYNcUr35Amr7TUUzR8+wLkUcMKs2beX2pF/cPVqw8tJlKHadMiXxrj
         hfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732424832; x=1733029632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcWLt9BzM+D5P0pawjkoXFMqoRI4kKmtgFNF6FAIvWI=;
        b=EWtW40ghG9ClekWBLYWlev01lX1KK55K9KWrlF0sKEvmDlgJeeh46ji9Ovh1fuYV3P
         Tq8rxF/bQ7ZtBVWYnVh1LbL/cJqn9xnQqTUO1DEbMihLfVNp73SIhYaEBxnwTTqKeBvK
         4YxjR1fetrXCwAtWAEJNkRkrGZ+j3g08KvDewAD007buXLCyWvjKXZoOkeHoOc1KT9F4
         QPINumeUc6EvaDttB64LLobvJT8SnsSHSmV78hfWMgjZU9GikHrP9dElOWwqR48m5BrG
         WwmZwXr6Ku6Y5RyGfDJlUDvCsbakRO4QghiMMN97JxYSVMhKLGbWkUv1h5nPeFRSmCSw
         7bWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVegm/DxK9UhJhm6UAizrPlLWBBChAaTnEdavSl2ZLe81y0LRjke7XPsp9x4s39zmvuLViv2ULRV7nelJqQ4zoCenzy69xt@vger.kernel.org, AJvYcCWUDnx8c9xexUcVTiS+ruoRMgkuBhYuJ5EWltjXj7mfo5dm+4rvH+kYOFZReAKAWOeOnKhjJ3xQiPmKXP/q@vger.kernel.org, AJvYcCX82Uz0jfmZkXdzRPsURsDMCwtVSi5wsv2YaS7myirOPeejdZwJxNDxrRUpzazF0Tg27O2Yx4Y2TbvlCDFX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyb5M5yAba8RuhiJ4aIjIbVfGG2S9KFc230M1M/9g1q87CzlRQ
	bZMLzNQRxVx7Dl9F2ZnAee7lAMFcqOFerMt2J0InV9BJCYRJ3ox9TrfDvXdzNbeeFotuzCyBBFa
	qtyb3eUPV/g5Ua77NQAAMQsE2Gt/rV8q/OPg=
X-Gm-Gg: ASbGnctAN/6exvZG43DcdPdWaJAaXvWLO1OQR/7FvwQfo9mRe8BNjhROThOQEf0fIMW
	yJV0Z6wQ3owM18triZdhLC8UnmuYmNWU=
X-Google-Smtp-Source: AGHT+IG2XZClBYhOqCC8Y9IQVvaihZ4ptkp7C6cgp9yuK+MvG/190TPd/69ziujBe5Esc+YpzA2pQbpRJXvduVYW3KM=
X-Received: by 2002:a17:906:3293:b0:a9a:14fc:9868 with SMTP id
 a640c23a62f3a-aa50995de26mr794376866b.4.1732424832006; Sat, 23 Nov 2024
 21:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122225958.1775625-1-song@kernel.org> <20241122225958.1775625-3-song@kernel.org>
In-Reply-To: <20241122225958.1775625-3-song@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Nov 2024 06:07:00 +0100
Message-ID: <CAOQ4uxhfd8ryQ6ua5u60yN5sh06fyiieS3XgfR9jvkAOeDSZUg@mail.gmail.com>
Subject: Re: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify fiter
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 12:00=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> This sample can run in two different mode: filter mode and block mode.
> In filter mode, the filter only sends events in a subtree to user space.
> To use it:
>
> [root] insmod ./filter-mod.ko
> [root] mkdir -p /tmp/a/b/c/d
> [root] ./filter-user /tmp/ /tmp/a/b &
> Running in filter mode
> [root] touch /tmp/xx      # Doesn't generate event
> [root]# touch /tmp/a/xxa  # Doesn't generate event
> [root]# touch /tmp/a/b/xxab      # Generates an event
> Accessing file xxab   # this is the output from filter-user
> [root@]# touch /tmp/a/b/c/xxabc  # Generates an event
> Accessing file xxabc  # this is the output from filter-user
>
> In block mode, the filter will block accesses to file in a subtree. To
> use it:
>
> [root] insmod ./filter-mod.ko
> [root] mkdir -p /tmp/a/b/c/d
> [root] ./filter-user /tmp/ /tmp/a/b block &
> Running in block mode
> [root]# dd if=3D/dev/zero of=3D/tmp/a/b/xx    # this will fail
> dd: failed to open '/tmp/a/b/xx': Operation not permitted
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  MAINTAINERS                    |   1 +
>  samples/Kconfig                |  20 ++++-
>  samples/Makefile               |   2 +-
>  samples/fanotify/.gitignore    |   1 +
>  samples/fanotify/Makefile      |   5 +-
>  samples/fanotify/filter-mod.c  | 105 ++++++++++++++++++++++++++
>  samples/fanotify/filter-user.c | 131 +++++++++++++++++++++++++++++++++
>  samples/fanotify/filter.h      |  19 +++++
>  8 files changed, 281 insertions(+), 3 deletions(-)
>  create mode 100644 samples/fanotify/filter-mod.c
>  create mode 100644 samples/fanotify/filter-user.c
>  create mode 100644 samples/fanotify/filter.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ad507f49324..8939a48b2d99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8658,6 +8658,7 @@ S:        Maintained
>  F:     fs/notify/fanotify/
>  F:     include/linux/fanotify.h
>  F:     include/uapi/linux/fanotify.h
> +F:     samples/fanotify/
>
>  FARADAY FOTG210 USB2 DUAL-ROLE CONTROLLER
>  M:     Linus Walleij <linus.walleij@linaro.org>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index b288d9991d27..9cc0a5cdf604 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -149,15 +149,33 @@ config SAMPLE_CONNECTOR
>           with it.
>           See also Documentation/driver-api/connector.rst
>
> +config SAMPLE_FANOTIFY
> +       bool "Build fanotify monitoring sample"
> +       depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
> +       help
> +         When enabled, this builds samples for fanotify.
> +         There multiple samples for fanotify. Please see the
> +         following configs for more details of these
> +         samples.
> +
>  config SAMPLE_FANOTIFY_ERROR
>         bool "Build fanotify error monitoring sample"
> -       depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
> +       depends on SAMPLE_FANOTIFY
>         help
>           When enabled, this builds an example code that uses the
>           FAN_FS_ERROR fanotify mechanism to monitor filesystem
>           errors.
>           See also Documentation/admin-guide/filesystem-monitoring.rst.
>
> +config SAMPLE_FANOTIFY_FILTER
> +       tristate "Build fanotify filter sample"
> +       depends on SAMPLE_FANOTIFY && m
> +       help
> +         When enabled, this builds kernel module that contains a
> +         fanotify filter handler.
> +         The filter handler filters out certain filename
> +         prefixes for the fanotify user.
> +
>  config SAMPLE_HIDRAW
>         bool "hidraw sample"
>         depends on CC_CAN_LINK && HEADERS_INSTALL
> diff --git a/samples/Makefile b/samples/Makefile
> index b85fa64390c5..108360972626 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -6,7 +6,7 @@ subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) +=3D binderfs
>  subdir-$(CONFIG_SAMPLE_CGROUP) +=3D cgroup
>  obj-$(CONFIG_SAMPLE_CONFIGFS)          +=3D configfs/
>  obj-$(CONFIG_SAMPLE_CONNECTOR)         +=3D connector/
> -obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)    +=3D fanotify/
> +obj-$(CONFIG_SAMPLE_FANOTIFY)          +=3D fanotify/
>  subdir-$(CONFIG_SAMPLE_HIDRAW)         +=3D hidraw
>  obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)     +=3D hw_breakpoint/
>  obj-$(CONFIG_SAMPLE_KDB)               +=3D kdb/
> diff --git a/samples/fanotify/.gitignore b/samples/fanotify/.gitignore
> index d74593e8b2de..df75eb5b8f95 100644
> --- a/samples/fanotify/.gitignore
> +++ b/samples/fanotify/.gitignore
> @@ -1 +1,2 @@
>  fs-monitor
> +filter-user
> diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
> index e20db1bdde3b..c33e9460772e 100644
> --- a/samples/fanotify/Makefile
> +++ b/samples/fanotify/Makefile
> @@ -1,5 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -userprogs-always-y +=3D fs-monitor
> +userprogs-always-$(CONFIG_SAMPLE_FANOTIFY_ERROR) +=3D fs-monitor
>
>  userccflags +=3D -I usr/include -Wall
>
> +obj-$(CONFIG_SAMPLE_FANOTIFY_FILTER) +=3D filter-mod.o
> +
> +userprogs-always-$(CONFIG_SAMPLE_FANOTIFY_FILTER) +=3D filter-user
> diff --git a/samples/fanotify/filter-mod.c b/samples/fanotify/filter-mod.=
c
> new file mode 100644
> index 000000000000..eafe55b1840a
> --- /dev/null
> +++ b/samples/fanotify/filter-mod.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/fsnotify.h>
> +#include <linux/fanotify.h>
> +#include <linux/module.h>
> +#include <linux/path.h>
> +#include <linux/file.h>
> +#include "filter.h"
> +
> +struct fan_filter_sample_data {
> +       struct path subtree_path;
> +       enum fan_filter_sample_mode mode;
> +};
> +
> +static int sample_filter(struct fsnotify_group *group,
> +                        struct fanotify_filter_hook *filter_hook,
> +                        struct fanotify_filter_event *filter_event)
> +{
> +       struct fan_filter_sample_data *data;
> +       struct dentry *dentry;
> +
> +       dentry =3D fsnotify_data_dentry(filter_event->data, filter_event-=
>data_type);
> +       if (!dentry)
> +               return FAN_FILTER_RET_SEND_TO_USERSPACE;
> +
> +       data =3D filter_hook->data;
> +
> +       if (is_subdir(dentry, data->subtree_path.dentry)) {
> +               if (data->mode =3D=3D FAN_FILTER_SAMPLE_MODE_BLOCK)
> +                       return -EPERM;
> +               return FAN_FILTER_RET_SEND_TO_USERSPACE;
> +       }
> +       return FAN_FILTER_RET_SKIP_EVENT;
> +}
> +
> +static int sample_filter_init(struct fsnotify_group *group,
> +                             struct fanotify_filter_hook *filter_hook,
> +                             void *argp)
> +{
> +       struct fan_filter_sample_args *args;
> +       struct fan_filter_sample_data *data;
> +       struct file *file;
> +       int fd;
> +
> +       args =3D (struct fan_filter_sample_args *)argp;
> +       fd =3D args->subtree_fd;
> +
> +       file =3D fget(fd);
> +       if (!file)
> +               return -EBADF;
> +       data =3D kzalloc(sizeof(struct fan_filter_sample_data), GFP_KERNE=
L);
> +       if (!data) {
> +               fput(file);
> +               return -ENOMEM;
> +       }
> +       path_get(&file->f_path);
> +       data->subtree_path =3D file->f_path;
> +       fput(file);
> +       data->mode =3D args->mode;
> +       filter_hook->data =3D data;
> +       return 0;
> +}
> +
> +static void sample_filter_free(struct fanotify_filter_hook *filter_hook)
> +{
> +       struct fan_filter_sample_data *data =3D filter_hook->data;
> +
> +       path_put(&data->subtree_path);
> +       kfree(data);
> +}
> +

Hi Song,

This example looks fine but it raises a question.
This filter will keep the mount of subtree_path busy until the group is clo=
sed
or the filter is detached.
This is probably fine for many services that keep the mount busy anyway.

But what if this wasn't the intention?
What if an Anti-malware engine that watches all mounts wanted to use that
for configuring some ignore/block subtree filters?

One way would be to use a is_subtree() variant that looks for a
subtree root inode
number and then verifies it with a subtree root fid.
A production subtree filter will need to use a variant of is_subtree()
anyway that
looks for a set of subtree root inodes, because doing a loop of is_subtree(=
) for
multiple paths is a no go.

Don't need to change anything in the example, unless other people
think that we do need to set a better example to begin with...

Thanks,
Amir.

