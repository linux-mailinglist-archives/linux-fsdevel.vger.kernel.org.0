Return-Path: <linux-fsdevel+bounces-25133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F7949549
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5775B2836E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E9F2EB10;
	Tue,  6 Aug 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUFlkv5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F915CB;
	Tue,  6 Aug 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960599; cv=none; b=VXW5P5vTKzV1Af502miZlCi5N53nUkCbalRYYeTR7yNho0iCd7P1urj9I9NdzJRtUYT2ywXDy0ZhxSOCMW1EYJbwmOFeOL7G9d00imjj4JYuIL/zOo4AQsSOMKj7NhSBdtSbQsUiamzhPt7RW8l3Me0zhhl/1eGaLl+yC4zIZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960599; c=relaxed/simple;
	bh=0zQD3EPDwM55vw5chIbnCLhounejmsAPsz2dHsxNu/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uwa6055cEQUiIRSqu5tOBhTNErzwQDRb32fuRdOmYqx1cSyBzGg9i2wggzgWD9RiSv/wWMORru3CoMJCGkurvoSIBUfeqekgS0ZC1yh+XMOVrLxE5dGNxf3hmslTW+OrSx3hHRUyINZAbksR+V7Cj1gQsCRBJEpi1CHe3O6tnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUFlkv5b; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so84439066b.0;
        Tue, 06 Aug 2024 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722960595; x=1723565395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIWoq8xOQdtc9PEWIsFJw5PaUwHe69rxz16ZktkHLlk=;
        b=cUFlkv5bcJtFDBdC1qa2MlE+vIxcKFqvvo1soFSfoCyGplIrcQmNxgjfvAG6GBxsei
         21gmYdslWehWnOeutxG9AfRvCR0SW3YGu/iAiPJxeaIHZ+7Ldwssb9SOQaN84uIpq1ow
         6gk2kdQI3QyqfZnqZTXJpcAzZe0DXNGlimbtQQ2I+jsPSbT8TlMHObS9BNsWvL41R66V
         m+W+FZIPlSkjMUjsaxGnoaTAKmFAHKa4EGIayitA+lkxrnCHaeEm5BldVHfp2cS2lUIK
         7Tz+GUe5MWwgrUTZ3pAaHPofnEZEijaalAXcncin0/rau9We8DH42M84/+DTUnRA9t22
         lB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960595; x=1723565395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIWoq8xOQdtc9PEWIsFJw5PaUwHe69rxz16ZktkHLlk=;
        b=HGkHY5KCm5ueHwu0quRttbM0sJOniCwqzua6TSzlDG0VNYOJSqNwnjnBq8kOq2bCvY
         RHSE1I1/e+jaZMrRNByZVITrAUYQGQlWjpTx8COo4GM7GGSywamQjoiTeH26ZpI4Rzl2
         jxzC135jQoUsdMmYNy0VT6lERzAMzqTLwfUIkJAXKhfNZaNnlxfkLha/+Kooe9rDRE6/
         QPKvoNrzABAns4hoD8AmzkSUHThj3VYNYp0GkEFWVLW+zz0C/2NouOvQzI4oV3ia8J0d
         +chpcC6HTWiuAB8M2RBnYoCcBlg5ldCwM6Ae6LWqjDEbmhXF3o9piqfwbs7gTL6jyXNB
         F08w==
X-Forwarded-Encrypted: i=1; AJvYcCUa9cWEMMMzdHn7w9KmO4xp9+YtMHGaB8MDuu8UlUTPl6EcPL7PfLnaJdAO+vGnqGCfT0Yss/5RQmUCpLZVB0nPtVzUxAIJEHM80N+hqZuhoyyYvDmnId55v9LpaWfR4qxV3/3V6FA0M6xJPg==
X-Gm-Message-State: AOJu0YxffRUod5Zy+l8y67Sjf3zBLN9mgDjojmPxGOd8RUE0GRbAtlhL
	hEp3A6D4eUrvs+VpZKt/L6UDBnOucdXFHs5DeXScT17d1B14GX64RP8bF8mqsOCHK+V0P3szykX
	nlLZ984+Z29lroEvCadsk65PmG7U=
