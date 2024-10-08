Return-Path: <linux-fsdevel+bounces-31341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773FF994E04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AF82869B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2971B1DF256;
	Tue,  8 Oct 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMjZt5r6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DA1DE88F;
	Tue,  8 Oct 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393113; cv=none; b=TixkJ9tO5mv4JKjHRyt+RfvXIq7K5mMRShpQvMNtXdn/UkK8RelvL9i5szekUbtoIMLk7JVP6v1UU7QPO04mWXe2h6Q5hE4jbkqTlGr5mPepAVLlgcyFe+ctB07Y1iMH8Ij0nkztV1fb+e5Yd7IyyMmxJZZSVybyQoN1Y96YwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393113; c=relaxed/simple;
	bh=sctgzteZF0xLIJZeV0v1P46a4lOB3Jen+Szq9MvYebg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZYnZSkrp9xvqNen4GdDeca+1z5Yq+4KiMWIK8oFflFhefSdL82spHq4YF5Yx5wCX+O87+MO0VjpWNH+Kf5hSrLcOwbMmHRY8N6q1gLlXyi9lBHG006IS6Y/Lclpa0ppCI23n48zPcjVbQH7rGGU5RSVn1mVRb/gsiVuvXeE7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMjZt5r6; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ae8fc076so610339485a.2;
        Tue, 08 Oct 2024 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728393111; x=1728997911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUhIhCW4EYVtZ1pFGNbZwIrKmPYGAss7TRP+oocEQ7M=;
        b=WMjZt5r6k08m67d0i3jJ9QlUMw5LXj2ZD/LbPlIBR5CUkxLsY/aN1qLtwvcb8yrsQm
         7JKAml6Ul+IKC8KTvzUeK++kKb6f590fHfIJ1HHhVpEamtiRJHL3d5sZfIT1D1I2AiEs
         jHcot0sGVHfIehGcoJPpaKoQekoqntsCU37NyUEFg3rhwMatLLgENXz/nZ/IjfPFLCzf
         nzJ1uOKcPLNHCL7TJJNuI5YOg7BVRige1IGkEMe0IeZAwD26a06EH4QZsQbFGikunWvv
         Nbs6ba3h6MdzLKu0O4COseLVG+arvb/WGhhaUQkuTYrKvpMNWaGkWUJ2hlEQqen1CUVg
         oV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393111; x=1728997911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUhIhCW4EYVtZ1pFGNbZwIrKmPYGAss7TRP+oocEQ7M=;
        b=bUwIi0hpjoQ+Ipm6knEoNf/I0POL6v0rRfz2rUxgzFgKQzyjtlMfz8oCd6L8nMzN4X
         012CijCXR55k7422/2GMOzbJ9GCvzN4K+mXc46Y+tPdgUwNG1g4G5v3q1bz0FaEN0yaF
         w0Rgz+nJ6dSoxhJsz0L3axtvu/OZimpmuzHwaKax/I0kSnLO4aLSRSw7UHwAklUEyhnK
         yQTUH9tItdAp2JY1i38AvqhNg+VGyrn8zSIgdiI/2+jC8dvyElu4P06nijCFjmoHSadP
         mhosu8kVuRShGdBIBGKiFARogUJ3j5tLfB5u72MNyyAG8l5MWPhMa62I6Uj4ZlRMtJRv
         rBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsigYSxfoifbv13PPJhK3F5lrtZiUFODIiIsBpvpRwfbvrrzqsZHNCRpzqWSUzUHRMgozYzF6ojgvsW+IK@vger.kernel.org, AJvYcCW0vEcD5jWeSVOsu1Nfllo+tajR74OQGehdp2YMah68f1QbMWxKFWWMiiwB0XVYfqtfx4+smTLmlza1@vger.kernel.org
X-Gm-Message-State: AOJu0YwSeC/SdbaT0HoqCag6PwC9wHOsxnoOTvCj7O33gCfHR8eIS/3n
	YN5IWgzVPZ0rRf/zibniYaFtGB5UbCHWqPLguJYg4+IzHNu3ZHAzYtRyBePKWKWaREuUIesumAc
	+60V6VXhH9Ki25uMzEW3ryAHKBIs=
X-Google-Smtp-Source: AGHT+IGlbGUYc4Iv0m2kHtGA8QMswKhBWC24wvpxa3c9aagc6ojOjSPwwHKFaT84+xM3iA5ee2GpWYw3USOI7cUl61I=
X-Received: by 2002:a05:620a:319c:b0:7a9:bcc7:4ff3 with SMTP id
 af79cd13be357-7ae6f48b8cdmr2714719985a.42.1728393110565; Tue, 08 Oct 2024
 06:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923082829.1910210-1-amir73il@gmail.com> <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com> <021d3f9acf33ff74bfde7aadd6a9a01a8ee64248.camel@kernel.org>
