Return-Path: <linux-fsdevel+bounces-29786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC4E97DCD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28561C20CC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F6616DEAB;
	Sat, 21 Sep 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAIkIyTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3945154425;
	Sat, 21 Sep 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726914342; cv=none; b=oHo+9VAFzzCnM7EsMQz0TUAvek4d1Dyxv0yHZ9diUgLZHLd/xOL6KjKX1xUwrlNS5+N1I/3W6sNdE7EAj8PNfcDemfiNevMZ30LkvttO33x5d/+dnpqbNlHxDcj3Sf85PR3dShNpYgdxsAr+jI4V1BwPuU2r9Rm66M7pAgj6hUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726914342; c=relaxed/simple;
	bh=JBSwaa3lb+nw80GNHJ8y+Mlwk6VCdTjL9iXAjUaem9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVe/RYpjXrp/77vH8biiNs/q8ddqEP1q1iul7UD5NiP0NO4t6LVoUC5oOo81SboRrPFwzZxhD4yP5SGTf3STzJmw8MWXFgPDtYl8XrsVxU3KPCYdQoFrlfIZgK+ml+MWdxtv6EQJgBvjrYF37hxlmXijRhXm4VccJVqiuwh3wgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAIkIyTR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4583083d019so19088671cf.3;
        Sat, 21 Sep 2024 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726914340; x=1727519140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHggiO0aSd2mJzBI8SQuoqlzbxR7FqQfOwUz0SiPx90=;
        b=YAIkIyTRMhp8z7eDyqRCGWW9oU2NRU7LZ8WYf6xaCnHyMwkF0GQ1qF244FDbz2v4tk
         OZ3gcCEcli7Rjoqni2JV14vavgMN9xnQJ3SrVJF8nW8l9wGkMJ7gBYm7nDcS39u8cqe9
         jt+9REjzFNF7+IXOij+hSrOEwfpt5AIZa00SD5xyQ4x2huhr/Jg/nw30dr185/MwREG3
         zPhHtX/dTvH90hb12FHlr2I453V8TZVh/Sg4dpzIl8AFvDWapCcPIC9E8/xzTocChWJY
         Sm8x3es8lx7ggtSSdEagcDXjZfHWxxXRPlKU+25vl/rC2gjj+lfdAeeC8is9cWOMS1Aw
         FV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726914340; x=1727519140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHggiO0aSd2mJzBI8SQuoqlzbxR7FqQfOwUz0SiPx90=;
        b=BINfiRHduLkA4JCPdPfZcrKwEaMGBkmGthS0FPpy86Ttw2qiFPYxA2St7aiLlqttq1
         csBQ7vdO3OZ4C+iRE7nhzqe04piyhbffJjs20iJsjO0MW248+soothN6ozb64Kjc+XxA
         xB1n9+Cd2MP9rjZGkRi8R4ICxz/4rDLsPiN4+LidJVZmq/MDZYhrWzxRLXhe9F6tsKM+
         86YthOWmxDvf3sQFBy5ciloB36/1BoHvbGmc0xkMJ0sUE7sYOrcRUhgkm1/pr71gAxnv
         lelw9Eq+MRIJhXmAHdDlSn2aNubMwVIFU2MCEt5ICb+XUlQ7nUp8zzlKSGMsl3w/ftKm
         5YWg==
X-Forwarded-Encrypted: i=1; AJvYcCUeiPnlD4i6jA+0TpMGwIOxCNwbmPmNikec9FduM+nLhN3ggYh7uPC+S3k5KO6tmStbDbEY1B8UbD9R@vger.kernel.org, AJvYcCXx1EZO4S/bBhudjp0rf59KABfsM9KsjAmGvnEhHnhM6y2HPEmacmc0JbYkHu50QFjDWqFGAdqgEHSXR9fF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7u0xlVxO0AUjpK2P3eOpd0Uz4eFQiXIvLVFrE2BvQnXeYImeT
	wDqOwU9a6VukCLsYnj7mKVH/cVXvCZZLHY4ZOxRN6sSU7VzPHjjo2yjiXIAyWxseNJ++QCdbJ+8
	GQXf86KTCEiz5Eby0OZGo8IRHJV8=
