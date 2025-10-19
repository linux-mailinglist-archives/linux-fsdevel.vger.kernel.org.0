Return-Path: <linux-fsdevel+bounces-64615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C81BEE2FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95545189D756
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D13C28134F;
	Sun, 19 Oct 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTJ8zVB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E25217648
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760869880; cv=none; b=ujbS230be/2F/WEH/k+S4EQpcCna2qyNQIuYrn8r0NSRSBt7gZEv6A4Sdu3ONvEaQ3/nR+TY4l7hq52SgDRsqpkCcHCIZU3nFlfZOwKncGYgxYhDXnwX2IE0QSSSEdgjBQTnTpJa2wCc4IkDiAHLF2OJLi/fHLyprQCVDSkcc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760869880; c=relaxed/simple;
	bh=q4WHDwr/y5rSG/XufV9LGPuNxZuz3CCJQQh3tiolHwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RH8GcausfNvwR9lk7XPNxvtE0P7Q1bqgHqrHRPhuLcLJSm4tjd60C3cJ13eM9Eh94pl+xKKMH4T95QKf52yOgReRdfqXK6zraP825I+C3oRRt2mLm7eqYC/CoIRUDwjtVEt10krXvkf8MqLX7+4WfTCCSBSSJGnVinZBGPg1ruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTJ8zVB5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso5977766a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760869875; x=1761474675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=716rCmYQ2k9VBpj3zfmi3QESGuMLFizlCbS9b91A8Go=;
        b=KTJ8zVB5nA1bxLJoUmky5U+3AcDlWcgT6YYg6iFr8aeH0LS70OmXRVkOlQUALn5APr
         eoF4VPvWADpctu1xWSFFO0py2sBgjiDMPqJFUGyK3hb3n0h2E/h5cOfWZOYxCOrX+CWc
         LzzaoPSrwBygUCDcTzKIMaLUvvxTRLqhdATJv0OXmWo7agnX9tFZLbC975CUonuQm7wU
         VoS707nC51UUlEPItcLqSeoe+/lcsvHsqwE2e+o4hxOL5r/Qcmexc3hAG4bR18XxeHVd
         11l6NQeTWHwe57kBLQys6OIhIO1qmSTC7L4JAzUhvnfr+KgCiKie98An4VdbCjxCQ1lZ
         sgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760869875; x=1761474675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=716rCmYQ2k9VBpj3zfmi3QESGuMLFizlCbS9b91A8Go=;
        b=WLLICeSO6hhtR1VbjZpBQ2DE6H2aihjh3ubwRh3/19fF5/UDHvr9NuU/55xQNDfPTY
         ale2GBzD7YfJn2MkkflNDMwfuId6tp2HJGV7oQt66UeZ1kh1D3X+Ggb8E/2LFlqPZwUd
         ELYv5vq8aIE0ZvN1pb3CU+QCaGR6WJNhas8FLhNcObHgy4/vVtl+7ooMoNsDTOf2tXL0
         bND8Fnxu2cLFkciyo2zyczrGCfcLRQ7Myge4ZWSNE4Id09n2geppgE5rPY3XIn9S66Qo
         Cvgr8905fhPYLOvv4x0G/ic17vYzrDWdGMYhTUGc3PO1EdhdUxyBNcf3zV0Rx3ORGbu7
         xhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgToUiTrR4D8NJHqzeoCCkrlZQdcFQbFBirAMKdfDxu6TLFZ8DijHvg5SWNHiLUoDIw2TyPZHCsjAhNZUk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8IiSsZEog7qea3qwMXLXvKiOigDnFcpj1vR19gR4eD2CTe4+
	nCrsWZsFf07QJmXlIFcN7Xp6nsmef1vUASriAd41CRL+V6DbhV/MsgBCyOCKxNYd+d1bjBJbRUk
	lWDIKq6jMsVi42joSRIoEPT/sIT2OXT0=
