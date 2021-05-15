Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0565381902
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 May 2021 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhEONNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 May 2021 09:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhEONNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 May 2021 09:13:47 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03450C061573;
        Sat, 15 May 2021 06:12:33 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n40so1439713ioz.4;
        Sat, 15 May 2021 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwygFXXLx2Hp37+1l3yiPQHPmvgV5fL8BNhZ6rtr6nY=;
        b=HUMhUN7CLLmtBGIShdOvu9GPChvJPJRKOaVNQqEhD78guNNa/1DphjdnfJsKuI4anh
         wU34AnTiTEu+xMPX1G9Ov8vr/Oh++e6DC4nL3FzGNXlkO3HlT0V1fGnsPPBxKsVrPfEr
         xe7jsgST+GDH85ScTRSrzxyLKGUjwPfdkw3OsizdwMRs9zVUjpSKS2OUkEChKYsCdi63
         UZMN6flHXhMNv0l4XWaVDJ9sJIEg6X6dc6bW3wm8SqOTYlpSpYf7IAykuJyHJkXwm7Lb
         +nDaq2u1zdthIxNOk/FbPdt/f2Dc9qa4mO+Bh7eohiHx4Xg6QqFpjRbqhoA4SLIxbzZH
         aOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwygFXXLx2Hp37+1l3yiPQHPmvgV5fL8BNhZ6rtr6nY=;
        b=T6uCUVwATRqFunXWL3B9twKLRhMIZAae60oAqwnmXV0E247vIx0EJx6NEjl/MGU1Cc
         lqyM3yjqg5cXCQSIOMol6OARzwDwpReDJCP0sqcUmCk+C8RjBPyUA/i++jzvrWBk6xo1
         zKU2QYmLSpf0N9UK9cSljxFrzZX6GXi2eRVyH+7GwQlGWsHh/TOv/cIqXsjHx8vM0bsC
         JKR0euSCLBMcA7oJ+SQNdLZ1FeUz54navACpMu1BdHNuIBk1k7Qjsj4Np8XWvT1bcPEl
         8EguO4Aw5XQ68bRY8KsnPDlCHx5zK/ITIONJmzakMwIrGQoIixKnoljICkB8yMXejX2y
         alRg==
X-Gm-Message-State: AOAM530Ke1eOQGaE7A5gDYZ7hoH9AFMsEC/BQ+IP3GQeQ9vdwfoPskQj
        AzHpCicHdKsL4mouQtJen8D7l3bWUcUdbmkp/iw=
X-Google-Smtp-Source: ABdhPJx9ApxVEC6UJctJzc+B4BwAc8I7kMGU/xZRv6Q7ZBR7pQk8cgoIGFQRFOflBRYBmrYY+g5o0uQ0MFPEZXalrDs=
X-Received: by 2002:a02:3505:: with SMTP id k5mr27271014jaa.123.1621084352231;
 Sat, 15 May 2021 06:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <1ff9dd79cd4938a28c3ff3045c0d639f412eb10b.1620934543.git.josef@toxicpanda.com>
