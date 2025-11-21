Return-Path: <linux-fsdevel+bounces-69363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F1C77C10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 08:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 62DEC2D03C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2933468E;
	Fri, 21 Nov 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhrGkNjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFF2D5950
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711403; cv=none; b=Of9EY/3m6Cz8RaE6D8JVT8bNKrG6hor2FjQOkPB9F4SsCMpMv50qYKxms1UdSXfMDij6V/iLZwn8jn0Pz961UBykWmPvlYk0u9PS+74BDZPVAcKHiRNFoOCuppHX4Ixo+XnkwS30+PY9cg/Ub2ifHFRDGQOtol42fjMpC0Nq3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711403; c=relaxed/simple;
	bh=bVV+QQ8g8NVBUuUVXm41nfDIbGgF0GYyheqNtXe93YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSPEoK063U/ZTGT3MDNpzYA8adJtL7GwYxG+yJNimkEk7Hi1h+16Ru3DoFoVtBGqextBotqg+IETr2gnt3slNMxSx+cflz14grUU7+DwnukBRnHWlPIOMz5BO8PMbPFHVbP6ZInYXMWMseQCpm1tIo96CcERtl5Z0353QZrifmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhrGkNjP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso2617009a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 23:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763711399; x=1764316199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1IQEotkjEral/qLo/mRr0TpTfZpEKdzqnGrGfHx6BI=;
        b=AhrGkNjPxN8m63N46egRvpswroMkIgRc6WnyIAMJxt+vxWbQS+ia9Oo0Bb4A9G/KfR
         028Ayt53+RSWe3h1FSfCL4JALZuqjvh/da9qOIrNISEY3Fw2X8DjgpFNqkAC+N56m0Ml
         ZGpyfUOHGqcVy+5LU4KPbDzH6gWZVW0g3ZyWhsBvis8jANUFi5VvVcgCa0WlfqlIovy/
         1tQtuo+4h1yZFhkcW9rM6D0Odho0I9y5IpyWyzkM2+jnBF9MtDu9ZLMExaat5ABeVWMM
         U+D+SEaDdyDUSOGHNr4Nm/+7h2bct4zJDTQc13RU3xUZdiYCZvJgXvrPfKZz1YqIZO7r
         MF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763711399; x=1764316199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1IQEotkjEral/qLo/mRr0TpTfZpEKdzqnGrGfHx6BI=;
        b=k7KCY9+b60T281l6UZ2ykokoiRw4xhEQjX+gRdDE3H1V+NFvHmY1eJcPWzpDzMLH8+
         13GL3YOxpzFLCNBgLpFLeiq38QXa8+PyvBvFdMz6LTvsdVUaL7D97evwNl8LLnsBcDsL
         BLPrsdc6xwGljfxS4c74F+eQQWXO7bIDdS9q9bcf+RhE9ax87QbTW7uQ249aJoyyVDWO
         N8AF8NYsj+vPrP8kQTIeWX3qJ1h8tcBHMyqWd0l5LPGjjRjyXfJdVYt8jRsaiKJx7cmg
         j9noxRYADFGEgtKdK1NP7hetSmecEnShHnle4Je2i7J7d7SAjjf83GBrb5JqSI/3Xwtv
         b5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCURH+9Y+ZBe5om+Ihouwl1QO4Bde4/ceJ2MjhkDxj3Ao/7rGHDfKkV8pwEBYMS6ZFGSadw1nwDI//VadTEn@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFyzV+UYRZtVwV+1hh/a3VMH213i9PcG0Z7vdH8jCz4/AcQqn
	OIcygD+qxaj0WbIVlj5/TqccaLM5CxcXKKjingp/lyaOtgNOpPrebOEn+d1FSWqPz5fCC6RckI2
	B1K+ki4oJ02E5AruFM2tw0G2xd/COS3w=
X-Gm-Gg: ASbGncumAeJQC2DW4PndrI3K9L9q90vxofAhu1DXYvsoZsGG/vgxDDH0r4/7q5E724L
	rG6e9QkRKFsUeQC08p5tI1InxOnXSofeg/UI8XV1M/hojGw+ZbpD1tG7cGSeQwnbgWSCvyAuUaI
	a2o6b3h8rLfMWU6hMMBGEwiFh8EmjKUUHehgnfJmaLzbc9b4vS24xHNPoEmJvA7mXFpyIJklYxV
	GlRIuIV19bryYaCrHswL+3Q9qOjBuXBr6idrY4UDa4wVezWJBREwV1uyTI4B8sJpZPY8VwoKnDp
	dxCSRV+ooUsAoG7bJBriN69UmqAnuw==
