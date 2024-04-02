Return-Path: <linux-fsdevel+bounces-15881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1889560A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39F0284279
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D2D85925;
	Tue,  2 Apr 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW0iibiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81184A22;
	Tue,  2 Apr 2024 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066546; cv=none; b=hNciZRhUasbHm1/jo8OBQgfJoZv80dhGR9iV0Iewz+vK1jw7ov5voQ1c8z3zABQzX9sKrzbaXT02ecPcN4ubkjFQ2raLw0dkxS5f6waja+uN+oqBsxWh3oscApFocf2/eLwGxwxFHmMFcxOJRh0XfMfa2v/4605DFGEH5lGuyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066546; c=relaxed/simple;
	bh=UO9L6r+vy9lR2lIAPzgynVMMD8ptxjYlJtiwB4qr5Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itTeIOmd5I2+SDvAA9GR2/UPgIYikoBUtMtCLdF4Gk9/6TBnIIBEYNdBCTIrmkBuK2Sw+iQy5Nhxao5ChmHhHhqGgno1739I4E3kyO1XNHr68g8HZjeiogpn0oQ55GZxea800IxezPs+Om7/cdgpTyWRezdBWuUhh7AdfLRB/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW0iibiz; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78a746759b4so379296785a.2;
        Tue, 02 Apr 2024 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712066543; x=1712671343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHSoMgHSVCnzk9XY/4SW/zti9qPkDr59hKAE7jpY8Tg=;
        b=GW0iibizMDfs4tL2jAt3gwJn9oRMyIWxqcPsdSw9pp6Ik6E1wDXST7YfyN8GXu95sU
         7cRy0aIaSNM1UIbzfc936BAF4mcKnYCbZKAysnKKYOf5jEhX6qVnXI4bJAAhUiG0iOly
         t8rw2BbrcZqIlJT6ekbQEgh2XhsJ3Dl1z4oedHOkxYWXIisEEWRURsjC+jNl2ftQLxkt
         z7FpyLdkt/vSqOsEkXgNKRW/erZWgYhD04An+QzgSneBEX4GUAgkwC1aR8UsNkKc68MS
         aC/9a7ED0F1tjfVOKTJNy1OxeydtqVCY/RN9DORTHr6lMr/iIdCx7yqghTRNcvSbisqW
         gMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066543; x=1712671343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHSoMgHSVCnzk9XY/4SW/zti9qPkDr59hKAE7jpY8Tg=;
        b=inZr0bB92Ya1gIjv8BEZ3IULhoqEiYGIb7DkqXPQ6a7AcwUdYruKnRmEfl3ahySCE+
         ik0vs5cM7A5cJ/q1sKZyY+2uKP9fZMhe5GZaONUgtvmp057d67A6swHJuJLauI2ZlAVB
         C9BdFpDfLQgR9alanTPNsS2h9hrOAEpGOO0C6x0W/PPhD57S3r+1ceNQt8g3M+r5OiJh
         5rzStoicNz9ywsgqLNeXlz366YWyrCJ/94iRGRmXYk4Inxjyf5QmZk6vKNohJD5Brwzc
         6L2oUBaN/wBpfN7jDrUjCAQQJ1ANVBa5p7owgTEJW4GuWq7IHfgZ+Pnf1PFxNUGUhMhO
         ouBA==
X-Forwarded-Encrypted: i=1; AJvYcCVsv2T08F2L/H8fmPfOFCDCfFG99h+lrRjQiROdsVRW2h962uJvEya9m0sORJnB7MuZWvnDpfncaUJzEpUjvkVvoDSJFBXntNlBuQxCBUEMS0P8B38fLg+DmuhIEqYUgR2FTiFRjmAVDTqAGA==
X-Gm-Message-State: AOJu0YwprDNxwUD+SNtkuSqG25xZuAQ3y4Q+Xg/5zwoO+oeTSTqzLa0o
	f4XLWBylOhyVB6W7KFSY8hLCsCrS5jTVJ1Nbs9ZCeDvOnFrfoF7q3LA4M/sBwAAWrDSm7DqkLAm
	P2FMuIRSyhX1Eh7zAhCoPGVoQAAA=
X-Google-Smtp-Source: AGHT+IE3Ie6UqpwR2ahcExp5xoKdrL6D3srT7/FC+clGzi0IT7DyqDbvdiFN6ftWm9TmZrO0LeCLO9dpE3KzPEnQxIA=
X-Received: by 2002:ad4:4e62:0:b0:699:514:3031 with SMTP id
 ec2-20020ad44e62000000b0069905143031mr5645451qvb.20.1712066543293; Tue, 02
 Apr 2024 07:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
 <8a8e8c0d-7878-4289-b490-cb9bf17e56b9@fastmail.fm> <f6bbdf158f0ca7a12de9b9f980d4d7fa31399ed9.camel@kernel.org>
In-Reply-To: <f6bbdf158f0ca7a12de9b9f980d4d7fa31399ed9.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Apr 2024 17:02:12 +0300
Message-ID: <CAOQ4uxiv7xSUS7RDK3esa1Crp8reYXewxkr5fFbhG623P20PwA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow FUSE drivers to declare themselves free
 from outside changes
