Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408851F9D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 18:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgFOQ0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbgFOQ0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:26:51 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9ABC061A0E;
        Mon, 15 Jun 2020 09:26:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t9so18548487ioj.13;
        Mon, 15 Jun 2020 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+Z8jxCIKSwW7ijnNxAqfFPdv5+6OXYtEQxCm8CXvqM=;
        b=mUVUB6mRayAKcNbN9t2oMkRHMvbtO5fddslsALc4MeEu5UWIiRReTaU1+C+SR+KtF4
         EOI8YyzKLRQjrtLZ6m6CSB51/DbYA0bqOEDTtUBJLcqjzjhkR8RGms8P9vP8nOLz3WRD
         836ArE3I+tJQF3lpHO8JJ4odMQD8LJWGtcpLZxyveQb/VivQOTK18VCYFbIGU2sXkQL3
         Q4UmUCIPfNW+pobkoD7FSd4oxDqdbxEjE+mb1WEV3O5cKqN0NxyVF1nqgNqmCXQd/dMi
         1mgSEi0SHGLq82ysFjK5hhhKeVI1cJ/SzJFZ82NNNyXd3H2G2GN2vHUxMBYu17XK1v01
         ex2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+Z8jxCIKSwW7ijnNxAqfFPdv5+6OXYtEQxCm8CXvqM=;
        b=Z17IyQeL/IjI9sqyTC+UZeXE1FzPwyrC3UoOBTL7bItOeEFX3507P7QjxAfwnoOULp
         cwuavKeZFPtdmQz/PIgfr2XVLUrfp8qTMz+CUz5vaMcBQdUHWp/Toq8umFYD4h9BLCAm
         C1O3N5MRZ87q59VIp4Pyj9N86N011Uu/f6Fqc5KqzXIe1Ztcay0mGkgltMic0D8MCQwS
         wIce+7zmO8Ih717/idAUqTi5I15Hx1BAqMXKyUtVXlqOldGgFmIjZ7xWxX5gbuEUCHTW
         UpQridOJyW9JRXtSxTnSLKmcwhV/bMngGISn+BnoQbJ/rW4ufJyJwhFb1hX3CqzJN3YJ
         lRcg==
X-Gm-Message-State: AOAM53385BntPtGmv5ktFIL+yzQjgoNPQoiFqwa6eHFt6h4+YuhcEr6k
        9eVqgw7Q+LbSxYZxgtgxVFZc0cXpr4RCBcPXlKG6s6ho
X-Google-Smtp-Source: ABdhPJzOYAF9vFopaDrb8NFGm/PEjiL8DOcAiQnEElqz28kl0e+MiHKHjL+MRG3ENZ3YQMR674c8WoU1FPOLQa6f1f8=
X-Received: by 2002:a05:6638:d96:: with SMTP id l22mr22700860jaj.120.1592238409573;
 Mon, 15 Jun 2020 09:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121358.GF3183@techsingularity.net>
In-Reply-To: <20200615121358.GF3183@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Jun 2020 19:26:38 +0300
Message-ID: <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:14 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Changelog since v1
> o Updated changelog

Slipped to commit message

>
> The kernel uses internal mounts created by kern_mount() and populated
> with files with no lookup path by alloc_file_pseudo for a variety of
> reasons. An example of such a mount is for anonymous pipes. For pipes,
> every vfs_write regardless of filesystem, fsnotify_modify() is called to
> notify of any changes which incurs a small amount of overhead in fsnotify
> even when there are no watchers. It can also trigger for reads and readv
> and writev, it was simply vfs_write() that was noticed first.
>
> A patch is pending that reduces, but does not eliminte, the overhead of

typo: eliminte

> fsnotify but for files that cannot be looked up via a path, even that
> small overhead is unnecessary. The user API for fanotify is based on
> the pathname and a dirfd and proc entries appear to be the only visible
> representation of the files. Proc does not have the same pathname as the
> internal entry and the proc inode is not the same as the internal inode
> so even if fanotify is used on a file under /proc/XX/fd, no useful events
> are notified.
>

Note that fanotify is not the only uapi to add marks, but this is fine by me
I suppose if Jan wants to he can make small corrections on commit.

> This patch changes alloc_file_pseudo() to always opt out of fsnotify by
> setting FMODE_NONOTIFY flag so that no check is made for fsnotify watchers
> on pseudo files. This should be safe as the underlying helper for the
> dentry is d_alloc_pseudo which explicitly states that no lookups are ever
> performed meaning that fanotify should have nothing useful to attach to.
>
> The test motivating this was "perf bench sched messaging --pipe". On
> a single-socket machine using threads the difference of the patch was
> as follows.
>
>                               5.7.0                  5.7.0
>                             vanilla        nofsnotify-v1r1
> Amean     1       1.3837 (   0.00%)      1.3547 (   2.10%)
> Amean     3       3.7360 (   0.00%)      3.6543 (   2.19%)
> Amean     5       5.8130 (   0.00%)      5.7233 *   1.54%*
> Amean     7       8.1490 (   0.00%)      7.9730 *   2.16%*
> Amean     12     14.6843 (   0.00%)     14.1820 (   3.42%)
> Amean     18     21.8840 (   0.00%)     21.7460 (   0.63%)
> Amean     24     28.8697 (   0.00%)     29.1680 (  -1.03%)
> Amean     30     36.0787 (   0.00%)     35.2640 *   2.26%*
> Amean     32     38.0527 (   0.00%)     38.1223 (  -0.18%)
>
> The difference is small but in some cases it's outside the noise so
> while marginal, there is still some small benefit to ignoring fsnotify
> for files allocated via alloc_file_pseudo in some cases.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/file_table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 30d55c9a1744..0076ccf67a7d 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -229,7 +229,7 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
>                 d_set_d_op(path.dentry, &anon_ops);
>         path.mnt = mntget(mnt);
>         d_instantiate(path.dentry, inode);
> -       file = alloc_file(&path, flags, fops);
> +       file = alloc_file(&path, flags | FMODE_NONOTIFY, fops);
>         if (IS_ERR(file)) {
>                 ihold(inode);
>                 path_put(&path);
