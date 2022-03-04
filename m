Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7925F4CCDAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 07:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiCDGYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 01:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiCDGYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:24:05 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC97652D6
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 22:23:17 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i1so5836385ila.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Mar 2022 22:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mF4k6k4qZhVDBGhI2HTR6SvvBAN87G8cTWnTlUi0X6I=;
        b=D7p/zioF+i8lYfgIicP32faAz5EDWuh8QDUD1FLSyM1TFXxeOj5GlfczsPRce0HKEh
         BAlr9vUlK9A7XkKeKIaR+vT7zM5tp41Nw0LjtSpg8EP0fYat3TNZw/d49d5IeEeT70eh
         I7ZrCz4q1PQ7HRhqW/YxunK6J53i6gKXvzWzMCiclF4ToL6luZipY2b6jBdt1FHS75NF
         7n0R8pEnA8Dn/3C8ya+7m26vWgWgFV1nGmOY1s57VuiplzEaSq7lBIpk1B6yQ9u5GnWk
         LCl6/MFne1dil8y6Ebo0fvSgBA1R274ugMDBIsMTxnZp1un7rD2Bk5rb/gE8zpnuWVS/
         +F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mF4k6k4qZhVDBGhI2HTR6SvvBAN87G8cTWnTlUi0X6I=;
        b=qaZvYsc7EKHo3Hszin0vmhOfl+pJn8LcbHeI/iDC7HoehIed/USWynEqWImDRKItSW
         mSIsciDmB70YPGYtoILSgThS5SAxVtOHs7J4FkMyFP9c/TfdNT5trT926q5PJI4j7n1I
         eAJzr83WEJgv2atUq0hb24JRgcnPySk+rgKM5JnvYzv39PVPu3yRriHNvT47kWLD7gXs
         RF3J5RRdh8zPAeYpKILK517iQUjjUaGN8FLKzj7vaRCfS+nGHvB+X+gsy+3JVE7bsfUu
         8EOih1STPYgIBMULDeQw962iZX3mt/LlbZi5XuTgd1fpPEfs+o7Gpq6gpS6Lf+qVxN4A
         B2aA==
X-Gm-Message-State: AOAM530Uk/jJQxHc1CqgHhMGTCmbRgishsRYCY+FpMKHZkD8t4b+E629
        0T+iQP4Jj8oSU3EV4810fiCmTUdgFm/dC8uyuZemOw==
X-Google-Smtp-Source: ABdhPJxgd7XWs0MadO9D3iJn9Ld23N99UXpiGr1rsya61enx2oHUVpYg5sC74ppFNuPhaz5qV0P2LXqg96MA2bEkk5I=
X-Received: by 2002:a05:6e02:1a6b:b0:2c1:f077:1275 with SMTP id
 w11-20020a056e021a6b00b002c1f0771275mr35692763ilv.180.1646374997211; Thu, 03
 Mar 2022 22:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20211229040239.66075-1-zhangjiachen.jaycee@bytedance.com> <YhX1QlW87Hs/HS4h@miu.piliscsaba.redhat.com>
