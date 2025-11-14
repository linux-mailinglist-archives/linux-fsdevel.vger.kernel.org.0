Return-Path: <linux-fsdevel+bounces-68439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1DC5C2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 954774E8432
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D33019B8;
	Fri, 14 Nov 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAnCxmde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0765303C9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111053; cv=none; b=mP5P15itZIFCV2dZkalW2oFIDzVtAQetmhB6hKWDzyVgvNhC7ajoifLq0dH+8whA3x2BdN9ga/JzckO45J0KyymmwEJK8UXXaafC3vY8RX7KmYtQhNXiyJPcIETtiAJs3AUoToT0mrSOTWbCQrJupDeaN8DYONO75SY4/NH7atA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111053; c=relaxed/simple;
	bh=HYQnY5wfvU5n/qDo8Hsdka9XFrb9KyLh+3RBQpxz8nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itkU6aEgx0jahVYGptUlL7T8Ao0HERsC4T/PP4oMaJpxP8RlXdD7JnUOGUAthap+F73/PycamS5+jbXC+kmxDsv1pyp5TpeasUFYnNjkzbKGWIoC0IY5unupX4Fwtsfd2JiCADt8mUTQpV/oNYa9rjISLAx11gGraqY6LyP1A4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAnCxmde; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so2460086a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 01:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111049; x=1763715849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Goa/xKjWBdY+53zyoaLs4oJnsl4iRvXwgrMVx7vmWhU=;
        b=GAnCxmdejgYatIu6nTrMd9Nqt60TNAXC9ULiamkk7/0m9K3mpiev9ScaFnZhlf5EW1
         s29NKCykwG1Mp928XHqFXqDzmA7mEBUwMI3bAZavwVPM1P8hbfZb/igVSc5P/WDCXLeJ
         yG3D+7SwdW+4ioP11nmfTlydkIslvbCvBNmUwjL5fn2kbQdc9zl5BEmukTxn6AaJFY7x
         5v7o/on/Be0cOae0lgBB99YdeEOskYiJnWkx+XfI7fJgFX3XAKWKz7z538wG7kMZIb84
         koKbQnFPXkpG5/B6bzyEOr2UciEimW+WY1R8AG8/kqCLa3E0/rKUDZm/8I15l1XctnCh
         irNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111049; x=1763715849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Goa/xKjWBdY+53zyoaLs4oJnsl4iRvXwgrMVx7vmWhU=;
        b=KaY6gixg7ZPbaqH/aLwJyhvaZ6UNfq0dqui2xtR8/6F+6mnTBItSB68xZwC/L6KBss
         Yw9A7SU/ap9Wg8i1VGLgXTxl27CG61gkO0LCy94yvhhoq9z9kOrF88AEc9KiMyVuYTBh
         tlL9kvqoieILok1zG7gbDbUyTnqpxA9FxhQd4fueQ5OOwMaOj6Rnk1wS6E/4dSeHinEt
         xEyk2bjGoB37wLuFpUksnb2tpf4XjrhZ/Od2YOUbFnGRjYDuTW3lKjI953SaLzRWVqwU
         wS1QvrWhdDu3LYr6Nm+ioSCp3N9FEgzFX9H9jE1scVb1LV8wXbsybjLDsl4tF/RXdBnU
         7R+w==
X-Forwarded-Encrypted: i=1; AJvYcCWEDZWVUJngjI+RZfHtO19Qa9nBOEn2K8s1Tej2YQmx19Zz6asViA4lR+cdPl+sG5ypWFVFr6bmdGNJudQc@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYgNHlbZswmdrYCXHiYj/lz7oG5VlVY4gFyvgPsuU6cmXjcbN
	SzvpfQzlog61JnXFHYua09WbuhtJvz/0vaxVxfV8ArFW8ueslETokWtOVRkL5NyyBlieXAOoY+/
	s7zxl+47LZaQP5HTfW2N88f/fCwz4tng=
X-Gm-Gg: ASbGncvwA0IZNQSXOuBI2KrKUndE/jvhKUfcxIdi1QsdpxAM0AzzYLUtpBPvbIxGO6R
	EOPvySosoCRNPcWqBjqpLjFwfnQJabtSCi+kQRhdgmVMFw+dli7HQSkNsIk5SUTX0y4+VEt6jqi
	iIhHeG3uZl2MrVyiIHLFj6roA041hnV8OlM16fuU4G2G+HixtOmVlvSHnVuX7ug4DbptUZDQWLO
	FeX8hBNLg4RFg+5XylnGtByr8a4cqIkZgRSkShFhNOSb217MyhQSaBrFkMTkVdtEFISJTXFmxOG
	3acVnKVzZel9NjzbjGs=
