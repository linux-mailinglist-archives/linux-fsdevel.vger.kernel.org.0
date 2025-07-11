Return-Path: <linux-fsdevel+bounces-54600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA4B0177D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE8A1C26DE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E632279DBD;
	Fri, 11 Jul 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxQ5CNbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFE279903;
	Fri, 11 Jul 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225670; cv=none; b=IrRWKeNFS2bpMWSPauHnvrq+AdFf3qcV65MoOerUq4XmBuc8N9IFnqSA8uuxhCpSj9mp/TZYIWvNKMB+2VyZSafHbeEnj8GpIGVqCjzyrMiussfFkjbCl9a6p2wGIsinVSX6zPwNB84OMZKX6ECvGF4+uVSoT4Is7WNLuzCcgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225670; c=relaxed/simple;
	bh=SQSY+yJcJgb25frE63fDGNycze80thMjpkH9vZYE1vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWOi6Rnn44auA1/lhlxKIuULbDStiAyM0CD1gSuo25yobTGUH24aKHIiC3nPMRg+mlbbIpXVGn3q9iSGrmhlUMWiQYANLzOZWELMPnMtWtX4HPcBMrJeBZ7NFOtVcbw0gORmuHBtQsQHxvYbJx+CIhJMn0Vom8WZd+nikzn8Z6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxQ5CNbm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso321627966b.3;
        Fri, 11 Jul 2025 02:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752225667; x=1752830467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbgQwgv86/5VVckypbyscciQa25651fNokB4l5TD2PE=;
        b=DxQ5CNbmILtaMSFqzCs2kuLa2OliXfYsIcnUTETpBZK+ofMvmEAIel+alv2Bg0dCwF
         P4CkQy/A8IDSCUigDk5NoYWCQDk3+JaxhDfAwl/yU5d/w2EdB8yB8szBCZrtUbIqqMrE
         BTixA5jsKpkKemFYM46b1RQpCMcTX+xYmmtI/JQ40hshy1TW5VQNMhbbetlqyXRIx7Ch
         R4/3JOvS/8cTg4cBncLPjoFVcgmbHv5sOxQqzhn44Hu9rU+FxeU3flcWEySMtLhX9wBj
         FIFKTRck9Eajsh1yENOsdhCBzYC8PpsDOk7pJ+zTpQ5a3O0sietNYl+yEPa4wsOicPUE
         1zTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752225667; x=1752830467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbgQwgv86/5VVckypbyscciQa25651fNokB4l5TD2PE=;
        b=tauobyhGYUodshgdWDlnwxoovL4FtAdc756sqGlErwH1GvynoYigVkC+CsfJAmVHtf
         J9FOLYr8xQ8Rf4YNPfVdXmWdDNaLsIGXylTehm2zOOuPNgA6N+Cvpq/EHdXkqCLjmYrx
         PTF2n9m79vSf9Saz31H8VlwSuMSRPr9Scf8gB0cfBnSKb+G++2N3wIbc3L+XZj6k24b4
         tOWr0Jvqwu0OHEU32bdT0SMy1cTRBBPxw8kdgpfptGWSSq0hKc7qoaJW4jmh1Pxp7BFq
         /cQtR+yWvuKwH21kJlSllA9wVC+k+hR6mns2JQ0+Xcg+oUDTtUAnd9pjamWlLDrHd7rR
         4ueg==
X-Forwarded-Encrypted: i=1; AJvYcCU7bIb1xBJlsvpleyYhBaxQD0JagKtKbRyOcDILr+dYO8gvFVS8OMepyK1zU3yQm4EuuR4t5vkVbQYdr+xWDQ==@vger.kernel.org, AJvYcCWg2V3X8MUWz6laZXR/fM700P1hBtxBWISdpSi5a2vm4uJIKneFcbyZ1MvrfHyvqbCLdMNJI2nisa76IFxE@vger.kernel.org, AJvYcCXtmupcDA7RvnL6E8vOtyK24QxP0nvNu7mZu/H7oVDQ22j/vR2yUod9uMcY1vKpr4EolwcBDeUo089GhjaR@vger.kernel.org
X-Gm-Message-State: AOJu0YzznILTbc0aMJUvnHO57c0MNJO/vjGwSiMvztUOAENJltb3JoXX
	g7hMR5LNRSIXOyNr4GvU8fhSBLNcz25EC5jR23nJlLT2pgp2UM0VIUi4KsdDyh+RQMkSexbxT/g
	phzakC+QB+i6d4xY03aayMuCNplV9T8s=
