Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9868336BEAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 06:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhD0EyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 00:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhD0EyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:54:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C88C061574;
        Mon, 26 Apr 2021 21:53:17 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f21so22255654ioh.8;
        Mon, 26 Apr 2021 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJ+q1oJfO9X2bfJR2nU6a3jdYBMwCxEIQeRUT5Rprd8=;
        b=X2ENgEo+kg5ha5U7EVzMZgr4hdZGsk4zM9sj2G7SvS3s+0K83izQrkP2GVvwDEFMaL
         QIINYTnmHr0+3nX/Og5hA1UfBLNxOE8xVZHQazUM2zDkUPa9SdHMNqSDgmnGYTbHJ6bM
         1+5SnyIJbnvIPwY4WVeo04UXZdUUnP0UmXE1s7wtq4578RDvCJedslr6jmPx56RivR8f
         LXa2/TVvkTVA9+ovuBtyjzM1QxVQeUOHQgPEKq1KIOLIemEvtajtMZXIcyR0RLL6fnoR
         X3JuVqj3kuEAtUX6UyOtYaYYhUnma7vfEY6f8h4OWFur/wdzrxO9hlNgTbkK8r3B5F5M
         mcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ+q1oJfO9X2bfJR2nU6a3jdYBMwCxEIQeRUT5Rprd8=;
        b=n57sM+MzUnmA7ZoY4Sg1MxOYu7YhvnxGqh2UNeaBWkDHCq7eyx3Xk+kWe2N/VsV50C
         QlpP0OK5P0UNS21bsJu/W3ZSZkD1GPe/Kx6hhoXAluZ0WQzlfL1oyC9yvTGOG3rl3DH8
         SnPNBgXi+57XX40Wmfg4iTT1Gc0KWOyToFsQxGBOMOkNa0fY0WdrEKETlfSplLX/NEMt
         ra6K4r0YjZ2V4x9CaFpAqesY/knDn/hqLs0pAPGaFNgmmWrUod5q+EFTyeNFc6yrjB/Y
         cXfBkD0UEq3fv8MDNdmheke/PPEav/52dIZpYBIM5qDPuH40sn3zs6YPhHIaZa4+zz1M
         fjyA==
X-Gm-Message-State: AOAM530Ou+oq6RwFdigUKazP/bG8mXOmLz/6f71N9j96GFOHBl9694ia
        y6B/uVShC9IsLyg7MgSrHM+FhQeHx0wV9S4iKM0=
X-Google-Smtp-Source: ABdhPJweJbLptvp5YqBNzAsC99KdUcv52veJQPQUBa6gUlTQExbpjNazJQhq1OdiQicrFa/R6b5ue0k8JKpdZtPJCF4=
X-Received: by 2002:a05:6602:58d:: with SMTP id v13mr16968137iox.64.1619499197053;
 Mon, 26 Apr 2021 21:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-3-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-3-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 07:53:06 +0300
Message-ID: <CAOQ4uxjkt2RRPm__sGEXefWnyrrPEvEahbWHC=NnF29yrKonWA@mail.gmail.com>
Subject: Re: [PATCH RFC 02/15] fanotify: Split fsid check from other fid mode checks
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:42 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_ERROR will require fsid, but not necessarily require the filesystem
> to expose a file handle.  Split those checks into different functions, so
> they can be used separately when creating a mark.

Ok for the split, but...

>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 35 +++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 0332c4afeec3..e0d113e3b65c 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1055,7 +1055,23 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  }
>
>  /* Check if filesystem can encode a unique fid */
> -static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> +static int fanotify_test_fid(struct path *path)

This helper can take a dentry.

> +{
> +       /*
> +        * We need to make sure that the file system supports at least
> +        * encoding a file handle so user can use name_to_handle_at() to
> +        * compare fid returned with event to the file handle of watched
> +        * objects. However, name_to_handle_at() requires that the
> +        * filesystem also supports decoding file handles.
> +        */
> +       if (!path->dentry->d_sb->s_export_op ||
> +           !path->dentry->d_sb->s_export_op->fh_to_dentry)
> +               return -EOPNOTSUPP;
> +
> +       return 0;
> +}
> +
> +static int fanotify_check_path_fsid(struct path *path, __kernel_fsid_t *fsid)

And so does this helper.
I certainly don't see the need for the _path_ in the helper name.

>  {
>         __kernel_fsid_t root_fsid;
>         int err;
> @@ -1082,17 +1098,6 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
>             root_fsid.val[1] != fsid->val[1])
>                 return -EXDEV;
>
> -       /*
> -        * We need to make sure that the file system supports at least
> -        * encoding a file handle so user can use name_to_handle_at() to
> -        * compare fid returned with event to the file handle of watched
> -        * objects. However, name_to_handle_at() requires that the
> -        * filesystem also supports decoding file handles.
> -        */
> -       if (!path->dentry->d_sb->s_export_op ||
> -           !path->dentry->d_sb->s_export_op->fh_to_dentry)
> -               return -EOPNOTSUPP;
> -
>         return 0;
>  }
>
> @@ -1230,7 +1235,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>         }
>
>         if (fid_mode) {
> -               ret = fanotify_test_fid(&path, &__fsid);
> +               ret = fanotify_check_path_fsid(&path, &__fsid);
> +               if (ret)
> +                       goto path_put_and_out;
> +
> +               ret = fanotify_test_fid(&path);

Whether _test_ or _check_ please stick to one.

Thanks,
Amir.
