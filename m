Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77F4906F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 19:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfHPRb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 13:31:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41526 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfHPRb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:31:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so10278045ota.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2019 10:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aWrb6bkEyRJ9ljqtUOtJ0J5JLJy+MWVMX/WZQyVm9g=;
        b=PnKmzHow483R2Ap/3V74UoRHGqB3aSoMXvNzk0fX8jGArKT595h6d1eRwU99IP6pgn
         50bTO17RJgI2Cztd6HkImiISKEyfs6UoBopWrAUWlONu9CdWDeSFxHNYz7MxPBzFgZjD
         PDo7yYhdS7GJNpY3o0a1nCtMBViZfTpU9c07VD5pQNkmaAEZKRxS8l7rQgJdmL9ScVHB
         +7nKQYLSQUfhUUjK8slruKIdLtsVeKMYQZNHxxqZJbNjNvx3LCOH8snjMXGE8ELpSTIr
         ukD2ksvqhH/qQb2/geOPpdrxsYJIsUMpGLoFCBQQ+5peRVN4mMkR9Ey3QQ+ok6CGt7ZC
         +JEA==
X-Gm-Message-State: APjAAAV1s4FYrSW8L6tL+l1Xp1IyuYNGY4kVSYIMX9fEBq0s4+AUxv3H
        Qmyv7w8OppTxyiswqhCn0ZOzqvRPcoeZaAKAEVHRjrqESuw=
X-Google-Smtp-Source: APXvYqycU9L1CyczxoX8AM684B7eb5/zv26MRRPFQPy46rYv/5hpKCXEkTvf6oVtJZxFalBczLDjZVwglqRSaUR1Lak=
X-Received: by 2002:a05:6830:1059:: with SMTP id b25mr7653740otp.95.1565976718425;
 Fri, 16 Aug 2019 10:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-4-arnd@arndb.de>
In-Reply-To: <20190814204259.120942-4-arnd@arndb.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 16 Aug 2019 19:31:47 +0200
Message-ID: <CAHc6FU5n9rBZuH=chOdmGCwyrX-B-Euq8oFrnu3UHHKSm5A5gQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] gfs2: add compat_ioctl support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arnd,

On Wed, Aug 14, 2019 at 10:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Out of the four ioctl commands supported on gfs2, only FITRIM
> works in compat mode.
>
> Add a proper handler based on the ext4 implementation.
>
> Fixes: 6ddc5c3ddf25 ("gfs2: getlabel support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/gfs2/file.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 52fa1ef8400b..49287f0b96d0 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -6,6 +6,7 @@
>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/compat.h>
>  #include <linux/completion.h>
>  #include <linux/buffer_head.h>
>  #include <linux/pagemap.h>
> @@ -354,6 +355,25 @@ static long gfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>         return -ENOTTY;
>  }
>
> +#ifdef CONFIG_COMPAT
> +static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +       /* These are just misnamed, they actually get/put from/to user an int */
> +       switch(cmd) {
> +       case FS_IOC32_GETFLAGS:
> +               cmd = FS_IOC_GETFLAGS;
> +               break;
> +       case FS_IOC32_SETFLAGS:
> +               cmd = FS_IOC_SETFLAGS;
> +               break;

I'd like the code to be more explicit here:

        case FITRIM:
        case FS_IOC_GETFSLABEL:
              break;
        default:
              return -ENOIOCTLCMD;

> +       }
> +
> +       return gfs2_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
> +}
> +#else
> +#define gfs2_compat_ioctl NULL
> +#endif
> +
>  /**
>   * gfs2_size_hint - Give a hint to the size of a write request
>   * @filep: The struct file
> @@ -1294,6 +1314,7 @@ const struct file_operations gfs2_file_fops = {
>         .write_iter     = gfs2_file_write_iter,
>         .iopoll         = iomap_dio_iopoll,
>         .unlocked_ioctl = gfs2_ioctl,
> +       .compat_ioctl   = gfs2_compat_ioctl,
>         .mmap           = gfs2_mmap,
>         .open           = gfs2_open,
>         .release        = gfs2_release,
> @@ -1309,6 +1330,7 @@ const struct file_operations gfs2_file_fops = {
>  const struct file_operations gfs2_dir_fops = {
>         .iterate_shared = gfs2_readdir,
>         .unlocked_ioctl = gfs2_ioctl,
> +       .compat_ioctl   = gfs2_compat_ioctl,
>         .open           = gfs2_open,
>         .release        = gfs2_release,
>         .fsync          = gfs2_fsync,
> @@ -1325,6 +1347,7 @@ const struct file_operations gfs2_file_fops_nolock = {
>         .write_iter     = gfs2_file_write_iter,
>         .iopoll         = iomap_dio_iopoll,
>         .unlocked_ioctl = gfs2_ioctl,
> +       .compat_ioctl   = gfs2_compat_ioctl,
>         .mmap           = gfs2_mmap,
>         .open           = gfs2_open,
>         .release        = gfs2_release,
> @@ -1338,6 +1361,7 @@ const struct file_operations gfs2_file_fops_nolock = {
>  const struct file_operations gfs2_dir_fops_nolock = {
>         .iterate_shared = gfs2_readdir,
>         .unlocked_ioctl = gfs2_ioctl,
> +       .compat_ioctl   = gfs2_compat_ioctl,
>         .open           = gfs2_open,
>         .release        = gfs2_release,
>         .fsync          = gfs2_fsync,
> --
> 2.20.0
>

Should we feed this through the gfs2 tree?

Thanks,
Andreas
