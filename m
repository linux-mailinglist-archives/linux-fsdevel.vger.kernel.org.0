Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8786263BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 22:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiKKVin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 16:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiKKVim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:38:42 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC48A64DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 13:38:37 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-369426664f9so54886977b3.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 13:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LGSQvOyjxEbHfvs7/+rm9ZoadlxwEhGcHixDz68WVU=;
        b=KOeHQBS0cx+ox8JFCcFPoTrF6vPSGcqtOIcNToJ7DHsqZdHv3oMVu8ija6MEiVNO2x
         S0lXefdpUCeknCiFvGIknm2vZ+NPBUus+2GE1d39xoHpto3ldXhHp75clr3OuXDWZk31
         na5fhwVzJAI7tUbIWkmtLR3RXCXBQuR9o+Hznsamzi5jfSbbndpq+Np68jjodnF4PgBY
         eV1PNUBR7s3be3V5qhssyJs3bWGiLUgetRZEKOn8G6AP32zFZZYEbqnviSK/qhEHULwM
         nQyyj4/5PKeljlfixtVNXQfrB6T47Ze+5Hh1IHGpKqY0R+ZFkTq0dcweI+aPBtX0kwW0
         tuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LGSQvOyjxEbHfvs7/+rm9ZoadlxwEhGcHixDz68WVU=;
        b=5OzhurRQg4kd2DRTUnVtvWhMt4aG1mWjUsHGUiTVtcBrjtBDTE+PC1/2DiHNj8Yo1a
         sSL8mvs2o8dwJtHOVyDI/I7YBY7HPoY0kgG36+NKGExjKZ4cDWs9BMrbzL5rkc+P30pX
         9BK3WfllByktk/G/razd4FKVlA3t0si7y8IKmnIqGW0mKKJ1GEE4MUn4o/BW6H5P7lO1
         Vvp2PJZsLLqAh6SxzuNirq79w+XuVLLR2scyl94kROeq5wh9xOl5Nm790kCn7H3DzgxU
         cruqiGdznXVk3FWNrkhCbMhnOhbhOIPi8m4KUbuMw44T5eGYt9lfRuzZh3ma3kpoQ1oD
         M6Mg==
X-Gm-Message-State: ANoB5pmlzIFy+w08VUj7jj1SXR0lyXJZ1awL7HXy3GoPZpzuyVBKOu66
        ggWgahtgCDXRo2VYFgG8VA494GqdGad7GpyQL22ngZ41JIn/qA==
X-Google-Smtp-Source: AA0mqf69hPv0UgCQc19aqaDDb8WzNPce5bq5C8HQFvL8F6rW8ylCLBckDMl/OFRwSmgq56Gxx9QOP10T/rppCkkejvE=
X-Received: by 2002:a0d:fb86:0:b0:354:df4f:ac11 with SMTP id
 l128-20020a0dfb86000000b00354df4fac11mr3783251ywf.415.1668202717048; Fri, 11
 Nov 2022 13:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20221018115700.166010-1-brauner@kernel.org> <20221018115700.166010-2-brauner@kernel.org>
In-Reply-To: <20221018115700.166010-2-brauner@kernel.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 11 Nov 2022 16:38:26 -0500
Message-ID: <CAOg9mSSq_yV=q5J6sEh8qHWwLe_wYwwsb1rTEh11k52D2nm11g@mail.gmail.com>
Subject: Re: [PATCH v5 01/30] orangefs: rework posix acl handling when
 creating new filesystem objects
To:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello... I have applied your v5 patch series to 6.1-rc2. I get
numerous acl related xfstests failures with your patch.

generic/105 is the first one that fails, so I got started dee-ciphering
what it does.

I hoped I could find what it is in the patch that causes the
regression, but I have not yet, and we're already up to rc4.

I have a sequence of events that is part of generic/105 where
I believe "the bad thing" happens, I thought I'd show you, you
might know right away what is wrong...

6.1-rc2 without the patch series:
root@vm1 ~]# cd /scratch
[root@vm1 scratch]# mkdir -m 600 subdir
[root@vm1 scratch]# chown 13 subdir
[root@vm1 scratch]# echo data > subdir/file
[root@vm1 scratch]# ls -l subdir/file | awk '{ print $1, $3 }'
-rw-r--r--. root

6.1-rc2 with the patch series:
[root@vm1 hubcap]# cd /scratch
[root@vm1 scratch]#  mkdir -m 600 subdir
[root@vm1 scratch]# chown 13 subdir
[root@vm1 scratch]# echo data > subdir/file
[root@vm1 scratch]# ls -l subdir/file | awk '{ print $1, $3 }'
-rw-rw-rw-. root

The commit message for the orangefs part of the patch
says "calculate the correct mode directly before
actually creating the inode."

Anywho... I'll keep looking...

-Mike



