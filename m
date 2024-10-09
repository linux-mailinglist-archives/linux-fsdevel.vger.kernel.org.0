Return-Path: <linux-fsdevel+bounces-31455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58284996F9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 17:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDABA283A2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B201E04AA;
	Wed,  9 Oct 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMkmvZzZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E02E64A;
	Wed,  9 Oct 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486985; cv=none; b=fSIghlvgJfKI0xT8A3UhsYkePh+Wrxk6sqQsphqUh/ZwSG2KOjHtZ01dqAaFGuXb+y1/xzZRWt7Am1DlwORwoNz3VMMLwOa+mHZ/1WMnfeoIMnEmmtSFfrDmMAJS6N2DQBxkl/ChAzqH8l/M4twq1+x7RfsNSM8uTNy1JKfvkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486985; c=relaxed/simple;
	bh=Tjst/Cq0tTVUI5BpbacV9XF7ZqrGKpXgiNhIuNGhw2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMaHG9k/CIFuk5mjLq8aQrsYfObgA7zTouyV6Fsp7+5KCskrjEno/ppWAWwU2WH1LLFGZfVPouRLWsgS/5Rpfdyn5ZhW61upXd/dQRmsGJFOjn8vMfMxsbNNS3CJ+oYg3zNMwZvhB86y8T3J0Ixerv4RdNjo1wJXvqhWHRIS/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMkmvZzZ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e989f7cc7aso314877eaf.0;
        Wed, 09 Oct 2024 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728486983; x=1729091783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUSmiAjUzkNnuQou8ah0RapUYo7grRYceTJLCUA+Qmk=;
        b=LMkmvZzZe3kylY+XaOuYTaGI69AEdAHFFEMuaYNY1ncRMVXinZsySKzJ7Iq92Rz7tr
         XH1In4NxgCdZhZhSYcI4ZuOeQ4S166ccacjYQKQLW7RpmDVX+Jdn47nA4Jsz5uvMYEew
         wkpvSY9Jyaq6c0rNLTWZBwkMwl8Vz3XAJ4pauhrQMZ3fEpju6C+Y+OHFFFrESVno/2qV
         l3PbNnth/t85pEiVGd83pScOIn8pfjWjrKaEGmUxMNn1IIoD34JtDaIaQzpE2a2/XOay
         8yZxPrpy0FErBlDO9rXMm5GGXczUaFe52wUkAYt3+tAcxPtFTZ6VDSk5Va7KFS0PlkIg
         hFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486983; x=1729091783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUSmiAjUzkNnuQou8ah0RapUYo7grRYceTJLCUA+Qmk=;
        b=T4xViYQACYmTp0li1a9jpVPNQIuT4VNq6P39NBhHnjiCjP9Y1RK0cBFZGC58l+zR9k
         TMdJ69TP2bljs+LyEBkKSAoqzhIX4rExXL4zq9eZQ2s0KBBjcMf9LaJpj/8N5SB+GJQx
         2nXdkNcF4I1qtW4nobNA7MC14ZYOP5avFS9OiC5mYAVh9kLMDvGpVKUqn9TCnaaZKy7r
         tyCMTH4wP7ETZMSjgzNoJYEGJhnSvEOXUmm4a+eOFZx5MTRFZeKqzbk3VP+jm6Mu27Mn
         bd9p/XvXq67ly+EJe+2N7DGseKg4Uf768evwvk1o/GKlztIVfct2tDl54DZthu4KYDrZ
         juqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVungdY2qCUI8Tnd2PacFRqNaI18d+kI5E7Tn504CSfEjDCm3A3adHLWgBvt+2Z6jhzzpf3oxkMReV@vger.kernel.org, AJvYcCWuoAzeo/aeV3eXq2j+FZoyXkJdNpZYwwE7cHI0X3/PbGoXFeVf6SSBVBVQ5Pv7mka0YfKf9L1mqJUPxBHN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WQ/ievHmpzn8HcZThzijrXr9VxOTTIKYGl+2d0k7hDgWgngx
	cTUu+/IPYwkAzlZcEhBouLKQNYTvrhd6sAfqqXX5gejWIC4b90CG4Y7DCrU9f1LLvddgSPHMZkw
	HG3KsgQQ++XE/CS41zeGx/Z7dWxY=
