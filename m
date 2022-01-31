Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B44A4A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379494AbiAaPaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiAaPaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:30:10 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C698C061714;
        Mon, 31 Jan 2022 07:30:10 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q204so17325742iod.8;
        Mon, 31 Jan 2022 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4lOxvM23ZmbnldrQg7JNgiPtEWkNzkH0ubdj3bkXvY=;
        b=E0/3kS4dmJZ0FOs5Nr8pR3kfSJhdluncMh7xUx97hURzmvoKr3HH2yX+vFpkQZyWZB
         kgRMwyVwbjGw/Avh/OTciMI0wS0bBtR/2fbxoQSRsYrJDzyzVpIP1QN54g2gNfHLLf5B
         bmuNAgKFitv/+HAHlQSyO7Qy1VuwNr1Ps91OUJowJ42wY55rnV+92en/Z0RUkkb/svP5
         cJTTJOUbEvrt6Y5j/Tv1op6GQbt8Y5LGToCDWsn/jIOQet+Ai9eqlOKKm/1u4QPdx9iD
         bIUUBKQGGoKdRiSjyZJrNmXQt7JSrV46Iba688ZADFyRlCo4MYXg+eWurK93hzoWSUbs
         UkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4lOxvM23ZmbnldrQg7JNgiPtEWkNzkH0ubdj3bkXvY=;
        b=fJdZo/oXyzEZqVhTs6zvyhV+kRR0cDod94+9saLWfwfKRJkAWgza7xsDj/8e5ac7+N
         kVpc4kWWi5kGYg00dKFSrQaIf3ZjnJynKCYWH4Im791yih60IiNAVSVx6De05SKBAaiH
         gVQC0JWmfG6OBNRvu9tXEQjX3HWIW8Bd25Vdq1BuFGt+Rw+300FSQvYfN91GtGEVG8p5
         P3QnyvW3EtqqfQb0HaZC2o+iab7GpF/rBDY6ouXgeSdv19wJTR+SbjXnSMILJGBIZ4gK
         rUFxW2dBfie2Yifmf4U0t45quTjmEsOjEvlkDLv+dig0Jwjuv0s9TsxJcbN348pvk1jB
         gQHQ==
X-Gm-Message-State: AOAM530GuVZxf8LAtTfEL7vqp38VikQR0Vi7sx+/yL38FDkGMvhgqqWc
        4p2i90/42t0A74t3tN3wOOUMovYwDpoVtWwNoqM=
X-Google-Smtp-Source: ABdhPJxwibO2gO9CMmscDSoKmWbxvhWsb65y55IAyx1imtlPY+YM8ipVYN8hNLp+qpbVRoF6slntKqFUan5Y2LZjUgg=
X-Received: by 2002:a05:6638:22cf:: with SMTP id j15mr1415760jat.188.1643643009809;
 Mon, 31 Jan 2022 07:30:09 -0800 (PST)
MIME-Version: 1.0
References: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
 <164364197646.1476539.3635698398603811895.stgit@warthog.procyon.org.uk>
