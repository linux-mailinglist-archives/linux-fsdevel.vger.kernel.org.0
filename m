Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B869974965C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjGFH13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjGFH12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:27:28 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E410A;
        Thu,  6 Jul 2023 00:27:27 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so135867241.1;
        Thu, 06 Jul 2023 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688628446; x=1691220446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uISjg6ChBgK0HXMruOvFhiDZACJ6uRcTTfMW8Zf5U6s=;
        b=hwXrI9BKuovy+Rnvq34hNjrVvQ67zEZsbnp1jQKYvtotZ1Y77CXK0UOrxDR6YbZSID
         vB4vqONtsg+IQG4TuKMoUcNAylrH+SspxoAeeaavS6WDTa8bVYlCwm3r+m3IWRVh46gA
         oQdpSGohRRUp5f/CDX9ANOn4+u/wHuyDH9UMCEEONbyaIgGT5ynQO27eBi1giSdkT6Hm
         srjBFPJ22PooaWIGRv3V6l08Vl5OxaEx/pybKfFyiSUs3tgrEIt7tA1Bmv4WlSS+/95s
         fvs2WDQ0aGOSizcGgj6BE44DCHmjPtGoXNakcVZxMaOVlcEf0Dt04p7tFC3l/1fxwAd9
         ORPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688628446; x=1691220446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uISjg6ChBgK0HXMruOvFhiDZACJ6uRcTTfMW8Zf5U6s=;
        b=MzlbXWkcIDxecUfhlcaz3f7O9SxSSJAfIHrYiuK/dgMCoE3OLxc9wEcg4zeRV+fJHM
         tVXoSWdj2FqLLiOhv5DicXdaVcejqaUfJB2iqYO5aUysNaAUx4I8fBHuiWhpNC6ea0UF
         L6lJI+rAkkp3dPNhzQQ7sfT3quPhw2+z0Un1mKioRQxBG5UhjH8X/XQ/6bpayxpEV1q5
         iGPpc2w0xxbvPWpYG0QEYGjNIbXdtJxkH1KNb9FaTOD6SHoqIOLJ+YYjIg69IOryGPxr
         5kHyr218xrAA5JZ3ywTxDp2hB7jP4AFQfl26qRZRfyZ44gUmyLJN8EebaPjZp3DnnPmq
         eTtw==
X-Gm-Message-State: ABy/qLYkvMlIt6sFE3YIIOF8m/Pj5Nj5p+odWGsLwR5VSlFFH7XsQtM2
        /B/RRboqKxwncdvHlfm+hN1eQWjsv3qHQ9di+ds=
X-Google-Smtp-Source: APBJJlELbNo2X6GQfQ9G96Q57ELTFwqdMlj1Psro/5ccMyC3gS4n+hLkhSCFC37mxbjHSdoOpgM2Hulu/zkq5e2pczc=
X-Received: by 2002:a67:f7c3:0:b0:443:60d7:3925 with SMTP id
 a3-20020a67f7c3000000b0044360d73925mr663927vsp.20.1688628446353; Thu, 06 Jul
 2023 00:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230425132223.2608226-1-amir73il@gmail.com> <20230425132223.2608226-2-amir73il@gmail.com>
In-Reply-To: <20230425132223.2608226-2-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 6 Jul 2023 10:27:15 +0300
Message-ID: <CAOQ4uxh70boEqU4cxhWFOk8y=eQCBTr=68TY39SMmgdD-B2HKA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] ovl: support encoding non-decodeable file handles
To:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 4:22=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> When all layers support file handles, we support encoding non-decodeable
> file handles (a.k.a. fid) even with nfs_export=3Doff.
>
> When file handles do not need to be decoded, we do not need to copy up
> redirected lower directories on encode, and we encode also non-indexed
> upper with lower file handle, so fid will not change on copy up.
>
> This enables reporting fanotify events with file handles on overlayfs
> with default config/mount options.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

FYI, the exportfs support for non-decodable file handles has been merged.

This follow up series which adds support for non-decodable file handles
to overlayfs has been pushed to:
https://github.com/amir73il/linux/commits/ovl_encode_fid
and to overlayfs-next (pending review by Miklos).

fanotify (over ovl) tests are available at:
https://github.com/amir73il/ltp/commits/ovl_encode_fid

Thanks,
Amir.

