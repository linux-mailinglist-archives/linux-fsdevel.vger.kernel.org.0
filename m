Return-Path: <linux-fsdevel+bounces-54786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4F8B0340C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 03:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22D13AB0D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 01:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2FC19AD90;
	Mon, 14 Jul 2025 01:00:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C2194A45;
	Mon, 14 Jul 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454833; cv=none; b=HQJL35nhTlrr+JZcZKGC5VqZUjg0DxYzviRgWzV90T0Wcqcka6SKbA7lxiVv4kOd2ZizkVLDkqZS4KUOvardJcfOMJ/GtHbu90m8OG44E/TE3WmLsxr0gDXE9OA/kHK2yCMTf1HRYPBbNroJcCrj6TD2u/7eWJ54NC4DL9s20Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454833; c=relaxed/simple;
	bh=nO1cJ0spI6VrbFKvCNUcC5RJMbikG75K0u7UCS7YvtE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XmhhZBVLHqA0hSoBM6g8Yj3FuFpLZQOJZXV0D3lTxIqbHuRkcYcEiWxoYZdBL6rp8fWwZkqT2yJJ09JjnhRGPnfAIeUgxtUlK6bVTUc4aXlSVIZgiVirqOBG2RbCPJHPqICQeuzEFD9hLL6bi2E2K+ZhFIT5MxNDA6bCUVUJl0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub7YR-001vsu-Hq;
	Mon, 14 Jul 2025 01:00:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/20] ovl: narrow locking in ovl_rename()
In-reply-to:
 <CAOQ4uxiRBS14KdZRY4ad_6cOZ+u3dZp+0C+8WYjJ=qmqhjqQTg@mail.gmail.com>
References:
 <>, <CAOQ4uxiRBS14KdZRY4ad_6cOZ+u3dZp+0C+8WYjJ=qmqhjqQTg@mail.gmail.com>
Date: Mon, 14 Jul 2025 11:00:29 +1000
Message-id: <175245482902.2234665.10015695984345104010@noble.neil.brown.name>