X-Google-Smtp-Source: AGHT+IEi9eFAfW/h4YRIeKTaTyq2v0VMJ28KgpXgjGmISiXDVEcWnv3cXysl37fE7mfrHXs52AaZZUKKAF0D9oTu3us=
X-Received: by 2002:a05:6402:2349:b0:640:b643:f3c5 with SMTP id
 4fb4d7f45d1cf-64554676f7cmr1388931a12.16.1763711398445; Thu, 20 Nov 2025
 23:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120105535.13374-1-luis@igalia.com> <20251120105535.13374-4-luis@igalia.com>
In-Reply-To: <20251120105535.13374-4-luis@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 21 Nov 2025 08:49:47 +0100
X-Gm-Features: AWmQ_blsxbEpZO_HjEHxchemFiFW0fyoJEYvJ06desKzV62vxYZiXURYhhyzS-0
Message-ID: <CAOQ4uxgN5du9ukfYLBPh88+NMLt6AzSSgx4F+UJmugZ86CvB1g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:55=E2=80=AFAM Luis Henriques <luis@igalia.com> w=
rote:
>
> The implementation of LOOKUP_HANDLE simply modifies the LOOKUP operation =
to
> include an extra inarg: the file handle for the parent directory (if it i=
s
> available).  Also, because fuse_entry_out now has a extra variable size
> struct (the actual handle), it also sets the out_argvar flag to true.
>
> Most of the other modifications in this patch are a fallout from these
> changes: because fuse_entry_out has been modified to include a variable s=
ize
> struct, every operation that receives such a parameter have to take this
> into account:
>
>   CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
>

Overall, this is exactly what I had in mind.
Maybe it's utter garbage but that's what I was aiming for ;)

I'd like to get feedback from Miklos and Bernd on the details of the
protocol extension, especially w.r.t backward compat aspects.

> The export_operations were also modified to use this new file handle inst=
ead
> if the lookup_handle operation is implemented for the file system.

This part is really broken. I will comment on it, but would not recommend
that you include it in the same patch, because it is an independent change
that may even require an independent opt-in flag.

