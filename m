Return-Path: <linux-fsdevel+bounces-57233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E5B1FA61
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E79D171DA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB326563F;
	Sun, 10 Aug 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9nvOkW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEF263F28;
	Sun, 10 Aug 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754835722; cv=none; b=AoU8xdMeFkJcwLAsfXbsPiX3vRWLJUjkQ2T+Jlvni69JQXlifLvdZlBkfAmIR7d49MzskmVaXT4L8ZBMqCVEkuobmcKRLF2M9l1GdxkDZnO6Yokv2sxyaCEba5USZeD+9AVT5IVUvfIARsSd6Tgp7zhzUZN1/7l41McA3Mh/N6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754835722; c=relaxed/simple;
	bh=DdiQcHRwyquR6v552g2NZenAkCQ7jkgO3wG4/V1Qi6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9ULlho/Qhsx2bqsTDneQdpVHVaz19Xn9+DMHw0wluaVlmMjfJdNZrv5PxsgZRerI02bJATTdUtQ513ycLXbSQx2YzG3HKlGB4y2RtRnmGu825KLTJXlF2v+1iFRVds7Z8PURqepcuohnd/loFiJaqGUJN1TdWty9lz0+lEWHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9nvOkW4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61530559887so5743522a12.1;
        Sun, 10 Aug 2025 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754835719; x=1755440519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oux9dWjWWokZwIvBQhPVdzqfDwYpAaNUcn761YUOVMw=;
        b=h9nvOkW4KNm/fvRw/hPxM5EeQpECe7jeUCSPYgR7yGxi2cBYy3cIBUAiBH9CUqkWNC
         OUL4Cq1Weq30xw/633pJ3MKx2/qi6d860IfnwhpRh2ZN49mMzRySP2k1DOLvgYa21YOy
         bAT1IOVLnClRwDp0yQZ2JgIDM3iqXak9EpS3GeyLvaMDMHJQuRVTfbCzS2cE+q4EMnWz
         +ggyDNuld44BE6COXVL+uL9zpOgirHjr2AYljP/gUhkkglToP8cZwA17Bc6sUl3YHS0F
         u+L9U+tXLNDqrnFIRUfiGSEnGsodDIj7FYjLlESHRkLaobdWhLIqabK47RF74eoHgDVi
         QkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754835719; x=1755440519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oux9dWjWWokZwIvBQhPVdzqfDwYpAaNUcn761YUOVMw=;
        b=rr12iN/HNlS4qG9GO8/DMJ1NkWSlUJqKdiKYAwpcZYQT6nrs1muAqZFXP64Q0sd4I9
         /vZ+AkOIiMhyt1iR5sPGeAFphr0RJxdWhfi/SE5V7fZVRHb2LyJm1yzxYnHv4fDsq75b
         rObG1Fd41BXhvw72IL3Im7nHlIbYz8loa9UF4ZmdFh71BdNX1nczQ9/j28sDVXhBLCAo
         BhyfEerElgjjIJkZs0qEEPe0eFHujUY9JUh/IhEHX6y809mgG4V2L4TfKk4aGC0lEIXP
         hKsmEVtpUToguXSodLnTjnMUDydh+aA4s8xF3xGxDzvJKuI+fASl8powch3NmJ3P0Sja
         r0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWfwyx6Rfltpa96Ere1T39plXMJR9erl5isi7MbxEjUGOTZJIRsuHLtTlDl80AuUtcBOSghWZBExj3eFw3b@vger.kernel.org, AJvYcCXzxmujhZjhFPOrOquxyR6gIRQciZL0h9mPBwc+YRn6QW+vxpqUzAUlQ6GDz3rttS2Z1XVT2at4cmZf6icZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgzdFQT7aVNHHF/qWpbvQe+Nwp2raaE41f3op4GRjVTSWpP6M
	HUPmAfbhdBdnT1w+KXqSBik1HpVPqGBgk273g7HjmdiPDvdngK4CYAGXkq7CMO8hbG1EekuqGV4
	Nz0MXeCjSJ9PSZk358mnF6amH1alvsWQ=
X-Gm-Gg: ASbGncsIKh4/Q8DGhVHNearySZ6dJXxrFdQ/XPrV45d2SWK5y/sKMtF6OKGCpmzKAPq
	hHxq74fohvTs0X1oxvg+18fnksWBvl1rXA8riI3dGGryl8C1XT2Zwp82zy8a7UO9L+Upxqiq6OF
	WAfBZL6oGKmCpv0X7YDeqESstAbNhLAdGxcHjUpOIBkbR+is6k50KaR3sfskQWI57IT9q+ja/3u
	Kxi02UTtJiM228MnA==
