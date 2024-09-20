Return-Path: <linux-fsdevel+bounces-29770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FFA97D86D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEA71C219C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1972F178383;
	Fri, 20 Sep 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8uJ+bsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3203282F7;
	Fri, 20 Sep 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850324; cv=none; b=Al8+sXlXc6y1/yVQInrNo5VDCUCyS8N+WiazZ3/t+EbpIDm5o9tXDzpljI+rpn1O3vhF6LNYl7a5xrKZqaLleABHK6mzRJXR3XiS9lnNqcz81qnLa9DJY4uTH8ETuONDrR1QXd6s4KZNzkIxCRf00W3xzrouIUngc4Q99YQtvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850324; c=relaxed/simple;
	bh=eiy7DjZXb6lrE5FuXfsJqUh1nuRn02DUddzILCrl4Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lS1DUDAnoWmZnqrPzuNKncPBsvofabKYj1FCzAis5DWlD2Kdy+FzTk/nGhO/4YSAA8kw5zV6cP0WbO6vka4nmeJhJFSnQcwMJDU7ThQgB2ZjLgFiqtWug6fkQG45G7zvoutJF1ecl2lmM4QBGF7vQ8F6Lr29cquTizXaiNEIeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8uJ+bsv; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a99e8ad977so158167485a.3;
        Fri, 20 Sep 2024 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726850321; x=1727455121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmKwoK9FOiMc1fei6pC02R6WOikASBkYWDYW8QqhUSU=;
        b=g8uJ+bsvnOOX0q8rM8HRbIVUHS7GiLgfSLVK3zJ0Z/djP1nRuKrBZOV1tyiqe/sSSW
         bjsHujfOQGjMt9H+CNen2PKoekOfgGJX4y2xbfJL4TvfVzHbeNl4HuZf2K9rTJUvl2a+
         SoEoWhyE3s0FMVxNDRxKE6irrG7nFVyEx3nFXKBYDg7h234p0j3Poq6AF60lx+vNXZs2
         ASOdn4bBzyXrw41aLweZN3sY0z/D+nOhbQelejJg9RKx4GuJKPKKCesXX1AbLpaPbXb7
         ZduVN4tUK6U9Gl+g+JoyHQx0Hysz3ZeD+EsA2HHZ7Zr10xOUgKTn90VWGCG97a9qDqGl
         swcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850321; x=1727455121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmKwoK9FOiMc1fei6pC02R6WOikASBkYWDYW8QqhUSU=;
        b=CEkj3X6cNVH83FxOeUDB6RyIQ0nU8uLFLW/MdVxahITWZnyMoR4TsJFw+X1xTehFQA
         vEwu6K3Y4X3VAfNk5/CwfzKKmjAlnrQlqPUmHmBqpJRrnPzdv5CRZx3zud7ee0clT1N0
         HjVhX6/ziWRg1YvHhCjmKaSh50TZ0AKPmtGYmrurxlKF/7Lsc0fssPtZOZrdGykRkdQK
         sVHFSjrQpUHRNn0YK2QvDT88LCac8NIMalkhfm4s82Zlxr6D/b6pRxt+RyFMRlDZqEHL
         zFhqMg24zvJfxWoiqBpJJCP7aH1u61WZcU4mdYK8yu3zIVyGY95ksA09u/4Y+BXn6x+/
         QJBg==
X-Forwarded-Encrypted: i=1; AJvYcCUIHFJdG+YQoJrP0nd7fPpLX+AVoKiUukN/33w3KfKRJYXLGLYOL9jMislbHSg2s0SaxDDMgMQ17q8B8eYo@vger.kernel.org, AJvYcCWVyDI/21OM/rnKXaQts1c53ne6QnEf564NKTlYwJWkwMSYo0BK2rMM9NdoiIBphF1yAihTr/QWDbAM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+OAP381fuMCvLsCf8FZ58pneoETc2nncxkng6MLOf2rx6UOA
	+K1IniQTfV8FGRU4/kfQNV5RdXSq4Kr+qttjrRd1aRjUh445FA6m9m5vXWVTc3cZ/N7XeteRTt7
	golvAf0UIabdaslls5wT6v8BXtsE=
X-Google-Smtp-Source: AGHT+IH+sx9UYhh5+ukSVXvmcmve+gYjewOfhsHS0TyYvuwnLKnS9du/OP9vthJpOcj34opofCOc/vcZ3UVtULwLYJw=
X-Received: by 2002:a05:620a:4101:b0:79f:148d:f611 with SMTP id
 af79cd13be357-7acb80d1670mr462718385a.29.1726850320701; Fri, 20 Sep 2024
 09:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919140611.1771651-1-amir73il@gmail.com> <20240919140611.1771651-3-amir73il@gmail.com>
 <784e439e0319bf0c3fbb0b92361a99ee2d78ac9f.camel@kernel.org>
In-Reply-To: <784e439e0319bf0c3fbb0b92361a99ee2d78ac9f.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Sep 2024 18:38:29 +0200
Message-ID: <CAOQ4uxjkN2WgT8QJeeZfbRCqrTMED+PtYEXrkDmWjh0iw+PGGw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fs: open_by_handle_at() support for decoding
 connectable file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 6:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2024-09-19 at 16:06 +0200, Amir Goldstein wrote:
