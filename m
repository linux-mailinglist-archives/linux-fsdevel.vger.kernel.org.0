Return-Path: <linux-fsdevel+bounces-64618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57B0BEE338
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BC2189E9F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1622E54A1;
	Sun, 19 Oct 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuQfnF4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173652BD58A
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870386; cv=none; b=pxysHTC2xTBAS3p6A9ULo2gYhQvskhu6sezO24emZ5xrogTXoaQBsPDDVnOKR2yX8m+hAosbto37wm6cJr04K+4Y322x2NSKd0wwKIHJeZlZbOPovf4tOcd2PDRgQ6kWMy3kPQG5lB9F8bEk3fYWC4OjAdleuznVh63609viVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870386; c=relaxed/simple;
	bh=aaixIVVWqKRM1ujh3Wh6PxUpLh9xi+cawmH1VCcardY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vj0vzNG5kPDF0ROVX9zes/EkEzjOQQYjHj4n7Tset0NRu97E/1txud3aa6ien8KXJQNh4JwwGEYkJeGO6mAwBe8EAMeCdaSB4qyBxKAXbSvN9kiH1KtKP02hhEzeRaGLnnLzsfcsihtRtiRUWPd8/xo+npA4CkPsZwm9ypAcu0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuQfnF4w; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so3339184a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760870383; x=1761475183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d70CmlwD7XvLPcS6xE6ZlduXc+b2/hJrtGNwer1vGX4=;
        b=UuQfnF4wgkqj1HksZWOyKwAKBsllWboqvFNqBoDX3HuE7lzwgbWgzrd+jSvY2KiFs9
         AoNddzU/jxKZVwDs+L7rQ5kxa1g5u97um7i+lVoCU5r9+tg9mAJ5g23WIn027JeZTa73
         LeGb98YqZ7+sGd0ngk1fJEfIFUK/wHPfTlhH/x3BfcNclzAHg1Gb5LbJAtsSJjtIT+eg
         IPdugh+EaJ0U24orDIOl3O802e26rupBF4FnB1+G1/DJ4Ehpk0Y31X//PPpk9apMMjEh
         H4P2eIU9V7Ir8rxYBehyVlQ7se7+UktSw1mFO5SQMh5/fZbbg1W+nI8dIhqoxvJi8j/M
         FBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760870383; x=1761475183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d70CmlwD7XvLPcS6xE6ZlduXc+b2/hJrtGNwer1vGX4=;
        b=AzydGf2OPK2QtguBDX0h6yGyizYgLf2NscsizuquMBcs1zRxRK+8e8dg37lm+rluAZ
         Epod9xFnAPLLLa8F6XE/wEZNv01go3t9QkWOijDILca65MGGqFDYQxJVdtAXRGlXziH7
         j2qx1kmWoLkksS80iHWyCH8/Bs1oWUnePL373xTQcyrHXdJPMNwQlUFl1CwH2OTuHfeE
         5rZE1bwIqMrEQ/BMiOc0xuz6tTiV5d72TdzS7aCNz7Nz7mdCjGib9hSODH38K2U+yqVP
         ITQl5MygzGaAZzY+aEXx/0H9BJpL/9DvOaJGRU0UjSydmmjpkp8Dil9voDaVUa7p/b4G
         jycA==
X-Forwarded-Encrypted: i=1; AJvYcCUcW4mL6TqxiCdxHSF0gH63LPHShhk5JCotrWeZ7K7iVxK31TEWrDHLr4nzyKva/9Y7WVZZkm707ogJnvMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaQBTbPC/yr3pgJk6wlSbFwM1QuzonNUvNdVZAsBJKMdO7vzf
	IWxCX/FKJ3V+UP8/S6gv1dqm/6JTCGpsrmsr85soPEz5C7AVhRTyFHakAeXzu4OYv1sYR3lAENh
	6zatugvrkvKO1mxtPvprMKcCbwxEx54U=
X-Gm-Gg: ASbGncsGqJnJtG6Nx2ezKfXzuqmqujuHDdary7MKhYLpNmN6wIXzyoiWqkPz4zRA+U/
	cRb9TqJWitThSLzNzhM6jQCj1/olczyi7e+V+zXwomNhQXAwsCYwB8AyjoV1LssoMFITfxJeYjW
	8ojt1Jjx98wW51KkAOkLK9Bi56CEqGP8o6ohYd2OebLGwBSDOFFRWfnDauMH2e7bRT88XYRWrVU
	v/G3jke6JO9tFofYgxdyN46ObvICbCMSli0O1o6k8KpYtz4cMSSgY7YoAwRAQOXb9OfYLRXXuzf
	Wc/mH0j+EOxhrMkgQP9H8KDn5gJYoA==
