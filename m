Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20456339BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 11:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiKVKVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 05:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiKVKVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:21:17 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BEF5BD43;
        Tue, 22 Nov 2022 02:19:36 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id t14so13967037vsr.9;
        Tue, 22 Nov 2022 02:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8p9ZQ/UmpLjcFqjZPlNuCFs77ZDkwn/7XdgpymOLrg=;
        b=asa+IPR7AAsj8nVdOvUGA9cCy6FoCH7gqyZ7Fyd14OPV1NfWqJIBxGnh+luw13+Rvt
         2aKGWWagmWeODzAXtKpmPlvGS155M6d+TbAtWc1FmsFP0KDrnqMAp4sLawrKlq5seA4p
         a2thLlsJ1BiRkKOF7ZUcIENv6WrnXA0RMxvAJvXrZmkbudEumBe35Ig5Eea3pec7RexW
         8S4Lo+Hlcng6gHLNXfz2TFTLmQyXF5jN1yKQcbMkYFhYbia0c3kQ2gr+fJ+/3lyizCFL
         d7XHK83LLvutNjB/Z2y5K5W6aqbsT0aB45KtYgpD4THa+32hailJg9iZin3oBBYJN2rI
         t0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8p9ZQ/UmpLjcFqjZPlNuCFs77ZDkwn/7XdgpymOLrg=;
        b=xPscTeUc5lfw+OecV0PeyRJR2QOAkxoc/tmjLQJRdr4S20nnOsDvDhi7pZxy88XvgE
         70j5B4f3lP8dB1TPArdXZDwCuowyGzx6cawugDF76EwBN5XO7l0IuFQSszCAUF0hPdpe
         kJCFxfkDyCGhNsIa8BELcY7I0KLAiOt0Qd6Ayqnq/AEl02t/Sqy6evyCPOENXgZXJ3Pd
         hJiut9OyuXQ07pq9s+0ujiWdDnKzh4v2Ei9ZQhkQtMOCLAa2NV2luELA5Gi8jDpFMch5
         tVPiGKU0hswVi+dE6Lt98jTzRXT9oot9QxoCQMq4RzHMCZ/1r4Qhvi6xczgZY0WdbW0u
         K/+g==
X-Gm-Message-State: ANoB5plOuEES7IezxGuUZhusfrqjtKhe6j0ugAoiTPQpNSGV+6gSRU7V
        sErVz4ZHKUAXF5DyDlYsh09U5ruccRARRPmlMo/BMVd5
X-Google-Smtp-Source: AA0mqf4+k6Ltt0LobrDMTg+yyfabacfVSb84QqqAWuB842avg9qXFmtK8YA40EBNP42QoyTa/E95DXD3l/lOYqi0dLg=
X-Received: by 2002:a05:6102:1009:b0:3aa:13b1:86e6 with SMTP id
 q9-20020a056102100900b003aa13b186e6mr12991442vsp.36.1669112375533; Tue, 22
 Nov 2022 02:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <20221122021536.1629178-5-drosen@google.com>
