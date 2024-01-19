Return-Path: <linux-fsdevel+bounces-8301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6B83285B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 12:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA22B2283E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6505C4C628;
	Fri, 19 Jan 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkUN+jYN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427054C615;
	Fri, 19 Jan 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662524; cv=none; b=ZGjhdvy9lZJO4fcGgYZLQkf4fziSbDTiOACDdxOs6NaPkLp4tYgd8uGJTRBEEtEtdQwXnMIYxp2ZhfeKzx0sVJRf6aI4P1J0H3SGlIuARQsUKlN5Yh9g5q9rv9KpxPmJ4aV3NUHtppSDbD4uhulyuSFDU82ypE6s+xMSVSZyuSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662524; c=relaxed/simple;
	bh=iKEnhR+6hI5Y93enzJTV75HTCTYqZMBGGyKPCjmXKTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R30cRNEiyCpBKzlfS4JeqbWFaK0A8nqBNgggkf9AnOgtTnrj/z5kx+Q2ACEbuj5pNUj0xU7WVVmv15dlnoJs04yep6TBE2IdV2Iyj56wrIQ5zC3+ql/HwhYtiYFE0ZHwsovfv4sjUmIYuvcysCZZPzMrSM84oZZEjZhM3UTFGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkUN+jYN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78324e302d4so50349385a.1;
        Fri, 19 Jan 2024 03:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705662522; x=1706267322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5HqOQ45z2/iQF1v/DY2/eQzBdqhq0puPqTiFxfUSEI=;
        b=MkUN+jYNcY1hzjE0MoGzaUVKQB8beSdQ7/aRBotK3DtuPjt4oKcOgD++j/id7zu6vr
         r5ncXTDuFrp3ZekeVDcaKn7D76/pQcXLKvSggOCIk1mRObcZOqoUHKcJnQRRT/zBfHtx
         Hs+5N6bz1bLarU/jFJvPElrGTIytTyYktcgMgo2aRp9bS1/Ff+lnSSpwSDZecWhaRtAI
         PdJx1ywxtSkQEBL9L1AB0cElKXnqt2p/0via0ADtF5uLpbxi0LiJGRxZl1TvjwjyFW6r
         bXOvNGjq9ZhIa0WndX1pxnIVxPr53JMuVHZf5TcqOu4d83qtC6St+s5iVt+Q278ohAUV
         iWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662522; x=1706267322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5HqOQ45z2/iQF1v/DY2/eQzBdqhq0puPqTiFxfUSEI=;
        b=O6+vfsZv/BaBzT2IvA43pe3slfFD1C2lCSFqNX9rwxJfOGUkZfUtBO70GTPLv+ja/7
         HjWMYR1SxUKxYHCOjERCcOKNHjgbTWWrINezGeliJEc//MGUaSsDtCanCQwxyjFriKAU
         /UZXCDdjGIZIbVIc5Bc43A8YZ1pDLFy1KxYSLaWUVd9CMaK/c4sfz8IVm5Mmd69dEweu
         z4PS8ZNxRh6FkHfmS1L84ObdyCiqOh3jB8CMZ8rpOanBfH9WbFfn/3LoEtAJabHOLZll
         /CsNEVdWdnLjZsUBl47cFmeW12FEHQFd8kJWz9RG2tV3XOp8SzRAd4J7KCLt+mcDCCjY
         tIhQ==
X-Gm-Message-State: AOJu0Yxe4Z+2vbOsRj7XcrnOaWjUAFgQOW8kHCDkkEzKQhfKLmhdaGrO
	AxmWkaVQgaCzUAz4oMs7z3CfCXe9BAOR0tzBv6xPO0Xfue9agzcZSfYGM3gcy2SqvGunIiN3C3u
	me7vSgfx3jhFBK4BfsmLANm5oU0+WfABxcAI=
X-Google-Smtp-Source: AGHT+IES49S32TLDHlJQ/+janDYXPaZfxYgWZFMJM6zJEvnkW4Dox6IYbKkexPWBnKEx1882mn8iP3+QPox0sC5MpGs=
X-Received: by 2002:a05:6214:528d:b0:681:6840:f805 with SMTP id
 kj13-20020a056214528d00b006816840f805mr2419242qvb.38.1705662521981; Fri, 19
 Jan 2024 03:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com>
