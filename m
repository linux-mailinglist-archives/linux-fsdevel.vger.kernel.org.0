Return-Path: <linux-fsdevel+bounces-7348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF763823CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 08:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F592285800
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD3200A7;
	Thu,  4 Jan 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbEef6mt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234D1F951;
	Thu,  4 Jan 2024 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67fa018c116so1204856d6.3;
        Wed, 03 Jan 2024 23:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704354378; x=1704959178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8JWWAcW5U6HoZv2tvwhmzksu600dRorErCbol8G1zE=;
        b=AbEef6mtA7KVNzB4ChdJGxpc2d/Fh4KkMFEFxssJPaxkpVlQMZg11j4u5313SvAgFD
         Ark8CDW099l/H65/PN0vvi6E1YQu2xtC0t86Q/M0jab6HAxuyE6pLtTB8GcXgwY0LO/D
         PPyIvqboMtu8PH4A4+3fRwlLQD2y2JiPGmqYH8ZBWKdyKXZ7m2xqrbrNUjaUReOWhUND
         woqn8tITH0SYK0ZcuYvE0BwobehrTQxexnfTxFV1NgcQCHBUrcvSSISVb+SzrO1PJ6do
         9bf4BvAmkAwHjeBdf1EMVjPopiWN/14yFgGWrlO14shbms7ZSCsyaWrdZ5RLSwPZdz+R
         /I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354378; x=1704959178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8JWWAcW5U6HoZv2tvwhmzksu600dRorErCbol8G1zE=;
        b=SeWlQQW1WvmONQa/XWP05XOKYvhGo9jnK7Gb8sYO80SIgnOOAtGs30RCsoJmerg+jJ
         rTkgYETXQpSWaLjQY4BFNEBSReY+jgLkMY0rjxJVKv3evykcnRM5egtV8Bq+a5faqLZx
         27UiG9YxLYAka/P/Fffv71cw690Ae0n8e6ZkSItHOwickIOMtO6NwyCrr+GmX6yAG12t
         SgvXt8OFvzXN3nBGXCtprLX7fJbz9gHa7mvkmM5cArOx0C8A41GT30GxhlwYEk2upPth
         2QSRAggR9w7U2P/JefmpPI7mEtjdJZXnifCUnD7P7+JI8462nvYnAxR1/O/mezzWoE/E
         s0nA==
X-Gm-Message-State: AOJu0YyYIatfC1nenZcg6sj/mNDZoBhIzlf0Pi0MIllpKeSMXHJCy4Mh
	y0UwSOw+samaa2InfjLyI0Yy4cbusqVa2G547rY=
X-Google-Smtp-Source: AGHT+IHnOSLvO5jpQ5cp++B0F0q5nQavs+ClEJ6yaOyBITA3vDzkdwt8QOPHM03MOVWA4J9aOSj2dk6ijzrICPgEy+A=
X-Received: by 2002:ad4:5b85:0:b0:680:d27c:a416 with SMTP id
 5-20020ad45b85000000b00680d27ca416mr252921qvp.107.1704354378515; Wed, 03 Jan
 2024 23:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170429478711.50646.12675561629884992953.stgit@bazille.1015granger.net>
 <170429518465.50646.9482690519449281531.stgit@bazille.1015granger.net> <276a17ed09cf6d53d17292b5182a8e08695251a4.camel@kernel.org>
