Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1431D77E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 11:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBQKWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 05:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhBQKV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:21:56 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313E2C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 02:21:16 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id 67so4374399uao.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7YMLJjk40HzAWELqN5l9m4d4X7by6+aJQrjOvMUw0Q=;
        b=aBwQ8vyyLXdPiYxmIPMn+u8n+zN5eUz3evKEEiKLz4mVAKmiI3e66LQTfkGf+EtYqd
         kDoQCHP6JkV0WZmQjMXp/DFk/mneY+9FkiRtxShWfVzgVmy1nU7k4IGY9g4VzYAS1tw6
         i4evrmjCbdiZVTlI8LSS19oFCVD42xFpHt/vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7YMLJjk40HzAWELqN5l9m4d4X7by6+aJQrjOvMUw0Q=;
        b=sa6UxHSfQJc/uSsgQkATgR6UaOD51At8xRZpQE+4JZ9YkKAYDm95rc/PF9NY1GuVpN
         ThQoc53JqF682eWv89T9BkINmstm4dCpIbbdg8c/VjdROUzU4dcUqz+E1QHibx3WC+nx
         EPsNEw7zDW62lKiG+xmuGe8jPVBa/oSfY7nkM8gXAXTxZI4R133DS6D9fyOM67DSJIXJ
         FAtGzu6hgZEaye0RZclT8tBS7kr/SKqBQEXAJXsCudv4SXda+eX5SnLNGvjjf5sh888j
         /Y0kSg0hjEMU4eBybUfLlRPkagQ35fWEYb+G9fKtYcKNYOwJYj/HUZO5d/GeeKicqDcF
         KVGw==
X-Gm-Message-State: AOAM533ftdjMHSLQ6uvqxFbH8NT9aZjYFnewx98qu10pZOZi4x+lPyvl
        2DtRP1fjPepq2JwAKTASopXOEKSoN/iuMHuIDpeB5g==
X-Google-Smtp-Source: ABdhPJxdVSmVC0ekPz8wTrSzRpU2MiWtMKZ1ompaYpQbNmbqIQDp0GCUYwVDtImw65OrCd5+hdowI4DEury0KzWA24A=
X-Received: by 2002:ab0:5963:: with SMTP id o32mr14151409uad.11.1613557275372;
 Wed, 17 Feb 2021 02:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-3-balsini@android.com>
In-Reply-To: <20210125153057.3623715-3-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Feb 2021 11:21:04 +0100
Message-ID: <CAJfpegviqcgtE4qRHZFy6xdL6Re7gs30TV1epkn7cvUu3A4hqw@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 4:31 PM Alessio Balsini <balsini@android.com> wrote:
>
> With a 64-bit kernel build the FUSE device cannot handle ioctl requests
> coming from 32-bit user space.
> This is due to the ioctl command translation that generates different
> command identifiers that thus cannot be used for direct comparisons
> without proper manipulation.
>
> Explicitly extract type and number from the ioctl command to enable
> 32-bit user space compatibility on 64-bit kernel builds.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/dev.c             | 29 ++++++++++++++++++-----------
>  include/uapi/linux/fuse.h |  3 ++-
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 588f8d1240aa..ff9f3b83f879 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2233,37 +2233,44 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
>  static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>                            unsigned long arg)
>  {
> -       int err = -ENOTTY;
> +       int res;
> +       int oldfd;
> +       struct fuse_dev *fud = NULL;
>
> -       if (cmd == FUSE_DEV_IOC_CLONE) {
> -               int oldfd;
> +       if (_IOC_TYPE(cmd) != FUSE_DEV_IOC_MAGIC)
> +               return -EINVAL;

Why change ENOTTY to EINVAL?

Thanks,
MIklos
