Return-Path: <linux-fsdevel+bounces-47451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC43A9DCEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 21:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59B81B65503
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF441DE2CF;
	Sat, 26 Apr 2025 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKCMo062"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7514D2A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745695841; cv=none; b=EcdUzTrpXiGvV/kS/a+lvfShlNtVQO+aG68gdyWjNAfGWacet4imTO991S6wN07B1lyBM02otG4vAS3vA4RxV4xjTg2VH+wZefZNvC9wvo9Zk09wShRHdvkQoyPHbAF5D4Lw22uJ9sdYitHl5u8kF678kTZPdH2znQWwujZByd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745695841; c=relaxed/simple;
	bh=nMz8vNFBwZP6fMUkf53kWOMfKv3CG+aLLZ4FDhoM6ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaXf+jPhVFgQYrr0o6Prw9Gg+jewtHsZivjfN9XO7inlweN/G7LrfMYgBzR6jNA3p34nPRnxvpnow/sZ/xAw4Rz3hATHXmvh/UDRCo2f58oEGmteo8cbiSB8XFbRMAJuTCdeTMRb1xrhzWDWF/RyaujW22o25W3OD7lpFwYM3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKCMo062; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac25520a289so531946466b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745695838; x=1746300638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg7nTaNi9mKVKeCUVuHpTFukPnithft5+Ky4/RpBH4g=;
        b=cKCMo062CZVOLNx/q620K7xxPbQJSpXVx78L/Oj3o7C16/gomjzJQg8/LmlfGyamyh
         6LaDm4aCxEh2Zcnbcyj4CN6uu2NnRh+RXT0zp0rTL9qZ+xfYtZvhCWVnbZ/eRRzrCPNA
         iYxg3Na2UcSkspe3BZMP5VbWeiMZMhaqi5f537Yv31hSrxy5+YCefD3sLwPWqo46/3tA
         FoUt1rJyH9DVX2ndC900WvArmndDgOlSTodAnMDHY38hmZnqZM21iEZ59762LNtAW5b8
         alWepJqUGNv3en/BGQxiWnlIAc8PpkTJdrQeMA5rYIZ8ZJe7D2gvfLqY9DwyYkX/D8tL
         mdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745695838; x=1746300638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg7nTaNi9mKVKeCUVuHpTFukPnithft5+Ky4/RpBH4g=;
        b=pHZaHqlgDvgeoAKR7Ya4rsP0g+AmZlhK6wnQFMhcHVSpaVGs71JjDgsL3uiTs3QOsX
         cCeTOsLQ0fYP7v1b76qwgc0kWSugSA4E9473bXi4b0MsyGVz1fbjErYdGEeNEl5mKdWA
         6lzeyUeTORkDcPDD2RbkGUhBWXLjnvIRgfP0g3ai3icLSCEN8tDRUkhGBmBKxVapI4rZ
         knpkCKxvop/WQEswjTeSd1icf/NKmKdYKZVppmJ9OuHQX03XINKgYXzjubMq+JvzVzFS
         Jw+h5RKv2nYAJMpAYSWwIgixVq6DeRbt2r8nqcdKP+b96w0FRJz9S0NJhh2bBw7pv1vy
         ZHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcgq1VFEhmAQ1cPrPXWbd2+4zNEuVoIFc9QspMK/MwTJ/WJUbXX1GMvLz7QtHaELp26dHVjx0jqHPMLkUC@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJYgFSf5V7dnVDFUeETYVqmyBlton9pIpiEyx8fEq57n67Xli
	jm4lLN8rxF2v/F1zXdUzu/ISUtWx7EMGymi9t7WRitbkA0ZwRYPcIVxnjtbqJZROEUSv6vpf1h4
	9mfHRS2FFOAexJY/QsRUpjtPOc/M=
X-Gm-Gg: ASbGncs/FlstPlJmtPtFzHSW1nvAQ8Hb6Tn+QIMheR8Dn4/i1MaDzRyW3JXVp0yG7/r
	8qvyafliAuuNWaMVlJOiR1uRNcA0JxLQopt1ivPtUW3foTkq45096YqYCNyPQTsFKWahn8fCwHj
	2gEma7bBGNCnzD1Y5CGo0stDHWHPbDvkk=
X-Google-Smtp-Source: AGHT+IGNiXKVUnQltOFajX8JeIpIF6Tokbc44g/F4CHagCegnfETkcUk53d3Um1bH9xI3bqQD/Z0rFUWHNr7y9qvi4I=
X-Received: by 2002:a17:906:d10d:b0:ace:3643:1959 with SMTP id
 a640c23a62f3a-ace710483e0mr480888766b.7.1745695837287; Sat, 26 Apr 2025
 12:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424132246.16822-2-jack@suse.cz> <uz6xvk77mvfsq6hkeclq3yksbalcvjvaqgdi4a5ai6kwydx2os@sbklkpv4wgah>
 <20250425-fahrschein-obacht-c622fbb4399b@brauner> <a3w7xdgldyoodxeav6zwn3dkw6y4cir6fdhftopo3snrpgbjoz@zvz4vny63ehf>