> > Allow using an O_PATH fd as mount fd argument of open_by_handle_at(2).
> > This was not allowed before, so we use it to enable a new API for
> > decoding "connectable" file handles that were created using the
> > AT_HANDLE_CONNECTABLE flag to name_to_handle_at(2).
> >
> > When mount fd is an O_PATH fd and decoding an O_PATH fd is requested,
> > use that as a hint to try to decode a "connected" fd with known path,
> > which is accessible (to capable user) from mount fd path.
> >
> > Note that this does not check if the path is accessible to the calling
> > user, just that it is accessible wrt the mount namesapce, so if there
> > is no "connected" alias, or if parts of the path are hidden in the
> > mount namespace, open_by_handle_at(2) will return -ESTALE.
> >
> > Note that the file handles used to decode a "connected" fd do not have
> > to be encoded with the AT_HANDLE_CONNECTABLE flag.  Specifically,
> > directory file handles are always "connectable", regardless of using
> > the AT_HANDLE_CONNECTABLE flag.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/fhandle.c | 61 +++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 37 insertions(+), 24 deletions(-)
> >
>
> The mountfd is only used to get a path, so I don't see a problem with
> allowing that to be an O_PATH fd.
>
> I'm less keen on using the fact that mountfd is an O_PATH fd to change
> the behaviour of open_by_handle_at(). That seems very subtle. Is there
> a good reason to do it that way instead of just declaring a new AT_*
> flag for this?
>

Not sure if it is a good reason, but open_by_handle_at() has an O_ flags
argument, not an AT_ flags argument...

If my hack API is not acceptable then we will need to add
open_by_handle_at2(), with struct open_how argument or something.

>
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 956d9b25d4f7..1fabfb79fd55 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -146,37 +146,45 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, cons=
t char __user *, name,
> >       return err;
> >  }
> >
> > -static int get_path_from_fd(int fd, struct path *root)
> > +enum handle_to_path_flags {
> > +     HANDLE_CHECK_PERMS   =3D (1 << 0),
> > +     HANDLE_CHECK_SUBTREE =3D (1 << 1),
> > +};
> > +
> > +struct handle_to_path_ctx {
> > +     struct path root;
> > +     enum handle_to_path_flags flags;
> > +     unsigned int fh_flags;
> > +     unsigned int o_flags;
> > +};
> > +
> > +static int get_path_from_fd(int fd, struct handle_to_path_ctx *ctx)
> >  {
> >       if (fd =3D=3D AT_FDCWD) {
> >               struct fs_struct *fs =3D current->fs;
> >               spin_lock(&fs->lock);
> > -             *root =3D fs->pwd;
> > -             path_get(root);
> > +             ctx->root =3D fs->pwd;
> > +             path_get(&ctx->root);
> >               spin_unlock(&fs->lock);
> >       } else {
> > -             struct fd f =3D fdget(fd);
> > +             struct fd f =3D fdget_raw(fd);
> >               if (!f.file)
> >                       return -EBADF;
> > -             *root =3D f.file->f_path;
> > -             path_get(root);
> > +             ctx->root =3D f.file->f_path;
> > +             path_get(&ctx->root);
> > +             /*
> > +              * Use O_PATH mount fd and requested O_PATH fd as a hint =
for
> > +              * decoding an fd with connected path, that is accessible=
 from
> > +              * the mount fd path.
> > +              */
> > +             if (ctx->o_flags & O_PATH && f.file->f_mode & FMODE_PATH)
> > +                     ctx->flags |=3D HANDLE_CHECK_SUBTREE;
> >               fdput(f);
> >       }
> >
> >       return 0;
> >  }
> >
> > -enum handle_to_path_flags {
> > -     HANDLE_CHECK_PERMS   =3D (1 << 0),
> > -     HANDLE_CHECK_SUBTREE =3D (1 << 1),
> > -};
> > -
> > -struct handle_to_path_ctx {
> > -     struct path root;
> > -     enum handle_to_path_flags flags;
> > -     unsigned int fh_flags;
> > -};
> > -
> >  static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
> >  {
> >       struct handle_to_path_ctx *ctx =3D context;
> > @@ -224,7 +232,13 @@ static int vfs_dentry_acceptable(void *context, st=
ruct dentry *dentry)
> >
> >       if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d =3D=3D root)
> >               retval =3D 1;
> > -     WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);
> > +     /*
> > +      * exportfs_decode_fh_raw() does not call acceptable() callback w=
ith
> > +      * a disconnected directory dentry, so we should have reached eit=
her
> > +      * mount fd directory or sb root.
> > +      */
> > +     if (ctx->fh_flags & EXPORT_FH_DIR_ONLY)
> > +             WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);
>
> I don't quite understand why the above change is necessary. Can you
> explain why we need to limit this only to the case where
> EXPORT_FH_DIR_ONLY is set?
>

With EXPORT_FH_DIR_ONLY, exportfs_decode_fh_raw() should
only be calling acceptable() with a connected directory dentry.

Until this patch, vfs_dentry_acceptable() would only be called with
EXPORT_FH_DIR_ONLY so the WARN_ON could be unconditional.

After this patch, vfs_dentry_acceptable() could also be called for
a disconnected non-dir dentry and then it should just fail to
accept the dentry, but should not WARN_ON.

Thanks for the review!
Amir.