>  fs/overlayfs/export.c    | 26 ++++++++++++++++++++------
>  fs/overlayfs/inode.c     |  2 +-
>  fs/overlayfs/overlayfs.h |  1 +
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/super.c     |  9 +++++++++
>  5 files changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index defd4e231ad2..dfd05ad2b722 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -173,28 +173,37 @@ static int ovl_connect_layer(struct dentry *dentry)
>   * U =3D upper file handle
>   * L =3D lower file handle
>   *
> - * (*) Connecting an overlay dir from real lower dentry is not always
> + * (*) Decoding a connected overlay dir from real lower dentry is not al=
ways
>   * possible when there are redirects in lower layers and non-indexed mer=
ge dirs.
>   * To mitigate those case, we may copy up the lower dir ancestor before =
encode
> - * a lower dir file handle.
> + * of a decodeable file handle for non-upper dir.
>   *
>   * Return 0 for upper file handle, > 0 for lower file handle or < 0 on e=
rror.
>   */
>  static int ovl_check_encode_origin(struct dentry *dentry)
>  {
>         struct ovl_fs *ofs =3D dentry->d_sb->s_fs_info;
> +       bool decodeable =3D ofs->config.nfs_export;
> +
> +       /* Lower file handle for non-upper non-decodeable */
> +       if (!ovl_dentry_upper(dentry) && !decodeable)
> +               return 0;
>
>         /* Upper file handle for pure upper */
>         if (!ovl_dentry_lower(dentry))
>                 return 0;
>
>         /*
> -        * Upper file handle for non-indexed upper.
> -        *
>          * Root is never indexed, so if there's an upper layer, encode up=
per for
>          * root.
>          */
> -       if (ovl_dentry_upper(dentry) &&
> +       if (dentry =3D=3D dentry->d_sb->s_root)
> +               return 0;
> +
> +       /*
> +        * Upper decodeable file handle for non-indexed upper.
> +        */
> +       if (ovl_dentry_upper(dentry) && decodeable &&
>             !ovl_test_flag(OVL_INDEX, d_inode(dentry)))
>                 return 0;
>
> @@ -204,7 +213,7 @@ static int ovl_check_encode_origin(struct dentry *den=
try)
>          * ovl_connect_layer() will try to make origin's layer "connected=
" by
>          * copying up a "connectable" ancestor.
>          */
> -       if (d_is_dir(dentry) && ovl_upper_mnt(ofs))
> +       if (d_is_dir(dentry) && ovl_upper_mnt(ofs) && decodeable)
>                 return ovl_connect_layer(dentry);
>
>         /* Lower file handle for indexed and non-upper dir/non-dir */
> @@ -875,3 +884,8 @@ const struct export_operations ovl_export_operations =
=3D {
>         .get_name       =3D ovl_get_name,
>         .get_parent     =3D ovl_get_parent,
>  };
> +
> +/* encode_fh() encodes non-decodeable file handles with nfs_export=3Doff=
 */
> +const struct export_operations ovl_export_fid_operations =3D {
> +       .encode_fh      =3D ovl_encode_fh,
> +};
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 541cf3717fc2..b6bec4064390 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -1304,7 +1304,7 @@ static bool ovl_hash_bylower(struct super_block *sb=
, struct dentry *upper,
>                 return false;
>
>         /* No, if non-indexed upper with NFS export */
> -       if (sb->s_export_op && upper)
> +       if (ofs->config.nfs_export && upper)
>                 return false;
>
>         /* Otherwise, hash by lower inode for fsnotify */
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 4d0b278f5630..87d44b889129 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -734,3 +734,4 @@ int ovl_set_origin(struct ovl_fs *ofs, struct dentry =
*lower,
>
>  /* export.c */
>  extern const struct export_operations ovl_export_operations;
> +extern const struct export_operations ovl_export_fid_operations;
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index fd11fe6d6d45..5cc0b6e65488 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -67,6 +67,7 @@ struct ovl_fs {
>         const struct cred *creator_cred;
>         bool tmpfile;
>         bool noxattr;
> +       bool nofh;
>         /* Did we take the inuse lock? */
>         bool upperdir_locked;
>         bool workdir_locked;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index f1d9f75f8786..5ed8c2650293 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -954,6 +954,7 @@ static int ovl_lower_dir(const char *name, struct pat=
h *path,
>                 pr_warn("fs on '%s' does not support file handles, fallin=
g back to index=3Doff,nfs_export=3Doff.\n",
>                         name);
>         }
> +       ofs->nofh |=3D !fh_type;
>         /*
>          * Decoding origin file handle is required for persistent st_ino.
>          * Without persistent st_ino, xino=3Dauto falls back to xino=3Dof=
f.
> @@ -1391,6 +1392,7 @@ static int ovl_make_workdir(struct super_block *sb,=
 struct ovl_fs *ofs,
>                 ofs->config.index =3D false;
>                 pr_warn("upper fs does not support file handles, falling =
back to index=3Doff.\n");
>         }
> +       ofs->nofh |=3D !fh_type;
>
>         /* Check if upper fs has 32bit inode numbers */
>         if (fh_type !=3D FILEID_INO32_GEN)
> @@ -2049,8 +2051,15 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
>                 ofs->config.nfs_export =3D false;
>         }
>
> +       /*
> +        * Support encoding decodeable file handles with nfs_export=3Don
> +        * and encoding non-decodeable file handles with nfs_export=3Doff
> +        * if all layers support file handles.
> +        */
>         if (ofs->config.nfs_export)
>                 sb->s_export_op =3D &ovl_export_operations;
> +       else if (!ofs->nofh)
> +               sb->s_export_op =3D &ovl_export_fid_operations;
>
>         /* Never override disk quota limits or use reserved space */
>         cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
> --
> 2.34.1
>
