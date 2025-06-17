Return-Path: <linux-fsdevel+bounces-51837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D7AADC12D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 07:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DA53AE3B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4AA23B611;
	Tue, 17 Jun 2025 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekbZIMJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758514A09C;
	Tue, 17 Jun 2025 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750136921; cv=none; b=CwIzAyCVsxV1Ne2uDWbFBi2JCYyiejaLzkvwWH1NUnu7+nY+1/7CneVKzhTHRjCaUcJUzuqIhnBIQwC2tNFOvvSZVxf5Eb6uLvZzhS1uXbAoftCPahwtOzKxjLvdMfeINPPzK5cj+gzDgW6N/xTeZqLOVEcE+/Cj9ohJc/vTfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750136921; c=relaxed/simple;
	bh=bl+wQOG/YTu+p7IqZ4udIhLI7a6kbV+hlxc2ZJpROso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zdb/pI9qLUJV0B3LmcZdvo05EQh6UqHdlc/UWvKV1q2M0OXlLennrAnKlXcH2FJT0USBTTmwemd0h6yqPnSioLotrZ5B/kjaaX6WJFPQBIZRVfa+ADTjwBSnNEBNQnZpIwJfgDZvETUlbkwYtIZHpxnJYuw51LUnY3Xw3IifRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekbZIMJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB445C4CEF3;
	Tue, 17 Jun 2025 05:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750136920;
	bh=bl+wQOG/YTu+p7IqZ4udIhLI7a6kbV+hlxc2ZJpROso=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ekbZIMJcRVe+dojIqmAuqdH1BMQYae73Fck5FJqWZACFn8R9LXAWSpT7ON04yYGh0
	 feEKJhlGRBrRf7H+2fDFKAG+DbB3pCEqO1SlT8MmwK+KZ1LSE+ZNOz/xkri/i5lwHY
	 ciFw3LHR6Hb0sWLsm9uK4NoyQ7YDoyeXX/RB6LgcnMFc2jw1R3tOraTX+TUKHsEOA4
	 EeXq6hpoD1oF3G3bhcYK83PzLTauxy/knB5kIuq/NeMnV5+xFviDV1AaVVOG/p4/Ri
	 mgHFlKFb4+67LEv3OBFZ0W9hab8dar4W04Ntng0M8J4LnVDE6x4kQ+8+CR2u9eXYXM
	 eWWu6VAF11q4g==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a43afb04a7so39704281cf.0;
        Mon, 16 Jun 2025 22:08:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+A6H7YsQP7k9c7ztaFQTI25GuJMyUQSCXjblR0UOZWT0Rd1KJzGeoiiK1bZCLcd7AEpw37KznmGCzojHIiGUjJGlFAgdx@vger.kernel.org, AJvYcCVnCKJVe1jAsk8oMGJckvSt4Aq7iHxrcTMtbm+IY85MbYFia+AJ+j+s+it8nbG9WowpmoTO3Qx4NpYVMzVn@vger.kernel.org, AJvYcCWGRUeN/G5MfiGKW2aj9T6n366qN6f0ohPFD4NbCOZQ99t8oV1d4nUngaA1pA3hn9ocRpxCQoDvk0/G9VlF@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoRjVbO/6+OFIaQtXfUgLU2kaLOqvPeolWDf95tVUwrleb4kS
	2svQYDMC1eTpiUJ8+qseGais9Zsly3eSNytnxMSpPh7wa4h/hg5uzKKnzIawKkCe0ilJ6WTmE+7
	LslJ+/tzCHmB9Izd2ZlkHfxsjIq7e1Ts=
X-Google-Smtp-Source: AGHT+IGV2ZQU5FEHR/is6f/JD89L4SCHZd4XCDGZ/qKtzhWxHrZxgM66En+qs2O2CLJ5ZITT0gAb1nHZP6JsA1Z/d4s=
X-Received: by 2002:a05:622a:1486:b0:494:7ca0:2ff with SMTP id
 d75a77b69052e-4a73c4beca6mr160152421cf.15.1750136919637; Mon, 16 Jun 2025
 22:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611220220.3681382-1-song@kernel.org> <20250611220220.3681382-2-song@kernel.org>
 <75ea3f6b-cf5b-4e97-9214-cbd3f299008c@maowtm.org>
In-Reply-To: <75ea3f6b-cf5b-4e97-9214-cbd3f299008c@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Mon, 16 Jun 2025 22:08:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4a9kUyNhw1kZuyrFLsWF4-FseT0Cb2PK1TpZ6VZmT1AQ@mail.gmail.com>
X-Gm-Features: AX0GCFs1Hp3je6LWKk-M4nBzwlFIO9mQlPC-AG9o6-qRVlulmxfFOuTV6afNyKQ
Message-ID: <CAPhsuW4a9kUyNhw1kZuyrFLsWF4-FseT0Cb2PK1TpZ6VZmT1AQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
To: Tingmao Wang <m@maowtm.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com, 
	neil@brown.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 11:36=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote:
>
> On 6/11/25 23:02, Song Liu wrote:
> > This helper walks an input path to its parent. Logic are added to handl=
e
> > walking across mount tree.
> >
> > This will be used by landlock, and BPF LSM.
> >
> > Suggested-by: Neil Brown <neil@brown.name>
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  fs/namei.c            | 99 +++++++++++++++++++++++++++++++++++++------
> >  include/linux/namei.h |  2 +
> >  2 files changed, 87 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 4bb889fc980b..bc65361c5d13 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2048,36 +2048,107 @@ static struct dentry *follow_dotdot_rcu(struct=
 nameidata *nd)
