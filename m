Return-Path: <linux-fsdevel+bounces-31349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAADF99525C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBB11C248F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EB01DFE2E;
	Tue,  8 Oct 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdViVd9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0518CBED;
	Tue,  8 Oct 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399043; cv=none; b=XKT/AAWoZL8o6YufuSNnhymE2/nbOLi+gs0MemefZ7Y5NU2JZshL1+V2xZEP3ZdjAmKAviHonyUTJmCIPwQDtpGzGnlbobcC0Ohzp3QdsjCSoM/g/glJG9dmtmvtT91Pq97Rk6Zekly2/CcuAM1Brw+/s+TYtchr6N4c0cDnuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399043; c=relaxed/simple;
	bh=DPPWzwbMCPm46B/hhkyIE7ZUaXYV8ymvnfxVxw7EwRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaOEMY5Trdv0BTJGh+8osH9X7icV8EXPfNwfzGIdkUnqtKSgo8uWAtujh7An7e9tVoDBcFUl0nwwjhbRVmjV9xIIv/MdvGzV9b5N5UCSvcs4+DHDbnJ2qA784AOoByOVRl+JgRH2LlPTyCAkr6eKC7N56nNs3bQpClhfmXr6dnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdViVd9L; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7afcd322cabso38643785a.1;
        Tue, 08 Oct 2024 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728399040; x=1729003840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jM8zwaLGZukvV/BmATk9lArC+P/khuBf+oY8DvXyr0=;
        b=bdViVd9LrWh5+hFWcOIB0AevZY4xsmmFqgkHZt4Pv8zcXPFN1dcrSroyhJ2BZZagOQ
         m0QGV1yYfzr0CQUXtcZx9pDSYBzKi7Fh/Uo4rJLqGshf2igG1x2JB4uoGi4BvfGuCuld
         0drZZZT47rDbGzCiPpiTLftAzzB4chLBmp2ea6e3Os9pjdC0mflvgUPLy2C74ff4Klks
         5Oa6Y8e9lHS+oY9L7rzLst95sgBu+wHPCK3PcWf5/gRqq1LN1k5/XZK3XwVB9gLgTa0x
         LuS/t6e9RpYitaV6CR4UpUTq/4hsFdYy1aT6GrGK1L0VKQfi/pkvIDvG71ofIChYfRkg
         VMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399040; x=1729003840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jM8zwaLGZukvV/BmATk9lArC+P/khuBf+oY8DvXyr0=;
        b=jkod3Ase9qYRKizONhSPt5+0Uw3WltLNKjiX94MBjfFlr2/l4I2YoYFneBf6L2cG4I
         0jIBWVUpL3mY+LMKwKYa9NOW2EJVmyUPggxcB+9PVCx2oMi4sAwZ6Vzfzr67zgRyyrAg
         h49xa+EimE2jseir57QFBY5gw7fdvi7YzjSiBDTI4mQy1VYMdYRN6ZJzoZU8qaJ0hJ1f
         0DeQ5L9rBjxGf3XmLu++XmIPSiQ5I18pa48Bz8zLauUtcUG+gE5euPvkDj/hKsWRhSLp
         wITgyttEq+Zd5sLSza445kh52JygFaXB5ijgbrGjadGGeqv7SEAE0ue3nkeqR7pQAUfx
         YU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAtX8wuI0KG3q65xUPgnxkOGk5jw+w4TqgMafEMZQsAXl5JNTm7eg/c/QzsAd4SLz7vigUSi+7W5+Si9cE@vger.kernel.org, AJvYcCXceT8cQ2/5WRlpVP6OtI3Q/usi/sRnVH3bWi9YyEWL+JBxk5X8liIFH/CvjcuMvRn/oHufRwN98wAs@vger.kernel.org
X-Gm-Message-State: AOJu0YzalCd42YmwyuxCajZeUHAIvP5GFDUHRnFoFE+7NNu3rCqLNmgl
	//Kwcte4fo1KmjDmKxjQozHCzsbCDpx+UXxhiB8tEx3mgpf74U3kJYDBT7xRgqyutk2Obe1nQgb
	Hqr/loBvJcx/27dpQSo4/KCFd0hI=
