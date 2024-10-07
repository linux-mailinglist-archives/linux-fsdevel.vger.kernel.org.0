Return-Path: <linux-fsdevel+bounces-31147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA8D9924F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 08:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C72824BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259514A4C3;
	Mon,  7 Oct 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7ZnLuD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981F42077;
	Mon,  7 Oct 2024 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283033; cv=none; b=LhVrm+MGK8UMNKynnBWmK4AaZLi3umBBCuhHeeUr2BdXLidWQIT+7nyx+IXvGJYrStOF3ouvvqECa0kbQkleQGMDA/M+z6og6No//qwAKmLbN/6gVX/mSrOWwFbkKsgSH740vKI79EhRQEoAKCq9pDBxwonyWLu9vRmkkbMCW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283033; c=relaxed/simple;
	bh=UIHhwGajmKJGxHhxu2cUN9Cz8qg9HQgaQhTbnWKtIlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMGe/CvFGhokxmulLtMjC+lCPYlF//4FkgQxDM38qqqHs2kBWH6Sp0op8XKKkjr/8ATX13sK5N2eor9P12HE7sYkhWkYMTiZqq+NxV1O2OS/QSD3NHwIIOGsnCURJSkA6KXeSo+RDL0Lk3h7pzvND1TYW9FpXvFgMSnuyIy19Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7ZnLuD3; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50ca646f545so301453e0c.3;
        Sun, 06 Oct 2024 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728283031; x=1728887831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+v/9PSr5TrS2XsqXt5AgIXHdLjchbYD+OGlZ7Lhsss=;
        b=J7ZnLuD3d441eAkklDTw80lE7ElcAYQqX4huRkzw7Q+0MVq/iRDTaj6gmF9ChOuHib
         yNdIKOsFok1uts2BdJrQbI4ot3OT1P1lWLLyRj5nHDbZy3UxC7pYi29zCeUg0cmYqg7U
         YdQ+OuGyqgQGdNT1L3wpiIAZAfbg4upJT28POXRiYbPKkzS0TwZ5E5LJ0IzK/aS9Vswm
         5FyezKpqE/vc7e57DjeJxvDRRjwi9s6zQs+dwzVLmuqM3YOQU1/x2pPAMy3tDCGuGF+k
         Otbeg24wrpAD9wROmIxJed0XZaSb85/m32V4qh0O1iChDoWDVJxtpzdEwVcynTHDWh9/
         lmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728283031; x=1728887831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+v/9PSr5TrS2XsqXt5AgIXHdLjchbYD+OGlZ7Lhsss=;
        b=SkPAktKOzNTKBK2fw2UM56in0U1nJ83GYvUyVBcLg2xvHIJD977Wf+2NTSGwjOOIqZ
         kMbDorM/NAt5e/saRYCu+TZX7P080ol1QvAAsjSiWOt36DgfJ5gS+rk6ojrywbhsVXnI
         NK4ZeBtSAETnavMfjukn16R/ei7SqZWZQtm2HTzLJWOUVuUQrfFqwK5qEYTgJx5ZuvVG
         Oky0WYrYH9jXuCc4/gw4nkLgqZJdr+foB7RIihwNoMCC2XqW2X7gj5cFSlOit5bvvip4
         NjBD3xHUJVSTQtfGjc04uMnDws5Da5Daqc2GFmEyMLQ7tElRX4MN0zNp6LcgzzSBJOFA
         aSyA==
X-Forwarded-Encrypted: i=1; AJvYcCWD4GeEDc5VlsjJXy7wvrIiZoSztLp4c+1tFpeP4VySnJlPLYakUzNl6h9PKLJqOnbimUCPMMqOZe+KJhW0@vger.kernel.org, AJvYcCWWno0bz3AS/spw/7a09DBj30HrAAZRKw2+wkbNGdepH/O8vYB76Nf5nsEO+GYnnXQcv5xkRyHsXzSqcTDhaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEJ4iQSPK9a20v4g6MazV+1TwKxxjG7CfvgK75gKw31S5WiJb
	v0XW3k+0H2Ud4UO4ff+pChb5wovUb2XpWlSLkBi1abYaaS4kRr8GT0FWvhD8ecjOLm4WfOJnLws
	ZBNkdNTulNKjHiMBbkWG4d+yBAs2t+tWp
