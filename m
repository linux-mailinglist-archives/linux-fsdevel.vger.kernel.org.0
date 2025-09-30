Return-Path: <linux-fsdevel+bounces-63095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA8BABE37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3400B16D671
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B2A2459FD;
	Tue, 30 Sep 2025 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV/Q0We9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402423F26A
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218382; cv=none; b=P7MNICENUKnx3lx6MB2oUy0CsZW9OKRc/XQBG5+2S95pQiDLeLoNIFOU5xNLl6N1QHZFNuXshjKpZbBQ6/r6wK0L2vBBONHvME/4SxZO3IXKo7D1hSHlJSYa56Xi6UGrwqNUHCrl9TCDhZ82lAiFe4Z52wXYhpdS2bSoy1eNhrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218382; c=relaxed/simple;
	bh=BnS+scwLGJpHjfFPl8V5Y3zKoKiQNGMTUhIS7k9WeOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO1l23PI494QrJUlGZfoOEGAeZPm4N2OHc9/zfKVs+DbsukbQGm3S1E5ltsrw+62fUwzvCp0JsLlZVNGbk6p5o9cfpG2jSNn0Os38NfYt1fNsvziDqaM4vqaypoqDoVs/vzdcM21mPH8DYWvJhxNQuhjEJHlzmMUPrEBC6dNbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV/Q0We9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so8074535a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759218379; x=1759823179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd6HSadD0qzJsQhyMqpFHLayWLluCt3L9t4A9Dl/EWQ=;
        b=DV/Q0We9cfInxQZyZ1sep2D6SpIOgNOH53M3L8po47k42FqkMXZoDCkeOPrWYHJjYQ
         iQ38KB9QAY+wd1XY9B9GQpHfk0jaylC6SV0sXdZ+pwCJJTV90ytvZ0zz/Fkl9lti1fsP
         +H/fZ4w31qt5UbIvTvitaNB6plAPDJfJsTIe7+3JpsI2/neRX5Byjm74QKAQadRgTc+U
         Jd7fL391rVKIYf0ltnOayvjIzbqd5NeOF15hCtUWdmFt8FsJPwZfqcvMqRczpIbaAeYY
         1l/E1C1nxjcZ43OwUURBRQLDxXsZWvte1e+wMCrvaJL8+Ud1g8ySwBIP+sQ6Ke1ZPqof
         gzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218379; x=1759823179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rd6HSadD0qzJsQhyMqpFHLayWLluCt3L9t4A9Dl/EWQ=;
        b=ZBQM7k6y2tmQGBUvxjvAXunailTv1IIpoX+5CDYXBWxbE8I3C9ltYN/n/ik242+wjz
         zfp+GvsK0fxLlIvQakDCCbMN614ptewlDZuSKcZAY9UiNYU7ZSYTdb4anakEjr29x9vL
         gQkk5ilr4UNNbYNJZF5oqvySyCUA9Dqbav5DWd316MVCm0fGlD3FGQr7Fw6b0xrXs/4+
         Jj4TbHDTepBvnsWxtYsE4QHJPIPq1Tm7MGC9FJKcKRI1gPA1FA7to0oCFPtt+0OY5eS1
         xGQ2Tgwk1alcYFUU/U2RnmH2dHMHGJ1P+LBEh1CcaApcC9FSco8w35HWyKd38GIfUwfL
         2byw==
X-Forwarded-Encrypted: i=1; AJvYcCXc++6TmG+kgxif9MY1jBTU4jzVfpBOUM51JmHPOBeYo+izmZBHpP+yKcdmHKOu8gh2dtvwylVaA1aBQLY4@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOZd824s+QDMfSYaO9Y6LqxohojbFAUtw4fNUOfTZrvDCtWPa
	lzKr8gv5qP7bUB9tBV/iIgN0De+gS4pl6kMzM6bLykXbqu8O2zwyWxD6z+mCuE8A8USkeaN5bQU
	fWFTnr63r1/hLZ5Q6ICs18zT2lSWhK14=