X-Google-Smtp-Source: AGHT+IG32tkEKaVz2poPu0Jiu/dQVodqvPzOb3K1FFp83fuarMmL7WaG1XdV9eNNSGKMqy2Rbog64/K3GnPZhfMvD+4=
X-Received: by 2002:a05:6402:5191:b0:63c:4f1e:6d82 with SMTP id
 4fb4d7f45d1cf-63c4f1e73acmr4523556a12.24.1760870383238; Sun, 19 Oct 2025
 03:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-15-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-15-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:39:31 +0200
X-Gm-Features: AS18NWBvxFt-mdTUtF9ormJUoA1AyGvhBf2TGf0xIy8x7PMiF8v7w-Wj_xSYbXA
Message-ID: <CAOQ4uxggvXyrHzAb2rHjdgJsNgrQy+gJYCeOitCkfQxefb6-oQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] VFS: introduce end_creating_keep()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:49=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Occasionally the caller of end_creating() wants to keep using the dentry.
> Rather then requiring them to dget() the dentry (when not an error)
> before calling end_creating(), provide end_creating_keep() which does
> this.
>
> cachefiles and overlayfs make use of this.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Thanks for adding this cleanup patch!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/cachefiles/namei.c |  3 +--
>  fs/overlayfs/dir.c    |  8 ++------
>  fs/overlayfs/super.c  | 11 +++--------
>  include/linux/namei.h | 22 ++++++++++++++++++++++
>  4 files changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 10f010dc9946..5c50293328f4 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -155,8 +155,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>
>         /* Tell rmdir() it's not allowed to delete the subdir */
>         inode_lock(d_inode(subdir));
> -       dget(subdir);
> -       end_creating(subdir);
> +       end_creating_keep(subdir);
>
>         if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
>                 pr_notice("cachefiles: Inode already in use: %pd (B=3D%lx=
)\n",
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 00dc797f2da7..cadbb47c6225 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -251,10 +251,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, s=
truct dentry *workdir,
>         if (IS_ERR(ret))
>                 return ret;
>         ret =3D ovl_create_real(ofs, workdir, ret, attr);
> -       if (!IS_ERR(ret))
> -               dget(ret);
> -       end_creating(ret);
> -       return ret;
> +       return end_creating_keep(ret);
>  }
>
>  static int ovl_set_opaque_xerr(struct dentry *dentry, struct dentry *upp=
er,
> @@ -364,8 +361,7 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>         if (IS_ERR(newdentry))
>                 return PTR_ERR(newdentry);
>
> -       dget(newdentry);
> -       end_creating(newdentry);
> +       end_creating_keep(newdentry);
>
>         if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
>             !ovl_allow_offline_changes(ofs)) {
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 3acda985c8a3..7b8fc1cab6eb 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -319,8 +319,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>                 };
>
>                 if (work->d_inode) {
> -                       dget(work);
> -                       end_creating(work);
> +                       end_creating_keep(work);
>                         if (persist)
>                                 return work;
>                         err =3D -EEXIST;
> @@ -336,9 +335,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>                 }
>
>                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> -               if (!IS_ERR(work))
> -                       dget(work);
> -               end_creating(work);
> +               end_creating_keep(work);
>                 err =3D PTR_ERR(work);
>                 if (IS_ERR(work))
>                         goto out_err;
> @@ -630,9 +627,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl=
_fs *ofs,
>                 if (!child->d_inode)
>                         child =3D ovl_create_real(ofs, parent, child,
>                                                 OVL_CATTR(mode));
> -               if (!IS_ERR(child))
> -                       dget(child);
> -               end_creating(child);
> +               end_creating_keep(child);
>         }
>         dput(parent);
>
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 0ef73d739a31..3d82c6a19197 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -125,6 +125,28 @@ static inline void end_creating(struct dentry *child=
)
>         end_dirop(child);
>  }
>
> +/* end_creating_keep - finish action started with start_creating() and r=
eturn result
> + * @child: dentry returned by start_creating() or vfs_mkdir()
> + *
> + * Unlock and return the child. This can be called after
> + * start_creating() whether that function succeeded or not,
> + * but it is not needed on failure.
> + *
> + * If vfs_mkdir() was called then the value returned from that function
> + * should be given for @child rather than the original dentry, as vfs_mk=
dir()
> + * may have provided a new dentry.
> + *
> + * Returns: @child, which may be a dentry or an error.
> + *
> + */
> +static inline struct dentry *end_creating_keep(struct dentry *child)
> +{
> +       if (!IS_ERR(child))
> +               dget(child);
> +       end_dirop(child);
> +       return child;
> +}
> +
>  /**
>   * end_removing - finish action started with start_removing
>   * @child:  dentry returned by start_removing()
> --
> 2.50.0.107.gf914562f5916.dirty
>