X-Google-Smtp-Source: AGHT+IE3CFMEZzzbiAMZy69SLOvGk+qXDC5/62VOZJk73PmsJFKMSEl7S3DVMNvO/NKNkZcPkQLOZzURGRfAoIgGamI=
X-Received: by 2002:a05:620a:4245:b0:7a1:62ad:9d89 with SMTP id
 af79cd13be357-7ae6f49da40mr2451711385a.64.1728399040152; Tue, 08 Oct 2024
 07:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923082829.1910210-1-amir73il@gmail.com> <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com>
 <021d3f9acf33ff74bfde7aadd6a9a01a8ee64248.camel@kernel.org>
 <CAOQ4uxht3A7Rx5eu=DX=Zn2PNyQnj5BkCLMi36Gftt0ej8KhdA@mail.gmail.com> <842daeacf39f9ef533bc398eb19526e0e1f2d532.camel@kernel.org>
In-Reply-To: <842daeacf39f9ef533bc398eb19526e0e1f2d532.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Oct 2024 16:50:28 +0200
Message-ID: <CAOQ4uxjj022MgWG0AunQiixyVky5AsL8HH3_j9zSr-qHRweHPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to userspace
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:43=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-10-08 at 15:11 +0200, Amir Goldstein wrote:
> > On Tue, Oct 8, 2024 at 1:07=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Mon, 2024-10-07 at 17:26 +0200, Amir Goldstein wrote:
> > > > On Wed, Sep 25, 2024 at 11:14=E2=80=AFAM Christian Brauner <brauner=
@kernel.org> wrote:
> > > > >
> > > > > > open_by_handle_at(2) does not have AT_ flags argument, but also=
, I find
> > > > > > it more useful API that encoding a connectable file handle can =
mandate
> > > > > > the resolving of a connected fd, without having to opt-in for a
> > > > > > connected fd independently.
> > > > >
> > > > > This seems the best option to me too if this api is to be added.
> > > >
> > > > Thanks.
> > > >
> > > > Jeff, Chuck,
> > > >
> > > > Any thoughts on this?
> > > >
> > >
> > > Sorry for the delay. I think encoding the new flag into the fh itself
> > > is a reasonable approach.
> > >
> >
> > Adding Jan.
> > Sorry I forgot to CC you on the patches, but struct file_handle is offi=
cially
> > a part of fanotify ABI, so your ACK is also needed on this change.
> >
> > > I'm less thrilled with using bitfields for this, just because I have =
a
> > > general dislike of them, and they aren't implemented the same way on
> > > all arches. Would it break ABI if we just turned the handle_type int
> > > into two uint16_t's instead?
> >
> > I think it will because this will not be backward compat on LE arch:
> >
> >  struct file_handle {
> >         __u32 handle_bytes;
> > -       int handle_type;
> > +      __u16 handle_type;
> > +      __u16 handle_flags;
> >         /* file identifier */
> >         unsigned char f_handle[] __counted_by(handle_bytes);
> >  };
> >
>
> Ok, good point.
>
> > But I can also do without the bitfileds, maybe it's better this way.
> > See diff from v2:
> >
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 4ce4ffddec62..64d44fc61d43 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -87,9 +87,9 @@ static long do_sys_name_to_handle(const struct path *=
path,
> >                  * decoding connectable non-directory file handles.
> >                  */
> >                 if (fh_flags & EXPORT_FH_CONNECTABLE) {
> > +                       handle->handle_type |=3D FILEID_IS_CONNECTABLE;
> >                         if (d_is_dir(path->dentry))
> > -                               fh_flags |=3D EXPORT_FH_DIR_ONLY;
> > -                       handle->handle_flags =3D fh_flags;
> > +                               fh_flags |=3D FILEID_IS_DIR;
> >                 }
> >                 retval =3D 0;
> >         }
> > @@ -352,7 +352,7 @@ static int handle_to_path(int mountdirfd, struct
> > file_handle __user *ufh,
> >                 retval =3D -EINVAL;
> >                 goto out_path;
> >         }
> > -       if (f_handle.handle_flags & ~EXPORT_FH_USER_FLAGS) {
> > +       if (!FILEID_USER_TYPE_IS_VALID(f_handle.handle_type)) {
> >                 retval =3D -EINVAL;
> >                 goto out_path;
> >         }
> > @@ -377,10 +377,14 @@ static int handle_to_path(int mountdirfd, struct
> > file_handle __user *ufh,
> >          * are decoding an fd with connected path, which is accessible =
from
> >          * the mount fd path.
> >          */
> > -       ctx.fh_flags |=3D f_handle.handle_flags;
> > -       if (ctx.fh_flags & EXPORT_FH_CONNECTABLE)
> > +       if (f_handle.handle_type & FILEID_IS_CONNECTABLE) {
> > +               ctx.fh_flags |=3D EXPORT_FH_CONNECTABLE;
> >                 ctx.flags |=3D HANDLE_CHECK_SUBTREE;
> > -
> > +               if (f_handle.handle_type & FILEID_IS_DIR)
> > +                       ctx.fh_flags |=3D EXPORT_FH_DIR_ONLY;
> > +       }
> > +       /* Filesystem code should not be exposed to user flags */
> > +       handle->handle_type &=3D ~FILEID_USER_FLAGS_MASK;
> >         retval =3D do_handle_to_path(handle, path, &ctx);
> >
> >  out_handle:
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 96b62e502f71..3e60bac74fa3 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -159,8 +159,17 @@ struct fid {
> >  #define EXPORT_FH_CONNECTABLE  0x1 /* Encode file handle with parent *=
/
> >  #define EXPORT_FH_FID          0x2 /* File handle may be non-decodeabl=
e */
> >  #define EXPORT_FH_DIR_ONLY     0x4 /* Only decode file handle for a
> > directory */
> > -/* Flags allowed in encoded handle_flags that is exported to user */
> > -#define EXPORT_FH_USER_FLAGS   (EXPORT_FH_CONNECTABLE | EXPORT_FH_DIR_=
ONLY)
>
> Maybe add a nice comment here about how the handle_type word is
> partitioned?
>

Sure, I added:

+/*
+ * Filesystems use only lower 8 bits of file_handle type for fid_type.
+ * name_to_handle_at() uses upper 16 bits of type as user flags to be
+ * interpreted by open_by_handle_at().
+ */

> > +
> > +/* Flags supported in encoded handle_type that is exported to user */
> > +#define FILEID_USER_FLAGS_MASK 0xffff0000
> > +#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
> > +
> > +#define FILEID_IS_CONNECTABLE  0x10000
> > +#define FILEID_IS_DIR          0x40000
> > +#define FILEID_VALID_USER_FLAGS        (FILEID_IS_CONNECTABLE | FILEID=
_IS_DIR)
> > +
> > +#define FILEID_USER_TYPE_IS_VALID(type) \
> > +       (FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS)
> >
> >  /**
> >   * struct export_operations - for nfsd to communicate with file system=
s
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index cca7e575d1f8..6329fec40872 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1071,8 +1071,7 @@ struct file {
> >
> >  struct file_handle {
> >         __u32 handle_bytes;
> > -       int handle_type:16;
> > -       int handle_flags:16;
> > +       int handle_type;
> >         /* file identifier */
> >         unsigned char f_handle[] __counted_by(handle_bytes);
> >  };
>
>
> I like that better than bitfields, fwiw.

