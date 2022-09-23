Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A615E7E16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIWPS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWPS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:18:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A1139F73
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:18:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e18so690101edj.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eMjuix+L9lp+VBbvQ7BEp2UQNnNAkzh8oHeOUceM7CI=;
        b=DdBvuiPcKmrT0wUSQyyZA4LooRGFjcKzR2mMzlf++igUtdqJ/oQ5yECmqaUcmfRGOr
         jfZz19CicDzxgk4XaqIq9RRmaXPnMYdIY5GH1fxPOoKuuTuVLtxLZtZWp2LCwzDNCerc
         FOB5bSQoRk/H5vkafweuSxsdgkxFs4nC9PDUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eMjuix+L9lp+VBbvQ7BEp2UQNnNAkzh8oHeOUceM7CI=;
        b=OZa4lRrVtureji2HNdSi7qGNdUYLi/xI8ZUqOI10tf5sNaE7PI1smZAODZWQsBnwYv
         BDA2l0pUBtyaTYxDLnpE16QPJfN2/wmGBg52ewEuvzZRyW/i46VgxrJ9Job25mUolEBV
         vmubi2najNgWRst93zJslmW+hWw/8fCGFef6kJ1gnbW81STaUCeG/w4IXR7dL9JnR2tt
         44VCY/hHnY1NmW6mc3tn2/lV8AMY2xc6c70CniErWsjSjPhAFIRaeg3/AlbxnGYHNkx1
         BIJrk9hSVC42JBy9qsd9ADV5c6o2d2r8psX6zcpfG60ku68sRc8sK+NjxLVMA22bCMnd
         OeCA==
X-Gm-Message-State: ACrzQf3vVe5HnMGL0ZHNmL4vuy4eLzckKfs/NCnJwRyik0JPw4B11h2U
        BPYqcxkXZaPqjD3ll7wFuZIbsD+dhHx2JTHj7RnLcQ==
X-Google-Smtp-Source: AMsMyM4ejcdj8JeaEjlfgLk0GZet0WGoCM2prpblQ/SJKV5CAyd0xMBH/TaxLgg4uteBKCZJughA84eNdgXw8nCS/Xc=
X-Received: by 2002:a05:6402:7c7:b0:456:d6fe:d803 with SMTP id
 u7-20020a05640207c700b00456d6fed803mr1975785edy.270.1663946333270; Fri, 23
 Sep 2022 08:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-23-brauner@kernel.org>
In-Reply-To: <20220922151728.1557914-23-brauner@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 23 Sep 2022 17:18:42 +0200
Message-ID: <CAJfpegstf+gUMm0iqrMSSzXKY6f8-U3vHK+hp+O7UuVR7oYCGA@mail.gmail.com>
Subject: Re: [PATCH 22/29] ovl: implement set acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 22 Sept 2022 at 17:18, Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> In order to build a type safe posix api around get and set acl we need
> all filesystem to implement get and set acl.
>
> Now that we have added get and set acl inode operations that allow easy
> access to the dentry we give overlayfs it's own get and set acl inode
> operations.
>
> The set acl inode operation is duplicates most of the ovl posix acl
> xattr handler. The main difference being that the set acl inode
> operation relies on the new posix acl api. Once the vfs has been
> switched over the custom posix acl xattr handler will be removed
> completely.
>
> Note, until the vfs has been switched to the new posix acl api this
> patch is a non-functional change.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  fs/overlayfs/dir.c       |  1 +
>  fs/overlayfs/inode.c     | 81 ++++++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/overlayfs.h | 17 +++++++++
>  3 files changed, 99 insertions(+)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index eb49d5d7b56f..0e817ebce92c 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1313,6 +1313,7 @@ const struct inode_operations ovl_dir_inode_operations = {
>         .listxattr      = ovl_listxattr,
>         .get_inode_acl  = ovl_get_inode_acl,
>         .get_acl        = ovl_get_acl,
> +       .set_acl        = ovl_set_acl,
>         .update_time    = ovl_update_time,
>         .fileattr_get   = ovl_fileattr_get,
>         .fileattr_set   = ovl_fileattr_set,
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index dd11e13cd288..b0a19f9deaf1 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -596,6 +596,85 @@ struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
>         revert_creds(old_cred);
>         return acl;
>  }
> +
> +int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> +               struct posix_acl *acl, int type)
> +{
> +       int err;
> +       struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
> +       struct inode *inode = d_inode(dentry);
> +       struct dentry *upperdentry = ovl_dentry_upper(dentry);
> +       struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
> +       struct dentry *workdir = ovl_workdir(dentry);
> +       struct inode *realinode = ovl_inode_real(inode);
> +       struct path realpath;
> +       const struct cred *old_cred;
> +       const char *acl_name;
> +
> +       if (!IS_POSIXACL(d_inode(workdir)))
> +               return -EOPNOTSUPP;
> +       if (!realinode->i_op->set_acl)
> +               return -EOPNOTSUPP;
> +       if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
> +               return acl ? -EACCES : 0;
> +       if (!inode_owner_or_capable(&init_user_ns, inode))
> +               return -EPERM;
> +
> +       /*
> +        * Check if sgid bit needs to be cleared (actual setacl operation will
> +        * be done with mounter's capabilities and so that won't do it for us).
> +        */
> +       if (unlikely(inode->i_mode & S_ISGID) && type == ACL_TYPE_ACCESS &&
> +           !in_group_p(inode->i_gid) &&
> +           !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
> +               struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
> +
> +               err = ovl_setattr(&init_user_ns, dentry, &iattr);
> +               if (err)
> +                       return err;
> +       }
> +

I'd split this function up here (same as was done in the original
xattr based one).

