Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B522B8BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 08:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKSHDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 02:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgKSHDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:03:05 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B93C0613CF;
        Wed, 18 Nov 2020 23:03:05 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id i9so4865794ioo.2;
        Wed, 18 Nov 2020 23:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZf0XT6FOpH4UgmSqNaoQWJcJUEUxG030KkkVYX8Ays=;
        b=Lm5YT6xLwtIktkI6IW71JqU1PBnDOR78a2eROaT+qT1Zlwx4wOkc0IeHckxEYzavXB
         53zy1iYnizAExLbHuhpOaQh8QcXZT5gYepJdpYd5peRVJmq1DGFc2uXEfzVQbfuvk7so
         VqizpHDq4DvG6PrSXeeiCE+qtQYt/QFpFbarvjgJ7c+dHjVjRsxp+FGCogCDbJIcv7lU
         l5X/dxVovVuM+vs30kURinsspudy4GjNCMojDN/KqcHpwhanwywXxDSJkw3d7jWN49AI
         gCxBVFU6Kw4mTxvCdQvDbdWdpsFCOsE8GDa/jEgbg/6JsYqho9G7i9jEq3psqQsALV4M
         xhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZf0XT6FOpH4UgmSqNaoQWJcJUEUxG030KkkVYX8Ays=;
        b=mYi+DinJSpa6qJ9K5IIncaXC8aRF40Ubeg9cAGFNyPigyt/n/7DzaldIVSh/rNSvZ8
         JJcxxKPeEmii6g9rnYI9klqf95DDn438FTDg+OIy7fhmddKWzMTQ6J9IkbAlaHUECr6G
         kOtelz6+ncMuFNfzM2EwyI7GXge+WjDKojzwTdiZtdBDYjrT46XnZtAYixghJVwzM3il
         KS1M/lmgOLGEq9HWfQ5AGHwUMR30gUx40qgr47CW8y1po3VFR3y8EKMFJ9n/mvVwUMle
         7nUxSW86Sdr/oxrASHOSHwUcWKfXj4GxhJwLE7Uv34XuIOfB07b+KelbsKSPmkEAYfWC
         mI9w==
X-Gm-Message-State: AOAM533IYFitpvv93qcD1QzcVeo6rF5bVPbv/1jTnM58iSTKQq0K7vDX
        MVTkpLvjGRFgSiGPGYW6qAU56KXdeI58ztdVvEE=
X-Google-Smtp-Source: ABdhPJw3iXSESWTX903d/nKwuPvu0+X+wTsglA0N1q1VryZJj9NwZpzQdAG7uiq4L6m+cOg5VSJ55vm1FKHDqS6dR0Y=
X-Received: by 2002:a6b:7841:: with SMTP id h1mr19706750iop.72.1605769384703;
 Wed, 18 Nov 2020 23:03:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605723568.git.osandov@fb.com> <977fd16687d8b0474fd9c442f79c23f53783e403.1605723568.git.osandov@fb.com>