On Tue, Oct 18, 2022 at 7:57 AM Christian Brauner <brauner@kernel.org> wrote:
>
> When creating new filesytem objects orangefs used to create posix acls
> after it had created and inserted a new inode. This made it necessary to
> all posix_acl_chmod() on the newly created inode in case the mode of the
> inode would be changed by the posix acls.
>
> Instead of doing it this way calculate the correct mode directly before
> actually creating the inode. So we first create posix acls, then pass
> the mode that posix acls mandate into the orangefs getattr helper and
> calculate the correct mode. This is needed so we can simply change
> posix_acl_chmod() to take a dentry instead of an inode argument in the
> next patch.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     Christoph Hellwig <hch@lst.de>:
>     - Add separate patch for orangefs rework.
>
>     /* v3 */
>     unchanged
>
>     /* v4 */
>     Christoph Hellwig <hch@lst.de>:
>     - drop extern from function declaration
>
>     /* v5 */
>     unchanged
>
>  fs/orangefs/acl.c             | 44 ++---------------------------------
>  fs/orangefs/inode.c           | 44 ++++++++++++++++++++++++++++-------
>  fs/orangefs/orangefs-kernel.h |  6 +++--
>  fs/orangefs/orangefs-utils.c  | 10 ++++++--
>  4 files changed, 50 insertions(+), 54 deletions(-)
>
> diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
> index 605e5a3506ec..0e2db840c217 100644
> --- a/fs/orangefs/acl.c
> +++ b/fs/orangefs/acl.c
> @@ -64,8 +64,7 @@ struct posix_acl *orangefs_get_acl(struct inode *inode, int type, bool rcu)
>         return acl;
>  }
>
> -static int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl,
> -                             int type)
> +int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>  {
>         int error = 0;
>         void *value = NULL;
> @@ -153,46 +152,7 @@ int orangefs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>         rc = __orangefs_set_acl(inode, acl, type);
>
>         if (!rc && (iattr.ia_valid == ATTR_MODE))
> -               rc = __orangefs_setattr(inode, &iattr);
> +               rc = __orangefs_setattr_mode(inode, &iattr);
>
>         return rc;
>  }
> -
> -int orangefs_init_acl(struct inode *inode, struct inode *dir)
> -{
> -       struct posix_acl *default_acl, *acl;
> -       umode_t mode = inode->i_mode;
> -       struct iattr iattr;
> -       int error = 0;
> -
> -       error = posix_acl_create(dir, &mode, &default_acl, &acl);
> -       if (error)
> -               return error;
> -
> -       if (default_acl) {
> -               error = __orangefs_set_acl(inode, default_acl,
> -                                          ACL_TYPE_DEFAULT);
> -               posix_acl_release(default_acl);
> -       } else {
> -               inode->i_default_acl = NULL;
> -       }
> -
> -       if (acl) {
> -               if (!error)
> -                       error = __orangefs_set_acl(inode, acl, ACL_TYPE_ACCESS);
> -               posix_acl_release(acl);
> -       } else {
> -               inode->i_acl = NULL;
> -       }
> -
> -       /* If mode of the inode was changed, then do a forcible ->setattr */
> -       if (mode != inode->i_mode) {
> -               memset(&iattr, 0, sizeof iattr);
> -               inode->i_mode = mode;
> -               iattr.ia_mode = mode;
> -               iattr.ia_valid |= ATTR_MODE;
> -               __orangefs_setattr(inode, &iattr);
> -       }
> -
> -       return error;
> -}
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 7a8c0c6e698d..35788cde6d24 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -828,15 +828,22 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
>         spin_unlock(&inode->i_lock);
>         mark_inode_dirty(inode);
>
> -       if (iattr->ia_valid & ATTR_MODE)
> -               /* change mod on a file that has ACLs */
> -               ret = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
> -
>         ret = 0;
>  out:
>         return ret;
>  }
>
> +int __orangefs_setattr_mode(struct inode *inode, struct iattr *iattr)
> +{
> +       int ret;
> +
> +       ret = __orangefs_setattr(inode, iattr);
> +       /* change mode on a file that has ACLs */
> +       if (!ret && (iattr->ia_valid & ATTR_MODE))
> +               ret = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
> +       return ret;
> +}
> +
>  /*
>   * Change attributes of an object referenced by dentry.
>   */
> @@ -849,7 +856,7 @@ int orangefs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>         ret = setattr_prepare(&init_user_ns, dentry, iattr);
>         if (ret)
>                 goto out;
> -       ret = __orangefs_setattr(d_inode(dentry), iattr);
> +       ret = __orangefs_setattr_mode(d_inode(dentry), iattr);
>         sync_inode_metadata(d_inode(dentry), 1);
>  out:
>         gossip_debug(GOSSIP_INODE_DEBUG, "orangefs_setattr: returning %d\n",
> @@ -1097,8 +1104,9 @@ struct inode *orangefs_iget(struct super_block *sb,
>   * Allocate an inode for a newly created file and insert it into the inode hash.
>   */
>  struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
> -               int mode, dev_t dev, struct orangefs_object_kref *ref)
> +               umode_t mode, dev_t dev, struct orangefs_object_kref *ref)
>  {
> +       struct posix_acl *acl = NULL, *default_acl = NULL;
>         unsigned long hash = orangefs_handle_hash(ref);
>         struct inode *inode;
>         int error;
> @@ -1115,16 +1123,33 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
>         if (!inode)
>                 return ERR_PTR(-ENOMEM);
>
> +       error = posix_acl_create(dir, &mode, &default_acl, &acl);
> +       if (error)
> +               goto out_iput;
> +
>         orangefs_set_inode(inode, ref);
>         inode->i_ino = hash;    /* needed for stat etc */
>
> -       error = orangefs_inode_getattr(inode, ORANGEFS_GETATTR_NEW);
> +       error = __orangefs_inode_getattr(inode, mode, ORANGEFS_GETATTR_NEW);
>         if (error)
>                 goto out_iput;
>
>         orangefs_init_iops(inode);
>         inode->i_rdev = dev;
>
> +       if (default_acl) {
> +               error = __orangefs_set_acl(inode, default_acl,
> +                                          ACL_TYPE_DEFAULT);
> +               if (error)
> +                       goto out_iput;
> +       }
> +
> +       if (acl) {
> +               error = __orangefs_set_acl(inode, acl, ACL_TYPE_ACCESS);
> +               if (error)
> +                       goto out_iput;
> +       }
> +
>         error = insert_inode_locked4(inode, hash, orangefs_test_inode, ref);
>         if (error < 0)
>                 goto out_iput;
> @@ -1132,10 +1157,13 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
>         gossip_debug(GOSSIP_INODE_DEBUG,
>                      "Initializing ACL's for inode %pU\n",
>                      get_khandle_from_ino(inode));
> -       orangefs_init_acl(inode, dir);
> +       posix_acl_release(acl);
> +       posix_acl_release(default_acl);
>         return inode;
>
>  out_iput:
>         iput(inode);
> +       posix_acl_release(acl);
> +       posix_acl_release(default_acl);
>         return ERR_PTR(error);
>  }
> diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
> index b5940ec1836a..3298b15684b7 100644
> --- a/fs/orangefs/orangefs-kernel.h
> +++ b/fs/orangefs/orangefs-kernel.h
> @@ -103,13 +103,13 @@ enum orangefs_vfs_op_states {
>  #define ORANGEFS_CACHE_CREATE_FLAGS 0
>  #endif
>
> -extern int orangefs_init_acl(struct inode *inode, struct inode *dir);
>  extern const struct xattr_handler *orangefs_xattr_handlers[];
>
>  extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type, bool rcu);
>  extern int orangefs_set_acl(struct user_namespace *mnt_userns,
>                             struct inode *inode, struct posix_acl *acl,
>                             int type);
> +int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
>
>  /*
>   * orangefs data structures
> @@ -356,11 +356,12 @@ void fsid_key_table_finalize(void);
>  vm_fault_t orangefs_page_mkwrite(struct vm_fault *);
>  struct inode *orangefs_new_inode(struct super_block *sb,
>                               struct inode *dir,
> -                             int mode,
> +                             umode_t mode,
>                               dev_t dev,
>                               struct orangefs_object_kref *ref);
>
>  int __orangefs_setattr(struct inode *, struct iattr *);
> +int __orangefs_setattr_mode(struct inode *inode, struct iattr *iattr);
>  int orangefs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
>
>  int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
> @@ -422,6 +423,7 @@ int orangefs_inode_setxattr(struct inode *inode,
>  #define ORANGEFS_GETATTR_SIZE 2
>
>  int orangefs_inode_getattr(struct inode *, int);
> +int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags);
>
>  int orangefs_inode_check_changed(struct inode *inode);
>
> diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
> index 46b7dcff18ac..334a2fd98c37 100644
> --- a/fs/orangefs/orangefs-utils.c
> +++ b/fs/orangefs/orangefs-utils.c
> @@ -233,7 +233,7 @@ static int orangefs_inode_is_stale(struct inode *inode,
>         return 0;
>  }
>
> -int orangefs_inode_getattr(struct inode *inode, int flags)
> +int __orangefs_inode_getattr(struct inode *inode, umode_t mode, int flags)
>  {
>         struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
>         struct orangefs_kernel_op_s *new_op;
> @@ -369,7 +369,8 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
>
>         /* special case: mark the root inode as sticky */
>         inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) |
> -           orangefs_inode_perms(&new_op->downcall.resp.getattr.attributes);
> +           orangefs_inode_perms(&new_op->downcall.resp.getattr.attributes) |
> +           mode;
>
>         orangefs_inode->getattr_time = jiffies +
>             orangefs_getattr_timeout_msecs*HZ/1000;
> @@ -381,6 +382,11 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
>         return ret;
>  }
>
> +int orangefs_inode_getattr(struct inode *inode, int flags)
> +{
> +       return __orangefs_inode_getattr(inode, 0, flags);
> +}
> +
>  int orangefs_inode_check_changed(struct inode *inode)
>  {
>         struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
> --
> 2.34.1
>
