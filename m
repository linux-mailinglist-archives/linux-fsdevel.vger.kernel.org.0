Return-Path: <linux-fsdevel+bounces-8238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF8983185E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 12:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904E41F2363F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6224216;
	Thu, 18 Jan 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3bkrz/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052A2420D;
	Thu, 18 Jan 2024 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576893; cv=none; b=qlnY/y4dXrNb+WtSzZRcq3fl8rTT7My0W1tysKY7nZrorrn+aHxbq6HTJfaJqYvmixJOjzYP+yuDyeroeHllPjY7JGuWHB0i4ZZNtxHtLyaINR/U5QoPZugMmFbgVYmjBAE00or/iJUMyEK1UJx3VRq3Imbk5UZSLjxWDDs9dkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576893; c=relaxed/simple;
	bh=ZKwB8DV0acqroboPz0MsCyjh1M6ia9lG2ZwO4kSX0dw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=abRmm7crRgpBAyTxnOXQNq0cKX+d09MsfmXHE6KIwSlRURtEG9htWxrxej5s8vZ4GeWGOcaDdJPD7/kdgf1c0B4jpWjlaubeEsDFl7qxuhis1HRfj9bYwEdpytr0m9xPWMkldDgq5spkcoR3dFmT2awReyxNNW2Krkzj2dB92tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3bkrz/j; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-680b1335af6so5165606d6.1;
        Thu, 18 Jan 2024 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576891; x=1706181691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSg7oDGrmlA37QkaixUy9xrvu8yvTJ438U4M62DJriU=;
        b=H3bkrz/jpxYaE3RrDiT4+lOuCgMmSCeSm9D05JmValx5qnxXReyrb7FCvyfUXDnQye
         2iBnJY6ciQ5Ey6POdhuUL0a8s2YKObXRs9vaOcnqetldeo8nU5xacfdlwtsUTBfsbqVJ
         9QTdB5EXgSRZLJ686ky+zTCzkqjiP3pCQvQocVOzNSIR5GnMxtV6UuHGvhFo5dOnG+U7
         FCXDyX7doWM8Tw+0zZWgQ++26F3Se+rAuQhiIqvtTLzWFcbb8UC8r45QB5Y1UJoPZQZz
         LwMy7B2ABkrYV4PKyuJMqKRq9CwH0NGTVUCeSLHPw39no9jYDvw5M8wyqPeeCuLhnF8Q
         6Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576891; x=1706181691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSg7oDGrmlA37QkaixUy9xrvu8yvTJ438U4M62DJriU=;
        b=sF8sJTOdUGoUNaR5Qpz7/7B5XSEcfOrfBXNoagOrVPcrWiAy77JpOlqEc54eXi/5P+
         eFeOmHRxulYYM11R365qt+wac1ovqEh9Y0wVsCIXCi6u0P1mHYfm1urjkzf9YjwMthwS
         WjriezXLhjiiF0mW+PU3kE5Y9m+f6HrjOg27AN+esxX3nAHKby2qBXGGJ/v1WvqkiQO+
         mef017JR3f4QwWrO1zXpILR1Efu27TIsc9xZ+G8IbD0ZywRCyNCHON2GqdiA291krqcc
         EfetVBvq4GWq4YK9XCUMYjtG0c8xo+CJiNOI6uelWChB09wRd3Sqr8DqiVeUkNyrIamE
         hQBA==
X-Gm-Message-State: AOJu0Yx7Qo8PjAl6Carior7D4o/adH3HZAaOyTetD0yFEj22jDAOxTPC
	j60qVqv99+LTpDCNghzdjDMnK9eqONh19HBzUkXJ99HBmtJZyEr8U/dV+MCydlmpuSnq5NLTH9s
	GiCHYxErtvSScOBzv/Y0cJqx7PSE=
X-Google-Smtp-Source: AGHT+IH+4PBmNp4bWYe29tXwAIGiYqngcRSrKWmZCw9+PwaLHPqsvyMIuD3OM1NPUovQHR36TUtHzsZBsnEhFcByHaU=
X-Received: by 2002:a05:6214:29c6:b0:681:555b:3a44 with SMTP id
 gh6-20020a05621429c600b00681555b3a44mr1103219qvb.30.1705576890671; Thu, 18
 Jan 2024 03:21:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104144.465158-1-mszeredi@redhat.com>