In-Reply-To: <1ff9dd79cd4938a28c3ff3045c0d639f412eb10b.1620934543.git.josef@toxicpanda.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 15 May 2021 16:12:20 +0300
Message-ID: <CAOQ4uxhWz_J4fir9ft5XpRVHoNCdk_bP1y-a=MhBqRYSf3N8gA@mail.gmail.com>
Subject: Re: [PATCH v2] fsnotify: rework unlink/rmdir notify events
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 10:38 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> A regression was introduced by 116b9731ad76 ("fsnotify: add empty
> fsnotify_{unlink,rmdir}() hooks"), which moved the fsnotify event for
> unlink and rmdir to before the d_delete.  This was noticed by a tool we

As the referenced commit description implies, it could not have caused the
regression because it added empty hooks. It was part the a patch series [1]
that caused the regression, but the commit that caused the
regression is more likely 49246466a989
("fsnotify: move fsnotify_nameremove() hook out of d_delete()").


> have internally for validating a FUSE file system.  This tool watches
> for IN_DELETE events and then stat's the file to make sure the file was
> actually deleted.  This started failing on our newer kernels, and it was
> traced to this patch.
>
> The problem is there's a slight window where we emit the event and
> we delete the dentry.  We can easily get the event before we've called
> d_delete, and then stat the file before we're able to remove it.  This
> is easily reproducible with the following reproducer
>

[...]

> Fix this by introducing a d_delete_notify() and a fsnotify_delete()
> helper.  d_delete_notify() will hold onto the dentry inode, do the
> d_delete, and then call fsnotify_delete() so that we avoid the race.
> Then fix up all callers of the fsnotify_unlink/fsnotify_rmdir helpers to
> either use d_delete_notify(), or use the fsnotify_delete() helper with
> the appropriate changes to protect the lifetime of the inode.  This
> patch makes the test no longer fail.
>
> Fixes: 116b9731ad76 ("fsnotify: add empty fsnotify_{unlink,rmdir}() hooks")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Took Amir's suggestion and wrapped all the weird work into a d_delete_notify()
>   helper and used that everywhere.
> - Removed fsnotify_unlink/fsnotify_rmdir, replaced it with a fsnotify_delete()
>   helper.
>
>  fs/btrfs/ioctl.c         |  6 ++----
>  fs/configfs/dir.c        |  6 ++----
>  fs/dcache.c              | 18 ++++++++++++++++++
>  fs/devpts/inode.c        |  7 ++++++-
>  fs/libfs.c               | 10 +++++-----
>  fs/namei.c               |  6 ++----
>  fs/nfsd/nfsctl.c         |  3 +--
>  include/linux/dcache.h   |  1 +
>  include/linux/fsnotify.h | 25 +++++++------------------
>  net/sunrpc/rpc_pipe.c    | 15 +++++++++++----
>  10 files changed, 55 insertions(+), 42 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5dc2fd843ae3..d9854db80e28 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2990,10 +2990,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>         btrfs_inode_lock(inode, 0);
>         err = btrfs_delete_subvolume(dir, dentry);
>         btrfs_inode_unlock(inode, 0);
> -       if (!err) {
> -               fsnotify_rmdir(dir, dentry);
> -               d_delete(dentry);
> -       }
> +       if (!err)
> +               d_delete_notify(dir, dentry);
>
>  out_dput:
>         dput(dentry);
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index ac5e0c0e9181..2f187766f2e2 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1805,8 +1805,7 @@ void configfs_unregister_group(struct config_group *group)
>         configfs_detach_group(&group->cg_item);
>         d_inode(dentry)->i_flags |= S_DEAD;
>         dont_mount(dentry);
> -       fsnotify_rmdir(d_inode(parent), dentry);
> -       d_delete(dentry);
> +       d_delete_notify(d_inode(parent), dentry);
>         inode_unlock(d_inode(parent));
>
>         dput(dentry);
> @@ -1947,10 +1946,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
>         configfs_detach_group(&group->cg_item);
>         d_inode(dentry)->i_flags |= S_DEAD;
>         dont_mount(dentry);
> -       fsnotify_rmdir(d_inode(root), dentry);
>         inode_unlock(d_inode(dentry));
>
> -       d_delete(dentry);
> +       d_delete_notify(d_inode(root), dentry);
>
>         inode_unlock(d_inode(root));
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index cf871a81f4fd..b342696c07f9 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2511,6 +2511,24 @@ void d_delete(struct dentry * dentry)
>  }
>  EXPORT_SYMBOL(d_delete);
>
> +/**
> + * d_delete_notify - delete a dentry and emit the fsnotify event
> + * @dir: The directory containing the dentry
> + * @dentry: The dentry to delete
> + *
> + * This operates exactly as d_delete, but also emits the fsnotify event for the
> + * deletion as well.
> + */
> +void d_delete_notify(struct inode *dir, struct dentry *dentry)
> +{
> +       struct inode *inode = dentry->d_inode;
> +
> +       ihold(inode);
> +       d_delete(dentry);
> +       fsnotify_delete(dir, dentry, inode);
> +       iput(inode);
> +}
> +
>  static void __d_rehash(struct dentry *entry)
>  {
>         struct hlist_bl_head *b = d_hash(entry->d_name.hash);
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index 42e5a766d33c..714e6f9b74f5 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -617,12 +617,17 @@ void *devpts_get_priv(struct dentry *dentry)
>   */
>  void devpts_pty_kill(struct dentry *dentry)
>  {
> +       struct inode *dir = d_inode(dentry->d_parent);
> +       struct inode *inode = d_inode(dentry);
> +
>         WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
>
> +       ihold(inode);
>         dentry->d_fsdata = NULL;
>         drop_nlink(dentry->d_inode);
> -       fsnotify_unlink(d_inode(dentry->d_parent), dentry);
>         d_drop(dentry);
> +       fsnotify_delete(dir, dentry, inode);
> +       iput(inode);
>         dput(dentry);   /* d_alloc_name() in devpts_pty_new() */
>  }
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e9b29c6ffccb..189e12dc5d9b 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -271,7 +271,7 @@ void simple_recursive_removal(struct dentry *dentry,
>         struct dentry *this = dget(dentry);
>         while (true) {
>                 struct dentry *victim = NULL, *child;
> -               struct inode *inode = this->d_inode;
> +               struct inode *inode = this->d_inode, *victim_inode;
>
>                 inode_lock(inode);
>                 if (d_is_dir(this))
> @@ -283,19 +283,19 @@ void simple_recursive_removal(struct dentry *dentry,
>                         clear_nlink(inode);
>                         inode_unlock(inode);
>                         victim = this;
> +                       victim_inode = d_inode(victim);
> +                       ihold(victim_inode);
>                         this = this->d_parent;
>                         inode = this->d_inode;
>                         inode_lock(inode);
>                         if (simple_positive(victim)) {
>                                 d_invalidate(victim);   // avoid lost mounts
> -                               if (d_is_dir(victim))
> -                                       fsnotify_rmdir(inode, victim);
> -                               else
> -                                       fsnotify_unlink(inode, victim);
> +                               fsnotify_delete(inode, victim, victim_inode);
>                                 if (callback)
>                                         callback(victim);
>                                 dput(victim);           // unpin it
>                         }
> +                       iput(victim_inode);
>                         if (victim == dentry) {
>                                 inode->i_ctime = inode->i_mtime =
>                                         current_time(inode);
> diff --git a/fs/namei.c b/fs/namei.c
> index 79b0ff9b151e..40c3ea4e5eae 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3900,13 +3900,12 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
>         dentry->d_inode->i_flags |= S_DEAD;
>         dont_mount(dentry);
>         detach_mounts(dentry);
> -       fsnotify_rmdir(dir, dentry);
>
>  out:
>         inode_unlock(dentry->d_inode);
>         dput(dentry);
>         if (!error)
> -               d_delete(dentry);
> +               d_delete_notify(dir, dentry);
>         return error;
>  }
>  EXPORT_SYMBOL(vfs_rmdir);
> @@ -4026,7 +4025,6 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
>                         if (!error) {
>                                 dont_mount(dentry);
>                                 detach_mounts(dentry);
> -                               fsnotify_unlink(dir, dentry);
>                         }
>                 }
>         }
> @@ -4036,7 +4034,7 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
>         /* We don't d_delete() NFS sillyrenamed files--they still exist. */
>         if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
>                 fsnotify_link_count(target);
> -               d_delete(dentry);
> +               d_delete_notify(dir, dentry);
>         }

This would cause a regression for NFS.
DELETE events will not be reported for deleted files with elevated d_count
and DELETE events *should* be created in that case.
I guess you could ihold(target) and call fsnotify_delete() directly
in this call site after checking only if (!error).

OTOH, if I am not mistaken d_name is already "wrong" when calling
fsnotify_unlink() in this case (it is the silly name), but at least let's not
make it any worse.

>
>         return error;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index c2c3d9077dc5..e95d122ef50d 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1337,8 +1337,7 @@ void nfsd_client_rmdir(struct dentry *dentry)
>         dget(dentry);
>         ret = simple_rmdir(dir, dentry);
>         WARN_ON_ONCE(ret);
> -       fsnotify_rmdir(dir, dentry);
> -       d_delete(dentry);
> +       d_delete_notify(dir, dentry);
>         dput(dentry);
>         inode_unlock(dir);
>  }
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 9e23d33bb6f1..86df9b269f0e 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -234,6 +234,7 @@ extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
>  extern void __d_drop(struct dentry *dentry);
>  extern void d_drop(struct dentry *dentry);
>  extern void d_delete(struct dentry *);
> +extern void d_delete_notify(struct inode *dir, struct dentry *dentry);
>  extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op);
>
>  /* allocate/de-allocate */
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..7bb06324c6b3 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -204,16 +204,18 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
>  }
>
>  /*
> - * fsnotify_unlink - 'name' was unlinked
> + * fsnotify_delete - 'name' was unlinked
>   *
>   * Caller must make sure that dentry->d_name is stable.

Please say something about the fact that dentry may be negative,
along the lines of the comment above fsnotify_link().

>   */
> -static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
> +static inline void fsnotify_delete(struct inode *dir, struct dentry *dentry,
> +                                  struct inode *inode)
>  {
> -       /* Expected to be called before d_delete() */
> -       WARN_ON_ONCE(d_is_negative(dentry));
> +       __u32 mask = FS_DELETE;
>
> -       fsnotify_dirent(dir, dentry, FS_DELETE);
> +       if (S_ISDIR(inode->i_mode))
> +               mask |= FS_ISDIR;
> +       fsnotify_name(dir, mask, inode, &dentry->d_name, 0);
>  }
>
>  /*
> @@ -226,19 +228,6 @@ static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
>         fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
>  }
>
> -/*
> - * fsnotify_rmdir - directory 'name' was removed
> - *
> - * Caller must make sure that dentry->d_name is stable.
> - */
> -static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
> -{
> -       /* Expected to be called before d_delete() */
> -       WARN_ON_ONCE(d_is_negative(dentry));
> -
> -       fsnotify_dirent(dir, dentry, FS_DELETE | FS_ISDIR);
> -}
> -
>  /*
>   * fsnotify_access - file was read
>   */
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 09c000d490a1..5dca896a60ab 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -596,26 +596,33 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
>
>  static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
>  {
> +       struct inode *inode = d_inode(dentry);
>         int ret;
>
>         dget(dentry);
> +       ihold(inode);
>         ret = simple_rmdir(dir, dentry);
> -       if (!ret)
> -               fsnotify_rmdir(dir, dentry);
>         d_delete(dentry);
> +       if (!ret)
> +               fsnotify_delete(dir, dentry, inode);
> +       iput(inode);

It is not the fault of your patch, but the fact that d_delete() is called
unconditionally and fsnotify_delete() is called conditionally is odd.

In many call sites and all call sites where simple_rmdir/simple_unlink are
inode operations, both d_delete() and fsnotify hooks are conditional on
success. In several other call sites, which are similar in nature to this
one, both d_delete() and fsnotify hooks are unconditional, so it should
apply here as well.
In fact, the way it is now is a change of behavior that was also introduced
by commit
49246466a989
("fsnotify: move fsnotify_nameremove() hook out of d_delete()")
following:
a35d632c723c ("rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks")

So just calling d_delete_notify() unconditionally should be fine here.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20190526143411.11244-1-amir73il@gmail.com/