>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dev.c             |   1 +
>  fs/fuse/dir.c             |  75 +++++++++++++++-----
>  fs/fuse/fuse_i.h          |  34 ++++++++--
>  fs/fuse/inode.c           | 139 +++++++++++++++++++++++++++++++++-----
>  fs/fuse/readdir.c         |  10 +--
>  include/uapi/linux/fuse.h |   8 +++
>  6 files changed, 224 insertions(+), 43 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 132f38619d70..2f659e70a088 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -632,6 +632,7 @@ static void fuse_adjust_compat(struct fuse_conn *fc, =
struct fuse_args *args)
>                         break;
>                 }
>         }
> +       /* XXX handle FUSE_COMPAT_45_ENTRY_OUT_SIZE */
>  }
>
>  static void fuse_force_creds(struct fuse_req *req)
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 77d50ea30b61..a40f7aa700b0 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -169,7 +169,8 @@ static void fuse_invalidate_entry(struct dentry *entr=
y)
>  }
>
>  static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *arg=
s,
> -                            u64 nodeid, const struct qstr *name,
> +                            u64 nodeid, struct inode *dir,
> +                            const struct qstr *name,
>                              struct fuse_entry_out *outarg)
>  {
>         args->opcode =3D FUSE_LOOKUP;
> @@ -181,8 +182,20 @@ static void fuse_lookup_init(struct fuse_conn *fc, s=
truct fuse_args *args,
>         args->in_args[2].size =3D 1;
>         args->in_args[2].value =3D "";
>         args->out_numargs =3D 1;
> -       args->out_args[0].size =3D sizeof(struct fuse_entry_out);
> +       args->out_args[0].size =3D sizeof(*outarg) + outarg->fh.size;
>         args->out_args[0].value =3D outarg;
> +
> +       if (fc->lookup_handle && dir) {
> +               struct fuse_inode *fi =3D get_fuse_inode(dir);
> +
> +               args->opcode =3D FUSE_LOOKUP_HANDLE;
> +               if (fi && fi->fh) {
> +                       args->in_numargs =3D 4;
> +                       args->in_args[3].size =3D sizeof(*fi->fh) + fi->f=
h->size;
> +                       args->in_args[3].value =3D fi->fh;
> +               }
> +               args->out_argvar =3D true;
> +       }
>  }
>
>  /*
> @@ -240,7 +253,7 @@ static int fuse_dentry_revalidate(struct inode *dir, =
const struct qstr *name,
>
>                 attr_version =3D fuse_get_attr_version(fm->fc);
>
> -               fuse_lookup_init(fm->fc, &args, get_node_id(dir),
> +               fuse_lookup_init(fm->fc, &args, get_node_id(dir), dir,
>                                  name, outarg);
>                 ret =3D fuse_simple_request(fm, &args);
>                 /* Zero nodeid is same as -ENOENT */
> @@ -248,7 +261,8 @@ static int fuse_dentry_revalidate(struct inode *dir, =
const struct qstr *name,
>                         ret =3D -ENOENT;
>                 if (!ret) {
>                         fi =3D get_fuse_inode(inode);
> -                       if (outarg->nodeid !=3D get_node_id(inode) ||
> +                       if (!fuse_file_handle_is_equal(fm->fc, fi->fh, &o=
utarg->fh) ||
> +                           outarg->nodeid !=3D get_node_id(inode) ||
>                             (bool) IS_AUTOMOUNT(inode) !=3D (bool) (outar=
g->attr.flags & FUSE_ATTR_SUBMOUNT)) {
>                                 fuse_queue_forget(fm->fc, forget,
>                                                   outarg->nodeid, 1);
> @@ -365,8 +379,9 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
>         return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->siz=
e);
>  }
>
> -int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qs=
tr *name,
> -                    struct fuse_entry_out *outarg, struct inode **inode)
> +int fuse_lookup_name(struct super_block *sb, u64 nodeid, struct inode *d=
ir,
> +                    const struct qstr *name, struct fuse_entry_out *outa=
rg,
> +                    struct inode **inode)
>  {
>         struct fuse_mount *fm =3D get_fuse_mount_super(sb);
>         FUSE_ARGS(args);
> @@ -388,14 +403,15 @@ int fuse_lookup_name(struct super_block *sb, u64 no=
deid, const struct qstr *name
>         attr_version =3D fuse_get_attr_version(fm->fc);
>         evict_ctr =3D fuse_get_evict_ctr(fm->fc);
>
> -       fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
> +       fuse_lookup_init(fm->fc, &args, nodeid, dir, name, outarg);
>         err =3D fuse_simple_request(fm, &args);
>         /* Zero nodeid is same as -ENOENT, but with valid timeout */
> -       if (err || !outarg->nodeid)
> +       if (err < 0 || !outarg->nodeid) // XXX err =3D size if args->out_=
argvar =3D true
>                 goto out_put_forget;
>
>         err =3D -EIO;
> -       if (fuse_invalid_attr(&outarg->attr))
> +       if (fuse_invalid_attr(&outarg->attr) ||
> +           fuse_invalid_file_handle(fm->fc, &outarg->fh))
>                 goto out_put_forget;
>         if (outarg->nodeid =3D=3D FUSE_ROOT_ID && outarg->generation !=3D=
 0) {
>                 pr_warn_once("root generation should be zero\n");
> @@ -404,7 +420,8 @@ int fuse_lookup_name(struct super_block *sb, u64 node=
id, const struct qstr *name
>
>         *inode =3D fuse_iget(sb, outarg->nodeid, outarg->generation,
>                            &outarg->attr, ATTR_TIMEOUT(outarg),
> -                          attr_version, evict_ctr);
> +                          attr_version, evict_ctr,
> +                          &outarg->fh);
>         err =3D -ENOMEM;
>         if (!*inode) {
>                 fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
> @@ -440,14 +457,14 @@ static struct dentry *fuse_lookup(struct inode *dir=
, struct dentry *entry,
>                 return ERR_PTR(-ENOMEM);
>
>         locked =3D fuse_lock_inode(dir);
> -       err =3D fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_n=
ame,
> +       err =3D fuse_lookup_name(dir->i_sb, get_node_id(dir), dir, &entry=
->d_name,
>                                outarg, &inode);
>         fuse_unlock_inode(dir, locked);
>         if (err =3D=3D -ENOENT) {
>                 outarg_valid =3D false;
>                 err =3D 0;
>         }
> -       if (err)
> +       if (err < 0) // XXX err =3D size if args->out_argvar =3D true
>                 goto out_err;
>
>         err =3D -EIO;
> @@ -688,8 +705,16 @@ static int fuse_create_open(struct mnt_idmap *idmap,=
 struct inode *dir,
>         args.in_args[0].value =3D &inarg;
>         args.in_args[1].size =3D entry->d_name.len + 1;
>         args.in_args[1].value =3D entry->d_name.name;
> +       if (fm->fc->lookup_handle) {
> +               fi =3D get_fuse_inode(dir);
> +               if (fi->fh) {
> +                       args.in_numargs =3D 3;
> +                       args.in_args[2].size =3D sizeof(*fi->fh) + fi->fh=
->size;
> +                       args.in_args[3].value =3D fi->fh;
> +               }
> +       }
>         args.out_numargs =3D 2;
> -       args.out_args[0].size =3D sizeof(*outentry);
> +       args.out_args[0].size =3D sizeof(*outentry) + outentry->fh.size;
>         args.out_args[0].value =3D outentry;
>         /* Store outarg for fuse_finish_open() */
>         outopenp =3D &ff->args->open_outarg;
> @@ -707,6 +732,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>
>         err =3D -EIO;
>         if (!S_ISREG(outentry->attr.mode) || invalid_nodeid(outentry->nod=
eid) ||
> +           fuse_invalid_file_handle(fm->fc, &outentry->fh) ||
>             fuse_invalid_attr(&outentry->attr))
>                 goto out_free_outentry;
>
> @@ -714,7 +740,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>         ff->nodeid =3D outentry->nodeid;
>         ff->open_flags =3D outopenp->open_flags;
>         inode =3D fuse_iget(dir->i_sb, outentry->nodeid, outentry->genera=
tion,
> -                         &outentry->attr, ATTR_TIMEOUT(outentry), 0, 0);
> +                         &outentry->attr, ATTR_TIMEOUT(outentry), 0, 0,
> +                         &outentry->fh);
>         if (!inode) {
>                 flags &=3D ~(O_CREAT | O_EXCL | O_TRUNC);
>                 fuse_sync_release(NULL, ff, flags);
> @@ -828,9 +855,21 @@ static struct dentry *create_new_entry(struct mnt_id=
map *idmap, struct fuse_moun
>                 goto out_put_forget_req;
>         }
>
> +       if (fm->fc->lookup_handle) {
> +               struct fuse_inode *fi =3D get_fuse_inode(dir);
> +               int idx =3D args->in_numargs;
> +
> +               WARN_ON_ONCE(idx >=3D 4);
> +
> +               if (fi->fh) {

This assertion can be handled gracefully

                    if (fi->fh && !WARN_ON_ONCE(idx >=3D 4)) {

> +                       args->in_args[idx].size =3D sizeof(*fi->fh) + fi-=
>fh->size;
> +                       args->in_args[idx].value =3D fi->fh;
> +                       args->in_numargs++;
> +               }
> +       }
>         args->nodeid =3D get_node_id(dir);
>         args->out_numargs =3D 1;
> -       args->out_args[0].size =3D sizeof(*outarg);
> +       args->out_args[0].size =3D sizeof(*outarg) + outarg->fh.size;
>         args->out_args[0].value =3D outarg;
>
>         if (args->opcode !=3D FUSE_LINK) {
> @@ -845,14 +884,16 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
>                 goto out_free_outarg;
>
>         err =3D -EIO;
> -       if (invalid_nodeid(outarg->nodeid) || fuse_invalid_attr(&outarg->=
attr))
> +       if (invalid_nodeid(outarg->nodeid) || fuse_invalid_attr(&outarg->=
attr) ||
> +           fuse_invalid_file_handle(fm->fc, &outarg->fh))
>                 goto out_free_outarg;
>
>         if ((outarg->attr.mode ^ mode) & S_IFMT)
>                 goto out_free_outarg;
>
>         inode =3D fuse_iget(dir->i_sb, outarg->nodeid, outarg->generation=
,
> -                         &outarg->attr, ATTR_TIMEOUT(outarg), 0, 0);
> +                         &outarg->attr, ATTR_TIMEOUT(outarg), 0, 0,
> +                         &outarg->fh);
>         if (!inode) {
>                 fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
>                 kfree(outarg);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index d997fdcede9b..ad9477394e4b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -216,6 +216,8 @@ struct fuse_inode {
>          * so preserve the blocksize specified by the server.
>          */
>         u8 cached_i_blkbits;
> +
> +       struct fuse_file_handle *fh;
>  };
>
>  /** FUSE inode state bits */
> @@ -1065,6 +1067,26 @@ static inline int invalid_nodeid(u64 nodeid)
>         return !nodeid || nodeid =3D=3D FUSE_ROOT_ID;
>  }
>
> +static inline bool fuse_invalid_file_handle(struct fuse_conn *fc,
> +                                           struct fuse_file_handle *hand=
le)
> +{
> +       if (!fc->lookup_handle)
> +               return false;
> +
> +       return !handle->size || (handle->size >=3D FUSE_MAX_HANDLE_SZ);
> +}
> +
> +static inline bool fuse_file_handle_is_equal(struct fuse_conn *fc,
> +                                            struct fuse_file_handle *fh1=
,
> +                                            struct fuse_file_handle *fh2=
)
> +{
> +       if (!fc->lookup_handle || !fh2->size || // XXX more OPs without h=
andle
> +           ((fh1->size =3D=3D fh2->size) &&
> +            (!memcmp(fh1->handle, fh2->handle, fh1->size))))
> +               return true;
> +       return false;
> +}
> +
>  static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
>  {
>         return atomic64_read(&fc->attr_version);
> @@ -1096,7 +1118,10 @@ static inline struct fuse_entry_out *fuse_entry_ou=
t_alloc(struct fuse_conn *fc)
>  {
>         struct fuse_entry_out *entryout;
>
> -       entryout =3D kzalloc(sizeof(*entryout), GFP_KERNEL_ACCOUNT);
> +       entryout =3D kzalloc(sizeof(*entryout) + fc->max_handle_sz,
> +                          GFP_KERNEL_ACCOUNT);
> +       if (entryout)
> +               entryout->fh.size =3D fc->max_handle_sz;
>
>         return entryout;
>  }
> @@ -1143,10 +1168,11 @@ extern const struct dentry_operations fuse_dentry=
_operations;
>  struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>                         int generation, struct fuse_attr *attr,
>                         u64 attr_valid, u64 attr_version,
> -                       u64 evict_ctr);
> +                       u64 evict_ctr, struct fuse_file_handle *fh);
>
> -int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qs=
tr *name,
> -                    struct fuse_entry_out *outarg, struct inode **inode)=
;
> +int fuse_lookup_name(struct super_block *sb, u64 nodeid, struct inode *d=
ir,
> +                    const struct qstr *name, struct fuse_entry_out *outa=
rg,
> +                    struct inode **inode);
>
>  /**
>   * Send FORGET command
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 30ee37c29057..23b8e4932da8 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -95,6 +95,25 @@ static struct fuse_submount_lookup *fuse_alloc_submoun=
t_lookup(void)
>         return NULL;
>  }
>
> +/*
> + * XXX postpone this allocation and later use the real size instead of m=
ax
> + */
> +static bool fuse_inode_handle_alloc(struct super_block *sb,
> +                                   struct fuse_inode *fi)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn_super(sb);
> +
> +       fi->fh =3D NULL;
> +       if (fc->lookup_handle) {
> +               fi->fh =3D kzalloc(sizeof(*fi->fh) + fc->max_handle_sz,
> +                                GFP_KERNEL_ACCOUNT);
> +               if (!fi->fh)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static struct inode *fuse_alloc_inode(struct super_block *sb)
>  {
>         struct fuse_inode *fi;
> @@ -120,8 +139,15 @@ static struct inode *fuse_alloc_inode(struct super_b=
lock *sb)
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 fuse_inode_backing_set(fi, NULL);
>
> +       if (!fuse_inode_handle_alloc(sb, fi))
> +               goto out_free_dax;
> +
>         return &fi->inode;
>
> +out_free_dax:
> +#ifdef CONFIG_FUSE_DAX
> +       kfree(fi->dax);
> +#endif
>  out_free_forget:
>         kfree(fi->forget);
>  out_free:
> @@ -132,6 +158,7 @@ static struct inode *fuse_alloc_inode(struct super_bl=
ock *sb)
>  static void fuse_free_inode(struct inode *inode)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
>
>         mutex_destroy(&fi->mutex);
>         kfree(fi->forget);
> @@ -141,6 +168,9 @@ static void fuse_free_inode(struct inode *inode)
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 fuse_backing_put(fuse_inode_backing(fi));
>
> +       if (fc->lookup_handle)
> +               kfree(fi->fh);
> +
>         kmem_cache_free(fuse_inode_cachep, fi);
>  }
>
> @@ -465,7 +495,7 @@ static int fuse_inode_set(struct inode *inode, void *=
_nodeidp)
>  struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>                         int generation, struct fuse_attr *attr,
>                         u64 attr_valid, u64 attr_version,
> -                       u64 evict_ctr)
> +                       u64 evict_ctr, struct fuse_file_handle *fh)
>  {
>         struct inode *inode;
>         struct fuse_inode *fi;
> @@ -505,14 +535,29 @@ struct inode *fuse_iget(struct super_block *sb, u64=
 nodeid,
>         if (!inode)
>                 return NULL;
>
> +       fi =3D get_fuse_inode(inode);
> +       if (fc->lookup_handle && fh->size) {
> +               if (fi->fh->size =3D=3D 0) {
> +                       if (fh->size >=3D fc->max_handle_sz)
> +                               pr_warn("Truncating file handle size (%u)=
\n",
> +                                       fh->size);
> +                       fi->fh->size =3D fh->size < fc->max_handle_sz ?
> +                               fh->size : fc->max_handle_sz - 1;

I can't think of anything good that can come out of copying a truncated
handle. If server provides a handle that does not meet the agreed
max_handle_sz then it is an invalid handle.

> +                       memcpy(fi->fh->handle, fh->handle, fi->fh->size);
> +               } else
> +                       pr_warn("handle was already set (size: %u)\n",
> +                               fi->fh->size);
> +       }
>         if ((inode->i_state & I_NEW)) {
>                 inode->i_flags |=3D S_NOATIME;
>                 if (!fc->writeback_cache || !S_ISREG(attr->mode))
>                         inode->i_flags |=3D S_NOCMTIME;
>                 inode->i_generation =3D generation;
> +
>                 fuse_init_inode(inode, attr, fc);
>                 unlock_new_inode(inode);
> -       } else if (fuse_stale_inode(inode, generation, attr)) {
> +       } else if (fuse_stale_inode(inode, generation, attr) ||
> +                  !fuse_file_handle_is_equal(fc, fi->fh, fh)) {
>                 /* nodeid was reused, any I/O on the old inode should fai=
l */
>                 fuse_make_bad(inode);
>                 if (inode !=3D d_inode(sb->s_root)) {
> @@ -521,7 +566,6 @@ struct inode *fuse_iget(struct super_block *sb, u64 n=
odeid,
>                         goto retry;
>                 }
>         }
> -       fi =3D get_fuse_inode(inode);
>         spin_lock(&fi->lock);
>         fi->nlookup++;
>         spin_unlock(&fi->lock);
> @@ -1059,12 +1103,23 @@ static struct inode *fuse_get_root_inode(struct s=
uper_block *sb, unsigned int mo
>         attr.mode =3D mode;
>         attr.ino =3D FUSE_ROOT_ID;
>         attr.nlink =3D 1;
> -       return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0);
> +       return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0, NULL); // X=
XX
>  }
>
> +enum {
> +       HANDLE_TYPE_NODEID      =3D 0,
> +       HANDLE_TYPE_HANDLE      =3D 1,
> +};
> +
>  struct fuse_inode_handle {
> -       u64 nodeid;
> -       u32 generation;
> +       u32 type;
> +       union {
> +               struct {
> +                       u64 nodeid;
> +                       u32 generation;
> +               };
> +               struct fuse_file_handle fh;
> +       };
>  };
>

These changes belong in a different patch, so I will reply in a separate em=
ail.

Thanks,
Amir.