X-Gm-Gg: ASbGncvzFbaTamwSLfSYokeTk2ad98gvjRAsbqTpBi4jpIuHS47jDbfZdmE9F+e/64l
	75KoTqdMQLfFdvYXQSEkrAsEiI3OkiEgvek091VxdxlBuyPHKoMr4SZnmCiuwFAZa+Goo/77CeH
	vSDte7OhfUOdk2ZVwLYcgaBmONY7KA9mDzEyP09kd4sKhyXTQA2zuIMVN64coXHPrmzk3baaq+Q
	2hFlsI=
X-Google-Smtp-Source: AGHT+IE8buR3tJCkIr8cAbGvc2ORbqJ8LUgtLVahQ80ZgCCcwYfluCn3E+tMNcHxUmPo384/tuhLUlR7hIk7gNL9BvY=
X-Received: by 2002:a17:907:2da3:b0:ae0:ce40:11c6 with SMTP id
 a640c23a62f3a-ae6fbd9c1camr267563166b.21.1752225666700; Fri, 11 Jul 2025
 02:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
 <20250409-tonyk-overlayfs-v1-2-3991616fe9a3@igalia.com> <CAOQ4uxit5nYeGPN1_uB7c37=eKQi_T-0LtoQaTZHVisAUDoBsg@mail.gmail.com>
