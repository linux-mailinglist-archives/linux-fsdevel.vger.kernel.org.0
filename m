Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3538C1E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhEUIeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhEUIeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:34:36 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3B0C061574;
        Fri, 21 May 2021 01:33:13 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e10so15936032ilu.11;
        Fri, 21 May 2021 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQCB7EqXEz5M5n0bjR+r4RAHYa/TPPF5gqkjPuFfzaI=;
        b=oJyss+qNBlSAkXCgRXVaOG/eZsL8oKdm5sg/nR/G/JQcX5YTiT4/aDFfMNEZay8hPS
         ylNAnMySKICFwrqTZhId0ar5tgjX7sKrI9MRuTKjeaE23utawxiZdZKAS/DoLLLIAJ4R
         7uXU+lgzflqCA4Y5hEL9IYfdBkLyLDro7jCzkfFxBh/Ut1p0YBptnoBNT5yIpy8Dh2tQ
         iXd9yt0VZPl8CUP6clbKdkCSIUjUYNrcTyVCHHsRCbAiq/wYYFRcWbu9Y49EKRGvDaqM
         0eJ+fUc0q0q+2HQKYFvuqvp7EoZJrQ/DK7CUZtDwB8ogVr2BWMCL24Fy2gUbA4lCgT79
         PW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQCB7EqXEz5M5n0bjR+r4RAHYa/TPPF5gqkjPuFfzaI=;
        b=aPMrqaZ/DEmc/Lovt+yRRCauiHZwkqIhRZ71WbBeH8969KoR/r/vRyYpz2VEyu+LKJ
         8XUBMRexkNRwFu0Ftj4IMJBvFHA1xnOpzkbH7UPz5K87SblL2EeJja/C6yz1S3uKEoHD
         2JaOuCXv5y84UUAAThnoMv8/Pal2DMtyA3kgwbo+vM9HVP4RCJlAncXArNfRoiNf4HZ+
         719O8HiGmFQUo+y7zLOtq7Gq6ySa2iDCEciQdvyPnhqj0XRG4f4CNUJXBezb8pYvvOOM
         1Twz0lbILj+zIsWRfzXavQLX6y/gzJZh1TpYxaHvxPvKUtjZbFsaEXv3RqFIZCGu2cFd
         o2Tg==
X-Gm-Message-State: AOAM530lvcRHjmx2nr9cn5kw/wqJ6cM1k20cufqabxM2Mvucf6z5i1H/
        U+c3bj+PDCB8V/ty/Ph73G0743RE2HaUpY6MIpo=
X-Google-Smtp-Source: ABdhPJwxUXwGtDhbjedppx7u3p1rgJS1S3j7EcGV74Ejlta6HvfTxkftzOy2oCsNTiS8O9R1q8ZZuISPhZLWEKIqHhg=
X-Received: by 2002:a92:4446:: with SMTP id a6mr11083170ilm.9.1621585992715;
 Fri, 21 May 2021 01:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-3-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-3-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 11:33:01 +0300
Message-ID: <CAOQ4uxh=6V4xidmC1eaGN-+=x8K-Yzz5r2Bpdo9uaqYr-5XiRQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] fanotify: Split fsid check from other fid mode checks
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_ERROR will require fsid, but not necessarily require the filesystem
> to expose a file handle.  Split those checks into different functions, so
> they can be used separately when setting up an event.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Changes since v1:
>   (Amir)
>   - Rename fanotify_check_path_fsid -> fanotify_test_fsid
>   - Use dentry directly instead of path
> ---
>  fs/notify/fanotify/fanotify_user.c | 43 ++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 3ccdee3c9f1e..9cc6c8808ed5 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1178,15 +1178,31 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  }
>
>  /* Check if filesystem can encode a unique fid */
> -static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> +static int fanotify_test_fid(struct dentry *dentry)
> +{
> +       /*
> +        * We need to make sure that the file system supports at least
> +        * encoding a file handle so user can use name_to_handle_at() to
> +        * compare fid returned with event to the file handle of watched
> +        * objects. However, name_to_handle_at() requires that the
> +        * filesystem also supports decoding file handles.
> +        */
> +       if (!dentry->d_sb->s_export_op ||
> +           !dentry->d_sb->s_export_op->fh_to_dentry)
> +               return -EOPNOTSUPP;
> +
> +       return 0;
> +}
> +

Nit: move this helper below test_fsid.
The patch will be smaller and easier to review and more
important, less churn that hides the true git blame on the code above.

Thanks,
Amir.
