Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6109F3973F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhFANUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 09:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhFANUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:20:51 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B229C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 06:19:08 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id s14so5056911vsk.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vG9XhD9yPILV9Qp7pU9v5y+PXRxebG5XrL79GQd10ds=;
        b=neTIcs2KViMm4PAkTdmxpRRJPGBIVB2P4CHkfj09jaZmc1cNfB/2QmyFtmvoW7bYQy
         GtvP361YVlji7lbMB2azJaAw2gzsb/VFEPoJEkBlkfCk4SK0uTG+rMKP64goXu5R4rmz
         tzKEkH0HmGAHRz7TThyTiMeMYADAWjvD2GDi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vG9XhD9yPILV9Qp7pU9v5y+PXRxebG5XrL79GQd10ds=;
        b=W2QL4BzZcj10xeCJ+khaH4wpDD5SqMh664b69ivAnsV8OeFPUEJ9N9F3xyNgIfLbGi
         7Tr5sZGgTJz7MKYsIJSRGqIgjKdCW+78Qr5ftdsgtmuLCtK9HQdFDkVqWNNCUOj3Ckmk
         KAMvONm+GwIsSVkgsi5SqskldtVgsOyXwK0TN1G8XXWXPcqD8fZqHxVL/a0VcA4D5cnr
         2A0je/S+Bwq7ix0AJgmOOIlmk081V1Ke/e1ZEMZ+IKV1vXFSJA1NJJ2dvfdO/KnjOR6g
         uMtiOe/E8PwJ7PV83erfKaDsfrtVavWF3TMAjCEOZNl7QPJWKZ+F2YlkCEh8tRMJzqYP
         I+2g==
X-Gm-Message-State: AOAM533A7BPb+7nM5Ea0dNqQGvQEvZe27xUZ+ETBPpPBlWmsMVZ2uK/L
        376044SNMay+QWD25y9v3pl3sN40eLKVDBYF4O7Q/A==
X-Google-Smtp-Source: ABdhPJxjmup0Pyq9xuCSMQbidyEK5x0ytyC4tnXrH70thXtlATobCKr/Au/GM/YPozoWlqxFsY73VBD2sR2OJ0RLFLA=
X-Received: by 2002:a05:6102:b06:: with SMTP id b6mr18171215vst.21.1622553545662;
 Tue, 01 Jun 2021 06:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
 <162218366632.34379.11311748209082333016.stgit@web.messagingengine.com>
In-Reply-To: <162218366632.34379.11311748209082333016.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Jun 2021 15:18:54 +0200
Message-ID: <CAJfpegshedor_ZiQ_8EdLGRG0AEWb5Sy5Pa4SwPg9+f196_mGg@mail.gmail.com>
Subject: Re: [REPOST PATCH v4 4/5] kernfs: use i_lock to protect concurrent
 inode updates
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net> wrote:
>
> The inode operations .permission() and .getattr() use the kernfs node
> write lock but all that's needed is to keep the rb tree stable while
> updating the inode attributes as well as protecting the update itself
> against concurrent changes.
>
> And .permission() is called frequently during path walks and can cause
> quite a bit of contention between kernfs node operations and path
> walks when the number of concurrent walks is high.
>
> To change kernfs_iop_getattr() and kernfs_iop_permission() to take
> the rw sem read lock instead of the write lock an additional lock is
> needed to protect against multiple processes concurrently updating
> the inode attributes and link count in kernfs_refresh_inode().
>
> The inode i_lock seems like the sensible thing to use to protect these
> inode attribute updates so use it in kernfs_refresh_inode().
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/inode.c |   10 ++++++----
>  fs/kernfs/mount.c |    4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 3b01e9e61f14e..6728ecd81eb37 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -172,6 +172,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
>  {
>         struct kernfs_iattrs *attrs = kn->iattr;
>
> +       spin_lock(&inode->i_lock);
>         inode->i_mode = kn->mode;
>         if (attrs)
>                 /*
> @@ -182,6 +183,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
>
>         if (kernfs_type(kn) == KERNFS_DIR)
>                 set_nlink(inode, kn->dir.subdirs + 2);
> +       spin_unlock(&inode->i_lock);
>  }
>
>  int kernfs_iop_getattr(struct user_namespace *mnt_userns,
> @@ -191,9 +193,9 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
>         struct inode *inode = d_inode(path->dentry);
>         struct kernfs_node *kn = inode->i_private;
>
> -       down_write(&kernfs_rwsem);
> +       down_read(&kernfs_rwsem);
>         kernfs_refresh_inode(kn, inode);
> -       up_write(&kernfs_rwsem);
> +       up_read(&kernfs_rwsem);
>
>         generic_fillattr(&init_user_ns, inode, stat);
>         return 0;
> @@ -284,9 +286,9 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
>
>         kn = inode->i_private;
>
> -       down_write(&kernfs_rwsem);
> +       down_read(&kernfs_rwsem);
>         kernfs_refresh_inode(kn, inode);
> -       up_write(&kernfs_rwsem);
> +       up_read(&kernfs_rwsem);
>
>         return generic_permission(&init_user_ns, inode, mask);
>  }
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index baa4155ba2edf..f2f909d09f522 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -255,9 +255,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
>         sb->s_shrink.seeks = 0;
>
>         /* get root inode, initialize and unlock it */
> -       down_write(&kernfs_rwsem);
> +       down_read(&kernfs_rwsem);
>         inode = kernfs_get_inode(sb, info->root->kn);
> -       up_write(&kernfs_rwsem);
> +       up_read(&kernfs_rwsem);
>         if (!inode) {
>                 pr_debug("kernfs: could not get root inode\n");
>                 return -ENOMEM;
>

This last hunk is not mentioned in the patch header.  Why is this needed?

Otherwise looks good.

Thanks,
Miklos