In-Reply-To: <20240119101454.532809-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Jan 2024 13:08:30 +0200
Message-ID: <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, Alexander Larsson <alexl@redhat.com>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:14=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> Add a check on each lower layer for the xwhiteout feature.  This prevents
> unnecessary checking the overlay.whiteouts xattr when reading a directory
> if this feature is not enabled, i.e. most of the time.
>
> Share the same xattr for the per-directory and the per-layer flag, which
> has the effect that if this is enabled for a layer, then the optimization
> to bypass checking of individual entries does not work on the root of the
> layer.  This was deemed better, than having a separate xattr for the laye=
r
> and the directory.
>
> Fixes: bc8df7a3dc03 ("ovl: Add an alternative type of whiteout")
> Cc: <stable@vger.kernel.org> # v6.7
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
> v2:
>  - use overlay.whiteouts instead of overlay.feature_xwhiteout
>  - move initialization to ovl_get_layers()
>  - xwhiteouts can only be enabled on lower layer
>
>  fs/overlayfs/namei.c     | 10 +++++++---
>  fs/overlayfs/overlayfs.h |  7 +++++--
>  fs/overlayfs/ovl_entry.h |  2 ++
>  fs/overlayfs/readdir.c   | 11 ++++++++---
>  fs/overlayfs/super.c     | 13 +++++++++++++
>  fs/overlayfs/util.c      |  7 ++++++-
>  6 files changed, 41 insertions(+), 9 deletions(-)
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
> index 05c3dd597fa8..6359cf5c66ff 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -492,7 +492,9 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, con=
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
> @@ -674,7 +676,8 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct den=
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
> index d82d2a043da2..33fcd3d3af30 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -40,6 +40,8 @@ struct ovl_layer {
>         int idx;
>         /* One fsid per unique underlying sb (upper fsid =3D=3D 0) */
>         int fsid;
> +       /* xwhiteouts are enabled on this layer*/
> +       bool xwhiteouts;
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

Not needed since we do not support xwhiteouts on upper.

>
>         err =3D ovl_dir_read(&realpath, &rdd);
>         if (err)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index a0967bb25003..04588721eb2a 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1027,6 +1027,7 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>                 struct ovl_fs_context_layer *l =3D &ctx->lower[i];
>                 struct vfsmount *mnt;
>                 struct inode *trap;
> +               struct path root;
>                 int fsid;
>
>                 if (i < nr_merged_lower)
> @@ -1069,6 +1070,16 @@ static int ovl_get_layers(struct super_block *sb, =
struct ovl_fs *ofs,
>                  */
>                 mnt->mnt_flags |=3D MNT_READONLY | MNT_NOATIME;
>
> +               /*
> +                * Check if xwhiteout (xattr whiteout) support is enabled=
 on
> +                * this layer.
> +                */
> +               root.mnt =3D mnt;
> +               root.dentry =3D mnt->mnt_root;
> +               err =3D ovl_path_getxattr(ofs, &root, OVL_XATTR_XWHITEOUT=
S, NULL, 0);
> +               if (err >=3D 0)
> +                       layers[ofs->numlayer].xwhiteouts =3D true;
> +
>                 layers[ofs->numlayer].trap =3D trap;
>                 layers[ofs->numlayer].mnt =3D mnt;
>                 layers[ofs->numlayer].idx =3D ofs->numlayer;
> @@ -1079,6 +1090,8 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>                 l->name =3D NULL;
>                 ofs->numlayer++;
>                 ofs->fs[fsid].is_lower =3D true;
> +
> +

extra spaces.

>         }
>
>         /*
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index c3f020ca13a8..6c6e6f5893ea 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -739,11 +739,16 @@ bool ovl_path_check_xwhiteout_xattr(struct ovl_fs *=
ofs, const struct path *path)
>         return res >=3D 0;
>  }
>
> -bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs, const struct pa=
th *path)
> +bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs,
> +                                    const struct ovl_layer *layer,
> +                                    const struct path *path)
>  {
>         struct dentry *dentry =3D path->dentry;
>         int res;
>
> +       if (!layer->xwhiteouts)
> +               return false;
> +
>         /* xattr.whiteouts must be a directory */
>         if (!d_is_dir(dentry))
>                 return false;
> --
> 2.43.0
>

Do you want me to fix/test and send this to Linus?

Alex, can we add your RVB to v2?

Thanks,
Amir.