X-Google-Smtp-Source: AGHT+IG4uUMaOnXrekKHsOJz/i2VomYUTZ+uYT68YRskTeQLVqMudwim/WEOY7T+N62zcoNvznvc2z9vuZg9llbSbng=
X-Received: by 2002:a05:6358:6501:b0:1b1:acdf:e94f with SMTP id
 e5c5f4694b2df-1c3081ba757mr76973455d.19.1728486982482; Wed, 09 Oct 2024
 08:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923082829.1910210-1-amir73il@gmail.com> <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com>
 <021d3f9acf33ff74bfde7aadd6a9a01a8ee64248.camel@kernel.org>
 <CAOQ4uxht3A7Rx5eu=DX=Zn2PNyQnj5BkCLMi36Gftt0ej8KhdA@mail.gmail.com> <20241009094034.xgcw2inu2tun4qrq@quack3>
In-Reply-To: <20241009094034.xgcw2inu2tun4qrq@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Oct 2024 17:16:10 +0200
Message-ID: <CAOQ4uxgoZBznM8VsnDoNekuMep8qN7eM8zUsYpS=C4OKC3ZMMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to userspace
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:40=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 08-10-24 15:11:39, Amir Goldstein wrote:
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
>
> Thanks. I've actually seen this series on list, went "eww bitfields, let'=
s
> sleep to this" and never got back to it.
>
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
> > +
> > +/* Flags supported in encoded handle_type that is exported to user */
> > +#define FILEID_USER_FLAGS_MASK 0xffff0000
> > +#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
> > +
> > +#define FILEID_IS_CONNECTABLE  0x10000
> > +#define FILEID_IS_DIR          0x40000
> > +#define FILEID_VALID_USER_FLAGS        (FILEID_IS_CONNECTABLE | FILEID=
_IS_DIR)
>
> FWIW I prefer this variant much over bitfields as their binary format
> depends on the compiler which leads to unpleasant surprises sooner rather
> than later.
>mask
> > +#define FILEID_USER_TYPE_IS_VALID(type) \
> > +       (FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS)
>
> The macro name is confusing

Confusing enough to hide the fact that it was negated in v2...

> because it speaks about type but actually
> checks flags. Frankly, I'd just fold this in the single call site to make
> things obvious.

Agree. but see below...

>
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
>
> Maybe you want to make handle_type unsigned when you treat it (partially)
> as flags? Otherwise some constructs can lead to surprises with sign
> extension etc...

That seems like a good idea, but when I look at:

        /* we ask for a non connectable maybe decodeable file handle */
        retval =3D exportfs_encode_fh(path->dentry,
                                    (struct fid *)handle->f_handle,
                                    &handle_dwords, fh_flags);
        handle->handle_type =3D retval;
        /* convert handle size to bytes */
        handle_bytes =3D handle_dwords * sizeof(u32);
        handle->handle_bytes =3D handle_bytes;
        if ((handle->handle_bytes > f_handle.handle_bytes) ||
            (retval =3D=3D FILEID_INVALID) || (retval < 0)) {
                /* As per old exportfs_encode_fh documentation
                 * we could return ENOSPC to indicate overflow
                 * But file system returned 255 always. So handle
                 * both the values
                 */
                if (retval =3D=3D FILEID_INVALID || retval =3D=3D -ENOSPC)
                        retval =3D -EOVERFLOW;
                /*

I realize that we actually return negative values in handle_type
(-ESTALE would be quite common).

So we probably don't want to make handle_type unsigned now,
but maybe we do want a macro:

#define FILEID_IS_USER_TYPE_VALID(type) \
             ((type) >=3D 0 && \
              !(FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS))

that will be used for the assertions instead of assuming that
FILEID_USER_FLAGS_MASK includes the sign bit.

huh?

Thanks,
Amir.