X-Google-Smtp-Source: AGHT+IFoskCa/SdVDEUVUUWpJHQ67AQ/IONGjnvohfpDlq/ojdtQg4Uvpc9VIlLLqId+kFJ6qzfr79pxwPqYXs2ZAxU=
X-Received: by 2002:a05:6122:1688:b0:50a:b604:2b9e with SMTP id
 71dfb90a1353d-50c854b95fdmr7611112e0c.7.1728283030516; Sun, 06 Oct 2024
 23:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com> <20241006082359.263755-4-amir73il@gmail.com>
 <20241007031236.GI4017910@ZenIV>
In-Reply-To: <20241007031236.GI4017910@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 08:36:59 +0200
Message-ID: <CAOQ4uxg0AYOrK_tBMkuytaBy+rR=UZ5jurpPP5ERaB5hZaQ-CA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ovl: convert ovl_real_fdget_path() callers to ovl_real_file_path()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:12=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sun, Oct 06, 2024 at 10:23:58AM +0200, Amir Goldstein wrote:
> > Stop using struct fd to return a real file from ovl_real_fdget_path(),
> > because we no longer return a temporary file object and the callers
> > always get a borrowed file reference.
> >
> > Rename the helper to ovl_real_file_path(), return a borrowed reference
> > of the real file that is referenced from the overlayfs file or an error=
.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/overlayfs/file.c | 70 +++++++++++++++++++++++++--------------------
> >  1 file changed, 39 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index 42f9bbdd65b4..ead805e9f2d6 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
>
> > +static struct file *ovl_upper_file(const struct file *file, bool data)
> >  {
> >       struct dentry *dentry =3D file_dentry(file);
> >       struct path realpath;
> > @@ -193,12 +204,11 @@ static int ovl_upper_fdget(const struct file *fil=
e, struct fd *real, bool data)
> >       else
> >               type =3D ovl_path_real(dentry, &realpath);
> >
> > -     real->word =3D 0;
> >       /* Not interested in lower nor in upper meta if data was requeste=
d */
> >       if (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type)))
> > -             return 0;
> > +             return NULL;
> >
> > -     return ovl_real_fdget_path(file, real, &realpath);
> > +     return ovl_real_file_path(file, &realpath);
>
> AFAICS, we should never get NULL from ovl_real_file_path() now.
>
> >  static int ovl_open(struct inode *inode, struct file *file)
> > @@ -455,7 +465,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_i=
nfo *pipe, struct file *out,
> >
> >  static int ovl_fsync(struct file *file, loff_t start, loff_t end, int =
datasync)
> >  {
> > -     struct fd real;
> > +     struct file *realfile;
> >       const struct cred *old_cred;
> >       int ret;
> >
> > @@ -463,19 +473,17 @@ static int ovl_fsync(struct file *file, loff_t st=
art, loff_t end, int datasync)
> >       if (ret <=3D 0)
> >               return ret;
> >
> > -     ret =3D ovl_upper_fdget(file, &real, datasync);
> > -     if (ret || fd_empty(real))
> > -             return ret;
> > +     realfile =3D ovl_upper_file(file, datasync);
> > +     if (IS_ERR_OR_NULL(realfile))
> > +             return PTR_ERR(realfile);
>
> ... if so, the only source of NULL here would be the checks for OVL_TYPE_=
...
> in ovl_upper_file().  Which has no other callers...
>
> >       /* Don't sync lower file for fear of receiving EROFS error */
> > -     if (file_inode(fd_file(real)) =3D=3D ovl_inode_upper(file_inode(f=
ile))) {
> > +     if (file_inode(realfile) =3D=3D ovl_inode_upper(file_inode(file))=
) {
>
> Can that _not_ be true after the same checks in ovl_upper_file()?

It should always be true. I will remove the check and rename the variable t=
o
upperfile to clarify further.

Thanks for the thorough review!

Amir.

