Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABE6DE1F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjDKRLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjDKRLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE71469F;
        Tue, 11 Apr 2023 10:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBB6E629B1;
        Tue, 11 Apr 2023 17:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DBC4339B;
        Tue, 11 Apr 2023 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681233061;
        bh=Z1vS1CZUHcjyBePBOAorksWeXWINj9Fg7ftzrrGoqxU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D0mVuMS2zEpPUjigFlE+EG/i7FtUIzq9DWNMZrbNP02GSjlSx+VrJFn659veZib9A
         Pmghq1klwiischli2dMlSeIv9OCE2CZx3Ko3oQzqtb14e91cPTupLaGRmpQlJubhFm
         kB2g5LdxaWodBIWODzACWRjkUuggJV/FaImRE0szEgFpeC9v44Y2LZEL7yJIeP0/mn
         mu9VeRTtrAfLG8QpXohhbNRoGzERHlwNfon4EFbA8eWo8uW+HnxqAz3dGG5qqaK7DV
         15F7jyBTlSkcjgeH4Bz0C34vVHFDoIaIFgptFqHLqvmLAsaOku76d71SPmLorUwPQT
         m2h8+2C0ItDUw==
Message-ID: <b18204512e016fe986bfbc707201d4ccd50dbf79.camel@kernel.org>
Subject: Re: [PATCH v2] nfs: use vfs setgid helper
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 11 Apr 2023 13:10:59 -0400
In-Reply-To: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
References: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-03-14 at 12:51 +0100, Christian Brauner wrote:
> We've aligned setgid behavior over multiple kernel releases. The details
> can be found in the following two merge messages:
> cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2')
> 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0')
> Consistent setgid stripping behavior is now encapsulated in the
> setattr_should_drop_sgid() helper which is used by all filesystems that
> strip setgid bits outside of vfs proper. Switch nfs to rely on this
> helper as well. Without this patch the setgid stripping tests in
> xfstests will fail.
>=20
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
>=20
> diff --git a/fs/attr.c b/fs/attr.c
> index aca9ff7aed33..d60dc1edb526 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -47,6 +47,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
>  		return ATTR_KILL_SGID;
>  	return 0;
>  }
> +EXPORT_SYMBOL(setattr_should_drop_sgid);
> =20
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
> -			     const struct inode *inode);
>  struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
>  struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
>  void mnt_idmap_put(struct mnt_idmap *idmap);
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 222a28320e1c..97a76706fd54 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -717,9 +717,7 @@ void nfs_setattr_update_inode(struct inode *inode, st=
ruct iattr *attr,
>  		if ((attr->ia_valid & ATTR_KILL_SUID) !=3D 0 &&
>  		    inode->i_mode & S_ISUID)
>  			inode->i_mode &=3D ~S_ISUID;
> -		if ((attr->ia_valid & ATTR_KILL_SGID) !=3D 0 &&
> -		    (inode->i_mode & (S_ISGID | S_IXGRP)) =3D=3D
> -		     (S_ISGID | S_IXGRP))
> +		if (setattr_should_drop_sgid(&nop_mnt_idmap, inode))
>  			inode->i_mode &=3D ~S_ISGID;
>  		if ((attr->ia_valid & ATTR_MODE) !=3D 0) {
>  			int mode =3D attr->ia_mode & S_IALLUGO;
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
> +			     const struct inode *inode);
> =20
>  /*
>   * This must be used for allocating filesystems specific inodes to set
>=20
> ---
> base-commit: eeac8ede17557680855031c6f305ece2378af326
> change-id: 20230313-fs-nfs-setgid-659410a10b25
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