X-Google-Smtp-Source: AGHT+IEoSfiUPRbBIuHs1Fo99u8PUyiMQRsyZYzU/qT81CcAry04l1AUAcRuL6UYkRhZG1uL1kXUA/frbT/v0g4zqxA=
X-Received: by 2002:a05:6402:1d4d:b0:641:7a6b:c849 with SMTP id
 4fb4d7f45d1cf-64350e8d765mr1888058a12.17.1763111049013; Fri, 14 Nov 2025
 01:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org> <20251113-work-ovl-cred-guard-v3-34-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-34-b35ec983efc1@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 10:03:56 +0100
X-Gm-Features: AWmQ_bk8iW-0REZJl59Nul7AEbbC8-mZBXZZvsGILoYrUPbsC4stoJyEwIaHT8s
Message-ID: <CAOQ4uxgumgfM1GVE1oMiiN=aW3RBxM67OZGfVE+7e2qW6Ne_jw@mail.gmail.com>
Subject: Re: [PATCH v3 34/42] ovl: extract do_ovl_rename() helper function
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:33=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Extract the code that runs under overridden credentials into a separate
> do_ovl_rename() helper function. Error handling is simplified. The
> helper returns errors directly instead of using goto labels.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

For the record, the only way I could review this patch is by manually
moving the helper and doing diff, so while I approve the code
I think this is unreviewable as it is posted.