X-Gm-Gg: ASbGnctLf5erP0ADumYpuxLFf+Dvjd0JLEyBIRQHHA1/Q4pTrrwDrJ3kNf6DFA6qA6A
	B2pQMn+cTa6E6oYssNHp8lD930GTDdVSlxFGS60Fu34EHv/IHd6dbDC0CTPkk1XaV+NTcq+Livy
	sjPuSDWwV2mmfxasGEs5tQ09EVfJpwuDh3Rpll7YLfCJ76DoTw1muR5+XqS8k3+zitlN6xW5IVA
	g23UkIr1pK5G2zA7fsWwmUewXMdrFt0JsxnGOuFm62o49FHhn/jt6dWmHJ9k8kXUoL2e66aMD+2
X-Google-Smtp-Source: AGHT+IFN0lWUZVs/WVv/Qu/CwpWBii81YJlPh5d7x3tSME5nVWHmo1MmfU3PT29jUszYNf1rlxPoUkNoUaeEmsx5bQQ=
X-Received: by 2002:aa7:c543:0:b0:633:b513:c5be with SMTP id
 4fb4d7f45d1cf-6349fa24029mr14012148a12.14.1759218378617; Tue, 30 Sep 2025
 00:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-11-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-11-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Sep 2025 09:46:07 +0200
X-Gm-Features: AS18NWCvC6fexHkOJlKDza-hcLoLd43NKoQhvs-gwZjfhb0pkLuaqyll2LkUcGY
Message-ID: <CAOQ4uxhftW72em_nQRcxREprYrJM591C6WrAvjxzQYdX4XRPwA@mail.gmail.com>
Subject: Re: [PATCH 10/11] Add start_renaming_two_dentrys()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> A few callers want to lock for a rename and already have both dentrys.
> Also debugfs does want to perform a lookup but doesn't want permission
> checking, so start_renaming_dentry() cannot be used.
>
> This patch introduces start_renaming_two_dentrys() which is given both
> dentrys.  debugfs performs one lookup itself.  As it will only continue
> with a negative dentry and as those cannot be renamed or unlinked, it is
> safe to do the lookup before getting the rename locks.
>
> overlayfs uses start_renaming_two_dentrys() in three places and  selinux
> uses it twice in sel_make_policy_nodes().
>

start_renaming_two_dentries() please

> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/debugfs/inode.c           | 48 +++++++++++++--------------
>  fs/namei.c                   | 63 ++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/dir.c           | 42 ++++++++++++++++--------
>  include/linux/namei.h        |  2 ++
>  security/selinux/selinuxfs.c | 27 ++++++++++------
>  5 files changed, 133 insertions(+), 49 deletions(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b863c8d0cbcd..2aad67b8174e 100644
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
> +       error =3D start_renaming_two_dentrys(&rd, dentry, target);
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
> index aca6de83d255..23f9adb43401 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3892,6 +3892,69 @@ int start_renaming_dentry(struct renamedata *rd, i=
nt lookup_flags,
>         return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_=
last);
>  }
>
> +/**
> + * start_renaming_two_dentrys - Lock to dentries in given parents for re=
name

two_dentries please

> + * @rd:           rename data containing parent
> + * @old_dentry:   dentry of name to move
> + * @new_dentry:   dentry to move to
> + *
> + * Ensure locks are in place for rename and check parentage is still cor=
rect.
> + *
> + * On success the two dentrys are stored in @rd.old_dentry and @rd.new_d=
entry and
> + * @rd.old_parent and @rd.new_parent are confirmed to be the parents of =
the dentruies.

typo: dentruies

> + *
> + * References and the lock can be dropped with end_renaming()
> + *
> + * Returns: zero or an error.
> + */
> +int
> +start_renaming_two_dentrys(struct renamedata *rd,
> +                          struct dentry *old_dentry, struct dentry *new_=
dentry)
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

This asymmetry between old_parent and new_parent is especially
odd with two dentries and particularly with RENAME_EXCHANGE
where the two dentries are alike.

Is the old_parent ref really needed?

> +       return 0;
> +
> +out_unlock:
> +       unlock_rename(old_dentry->d_parent, rd->new_parent);
> +       return err;
> +}

needs EXPORT_GPL

