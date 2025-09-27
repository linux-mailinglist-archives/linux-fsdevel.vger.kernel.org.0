Return-Path: <linux-fsdevel+bounces-62928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482AEBA5C68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75380322EE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B22D6E6D;
	Sat, 27 Sep 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez18PoJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA43027A915
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965578; cv=none; b=WwtyzOE1u6HYKxSC/FmxeM9bN9j6vjTCo3wlrxG6f++nyh/FPnqt5uuVL28MHY2LyOt2joKcVlSFgYkUi6aAEjKsiMUqu8ZRfvSJ5X7LH1BAT1FTS/XGrXEkUpCOjVCu9orN+ylIHx4yEhOCY7qPGqe3d7DGaGiWwbDrHBzql/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965578; c=relaxed/simple;
	bh=CO5m4cLrG2+yVfi9kCECmd36TWgS5MqYOZDAJh2EK74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2v7C7K3FSyG7G3zSTsu5xwirnChkRHmWoCuW9netNovki6Y4q0WXWRVOjdJtHckHvXC0OCHlMciCh23v2NHl3WCbjgjjqtLPhlXXbVTcmDo2ZYpgswZnd7YaUsuXJP9dynGltPPLhuacdk/T98NpBoABX+KfAdI0M1WZ7k/Bac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez18PoJa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so32155666b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758965575; x=1759570375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji45xUPyfqa5zi3fNN63Tmd98w4J8dDZo8/EHIN4yTw=;
        b=Ez18PoJazJYJi60bGR2SrNpfCZH0pnx6EDOYIUMdLddvixIfXrgPdWYaTKNmuatEXa
         ElXemJ3svvPBzMlaWaEGyu9aSEyufyIu7bMMmF+aCAN3/lMbr/4ivTuqs9dbWncBwYVl
         UKsaAvqETE94fRd5eqkmLvqg10/WtCyJOandqXNvn14u1WkefWypp0hxW3Pi1u55z/kz
         eLjePJAS/YKacp1Mfb2i7Fs5ripyLGuDPDtmPNNV1nVszNy6aZFX77RY+b4oxJoE7g+a
         BiLC1ivSbVySvAHNZeqvcHzrkvKC6niZgYrsNv8eTaN9sAvKTNKq7rNOH9ubyyQi0hyW
         ynpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965575; x=1759570375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji45xUPyfqa5zi3fNN63Tmd98w4J8dDZo8/EHIN4yTw=;
        b=kmUbDtFOsOTCqWbkMsYqa0/ecyD86r+g1sQks1YFt+QemutOAkMvKt0m5MDMery3KF
         UudUl+boaC1HlTSgv7NGNmMLBK91w3ZFIJtrz3/kDQ1NVqKLXk/HsDgOe7sW5yJeTxVq
         QPDkJawWtZR8X4CRMBNeMriVOLTA/u0gpFiI42ZAUp2tGgerCWKoFUUuCE4Mc3K6Zmii
         U2+whb49Ymyu9FQCTYRWocwBOjM0RxX5yaYto/kLRxtY2yjSVeC0i+7VxmkuxXLXuWu8
         fQj5oQaJWmcZqDQvP9f/jOjD1wA3tz/YiFPHKPsBonkR/Yc/1CT81rQtrv2gv3VqT9vU
         n2ow==
X-Forwarded-Encrypted: i=1; AJvYcCVwht7tCQc3mv9cszmJue+cXNsyRvU2Y/wIqKoeO96dGLiqp+sIZfU72V5EICVixbHp6BNn2JrusOE2O9gP@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLruEMSpVQS0486pNwITyLY56K6tHaPGt5OyPBQ4tzCAb0Nql
	qtAuISPjcT2MJ4OOV8Tl3KFtJQHsAWjCTxMG1u5XE6Stqc9mOcKby7Pv6qjjh9xOyDAqY2xX3RZ
	g494XxqzYc5E/Fkox53byatGh/0EO9KI=
X-Gm-Gg: ASbGncuEWE6nJmP55x4C1H/evaKWmaS08o9jIGPkSfcitzkvNlv35lbvtiPf5s9d7vg
	2iJD7C9W75q+f3gCA/0T/N01vtxt5B0BG2xQagHLj1hMpKJO4yJa+okbBXVIclN8g463dOrm+CW
	r3gHO+8KdePfGi5jnL+QAJ7lmO6Z+gN7/9AyR8RF9TrJi74qS+p2yEiS7v10cJdI/7bnLtQGKIT
	xR3jiOlcgdXJbSXjmD34hoWC1FINMlxLjB5hOALLw==
X-Google-Smtp-Source: AGHT+IGGaAqyavAf9FyigW2ZV45B9n6ik7+CoLJFud0e+a7RZYB27/pMMgt7EhbEm5Xa1olVKPiV6CCkl1jEtufYgcA=
X-Received: by 2002:a17:907:7f0e:b0:ae6:d47a:105d with SMTP id
 a640c23a62f3a-b34bcd592ddmr1172308566b.55.1758965574851; Sat, 27 Sep 2025
 02:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-7-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-7-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Sep 2025 11:32:43 +0200