On Fri, 11 Jul 2025, Amir Goldstein wrote:
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > Drop the rename lock immediately after the rename, and use
> > ovl_cleanup_unlocked() for cleanup.
> >
> > This makes way for future changes where locks are taken on individual
> > dentries rather than the whole directory.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/dir.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 687d5e12289c..d01e83f9d800 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -1262,9 +1262,10 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
> >                             new_upperdir, newdentry, flags);
> >         if (err)
> >                 goto out_dput;
> > +       unlock_rename(new_upperdir, old_upperdir);
> >
> >         if (cleanup_whiteout)
> > -               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> > +               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
> >
> >         if (overwrite && d_inode(new)) {
> >                 if (new_is_dir)
> > @@ -1283,12 +1284,8 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
> >         if (d_inode(new) && ovl_dentry_upper(new))
> >                 ovl_copyattr(d_inode(new));
> >
> > -out_dput:
> >         dput(newdentry);
> > -out_dput_old:
> >         dput(olddentry);
> > -out_unlock:
> > -       unlock_rename(new_upperdir, old_upperdir);
> >  out_revert_creds:
> >         ovl_revert_creds(old_cred);
> >         if (update_nlink)
> > @@ -1299,6 +1296,14 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
> >         dput(opaquedir);
> >         ovl_cache_free(&list);
> >         return err;
> > +
> > +out_dput:
> > +       dput(newdentry);
> > +out_dput_old:
> > +       dput(olddentry);
> > +out_unlock:
> > +       unlock_rename(new_upperdir, old_upperdir);
> > +       goto out_revert_creds;
> >  }
> >
> >  static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
> > --
> > 2.49.0
> >
>=20
> I think we get end up with fewer and clearer to understand goto labels
> with a relatively simple trick:
>=20
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index fe493f3ed6b6..7cddaa7b263e 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1069,8 +1069,8 @@ static int ovl_rename(struct mnt_idmap *idmap,
> struct inode *olddir,
>         int err;
>         struct dentry *old_upperdir;
>         struct dentry *new_upperdir;
> -       struct dentry *olddentry;
> -       struct dentry *newdentry;
> +       struct dentry *olddentry =3D NULL;
> +       struct dentry *newdentry =3D NULL;
>         struct dentry *trap;
>         bool old_opaque;
>         bool new_opaque;
> @@ -1187,18 +1187,22 @@ static int ovl_rename(struct mnt_idmap *idmap,
> struct inode *olddir,
>         olddentry =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
>                                      old->d_name.len);
>         err =3D PTR_ERR(olddentry);
> -       if (IS_ERR(olddentry))
> +       if (IS_ERR(olddentry)) {
> +               olddentry =3D NULL;
>                 goto out_unlock;
> +       }
>=20
>         err =3D -ESTALE;
>         if (!ovl_matches_upper(old, olddentry))
> -               goto out_dput_old;
> +               goto out_unlock;
>=20
>         newdentry =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
>                                      new->d_name.len);
>         err =3D PTR_ERR(newdentry);
> -       if (IS_ERR(newdentry))
> -               goto out_dput_old;
> +       if (IS_ERR(newdentry)) {
> +               newdentry =3D NULL;
> +               goto out_unlock;
> +       }
>=20
>         old_opaque =3D ovl_dentry_is_opaque(old);
>         new_opaque =3D ovl_dentry_is_opaque(new);
> @@ -1207,28 +1211,28 @@ static int ovl_rename(struct mnt_idmap *idmap,
> struct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new)) {
>                 if (opaquedir) {
>                         if (newdentry !=3D opaquedir)
> -                               goto out_dput;
> +                               goto out_unlock;
>                 } else {
>                         if (!ovl_matches_upper(new, newdentry))
> -                               goto out_dput;
> +                               goto out_unlock;
>                 }
>         } else {
>                 if (!d_is_negative(newdentry)) {
>                         if (!new_opaque || !ovl_upper_is_whiteout(ofs,
> newdentry))
> -                               goto out_dput;
> +                               goto out_unlock;
>                 } else {
>                         if (flags & RENAME_EXCHANGE)
> -                               goto out_dput;
> +                               goto out_unlock;
>                 }
>         }
>=20
>         if (olddentry =3D=3D trap)
> -               goto out_dput;
> +               goto out_unlock;
>         if (newdentry =3D=3D trap)
> -               goto out_dput;
> +               goto out_unlock;
>=20
>         if (olddentry->d_inode =3D=3D newdentry->d_inode)
> -               goto out_dput;
> +               goto out_unlock;
>=20
>         err =3D 0;
>         if (ovl_type_merge_or_lower(old))
> @@ -1236,7 +1240,7 @@ static int ovl_rename(struct mnt_idmap *idmap,
> struct inode *olddir,
>         else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
>                 err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
>=20
>         if (!overwrite && ovl_type_merge_or_lower(new))
>                 err =3D ovl_set_redirect(new, samedir);
> @@ -1244,15 +1248,16 @@ static int ovl_rename(struct mnt_idmap *idmap,
> struct inode *olddir,
>                  ovl_type_merge(old->d_parent))
>                 err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
>=20
>         err =3D ovl_do_rename(ofs, old_upperdir->d_inode, olddentry,
>                             new_upperdir->d_inode, newdentry, flags);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
> +       unlock_rename(new_upperdir, old_upperdir);
>=20
>         if (cleanup_whiteout)
> -               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> +               ovl_cleanup_unlocked(ofs, old_upperdir->d_inode, newdentry);
>=20
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
> @@ -1271,12 +1276,6 @@ static int ovl_rename(struct mnt_idmap *idmap,
> struct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new))
>                 ovl_copyattr(d_inode(new));
>=20
> -out_dput:
> -       dput(newdentry);
> -out_dput_old:
> -       dput(olddentry);
> -out_unlock:
> -       unlock_rename(new_upperdir, old_upperdir);
>  out_revert_creds:
>         ovl_revert_creds(old_cred);
>         if (update_nlink)
> @@ -1284,9 +1283,15 @@ static int ovl_rename(struct mnt_idmap *idmap,
> struct inode *olddir,
>         else
>                 ovl_drop_write(old);
>  out:
> +       dput(newdentry);
> +       dput(olddentry);
>         dput(opaquedir);
>         ovl_cache_free(&list);
>         return err;
> +
> +out_unlock:
> +       unlock_rename(new_upperdir, old_upperdir);
> +       goto out_revert_creds;
>  }
>=20

I decided to make the goto changed into a separate patch as follows.  My
version is slightly different to yours (see new var "de").

Thanks,
NeilBrown

From: NeilBrown <neil@brown.name>
Date: Mon, 14 Jul 2025 10:44:03 +1000
Subject: [PATCH] ovl: simplify gotos in ovl_rename()

Rather than having three separate goto label: out_unlock, out_dput_old,
and out_dput, make use of that fact that dput() happily accepts a NULL
point to reduce this to just one goto label: out_unlock.

