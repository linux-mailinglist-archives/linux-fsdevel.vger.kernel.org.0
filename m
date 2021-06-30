Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B853B7C06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhF3DQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhF3DQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:16:51 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC6C061760;
        Tue, 29 Jun 2021 20:14:23 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 3so1466794ilj.3;
        Tue, 29 Jun 2021 20:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4j9zSzgiR5o9dBrvDRjpy5UHlIQLNlyRVTLl62YnG8=;
        b=ZubH7KLZ6mjB4pFSL4MvhFzmLK82l4Zi8ifNgP/teFBOutPRUrkwUsTpk2HbPr3EVX
         /ejjazgSvw582cFHrFddC2mqZeXZVDMPme+Tx364PidcCffgtHXJd+bJAP9/RPawNkvs
         aJ1w55rljOynqiRxH8anXFMVI0M5u5hmc7tLYW+hjYGlYSb3zj4rl2gpPfQuLBydcMBI
         NQauMx3Ykr7n+ssI4hpobWHA6QVQ8ZowCKUW3MMgZfLuXPRT+7+1YrEPMgXCs7ZbEP9j
         bcNwR1sm+obZDBQmM7/NM5llUXOX9xqyD9zjg719czoaHH/lMVeP4/EGvA5nMSgN+kJv
         xZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4j9zSzgiR5o9dBrvDRjpy5UHlIQLNlyRVTLl62YnG8=;
        b=uW24/i/uCIAe0tw1ZTHHlA7kL5Nqxk/FTmA4wzKwv51cG1tLEmej/Yy3kqbC41kEol
         MZmmgDzzNMq5Y4aXQXbqZsdGhTlDsejY+TBvUqII+jJmx28TmxMJpvb4+odhlZxm0Og2
         NFj72xfqqExHxYCk8bsSgJk+1YS5hYmnTNPPTtu4klj0QtgT+tCEvbJLV0fkXjHdgi+R
         GWD/TWGJNVXSQ3e/y/Vsa1PrJ2MNST0/Xr0kdYs9lvjVHfvHqORqsZm5BoIQakDiwjyV
         NZ4Rvdu30AQeQSP3twWAPlmt5SDPpaU+VewsNkw2MG/Y038pLUfqS8ZQqaM8Emgud/KE
         56Qw==
X-Gm-Message-State: AOAM531gS6wd86uqld11H8J5j4rtkRbgGVj+rbkFpzwJU/Alp+xO/jCp
        fHNdxjZvgaoT8n/hIn0dlKxJIabpsZVjpQwaKsE=
X-Google-Smtp-Source: ABdhPJxxDuCPU7gPEHkoM9hHl+JwK2kl2kwAr4NRxG0uElRA7xjAzEmeZftFGRLtr5dT1wLdtfvLatDx/HACmTSlFxI=
X-Received: by 2002:a92:dd05:: with SMTP id n5mr13801681ilm.72.1625022862724;
 Tue, 29 Jun 2021 20:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-4-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-4-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 06:14:11 +0300
Message-ID: <CAOQ4uxhxSetEOxdLiG=UgDdZqG-Giz4d5425kXtTNxAfbwybzg@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] fanotify: Split fsid check from other fid mode checks
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:12 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_FS_ERROR will require fsid, but not necessarily require the
> filesystem to expose a file handle.  Split those checks into different
> functions, so they can be used separately when setting up an event.
>
> While there, update a comment about tmpfs having 0 fsid, which is no
> longer true.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v2:
>   - FAN_ERROR -> FAN_FS_ERROR (Amir)
>   - Update comment (Amir)
>
> Changes since v1:
>   (Amir)
>   - Sort hunks to simplify diff.
> Changes since RFC:
>   (Amir)
>   - Rename fanotify_check_path_fsid -> fanotify_test_fsid.
>   - Use dentry directly instead of path.
> ---
>  fs/notify/fanotify/fanotify_user.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 68a53d3534f8..67b18dfe0025 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1192,16 +1192,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>         return fd;
>  }
>
> -/* Check if filesystem can encode a unique fid */
> -static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> +static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
>  {
>         __kernel_fsid_t root_fsid;
>         int err;
>
>         /*
> -        * Make sure path is not in filesystem with zero fsid (e.g. tmpfs).
> +        * Make sure dentry is not of a filesystem with zero fsid (e.g. fuse).
>          */
> -       err = vfs_get_fsid(path->dentry, fsid);
> +       err = vfs_get_fsid(dentry, fsid);
>         if (err)
>                 return err;
>
> @@ -1209,10 +1208,10 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
>                 return -ENODEV;
>
>         /*
> -        * Make sure path is not inside a filesystem subvolume (e.g. btrfs)
> +        * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
>          * which uses a different fsid than sb root.
>          */
> -       err = vfs_get_fsid(path->dentry->d_sb->s_root, &root_fsid);
> +       err = vfs_get_fsid(dentry->d_sb->s_root, &root_fsid);
>         if (err)
>                 return err;
>
> @@ -1220,6 +1219,12 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
>             root_fsid.val[1] != fsid->val[1])
>                 return -EXDEV;
>
> +       return 0;
> +}
> +
> +/* Check if filesystem can encode a unique fid */
> +static int fanotify_test_fid(struct dentry *dentry)
> +{
>         /*
>          * We need to make sure that the file system supports at least
>          * encoding a file handle so user can use name_to_handle_at() to
> @@ -1227,8 +1232,8 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
>          * objects. However, name_to_handle_at() requires that the
>          * filesystem also supports decoding file handles.
>          */
> -       if (!path->dentry->d_sb->s_export_op ||
> -           !path->dentry->d_sb->s_export_op->fh_to_dentry)
> +       if (!dentry->d_sb->s_export_op ||
> +           !dentry->d_sb->s_export_op->fh_to_dentry)
>                 return -EOPNOTSUPP;
>
>         return 0;
> @@ -1379,7 +1384,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>         }
>
>         if (fid_mode) {
> -               ret = fanotify_test_fid(&path, &__fsid);
> +               ret = fanotify_test_fsid(path.dentry, &__fsid);
> +               if (ret)
> +                       goto path_put_and_out;
> +
> +               ret = fanotify_test_fid(path.dentry);
>                 if (ret)
>                         goto path_put_and_out;
>
> --
> 2.32.0
>
