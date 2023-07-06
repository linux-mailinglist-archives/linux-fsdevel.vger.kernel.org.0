Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB5749636
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGFHUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 03:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjGFHUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:20:14 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBD1BD8;
        Thu,  6 Jul 2023 00:20:11 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44096f01658so125525137.0;
        Thu, 06 Jul 2023 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688628010; x=1691220010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lmKgGO3f9SraLQnfsiu8hluMt7RG2bWCDPF7r5VmIo=;
        b=NuILwJ3t87PFreXvL8nm+2rrx1kxQffj12I8iFKpSI38oqfPX6H2aZpQqjKXrcM7Jo
         DAdCXs18BCH9ETVQFA/A/BDy1mhtw0rNwkUf5qENWEzHP5ScnXx1hP6ReexR8mCc/fas
         eoUytP+LnYdlfPCYKbZC8r7MuZoVyXcjNtqhDUhsWr5GBnkltAv7jgrMs7ZZ39KBMa3p
         phipTKvE+Al1Pe5K8KE9WFxQEpwVCb8M2sj11gIjUpI57o0uVCU/mXLUei4Dq5PeFIQa
         Dakf67vS8m2ZLNl08VQChbXjlsjq6gAWcPxyEhImCChJwTAs81p+IpRlAuIaPFAgjfZB
         wGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688628010; x=1691220010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lmKgGO3f9SraLQnfsiu8hluMt7RG2bWCDPF7r5VmIo=;
        b=O1IN4k7eXjdv2FOTwWQrwTagHQioIzG/gc2W139XB9F3gz05fAofUu6pbH/DpIgROn
         jwKtX0PWp3voax0a3KuEElQrxZmvi+5VRpuvKe6pe+RgiI2cIvqqkJT4q5L6XuSZEa4X
         F35LyaDrxP7mxR0CbMhQCbNVK1Fl6DdGkcgAswJFmNjKWf8WL6PaoMFHjHw+BnMzbAiL
         lCzfLJOE8JyKAmVe0Ue0IWpdpvLuZJBo3rju274Td0RSuby2Dce/IIpGlg0IxUZirvxx
         a0xHgsu0u8ArkYj8VAOIyfZoekj8QJ0BCOCJHwMAJf/O/Dbz63HF8KtWSo5eFkq91BIn
         f9Dg==
X-Gm-Message-State: ABy/qLZ4VNHnsuTmfyBzgwwc3mAjPsLTJcD6GaKvKjQl9aUW0g/MfRYw
        Q0xwVuWm5iT18RJZEql7K8WlVBGgasUTTJNiEwE=
X-Google-Smtp-Source: APBJJlFTQYvwXRV0Pgo4FXXI5krTk6ijbZPTmgLfiTzzOHOBbPdu4IixgK9ppBZdbsV3WLT6YzNBBd/ObN5JQ6zgE3A=
X-Received: by 2002:a67:cf89:0:b0:437:e5ce:7e8f with SMTP id
 g9-20020a67cf89000000b00437e5ce7e8fmr602951vsm.4.1688628010307; Thu, 06 Jul
 2023 00:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230425132223.2608226-1-amir73il@gmail.com> <20230425132223.2608226-4-amir73il@gmail.com>
In-Reply-To: <20230425132223.2608226-4-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 6 Jul 2023 10:19:59 +0300
Message-ID: <CAOQ4uxgX0Tx07q2gAzsB2kPsUm+MjsYw9BG4W7-h8ODNnqH_1A@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] ovl: use persistent s_uuid with index=on
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
> With index=3Don, overlayfs instances are non-migratable, meaning that
> the layers cannot be copied without breaking the index.
>
> So when indexdir exists, store a persistent uuid in xattr on the
> indexdir to give the overlayfs instance a persistent identifier.
>
> This also makes f_fsid persistent and more reliable for reporting
> fid info in fanotify events.
>
> With mount option uuid=3Dnogen, a persistent uuid is not be initialized
> on indexdir, but if a persistent uuid already exists, it will be used.
>

This behavior (along with the grammatical mistakes) was changed in
https://github.com/amir73il/linux/commits/ovl_encode_fid

uuid=3Doff or uuid=3Dnull both set ovl fsid to null regardless of persisten=
t
uuid xattr.

Whether we need this backward compact option or not is to be determined.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/overlayfs.h |  3 +++
>  fs/overlayfs/super.c     |  7 +++++++
>  fs/overlayfs/util.c      | 41 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index dcdb02d0ddf8..9927472a3aaa 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -36,6 +36,7 @@ enum ovl_xattr {
>         OVL_XATTR_IMPURE,
>         OVL_XATTR_NLINK,
>         OVL_XATTR_UPPER,
> +       OVL_XATTR_UUID,
>         OVL_XATTR_METACOPY,
>         OVL_XATTR_PROTATTR,
>  };
> @@ -431,6 +432,8 @@ bool ovl_already_copied_up(struct dentry *dentry, int=
 flags);
