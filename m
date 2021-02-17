Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8015531D4B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 05:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBQEqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 23:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhBQEqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 23:46:34 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E200C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 20:45:54 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id l192so5996285vsd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 20:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uktxjKQwz4TfwBjCYOOJzA5Rs1qSh3+bpu7dP8/xG98=;
        b=Ob7vhkngcs5SWjWVOtXougGOBUPgdqIiyzX5uKLWMlq6lQTrZ2PUjthoQjHous+cx7
         d5pWfI4ADzGXpZb/8wNemgCNGcoJK7h2gX/SNiWUbKVfPuoN7gLueEhhCh06bQp2D4kj
         nO7uch7pPugyX+oLuzb8DPlSpoKToPbcLYd6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uktxjKQwz4TfwBjCYOOJzA5Rs1qSh3+bpu7dP8/xG98=;
        b=MIYnUIBeGILpqRWskYEFAM6HBPv8QfMy4ZphETRPwscRg/cBJ7PRZbxOaYHwMf9L1G
         F63w9tMc4ozotjeYRKyjXJiiOxoCdGWhKzEnyl/ye4iy9i5gMrG81ArX1tIZtu7boFA4
         JSqntWwAHMHZxT1wZBSizVeEzCu5BctZoSqdqf2cDYw0WzAEWgbZGMJPnMdHBkclbQHl
         CqEjJNKZP4Qh9TgEW98+/aBEI8zxhiN4uLny+7zb47PAbQSd2vwQYePBzGh0cZhb0slz
         rIjtj7QvM2JJSiB+XpsmqZOiWTs+hgpHz5tgsC/8GiIINPLp5pFX61c1/ThPj34WEaq2
         eybg==
X-Gm-Message-State: AOAM532WyeT4ADMLpK7g8VPhMHAia7J3A3Nbt+3FYXQBtrQbh+0agUB7
        AE40fUhSkLXE8e95EHo0c6J+lLHh3AcfvZo5toMMDg==
X-Google-Smtp-Source: ABdhPJxI8u0RvnOp3BypDJ/HZUdf2uePEnqUeAieLHAvwOaNch0GOwf7JSOHb1NAP4ygE7Ttv2XRYC6P0KVm2+/QFtU=
X-Received: by 2002:a67:8945:: with SMTP id l66mr13422008vsd.48.1613537153038;
 Tue, 16 Feb 2021 20:45:53 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de>
In-Reply-To: <20210215154317.8590-1-lhenriques@suse.de>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 17 Feb 2021 12:45:41 +0800
Message-ID: <CANMq1KCWF=yucGZ_DizvdzytW8RCXKPaQeC9huML2FJkqNWjQw@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>, ceph-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 11:42 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> Nicolas Boichat reported an issue when trying to use the copy_file_range
> syscall on a tracefs file.  It failed silently because the file content is
> generated on-the-fly (reporting a size of zero) and copy_file_range needs
> to know in advance how much data is present.

Not sure if you have the whole history, these links and discussion can
help if you want to expand on the commit message:
[1] http://issuetracker.google.com/issues/178332739
[2] https://lkml.org/lkml/2021/1/25/64
[3] https://lkml.org/lkml/2021/1/26/1736
[4] https://patchwork.kernel.org/project/linux-fsdevel/cover/20210212044405.4120619-1-drinkcat@chromium.org/

> This commit restores the cross-fs restrictions that existed prior to
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") and
> removes generic_copy_file_range() calls from ceph, cifs, fuse, and nfs.

It goes beyond that, I think this also prevents copies within the same
FS if copy_file_range is not implemented. Which is IMHO a good thing
since this has been broken on procfs and friends ever since
copy_file_range was implemented (but I assume that nobody ever hit
that before cross-fs became available).

>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Cc: Nicolas Boichat <drinkcat@chromium.org>

You could replace that with Reported-by: Nicolas Boichat <drinkcat@chromium.org>

> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Changes since v1 (after Amir review)
> - restored do_copy_file_range() helper
> - return -EOPNOTSUPP if fs doesn't implement CFR
> - updated commit description
>
>  fs/ceph/file.c     | 21 +++-----------------
>  fs/cifs/cifsfs.c   |  3 ---
>  fs/fuse/file.c     | 21 +++-----------------
>  fs/nfs/nfs4file.c  | 20 +++----------------
>  fs/read_write.c    | 49 ++++++++++------------------------------------
>  include/linux/fs.h |  3 ---
>  6 files changed, 19 insertions(+), 98 deletions(-)
>
[snip]
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 75f764b43418..b217cd62ae0d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1358,40 +1358,12 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
>  }
>  #endif
>
> -/**
> - * generic_copy_file_range - copy data between two files
> - * @file_in:   file structure to read from
> - * @pos_in:    file offset to read from
> - * @file_out:  file structure to write data to
> - * @pos_out:   file offset to write data to
> - * @len:       amount of data to copy
> - * @flags:     copy flags
> - *
> - * This is a generic filesystem helper to copy data from one file to another.
> - * It has no constraints on the source or destination file owners - the files
> - * can belong to different superblocks and different filesystem types. Short
> - * copies are allowed.
> - *
> - * This should be called from the @file_out filesystem, as per the
> - * ->copy_file_range() method.
> - *
> - * Returns the number of bytes copied or a negative error indicating the
> - * failure.
> - */
> -
> -ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> -                               struct file *file_out, loff_t pos_out,
> -                               size_t len, unsigned int flags)
> -{
> -       return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> -                               len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> -}
> -EXPORT_SYMBOL(generic_copy_file_range);
> -
>  static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>                                   struct file *file_out, loff_t pos_out,
>                                   size_t len, unsigned int flags)
>  {
> +       ssize_t ret = -EXDEV;
> +
>         /*
>          * Although we now allow filesystems to handle cross sb copy, passing
>          * a file of the wrong filesystem type to filesystem driver can result
> @@ -1400,14 +1372,14 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>          * several different file_system_type structures, but they all end up
>          * using the same ->copy_file_range() function pointer.
>          */
> -       if (file_out->f_op->copy_file_range &&
> -           file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
> -               return file_out->f_op->copy_file_range(file_in, pos_in,
> -                                                      file_out, pos_out,
> -                                                      len, flags);
> +       if (!file_out->f_op->copy_file_range)
> +               ret = -EOPNOTSUPP;

This doesn't work as the 0-filesize check is done before that in
vfs_copy_file_range (so the syscall still returns 0, works fine if you
comment out `if (len == 0)`).

Also, you need to check for file_in->f_op->copy_file_range instead,
the problem is if the _input_ filesystem doesn't report sizes or can't
seek properly.

> +       else if (file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
> +               ret = file_out->f_op->copy_file_range(file_in, pos_in,
> +                                                     file_out, pos_out,
> +                                                     len, flags);
>
> -       return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                                      flags);
> +       return ret;
>  }
>
>  /*
> @@ -1514,8 +1486,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>         }
>
>         ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                               flags);
> -       WARN_ON_ONCE(ret == -EOPNOTSUPP);
> +                                flags);
>  done:
>         if (ret > 0) {
>                 fsnotify_access(file_in);