In-Reply-To: <276a17ed09cf6d53d17292b5182a8e08695251a4.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Jan 2024 09:46:07 +0200
Message-ID: <CAOQ4uxhKVaL3gvwrURSWFSBf2HH6vg0qwM1LVPkmQLfnvTPrdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fs: Create a generic is_dot_dotdot() utility
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 9:08=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2024-01-03 at 10:19 -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > De-duplicate the same functionality in several places by hoisting
> > the is_dot_dotdot() function into linux/fs.h.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/crypto/fname.c    |    8 +-------
> >  fs/ecryptfs/crypto.c |   10 ----------
> >  fs/exportfs/expfs.c  |    4 +---
> >  fs/f2fs/f2fs.h       |   11 -----------
> >  include/linux/fs.h   |    9 +++++++++
> >  5 files changed, 11 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> > index 7b3fc189593a..0ad52fbe51c9 100644
> > --- a/fs/crypto/fname.c
> > +++ b/fs/crypto/fname.c
> > @@ -74,13 +74,7 @@ struct fscrypt_nokey_name {
> >
> >  static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
> >  {
> > -     if (str->len =3D=3D 1 && str->name[0] =3D=3D '.')
> > -             return true;
> > -
> > -     if (str->len =3D=3D 2 && str->name[0] =3D=3D '.' && str->name[1] =
=3D=3D '.')
> > -             return true;
> > -
> > -     return false;
> > +     return is_dot_dotdot(str->name, str->len);
> >  }
> >
> >  /**
> > diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> > index 03bd55069d86..2fe0f3af1a08 100644
> > --- a/fs/ecryptfs/crypto.c
> > +++ b/fs/ecryptfs/crypto.c
> > @@ -1949,16 +1949,6 @@ int ecryptfs_encrypt_and_encode_filename(
> >       return rc;
> >  }
> >
> > -static bool is_dot_dotdot(const char *name, size_t name_size)
> > -{
> > -     if (name_size =3D=3D 1 && name[0] =3D=3D '.')
> > -             return true;
> > -     else if (name_size =3D=3D 2 && name[0] =3D=3D '.' && name[1] =3D=
=3D '.')
> > -             return true;
> > -
> > -     return false;
> > -}
> > -
> >  /**
> >   * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher =
text name to decoded plaintext
> >   * @plaintext_name: The plaintext name
> > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > index 84af58eaf2ca..07ea3d62b298 100644
> > --- a/fs/exportfs/expfs.c
> > +++ b/fs/exportfs/expfs.c
> > @@ -255,9 +255,7 @@ static bool filldir_one(struct dir_context *ctx, co=
nst char *name, int len,
> >               container_of(ctx, struct getdents_callback, ctx);
> >
> >       buf->sequence++;
> > -     /* Ignore the '.' and '..' entries */
> > -     if ((len > 2 || name[0] !=3D '.' || (len =3D=3D 2 && name[1] !=3D=
 '.')) &&
> > -         buf->ino =3D=3D ino && len <=3D NAME_MAX) {
> > +     if (buf->ino =3D=3D ino && len <=3D NAME_MAX && !is_dot_dotdot(na=
me, len)) {
> >               memcpy(buf->name, name, len);
> >               buf->name[len] =3D '\0';
> >               buf->found =3D 1;
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9043cedfa12b..322a3b8a3533 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3368,17 +3368,6 @@ static inline bool f2fs_cp_error(struct f2fs_sb_=
info *sbi)
> >       return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
> >  }
> >
> > -static inline bool is_dot_dotdot(const u8 *name, size_t len)
> > -{
> > -     if (len =3D=3D 1 && name[0] =3D=3D '.')
> > -             return true;
> > -
> > -     if (len =3D=3D 2 && name[0] =3D=3D '.' && name[1] =3D=3D '.')
> > -             return true;
> > -
> > -     return false;
> > -}
> > -
> >  static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
> >                                       size_t size, gfp_t flags)
> >  {
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 98b7a7a8c42e..179eea797c22 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2846,6 +2846,15 @@ extern bool path_is_under(const struct path *, c=
onst struct path *);
> >
> >  extern char *file_path(struct file *, char *, int);
> >
> > +static inline bool is_dot_dotdot(const char *name, size_t len)
> > +{
> > +     if (len =3D=3D 1 && name[0] =3D=3D '.')
> > +             return true;
> > +     if (len =3D=3D 2 && name[0] =3D=3D '.' && name[1] =3D=3D '.')
> > +             return true;
> > +     return false;
> > +}
> > +
> >  #include <linux/err.h>
> >
> >  /* needed for stackable file system support */
> >
> >
>
> Looks good to me. I took a quick look to see if there were other open-
> coded versions, but I didn't see any.
>

The outstanding open-coded version that wasn't deduped is in
lookup_one_common(), which is the version that Trond used and
mentioned in his patch.

It is also a slightly more "efficient" version, but I have no idea if
that really matters.

In any case, having lookup_one_common() and get_name() use
the same helper is clearly prefered, because the check in lookup_one()
is the declared reason for the get_name() patch.

Thanks,
Amir.