>  bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *pat=
h,
>                               enum ovl_xattr ox);
>  bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct path *=
path);
> +bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
> +                        struct dentry *upperdentry, bool set);
>
>  static inline bool ovl_check_origin_xattr(struct ovl_fs *ofs,
>                                           struct dentry *upperdentry)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ad2250f98b38..8364620e8722 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1535,6 +1535,9 @@ static int ovl_get_indexdir(struct super_block *sb,=
 struct ovl_fs *ofs,
>                 if (err)
>                         pr_err("failed to verify index dir 'upper' xattr\=
n");
>
> +               /* Best effort get or set persistent uuid */
> +               ovl_init_uuid_xattr(sb, ofs, ofs->indexdir, true);
> +
>                 /* Cleanup bad/stale/orphan index entries */
>                 if (!err)
>                         err =3D ovl_indexdir_cleanup(ofs);
> @@ -2052,6 +2055,10 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
>                         ovl_uuid_str[ofs->config.uuid]);
>         }
>
> +       /*
> +        * This uuid may be overridden by a persistent uuid stored in xat=
tr on
> +        * index dir and it may be persisted in xattr on first index=3Don=
 mount.
> +        */
>         if (ovl_want_uuid_gen(ofs))
>                 uuid_gen(&sb->s_uuid);
>
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 923d66d131c1..8902db4b2975 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -589,6 +589,45 @@ bool ovl_path_check_origin_xattr(struct ovl_fs *ofs,=
 const struct path *path)
>         return false;
>  }
>
> +/*
> + * Load persistent uuid from xattr into s_uuid if found, possibly overri=
ding
> + * the random generated value in s_uuid.
> + * Otherwise, if @set is true and s_uuid contains a valid value, store t=
his
> + * value in xattr.
> + */
> +bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
> +                        struct dentry *upperdentry, bool set)
> +{
> +       struct path path =3D {
> +               .dentry =3D upperdentry,
> +               .mnt =3D ovl_upper_mnt(ofs),
> +       };
> +       uuid_t uuid;
> +       int res;
> +
> +       res =3D ovl_path_getxattr(ofs, &path, OVL_XATTR_UUID, uuid.b, UUI=
D_SIZE);
> +       if (res =3D=3D UUID_SIZE) {
> +               uuid_copy(&sb->s_uuid, &uuid);
> +               return true;
> +       }
> +
> +       if (res =3D=3D -ENODATA) {
> +               if (!set || uuid_is_null(&sb->s_uuid))
> +                       return false;
> +
> +               res =3D ovl_setxattr(ofs, upperdentry, OVL_XATTR_UUID,
> +                                  sb->s_uuid.b, UUID_SIZE);
> +               if (res =3D=3D 0)
> +                       return true;
> +       } else {
> +               set =3D false;
> +       }
> +
> +       pr_warn("failed to %s uuid (%pd2, err=3D%i)\n",
> +               set ? "set" : "get", upperdentry, res);
> +       return false;
> +}
> +
>  bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *pat=
h,
>                                enum ovl_xattr ox)
>  {
> @@ -611,6 +650,7 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, con=
st struct path *path,
>  #define OVL_XATTR_IMPURE_POSTFIX       "impure"
>  #define OVL_XATTR_NLINK_POSTFIX                "nlink"
>  #define OVL_XATTR_UPPER_POSTFIX                "upper"
> +#define OVL_XATTR_UUID_POSTFIX         "uuid"
>  #define OVL_XATTR_METACOPY_POSTFIX     "metacopy"
>  #define OVL_XATTR_PROTATTR_POSTFIX     "protattr"
>
> @@ -625,6 +665,7 @@ const char *const ovl_xattr_table[][2] =3D {
>         OVL_XATTR_TAB_ENTRY(OVL_XATTR_IMPURE),
>         OVL_XATTR_TAB_ENTRY(OVL_XATTR_NLINK),
>         OVL_XATTR_TAB_ENTRY(OVL_XATTR_UPPER),
> +       OVL_XATTR_TAB_ENTRY(OVL_XATTR_UUID),
>         OVL_XATTR_TAB_ENTRY(OVL_XATTR_METACOPY),
>         OVL_XATTR_TAB_ENTRY(OVL_XATTR_PROTATTR),
>  };
> --
> 2.34.1
>
