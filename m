Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376417B53F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjJBNWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 09:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjJBNWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:22:40 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9F9AD;
        Mon,  2 Oct 2023 06:22:37 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7ab4c86eeb0so5520783241.2;
        Mon, 02 Oct 2023 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696252956; x=1696857756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVsMtZasrJtEby/cWp2K2MNSFEAPM2DmMjcEMUEk2rg=;
        b=QA+e4iatRG6shuVP6s54Kwzt+/kB3PjlQJI6m51mUFQj0Q5SDGgA6RUFqER82swpzH
         bL5frKvlZCS9EH90amZIAs1dbI6kfsCN1+J5bbMUARr8SvHbYMqwq6gCOJDOV8jRwjvF
         +k05KwzjEsrd34atc+g1r8bZkP2KN6yDACixlrp22Vdbj/2x//XbtYOGxPKWRxvh2H0W
         YnvGAc7OdQBK1maHDWwvnKJxwLvT+IrHwEkTztlqMZq/iHdyGoXkfg5olFKhHtX7FM7e
         kxRwVpAE9tQZAyoDFjK/Y+aMcpWlMC+7GWUI5NzfkJlwlUUhu0Exw9OW2bUTeFU5hzBm
         aVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252956; x=1696857756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVsMtZasrJtEby/cWp2K2MNSFEAPM2DmMjcEMUEk2rg=;
        b=QbMke1rvYPoVZpaCRfN2ls1msoHxYnfVVpmoIo8TGWcThbH4lhhUokr/28fwD7bOWB
         t8DTf5IQmwba2NPjC1iDIeuR1WFE+9r1Az2H7FgxtnkzkvLlvbZD1TxYApeoS3hawzJh
         RsDh5ocJHYGvHYsLeOWxze/EafhOmCJyYetx3foZStZmyjUk5j3VNqqjNYfzi/WfCTRT
         Lse9u/2/DSWY/949EbojMGnhTRe8YQsODBoDVwjGd6zWZpFFiREH8rQeWipSy5cxD+u1
         1o9ma1PVvN71GDfgJUQReBHgT305hd9odyUKFRXsLz6xw13gSSMZ82WouMFQminLI6aw
         udUg==
X-Gm-Message-State: AOJu0Ywnp8ZJdO1RQYFKBYXL5N5xMwtH2VWdvbS2VVN9pMOLoi/VD+Zp
        xqmTduRBRTi/JRM/B3VrnxOJpxzffnsH++DVixg=
X-Google-Smtp-Source: AGHT+IFEgHiwDYxWJCCCP4Dn2vbruH+ZDPDbE2jLy9mehhlbjWAHx6f13KHylzPOKRRvQxlVA1Nd0fOVlOQKS83hLLw=
X-Received: by 2002:a67:e9ca:0:b0:452:6764:4f8e with SMTP id
 q10-20020a67e9ca000000b0045267644f8emr8676333vso.34.1696252956237; Mon, 02
 Oct 2023 06:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Oct 2023 16:22:25 +0300
Message-ID: <CAOQ4uxiuQxTDqn4F62ueGf_9f4KC4p7xqRZdwPvL8rEYrCOWbg@mail.gmail.com>
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface function
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 2, 2023 at 3:57=E2=80=AFPM Stefan Berger <stefanb@linux.vnet.ib=
m.com> wrote:
>
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> When vfs_getattr_nosec() calls a filesystem's getattr interface function
> then the 'nosec' should propagate into this function so that
> vfs_getattr_nosec() can again be called from the filesystem's gettattr
> rather than vfs_getattr(). The latter would add unnecessary security
> checks that the initial vfs_getattr_nosec() call wanted to avoid.
> Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
> with the new getattr_flags parameter to the getattr interface function.
> In overlayfs and ecryptfs use this flag to determine which one of the
> two functions to call.
>
> In a recent code change introduced to IMA vfs_getattr_nosec() ended up
> calling vfs_getattr() in overlayfs, which in turn called
> security_inode_getattr() on an exiting process that did not have
> current->fs set anymore, which then caused a kernel NULL pointer
> dereference. With this change the call to security_inode_getattr() can
> be avoided, thus avoiding the NULL pointer dereference.
>
> Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Tyler Hicks <code@tyhicks.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Co-developed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Now let's see what vfs maintainers think about this...

Thanks,
Amir.