X-Gm-Features: AS18NWCeK9LhIAJS5LUkRLZSWnYE6wD8wrmxSOqhjz21mq7wj5H3fBujCISdRWc
Message-ID: <CAOQ4uxjq9+9DgEsmB=PS95CN+j0ft8sr4n70FtoeKPTAcJG-rA@mail.gmail.com>
Subject: Re: [PATCH 06/11] VFS: introduce start_removing_dentry()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> start_removing_dentry() is similar to start_removing() but instead of
> providing a name for lookup, the target dentry is given.
>
> start_removing_dentry() checks that the dentry is still hashed and in
> the parent, and if so it locks and increases the refcount so that
> end_removing() can be used to finish the operation.
>
> This is used in cachefiles, overlayfs, smb/server, and apparmor.
>
> There will be other users including ecryptfs.
>
> As start_removing_dentry() takes an extra reference to the dentry (to be
> put by end_removing()), there is no need to explicitly take an extra
> reference to stop d_delete() from using dentry_unlink_inode() to negate
> the dentry - as in cachefiles_delete_object(), and ksmbd_vfs_unlink().
>
> Signed-off-by: NeilBrown <neil@brown.name>

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

After answering/fixing the questions below...

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
> index 3e63cfe15874..3f8a6f1a8fc3 100644
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
> +                       end_removing(obj);
>                 }
>                 fput(old_file);
>         }
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 3064d439807b..80a3055d8ae5 100644
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
> +       end_removing(dentry);
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

I see that other callers do not check return value from
cachefiles_bury_object(), but this call site does.
Shouldn't we treat this error as well (assign it to ret)?

Thanks,
Amir.

> +                       ret =3D cachefiles_bury_object(volume->cache, obj=
ect,
> +                                                    fan, de,
> +                                                    FSCACHE_OBJECT_IS_WE=
IRD);
> +               end_removing(de);
>                 dput(dentry);
>                 if (ret < 0)
>                         return false;
> diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
> index 781aac4ef274..ddf95ff5daf0 100644
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
> +                       end_removing(vdentry);
>                         cachefiles_put_directory(volume->dentry);
>                         cond_resched();
>                         goto retry;
> diff --git a/fs/namei.c b/fs/namei.c
> index bd5c45801756..cb4d40af12ae 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3344,6 +3344,35 @@ struct dentry *start_removing_noperm(struct dentry=
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
> + * end_removing() should be called when removal is complete, or aborted.
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
> index c4057b4a050d..74b1ef5860a4 100644
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
> +       end_removing(wdentry);
>
>         return 0;
>  }
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 15cb06fa0c9a..213ff42556e7 100644
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
> +       end_removing(dentry);
>         if (err) {
>                 struct path path =3D { .mnt =3D mnt, .dentry =3D dentry }=
;
>
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 1cfa688904b2..56b755a05c4e 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -48,24 +48,6 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work =
*work,
>         i_uid_write(inode, i_uid_read(parent_inode));
>  }
>
> -/**
> - * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
> - * @parent: parent dentry
> - * @child: child dentry
> - *
> - * Returns: %0 on success, %-ENOENT if the parent dentry is not stable
> - */
> -int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
> -{
> -       inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> -       if (child->d_parent !=3D parent) {
> -               inode_unlock(d_inode(parent));
> -               return -ENOENT;
> -       }
> -
> -       return 0;
> -}
> -
>  static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
>                                  char *pathname, unsigned int flags,
>                                  struct path *path, bool do_lock)
> @@ -1083,18 +1065,17 @@ int ksmbd_vfs_unlink(struct file *filp)
>                 return err;
>
>         dir =3D dget_parent(dentry);
> -       err =3D ksmbd_vfs_lock_parent(dir, dentry);
> -       if (err)
> +       dentry =3D start_removing_dentry(dir, dentry);
> +       err =3D PTR_ERR(dentry);
> +       if (IS_ERR(dentry))
>                 goto out;
> -       dget(dentry);
>
>         if (S_ISDIR(d_inode(dentry)->i_mode))
>                 err =3D vfs_rmdir(idmap, d_inode(dir), dentry);
>         else
>                 err =3D vfs_unlink(idmap, d_inode(dir), dentry, NULL);
>
> -       dput(dentry);
> -       inode_unlock(d_inode(dir));
> +       end_removing(dentry);
>         if (err)
>                 ksmbd_debug(VFS, "failed to delete, err %d\n", err);
>  out:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 20a88a46fe92..32a007f1043e 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -94,6 +94,8 @@ struct dentry *start_removing(struct mnt_idmap *idmap, =
struct dentry *parent,
>                               struct qstr *name);
>  struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
> +struct dentry *start_removing_dentry(struct dentry *parent,
> +                                    struct dentry *child);
>
>  /* end_creating - finish action started with start_creating
>   * @child - dentry returned by start_creating()
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index 391a586d0557..9d08d103f142 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -355,17 +355,17 @@ static void aafs_remove(struct dentry *dentry)
>         if (!dentry || IS_ERR(dentry))
>                 return;
>
> +       /* ->d_parent is stable as rename is not supported */
>         dir =3D d_inode(dentry->d_parent);
> -       inode_lock(dir);
> -       if (simple_positive(dentry)) {
> +       dentry =3D start_removing_dentry(dentry->d_parent, dentry);
> +       if (!IS_ERR(dentry) && simple_positive(dentry)) {
>                 if (d_is_dir(dentry))
>                         simple_rmdir(dir, dentry);
>                 else
>                         simple_unlink(dir, dentry);
>                 d_delete(dentry);
> -               dput(dentry);
>         }
> -       inode_unlock(dir);
> +       end_removing(dentry);
>         simple_release_fs(&aafs_mnt, &aafs_count);
>  }
>
> --
> 2.50.0.107.gf914562f5916.dirty
>

