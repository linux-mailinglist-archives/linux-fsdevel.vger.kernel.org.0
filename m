Return-Path: <linux-fsdevel+bounces-68480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26816C5D046
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36899350E13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF5313522;
	Fri, 14 Nov 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBh9ztrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE83191F91
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122060; cv=none; b=qpqisgAiX+P0n11OvwRuJ965ZiWsyBIuC3J4MkpJ3DdcNOt64rzxRalkEAWQqOhfUItaN+/rTXZevhpE2m8HFEA4HbMFRpdjqcs29+ektkLZzKW4tNJPg48z7TRO2EEdTd5pqNQi2BSeObY+hSkTmaeuSflgnp1KUBR/486lQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122060; c=relaxed/simple;
	bh=nS8fwHEQj4VeU7JYF+1Vur6CmNLUaf0gsfVJCcbwq0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOPK1r0lVjZzDe1V4TqcSvYBqxDSKam6KYSwli+615M6doW0CCamq3NtC8BHJZDo7GCC3ueDWbXPmacm1VGIRtVJVXyUYWsUeN/Gk8tvFegKHE3J9JVWijpHOSLDAgQ/TKqr1Y2LY8GTGfx2cLpFr3gJTNuaehx+cYGairsKzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBh9ztrX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso3347295a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763122057; x=1763726857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7c2Or+t9SJ4JcJ4QHM6wwh2YCSGgVhmzcFUnOogJw4=;
        b=eBh9ztrXrgyTOFo/9pfsoB5YEPHa0/IOKwy8HLFxx3/VfX7gpfrtM9Bv0J2Ar0MmUf
         UUlt8YHdDBZnn0r2qGER3sqOqsQeZSQbyS/vNO1JVz0rTjcaamqDeFz6AS1BphYqOOOb
         XF5stBFl3mQDpeKeu5hQYZjM+lOkCJo49/Vh6a6hLb7MJb5pT0U+z47sUx5Ssv0/oSV4
         IymUPgGGq+f5QfDSXOzaGQkklBrMY7KHpqzJQ2hJISE6DjwP4D1pljeirKlkqjT311N6
         KGa0y0+HfsvhDG8FnTzR5fMcbSHltEE2cf6RFOyBkNqC+ABwGSpMb1gO+pbXdUY4FGXY
         UM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122057; x=1763726857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7c2Or+t9SJ4JcJ4QHM6wwh2YCSGgVhmzcFUnOogJw4=;
        b=Dn6hYWCOVuQ4LbpyN3+u5KLbdg/ygOLakBoN1WkqlCjixsMDlNE0RbIuJuI6QuXJ5a
         XU5KzSiMqVncieLcLAs47DbotMQbALd7DLDfkKmCLQ/2gYJSY663GfumuX/RQj1YLSet
         p7d9bSRnFn61QkXDrjiEJj8dF4hQCt2a1WLGd3zuTlZNsrCOsu29lpMzryrOoHcJvY+1
         P3GReuC4nF8FjE5P7puiZVkEtNR317+l3dOs9o3bcJOr6YqEXe/4CaHadgKE+smj6HBG
         SnZDG4hIvYbFUqPuvNMbZR/+yoD+rGyRfICzFwWV1vWv8LLZnOy9G4kYMYNquqIneaDO
         dV5g==
X-Forwarded-Encrypted: i=1; AJvYcCViNXN00a7+L26xqWgGNz7wVfSxVAGiWl6fObjIwI3wR3k7ztIzD8K1YqwAEjbhrBzZH0IYYoC7eef4o1kt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjj7g8hQoooc/T9BKuVvyVgnkAaiu74cytvTWG3tmNlcYlST6V
	LbKb26D6Py6brFnjp6rFu6DztTjFcD+KNpvsL3Xs4LQKTbeMbOtvTf283GBJdsgKrmyykvZpb3s
	JpVRElEJU269jURR3XWSW0rQtFrdFsfQ=
X-Gm-Gg: ASbGncsVdT4JJ2lj2iFpdmkWtBDoZwP5kAbJsxSF50YWV8870HdBPXqzW2nkI7EFpz8
	Doiv7g5L4Upk0Beb8N9tc9EtU3czYpk1b/0ZeW7cPHemnaAzxjZqM66nzpiFUcbanhBMwUfIPgd
	+gnXjbJyR8ZmflLWH5CdvgsGnms6xEYEZxvH8ZKHM3DztNwN44q732oHaYi75LZlolieQhind7D
	MfPOt1LWi6REQJlUgBRzp6Ta1kH5ieiz1KjAFrdouUYyXk34up4VZzH/H7mwwh5Ddbwn4hARXMg
	ZQcpxDZ+Lxj8mxd1GGk=