In-Reply-To: <a3w7xdgldyoodxeav6zwn3dkw6y4cir6fdhftopo3snrpgbjoz@zvz4vny63ehf>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 26 Apr 2025 21:30:25 +0200
X-Gm-Features: ATxdqUFe0HTj9t5jzDSLuEGjb_YdPsZzofhMAhXg3DlxuTjJv9uDtS73eo6aHDM
Message-ID: <CAGudoHF_h0Yg9pp9LqG0CKaqZDJgAjA9Tp+piJ0aMO+V9iFXBg@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2)
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:33=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 25-04-25 10:45:22, Christian Brauner wrote:
> > On Thu, Apr 24, 2025 at 05:45:17PM +0200, Mateusz Guzik wrote:
> > > On Thu, Apr 24, 2025 at 03:22:47PM +0200, Jan Kara wrote:
> > > > Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
> > > > calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) an=
d
> > > > fail with -EBADF error instead of operating on CWD. Fix it.
> > > >
> > > > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  fs/xattr.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > > index 02bee149ad96..fabb2a04501e 100644
> > > > --- a/fs/xattr.c
> > > > +++ b/fs/xattr.c
> > > > @@ -703,7 +703,7 @@ static int path_setxattrat(int dfd, const char =
__user *pathname,
> > > >           return error;
> > > >
> > > >   filename =3D getname_maybe_null(pathname, at_flags);
> > > > - if (!filename) {
> > > > + if (!filename && dfd >=3D 0) {
> > > >           CLASS(fd, f)(dfd);
> > > >           if (fd_empty(f))
> > > >                   error =3D -EBADF;
> > > > @@ -847,7 +847,7 @@ static ssize_t path_getxattrat(int dfd, const c=
har __user *pathname,
> > > >           return error;
> > > >
> > > >   filename =3D getname_maybe_null(pathname, at_flags);
> > > > - if (!filename) {
> > > > + if (!filename && dfd >=3D 0) {
> > > >           CLASS(fd, f)(dfd);
> > > >           if (fd_empty(f))
> > > >                   return -EBADF;
> > >
> > > Is there any code which legitimately does not follow this pattern?
> > >
> > > With some refactoring getname_maybe_null() could handle the fd thing,
> > > notably return the NULL pointer if the name is empty. This could brin=
g
> > > back the invariant that the path argument is not NULL.
> > >
> > > Something like this:
> > > static inline struct filename *getname_maybe_null(int fd, const char =
__user *name, int flags)
> > > {
> > >         if (!(flags & AT_EMPTY_PATH))
> > >                 return getname(name);
> > >
> > >         if (!name && fd >=3D 0)
> > >                 return NULL;
> > >         return __getname_maybe_null(fd, name);
> > > }
> > >
> > > struct filename *__getname_maybe_null(int fd, const char __user *path=
name)
> > > {
> > >         char c;
> > >
> > >         if (fd >=3D 0) {
> > >                 /* try to save on allocations; loss on um, though */
> > >                 if (get_user(c, pathname))
> > >                         return ERR_PTR(-EFAULT);
> > >                 if (!c)
> > >                         return NULL;
> > >         }
> > >
> > >     /* we alloc suffer the allocation of the buffer. worst case, if
> > >      * the name turned empty in the meantime, we return it and
> > >      * handle it the old-fashioned way.
> > >      /
> > >         return getname_flags(pathname, LOOKUP_EMPTY);
> > > }
> > >
> > > Then callers would look like this:
> > > filename =3D getname_maybe_null(dfd, pathname, at_flags);
> > > if (!filename) {
> > >     /* fd handling goes here */
> > >     CLASS(fd, f)(dfd);
> > >     ....
> > >
> > > } else {
> > >     /* regular path handling goes here */
> > > }
> > >
> > >
> > > set_nameidata() would lose this branch:
> > > p->pathname =3D likely(name) ? name->name : "";
> > >
> > > and putname would convert IS_ERR_OR_NULL (which is 2 branches) into o=
ne,
> > > maybe like so:
> > > -       if (IS_ERR_OR_NULL(name))
> > > +       VFS_BUG_ON(!name);
> > > +
> > > +       if (IS_ERR(name))
> > >                 return;
> > >
> > > i think this would be an ok cleanup
> >
> > Not opposed, but please for -next and Jan's thing as a backportable fix=
,
> > please. Thanks!
>
> Exactly, I agree the code is pretty subtle and ugly. It shouldn't take
> several engineers to properly call a function to lookup a file :) So
> some cleanup and refactoring is definitely long overdue but for now I
> wanted some minimal fix which is easy to backport to stable.
>
> When we speak about refactoring: Is there a reason why user_path_at()
> actually doesn't handle NULL 'name' as empty like we do it in *xattrat()
> syscalls? I understand this will make all _at() syscalls accept NULL name
> with AT_EMPTY_PATH but is that a problem?

Is there a benefit for doing it though?

I think the entire AT_EMPTY_PATH and NULL thing is trainwreck which
needs to be reasonably contained instead. In particular the flag has
most regrettable semantics of requiring an actual path (the NULL thing
is a Linux extension) and being a nop if the path is not empty.

The entire thing is a kludge for syscalls which don't have an fd-only
variant and imo was the wrong way to approach this (provide fd-only
variants instead), but it's too late now.

user_path_at() always returns a path (go figure). Suppose it got
extended with the fuckery and some userspace started to rely on it.

Part of the benefit of having a fd-based op and knowing it is fd-based
is that you know the inode itself is secured by liveness of the file
object. If the calling thread is a part of a single-threaded process,
then there is the extra benefit of eliding atomics on the file thing
(reducing single-threaded cost). If the thing is multi-threaded,
atomics are only done on the file (not the inode), which scales better
if other procs use a different file obj for the same inode.

Or to put it differently, if user_path_at() keeps returning a path
like it does now *and* is relied on for AT_EMPTY_PATH fuckery, it is
going to impose extra overhead on its consumers.

Suppose one will decide to combat it. Then the routine will have to
copy path from the file without refing it and return an indicator
what's needed -- path_put for a real path handling, fput for fd-only
in a multithreaded proc [but then also it will need to return the
found file obj] and nothing for a fd-only in a single-threaded proc.

I think that's ugly af and completely unnecessary.
--=20
Mateusz Guzik <mjguzik gmail.com>