In-Reply-To: <CAOQ4uxit5nYeGPN1_uB7c37=eKQi_T-0LtoQaTZHVisAUDoBsg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 11:20:55 +0200
X-Gm-Features: Ac12FXy38P3vrL06knTn6rpiQBvERA0QEnB7JcRW5AyvK5K5AUV-tM7LzbviHb0
Message-ID: <CAOQ4uxgzT1R-u9-ZFHbW7koFV+o-Ow-k=eAwfKBc18cQe2DW4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] ovl: Make ovl_dentry_weird() accept casefold dentries
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:11=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Wed, Apr 9, 2025 at 5:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
> >
> > ovl_dentry_weird() is used to avoid problems with filesystems that has
> > their d_hash and d_compare implementations. Create an exception for thi=
s
> > function, where only casefold filesystems are eligible to use their own
> > d_hash and d_compare functions, allowing to support casefold
> > filesystems.
>
> What do you mean by this sentence?
> Any casefold fs can be on any layer?
> All layers on the same casefold sb? same casefold fstype?
>
>
> >
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> >  fs/overlayfs/namei.c     | 11 ++++++-----
> >  fs/overlayfs/overlayfs.h |  2 +-
> >  fs/overlayfs/params.c    |  3 ++-
> >  fs/overlayfs/util.c      | 12 +++++++-----
> >  4 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> > index be5c65d6f8484b1fba6b3fee379ba1d034c0df8a..140bc609ffebe00151cbb44=
6720f5106dbeb2ef2 100644
> > --- a/fs/overlayfs/namei.c
> > +++ b/fs/overlayfs/namei.c
> > @@ -192,7 +192,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *of=
s, struct ovl_fh *fh,
> >                 return real;
> >         }
> >
> > -       if (ovl_dentry_weird(real)) {
> > +       if (ovl_dentry_weird(real, ofs)) {
> >                 dput(real);
> >                 return NULL;
> >         }
> > @@ -244,7 +244,7 @@ static int ovl_lookup_single(struct dentry *base, s=
truct ovl_lookup_data *d,
> >                 goto out_err;
> >         }
> >
> > -       if (ovl_dentry_weird(this)) {
> > +       if (ovl_dentry_weird(this, ofs)) {
> >                 /* Don't support traversing automounts and other weirdn=
ess */
> >                 err =3D -EREMOTE;
> >                 goto out_err;
> > @@ -365,6 +365,7 @@ static int ovl_lookup_data_layer(struct dentry *den=
try, const char *redirect,
> >                                  struct path *datapath)
> >  {
> >         int err;
> > +       struct ovl_fs *ovl =3D OVL_FS(layer->fs->sb);
>
> ofs please
>
> >
> >         err =3D vfs_path_lookup(layer->mnt->mnt_root, layer->mnt, redir=
ect,
> >                         LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS | LOOKUP_NO=
_XDEV,
> > @@ -376,7 +377,7 @@ static int ovl_lookup_data_layer(struct dentry *den=
try, const char *redirect,
> >                 return err;
> >
> >         err =3D -EREMOTE;
> > -       if (ovl_dentry_weird(datapath->dentry))
> > +       if (ovl_dentry_weird(datapath->dentry, ovl))
> >                 goto out_path_put;
> >
> >         err =3D -ENOENT;
> > @@ -767,7 +768,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs,=
 struct ovl_fh *fh)
> >
> >         if (ovl_is_whiteout(index))
> >                 err =3D -ESTALE;
> > -       else if (ovl_dentry_weird(index))
> > +       else if (ovl_dentry_weird(index, ofs))
> >                 err =3D -EIO;
> >         else
> >                 return index;
> > @@ -815,7 +816,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs,=
 struct dentry *upper,
> >                 dput(index);
> >                 index =3D ERR_PTR(-ESTALE);
> >                 goto out;
> > -       } else if (ovl_dentry_weird(index) || ovl_is_whiteout(index) ||
> > +       } else if (ovl_dentry_weird(index, ofs) || ovl_is_whiteout(inde=
x) ||
> >                    inode_wrong_type(inode, d_inode(origin)->i_mode)) {
> >                 /*
> >                  * Index should always be of the same file type as orig=
in
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 6f2f8f4cfbbc177fbd5441483395d7ff72efe332..f3de013517598c44c15ca9f=
950f6c2f0a5c2084b 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -445,7 +445,7 @@ void ovl_dentry_init_reval(struct dentry *dentry, s=
truct dentry *upperdentry,
> >                            struct ovl_entry *oe);
> >  void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upper=
dentry,
> >                            struct ovl_entry *oe, unsigned int mask);
> > -bool ovl_dentry_weird(struct dentry *dentry);
> > +bool ovl_dentry_weird(struct dentry *dentry, struct ovl_fs *ovl);
> >  enum ovl_path_type ovl_path_type(struct dentry *dentry);
> >  void ovl_path_upper(struct dentry *dentry, struct path *path);
> >  void ovl_path_lower(struct dentry *dentry, struct path *path);
> > diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> > index 6759f7d040c89d3b3c01572579c854a900411157..459e8bddf1777c12c9fa0bd=
fc150e2ea22eaafc3 100644
> > --- a/fs/overlayfs/params.c
> > +++ b/fs/overlayfs/params.c
> > @@ -277,6 +277,7 @@ static int ovl_mount_dir_check(struct fs_context *f=
c, const struct path *path,
> >                                enum ovl_opt layer, const char *name, bo=
ol upper)
> >  {
> >         struct ovl_fs_context *ctx =3D fc->fs_private;
> > +       struct ovl_fs *ovl =3D fc->s_fs_info;
>
> ofs pls
>
> >
> >         if (!d_is_dir(path->dentry))
> >                 return invalfc(fc, "%s is not a directory", name);
> > @@ -290,7 +291,7 @@ static int ovl_mount_dir_check(struct fs_context *f=
c, const struct path *path,
> >         if (sb_has_encoding(path->mnt->mnt_sb))
> >                 return invalfc(fc, "case-insensitive capable filesystem=
 on %s not supported", name);

I wonder how did your tests pass with this ^^^^
Please rebase your patches on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvfs-6.=
17.file
which changes this test to ovl_dentry_casefolded()
but you need to change this logic anyway.

> >
> > -       if (ovl_dentry_weird(path->dentry))
> > +       if (ovl_dentry_weird(path->dentry, ovl))
> >                 return invalfc(fc, "filesystem on %s not supported", na=
me);
> >
> >         /*
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 0819c739cc2ffce0dfefa84d3ff8f9f103eec191..4dd523a1a13ab0a6cf51d96=
7d0b712873e6d8580 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -200,15 +200,17 @@ void ovl_dentry_init_flags(struct dentry *dentry,=
 struct dentry *upperdentry,
> >         spin_unlock(&dentry->d_lock);
> >  }
> >
> > -bool ovl_dentry_weird(struct dentry *dentry)
> > +bool ovl_dentry_weird(struct dentry *dentry, struct ovl_fs *ovl)
>
> ovl_fs *ofs as first argument please
>

Please don't forget to address those nits also.

Thanks,
Amir.