X-Google-Smtp-Source: AGHT+IGsdD+DwgIluNqYcI7EXrh65Uaym08qPEl5/enIgMmWqByBRKYdkdEV8HemKof6S+gjFOFYjWL3fLOhykxVdQ8=
X-Received: by 2002:a17:907:7e86:b0:ad4:d00f:b4ca with SMTP id
 a640c23a62f3a-af9c651238dmr790569666b.50.1754835718327; Sun, 10 Aug 2025
 07:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
 <20250804173228.1990317-1-paullawrence@google.com> <20250804173228.1990317-2-paullawrence@google.com>
In-Reply-To: <20250804173228.1990317-2-paullawrence@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 10 Aug 2025 16:21:47 +0200
X-Gm-Features: Ac12FXzbVLtxvfVooXpogJhXWNYeFxCg11qJYKA2qrDXhqqv2pTc2nCtijJo3tQ
Message-ID: <CAOQ4uxgNjDuitnAn1np29nB7WfDbEkN3K8oOPUc7wH7A+UfuuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Allow backing file to be set at lookup (WIP)
To: Paul Lawrence <paullawrence@google.com>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:32=E2=80=AFPM Paul Lawrence <paullawrence@google.c=
om> wrote:
>
> Add optional extra outarg to FUSE_LOOKUP which holds a backing id to set
> a backing file at lookup.
>
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> ---
>  fs/fuse/dir.c             | 23 ++++++++++++++++++----
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/iomode.c          | 41 +++++++++++++++++++++++++++++++++++----
>  fs/fuse/passthrough.c     | 40 +++++++++++++++++++++++++++++---------
>  include/uapi/linux/fuse.h |  4 ++++
>  5 files changed, 94 insertions(+), 17 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 62508d212826..c0bef93dd078 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -170,7 +170,8 @@ static void fuse_invalidate_entry(struct dentry *entr=
y)
>
>  static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *arg=
s,
>                              u64 nodeid, const struct qstr *name,
> -                            struct fuse_entry_out *outarg)
> +                            struct fuse_entry_out *outarg,
> +                            struct fuse_entry_passthrough_out *backing)
>  {
>         memset(outarg, 0, sizeof(struct fuse_entry_out));
>         args->opcode =3D FUSE_LOOKUP;
> @@ -184,6 +185,12 @@ static void fuse_lookup_init(struct fuse_conn *fc, s=
truct fuse_args *args,
>         args->out_numargs =3D 1;
>         args->out_args[0].size =3D sizeof(struct fuse_entry_out);
>         args->out_args[0].value =3D outarg;
> +       if (backing) {
> +               args->out_numargs =3D 2;
> +               args->out_args[1].size =3D sizeof(struct fuse_entry_passt=
hrough_out);
> +               args->out_args[1].value =3D backing;
> +               args->out_argvar =3D true;
> +       }
>  }
>
>  /*
> @@ -236,7 +243,7 @@ static int fuse_dentry_revalidate(struct inode *dir, =
const struct qstr *name,
>                 attr_version =3D fuse_get_attr_version(fm->fc);
>
>                 fuse_lookup_init(fm->fc, &args, get_node_id(dir),
> -                                name, &outarg);
> +                                name, &outarg, NULL);
>                 ret =3D fuse_simple_request(fm, &args);
>                 /* Zero nodeid is same as -ENOENT */
>                 if (!ret && !outarg.nodeid)
> @@ -369,6 +376,7 @@ int fuse_lookup_name(struct super_block *sb, u64 node=
id, const struct qstr *name
>         struct fuse_forget_link *forget;
>         u64 attr_version, evict_ctr;
>         int err;
> +       struct fuse_entry_passthrough_out passthrough;
>
>         *inode =3D NULL;
>         err =3D -ENAMETOOLONG;
> @@ -384,10 +392,10 @@ int fuse_lookup_name(struct super_block *sb, u64 no=
deid, const struct qstr *name
>         attr_version =3D fuse_get_attr_version(fm->fc);
>         evict_ctr =3D fuse_get_evict_ctr(fm->fc);
>
> -       fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
> +       fuse_lookup_init(fm->fc, &args, nodeid, name, outarg, &passthroug=
h);
>         err =3D fuse_simple_request(fm, &args);
>         /* Zero nodeid is same as -ENOENT, but with valid timeout */
> -       if (err || !outarg->nodeid)
> +       if (err < 0 || !outarg->nodeid)

Why this change?

>                 goto out_put_forget;
>
>         err =3D -EIO;
> @@ -406,6 +414,13 @@ int fuse_lookup_name(struct super_block *sb, u64 nod=
eid, const struct qstr *name
>                 fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
>                 goto out;
>         }
> +
> +       // TODO check that if fuse_backing is already set they are consis=
tent
> +       if (args.out_args[1].size && !get_fuse_inode(*inode)->fb) {

This check is not atomic.
fuse_inode_set_passthrough() already does nothing if
fuse_inode_passthrough() is already set.

> +               err =3D fuse_inode_set_passthrough(*inode, passthrough.ba=
cking_id);
> +               if (err)
> +                       goto out;

This needs to queue forget + iput.

> +       }
>         err =3D 0;
>
>   out_put_forget:
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 1e8e732a2f09..aebd338751f1 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1595,9 +1595,12 @@ ssize_t fuse_passthrough_splice_read(struct file *=
in, loff_t *ppos,
>  ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
>                                       struct file *out, loff_t *ppos,
>                                       size_t len, unsigned int flags);
> +struct fuse_backing *fuse_backing_id_get(struct fuse_conn *fc, int backi=
ng_id);
>  ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *=
vma);
>  int fuse_passthrough_readdir(struct file *file, struct dir_context *ctx)=
;
>
> +int fuse_inode_set_passthrough(struct inode *inode, int backing_id);
> +
>  static inline struct fuse_backing *fuse_inode_passthrough(struct fuse_in=
ode *fi)
>  {
>  #ifdef CONFIG_FUSE_PASSTHROUGH
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index f46dfa040e53..4c23ae640624 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -166,6 +166,37 @@ static void fuse_file_uncached_io_release(struct fus=
e_file *ff,
>         fuse_inode_uncached_io_end(fi);
>  }
>
> +/* Setup passthrough for inode operations without an open file */
> +int fuse_inode_set_passthrough(struct inode *inode, int backing_id)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_backing *fb;
> +       int err;
> +
> +       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough_ino)
> +               return 0;
> +
> +       /* backing inode is set once for the lifetime of the inode */
> +       if (fuse_inode_passthrough(fi))
> +               return 0;
> +
> +       fb =3D fuse_backing_id_get(fc, backing_id);
> +       err =3D PTR_ERR(fb);
> +       if (IS_ERR(fb))
> +               goto fail;
> +
> +       fi->fb =3D fb;
> +       set_bit(FUSE_I_PASSTHROUGH, &fi->state);
> +       fi->iocachectr--;

These need a lock. My patch calls fuse_inode_uncached_io_start()
Why did you change that?

My patch also requires a minimal passthrough op:

        /* Backing inode requires at least GETATTR op passthrough */
        err =3D -EOPNOTSUPP;
        if (!(fb->ops_mask & FUSE_PASSTHROUGH_OP(FUSE_GETATTR)))
                goto fail;

Why did you remove this? it seems sane to me not to ever have to deal
with inode attr cache when setting up passthrough to inode operations.

I've split my patch to prep patch that adds those helpers and the demo API.
push to branch fuse_passthrough_iops on my github.
Please use the prep patch as is without changing the helper functions
unless you have a good reason to change them and document this reason.

> +       return 0;
> +
> +fail:
> +       pr_debug("failed to setup backing inode (ino=3D%lu, backing_id=3D=
%d, err=3D%i).\n",
> +                inode->i_ino, backing_id, err);
> +       return err;
> +}
> +
>  /*
>   * Open flags that are allowed in combination with FOPEN_PASSTHROUGH.
>   * A combination of FOPEN_PASSTHROUGH and FOPEN_DIRECT_IO means that rea=
d/write
> @@ -185,8 +216,10 @@ static int fuse_file_passthrough_open(struct inode *=
inode, struct file *file)
>         int err;
>
>         /* Check allowed conditions for file open in passthrough mode */
> -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough ||
> -           (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK))
> +       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough)
> +               return -EINVAL;
> +
> +       if (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK && !fuse_inode_backi=
ng(get_fuse_inode(inode)))