In-Reply-To: <164364197646.1476539.3635698398603811895.stgit@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 31 Jan 2022 17:29:58 +0200
Message-ID: <CAOQ4uxiorvXhhJbCsGo-B7aBX0BbSYp7wUHmYS1e1xxJ4dpF3w@mail.gmail.com>
Subject: Re: [PATCH 1/5] vfs, overlayfs, cachefiles: Turn I_OVL_INUSE into
 something generic
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:13 PM David Howells <dhowells@redhat.com> wrote:
>
> Turn overlayfs's I_OVL_INUSE into something generic that cachefiles can
> also use for excluding access to its own cache files by renaming it to
> I_EXCL_INUSE as suggested by Amir[1] and hoisting the helpers to generic
> code.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Amir Goldstein <amir73il@gmail.com>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: linux-unionfs@vger.kernel.org
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/CAOQ4uxhRS3MGEnCUDcsB1RL0d1Oy0g0Rzm75hVFAJw2dJ7uKSA@mail.gmail.com/ [1]
> ---
>
>  fs/inode.c               |   43 +++++++++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/overlayfs.h |    3 ---
>  fs/overlayfs/super.c     |   12 ++++++------
>  fs/overlayfs/util.c      |   43 -------------------------------------------
>  include/linux/fs.h       |   22 +++++++++++++++++++---
>  5 files changed, 68 insertions(+), 55 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 63324df6fa27..954719f66113 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2405,3 +2405,46 @@ struct timespec64 current_time(struct inode *inode)
>         return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> +
> +/**
> + * inode_excl_inuse_trylock - Try to exclusively lock an inode for kernel access
> + * @dentry: Reference to the inode to be locked
> + *
> + * Try to gain exclusive access to an inode for a kernel service, returning
> + * true if successful.
> + */
> +bool inode_excl_inuse_trylock(struct dentry *dentry)
> +{
> +       struct inode *inode = d_inode(dentry);
> +       bool locked = false;
> +
> +       spin_lock(&inode->i_lock);
> +       if (!(inode->i_state & I_EXCL_INUSE)) {
> +               inode->i_state |= I_EXCL_INUSE;
> +               locked = true;
> +       }
> +       spin_unlock(&inode->i_lock);
> +
> +       return locked;
> +}
> +EXPORT_SYMBOL(inode_excl_inuse_trylock);
> +
> +/**
> + * inode_excl_inuse_unlock - Unlock exclusive kernel access to an inode
> + * @dentry: Reference to the inode to be unlocked
> + *
> + * Drop exclusive access to an inode for a kernel service.  A warning is given
> + * if the inode was not marked for exclusive access.
> + */
> +void inode_excl_inuse_unlock(struct dentry *dentry)
> +{
> +       if (dentry) {
> +               struct inode *inode = d_inode(dentry);
> +
> +               spin_lock(&inode->i_lock);
> +               WARN_ON(!(inode->i_state & I_EXCL_INUSE));
> +               inode->i_state &= ~I_EXCL_INUSE;
> +               spin_unlock(&inode->i_lock);
> +       }
> +}
> +EXPORT_SYMBOL(inode_excl_inuse_unlock);
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 2cd5741c873b..8415c0c6d40c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -337,9 +337,6 @@ int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
>                        enum ovl_xattr ox, const void *value, size_t size,
>                        int xerr);
>  int ovl_set_impure(struct dentry *dentry, struct dentry *upperdentry);
> -bool ovl_inuse_trylock(struct dentry *dentry);
> -void ovl_inuse_unlock(struct dentry *dentry);
> -bool ovl_is_inuse(struct dentry *dentry);
>  bool ovl_need_index(struct dentry *dentry);
>  int ovl_nlink_start(struct dentry *dentry);
>  void ovl_nlink_end(struct dentry *dentry);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 7bb0a47cb615..5c3361a2dc7c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -224,10 +224,10 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>         dput(ofs->indexdir);
>         dput(ofs->workdir);
>         if (ofs->workdir_locked)
> -               ovl_inuse_unlock(ofs->workbasedir);
> +               inode_excl_inuse_unlock(ofs->workbasedir);
>         dput(ofs->workbasedir);
>         if (ofs->upperdir_locked)
> -               ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
> +               inode_excl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
>
>         /* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
>         mounts = (struct vfsmount **) ofs->layers;
> @@ -1239,7 +1239,7 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
>         if (upper_mnt->mnt_sb->s_flags & SB_NOSEC)
>                 sb->s_flags |= SB_NOSEC;
>
> -       if (ovl_inuse_trylock(ovl_upper_mnt(ofs)->mnt_root)) {
> +       if (inode_excl_inuse_trylock(ovl_upper_mnt(ofs)->mnt_root)) {
>                 ofs->upperdir_locked = true;
>         } else {
>                 err = ovl_report_in_use(ofs, "upperdir");
> @@ -1499,7 +1499,7 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
>
>         ofs->workbasedir = dget(workpath.dentry);
>
> -       if (ovl_inuse_trylock(ofs->workbasedir)) {
> +       if (inode_excl_inuse_trylock(ofs->workbasedir)) {
>                 ofs->workdir_locked = true;
>         } else {
>                 err = ovl_report_in_use(ofs, "workdir");
> @@ -1722,7 +1722,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
>                 if (err)
>                         goto out;
>
> -               if (ovl_is_inuse(stack[i].dentry)) {
> +               if (inode_is_excl_inuse(stack[i].dentry)) {
>                         err = ovl_report_in_use(ofs, "lowerdir");
>                         if (err) {
>                                 iput(trap);
> @@ -1872,7 +1872,7 @@ static int ovl_check_layer(struct super_block *sb, struct ovl_fs *ofs,
>                 if (is_lower && ovl_lookup_trap_inode(sb, parent)) {
>                         err = -ELOOP;
>                         pr_err("overlapping %s path\n", name);
> -               } else if (ovl_is_inuse(parent)) {
> +               } else if (inode_is_excl_inuse(parent)) {
>                         err = ovl_report_in_use(ofs, name);
>                 }
>                 next = parent;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index f48284a2a896..748c4b22deb3 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -724,49 +724,6 @@ int ovl_set_protattr(struct inode *inode, struct dentry *upper,
>         return 0;
>  }
>
> -/**
> - * Caller must hold a reference to inode to prevent it from being freed while
> - * it is marked inuse.
> - */
> -bool ovl_inuse_trylock(struct dentry *dentry)
> -{
> -       struct inode *inode = d_inode(dentry);
> -       bool locked = false;
> -
> -       spin_lock(&inode->i_lock);
> -       if (!(inode->i_state & I_OVL_INUSE)) {
> -               inode->i_state |= I_OVL_INUSE;
> -               locked = true;
> -       }
> -       spin_unlock(&inode->i_lock);
> -
> -       return locked;
> -}
> -
> -void ovl_inuse_unlock(struct dentry *dentry)
> -{
> -       if (dentry) {
> -               struct inode *inode = d_inode(dentry);
> -
> -               spin_lock(&inode->i_lock);
> -               WARN_ON(!(inode->i_state & I_OVL_INUSE));
> -               inode->i_state &= ~I_OVL_INUSE;
> -               spin_unlock(&inode->i_lock);
> -       }
> -}
> -
> -bool ovl_is_inuse(struct dentry *dentry)
> -{
> -       struct inode *inode = d_inode(dentry);
> -       bool inuse;
> -
> -       spin_lock(&inode->i_lock);
> -       inuse = (inode->i_state & I_OVL_INUSE);
> -       spin_unlock(&inode->i_lock);
> -
> -       return inuse;
> -}

Please leave ovl_* as wrappers instead of changing super.c.

Thanks,
Amir.