X-Google-Smtp-Source: AGHT+IHgxAhdbgMpAOpIU/vg0eaXb2xu5A3f/rcYvzKrOMUJkbv7i4ilBYyFXDvbZh3aSGwZg+9SiGNuMyf5t8+4Zi8=
X-Received: by 2002:a05:6402:4504:b0:643:5884:b4a6 with SMTP id
 4fb4d7f45d1cf-6435884b979mr1313605a12.31.1763122057402; Fri, 14 Nov 2025
 04:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
 <20251114-work-ovl-cred-guard-prepare-v1-3-4fc1208afa3d@kernel.org>
 <CAOQ4uxhB2am_xAGugZvAiuEx7ud+8QGPJBwcA+M+LmRvWC-nsA@mail.gmail.com> <20251114-gasleitung-muffel-2a5478a34a6b@brauner>
In-Reply-To: <20251114-gasleitung-muffel-2a5478a34a6b@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 13:07:25 +0100
X-Gm-Features: AWmQ_bnsXv9Z9oRwqDJ96sy0kp-0qOvb1j0w_1F3esqg2JheMpC50V3b9oI_8i8
Message-ID: <CAOQ4uxie_CSG7kPBCZaKEfiQmLH7EAcMqrHXvy78ciLqX4QuKA@mail.gmail.com>
Subject: Re: [PATCH 3/6] ovl: reflow ovl_create_or_link()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:00=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Nov 14, 2025 at 12:52:58PM +0100, Amir Goldstein wrote:
> > On Fri, Nov 14, 2025 at 11:15=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > Reflow the creation routine in preparation of porting it to a guard.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/overlayfs/dir.c | 23 +++++++++++++++--------
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index a276eafb5e78..ff30a91e07f8 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -644,14 +644,23 @@ static const struct cred *ovl_setup_cred_for_cr=
eate(struct dentry *dentry,
> > >         return override_cred;
> > >  }
> > >
> > > +static int do_ovl_create_or_link(struct dentry *dentry, struct inode=
 *inode,
> > > +                                struct ovl_cattr *attr)
> >
> > Trying to avert the bikesheding over do_ovl_ helper name...
> >
> > > +{
> > > +       if (!ovl_dentry_is_whiteout(dentry))
> > > +               return ovl_create_upper(dentry, inode, attr);
> > > +
> > > +       return ovl_create_over_whiteout(dentry, inode, attr);
> > > +}
> > > +
> > >  static int ovl_create_or_link(struct dentry *dentry, struct inode *i=
node,
> > >                               struct ovl_cattr *attr, bool origin)
> > >  {
> > >         int err;
> > > -       const struct cred *new_cred __free(put_cred) =3D NULL;
> > >         struct dentry *parent =3D dentry->d_parent;
> > >
> > >         scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
> > > +               const struct cred *new_cred __free(put_cred) =3D NULL=
;
> > >                 /*
> > >                  * When linking a file with copy up origin into a new=
 parent, mark the
> > >                  * new parent dir "impure".
> > > @@ -662,7 +671,6 @@ static int ovl_create_or_link(struct dentry *dent=
ry, struct inode *inode,
> > >                                 return err;
> > >                 }
> > >
> > > -               if (!attr->hardlink) {
> > >                 /*
> > >                  * In the creation cases(create, mkdir, mknod, symlin=
k),
> > >                  * ovl should transfer current's fs{u,g}id to underly=
ing
> > > @@ -676,16 +684,15 @@ static int ovl_create_or_link(struct dentry *de=
ntry, struct inode *inode,
> > >                  * create a new inode, so just use the ovl mounter's
> > >                  * fs{u,g}id.
> > >                  */
> > > +
> > > +               if (attr->hardlink)
> > > +                       return do_ovl_create_or_link(dentry, inode, a=
ttr);
> > > +
> >
> > ^^^ This looks like an optimization (don't setup cred for hardlink).
> > Is it really an important optimization that is worth complicating the c=
ode flow?
>
> It elides a bunch of allocations and an rcu cycle from put_cred().
> So yes, I think it's worth it.

I have no doubt that ovl_setup_cred_for_create() has a price.
The question is whether hardlinking over ovl is an interesting use case
to optimize for.

Miklos? WDYT?

> You can always remove the special-case later yourself.

Sure. Just as we touch and improve the code, it's worth asking those
questions.

Thanks,
Amir.