I don't understand this condition.
If there is already a backing inode, then open_flags are ignored?
This does not make sense to me.
What is the reason to make this change?

>                 return -EINVAL;
>
>         fb =3D fuse_passthrough_open(file, inode,
> @@ -224,8 +257,8 @@ int fuse_file_io_open(struct file *file, struct inode=
 *inode)
>          * which is already open for passthrough.
>          */
>         err =3D -EINVAL;
> -       if (fuse_inode_backing(fi) && !(ff->open_flags & FOPEN_PASSTHROUG=
H))
> -               goto fail;
> +       if (fuse_inode_backing(fi))
> +               ff->open_flags |=3D FOPEN_PASSTHROUGH;

I agree that it makes some sense for an inode in passthrough mode
to imply FOPEN_PASSTHROUGH, as long as FOPEN_DIRECT_IO
is not cleared, but what do we really gain from making this flag implicit?
If a server is setting up backing inodes, what's the problem with keeping
existing API and requiring the server to use explicit FOPEN_PASSTHROUGH
flag for the inodes that it had mapped?
I understand that you want the server to be able to use backing_id 0
for open for simplicity in this case?
Nevertheless, I see no reason to drop the flag.

>
>         /*
>          * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index de6ece996ff8..cee40e1c6e4a 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -229,7 +229,6 @@ static int fuse_backing_id_free(int id, void *p, void=
 *data)
>  {
>         struct fuse_backing *fb =3D p;
>
> -       WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);

Why remove this assertion?
Did you change the refcounting rules?
Why? and if so, please document the change.

>         fuse_backing_free(fb);
>         return 0;
>  }
> @@ -348,6 +347,29 @@ int fuse_backing_close(struct fuse_conn *fc, int bac=
king_id)
>         return err;
>  }
>
> +/*
> + * Get fuse backing object by backing id.
> + *
> + * Returns an fb object with elevated refcount to be stored in fuse inod=
e.
> + */
> +struct fuse_backing *fuse_backing_id_get(struct fuse_conn *fc, int backi=
ng_id)
> +{
> +       struct fuse_backing *fb;
> +
> +       if (backing_id <=3D 0)
> +               return ERR_PTR(-EINVAL);
> +
> +       rcu_read_lock();
> +       fb =3D idr_find(&fc->backing_files_map, backing_id);
> +       fb =3D fuse_backing_get(fb);
> +       rcu_read_unlock();
> +
> +       if (!fb)
> +               return ERR_PTR(-ENOENT);
> +
> +       return fb;
> +}
> +
>  /*
>   * Setup passthrough to a backing file.
>   *
> @@ -363,18 +385,18 @@ struct fuse_backing *fuse_passthrough_open(struct f=
ile *file,
>         struct file *backing_file;
>         int err;
>
> -       err =3D -EINVAL;
> -       if (backing_id <=3D 0)
> -               goto out;
> -
>         rcu_read_lock();
> -       fb =3D idr_find(&fc->backing_files_map, backing_id);
> +       if (backing_id <=3D 0) {
> +               err =3D -EINVAL;
> +               fb =3D fuse_inode_backing(get_fuse_inode(inode));
> +       } else {
> +               err =3D -ENOENT;
> +               fb =3D idr_find(&fc->backing_files_map, backing_id);
> +       }
>         fb =3D fuse_backing_get(fb);
> -       rcu_read_unlock();
> -
> -       err =3D -ENOENT;

Maybe you are over complicating this?

My patch replaced all of the above with:

       fb =3D fuse_backing_id_get(fc, backing_id);
       if (IS_ERR(fb)) {
               err =3D PTR_ERR(fb);
               fb =3D NULL;
        }

I think you want something like:

       if (!backing_id) {
               fb =3D fuse_backing_get(fuse_inode_passthrough(fi));
       } else {
               fb =3D fuse_backing_id_get(fc, backing_id);
       }
       if (IS_ERR_OR_NULL(fb)) {
               err =3D fb ? PTR_ERR(fb) : -ENOENT;
               fb =3D NULL;
       }

But also, that is a separate API change.
You should do it in its own patch that documents the change
and not in the same patch that implements the backing inode
setup on lookup response.

My patches added fuse_inode_passthrough() exactly so you can
write code that checks if inode has permanent backing inode
*before* you add the API to make this association.

Thanks,
Amir.

