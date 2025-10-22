Return-Path: <linux-fsdevel+bounces-65102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFB3BFC095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1C7B3534D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D126ED35;
	Wed, 22 Oct 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0j/Wlj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530726ED24
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138535; cv=none; b=ERBWU8JlHr/ksoVaAf5XgMbBTd145aiNlYHrXpfwYfrKQNC3bFmiOdh0rRvm7pb8MzkuodU9A3dftw7ea1ekGg+w7CaV+5ur4vThRVT9hNvs+XkkcDvTNHi9HfBbDmGZBE3ezth3vCg3eNgHAgC2/ix/379gz0mu4zUC9tSf6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138535; c=relaxed/simple;
	bh=Nw4nVDETtI8PMJkIIMMhLzgnwTq8xBjwvNi22mDe/L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeGqUcwbWuChCjO7Pf6fo9dQRASajZbrrZhL3Z4KzyEXU/2WHJ+n5/dgJyJkPVnOaF5PaqgN1f55/KByprLVqmMKnirARo9myIBf/PgV0fyuQO9n7rm2E74yHSUTSxK5hP1iYluMqoiVp5e1uXUgGwGRZn8tA4P3GqUcy1q9izQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0j/Wlj3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso236036366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761138532; x=1761743332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ06bY4uDinK9AkSONcJcZ97BJMGXA71Ws4veNulHvU=;
        b=i0j/Wlj3+j5xpt9YN7u/Q9znkeRhcF99/DlAow8n5Djkv69cmioy4taedGMl+BfxC/
         YPJLKPdeYRvAfU8kyiX4/uN8OdiML3eZhqsOKlyAu+tFoxCRRtUYe+sqXb1kE0djBCPU
         69MdxGqIFUUQMdhR08xPMeDoezux0u1Z3ejfZcNp9dAJ9xiNGI8PjDkf4ncjoI9vDE+K
         kmv7uqpEkprpV6/yqdIZ/x3MV+AEtG1wGedPIP+6UkuC63OpuImAqAqTBPYhlzI4cUiv
         2G2G85JeKaa8rW8KAofMLF0rGw/bx6LMuX7BP48+i7W7Fh1SoxjqLwq/XdT+YkLL6q33
         nobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138532; x=1761743332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ06bY4uDinK9AkSONcJcZ97BJMGXA71Ws4veNulHvU=;
        b=DWkjxfP7GGp6/PHAGutEhNW/oB+O1k3Y77AzBIjTuBnyZrDTV84BgOI02uVejjRkgi
         /FQTfFMhWDG+0iKVkEWYXuxP3wJ8oYG0VEsFcEjzPi7DaYUBtP1OuifsFI9Z3N/gJlwl
         JdGQGN09huzmnqJNsh1Tq2oTZI0T00r9OQDC0lVzA0ToFVAMEWJFR6pYK6AeGyAmZDC+
         TG/aI2CkJzTBhYuYB6VGau03ORsoNzeiIWWeITouwx5no7VW6PtUjy/vheVxSZdIhUGx
         2ZkOLzSfmDz9QVKfBu5MGVXDKfo8h2zID2gdFBu02+duw5vuNAZRr04FPqBx+2bXSHYA
         swnw==
X-Forwarded-Encrypted: i=1; AJvYcCUsNo697FsFOq/K/+9Tp7YGWylHoSnh4RWvTAgf16cXviGnuF75rbjKqcjbpTdNAiDVGZURKzRhds5AYiCG@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkKFGNTU3wg9A35+7M4ZT5Jc29Bvz4SLo2tnDpXzHwfQQDA+K
	+8srGrx3l8g7J1rIItdqJq07hYROwBZJvs+YJNvRnmWXxURYqVMvI2KPAlzDgMqxt9MKDsv6sSw
	GtOY4WgeCcRL2m84RUO8WEmrRaQKw6Dk=
X-Gm-Gg: ASbGnctHosnaFZU2+RJoTo8PvKYsCJ0tzJxnbselHwZ6Y9ASCvvsLahPowJtF3cJ8gu
	Hy6vR3jykKfo+WbSipYlUJ5RGxJ63KKLdQc4uOqYrfrdj5bQtAeBuM9I2rU9mxvo2J0pCmb15E6
	IXPqtlWTzReoNw2v1SYIyTKGTGHr0A8ddPjeRQ3d7HidSbt15l+Ce32CZgpXeumgilsSXtG9QYV
	Kv/IFXoQRkU4iKW2+NAemjYrWYqG2IEnZkpqEtUg9Qu8JZm7EHtRhTGpmk6W5ikOTCrMwIFOMYj
	/n5FJrLw/UbPK5oauM30s6jQWkDf2w==