> >       return nd->path.dentry;
> >  }
> >
> > -static struct dentry *follow_dotdot(struct nameidata *nd)
> > +/**
> > + * __path_walk_parent - Find the parent of the given struct path
> > + * @path  - The struct path to start from
> > + * @root  - A struct path which serves as a boundary not to be crosses=
.
> > + *        - If @root is zero'ed, walk all the way to global root.
> > + * @flags - Some LOOKUP_ flags.
> > + *
> > + * Find and return the dentry for the parent of the given path
> > + * (mount/dentry). If the given path is the root of a mounted tree, it
> > + * is first updated to the mount point on which that tree is mounted.
> > + *
> > + * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a =
new
> > + * mount, the error EXDEV is returned.
> > + *
> > + * If no parent can be found, either because the tree is not mounted o=
r
> > + * because the @path matches the @root, then @path->dentry is returned
> > + * unless @flags contains %LOOKUP_BENEATH, in which case -EXDEV is ret=
urned.
> > + *
> > + * Returns: either an ERR_PTR() or the chosen parent which will have h=
ad
> > + * the refcount incremented.
> > + */
> > +static struct dentry *__path_walk_parent(struct path *path, const stru=
ct path *root, int flags)
> >  {
> >       struct dentry *parent;
> >
> > -     if (path_equal(&nd->path, &nd->root))
> > +     if (path_equal(path, root))
> >               goto in_root;
> > -     if (unlikely(nd->path.dentry =3D=3D nd->path.mnt->mnt_root)) {
> > -             struct path path;
> > +     if (unlikely(path->dentry =3D=3D path->mnt->mnt_root)) {
> > +             struct path new_path;
> >
> > -             if (!choose_mountpoint(real_mount(nd->path.mnt),
> > -                                    &nd->root, &path))
> > +             if (!choose_mountpoint(real_mount(path->mnt),
> > +                                    root, &new_path))
> >                       goto in_root;
> > -             path_put(&nd->path);
> > -             nd->path =3D path;
> > -             nd->inode =3D path.dentry->d_inode;
> > -             if (unlikely(nd->flags & LOOKUP_NO_XDEV))
> > +             path_put(path);
> > +             *path =3D new_path;
> > +             if (unlikely(flags & LOOKUP_NO_XDEV))
> >                       return ERR_PTR(-EXDEV);
> >       }
> >       /* rare case of legitimate dget_parent()... */
> > -     parent =3D dget_parent(nd->path.dentry);
> > -     if (unlikely(!path_connected(nd->path.mnt, parent))) {
> > +     parent =3D dget_parent(path->dentry);
> > +     if (unlikely(!path_connected(path->mnt, parent))) {
>
> This is checking path_connected here but also in follow_dotdot,
> path_connected is checked again. Is this check meant to be here?  It will
> also change the landlock behaviour right?

Good catch! Removed the check in v5.

>
> (For some reason patch 2 rejects when I tried to apply it on v6.16-rc1, s=
o
> I haven't actually tested this patch to see if this is really an issue)
>
> >               dput(parent);
> >               return ERR_PTR(-ENOENT);
> >       }
> >       return parent;
> >
> >  in_root:
> > -     if (unlikely(nd->flags & LOOKUP_BENEATH))
> > +     if (unlikely(flags & LOOKUP_BENEATH))
> >               return ERR_PTR(-EXDEV);
> > -     return dget(nd->path.dentry);
> > +     return dget(path->dentry);
> > +}
> > +
> > +/**
> > + * path_walk_parent - Walk to the parent of path
> > + * @path: input and output path.
> > + * @root: root of the path walk, do not go beyond this root. If @root =
is
> > + *        zero'ed, walk all the way to real root.
> > + *
> > + * Given a path, find the parent path. Replace @path with the parent p=
ath.
> > + * If we were already at the real root or a disconnected root, @path i=
s
> > + * released and zero'ed.
> > + *
> > + * Returns:
> > + *  true  - if @path is updated to its parent.
> > + *  false - if @path is already the root (real root or @root).
> > + */
> > +bool path_walk_parent(struct path *path, const struct path *root)
> > +{
> > +     struct dentry *parent;
> > +
> > +     parent =3D __path_walk_parent(path, root, LOOKUP_BENEATH);
> > +
> > +     if (IS_ERR(parent))
> > +             goto false_out;
> > +
> > +     if (parent =3D=3D path->dentry) {
> > +             dput(parent);
> > +             goto false_out;
> > +     }
> > +     dput(path->dentry);
> > +     path->dentry =3D parent;
> > +     return true;
> > +
> > +false_out:
> > +     path_put(path);
> > +     memset(path, 0, sizeof(*path));
> > +     return false;
> > +}
> > +
> > +static struct dentry *follow_dotdot(struct nameidata *nd)
> > +{
> > +     struct dentry *parent =3D __path_walk_parent(&nd->path, &nd->root=
, nd->flags);
> > +
> > +     if (IS_ERR(parent))
> > +             return parent;
> > +     if (unlikely(!path_connected(nd->path.mnt, parent))) {
> > +             dput(parent);
> > +             return ERR_PTR(-ENOENT);
> > +     }
> > +     nd->inode =3D nd->path.dentry->d_inode;
> > +     return parent;
> >  }
> >
> >  static const char *handle_dots(struct nameidata *nd, int type)
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 5d085428e471..cba5373ecf86 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
> >  extern int follow_down(struct path *path, unsigned int flags);
> >  extern int follow_up(struct path *);
> >
> > +bool path_walk_parent(struct path *path, const struct path *root);
> > +
> >  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
> >  extern struct dentry *lock_rename_child(struct dentry *, struct dentry=
 *);
> >  extern void unlock_rename(struct dentry *, struct dentry *);
>