To: Jeff Layton <jlayton@kernel.org>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 4:29=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-04-02 at 15:23 +0200, Bernd Schubert wrote:
> >
> > On 4/2/24 15:10, Jeff Layton wrote:
> > > Traditionally, we've allowed people to set leases on FUSE inodes.  So=
me
> > > FUSE drivers are effectively local filesystems and should be fine wit=
h
> > > kernel-internal lease support. Others are backed by a network server
> > > that may have multiple clients, or may be backed by something non-fil=
e
> > > like entirely. On those, we don't want to allow leases.
> > >
> > > Have the filesytem driver to set a fuse_conn flag to indicate whether
> > > the inodes are subject to outside changes, not done via kernel APIs. =
 If
> > > the flag is unset (the default), then setlease attempts will fail wit=
h
> > > -EINVAL, indicating that leases aren't supported on that inode.
> > >
> > > Local-ish filesystems may want to start setting this value to true to
> > > preserve the ability to set leases.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > This is only tested for compilation, but it's fairly straightforward.
> > >
> > > I've left the default the "safe" value of false, so that we assume th=
at
> > > outside changes are possible unless told otherwise.
> > > ---
> > > Changes in v2:
> > > - renamed flag to FUSE_NO_OUTSIDE_CHANGES
> > > - flesh out comment describing the new flag
> > > ---
> > >  fs/fuse/file.c            | 11 +++++++++++
> > >  fs/fuse/fuse_i.h          |  5 +++++
> > >  fs/fuse/inode.c           |  4 +++-
> > >  include/uapi/linux/fuse.h |  1 +
> > >  4 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index a56e7bffd000..79c7152c0d12 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -3298,6 +3298,16 @@ static ssize_t fuse_copy_file_range(struct fil=
e *src_file, loff_t src_off,
> > >     return ret;
> > >  }
> > >
> > > +static int fuse_setlease(struct file *file, int arg,
> > > +                    struct file_lease **flp, void **priv)
> > > +{
> > > +   struct fuse_conn *fc =3D get_fuse_conn(file_inode(file));
> > > +
> > > +   if (fc->no_outside_changes)
> > > +           return generic_setlease(file, arg, flp, priv);
> > > +   return -EINVAL;
> > > +}
> > > +
> > >  static const struct file_operations fuse_file_operations =3D {
> > >     .llseek         =3D fuse_file_llseek,
> > >     .read_iter      =3D fuse_file_read_iter,
> > > @@ -3317,6 +3327,7 @@ static const struct file_operations fuse_file_o=
perations =3D {
> > >     .poll           =3D fuse_file_poll,
> > >     .fallocate      =3D fuse_file_fallocate,
> > >     .copy_file_range =3D fuse_copy_file_range,
> > > +   .setlease       =3D fuse_setlease,
> > >  };
> > >
> > >  static const struct address_space_operations fuse_file_aops  =3D {
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index b24084b60864..49d44a07b0db 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -860,6 +860,11 @@ struct fuse_conn {
> > >     /** Passthrough support for read/write IO */
> > >     unsigned int passthrough:1;
> > >
> > > +   /** Can we assume that the only changes will be done via the loca=
l
> > > +    *  kernel? If the driver represents a network filesystem or is a=
 front
> > > +    *  for data that can change on its own, set this to false. */
> > > +   unsigned int no_outside_changes:1;
> > > +
> > >     /** Maximum stack depth for passthrough backing files */
> > >     int max_stack_depth;
> > >
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 3a5d88878335..f33aedccdb26 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -1330,6 +1330,8 @@ static void process_init_reply(struct fuse_moun=
t *fm, struct fuse_args *args,
> > >                     }
> > >                     if (flags & FUSE_NO_EXPORT_SUPPORT)
> > >                             fm->sb->s_export_op =3D &fuse_export_fid_=
operations;
> > > +                   if (flags & FUSE_NO_OUTSIDE_CHANGES)
> > > +                           fc->no_outside_changes =3D 1;
> > >             } else {
> > >                     ra_pages =3D fc->max_read / PAGE_SIZE;
> > >                     fc->no_lock =3D 1;
> > > @@ -1377,7 +1379,7 @@ void fuse_send_init(struct fuse_mount *fm)
> > >             FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_E=
XT |
> > >             FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
> > >             FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
> > > -           FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
> > > +           FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_NO_OUTSID=
E_CHANGES;
> > >  #ifdef CONFIG_FUSE_DAX
> > >     if (fm->fc->dax)
> > >             flags |=3D FUSE_MAP_ALIGNMENT;
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index d08b99d60f6f..703d149d45ff 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -463,6 +463,7 @@ struct fuse_file_lock {
> > >  #define FUSE_PASSTHROUGH   (1ULL << 37)
> > >  #define FUSE_NO_EXPORT_SUPPORT     (1ULL << 38)
> > >  #define FUSE_HAS_RESEND            (1ULL << 39)
> > > +#define FUSE_NO_OUTSIDE_CHANGES    (1ULL << 40)
> >
> > Above all of these flags are comments explaining the flags, so that one
> > doesn't need to look up in kernel sources what the exact meaning is.
> >
> > Could you please add something like below?
> >
> > FUSE_NO_OUTSIDE_CHANGES: No file changes through other mounts / clients
> >
>
> Definitely. I've added that in my local branch. I can either resend
> later, or maybe Miklos can just add that if he's otherwise OK with this
> patch.

Don't love the name but don't have any suggestions either.

I am wondering out loud, if we have such a mode for the fs,
if and how should it affect caching configuration?

Thanks,
Amir.