X-Google-Smtp-Source: AGHT+IHbpA7c5CkZVUQ4+N0nVqiYOJux6DhA2L9nOeH+D73PNsrs16fCJsCJqc6Y4AgOVHzYpUCZqfAGEe4HQ4noZ68=
X-Received: by 2002:a17:906:9f8c:b0:b40:5463:3afd with SMTP id
 a640c23a62f3a-b6473147238mr2437844266b.26.1761138531188; Wed, 22 Oct 2025
 06:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022044545.893630-1-neilb@ownmail.net> <20251022044545.893630-12-neilb@ownmail.net>
In-Reply-To: <20251022044545.893630-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Oct 2025 15:08:38 +0200
X-Gm-Features: AS18NWAMWYfEjj-nm8I1V7GBBJytJmykzCrYE6pb-b2M65wlOutrXKjKediRFOI
Message-ID: <CAOQ4uxg0RHDQLYD0WuiASdj5N0_Zt_aAA+dO_Uu3w6aigqEmSA@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] Add start_renaming_two_dentries()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> A few callers want to lock for a rename and already have both dentries.
> Also debugfs does want to perform a lookup but doesn't want permission
> checking, so start_renaming_dentry() cannot be used.
>
> This patch introduces start_renaming_two_dentries() which is given both
> dentries.  debugfs performs one lookup itself.  As it will only continue
> with a negative dentry and as those cannot be renamed or unlinked, it is
> safe to do the lookup before getting the rename locks.
>
> overlayfs uses start_renaming_two_dentries() in three places and  selinux
> uses it twice in sel_make_policy_nodes().
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/debugfs/inode.c           | 48 ++++++++++++--------------
>  fs/namei.c                   | 65 ++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/dir.c           | 42 +++++++++++++++--------
>  include/linux/namei.h        |  2 ++
>  security/selinux/selinuxfs.c | 27 ++++++++++-----
>  5 files changed, 135 insertions(+), 49 deletions(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index f241b9df642a..532bd7c46baf 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -842,7 +842,8 @@ int __printf(2, 3) debugfs_change_name(struct dentry =
*dentry, const char *fmt, .
>         int error =3D 0;
>         const char *new_name;
>         struct name_snapshot old_name;
> -       struct dentry *parent, *target;
> +       struct dentry *target;
> +       struct renamedata rd =3D {};
>         struct inode *dir;
>         va_list ap;
>
> @@ -855,36 +856,31 @@ int __printf(2, 3) debugfs_change_name(struct dentr=
y *dentry, const char *fmt, .
>         if (!new_name)
>                 return -ENOMEM;
>
> -       parent =3D dget_parent(dentry);
> -       dir =3D d_inode(parent);
> -       inode_lock(dir);
> +       rd.old_parent =3D dget_parent(dentry);
> +       rd.new_parent =3D rd.old_parent;
> +       rd.flags =3D RENAME_NOREPLACE;
> +       target =3D lookup_noperm_unlocked(&QSTR(new_name), rd.new_parent)=
;
> +       if (IS_ERR(target))
> +               return PTR_ERR(target);
>
> -       take_dentry_name_snapshot(&old_name, dentry);
> -
> -       if (WARN_ON_ONCE(dentry->d_parent !=3D parent)) {
> -               error =3D -EINVAL;
> -               goto out;
> -       }
> -       if (strcmp(old_name.name.name, new_name) =3D=3D 0)
> -               goto out;
> -       target =3D lookup_noperm(&QSTR(new_name), parent);
> -       if (IS_ERR(target)) {
> -               error =3D PTR_ERR(target);
> -               goto out;
> -       }
> -       if (d_really_is_positive(target)) {
> -               dput(target);
> -               error =3D -EINVAL;
> +       error =3D start_renaming_two_dentries(&rd, dentry, target);
> +       if (error) {
> +               if (error =3D=3D -EEXIST && target =3D=3D dentry)
> +                       /* it isn't an error to rename a thing to itself =
*/
> +                       error =3D 0;
>                 goto out;
>         }
> -       simple_rename_timestamp(dir, dentry, dir, target);
> -       d_move(dentry, target);
> -       dput(target);
> +
> +       dir =3D d_inode(rd.old_parent);
> +       take_dentry_name_snapshot(&old_name, dentry);
> +       simple_rename_timestamp(dir, dentry, dir, rd.new_dentry);
> +       d_move(dentry, rd.new_dentry);
>         fsnotify_move(dir, dir, &old_name.name, d_is_dir(dentry), NULL, d=
entry);
> -out:
>         release_dentry_name_snapshot(&old_name);
> -       inode_unlock(dir);
> -       dput(parent);
> +       end_renaming(&rd);
> +out:
> +       dput(rd.old_parent);
> +       dput(target);
>         kfree_const(new_name);
>         return error;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 5153ceddd37a..4a4b8b96c192 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3877,6 +3877,71 @@ int start_renaming_dentry(struct renamedata *rd, i=
nt lookup_flags,
>  }
>  EXPORT_SYMBOL(start_renaming_dentry);
>
> +/**
> + * start_renaming_two_dentries - Lock to dentries in given parents for r=
ename
> + * @rd:           rename data containing parent
> + * @old_dentry:   dentry of name to move
> + * @new_dentry:   dentry to move to
> + *
> + * Ensure locks are in place for rename and check parentage is still cor=
rect.
> + *
> + * On success the two dentries are stored in @rd.old_dentry and
> + * @rd.new_dentry and @rd.old_parent and @rd.new_parent are confirmed to
> + * be the parents of the dentries.
> + *
> + * References and the lock can be dropped with end_renaming()
> + *
> + * Returns: zero or an error.
> + */
> +int
> +start_renaming_two_dentries(struct renamedata *rd,
> +                           struct dentry *old_dentry, struct dentry *new=
_dentry)
> +{
> +       struct dentry *trap;
> +       int err;
> +
> +       /* Already have the dentry - need to be sure to lock the correct =
parent */
> +       trap =3D lock_rename_child(old_dentry, rd->new_parent);
> +       if (IS_ERR(trap))
> +               return PTR_ERR(trap);
> +       err =3D -EINVAL;
> +       if (d_unhashed(old_dentry) ||
> +           (rd->old_parent && rd->old_parent !=3D old_dentry->d_parent))
> +               /* old_dentry was removed, or moved and explicit parent r=
equested */
> +               goto out_unlock;
> +       if (d_unhashed(new_dentry) ||
> +           rd->new_parent !=3D new_dentry->d_parent)
> +               /* new_dentry was removed or moved */
> +               goto out_unlock;
> +
> +       if (old_dentry =3D=3D trap)
> +               /* source is an ancestor of target */
> +               goto out_unlock;
> +
> +       if (new_dentry =3D=3D trap) {
> +               /* target is an ancestor of source */
> +               if (rd->flags & RENAME_EXCHANGE)
> +                       err =3D -EINVAL;
> +               else
> +                       err =3D -ENOTEMPTY;
> +               goto out_unlock;
> +       }
> +
> +       err =3D -EEXIST;
> +       if (d_is_positive(new_dentry) && (rd->flags & RENAME_NOREPLACE))
> +               goto out_unlock;
> +
> +       rd->old_dentry =3D dget(old_dentry);
> +       rd->new_dentry =3D dget(new_dentry);
> +       rd->old_parent =3D dget(old_dentry->d_parent);
> +       return 0;
> +
> +out_unlock:
> +       unlock_rename(old_dentry->d_parent, rd->new_parent);
> +       return err;
> +}
> +EXPORT_SYMBOL(start_renaming_two_dentries);
> +
>  void end_renaming(struct renamedata *rd)
>  {
>         unlock_rename(rd->old_parent, rd->new_parent);
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 3c5cb665d530..b1f2c940e585 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -123,6 +123,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, stru=
ct dentry *dir,
>                              struct dentry *dentry)
>  {
>         struct dentry *whiteout;
> +       struct renamedata rd =3D {};
>         int err;
>         int flags =3D 0;
>
> @@ -134,10 +135,13 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>         if (d_is_dir(dentry))
>                 flags =3D RENAME_EXCHANGE;
>
> -       err =3D ovl_lock_rename_workdir(ofs->workdir, whiteout, dir, dent=
ry);

Missed a spot:
       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);

> +       rd.old_parent =3D ofs->workdir;
> +       rd.new_parent =3D dir;
> +       rd.flags =3D flags;
> +       err =3D start_renaming_two_dentries(&rd, whiteout, dentry);
>         if (!err) {
> -               err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, d=
entry, flags);
> -               unlock_rename(ofs->workdir, dir);
> +               err =3D ovl_do_rename_rd(&rd);
> +               end_renaming(&rd);
>         }

This, not surprisingly, is crashing when running ovl sanity tests.

Thanks,
Amir.