X-Google-Smtp-Source: AGHT+IHG1rpeJVa6kFfdk0VsXjZDzkumH2RDxISa4St9ZJ7uz7YMnKz2NNfqIGS0WDLwK/0hGFa07Pys+lPiSMvlcz0=
X-Received: by 2002:ac8:58c8:0:b0:458:53da:a4e9 with SMTP id
 d75a77b69052e-45b204e0346mr84104111cf.4.1726914339402; Sat, 21 Sep 2024
 03:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919140611.1771651-1-amir73il@gmail.com> <20240919140611.1771651-3-amir73il@gmail.com>
 <784e439e0319bf0c3fbb0b92361a99ee2d78ac9f.camel@kernel.org>
 <CAOQ4uxjkN2WgT8QJeeZfbRCqrTMED+PtYEXrkDmWjh0iw+PGGw@mail.gmail.com> <8aa01edea8972c1bde3b34df32f9db72e29420ed.camel@kernel.org>
In-Reply-To: <8aa01edea8972c1bde3b34df32f9db72e29420ed.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 21 Sep 2024 12:25:27 +0200
Message-ID: <CAOQ4uxj3wgXAnAiewbVNa32Mfr=TRstBPNQd=owrvV4=R3VP8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fs: open_by_handle_at() support for decoding
 connectable file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 7:33=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-09-20 at 18:38 +0200, Amir Goldstein wrote:
> > On Fri, Sep 20, 2024 at 6:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Thu, 2024-09-19 at 16:06 +0200, Amir Goldstein wrote:
> > > > Allow using an O_PATH fd as mount fd argument of open_by_handle_at(=
2).
> > > > This was not allowed before, so we use it to enable a new API for
> > > > decoding "connectable" file handles that were created using the
> > > > AT_HANDLE_CONNECTABLE flag to name_to_handle_at(2).
> > > >
> > > > When mount fd is an O_PATH fd and decoding an O_PATH fd is requeste=
d,
> > > > use that as a hint to try to decode a "connected" fd with known pat=
h,
> > > > which is accessible (to capable user) from mount fd path.
> > > >
> > > > Note that this does not check if the path is accessible to the call=
ing
> > > > user, just that it is accessible wrt the mount namesapce, so if the=
re
> > > > is no "connected" alias, or if parts of the path are hidden in the
> > > > mount namespace, open_by_handle_at(2) will return -ESTALE.
> > > >
> > > > Note that the file handles used to decode a "connected" fd do not h=
ave
> > > > to be encoded with the AT_HANDLE_CONNECTABLE flag.  Specifically,
> > > > directory file handles are always "connectable", regardless of usin=
g
> > > > the AT_HANDLE_CONNECTABLE flag.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/fhandle.c | 61 +++++++++++++++++++++++++++++++-----------------=
----
> > > >  1 file changed, 37 insertions(+), 24 deletions(-)
> > > >
> > >
> > > The mountfd is only used to get a path, so I don't see a problem with
> > > allowing that to be an O_PATH fd.
> > >
> > > I'm less keen on using the fact that mountfd is an O_PATH fd to chang=
e
> > > the behaviour of open_by_handle_at(). That seems very subtle. Is ther=
e
> > > a good reason to do it that way instead of just declaring a new AT_*
> > > flag for this?
> > >
> >
> > Not sure if it is a good reason, but open_by_handle_at() has an O_ flag=
s
> > argument, not an AT_ flags argument...
> >
> > If my hack API is not acceptable then we will need to add
> > open_by_handle_at2(), with struct open_how argument or something.
> >
>
> Oh right, I forgot that open_by_handle_at doesn't take AT_* flags.
> A new syscall may be best then.
>
> I can see a couple of other potential approaches:
>
> 1/ You could add a new fcntl() cmd that puts the mountfd into a
> "connectable filehandles" mode. The downside there is that it'd take 2
> syscalls to do your open.
>
> 2/ You could add flags to open_how that make openat2() behave like
> open_by_handle_at(). Add a flag that allows "pathname" to point to a
> filehandle instead, and a second flag that indicates that the fh is
> connectable.
>
> Both of those are pretty hacky though.
>