In-Reply-To: <20221122021536.1629178-5-drosen@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Nov 2022 12:19:23 +0200
Message-ID: <CAOQ4uxiVqR_HxCytweO_uKR=gdRHTjGG9SgHaNTFb1+5b6ucGQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/21] fuse: Add fuse-bpf, a stacked fs extension
 for FUSE
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 4:16 AM Daniel Rosenberg <drosen@google.com> wrote:
>
> Fuse-bpf provides a short circuit path for Fuse implementations that act
> as a stacked filesystem. For cases that are directly unchanged,
> operations are passed directly to the backing filesystem. Small
> adjustments can be handled by bpf prefilters or postfilters, with the
> option to fall back to userspace as needed.
>
> Fuse implementations may supply backing node information, as well as bpf
> programs via an optional add on to the lookup structure.
>
> This has been split over the next set of patches for readability.
> Clusters of fuse ops have been split into their own patches, as well as
> the actual bpf calls and userspace calls for filters.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> Signed-off-by: Alessio Balsini <balsini@google.com>
> ---
>  fs/fuse/Kconfig   |   8 +
>  fs/fuse/Makefile  |   1 +
>  fs/fuse/backing.c | 392 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/dev.c     |  41 ++++-
>  fs/fuse/dir.c     | 187 +++++++++++++++++-----
>  fs/fuse/file.c    |  25 ++-
>  fs/fuse/fuse_i.h  |  99 +++++++++++-
>  fs/fuse/inode.c   | 189 +++++++++++++++++-----
>  fs/fuse/ioctl.c   |   2 +-
>  9 files changed, 861 insertions(+), 83 deletions(-)
>  create mode 100644 fs/fuse/backing.c
>
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 038ed0b9aaa5..3a64fa73e591 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -52,3 +52,11 @@ config FUSE_DAX
>
>           If you want to allow mounting a Virtio Filesystem with the "dax"
>           option, answer Y.
> +
> +config FUSE_BPF
> +       bool "Adds BPF to fuse"
> +       depends on FUSE_FS
> +       depends on BPF
> +       help
> +         Extends FUSE by adding BPF to prefilter calls and potentially pass to a
> +         backing file system
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 0c48b35c058d..a0853c439db2 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -9,5 +9,6 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
>
>  fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
>  fuse-$(CONFIG_FUSE_DAX) += dax.o
> +fuse-$(CONFIG_FUSE_BPF) += backing.o
>
>  virtiofs-y := virtio_fs.o
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> new file mode 100644
> index 000000000000..5a59a8963d52
> --- /dev/null
> +++ b/fs/fuse/backing.c
> @@ -0,0 +1,392 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FUSE-BPF: Filesystem in Userspace with BPF
> + * Copyright (c) 2021 Google LLC
> + */
> +
> +#include "fuse_i.h"
> +
> +#include <linux/fdtable.h>
> +#include <linux/file.h>
> +#include <linux/fs_stack.h>
> +#include <linux/namei.h>
> +
> +/*
> + * expression statement to wrap the backing filter logic
> + * struct inode *inode: inode with bpf and backing inode
> + * typedef io: (typically complex) type whose components fuse_args can point to.
> + *     An instance of this type is created locally and passed to initialize
> + * void initialize_in(struct fuse_args *fa, io *in_out, args...): function that sets
> + *     up fa and io based on args
> + * void initialize_out(struct fuse_args *fa, io *in_out, args...): function that sets
> + *     up fa and io based on args
> + * int backing(struct fuse_bpf_args_internal *fa, args...): function that actually performs
> + *     the backing io operation
> + * void *finalize(struct fuse_bpf_args *, args...): function that performs any final
> + *     work needed to commit the backing io
> + */
> +#define fuse_bpf_backing(inode, io, out, initialize_in, initialize_out,        \
> +                        backing, finalize, args...)                    \
> +({                                                                     \
> +       struct fuse_inode *fuse_inode = get_fuse_inode(inode);          \
> +       struct fuse_args fa = { 0 };                                    \
> +       bool initialized = false;                                       \
> +       bool handled = false;                                           \
> +       ssize_t res;                                                    \
> +       io feo = { 0 };                                                 \
> +       int error = 0;                                                  \
> +                                                                       \
> +       do {                                                            \
> +               if (!fuse_inode || !fuse_inode->backing_inode)          \
> +                       break;                                          \
> +                                                                       \
> +               handled = true;                                         \
> +               error = initialize_in(&fa, &feo, args);                 \
> +               if (error)                                              \
> +                       break;                                          \
> +                                                                       \
> +               error = initialize_out(&fa, &feo, args);                \
> +               if (error)                                              \
> +                       break;                                          \
> +                                                                       \
> +               initialized = true;                                     \
> +                                                                       \
> +               error = backing(&fa, out, args);                        \
> +               if (error < 0)                                          \
> +                       fa.error_in = error;                            \
> +                                                                       \
> +       } while (false);                                                \
> +                                                                       \
> +       if (initialized && handled) {                                   \
> +               res = finalize(&fa, out, args);                         \
> +               if (res)                                                \
> +                       error = res;                                    \
> +       }                                                               \
> +                                                                       \
> +       *out = error ? _Generic((*out),                                 \
> +                       default :                                       \
> +                               error,                                  \
> +                       struct dentry * :                               \
> +                               ERR_PTR(error),                         \
> +                       const char * :                                  \
> +                               ERR_PTR(error)                          \
> +                       ) : (*out);                                     \
> +       handled;                                                        \
> +})
> +

I hope there is a better way than this macro...
Haven't studied the patches enough to be able to suggest one.

Thanks,
Amir.