>  fs/overlayfs/dir.c | 277 +++++++++++++++++++++++++++--------------------=
------
>  1 file changed, 140 insertions(+), 137 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 052929b9b99d..0812bb4ee4f6 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1099,107 +1099,28 @@ struct ovl_renamedata {
>         bool overwrite;
>  };
>
> -static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
> -                     struct dentry *old, struct inode *newdir,
> -                     struct dentry *new, unsigned int flags)
> +static int do_ovl_rename(struct ovl_renamedata *ovlrd, struct list_head =
*list)
>  {
> -       int err;
> -       struct dentry *old_upperdir;
> -       struct dentry *new_upperdir;
> -       struct dentry *trap, *de;
> -       bool old_opaque;
> -       bool new_opaque;
> -       bool update_nlink =3D false;
> +       struct dentry *old =3D ovlrd->old_dentry;
> +       struct dentry *new =3D ovlrd->new_dentry;
> +       struct ovl_fs *ofs =3D OVL_FS(old->d_sb);
> +       unsigned int flags =3D ovlrd->flags;
> +       struct dentry *old_upperdir =3D ovl_dentry_upper(ovlrd->old_paren=
t);
> +       struct dentry *new_upperdir =3D ovl_dentry_upper(ovlrd->new_paren=
t);
> +       bool samedir =3D ovlrd->old_parent =3D=3D ovlrd->new_parent;
>         bool is_dir =3D d_is_dir(old);
>         bool new_is_dir =3D d_is_dir(new);
> -       const struct cred *old_cred =3D NULL;
> -       struct ovl_fs *ofs =3D OVL_FS(old->d_sb);
> -       struct ovl_renamedata ovlrd =3D {
> -               .old_parent             =3D old->d_parent,
> -               .old_dentry             =3D old,
> -               .new_parent             =3D new->d_parent,
> -               .new_dentry             =3D new,
> -               .flags                  =3D flags,
> -               .cleanup_whiteout       =3D false,
> -               .overwrite              =3D !(flags & RENAME_EXCHANGE),
> -       };
> -       LIST_HEAD(list);
> -       bool samedir =3D ovlrd.old_parent =3D=3D ovlrd.new_parent;
> -
> -       err =3D -EINVAL;
> -       if (ovlrd.flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
> -               goto out;
> -
> -       ovlrd.flags &=3D ~RENAME_NOREPLACE;
> -
> -       /* Don't copy up directory trees */
> -       err =3D -EXDEV;
> -       if (!ovl_can_move(old))
> -               goto out;
> -       if (!ovlrd.overwrite && !ovl_can_move(new))
> -               goto out;
> -
> -       if (ovlrd.overwrite && new_is_dir && !ovl_pure_upper(new)) {
> -               err =3D ovl_check_empty_dir(new, &list);
> -               if (err)
> -                       goto out;
> -       }
> -
> -       if (ovlrd.overwrite) {
> -               if (ovl_lower_positive(old)) {
> -                       if (!ovl_dentry_is_whiteout(new)) {
> -                               /* Whiteout source */
> -                               ovlrd.flags |=3D RENAME_WHITEOUT;
> -                       } else {
> -                               /* Switch whiteouts */
> -                               ovlrd.flags |=3D RENAME_EXCHANGE;
> -                       }
> -               } else if (is_dir && ovl_dentry_is_whiteout(new)) {
> -                       ovlrd.flags |=3D RENAME_EXCHANGE;
> -                       ovlrd.cleanup_whiteout =3D true;
> -               }
> -       }
> -
> -       err =3D ovl_copy_up(old);
> -       if (err)
> -               goto out;
> -
> -       err =3D ovl_copy_up(ovlrd.new_parent);
> -       if (err)
> -               goto out;
> -       if (!ovlrd.overwrite) {
> -               err =3D ovl_copy_up(new);
> -               if (err)
> -                       goto out;
> -       } else if (d_inode(new)) {
> -               err =3D ovl_nlink_start(new);
> -               if (err)
> -                       goto out;
> -
> -               update_nlink =3D true;
> -       }
> -
> -       if (!update_nlink) {
> -               /* ovl_nlink_start() took ovl_want_write() */
> -               err =3D ovl_want_write(old);
> -               if (err)
> -                       goto out;
> -       }
> -
> -       old_cred =3D ovl_override_creds(old->d_sb);
> +       struct dentry *trap, *de;
> +       bool old_opaque, new_opaque;
> +       int err;
>
> -       if (!list_empty(&list)) {
> -               ovlrd.opaquedir =3D ovl_clear_empty(new, &list);
> -               err =3D PTR_ERR(ovlrd.opaquedir);
> -               if (IS_ERR(ovlrd.opaquedir)) {
> -                       ovlrd.opaquedir =3D NULL;
> -                       goto out_revert_creds;
> -               }
> +       if (!list_empty(list)) {
> +               de =3D ovl_clear_empty(new, list);
> +               if (IS_ERR(de))
> +                       return PTR_ERR(de);
> +               ovlrd->opaquedir =3D de;
>         }
>
> -       old_upperdir =3D ovl_dentry_upper(ovlrd.old_parent);
> -       new_upperdir =3D ovl_dentry_upper(ovlrd.new_parent);
> -
>         if (!samedir) {
>                 /*
>                  * When moving a merge dir or non-dir with copy up origin=
 into
> @@ -1208,32 +1129,30 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>                  * lookup the origin inodes of the entries to fill d_ino.
>                  */
>                 if (ovl_type_origin(old)) {
> -                       err =3D ovl_set_impure(ovlrd.new_parent, new_uppe=
rdir);
> +                       err =3D ovl_set_impure(ovlrd->new_parent, new_upp=
erdir);
>                         if (err)
> -                               goto out_revert_creds;
> +                               return err;
>                 }
> -               if (!ovlrd.overwrite && ovl_type_origin(new)) {
> -                       err =3D ovl_set_impure(ovlrd.old_parent, old_uppe=
rdir);
> +               if (!ovlrd->overwrite && ovl_type_origin(new)) {
> +                       err =3D ovl_set_impure(ovlrd->old_parent, old_upp=
erdir);
>                         if (err)
> -                               goto out_revert_creds;
> +                               return err;
>                 }
>         }
>
>         trap =3D lock_rename(new_upperdir, old_upperdir);
> -       if (IS_ERR(trap)) {
> -               err =3D PTR_ERR(trap);
> -               goto out_revert_creds;
> -       }
> +       if (IS_ERR(trap))
> +               return PTR_ERR(trap);
>
>         de =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
>                               old->d_name.len);
>         err =3D PTR_ERR(de);
>         if (IS_ERR(de))
>                 goto out_unlock;
> -       ovlrd.olddentry =3D de;
> +       ovlrd->olddentry =3D de;
>
>         err =3D -ESTALE;
> -       if (!ovl_matches_upper(old, ovlrd.olddentry))
> +       if (!ovl_matches_upper(old, ovlrd->olddentry))
>                 goto out_unlock;
>
>         de =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
> @@ -1241,73 +1160,74 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>         err =3D PTR_ERR(de);
>         if (IS_ERR(de))
>                 goto out_unlock;
> -       ovlrd.newdentry =3D de;
> +       ovlrd->newdentry =3D de;
>
>         old_opaque =3D ovl_dentry_is_opaque(old);
>         new_opaque =3D ovl_dentry_is_opaque(new);
>
>         err =3D -ESTALE;
>         if (d_inode(new) && ovl_dentry_upper(new)) {
> -               if (ovlrd.opaquedir) {
> -                       if (ovlrd.newdentry !=3D ovlrd.opaquedir)
> +               if (ovlrd->opaquedir) {
> +                       if (ovlrd->newdentry !=3D ovlrd->opaquedir)
>                                 goto out_unlock;
>                 } else {
> -                       if (!ovl_matches_upper(new, ovlrd.newdentry))
> +                       if (!ovl_matches_upper(new, ovlrd->newdentry))
>                                 goto out_unlock;
>                 }
>         } else {
> -               if (!d_is_negative(ovlrd.newdentry)) {
> -                       if (!new_opaque || !ovl_upper_is_whiteout(ofs, ov=
lrd.newdentry))
> +               if (!d_is_negative(ovlrd->newdentry)) {
> +                       if (!new_opaque || !ovl_upper_is_whiteout(ofs, ov=
lrd->newdentry))
>                                 goto out_unlock;
>                 } else {
> -                       if (ovlrd.flags & RENAME_EXCHANGE)
> +                       if (flags & RENAME_EXCHANGE)
>                                 goto out_unlock;
>                 }
>         }
>
> -       if (ovlrd.olddentry =3D=3D trap)
> +       if (ovlrd->olddentry =3D=3D trap)
>                 goto out_unlock;
> -       if (ovlrd.newdentry =3D=3D trap)
> +       if (ovlrd->newdentry =3D=3D trap)
>                 goto out_unlock;
>
> -       if (ovlrd.olddentry->d_inode =3D=3D ovlrd.newdentry->d_inode)
> +       if (ovlrd->olddentry->d_inode =3D=3D ovlrd->newdentry->d_inode)
>                 goto out_unlock;
>
>         err =3D 0;
>         if (ovl_type_merge_or_lower(old))
>                 err =3D ovl_set_redirect(old, samedir);
> -       else if (is_dir && !old_opaque && ovl_type_merge(ovlrd.new_parent=
))
> -               err =3D ovl_set_opaque_xerr(old, ovlrd.olddentry, -EXDEV)=
;
> +       else if (is_dir && !old_opaque && ovl_type_merge(ovlrd->new_paren=
t))
> +               err =3D ovl_set_opaque_xerr(old, ovlrd->olddentry, -EXDEV=
);
>         if (err)
>                 goto out_unlock;
>
> -       if (!ovlrd.overwrite && ovl_type_merge_or_lower(new))
> +       if (!ovlrd->overwrite && ovl_type_merge_or_lower(new))
>                 err =3D ovl_set_redirect(new, samedir);
> -       else if (!ovlrd.overwrite && new_is_dir && !new_opaque &&
> -                ovl_type_merge(ovlrd.old_parent))
> -               err =3D ovl_set_opaque_xerr(new, ovlrd.newdentry, -EXDEV)=
;
> +       else if (!ovlrd->overwrite && new_is_dir && !new_opaque &&
> +                ovl_type_merge(ovlrd->old_parent))
> +               err =3D ovl_set_opaque_xerr(new, ovlrd->newdentry, -EXDEV=
);
>         if (err)
>                 goto out_unlock;
>
> -       err =3D ovl_do_rename(ofs, old_upperdir, ovlrd.olddentry,
> -                           new_upperdir, ovlrd.newdentry, flags);
> +       err =3D ovl_do_rename(ofs, old_upperdir, ovlrd->olddentry,
> +                           new_upperdir, ovlrd->newdentry, flags);
> +out_unlock:
>         unlock_rename(new_upperdir, old_upperdir);
>         if (err)
> -               goto out_revert_creds;
> +               return err;
>
> -       if (ovlrd.cleanup_whiteout)
> -               ovl_cleanup(ofs, old_upperdir, ovlrd.newdentry);
> +       if (ovlrd->cleanup_whiteout)
> +               ovl_cleanup(ofs, old_upperdir, ovlrd->newdentry);
>
> -       if (ovlrd.overwrite && d_inode(new)) {
> +       if (ovlrd->overwrite && d_inode(new)) {
>                 if (new_is_dir)
>                         clear_nlink(d_inode(new));
>                 else
>                         ovl_drop_nlink(new);
>         }
>
> -       ovl_dir_modified(ovlrd.old_parent, ovl_type_origin(old) ||
> -                        (!ovlrd.overwrite && ovl_type_origin(new)));
> -       ovl_dir_modified(ovlrd.new_parent, ovl_type_origin(old) ||
> +       ovl_dir_modified(ovlrd->old_parent, ovl_type_origin(old) ||
> +                        (!ovlrd->overwrite && ovl_type_origin(new)));
> +       ovl_dir_modified(ovlrd->new_parent, ovl_type_origin(old) ||
>                          (d_inode(new) && ovl_type_origin(new)));
>
>         /* copy ctime: */
> @@ -1315,22 +1235,105 @@ static int ovl_rename(struct mnt_idmap *idmap, s=
truct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new))
>                 ovl_copyattr(d_inode(new));
>
> -out_revert_creds:
> +       return err;
> +}
> +
> +static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
> +                     struct dentry *old, struct inode *newdir,
> +                     struct dentry *new, unsigned int flags)
> +{
> +       int err;
> +       bool update_nlink =3D false;
> +       bool is_dir =3D d_is_dir(old);
> +       bool new_is_dir =3D d_is_dir(new);
> +       const struct cred *old_cred =3D NULL;
> +       struct ovl_renamedata ovlrd =3D {
> +               .old_parent             =3D old->d_parent,
> +               .old_dentry             =3D old,
> +               .new_parent             =3D new->d_parent,
> +               .new_dentry             =3D new,
> +               .flags                  =3D flags,
> +               .cleanup_whiteout       =3D false,
> +               .overwrite              =3D !(flags & RENAME_EXCHANGE),
> +       };
> +       LIST_HEAD(list);
> +
> +       err =3D -EINVAL;
> +       if (ovlrd.flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
> +               goto out;
> +
> +       ovlrd.flags &=3D ~RENAME_NOREPLACE;
> +
> +       /* Don't copy up directory trees */
> +       err =3D -EXDEV;
> +       if (!ovl_can_move(old))
> +               goto out;
> +       if (!ovlrd.overwrite && !ovl_can_move(new))
> +               goto out;
> +
> +       if (ovlrd.overwrite && new_is_dir && !ovl_pure_upper(new)) {
> +               err =3D ovl_check_empty_dir(new, &list);
> +               if (err)
> +                       goto out;
> +       }
> +
> +       if (ovlrd.overwrite) {
> +               if (ovl_lower_positive(old)) {
> +                       if (!ovl_dentry_is_whiteout(new)) {
> +                               /* Whiteout source */
> +                               ovlrd.flags |=3D RENAME_WHITEOUT;
> +                       } else {
> +                               /* Switch whiteouts */
> +                               ovlrd.flags |=3D RENAME_EXCHANGE;
> +                       }
> +               } else if (is_dir && ovl_dentry_is_whiteout(new)) {
> +                       ovlrd.flags |=3D RENAME_EXCHANGE;
> +                       ovlrd.cleanup_whiteout =3D true;
> +               }
> +       }
> +
> +       err =3D ovl_copy_up(old);
> +       if (err)
> +               goto out;
> +
> +       err =3D ovl_copy_up(new->d_parent);
> +       if (err)
> +               goto out;
> +       if (!ovlrd.overwrite) {
> +               err =3D ovl_copy_up(new);
> +               if (err)
> +                       goto out;
> +       } else if (d_inode(new)) {
> +               err =3D ovl_nlink_start(new);
> +               if (err)
> +                       goto out;
> +
> +               update_nlink =3D true;
> +       }
> +
> +       if (!update_nlink) {
> +               /* ovl_nlink_start() took ovl_want_write() */
> +               err =3D ovl_want_write(old);
> +               if (err)
> +                       goto out;
> +       }
> +
> +       old_cred =3D ovl_override_creds(old->d_sb);
> +
> +       err =3D do_ovl_rename(&ovlrd, &list);
> +
>         ovl_revert_creds(old_cred);
>         if (update_nlink)
>                 ovl_nlink_end(new);
>         else
>                 ovl_drop_write(old);
> -out:
> +
>         dput(ovlrd.newdentry);
>         dput(ovlrd.olddentry);
>         dput(ovlrd.opaquedir);
> +out:
>         ovl_cache_free(&list);
>         return err;
> -
> -out_unlock:
> -       unlock_rename(new_upperdir, old_upperdir);
> -       goto out_revert_creds;
>  }
>
>  static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
>
> --
> 2.47.3
>

