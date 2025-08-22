Return-Path: <linux-fsdevel+bounces-58755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA4B31422
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B6D34E6686
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098462F4A1F;
	Fri, 22 Aug 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8dzwiuG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A12EA498;
	Fri, 22 Aug 2025 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855915; cv=none; b=qFlGMokRRwWwc7xuWrOfwt2IXQLqfvJ42g4BbGxiQAPOrYb8fIZzt7+uTEfQqrjVfzAdC2YMhoRyAj2Typ657gCX35zNQyuUqNkB7hQj7m7qqS41K6WZKyW4gYhouNDYLgzdGCsxVRlIEFAin5MF64m/oCcuZEE71dFmh52f7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855915; c=relaxed/simple;
	bh=1y89flJsXTKc2Wb35oysVI58lfHznxgrZjGDG4khb88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn4RuS3sqbbLEGFj3cYf4d4kLeyBl+kYnzkhJ8FyOum1RZ9jXKAT8VoRlBhlB8jo5JmqHS9VxixM3HYZuwZ0dEAn2n1KAkD6vjzTyUFFn9gfGkKVtoZb6+/1id1PNYZo8NJipLI3CaiZPL9H5Q8V336MnRorslbSSLBFbBLQR94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8dzwiuG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6197efa570eso3688086a12.1;
        Fri, 22 Aug 2025 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755855912; x=1756460712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cRCvGks0EFJYvJ71qS1eybI56GOiHuu7CXXJ2Si3fY=;
        b=f8dzwiuG5JnCOug+HE/Lr4EjZL7qzw0vB+LVJ2DhRJzwrLXW2m1b0lyrwfFmLpSvS7
         md2xgyxECvv3fqD5+vGq/mIn5errMD0XofmD6wP1c7zmDXeV0sX5O05pDrkhsK/9q6N1
         +du1LjFLUTdsJI3G0je5yERAEq+lFsNtHpx6l0UsUlUWr5zf7KkZmnAVrRR4/8rr9Ylc
         y4+cxFxCjm3AwvZjk3NeYA/rq2820zYCpT+x0pqVAvoN3HE3m7EvDt2pVUVJ72rC8opL
         QrxVV8b72axaZjmKFX3q8lSjSAk6hMZulanBH69y2WQ5m1aK05csbjqb5QzeJrjZ7yO0
         JvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855912; x=1756460712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cRCvGks0EFJYvJ71qS1eybI56GOiHuu7CXXJ2Si3fY=;
        b=a945FZH8nwVxIvb7DEPEY6F5juXIpxe/j6PXxTXO50XRgHqB6VpSU0gvkslP+F09tQ
         XqF24I72s7n0BvZojdW+TO4DqUJnjTzbTR0pPfL5AkZaM+0dN5XsNVTbQ+wRq1K61uNG
         /phrZyxbWjtXyPT2OIy6ViVmmsvZkII8BNSg0IapFth71dxbJj8fRoNgebujwc/ubkrS
         avDBrp/4sMwTUKK4fkBAzBAZ8uNHJSLsvDi1pXuyTerkrfJoHGaS2F5UoXIpO6QGbl2T
         ee9nF/m9FeIP7Nn639uFVux/ALsrD8smXZfVhv4OeueXVrkNYK6MddzY8MfzKNw8cpRI
         k8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeT7GbePba4IlayXzrLxEXT4GgZ+R2saKdr9ppBalt6GPShUT69BH723WZFxRxJhyDLOF8Gfr0F/t1mIHz@vger.kernel.org, AJvYcCXbdKJ3CY6Tzahw249hm7VYujH/llUUBf/NwQVi+hDuQ/CpVPRnsMdhyF058rlmJSrYyQSlVK3oy2wH6wP6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jiJca51e7wqfqVSS/xLFW5r+utik+UL6mur0vDWYoS3GSnth
	6hNER6t4WQ3E7UHMoFGJtECn+3jE7e9gj7Aky4f5gM+1ZT3XmFHpTcJrQ+DDXFtiRkC6tPY2hJy
	8sh2gS6cg5Q/2TfVn35tkqbNN3Oc1vkY=
X-Gm-Gg: ASbGncvYmIGKIQe/DODnQsnJYGmqIIIOJUiRbg0sN84NG1gCGd8mXi4PS0+nfO3MLjU
	tXT+G9DdDfTBFOhFuDcdfp42lezf95xph4ef4mhtQLrB5eAI9kBUspg0xOfqK3z8KQhGqs1ftW2
	8XCfKAvr7wMaw0zshMxrxvsccRlCtgccuMy+PFNVtsUKsFsMe5WqNYtver6QazwPQAuu7S8djAl
	tsJ1zc=
X-Google-Smtp-Source: AGHT+IFYrMscDooAcGybTNEBnrNhnjtULycCiZWX0/rP6f7EZG3KSr5AR001ZxTVI9zpqgqATWp/dTYNB4F2Ip7AcbA=
X-Received: by 2002:a05:6402:270c:b0:61b:fabb:6d0e with SMTP id
 4fb4d7f45d1cf-61c1b705498mr1888374a12.19.1755855911313; Fri, 22 Aug 2025
 02:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822000818.1086550-1-neil@brown.name> <20250822000818.1086550-16-neil@brown.name>