In-Reply-To: <YhX1QlW87Hs/HS4h@miu.piliscsaba.redhat.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Fri, 4 Mar 2022 14:23:05 +0800
Message-ID: <CAFQAk7gUCefe7WJhLD-oJdnjowqDVorpYv_u9_AqkceTvn9xNA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] fuse: fix deadlock between atomic
 O_TRUNC open() and page invalidations
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 4:50 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Dec 29, 2021 at 12:02:39PM +0800, Jiachen Zhang wrote:
> > fuse_finish_open() will be called with FUSE_NOWRITE set in case of atomic
> > O_TRUNC open(), so commit 76224355db75 ("fuse: truncate pagecache on
> > atomic_o_trunc") replaced invalidate_inode_pages2() by truncate_pagecache()
> > in such a case to avoid the A-A deadlock. However, we found another A-B-B-A
> > deadlock related to the case above, which will cause the xfstests
> > generic/464 testcase hung in our virtio-fs test environment.
> >
> > For example, consider two processes concurrently open one same file, one
> > with O_TRUNC and another without O_TRUNC. The deadlock case is described
> > below, if open(O_TRUNC) is already set_nowrite(acquired A), and is trying
> > to lock a page (acquiring B), open() could have held the page lock
> > (acquired B), and waiting on the page writeback (acquiring A). This would
> > lead to deadlocks.
> >
> > open(O_TRUNC)
> > ----------------------------------------------------------------
> > fuse_open_common
> >   inode_lock            [C acquire]
> >   fuse_set_nowrite      [A acquire]
> >
> >   fuse_finish_open
> >     truncate_pagecache
> >       lock_page         [B acquire]
> >       truncate_inode_page
> >       unlock_page       [B release]
> >
> >   fuse_release_nowrite  [A release]
> >   inode_unlock          [C release]
> > ----------------------------------------------------------------
> >
> > open()
> > ----------------------------------------------------------------
> > fuse_open_common
> >   fuse_finish_open
> >     invalidate_inode_pages2
> >       lock_page         [B acquire]
> >       fuse_launder_page
> >         fuse_wait_on_page_writeback [A acquire & release]
> >       unlock_page       [B release]
> > ----------------------------------------------------------------
> >
> > Besides this case, all calls of invalidate_inode_pages2() and
> > invalidate_inode_pages2_range() in fuse code also can deadlock with
> > open(O_TRUNC). This commit tries to fix it by adding a new lock,
> > atomic_o_trunc, to protect the areas with the A-B-B-A deadlock risk.
>
> Thanks.  Can you please try the following patch?  Instead of introducing a new
> lock it tries to fix this by moving the truncate_pagecache() out of the nowrite
> protected section.
>
> Thanks,
> Miklos
>
> ---
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 656e921f3506..56f439719129 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -537,6 +537,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         struct fuse_file *ff;
>         void *security_ctx = NULL;
>         u32 security_ctxlen;
> +       bool trunc = flags & O_TRUNC;
>
>         /* Userspace expects S_IFREG in create mode */
>         BUG_ON((mode & S_IFMT) != S_IFREG);
> @@ -561,7 +562,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         inarg.mode = mode;
>         inarg.umask = current_umask();
>
> -       if (fm->fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
> +       if (fm->fc->handle_killpriv_v2 && trunc &&
>             !(flags & O_EXCL) && !capable(CAP_FSETID)) {
>                 inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
>         }
> @@ -623,6 +624,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         } else {
>                 file->private_data = ff;
>                 fuse_finish_open(inode, file);
> +               if (fm->fc->atomic_o_trunc && trunc)
> +                       truncate_pagecache(inode, 0);
>         }
>         return err;
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 829094451774..2e041708ef44 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -210,7 +210,6 @@ void fuse_finish_open(struct inode *inode, struct file *file)
>                 fi->attr_version = atomic64_inc_return(&fc->attr_version);
>                 i_size_write(inode, 0);
>                 spin_unlock(&fi->lock);
> -               truncate_pagecache(inode, 0);
>                 file_update_time(file);
>                 fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
>         } else if (!(ff->open_flags & FOPEN_KEEP_CACHE)) {
> @@ -239,30 +238,32 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
>         if (err)
>                 return err;
>
> -       if (is_wb_truncate || dax_truncate) {
> +       if (is_wb_truncate || dax_truncate)
>                 inode_lock(inode);
> -               fuse_set_nowrite(inode);
> -       }
>
>         if (dax_truncate) {
>                 filemap_invalidate_lock(inode->i_mapping);
>                 err = fuse_dax_break_layouts(inode, 0, 0);
>                 if (err)
> -                       goto out;
> +                       goto out_inode_unlock;
>         }
>
> +       if (is_wb_truncate || dax_truncate)
> +               fuse_set_nowrite(inode);
> +
>         err = fuse_do_open(fm, get_node_id(inode), file, isdir);
>         if (!err)
>                 fuse_finish_open(inode, file);
>
> -out:
> +       if (is_wb_truncate | dax_truncate)
> +               fuse_release_nowrite(inode);
> +       if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC))
> +               truncate_pagecache(inode, 0);
>         if (dax_truncate)
>                 filemap_invalidate_unlock(inode->i_mapping);
> -
> -       if (is_wb_truncate | dax_truncate) {
> -               fuse_release_nowrite(inode);
> +out_inode_unlock:
> +       if (is_wb_truncate | dax_truncate)
>                 inode_unlock(inode);
> -       }
>
>         return err;
>  }

Hi, Miklos,

I tested this fix, and it did pass the xfstests generic/464 in our
environment. However, if I understand correctly, one of the usages of
the nowrite is to protect file truncation, as said in the commit
message of e4648309b85a78f8c787457832269a8712a8673e. So, does that
mean this fix may introduce some other problems?

Thanks,
Jiachen