In-Reply-To: <20240118104144.465158-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Jan 2024 13:21:19 +0200
Message-ID: <CAOQ4uxgB3qhqtTGsvgLQ6x4taZ4m-V0MD9rXJ_zacTPrCR+bow@mail.gmail.com>
Subject: Re: [PATCH] ovl: require xwhiteout feature flag on layer roots
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, Alexander Larsson <alexl@redhat.com>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:41=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> Add a check on each layer for the xwhiteout feature.  This prevents
> unnecessary checking the overlay.whiteouts xattr when reading a
> directory if this feature is not enabled, i.e. most of the time.

Does it really have a significant cost or do you just not like the
unneeded check?
IIRC, we anyway check for ORIGIN xattr and IMPURE xattr on
readdir.

>
> Fixes: bc8df7a3dc03 ("ovl: Add an alternative type of whiteout")
> Cc: <stable@vger.kernel.org> # v6.7
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>
> Hi Alex,
>
> Can you please test this in your environment?
>
> I xwhiteout test in xfstests needs this tweak:
>
> --- a/tests/overlay/084
> +++ b/tests/overlay/084
> @@ -115,6 +115,7 @@ do_test_xwhiteout()
>
>         mkdir -p $basedir/lower $basedir/upper $basedir/work
>         touch $basedir/lower/regular $basedir/lower/hidden  $basedir/uppe=
r/hidden
> +       setfattr -n $prefix.overlay.feature_xwhiteout -v "y" $basedir/upp=
er
>         setfattr -n $prefix.overlay.whiteouts -v "y" $basedir/upper
>         setfattr -n $prefix.overlay.whiteout -v "y" $basedir/upper/hidden
>
>
> Thanks,
> Miklos
>
> fs/overlayfs/namei.c     | 10 +++++++---
>  fs/overlayfs/overlayfs.h |  8 ++++++--
>  fs/overlayfs/ovl_entry.h |  2 ++
>  fs/overlayfs/readdir.c   | 11 ++++++++---
>  fs/overlayfs/super.c     | 13 ++++++++++++-
>  fs/overlayfs/util.c      |  9 ++++++++-
>  6 files changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 03bc8d5dfa31..583cf56df66e 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -863,7 +863,8 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, s=
truct dentry *upper,
>   * Returns next layer in stack starting from top.
>   * Returns -1 if this is the last layer.
>   */
> -int ovl_path_next(int idx, struct dentry *dentry, struct path *path)
> +int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
> +                 const struct ovl_layer **layer)
>  {
>         struct ovl_entry *oe =3D OVL_E(dentry);
>         struct ovl_path *lowerstack =3D ovl_lowerstack(oe);
> @@ -871,13 +872,16 @@ int ovl_path_next(int idx, struct dentry *dentry, s=
truct path *path)
>         BUG_ON(idx < 0);
>         if (idx =3D=3D 0) {
>                 ovl_path_upper(dentry, path);
> -               if (path->dentry)
> +               if (path->dentry) {
> +                       *layer =3D &OVL_FS(dentry->d_sb)->layers[0];
>                         return ovl_numlower(oe) ? 1 : -1;
> +               }
>                 idx++;
>         }
>         BUG_ON(idx > ovl_numlower(oe));
>         path->dentry =3D lowerstack[idx - 1].dentry;
> -       path->mnt =3D lowerstack[idx - 1].layer->mnt;
> +       *layer =3D lowerstack[idx - 1].layer;
> +       path->mnt =3D (*layer)->mnt;
>
>         return (idx < ovl_numlower(oe)) ? idx + 1 : -1;
>  }
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 05c3dd597fa8..991eb5d5c66c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -51,6 +51,7 @@ enum ovl_xattr {
>         OVL_XATTR_PROTATTR,
>         OVL_XATTR_XWHITEOUT,
>         OVL_XATTR_XWHITEOUTS,
> +       OVL_XATTR_FEATURE_XWHITEOUT,

Can we not add a new OVL_XATTR_FEATURE_XWHITEOUT xattr.

Setting OVL_XATTR_XWHITEOUTS on directories with xwhiteouts is
anyway the responsibility of the layer composer.

Let's just require the layer composer to set OVL_XATTR_XWHITEOUTS
on the layer root even if it does not have any immediate xwhiteout
children as "layer may have xwhiteouts" indication. ok?


>  };
>
>  enum ovl_inode_flag {
> @@ -492,7 +493,9 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, con=
st struct path *path,
>                               enum ovl_xattr ox);
>  bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct path *=
path);
>  bool ovl_path_check_xwhiteout_xattr(struct ovl_fs *ofs, const struct pat=
h *path);
> -bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs, const struct pa=
th *path);
> +bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs,
> +                                    const struct ovl_layer *layer,
> +                                    const struct path *path);
>  bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
>                          const struct path *upperpath);
>
> @@ -674,7 +677,8 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct den=
try *origin,
>  struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh);
>  struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper=
,
>                                 struct dentry *origin, bool verify);
> -int ovl_path_next(int idx, struct dentry *dentry, struct path *path);
> +int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
> +                 const struct ovl_layer **layer);
>  int ovl_verify_lowerdata(struct dentry *dentry);
>  struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>                           unsigned int flags);
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index d82d2a043da2..51729e614f5a 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -40,6 +40,8 @@ struct ovl_layer {
>         int idx;
>         /* One fsid per unique underlying sb (upper fsid =3D=3D 0) */
>         int fsid;
> +       /* xwhiteouts are enabled on this layer*/
> +       bool feature_xwhiteout;
>  };
>
>  struct ovl_path {
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index a490fc47c3e7..c2597075e3f8 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -305,8 +305,6 @@ static inline int ovl_dir_read(const struct path *rea=
lpath,
>         if (IS_ERR(realfile))
>                 return PTR_ERR(realfile);
>
> -       rdd->in_xwhiteouts_dir =3D rdd->dentry &&
> -               ovl_path_check_xwhiteouts_xattr(OVL_FS(rdd->dentry->d_sb)=
, realpath);
>         rdd->first_maybe_whiteout =3D NULL;
>         rdd->ctx.pos =3D 0;
>         do {
> @@ -359,10 +357,14 @@ static int ovl_dir_read_merged(struct dentry *dentr=
y, struct list_head *list,
>                 .is_lowest =3D false,
>         };
>         int idx, next;
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> +       const struct ovl_layer *layer;
>
>         for (idx =3D 0; idx !=3D -1; idx =3D next) {
> -               next =3D ovl_path_next(idx, dentry, &realpath);
> +               next =3D ovl_path_next(idx, dentry, &realpath, &layer);
>                 rdd.is_upper =3D ovl_dentry_upper(dentry) =3D=3D realpath=
.dentry;
> +               if (ovl_path_check_xwhiteouts_xattr(ofs, layer, &realpath=
))
> +                       rdd.in_xwhiteouts_dir =3D true;
>
>                 if (next !=3D -1) {
>                         err =3D ovl_dir_read(&realpath, &rdd);
> @@ -568,6 +570,7 @@ static int ovl_dir_read_impure(const struct path *pat=
h,  struct list_head *list,
>         int err;
>         struct path realpath;
>         struct ovl_cache_entry *p, *n;
> +       struct ovl_fs *ofs =3D OVL_FS(path->dentry->d_sb);
>         struct ovl_readdir_data rdd =3D {
>                 .ctx.actor =3D ovl_fill_plain,
>                 .list =3D list,
> @@ -577,6 +580,8 @@ static int ovl_dir_read_impure(const struct path *pat=
h,  struct list_head *list,
>         INIT_LIST_HEAD(list);
>         *root =3D RB_ROOT;
>         ovl_path_upper(path->dentry, &realpath);
> +       if (ovl_path_check_xwhiteouts_xattr(ofs, &ofs->layers[0], &realpa=
th))
> +               rdd.in_xwhiteouts_dir =3D true;
>
>         err =3D ovl_dir_read(&realpath, &rdd);
>         if (err)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index a0967bb25003..4e507ab780f3 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1291,7 +1291,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>         struct ovl_entry *oe;
>         struct ovl_layer *layers;
>         struct cred *cred;
> -       int err;
> +       int err, i;
>
>         err =3D -EIO;
>         if (WARN_ON(fc->user_ns !=3D current_user_ns()))
> @@ -1414,6 +1414,17 @@ int ovl_fill_super(struct super_block *sb, struct =
fs_context *fc)
>         if (err)
>                 goto out_free_oe;
>
> +       for (i =3D 0; i < ofs->numlayer; i++) {
> +               struct path path =3D { .mnt =3D layers[i].mnt };
> +
> +               if (path.mnt) {
> +                       path.dentry =3D path.mnt->mnt_root;
> +                       err =3D ovl_path_getxattr(ofs, &path, OVL_XATTR_F=
EATURE_XWHITEOUT, NULL, 0);
> +                       if (err >=3D 0)
> +                               layers[i].feature_xwhiteout =3D true;


Any reason not to do this in ovl_get_layers() when adding the layer?

Thanks,
Amir.