X-Gm-Gg: ASbGnctgQB8Q+oc+x+QZrdOwtwE8nOkAyHaXbsiPIq+l3vbZKUWcvqu99I46lAGGCD6
	UTEEsi9nPPPGs5YPtylFbCF2S+OkR78gyjw3EBpA1OQZpXiGNmZxH999HZZnYYB20l2ek8YbEdb
	jmS9YxyiSRr2JKd2oXUJTy/C+8aUM+6O48sR8+OpeECXp+HuzC6YTy9rwGJ4slyQn0MAOeGEbvI
	AXQ9tHIsPxFMQBWmsN3h7jkaNyhNhYjgSDKy8Izr0gTaTRkEct8l+CU8ld8LeVxSW3H24kcgqdo
	UvqIJZBYF0WfH/+J0IyIRKRhqU9sSQ==
X-Google-Smtp-Source: AGHT+IGX+3XEUyM0QvP5anCF8u0nTCK5s7tJY4u6oJvR94UXSqpIUf+n/8aX8f3xl+1gfd1y3GcIBrwa2HNrLO9wUYk=
X-Received: by 2002:a05:6402:3595:b0:63b:f67b:3782 with SMTP id
 4fb4d7f45d1cf-63c1f6e0330mr9153248a12.27.1760869875066; Sun, 19 Oct 2025
 03:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-11-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-11-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:31:03 +0200
