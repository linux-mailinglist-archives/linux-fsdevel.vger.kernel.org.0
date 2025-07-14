Return-Path: <linux-fsdevel+bounces-54794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C76B0357B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364027A988A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A091F8AD3;
	Mon, 14 Jul 2025 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2PzNYSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1418D;
	Mon, 14 Jul 2025 05:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469992; cv=none; b=kOjyzA3UNY0avdaDglxu1P97a+XInUgl5idOCOBiK6apxmNdAgtU3dnBWyrlxxrR9UsUx4z7Y1lud7gbmVi+4lFERJUolAG8RCrFhMWqLFmSSZzNsjfocIrmEfjfhbztR+/RmmlIsBGcJxv03v3d+c2Ux5oCIdK4rYUzeL7QDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469992; c=relaxed/simple;
	bh=ENmvx67fsgv6fuBClIhQsXaS3rlJFils+eJ4SGGiaCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUjuKxbB58SwTCk5coztdG3/HHCIytu5NlKlu8GMO0PxENQQKAO6JKmVUNpxZ3Wc7kUIMQD48LYkHbLjXywSsoDh2E7ErYbvqW16XCJSv5wKwsjPp6Pm3fZy5ySkCoHQkazqdeJ541sw0LIEW37apy7epzUr8eY3sYk2TstbxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2PzNYSd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so7454638a12.2;
        Sun, 13 Jul 2025 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752469989; x=1753074789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl1z5l0SKOhbQO2EGhfHhGja92omHGzvOiHGOzxnwgo=;
        b=k2PzNYSds6iLOJGVB1C6ip3970RH3cRXe797/oQEbOpO3Dj49rD8qKNMp2GX5q795w
         6MPXpsTH+wI0pqDk3b/BczUyblHoHbRhH8EuInDUtr9aNSmv1jJU7rkh9iaWbZLGpdtg
         nDqhrhJ8L6Qc/F01ksgrG7663O41Cd4h72YqOBNizhnwBAEUVV8zIyYmxkQQtUNrUh+f
         8LKOQs+vx1cqbgyvDS4eDj5c7U6V5tGKiJTNNNy0/uR+5dhlhlwVrpJvasedQSWfNO5i
         owKPY26LX+jFIFnoAkOKbhKi6j1eKEjsY8yMCCsfvtp2B+5wXG0XaVReHNuxY2NuhxO8
         C4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752469989; x=1753074789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hl1z5l0SKOhbQO2EGhfHhGja92omHGzvOiHGOzxnwgo=;
        b=IVutaZpbgYCADNsuT/uzEvF2771WSwEgP2ZJbHWdRFhVAabiFqqPoThewGeGlk9/Gf
         UHidPr7HT7a2bCBtVteYKe8XXKg7fANvBzxZozXA1MFcyZD2QcL1jv/WNHq3su/9EMDa
         X5EJtVf6qVQTiqJ7duSuhUnT+bpOhzZ7tzHWxSlE7DpE2D9+pmFThhooiEmq3Gkh12NV
         N0hRTFISLlF5GMyUgrO4GkA886Kz5ao0kXFRqiOd8NGV/dudFlOZyAxVigrCCDvf/PIC
         F6V7w505Jq85Q76XvgMvpy4OCRn7HFJeMERKe7qFQ0Cvoc3IRm+NU1d1XV80QQ4n3wMG
         NJiw==
X-Forwarded-Encrypted: i=1; AJvYcCU+xC35xfglZTFJP/365GvSRotCeNJtzs3H3InjouWSE1OnYeCArndUfwsS8kXcM4owkYQYi7Pp4yJHrDEF@vger.kernel.org, AJvYcCVT4BC599LfR2KZZMI22XJTIgckboOsJCsraIQtW8omUjdkkkR1lCa6dsVceLY8VJnWNqARi7RlhPAVcbxQzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23jTTFQHLXIrIAspmRAFK7zy4fxTo91fa1EqJ94V3qa2nbBMh
	OO+xUXbBlLlkoWDq5+KHA8of+hL4rOVQdDjPMBH+ZyDgHa5Rdvfz5di/Qtn1RqCxAHmgUlyqyU4
	REYc1UbVkAN98pbH1lXZETzrcKF4i5zHU79bVi6o=
X-Gm-Gg: ASbGncvnTIUioEETEE5sEy/k4lePlkS67y9PvidIdb8bXDk6rwFJKR+MuU3DHyo3Bq0
	OPMPKMjZYas6/FrRn3o5lObfwAsTv2UG67/jyHoOLTLYM4Pz/V3xtEzwu7j1O+1AvoPD9IyLiOm
	pr79a1se3rFxZhgIgQ+2Hmlz70NmKOmRTFgyrI7AvC3kPO+EtGZFLcvrZI0f/zOtCZb1g8J0T8v
	EsO4OM=