In-Reply-To: <021d3f9acf33ff74bfde7aadd6a9a01a8ee64248.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Oct 2024 15:11:39 +0200
Message-ID: <CAOQ4uxht3A7Rx5eu=DX=Zn2PNyQnj5BkCLMi36Gftt0ej8KhdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to userspace
To: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:07=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Mon, 2024-10-07 at 17:26 +0200, Amir Goldstein wrote:
> > On Wed, Sep 25, 2024 at 11:14=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > > open_by_handle_at(2) does not have AT_ flags argument, but also, I =
find
> > > > it more useful API that encoding a connectable file handle can mand=
ate
> > > > the resolving of a connected fd, without having to opt-in for a
> > > > connected fd independently.
> > >
> > > This seems the best option to me too if this api is to be added.
> >
> > Thanks.
> >
> > Jeff, Chuck,
> >
> > Any thoughts on this?
> >
>
> Sorry for the delay. I think encoding the new flag into the fh itself
> is a reasonable approach.
>

Adding Jan.
Sorry I forgot to CC you on the patches, but struct file_handle is official=
ly
a part of fanotify ABI, so your ACK is also needed on this change.

> I'm less thrilled with using bitfields for this, just because I have a
> general dislike of them, and they aren't implemented the same way on
> all arches. Would it break ABI if we just turned the handle_type int
> into two uint16_t's instead?

I think it will because this will not be backward compat on LE arch:

 struct file_handle {
        __u32 handle_bytes;
-       int handle_type;
+      __u16 handle_type;
+      __u16 handle_flags;
        /* file identifier */
        unsigned char f_handle[] __counted_by(handle_bytes);
 };

But I can also do without the bitfileds, maybe it's better this way.
See diff from v2:

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 4ce4ffddec62..64d44fc61d43 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -87,9 +87,9 @@ static long do_sys_name_to_handle(const struct path *path=
,
                 * decoding connectable non-directory file handles.
                 */
                if (fh_flags & EXPORT_FH_CONNECTABLE) {
+                       handle->handle_type |=3D FILEID_IS_CONNECTABLE;
                        if (d_is_dir(path->dentry))
-                               fh_flags |=3D EXPORT_FH_DIR_ONLY;
-                       handle->handle_flags =3D fh_flags;
+                               fh_flags |=3D FILEID_IS_DIR;
                }
                retval =3D 0;
        }
@@ -352,7 +352,7 @@ static int handle_to_path(int mountdirfd, struct
file_handle __user *ufh,
                retval =3D -EINVAL;
                goto out_path;
        }
-       if (f_handle.handle_flags & ~EXPORT_FH_USER_FLAGS) {
+       if (!FILEID_USER_TYPE_IS_VALID(f_handle.handle_type)) {
                retval =3D -EINVAL;
                goto out_path;
        }
@@ -377,10 +377,14 @@ static int handle_to_path(int mountdirfd, struct
file_handle __user *ufh,
         * are decoding an fd with connected path, which is accessible from
         * the mount fd path.
         */
-       ctx.fh_flags |=3D f_handle.handle_flags;
-       if (ctx.fh_flags & EXPORT_FH_CONNECTABLE)
+       if (f_handle.handle_type & FILEID_IS_CONNECTABLE) {
+               ctx.fh_flags |=3D EXPORT_FH_CONNECTABLE;
                ctx.flags |=3D HANDLE_CHECK_SUBTREE;
-
+               if (f_handle.handle_type & FILEID_IS_DIR)
+                       ctx.fh_flags |=3D EXPORT_FH_DIR_ONLY;
+       }
+       /* Filesystem code should not be exposed to user flags */
+       handle->handle_type &=3D ~FILEID_USER_FLAGS_MASK;
        retval =3D do_handle_to_path(handle, path, &ctx);

 out_handle:
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 96b62e502f71..3e60bac74fa3 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -159,8 +159,17 @@ struct fid {
 #define EXPORT_FH_CONNECTABLE  0x1 /* Encode file handle with parent */
 #define EXPORT_FH_FID          0x2 /* File handle may be non-decodeable */
 #define EXPORT_FH_DIR_ONLY     0x4 /* Only decode file handle for a
directory */
-/* Flags allowed in encoded handle_flags that is exported to user */
-#define EXPORT_FH_USER_FLAGS   (EXPORT_FH_CONNECTABLE | EXPORT_FH_DIR_ONLY=
)
+
+/* Flags supported in encoded handle_type that is exported to user */
+#define FILEID_USER_FLAGS_MASK 0xffff0000
+#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
+
+#define FILEID_IS_CONNECTABLE  0x10000
+#define FILEID_IS_DIR          0x40000
+#define FILEID_VALID_USER_FLAGS        (FILEID_IS_CONNECTABLE | FILEID_IS_=
DIR)
+
+#define FILEID_USER_TYPE_IS_VALID(type) \
+       (FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS)

 /**
  * struct export_operations - for nfsd to communicate with file systems
diff --git a/include/linux/fs.h b/include/linux/fs.h
index cca7e575d1f8..6329fec40872 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1071,8 +1071,7 @@ struct file {

 struct file_handle {
        __u32 handle_bytes;
-       int handle_type:16;
-       int handle_flags:16;
+       int handle_type;
        /* file identifier */
        unsigned char f_handle[] __counted_by(handle_bytes);
 };