X-Gm-Features: AS18NWCafdjMJ1aHViZHzS6YPLJ7irSwk4C4D63KQT37TYygOzVCFqGFKl8LZR0
Message-ID: <CAOQ4uxj+uE3zvTPvCn5_kLor0L8PP=wKdaONWYCh3mTr1s414w@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Several callers perform a rename on a dentry they already have, and only
> require lookup for the target name.  This includes smb/server and a few
> different places in overlayfs.
>
> start_renaming_dentry() performs the required lookup and takes the
> required lock using lock_rename_child()
>
> It is used in three places in overlayfs and in ksmbd_vfs_rename().
>
> In the ksmbd case, the parent of the source is not important - the
> source must be renamed from wherever it is.  So start_renaming_dentry()
> allows rd->old_parent to be NULL and only checks it if it is non-NULL.
> On success rd->old_parent will be the parent of old_dentry with an extra
> reference taken.  Other start_renaming function also now take the extra
> reference and end_renaming() now drops this reference as well.
>
> ovl_lookup_temp(), ovl_parent_lock(), and ovl_parent_unlock() are
> all removed as they are no longer needed.
>
> OVL_TEMPNAME_SIZE and ovl_tempname() are now declared in overlayfs.h so
> that ovl_check_rename_whiteout() can access them.
>
> ovl_copy_up_workdir() now always cleans up on error.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/namei.c               | 108 ++++++++++++++++++++++++++++++++++++---
>  fs/overlayfs/copy_up.c   |  54 +++++++++-----------
>  fs/overlayfs/dir.c       |  19 +------
>  fs/overlayfs/overlayfs.h |   8 +--
>  fs/overlayfs/super.c     |  22 ++++----
>  fs/overlayfs/util.c      |  11 ----
>  fs/smb/server/vfs.c      |  60 ++++------------------
>  include/linux/namei.h    |   2 +
>  8 files changed, 150 insertions(+), 134 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index a2553df8f34e..4e694b82e309 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3669,7 +3669,7 @@ EXPORT_SYMBOL(unlock_rename);
>
>  /**
>   * __start_renaming - lookup and lock names for rename
> - * @rd:           rename data containing parent and flags, and
> + * @rd:           rename data containing parents and flags, and
>   *                for receiving found dentries
>   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
>   *                LOOKUP_NO_SYMLINKS etc).
> @@ -3680,8 +3680,8 @@ EXPORT_SYMBOL(unlock_rename);
>   * rename.
>   *
>   * On success the found dentrys are stored in @rd.old_dentry,
> - * @rd.new_dentry.  These references and the lock are dropped by
> - * end_renaming().
> + * @rd.new_dentry and an extra ref is taken on @rd.old_parent.
> + * These references and the lock are dropped by end_renaming().
>   *
>   * The passed in qstrs must have the hash calculated, and no permission
>   * checking is performed.
> @@ -3733,6 +3733,7 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
>
>         rd->old_dentry =3D d1;
>         rd->new_dentry =3D d2;
> +       dget(rd->old_parent);
>         return 0;
>
>  out_unlock_3:
> @@ -3748,7 +3749,7 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
>
>  /**
>   * start_renaming - lookup and lock names for rename with permission che=
cking
> - * @rd:           rename data containing parent and flags, and
> + * @rd:           rename data containing parents and flags, and
>   *                for receiving found dentries
>   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
>   *                LOOKUP_NO_SYMLINKS etc).
> @@ -3759,8 +3760,8 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
>   * rename.
>   *
>   * On success the found dentrys are stored in @rd.old_dentry,
> - * @rd.new_dentry.  These references and the lock are dropped by
> - * end_renaming().
> + * @rd.new_dentry.  Also the refcount on @rd->old_parent is increased.
> + * These references and the lock are dropped by end_renaming().
>   *
>   * The passed in qstrs need not have the hash calculated, and basic
>   * eXecute permission checking is performed against @rd.mnt_idmap.
> @@ -3782,11 +3783,106 @@ int start_renaming(struct renamedata *rd, int lo=
okup_flags,
>  }
>  EXPORT_SYMBOL(start_renaming);
>
> +static int
> +__start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> +                       struct dentry *old_dentry, struct qstr *new_last)
> +{
> +       struct dentry *trap;
> +       struct dentry *d2;
> +       int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +       int err;
> +
> +       if (rd->flags & RENAME_EXCHANGE)
> +               target_flags =3D 0;
> +       if (rd->flags & RENAME_NOREPLACE)
> +               target_flags |=3D LOOKUP_EXCL;
> +
> +       /* Already have the dentry - need to be sure to lock the correct =
parent */
> +       trap =3D lock_rename_child(old_dentry, rd->new_parent);
> +       if (IS_ERR(trap))
> +               return PTR_ERR(trap);
> +       if (d_unhashed(old_dentry) ||
> +           (rd->old_parent && rd->old_parent !=3D old_dentry->d_parent))=
 {
> +               /* dentry was removed, or moved and explicit parent reque=
sted */
> +               err =3D -EINVAL;
> +               goto out_unlock;
> +       }
> +
> +       d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> +                                 lookup_flags | target_flags);
> +       err =3D PTR_ERR(d2);
> +       if (IS_ERR(d2))
> +               goto out_unlock;
> +
> +       if (old_dentry =3D=3D trap) {
> +               /* source is an ancestor of target */
> +               err =3D -EINVAL;
> +               goto out_dput_d2;
> +       }
> +
> +       if (d2 =3D=3D trap) {
> +               /* target is an ancestor of source */
> +               if (rd->flags & RENAME_EXCHANGE)
> +                       err =3D -EINVAL;
> +               else
> +                       err =3D -ENOTEMPTY;
> +               goto out_dput_d2;
> +       }
> +
> +       rd->old_dentry =3D dget(old_dentry);
> +       rd->new_dentry =3D d2;
> +       rd->old_parent =3D dget(old_dentry->d_parent);
> +       return 0;
> +
> +out_dput_d2:
> +       dput(d2);
> +out_unlock:
> +       unlock_rename(old_dentry->d_parent, rd->new_parent);
> +       return err;
> +}
> +
> +/**
> + * start_renaming_dentry - lookup and lock name for rename with permissi=
on checking
> + * @rd:           rename data containing parents and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_dentry:   dentry of name to move
> + * @new_last:     name of target in @rd.new_parent
> + *
> + * Look up target name and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentry is stored in @rd.new_dentry and
> + * @rd.old_parent is confirmed to be the parent of @old_dentry.  If it
> + * was originally %NULL, it is set.  In either case a reference is taken
> + * so that end_renaming() can have a stable reference to unlock.
> + *
> + * References and the lock can be dropped with end_renaming()
> + *
> + * The passed in qstr need not have the hash calculated, and basic
> + * eXecute permission checking is performed against @rd.mnt_idmap.
> + *
> + * Returns: zero or an error.
> + */
> +int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> +                         struct dentry *old_dentry, struct qstr *new_las=
t)
> +{
> +       int err;
> +
> +       err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent=
);
> +       if (err)
> +               return err;
> +       return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_=
last);
> +}
> +EXPORT_SYMBOL(start_renaming_dentry);
> +
>  void end_renaming(struct renamedata *rd)
>  {
>         unlock_rename(rd->old_parent, rd->new_parent);
>         dput(rd->old_dentry);
>         dput(rd->new_dentry);
> +       dput(rd->old_parent);
>  }
>  EXPORT_SYMBOL(end_renaming);
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 7a31ca9bdea2..27014ada11c7 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -523,8 +523,8 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> -       struct dentry *index =3D NULL;
>         struct dentry *temp =3D NULL;
> +       struct renamedata rd =3D {};
>         struct qstr name =3D { };
>         int err;
>
> @@ -556,17 +556,15 @@ static int ovl_create_index(struct dentry *dentry, =
const struct ovl_fh *fh,
>         if (err)
>                 goto out;
>
> -       err =3D ovl_parent_lock(indexdir, temp);
> +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +       rd.old_parent =3D indexdir;
> +       rd.new_parent =3D indexdir;
> +       err =3D start_renaming_dentry(&rd, 0, temp, &name);
>         if (err)
>                 goto out;
> -       index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> -       if (IS_ERR(index)) {
> -               err =3D PTR_ERR(index);
> -       } else {
> -               err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, inde=
x, 0);
> -               dput(index);
> -       }
> -       ovl_parent_unlock(indexdir);
> +
> +       err =3D ovl_do_rename_rd(&rd);
> +       end_renaming(&rd);
>  out:
>         if (err)
>                 ovl_cleanup(ofs, indexdir, temp);
> @@ -763,7 +761,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct inode *inode;
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
> -       struct dentry *temp, *upper, *trap;
> +       struct renamedata rd =3D {};
> +       struct dentry *temp;
>         struct ovl_cu_creds cc;
>         int err;
>         struct ovl_cattr cattr =3D {
> @@ -807,29 +806,24 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>          * ovl_copy_up_data(), so lock workdir and destdir and make sure =
that
>          * temp wasn't moved before copy up completion or cleanup.
>          */
> -       trap =3D lock_rename(c->workdir, c->destdir);
> -       if (trap || temp->d_parent !=3D c->workdir) {
> -               /* temp or workdir moved underneath us? abort without cle=
anup */
> -               dput(temp);
> +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +       rd.old_parent =3D c->workdir;
> +       rd.new_parent =3D c->destdir;
> +       rd.flags =3D 0;
> +       err =3D start_renaming_dentry(&rd, 0, temp,
> +                                   &QSTR_LEN(c->destname.name, c->destna=
me.len));
> +       if (err) {
> +               /* temp or workdir moved underneath us? map to -EIO */
>                 err =3D -EIO;
> -               if (!IS_ERR(trap))
> -                       unlock_rename(c->workdir, c->destdir);
> -               goto out;
>         }
> -
> -       err =3D ovl_copy_up_metadata(c, temp);
>         if (err)
> -               goto cleanup;
> +               goto cleanup_unlocked;
>
> -       upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
> -                                c->destname.len);
> -       err =3D PTR_ERR(upper);
> -       if (IS_ERR(upper))
> -               goto cleanup;
> +       err =3D ovl_copy_up_metadata(c, temp);
> +       if (!err)
> +               err =3D ovl_do_rename_rd(&rd);
> +       end_renaming(&rd);
>
> -       err =3D ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0=
);
> -       unlock_rename(c->workdir, c->destdir);
> -       dput(upper);
>         if (err)
>                 goto cleanup_unlocked;
>
> @@ -850,8 +844,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>
>         return err;
>
> -cleanup:
> -       unlock_rename(c->workdir, c->destdir);
>  cleanup_unlocked:
>         ovl_cleanup(ofs, c->workdir, temp);
>         dput(temp);
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ded86855e91c..6367cebdbd48 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -57,8 +57,7 @@ int ovl_cleanup(struct ovl_fs *ofs, struct dentry *work=
dir,
>         return 0;
>  }
>
> -#define OVL_TEMPNAME_SIZE 20
> -static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
> +void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  {
>         static atomic_t temp_id =3D ATOMIC_INIT(0);
>
> @@ -66,22 +65,6 @@ static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>         snprintf(name, OVL_TEMPNAME_SIZE, "#%x", atomic_inc_return(&temp_=
id));
>  }
>
> -struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> -{
> -       struct dentry *temp;
> -       char name[OVL_TEMPNAME_SIZE];
> -
> -       ovl_tempname(name);
> -       temp =3D ovl_lookup_upper(ofs, name, workdir, strlen(name));
> -       if (!IS_ERR(temp) && temp->d_inode) {
> -               pr_err("workdir/%s already exists\n", name);
> -               dput(temp);
> -               temp =3D ERR_PTR(-EIO);
> -       }
> -
> -       return temp;
> -}
> -
>  static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
>                                               struct dentry *workdir)
>  {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index aecb527e0524..a9ecab16dba6 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -454,11 +454,6 @@ static inline bool ovl_open_flags_need_copy_up(int f=
lags)
>  }
>
>  /* util.c */
> -int ovl_parent_lock(struct dentry *parent, struct dentry *child);
> -static inline void ovl_parent_unlock(struct dentry *parent)
> -{
> -       inode_unlock(parent->d_inode);
> -}
>  int ovl_get_write_access(struct dentry *dentry);
>  void ovl_put_write_access(struct dentry *dentry);
>  void ovl_start_write(struct dentry *dentry);
> @@ -895,7 +890,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
>                                struct dentry *parent, struct dentry *newd=
entry,
>                                struct ovl_cattr *attr);
>  int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentr=
y *dentry);
> -struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r);
> +#define OVL_TEMPNAME_SIZE 20
> +void ovl_tempname(char name[OVL_TEMPNAME_SIZE]);
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>                                struct ovl_cattr *attr);
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 6e0816c1147a..a721ef2b90e8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -566,9 +566,10 @@ static int ovl_check_rename_whiteout(struct ovl_fs *=
ofs)
>  {
>         struct dentry *workdir =3D ofs->workdir;
>         struct dentry *temp;
> -       struct dentry *dest;
>         struct dentry *whiteout;
>         struct name_snapshot name;
> +       struct renamedata rd =3D {};
> +       char name2[OVL_TEMPNAME_SIZE];
>         int err;
>
>         temp =3D ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
> @@ -576,23 +577,21 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>         if (IS_ERR(temp))
>                 return err;
>
> -       err =3D ovl_parent_lock(workdir, temp);
> +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +       rd.old_parent =3D workdir;
> +       rd.new_parent =3D workdir;
> +       rd.flags =3D RENAME_WHITEOUT;
> +       ovl_tempname(name2);
> +       err =3D start_renaming_dentry(&rd, 0, temp, &QSTR(name2));
>         if (err) {
>                 dput(temp);
>                 return err;
>         }
> -       dest =3D ovl_lookup_temp(ofs, workdir);
> -       err =3D PTR_ERR(dest);
> -       if (IS_ERR(dest)) {
> -               dput(temp);
> -               ovl_parent_unlock(workdir);
> -               return err;
> -       }
>
>         /* Name is inline and stable - using snapshot as a copy helper */
>         take_dentry_name_snapshot(&name, temp);
> -       err =3D ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_W=
HITEOUT);
> -       ovl_parent_unlock(workdir);
> +       err =3D ovl_do_rename_rd(&rd);
> +       end_renaming(&rd);
>         if (err) {
>                 if (err =3D=3D -EINVAL)
>                         err =3D 0;
> @@ -616,7 +615,6 @@ static int ovl_check_rename_whiteout(struct ovl_fs *o=
fs)
>         ovl_cleanup(ofs, workdir, temp);
>         release_dentry_name_snapshot(&name);
>         dput(temp);
> -       dput(dest);
>
>         return err;
>  }
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index f76672f2e686..46387aeb6be6 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1548,14 +1548,3 @@ void ovl_copyattr(struct inode *inode)
>         i_size_write(inode, i_size_read(realinode));
>         spin_unlock(&inode->i_lock);
>  }
> -
> -int ovl_parent_lock(struct dentry *parent, struct dentry *child)
> -{
> -       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> -       if (!child ||
> -           (!d_unhashed(child) && child->d_parent =3D=3D parent))
> -               return 0;
> -
> -       inode_unlock(parent->d_inode);
> -       return -EINVAL;
> -}
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 7c4ddc43ab39..f54b5b0aaba2 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -663,7 +663,6 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const cha=
r *oldname,
>  int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_pat=
h,
>                      char *newname, int flags)
>  {
> -       struct dentry *old_parent, *new_dentry, *trap;
>         struct dentry *old_child =3D old_path->dentry;
>         struct path new_path;
>         struct qstr new_last;
> @@ -673,7 +672,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>         struct ksmbd_file *parent_fp;
>         int new_type;
>         int err, lookup_flags =3D LOOKUP_NO_SYMLINKS;
> -       int target_lookup_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
>
>         if (ksmbd_override_fsids(work))
>                 return -ENOMEM;
> @@ -684,14 +682,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const =
struct path *old_path,
>                 goto revert_fsids;
>         }
>
> -       /*
> -        * explicitly handle file overwrite case, for compatibility with
> -        * filesystems that may not support rename flags (e.g: fuse)
> -        */
> -       if (flags & RENAME_NOREPLACE)
> -               target_lookup_flags |=3D LOOKUP_EXCL;
> -       flags &=3D ~(RENAME_NOREPLACE);
> -
>  retry:
>         err =3D vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
>                                      &new_path, &new_last, &new_type,
> @@ -708,17 +698,14 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const=
 struct path *old_path,