>  fs/ecryptfs/inode.c        | 12 ++++++++++--
>  fs/overlayfs/inode.c       | 10 +++++-----
>  fs/overlayfs/overlayfs.h   |  8 ++++++++
>  fs/stat.c                  |  6 +++++-
>  include/uapi/linux/fcntl.h |  3 +++
>  5 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 992d9c7e64ae..5ab4b87888a7 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -998,6 +998,14 @@ static int ecryptfs_getattr_link(struct mnt_idmap *i=
dmap,
>         return rc;
>  }
>
> +static int ecryptfs_do_getattr(const struct path *path, struct kstat *st=
at,
> +                              u32 request_mask, unsigned int flags)
> +{
> +       if (flags & AT_GETATTR_NOSEC)
> +               return vfs_getattr_nosec(path, stat, request_mask, flags)=
;
> +       return vfs_getattr(path, stat, request_mask, flags);
> +}
> +
>  static int ecryptfs_getattr(struct mnt_idmap *idmap,
>                             const struct path *path, struct kstat *stat,
>                             u32 request_mask, unsigned int flags)
> @@ -1006,8 +1014,8 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap=
,
>         struct kstat lower_stat;
>         int rc;
>
> -       rc =3D vfs_getattr(ecryptfs_dentry_to_lower_path(dentry), &lower_=
stat,
> -                        request_mask, flags);
> +       rc =3D ecryptfs_do_getattr(ecryptfs_dentry_to_lower_path(dentry),
> +                                &lower_stat, request_mask, flags);
>         if (!rc) {
>                 fsstack_copy_attr_all(d_inode(dentry),
>                                       ecryptfs_inode_to_lower(d_inode(den=
try)));
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 83ef66644c21..fca29dba7b14 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -171,7 +171,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
>
>         type =3D ovl_path_real(dentry, &realpath);
>         old_cred =3D ovl_override_creds(dentry->d_sb);
> -       err =3D vfs_getattr(&realpath, stat, request_mask, flags);
> +       err =3D ovl_do_getattr(&realpath, stat, request_mask, flags);
>         if (err)
>                 goto out;
>
> @@ -196,8 +196,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
>                                         (!is_dir ? STATX_NLINK : 0);
>
>                         ovl_path_lower(dentry, &realpath);
> -                       err =3D vfs_getattr(&realpath, &lowerstat,
> -                                         lowermask, flags);
> +                       err =3D ovl_do_getattr(&realpath, &lowerstat, low=
ermask,
> +                                            flags);
>                         if (err)
>                                 goto out;
>
> @@ -249,8 +249,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct=
 path *path,
>
>                         ovl_path_lowerdata(dentry, &realpath);
>                         if (realpath.dentry) {
> -                               err =3D vfs_getattr(&realpath, &lowerdata=
stat,
> -                                                 lowermask, flags);
> +                               err =3D ovl_do_getattr(&realpath, &lowerd=
atastat,
> +                                                    lowermask, flags);
>                                 if (err)
>                                         goto out;
>                         } else {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 9817b2dcb132..09ca82ed0f8c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -397,6 +397,14 @@ static inline bool ovl_open_flags_need_copy_up(int f=
lags)
>         return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
>  }
>
> +static inline int ovl_do_getattr(const struct path *path, struct kstat *=
stat,
> +                                u32 request_mask, unsigned int flags)
> +{
> +       if (flags & AT_GETATTR_NOSEC)
> +               return vfs_getattr_nosec(path, stat, request_mask, flags)=
;
> +       return vfs_getattr(path, stat, request_mask, flags);
> +}
> +
>  /* util.c */
>  int ovl_want_write(struct dentry *dentry);
>  void ovl_drop_write(struct dentry *dentry);
> diff --git a/fs/stat.c b/fs/stat.c
> index d43a5cc1bfa4..5375be5f97cc 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -133,7 +133,8 @@ int vfs_getattr_nosec(const struct path *path, struct=
 kstat *stat,
>         idmap =3D mnt_idmap(path->mnt);
>         if (inode->i_op->getattr)
>                 return inode->i_op->getattr(idmap, path, stat,
> -                                           request_mask, query_flags);
> +                                           request_mask,
> +                                           query_flags | AT_GETATTR_NOSE=
C);
>
>         generic_fillattr(idmap, request_mask, inode, stat);
>         return 0;
> @@ -166,6 +167,9 @@ int vfs_getattr(const struct path *path, struct kstat=
 *stat,
>  {
>         int retval;
>
> +       if (WARN_ON_ONCE(query_flags & AT_GETATTR_NOSEC))
> +               return -EPERM;
> +
>         retval =3D security_inode_getattr(path);
>         if (retval)
>                 return retval;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 6c80f96049bd..282e90aeb163 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -116,5 +116,8 @@
>  #define AT_HANDLE_FID          AT_REMOVEDIR    /* file handle is needed =
to
>                                         compare object identity and may n=
ot
>                                         be usable to open_by_handle_at(2)=
 */
> +#if defined(__KERNEL__)
> +#define AT_GETATTR_NOSEC       0x80000000
> +#endif
>
>  #endif /* _UAPI_LINUX_FCNTL_H */
> --
> 2.40.1
>