> +       err = ovl_want_write(dentry);
> +       if (err)
> +               goto out;
> +
> +       acl_name = posix_acl_xattr_name(type);

My bad, but this really deserves a comment:  /* If ACL is to be
removed from a lower file, check if it exists in the first place
before copying it up */

> +       if (!acl && !upperdentry) {
> +               struct posix_acl *real_acl;
> +
> +               ovl_path_lower(dentry, &realpath);
> +               old_cred = ovl_override_creds(dentry->d_sb);
> +               real_acl = vfs_get_acl(mnt_user_ns(realpath.mnt), realdentry,
> +                                      posix_acl_xattr_name(type));
> +               revert_creds(old_cred);
> +               posix_acl_release(real_acl);
> +               if (IS_ERR(real_acl))
> +                       goto out_drop_write;
> +       }
> +
> +       if (!upperdentry) {
> +               err = ovl_copy_up(dentry);
> +               if (err)
> +                       goto out_drop_write;
> +
> +               realdentry = ovl_dentry_upper(dentry);
> +       }
> +
> +       old_cred = ovl_override_creds(dentry->d_sb);
> +       if (acl)
> +               err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
> +       else
> +               err = ovl_do_remove_acl(ofs, realdentry, acl_name);
> +       revert_creds(old_cred);
> +
> +       /* copy c/mtime */
> +       ovl_copyattr(inode);
> +
> +out_drop_write:
> +       ovl_drop_write(dentry);
> +out:
> +       return err;
> +}
>  #endif
>
>  int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
> @@ -772,6 +851,7 @@ static const struct inode_operations ovl_file_inode_operations = {
>         .listxattr      = ovl_listxattr,
>         .get_inode_acl  = ovl_get_inode_acl,
>         .get_acl        = ovl_get_acl,
> +       .set_acl        = ovl_set_acl,
>         .update_time    = ovl_update_time,
>         .fiemap         = ovl_fiemap,
>         .fileattr_get   = ovl_fileattr_get,
> @@ -793,6 +873,7 @@ static const struct inode_operations ovl_special_inode_operations = {
>         .listxattr      = ovl_listxattr,
>         .get_inode_acl  = ovl_get_inode_acl,
>         .get_acl        = ovl_get_acl,
> +       .set_acl        = ovl_set_acl,
>         .update_time    = ovl_update_time,
>  };
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 68a3030332e9..b2645baeba2f 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -8,6 +8,8 @@
>  #include <linux/uuid.h>
>  #include <linux/fs.h>
>  #include <linux/namei.h>
> +#include <linux/posix_acl.h>
> +#include <linux/posix_acl_xattr.h>
>  #include "ovl_entry.h"
>
>  #undef pr_fmt
> @@ -278,6 +280,18 @@ static inline int ovl_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
>         return ovl_do_removexattr(ofs, dentry, ovl_xattr(ofs, ox));
>  }
>
> +static inline int ovl_do_set_acl(struct ovl_fs *ofs, struct dentry *dentry,
> +                                const char *acl_name, struct posix_acl *acl)
> +{
> +       return vfs_set_acl(ovl_upper_mnt_userns(ofs), dentry, acl_name, acl);
> +}
> +
> +static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
> +                                   const char *acl_name)
> +{
> +       return vfs_remove_acl(ovl_upper_mnt_userns(ofs), dentry, acl_name);
> +}
> +
>  static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
>                                 struct dentry *olddentry, struct inode *newdir,
>                                 struct dentry *newdentry, unsigned int flags)
> @@ -595,12 +609,15 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
>  struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type, bool rcu);
>  struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
>                               struct dentry *dentry, int type);
> +int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> +               struct posix_acl *acl, int type);
>  void ovl_idmap_posix_acl(struct inode *realinode,
>                          struct user_namespace *mnt_userns,
>                          struct posix_acl *acl);
>  #else
>  #define ovl_get_inode_acl      NULL
>  #define ovl_get_acl            NULL
> +#define ovl_set_acl            NULL
>  #endif
>
>  int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
> --
> 2.34.1
>