> +
>  void end_renaming(struct renamedata *rd)
>  {
>         unlock_rename(rd->old_parent, rd->new_parent);
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 54423ad00e1c..e8c369e3e277 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -125,6 +125,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, stru=
ct dentry *dir,
>                              struct dentry *dentry)
>  {
>         struct dentry *whiteout;
> +       struct renamedata rd =3D {};
>         int err;
>         int flags =3D 0;
>
> @@ -136,10 +137,13 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>         if (d_is_dir(dentry))
>                 flags =3D RENAME_EXCHANGE;
>
> -       err =3D ovl_lock_rename_workdir(ofs->workdir, whiteout, dir, dent=
ry);
> +       rd.old_parent =3D ofs->workdir;
> +       rd.new_parent =3D dir;
> +       rd.flags =3D flags;
> +       err =3D start_renaming_two_dentrys(&rd, whiteout, dentry);
>         if (!err) {
> -               err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, d=
entry, flags);
> -               unlock_rename(ofs->workdir, dir);
> +               err =3D ovl_do_rename_rd(&rd);
> +               end_renaming(&rd);
>         }
>         if (err)
>                 goto kill_whiteout;
> @@ -363,6 +367,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *workdir =3D ovl_workdir(dentry);
>         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> +       struct renamedata rd =3D {};
>         struct path upperpath;
>         struct dentry *upper;
>         struct dentry *opaquedir;
> @@ -388,7 +393,11 @@ static struct dentry *ovl_clear_empty(struct dentry =
*dentry,
>         if (IS_ERR(opaquedir))
>                 goto out;
>
> -       err =3D ovl_lock_rename_workdir(workdir, opaquedir, upperdir, upp=
er);
> +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +       rd.old_parent =3D workdir;
> +       rd.new_parent =3D upperdir;
> +       rd.flags =3D RENAME_EXCHANGE;
> +       err =3D start_renaming_two_dentrys(&rd, opaquedir, upper);
>         if (err)
>                 goto out_cleanup_unlocked;
>
> @@ -406,8 +415,8 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>         if (err)
>                 goto out_cleanup;
>
> -       err =3D ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, R=
ENAME_EXCHANGE);
> -       unlock_rename(workdir, upperdir);
> +       err =3D ovl_do_rename_rd(&rd);
> +       end_renaming(&rd);
>         if (err)
>                 goto out_cleanup_unlocked;
>
> @@ -420,7 +429,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>         return opaquedir;
>
>  out_cleanup:
> -       unlock_rename(workdir, upperdir);
> +       end_renaming(&rd);
>  out_cleanup_unlocked:
>         ovl_cleanup(ofs, workdir, opaquedir);
>         dput(opaquedir);
> @@ -443,6 +452,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *workdir =3D ovl_workdir(dentry);
>         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> +       struct renamedata rd =3D {};
>         struct dentry *upper;
>         struct dentry *newdentry;
>         int err;
> @@ -474,7 +484,11 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
>         if (IS_ERR(newdentry))
>                 goto out_dput;
>
> -       err =3D ovl_lock_rename_workdir(workdir, newdentry, upperdir, upp=
er);
> +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +       rd.old_parent =3D workdir;
> +       rd.new_parent =3D upperdir;
> +       rd.flags =3D 0;
> +       err =3D start_renaming_two_dentrys(&rd, newdentry, upper);
>         if (err)
>                 goto out_cleanup_unlocked;
>
> @@ -511,16 +525,16 @@ static int ovl_create_over_whiteout(struct dentry *=
dentry, struct inode *inode,
>                 if (err)
>                         goto out_cleanup;
>
> -               err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper,
> -                                   RENAME_EXCHANGE);
> -               unlock_rename(workdir, upperdir);
> +               rd.flags =3D RENAME_EXCHANGE;
> +               err =3D ovl_do_rename_rd(&rd);
> +               end_renaming(&rd);
>                 if (err)
>                         goto out_cleanup_unlocked;
>
>                 ovl_cleanup(ofs, workdir, upper);
>         } else {
> -               err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper, 0);
> -               unlock_rename(workdir, upperdir);
> +               err =3D ovl_do_rename_rd(&rd);
> +               end_renaming(&rd);
>                 if (err)
>                         goto out_cleanup_unlocked;
>         }
> @@ -540,7 +554,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>         return err;
>
>  out_cleanup:
> -       unlock_rename(workdir, upperdir);
> +       end_renaming(&rd);
>  out_cleanup_unlocked:
>         ovl_cleanup(ofs, workdir, newdentry);
>         dput(newdentry);

ovl changes look fine to me.

with change of helper name and typo fixes feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Thanks,
Amir.