X-Google-Smtp-Source: AGHT+IFIyVuP6+Ff9qNzxtWF308BWUTm/GluwOv9WoRp0THhqnjpacttXqTyICaC4rfJZIz4u+2skhqwk3h8jxneS24=
X-Received: by 2002:a17:907:3d9f:b0:ae9:a1f1:2b7d with SMTP id
 a640c23a62f3a-ae9a1f12fd1mr210595466b.17.1752469988004; Sun, 13 Jul 2025
 22:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxiRBS14KdZRY4ad_6cOZ+u3dZp+0C+8WYjJ=qmqhjqQTg@mail.gmail.com>
 <175245482902.2234665.10015695984345104010@noble.neil.brown.name>
In-Reply-To: <175245482902.2234665.10015695984345104010@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Jul 2025 07:12:56 +0200
X-Gm-Features: Ac12FXyPuHiDm1nA9uTTau156wFc8gM-JF5hkAhVOEtnQCvKfri4YfcTRLkDcvg
Message-ID: <CAOQ4uxjJNYq++u98B2LZ-xQTNXu3zAX92xZLy=sLaN6q0QeMsA@mail.gmail.com>
Subject: Re: [PATCH 08/20] ovl: narrow locking in ovl_rename()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 3:00=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Fri, 11 Jul 2025, Amir Goldstein wrote:
> > On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > Drop the rename lock immediately after the rename, and use
> > > ovl_cleanup_unlocked() for cleanup.
> > >
> > > This makes way for future changes where locks are taken on individual
> > > dentries rather than the whole directory.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/overlayfs/dir.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index 687d5e12289c..d01e83f9d800 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -1262,9 +1262,10 @@ static int ovl_rename(struct mnt_idmap *idmap,=
 struct inode *olddir,
> > >                             new_upperdir, newdentry, flags);
> > >         if (err)
> > >                 goto out_dput;
> > > +       unlock_rename(new_upperdir, old_upperdir);
> > >
> > >         if (cleanup_whiteout)
> > > -               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> > > +               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
> > >
> > >         if (overwrite && d_inode(new)) {
> > >                 if (new_is_dir)
> > > @@ -1283,12 +1284,8 @@ static int ovl_rename(struct mnt_idmap *idmap,=
 struct inode *olddir,
> > >         if (d_inode(new) && ovl_dentry_upper(new))
> > >                 ovl_copyattr(d_inode(new));
> > >
> > > -out_dput:
> > >         dput(newdentry);
> > > -out_dput_old:
> > >         dput(olddentry);
> > > -out_unlock:
> > > -       unlock_rename(new_upperdir, old_upperdir);
> > >  out_revert_creds:
> > >         ovl_revert_creds(old_cred);
> > >         if (update_nlink)
> > > @@ -1299,6 +1296,14 @@ static int ovl_rename(struct mnt_idmap *idmap,=
 struct inode *olddir,
> > >         dput(opaquedir);
> > >         ovl_cache_free(&list);
> > >         return err;
> > > +
> > > +out_dput:
> > > +       dput(newdentry);
> > > +out_dput_old:
> > > +       dput(olddentry);
> > > +out_unlock:
> > > +       unlock_rename(new_upperdir, old_upperdir);
> > > +       goto out_revert_creds;
> > >  }
> > >
> > >  static int ovl_create_tmpfile(struct file *file, struct dentry *dent=
ry,
> > > --
> > > 2.49.0
> > >
> >
> > I think we get end up with fewer and clearer to understand goto labels
> > with a relatively simple trick:
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index fe493f3ed6b6..7cddaa7b263e 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -1069,8 +1069,8 @@ static int ovl_rename(struct mnt_idmap *idmap,
> > struct inode *olddir,
> >         int err;
> >         struct dentry *old_upperdir;
> >         struct dentry *new_upperdir;
> > -       struct dentry *olddentry;
> > -       struct dentry *newdentry;
> > +       struct dentry *olddentry =3D NULL;
> > +       struct dentry *newdentry =3D NULL;
> >         struct dentry *trap;
> >         bool old_opaque;
> >         bool new_opaque;
> > @@ -1187,18 +1187,22 @@ static int ovl_rename(struct mnt_idmap *idmap,
> > struct inode *olddir,
> >         olddentry =3D ovl_lookup_upper(ofs, old->d_name.name, old_upper=
dir,
> >                                      old->d_name.len);
> >         err =3D PTR_ERR(olddentry);
> > -       if (IS_ERR(olddentry))
> > +       if (IS_ERR(olddentry)) {
> > +               olddentry =3D NULL;
> >                 goto out_unlock;
> > +       }
> >
> >         err =3D -ESTALE;
> >         if (!ovl_matches_upper(old, olddentry))
> > -               goto out_dput_old;
> > +               goto out_unlock;
> >
> >         newdentry =3D ovl_lookup_upper(ofs, new->d_name.name, new_upper=
dir,
> >                                      new->d_name.len);
> >         err =3D PTR_ERR(newdentry);
> > -       if (IS_ERR(newdentry))
> > -               goto out_dput_old;
> > +       if (IS_ERR(newdentry)) {
> > +               newdentry =3D NULL;
> > +               goto out_unlock;
> > +       }
> >
> >         old_opaque =3D ovl_dentry_is_opaque(old);
> >         new_opaque =3D ovl_dentry_is_opaque(new);
> > @@ -1207,28 +1211,28 @@ static int ovl_rename(struct mnt_idmap *idmap,
> > struct inode *olddir,
> >         if (d_inode(new) && ovl_dentry_upper(new)) {
> >                 if (opaquedir) {
> >                         if (newdentry !=3D opaquedir)
> > -                               goto out_dput;
> > +                               goto out_unlock;
> >                 } else {
> >                         if (!ovl_matches_upper(new, newdentry))
> > -                               goto out_dput;
> > +                               goto out_unlock;
> >                 }
> >         } else {
> >                 if (!d_is_negative(newdentry)) {
> >                         if (!new_opaque || !ovl_upper_is_whiteout(ofs,
> > newdentry))
> > -                               goto out_dput;
> > +                               goto out_unlock;
> >                 } else {
> >                         if (flags & RENAME_EXCHANGE)
> > -                               goto out_dput;
> > +                               goto out_unlock;
> >                 }
> >         }
> >
> >         if (olddentry =3D=3D trap)
> > -               goto out_dput;
> > +               goto out_unlock;
> >         if (newdentry =3D=3D trap)
> > -               goto out_dput;
> > +               goto out_unlock;
> >
> >         if (olddentry->d_inode =3D=3D newdentry->d_inode)
> > -               goto out_dput;
> > +               goto out_unlock;
> >
> >         err =3D 0;
> >         if (ovl_type_merge_or_lower(old))
> > @@ -1236,7 +1240,7 @@ static int ovl_rename(struct mnt_idmap *idmap,
> > struct inode *olddir,
> >         else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent)=
)
> >                 err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
> >         if (err)
> > -               goto out_dput;
> > +               goto out_unlock;
> >
> >         if (!overwrite && ovl_type_merge_or_lower(new))
> >                 err =3D ovl_set_redirect(new, samedir);
> > @@ -1244,15 +1248,16 @@ static int ovl_rename(struct mnt_idmap *idmap,
> > struct inode *olddir,
> >                  ovl_type_merge(old->d_parent))
> >                 err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
> >         if (err)
> > -               goto out_dput;
> > +               goto out_unlock;
> >
> >         err =3D ovl_do_rename(ofs, old_upperdir->d_inode, olddentry,
> >                             new_upperdir->d_inode, newdentry, flags);
> >         if (err)
> > -               goto out_dput;
> > +               goto out_unlock;
> > +       unlock_rename(new_upperdir, old_upperdir);
> >
> >         if (cleanup_whiteout)
> > -               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> > +               ovl_cleanup_unlocked(ofs, old_upperdir->d_inode, newden=
try);
> >
> >         if (overwrite && d_inode(new)) {
> >                 if (new_is_dir)
> > @@ -1271,12 +1276,6 @@ static int ovl_rename(struct mnt_idmap *idmap,
> > struct inode *olddir,
> >         if (d_inode(new) && ovl_dentry_upper(new))
> >                 ovl_copyattr(d_inode(new));
> >
> > -out_dput:
> > -       dput(newdentry);
> > -out_dput_old:
> > -       dput(olddentry);
> > -out_unlock:
> > -       unlock_rename(new_upperdir, old_upperdir);
> >  out_revert_creds:
> >         ovl_revert_creds(old_cred);
> >         if (update_nlink)
> > @@ -1284,9 +1283,15 @@ static int ovl_rename(struct mnt_idmap *idmap,
> > struct inode *olddir,
> >         else
> >                 ovl_drop_write(old);
> >  out:
> > +       dput(newdentry);
> > +       dput(olddentry);
> >         dput(opaquedir);
> >         ovl_cache_free(&list);
> >         return err;
> > +
> > +out_unlock:
> > +       unlock_rename(new_upperdir, old_upperdir);
> > +       goto out_revert_creds;
> >  }
> >
>
> I decided to make the goto changed into a separate patch as follows.

Good idea.

> My version is slightly different to yours (see new var "de").
>

Looks nicer.

Thanks,
Amir.

> Thanks,
> NeilBrown
>
> From: NeilBrown <neil@brown.name>
> Date: Mon, 14 Jul 2025 10:44:03 +1000
> Subject: [PATCH] ovl: simplify gotos in ovl_rename()
>
> Rather than having three separate goto label: out_unlock, out_dput_old,
> and out_dput, make use of that fact that dput() happily accepts a NULL
> point to reduce this to just one goto label: out_unlock.
>
> olddentry and newdentry are initialised to NULL and only set once a
> value dentry is found.  They are then put late in the function.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c | 54 +++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index e094adf9d169..63460bdd71cf 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1082,9 +1082,9 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         int err;
>         struct dentry *old_upperdir;
>         struct dentry *new_upperdir;
> -       struct dentry *olddentry;
> -       struct dentry *newdentry;
> -       struct dentry *trap;
> +       struct dentry *olddentry =3D NULL;
> +       struct dentry *newdentry =3D NULL;
> +       struct dentry *trap, *de;
>         bool old_opaque;
>         bool new_opaque;
>         bool cleanup_whiteout =3D false;
> @@ -1197,21 +1197,23 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>                 goto out_revert_creds;
>         }
>
> -       olddentry =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdi=
r,
> -                                    old->d_name.len);
> -       err =3D PTR_ERR(olddentry);
> -       if (IS_ERR(olddentry))
> +       de =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
> +                             old->d_name.len);
> +       err =3D PTR_ERR(de);
> +       if (IS_ERR(de))
>                 goto out_unlock;
> +       olddentry =3D de;
>
>         err =3D -ESTALE;
>         if (!ovl_matches_upper(old, olddentry))
> -               goto out_dput_old;
> +               goto out_unlock;
>
> -       newdentry =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdi=
r,
> -                                    new->d_name.len);
> -       err =3D PTR_ERR(newdentry);
> -       if (IS_ERR(newdentry))
> -               goto out_dput_old;
> +       de =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
> +                             new->d_name.len);
> +       err =3D PTR_ERR(de);
> +       if (IS_ERR(de))
> +               goto out_unlock;
> +       newdentry =3D de;
>
>         old_opaque =3D ovl_dentry_is_opaque(old);
>         new_opaque =3D ovl_dentry_is_opaque(new);
> @@ -1220,28 +1222,28 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
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
>                         if (!new_opaque || !ovl_upper_is_whiteout(ofs, ne=
wdentry))
> -                               goto out_dput;
> +                               goto out_unlock;
>                 } else {
>                         if (flags & RENAME_EXCHANGE)
> -                               goto out_dput;
> +                               goto out_unlock;
>                 }
>         }
>
>         if (olddentry =3D=3D trap)
> -               goto out_dput;
> +               goto out_unlock;
>         if (newdentry =3D=3D trap)
> -               goto out_dput;
> +               goto out_unlock;
>
>         if (olddentry->d_inode =3D=3D newdentry->d_inode)
> -               goto out_dput;
> +               goto out_unlock;
>
>         err =3D 0;
>         if (ovl_type_merge_or_lower(old))
> @@ -1249,7 +1251,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
>                 err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
>
>         if (!overwrite && ovl_type_merge_or_lower(new))
>                 err =3D ovl_set_redirect(new, samedir);
> @@ -1257,12 +1259,12 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>                  ovl_type_merge(old->d_parent))
>                 err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
>
>         err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
>                             new_upperdir, newdentry, flags);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
>
>         if (cleanup_whiteout)
>                 ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> @@ -1284,10 +1286,6 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new))
>                 ovl_copyattr(d_inode(new));
>
> -out_dput:
> -       dput(newdentry);
> -out_dput_old:
> -       dput(olddentry);
>  out_unlock:
>         unlock_rename(new_upperdir, old_upperdir);
>  out_revert_creds:
> @@ -1297,6 +1295,8 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         else
>                 ovl_drop_write(old);
>  out:
> +       dput(newdentry);
> +       dput(olddentry);
>         dput(opaquedir);
>         ovl_cache_free(&list);
>         return err;
> --
> 2.49.0
>