X-Google-Smtp-Source: AGHT+IFu5J8MpZPlJpFIp9gHzYHUCqqiw/1Py3CKdCoBbjSA6R3KjgV7msAaze2J7RTqghJvDgmeKszoKzMDx9Unr5c=
X-Received: by 2002:a17:906:d264:b0:a7a:97ca:3058 with SMTP id
 a640c23a62f3a-a7dc4da7331mr1001697666b.5.1722960595168; Tue, 06 Aug 2024
 09:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144628.874350-1-mjguzik@gmail.com> <20240806155319.GP5334@ZenIV>
In-Reply-To: <20240806155319.GP5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 6 Aug 2024 18:09:43 +0200
Message-ID: <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:53=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Tue, Aug 06, 2024 at 04:46:28PM +0200, Mateusz Guzik wrote:
>
> > The flag thing is optional and can be dropped, but I think the general
> > direction should be to add *more* asserts and whatnot (even if they are
> > to land separately). A debug-only variant would not hurt.
>
> Asserts do *not* clarify anything; if you want your optional flag,
> come up with clear description of its semantics.  In terms of state,
> _not_ control flow.
>

It is supposed to indicate that both nd->path.mnt and nd->path.dentry
are no longer usable and must not even be looked at. Ideally code
which *does* look at them despite the flag (=3D=3D there is a bug) traps.

However, I did not find a handy macro or anything of the sort to
"poison" these pointers. Instead I found tons of NULL checks all over,
including in lookup clean up.

So as is I agree the flag adds next to nothing as is, but the intent
was to catch any use of the above pointers after what they point to
got consumed. Perhaps I should just drop the flag for the time being
and only propose it with a more fleshed out scheme later.

> > @@ -3683,6 +3685,7 @@ static const char *open_last_lookups(struct namei=
data *nd,
> >  static int do_open(struct nameidata *nd,
> >                  struct file *file, const struct open_flags *op)
> >  {
> > +     struct vfsmount *mnt;
> >       struct mnt_idmap *idmap;
> >       int open_flag =3D op->open_flag;
> >       bool do_truncate;
> > @@ -3720,11 +3723,22 @@ static int do_open(struct nameidata *nd,
> >               error =3D mnt_want_write(nd->path.mnt);
> >               if (error)
> >                       return error;
> > +             /*
> > +              * We grab an additional reference here because vfs_open_=
consume()
> > +              * may error out and free the mount from under us, while =
we need
> > +              * to undo write access below.
> > +              */
> > +             mnt =3D mntget(nd->path.mnt);
>
> It's "after vfs_open_consume() we no longer own the reference in nd->path=
.mnt",
> error or no error...
>

ok

> >               do_truncate =3D true;
>
>
> >       }
> >       error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
> > -     if (!error && !(file->f_mode & FMODE_OPENED))
> > -             error =3D vfs_open(&nd->path, file);
> > +     if (!error && !(file->f_mode & FMODE_OPENED)) {
> > +             BUG_ON(nd->state & ND_PATH_CONSUMED);
> > +             error =3D vfs_open_consume(&nd->path, file);
> > +             nd->state |=3D ND_PATH_CONSUMED;
> > +             nd->path.mnt =3D NULL;
> > +             nd->path.dentry =3D NULL;
>
> Umm...  The thing that feels wrong here is that you get an extra
> asymmetry with ->atomic_open() ;-/  We obviously can't do that
> kind of thing there (if nothing else, we have the parent directory's
> inode to unlock, error or no error).
>
> I don't hate that patch, but it really feels like the calling
> conventions are not right.  Let me try to tweak it a bit and
> see if anything falls out...

Should you write your own patch I'm happy to give it a spin to
validate the win is about the same.

I forgot to note some stuff when sending the patch, so here it is:
perf is highly unstable between re-runs of the benchmark because
struct inode itself is not aligned to anything and at least ext4 plops
it in in a rather arbitrary place and uses a kmem cache without any
magic alignment guarantees. This results in false sharing showing up
and disappearing depending on how (un)lucky one gets. For reported
results I picked the worst case.

I had to patch one sucker for constantly getting in:
https://lore.kernel.org/linux-security-module/20240806133607.869394-1-mjguz=
ik@gmail.com/T/#u

--=20
Mateusz Guzik <mjguzik gmail.com>