Yes, especially #2, very creative ;)

But I had another less hacky idea.
Instead of (ab)using a sycall flag to get a "connected" fd,
encode an explicit "connectable" fh, something like this untested patch.

WDYT?

Thanks,
Amir.

--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -59,6 +59,7 @@ static long do_sys_name_to_handle(const struct path *path=
,
        handle_bytes =3D handle_dwords * sizeof(u32);
        handle->handle_bytes =3D handle_bytes;
        if ((handle->handle_bytes > f_handle.handle_bytes) ||
+           WARN_ON_ONCE(retval > FILEID_INVALID) ||
            (retval =3D=3D FILEID_INVALID) || (retval < 0)) {
                /* As per old exportfs_encode_fh documentation
                 * we could return ENOSPC to indicate overflow
@@ -72,8 +73,21 @@ static long do_sys_name_to_handle(const struct path *pat=
h,
                 * non variable part of the file_handle
                 */
                handle_bytes =3D 0;
-       } else
+       } else {
+               /*
+                * When asked to encode a connectable file handle, encode t=
his
+                * property in the file handle itself, so we know how
to decode it.
+                * For sanity, also encode in the file handle if the
encoded object
+                * is a directory, because connectable directory file
handles do not
+                * encode the parent.
+                */
+               if (fh_flags & EXPORT_FH_CONNECTABLE) {
+                       if (d_is_dir(path->dentry))
+                               fh_flags |=3D EXPORT_FH_DIR_ONLY;
+                       handle->handle_flags =3D fh_flags;
+               }
                retval =3D 0;
+       }
...
@@ -336,6 +350,19 @@ static int handle_to_path(int mountdirfd, struct
file_handle __user *ufh,
                retval =3D -EINVAL;
                goto out_path;
        }
+       if (f_handle.handle_flags & ~EXPORT_FH_USER_FLAGS) {
+               retval =3D -EINVAL;
+               goto out_path;
+       }
+       /*
+        * If handle was encoded with AT_HANDLE_CONNECTABLE, verify that we
+        * are decoding an fd with connected path, which is accessible from
+        * the mount fd path.
+        */
+       ctx.fh_flags |=3D f_handle.handle_flags;
+       if (ctx.fh_flags & EXPORT_FH_CONNECTABLE)
+               ctx.flags |=3D HANDLE_CHECK_SUBTREE;
+
        handle =3D kmalloc(struct_size(handle, f_handle, f_handle.handle_by=
tes),
                         GFP_KERNEL);
...
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -159,6 +159,8 @@ struct fid {
 #define EXPORT_FH_CONNECTABLE  0x1 /* Encode file handle with parent */
 #define EXPORT_FH_FID          0x2 /* File handle may be non-decodeable */
 #define EXPORT_FH_DIR_ONLY     0x4 /* Only decode file handle for a
directory */
+/* Flags allowed in encoded handle_flags that is exported to user */
+#define EXPORT_FH_USER_FLAGS   (EXPORT_FH_CONNECTABLE | EXPORT_FH_DIR_ONLY=
)
...
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1071,7 +1071,8 @@ struct file {

 struct file_handle {
        __u32 handle_bytes;
-       int handle_type;
+       int handle_type:16;
+       int handle_flags:16;
        /* file identifier */
        unsigned char f_handle[] __counted_by(handle_bytes);
 };

