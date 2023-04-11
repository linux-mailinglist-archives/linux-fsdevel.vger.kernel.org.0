Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C66DE197
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDKQy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjDKQyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B9B198A;
        Tue, 11 Apr 2023 09:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F80F62938;
        Tue, 11 Apr 2023 16:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985E2C4339B;
        Tue, 11 Apr 2023 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232082;
        bh=fW1rYgMZwfdGRxE8jEzrjUzX0hYRpeAu6E/zcoE+v+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P/PveCrZEHw7aiHHFRIXUvvmBhYFw42B0lSaEtwGOaPs5Caj7A+Cg5mMoBK3pGsNR
         k5oyMsgRzPrcs2hhSdi8DigNFsxWDPP0AhwN1KOLQuTGtloYI1sbT5tUd7ocAhbgqZ
         nLZw4eGdMPCfsHK7H94FUzYzVmxRXtduyY7g3qSJeSX6AQf1a5duX3Cdo2PM1hRVIP
         fmwAYb3qXPHSO0kqdOa5SWtXrS+nbfBHPQ2KjD+4Xv0yNNQRVW4cXagF+Cu9+hjyDl
         3ovS9M6Tq/oHuPbeDAzyfJCzOrPYajoD9/BSHFtPp8FtVs935ZmsZXe21PLsh1yFnN
         qIQqz0gTTeR7A==
Received: by mail-qt1-f169.google.com with SMTP id ge18so5297297qtb.0;
        Tue, 11 Apr 2023 09:54:42 -0700 (PDT)
X-Gm-Message-State: AAQBX9dpFre8G224QPwo51jyhxqnVtf5YiDoa9lL4nlWPb+xYH7M8nRg
        YKxdakTwLJeESm81ddcp1favEgICfz7nPXtnI+I=
X-Google-Smtp-Source: AKy350ZSsU8/qQ59JG7Xa6ToXE8s41N3elJr940XfdoklSnPn4GftdUXy54ZRrkbLckxifm6hcjQI10bPreJWYKd4Mg=
X-Received: by 2002:a05:622a:1e92:b0:3e6:9579:2539 with SMTP id
 bz18-20020a05622a1e9200b003e695792539mr2840455qtb.3.1681232081682; Tue, 11
 Apr 2023 09:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
In-Reply-To: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 11 Apr 2023 12:54:25 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkZr4qC9dgxsUxUqsLVKhosmn59BoKig4o5oPT_jBUodg@mail.gmail.com>
Message-ID: <CAFX2JfkZr4qC9dgxsUxUqsLVKhosmn59BoKig4o5oPT_jBUodg@mail.gmail.com>
Subject: Re: [PATCH v2] nfs: use vfs setgid helper
To:     Christian Brauner <brauner@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Tue, Mar 14, 2023 at 7:51=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> We've aligned setgid behavior over multiple kernel releases. The details
> can be found in the following two merge messages:
> cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2')
> 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0')
> Consistent setgid stripping behavior is now encapsulated in the
> setattr_should_drop_sgid() helper which is used by all filesystems that
> strip setgid bits outside of vfs proper. Switch nfs to rely on this
> helper as well. Without this patch the setgid stripping tests in
> xfstests will fail.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> Changes in v2:
> - Christoph Hellwig <hch@lst.de>:
>   * Export setattr_should_sgid() so it actually can be used by filesystem=
s
> - Link to v1: https://lore.kernel.org/r/20230313-fs-nfs-setgid-v1-1-5b1fa=
599f186@kernel.org
> ---
>  fs/attr.c          | 1 +
>  fs/internal.h      | 2 --
>  fs/nfs/inode.c     | 4 +---
>  include/linux/fs.h | 2 ++
>  4 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index aca9ff7aed33..d60dc1edb526 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -47,6 +47,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
>                 return ATTR_KILL_SGID;
>         return 0;
>  }
> +EXPORT_SYMBOL(setattr_should_drop_sgid);
>
>  /**
>   * setattr_should_drop_suidgid - determine whether the set{g,u}id bit ne=
eds to
> diff --git a/fs/internal.h b/fs/internal.h
> index dc4eb91a577a..ab36ed8fa41c 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -259,8 +259,6 @@ ssize_t __kernel_write_iter(struct file *file, struct=
 iov_iter *from, loff_t *po
>  /*
>   * fs/attr.c
>   */
> -int setattr_should_drop_sgid(struct mnt_idmap *idmap,
> -                            const struct inode *inode);
>  struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
>  struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
>  void mnt_idmap_put(struct mnt_idmap *idmap);
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 222a28320e1c..97a76706fd54 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -717,9 +717,7 @@ void nfs_setattr_update_inode(struct inode *inode, st=
ruct iattr *attr,
>                 if ((attr->ia_valid & ATTR_KILL_SUID) !=3D 0 &&
>                     inode->i_mode & S_ISUID)
>                         inode->i_mode &=3D ~S_ISUID;
> -               if ((attr->ia_valid & ATTR_KILL_SGID) !=3D 0 &&
> -                   (inode->i_mode & (S_ISGID | S_IXGRP)) =3D=3D
> -                    (S_ISGID | S_IXGRP))
> +               if (setattr_should_drop_sgid(&nop_mnt_idmap, inode))
>                         inode->i_mode &=3D ~S_ISGID;
>                 if ((attr->ia_valid & ATTR_MODE) !=3D 0) {
>                         int mode =3D attr->ia_mode & S_IALLUGO;

Will this be going through your tree (due to the VFS leve changes)?
If so, you can add:

Acked-by: Anna Schumaker <anna.schumaker@netapp.com>

for the NFS bits.

Thanks,
Anna

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..af95b64fc810 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2675,6 +2675,8 @@ extern struct inode *new_inode(struct super_block *=
sb);
>  extern void free_inode_nonrcu(struct inode *inode);
>  extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode =
*);
>  extern int file_remove_privs(struct file *);
> +int setattr_should_drop_sgid(struct mnt_idmap *idmap,
> +                            const struct inode *inode);
>
>  /*
>   * This must be used for allocating filesystems specific inodes to set
>
> ---
> base-commit: eeac8ede17557680855031c6f305ece2378af326
> change-id: 20230313-fs-nfs-setgid-659410a10b25
>
