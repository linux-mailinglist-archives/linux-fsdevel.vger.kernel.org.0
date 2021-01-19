Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31DA2FB191
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 07:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbhASGe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 01:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbhASGeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:34:08 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026CC061573;
        Mon, 18 Jan 2021 22:33:28 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q1so37498857ion.8;
        Mon, 18 Jan 2021 22:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6x6S6V7QqaCecRtSu4BVeMkktffIYWiGzWsttlVG90=;
        b=boi99NBW5OJuvA/Hx9NZrGLvag/X1H6xRs6skEbNsfWkKLaP/r/WMVh/EoZ5EqBIV6
         XkLtlOrkOmYZzI2h7uLNAh7rsVto0m9ZqrjKgP+X1MX3R+dt6tkKflKaLBcbLq/SEzLF
         tIhbuhq/jDRfl1bP1CuFELvTh8LNd2xzwjsVUwMvTIKTDIl2tcuZv1nIOADy6Cq60H1P
         /CHwLagd5+roW9AMiAXWW9T5SK8soJd77RVPGAyew23bKqXBZQsePpsyj25aHe92h9Cs
         z5QDS3sdAV+oPV6Nn7IPyUt4G1Q7VKMZ6lpEXaEPsghwqvarV+Ai4/HxsAZU9DFdvu9L
         Qsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6x6S6V7QqaCecRtSu4BVeMkktffIYWiGzWsttlVG90=;
        b=VO9/1AQS5JCbK0ewc/wHXIrTzexAZVahzRY09SDjaYDDzMgW0e1rOY9XnbhKs/KfBT
         itdEneyPSwa++8YvT6CBX6pFvEKIVYs7xAJmrSvt4wNimdWaIOcaOyFgZdKcfKEgmwc2
         SbWFNBEp1Bv8KucogXf4lNNLfIrPckeham5pZVaHmt/SjO0MTBanSw1SRC10DnLkKRrv
         nbSQAG7g0pXFGfqDvOnE3Fkuge2mNLCCjXEVZU1o3XdHf+HzmpCUq/NXyOAjFuT7U7jK
         RTU8Z0GmKXywqYjWkmOqVN+7+gmD0XOteB9ZaY87kcX2oJb1pKXGu+EawXIGcuAqE7ah
         PrPg==
X-Gm-Message-State: AOAM530kab6ODjsUeal23GDPDCzhn4xr5XrF7H2FxaHwdMZ6+Lrevn49
        xBtgv5gqKZg9bHKmG0O8YWoSSkhuQz1FyIv14GI=
X-Google-Smtp-Source: ABdhPJzq2DbzRn0vb3Itf6IiI3hLJ6h5DadfQ0C7y0LCnwOWHXzQH71EUqZQcMXpNpbUNhv/D6YNhelbDuoDyO8M66g=
X-Received: by 2002:a92:6403:: with SMTP id y3mr2235438ilb.72.1611038007420;
 Mon, 18 Jan 2021 22:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20210118192748.584213-1-balsini@android.com> <20210118192748.584213-4-balsini@android.com>
In-Reply-To: <20210118192748.584213-4-balsini@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Jan 2021 08:33:16 +0200
Message-ID: <CAOQ4uxj-Ncm7nKBZE_homGu_kcF0w1JtYcC9zg2=uWT591Ggbw@mail.gmail.com>
Subject: Re: [PATCH RESEND V11 3/7] fuse: Definitions and ioctl for passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 9:28 PM Alessio Balsini <balsini@android.com> wrote:
>
> Expose the FUSE_PASSTHROUGH interface to user space and declare all the
> basic data structures and functions as the skeleton on top of which the
> FUSE passthrough functionality will be built.
>
> As part of this, introduce the new FUSE passthrough ioctl(), which
> allows the FUSE daemon to specify a direct connection between a FUSE
> file and a lower file system file. Such ioctl() requires users pace to
> pass the file descriptor of one of its opened files through the
> fuse_passthrough_out data structure introduced in this patch. This
> structure includes extra fields for possible future extensions.
> Also, add the passthrough functions for the set-up and tear-down of the
> data structures and locks that will be used both when fuse_conns and
> fuse_files are created/deleted.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
[...]

> @@ -699,6 +700,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>         INIT_LIST_HEAD(&fc->bg_queue);
>         INIT_LIST_HEAD(&fc->entry);
>         INIT_LIST_HEAD(&fc->devices);
> +       idr_init(&fc->passthrough_req);
>         atomic_set(&fc->num_waiting, 0);
>         fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
>         fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
> @@ -1052,6 +1054,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>                                 fc->handle_killpriv_v2 = 1;
>                                 fm->sb->s_flags |= SB_NOSEC;
>                         }
> +                       if (arg->flags & FUSE_PASSTHROUGH) {
> +                               fc->passthrough = 1;
> +                               /* Prevent further stacking */
> +                               fm->sb->s_stack_depth =
> +                                       FILESYSTEM_MAX_STACK_DEPTH + 1;
> +                       }

Hi Allesio,

I'm sorry I missed the discussion on v10 patch, but this looks wrong.
First of all, assigning a value above a declared MAX_ is misleading
and setting a trap for someone else to trip in the future.

While this may be just a semantic mistake, the code that checks for
(passthrough_sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH)
is just cheating.

fuse_file_{read,write}_iter are stacked operations, no different in any way
than overlayfs and ecryptfs stacked file operations.

Peng Tao mentioned a case of passthrough to overlayfs over ecryptfs [1].
If anyone really thinks this use case is interesting enough (I doubt it), then
they may propose to bump up FILESYSTEM_MAX_STACK_DEPTH to 3,
but not to cheat around the currently defined maximum.

So please set s_max_depth to FILESYSTEM_MAX_STACK_DEPTH and
restore your v10 check of
passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH

Your commit message sounds as if the only purpose of this check is to
prevent stacking of FUSE passthrough on top of each other, but that
is not enough.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CA+a=Yy6S9spMLr9BqyO1qvU52iAAXU3i9eVtb81SnrzjkCwO5Q@mail.gmail.com/