>         if (err)
>                 goto out2;
>
> -       trap =3D lock_rename_child(old_child, new_path.dentry);
> -       if (IS_ERR(trap)) {
> -               err =3D PTR_ERR(trap);
> +       rd.mnt_idmap            =3D mnt_idmap(old_path->mnt);
> +       rd.old_parent           =3D NULL;
> +       rd.new_parent           =3D new_path.dentry;
> +       rd.flags                =3D flags;
> +       rd.delegated_inode      =3D NULL,
> +       err =3D start_renaming_dentry(&rd, lookup_flags, old_child, &new_=
last);
> +       if (err)
>                 goto out_drop_write;
> -       }
> -
> -       old_parent =3D dget(old_child->d_parent);
> -       if (d_unhashed(old_child)) {
> -               err =3D -EINVAL;
> -               goto out3;
> -       }
>
>         parent_fp =3D ksmbd_lookup_fd_inode(old_child->d_parent);
>         if (parent_fp) {
> @@ -731,44 +718,17 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const=
 struct path *old_path,
>                 ksmbd_fd_put(work, parent_fp);
>         }
>
> -       new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
> -                                         lookup_flags | target_lookup_fl=
ags);
> -       if (IS_ERR(new_dentry)) {
> -               err =3D PTR_ERR(new_dentry);
> -               goto out3;
> -       }
> -
> -       if (d_is_symlink(new_dentry)) {
> +       if (d_is_symlink(rd.new_dentry)) {
>                 err =3D -EACCES;
> -               goto out4;
> -       }
> -
> -       if (old_child =3D=3D trap) {
> -               err =3D -EINVAL;
> -               goto out4;
> -       }
> -
> -       if (new_dentry =3D=3D trap) {
> -               err =3D -ENOTEMPTY;
> -               goto out4;
> +               goto out3;
>         }
>
> -       rd.mnt_idmap            =3D mnt_idmap(old_path->mnt),
> -       rd.old_parent           =3D old_parent,
> -       rd.old_dentry           =3D old_child,
> -       rd.new_parent           =3D new_path.dentry,
> -       rd.new_dentry           =3D new_dentry,
> -       rd.flags                =3D flags,
> -       rd.delegated_inode      =3D NULL,
>         err =3D vfs_rename(&rd);
>         if (err)
>                 ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
>
> -out4:
> -       dput(new_dentry);
>  out3:
> -       dput(old_parent);
> -       unlock_rename(old_parent, new_path.dentry);
> +       end_renaming(&rd);
>  out_drop_write:
>         mnt_drop_write(old_path->mnt);
>  out2:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 19c3d8e336d5..f73001e3719a 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -158,6 +158,8 @@ extern struct dentry *lock_rename_child(struct dentry=
 *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);
>  int start_renaming(struct renamedata *rd, int lookup_flags,
>                    struct qstr *old_last, struct qstr *new_last);
> +int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> +                         struct dentry *old_dentry, struct qstr *new_las=
t);
>  void end_renaming(struct renamedata *rd);
>
>  /**
> --
> 2.50.0.107.gf914562f5916.dirty
>