Me too :)

I also added assertions in case there is an out of tree fs with weird
handle type:

--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -382,14 +382,21 @@ int exportfs_encode_inode_fh(struct inode
*inode, struct fid *fid,
                             int *max_len, struct inode *parent, int flags)
 {
        const struct export_operations *nop =3D inode->i_sb->s_export_op;
+       enum fid_type type;

        if (!exportfs_can_encode_fh(nop, flags))
                return -EOPNOTSUPP;

        if (!nop && (flags & EXPORT_FH_FID))
-               return exportfs_encode_ino64_fid(inode, fid, max_len);
+               type =3D exportfs_encode_ino64_fid(inode, fid, max_len);
+       else
+               type =3D nop->encode_fh(inode, fid->raw, max_len, parent);
+
+       if (WARN_ON_ONCE(FILEID_USER_FLAGS(type)))
+               return -EINVAL;
+
+       return type;

-       return nop->encode_fh(inode, fid->raw, max_len, parent);
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);

@@ -436,6 +443,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt,
struct fid *fid, int fh_len,
        char nbuf[NAME_MAX+1];
        int err;

+       if (WARN_ON_ONCE(FILEID_USER_FLAGS(fileid_type)))
+               return -EINVAL;
+

I will post it in v3 after testing.

Thanks for the review!
Amir.