olddentry and newdentry are initialised to NULL and only set once a
value dentry is found.  They are then put late in the function.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index e094adf9d169..63460bdd71cf 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1082,9 +1082,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct i=
node *olddir,
 	int err;
 	struct dentry *old_upperdir;
 	struct dentry *new_upperdir;
-	struct dentry *olddentry;
-	struct dentry *newdentry;
-	struct dentry *trap;
+	struct dentry *olddentry =3D NULL;
+	struct dentry *newdentry =3D NULL;
+	struct dentry *trap, *de;
 	bool old_opaque;
 	bool new_opaque;
 	bool cleanup_whiteout =3D false;
@@ -1197,21 +1197,23 @@ static int ovl_rename(struct mnt_idmap *idmap, struct=
 inode *olddir,
 		goto out_revert_creds;
 	}
=20
-	olddentry =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
-				     old->d_name.len);
-	err =3D PTR_ERR(olddentry);
-	if (IS_ERR(olddentry))
+	de =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
+			      old->d_name.len);
+	err =3D PTR_ERR(de);
+	if (IS_ERR(de))
 		goto out_unlock;
+	olddentry =3D de;
=20
 	err =3D -ESTALE;
 	if (!ovl_matches_upper(old, olddentry))
-		goto out_dput_old;
+		goto out_unlock;
=20
-	newdentry =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
-				     new->d_name.len);
-	err =3D PTR_ERR(newdentry);
-	if (IS_ERR(newdentry))
-		goto out_dput_old;
+	de =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
+			      new->d_name.len);
+	err =3D PTR_ERR(de);
+	if (IS_ERR(de))
+		goto out_unlock;
+	newdentry =3D de;
=20
 	old_opaque =3D ovl_dentry_is_opaque(old);
 	new_opaque =3D ovl_dentry_is_opaque(new);
@@ -1220,28 +1222,28 @@ static int ovl_rename(struct mnt_idmap *idmap, struct=
 inode *olddir,
 	if (d_inode(new) && ovl_dentry_upper(new)) {
 		if (opaquedir) {
 			if (newdentry !=3D opaquedir)
-				goto out_dput;
+				goto out_unlock;
 		} else {
 			if (!ovl_matches_upper(new, newdentry))
-				goto out_dput;
+				goto out_unlock;
 		}
 	} else {
 		if (!d_is_negative(newdentry)) {
 			if (!new_opaque || !ovl_upper_is_whiteout(ofs, newdentry))
-				goto out_dput;
+				goto out_unlock;
 		} else {
 			if (flags & RENAME_EXCHANGE)
-				goto out_dput;
+				goto out_unlock;
 		}
 	}
=20
 	if (olddentry =3D=3D trap)
-		goto out_dput;
+		goto out_unlock;
 	if (newdentry =3D=3D trap)
-		goto out_dput;
+		goto out_unlock;
=20
 	if (olddentry->d_inode =3D=3D newdentry->d_inode)
-		goto out_dput;
+		goto out_unlock;
=20
 	err =3D 0;
 	if (ovl_type_merge_or_lower(old))
@@ -1249,7 +1251,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct i=
node *olddir,
 	else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
 		err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
 	if (err)
-		goto out_dput;
+		goto out_unlock;
=20
 	if (!overwrite && ovl_type_merge_or_lower(new))
 		err =3D ovl_set_redirect(new, samedir);
@@ -1257,12 +1259,12 @@ static int ovl_rename(struct mnt_idmap *idmap, struct=
 inode *olddir,
 		 ovl_type_merge(old->d_parent))
 		err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
 	if (err)
-		goto out_dput;
+		goto out_unlock;
=20
 	err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
 			    new_upperdir, newdentry, flags);
 	if (err)
-		goto out_dput;
+		goto out_unlock;
=20
 	if (cleanup_whiteout)
 		ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
@@ -1284,10 +1286,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct =
inode *olddir,
 	if (d_inode(new) && ovl_dentry_upper(new))
 		ovl_copyattr(d_inode(new));
=20
-out_dput:
-	dput(newdentry);
-out_dput_old:
-	dput(olddentry);
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
@@ -1297,6 +1295,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct i=
node *olddir,
 	else
 		ovl_drop_write(old);
 out:
+	dput(newdentry);
+	dput(olddentry);
 	dput(opaquedir);
 	ovl_cache_free(&list);
 	return err;
--=20
2.49.0