In-Reply-To: <977fd16687d8b0474fd9c442f79c23f53783e403.1605723568.git.osandov@fb.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 Nov 2020 09:02:53 +0200
Message-ID: <CAOQ4uxiaWAT6kOkxgMgeYEcOBMsc=HtmSwssMXg0Nn=rbkZRGA@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] fs: add O_ALLOW_ENCODED open flag
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 9:18 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> The upcoming RWF_ENCODED operation introduces some security concerns:
>
> 1. Compressed writes will pass arbitrary data to decompression
>    algorithms in the kernel.
> 2. Compressed reads can leak truncated/hole punched data.
>
> Therefore, we need to require privilege for RWF_ENCODED. It's not
> possible to do the permissions checks at the time of the read or write
> because, e.g., io_uring submits IO from a worker thread. So, add an open
> flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> fcntl(). The flag is not cleared in any way on fork or exec. It must be
> combined with O_CLOEXEC when opening to avoid accidental leaks (if
> needed, it may be set without O_CLOEXEC by using fnctl()).
>
> Note that the usual issue that unknown open flags are ignored doesn't
> really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  arch/alpha/include/uapi/asm/fcntl.h  |  1 +
>  arch/parisc/include/uapi/asm/fcntl.h |  1 +
>  arch/sparc/include/uapi/asm/fcntl.h  |  1 +
>  fs/fcntl.c                           | 10 ++++++++--
>  fs/namei.c                           |  4 ++++
>  fs/open.c                            |  7 +++++++
>  include/linux/fcntl.h                |  2 +-
>  include/uapi/asm-generic/fcntl.h     |  4 ++++
>  8 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
> index 50bdc8e8a271..391e0d112e41 100644
> --- a/arch/alpha/include/uapi/asm/fcntl.h
> +++ b/arch/alpha/include/uapi/asm/fcntl.h
> @@ -34,6 +34,7 @@
>
>  #define O_PATH         040000000
>  #define __O_TMPFILE    0100000000
> +#define O_ALLOW_ENCODED        0200000000
>
>  #define F_GETLK                7
>  #define F_SETLK                8
> diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
> index 03dee816cb13..72ea9bdf5f04 100644
> --- a/arch/parisc/include/uapi/asm/fcntl.h
> +++ b/arch/parisc/include/uapi/asm/fcntl.h
> @@ -19,6 +19,7 @@
>
>  #define O_PATH         020000000
>  #define __O_TMPFILE    040000000
> +#define O_ALLOW_ENCODED        100000000
>
>  #define F_GETLK64      8
>  #define F_SETLK64      9
> diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
> index 67dae75e5274..ac3e8c9cb32c 100644
> --- a/arch/sparc/include/uapi/asm/fcntl.h
> +++ b/arch/sparc/include/uapi/asm/fcntl.h
> @@ -37,6 +37,7 @@
>
>  #define O_PATH         0x1000000
>  #define __O_TMPFILE    0x2000000
> +#define O_ALLOW_ENCODED        0x8000000
>
>  #define F_GETOWN       5       /*  for sockets. */
>  #define F_SETOWN       6       /*  for sockets. */
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 19ac5baad50f..9302f68fe698 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -30,7 +30,8 @@
>  #include <asm/siginfo.h>
>  #include <linux/uaccess.h>
>
> -#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME)
> +#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME | \
> +                   O_ALLOW_ENCODED)
>
>  static int setfl(int fd, struct file * filp, unsigned long arg)
>  {
> @@ -49,6 +50,11 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
>                 if (!inode_owner_or_capable(inode))
>                         return -EPERM;
>
> +       /* O_ALLOW_ENCODED can only be set by superuser */
> +       if ((arg & O_ALLOW_ENCODED) && !(filp->f_flags & O_ALLOW_ENCODED) &&
> +           !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
>         /* required for strict SunOS emulation */
>         if (O_NONBLOCK != O_NDELAY)
>                if (arg & O_NDELAY)
> @@ -1033,7 +1039,7 @@ static int __init fcntl_init(void)
>          * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>          * is defined as O_NONBLOCK on some platforms and not on others.
>          */
> -       BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
> +       BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
>                 HWEIGHT32(
>                         (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>                         __FMODE_EXEC | __FMODE_NONOTIFY));
> diff --git a/fs/namei.c b/fs/namei.c
> index d4a6dd772303..fbf64ce61088 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2890,6 +2890,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>         if (flag & O_NOATIME && !inode_owner_or_capable(inode))
>                 return -EPERM;
>
> +       /* O_ALLOW_ENCODED can only be set by superuser */
> +       if ((flag & O_ALLOW_ENCODED) && !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
>         return 0;
>  }
>
> diff --git a/fs/open.c b/fs/open.c
> index 9af548fb841b..f2863aaf78e7 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1040,6 +1040,13 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>                 acc_mode = 0;
>         }
>
> +       /*
> +        * O_ALLOW_ENCODED must be combined with O_CLOEXEC to avoid accidentally
> +        * leaking encoded I/O privileges.
> +        */
> +       if ((how->flags & (O_ALLOW_ENCODED | O_CLOEXEC)) == O_ALLOW_ENCODED)
> +               return -EINVAL;
> +


dup() can also result in accidental leak.
We could fail dup() of fd without O_CLOEXEC. Should we?

If we should than what error code should it be? We could return EPERM,
but since we do allow to clear O_CLOEXEC or set O_ALLOW_ENCODED
after open, EPERM seems a tad harsh.
EINVAL seems inappropriate because the error has nothing to do with
input args of dup() and EBADF would also be confusing.

Thanks,
Amir.