In-Reply-To: <20250822000818.1086550-16-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Aug 2025 11:44:59 +0200
X-Gm-Features: Ac12FXx4q8rcAWzzkDZg6nP32TbSIW3WC2cWFhSpc3JVjEE-jAEJ8E4i5eJZ6Bc
Message-ID: <CAOQ4uxgbv8as-m7P9Az41nZiOBPLN0znW4xu1HSqpuCN1=Tp4Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] VFS: introduce start_removing_dentry()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:11=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> start_removing_dentry() is similar to start_removing() but instead of
> providing a name for lookup, the target dentry is given.
>
> start_removing_dentry() checks that the dentry is still hashed and in
> the parent, and if so it locks and increases the refcount so that
> end_dirop() can be used to finish the operation.
>
> This is used in cachefiles, overlayfs, smb/server and apparmor.
>
> There will be other users including ecryptfs.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/interface.c      | 14 +++++++++-----
>  fs/cachefiles/namei.c          | 22 ++++++++++++----------
>  fs/cachefiles/volume.c         | 10 +++++++---
>  fs/namei.c                     | 29 +++++++++++++++++++++++++++++
>  fs/overlayfs/dir.c             | 10 ++++------
>  fs/overlayfs/readdir.c         |  8 ++++----
>  fs/smb/server/vfs.c            | 27 ++++-----------------------
>  include/linux/namei.h          |  2 ++
>  security/apparmor/apparmorfs.c |  8 ++++----
>  9 files changed, 75 insertions(+), 55 deletions(-)
>
> diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
> index 3e63cfe15874..763d7d55b1f9 100644
> --- a/fs/cachefiles/interface.c
> +++ b/fs/cachefiles/interface.c
> @@ -9,6 +9,7 @@
>  #include <linux/mount.h>
>  #include <linux/xattr.h>
>  #include <linux/file.h>
> +#include <linux/namei.h>
>  #include <linux/falloc.h>
>  #include <trace/events/fscache.h>
>  #include "internal.h"
> @@ -428,11 +429,14 @@ static bool cachefiles_invalidate_cookie(struct fsc=
ache_cookie *cookie)
>                 if (!old_tmpfile) {
>                         struct cachefiles_volume *volume =3D object->volu=
me;
>                         struct dentry *fan =3D volume->fanout[(u8)cookie-=
>key_hash];
> -
> -                       inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> -                       cachefiles_bury_object(volume->cache, object, fan=
,
> -                                              old_file->f_path.dentry,
> -                                              FSCACHE_OBJECT_INVALIDATED=
);
> +                       struct dentry *obj;
> +
> +                       obj =3D start_removing_dentry(fan, old_file->f_pa=
th.dentry);
> +                       if (!IS_ERR(obj))
> +                               cachefiles_bury_object(volume->cache, obj=
ect,
> +                                                      fan, obj,
> +                                                      FSCACHE_OBJECT_INV=
ALIDATED);
> +                       end_dirop(obj);
>                 }
>                 fput(old_file);
>         }
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index ddced50afb66..cc6dccd606ea 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -424,13 +424,12 @@ int cachefiles_delete_object(struct cachefiles_obje=
ct *object,
>
>         _enter(",OBJ%x{%pD}", object->debug_id, object->file);
>
> -       /* Stop the dentry being negated if it's only pinned by a file st=
ruct. */
> -       dget(dentry);
> -
> -       inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
> -       ret =3D cachefiles_unlink(volume->cache, object, fan, dentry, why=
);
> -       inode_unlock(d_backing_inode(fan));
> -       dput(dentry);
> +       dentry =3D start_removing_dentry(fan, dentry);
> +       if (IS_ERR(dentry))
> +               ret =3D PTR_ERR(dentry);
> +       else
> +               ret =3D cachefiles_unlink(volume->cache, object, fan, den=
try, why);
> +       end_dirop(dentry);
>         return ret;
>  }
>
> @@ -643,9 +642,12 @@ bool cachefiles_look_up_object(struct cachefiles_obj=
ect *object)
>
>         if (!d_is_reg(dentry)) {
>                 pr_err("%pd is not a file\n", dentry);
> -               inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> -               ret =3D cachefiles_bury_object(volume->cache, object, fan=
, dentry,
> -                                            FSCACHE_OBJECT_IS_WEIRD);
> +               struct dentry *de =3D start_removing_dentry(fan, dentry);
> +               if (!IS_ERR(de))
> +                       ret =3D cachefiles_bury_object(volume->cache, obj=
ect,
> +                                                    fan, de,
> +                                                    FSCACHE_OBJECT_IS_WE=
IRD);
> +               end_dirop(de);
>                 dput(dentry);
>                 if (ret < 0)
>                         return false;
> diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
> index 781aac4ef274..8c29f3db3fae 100644
> --- a/fs/cachefiles/volume.c
> +++ b/fs/cachefiles/volume.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/fs.h>
>  #include <linux/slab.h>
> +#include <linux/namei.h>
>  #include "internal.h"
>  #include <trace/events/fscache.h>
>
> @@ -58,9 +59,12 @@ void cachefiles_acquire_volume(struct fscache_volume *=
vcookie)
>                 if (ret < 0) {
>                         if (ret !=3D -ESTALE)
>                                 goto error_dir;
> -                       inode_lock_nested(d_inode(cache->store), I_MUTEX_=
PARENT);
> -                       cachefiles_bury_object(cache, NULL, cache->store,=
 vdentry,
> -                                              FSCACHE_VOLUME_IS_WEIRD);
> +                       vdentry =3D start_removing_dentry(cache->store, v=
dentry);
> +                       if (!IS_ERR(vdentry))
> +                               cachefiles_bury_object(cache, NULL, cache=
->store,
> +                                                      vdentry,
> +                                                      FSCACHE_VOLUME_IS_=
WEIRD);
> +                       end_dirop(vdentry);
>                         cachefiles_put_directory(volume->dentry);
>                         cond_resched();
>                         goto retry;
> diff --git a/fs/namei.c b/fs/namei.c
> index 34895487045e..af56bc39c4d5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3261,6 +3261,35 @@ struct dentry *start_removing_noperm(struct dentry=
 *parent,
>  }
>  EXPORT_SYMBOL(start_removing_noperm);
>
> +/**
> + * start_removing_dentry - prepare to remove a given dentry
> + * @parent - directory from which dentry should be removed
> + * @child - the dentry to be removed
> + *
> + * A lock is taken to protect the dentry again other dirops and
> + * the validity of the dentry is checked: correct parent and still hashe=
d.
> + *
> + * If the dentry is valid a reference is taken and returned.  If not
> + * an error is returned.
> + *
> + * end_dirop() should be called when removal is complete, or aborted.
> + *
> + * Returns: the valid dentry, or an error.
> + */
> +struct dentry *start_removing_dentry(struct dentry *parent,
> +                                    struct dentry *child)
> +{
> +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> +       if (unlikely(IS_DEADDIR(parent->d_inode) ||
> +                    child->d_parent !=3D parent ||
> +                    d_unhashed(child))) {
> +               inode_unlock(parent->d_inode);
> +               return ERR_PTR(-EINVAL);
> +       }
> +       return dget(child);
> +}
> +EXPORT_SYMBOL(start_removing_dentry);
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
>  {
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 70b8687dc45e..b8f0d409e841 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -47,14 +47,12 @@ static int ovl_cleanup_locked(struct ovl_fs *ofs, str=
uct inode *wdir,
>  int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
>                 struct dentry *wdentry)
>  {
> -       int err;
> -
> -       err =3D ovl_parent_lock(workdir, wdentry);
> -       if (err)
> -               return err;
> +       wdentry =3D start_removing_dentry(workdir, wdentry);
> +       if (IS_ERR(wdentry))
> +               return PTR_ERR(wdentry);
>
>         ovl_cleanup_locked(ofs, workdir->d_inode, wdentry);
> -       ovl_parent_unlock(workdir);
> +       end_dirop(wdentry);
>
>         return 0;
>  }
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index b65cdfce31ce..20348be4b98f 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1158,11 +1158,11 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struc=
t dentry *parent,
>         if (!d_is_dir(dentry) || level > 1)
>                 return ovl_cleanup(ofs, parent, dentry);
>
> -       err =3D ovl_parent_lock(parent, dentry);
> -       if (err)
> -               return err;
> +       dentry =3D start_removing_dentry(parent, dentry);
> +       if (IS_ERR(dentry))
> +               return PTR_ERR(dentry);
>         err =3D ovl_do_rmdir(ofs, parent->d_inode, dentry);
> -       ovl_parent_unlock(parent);
> +       end_dirop(dentry);
>         if (err) {
>                 struct path path =3D { .mnt =3D mnt, .dentry =3D dentry }=
;
>

I'm sorry I keep nagging about this semantic point, but when I request
that code remains "balanced", I mean "balanced to a human eye".

If we are going to delegate reviews to LLM, then we can feed LLM
the documentation that says which start_ pairs with which end_
and go on to our retirement plans, but as long as I need to review
code, I need a human readable signal about what pairs with what.

Therefore, IMO it is better to have semantic wrappers
end_removing(), end_creating(), than having to rely on humans
to understand that  start_removing_dentry() pairs with end_dirop().

Alternatively, use start_dirop_remove*, start_dirop_create*,
so it is clear that they can all match end_dirop() (can they???).

And repeating my request again: I will insist for overlayfs patches
but I think it is a good practice for all of your patches -
Please keep the code balance by introducing start_ together
with end_ in the same patch, so that it is clear from context of
a single patch review, that the callers were converted correctly.
Otherwise, the only way to verify that is to review the end result
and that is not the idea of a patch series.

Thanks,
Amir.

