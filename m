Return-Path: <linux-fsdevel+bounces-40990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C154A29C16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CD91888329
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA17C215075;
	Wed,  5 Feb 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXVQK7Ep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59A14F9FD;
	Wed,  5 Feb 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792082; cv=none; b=XRqnY2wM/+TcHqKvACK5ZmWC0br/kFmEfEXV4PqXhvknp2Pu6X31E9eOKNCSNsqkGAFcsKgEkIrbVGEPKPBBzrDVn5IaNeFTdaSJXF1+up7QS6m58Gt+2ilB7Aw8WCQ5W42qWl9eCLlURniSbqBBGtkgndhvoPOIOsWTgYIcZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792082; c=relaxed/simple;
	bh=8AwJCVv7v2zMQx4IM6ZpSqPdwVrU547BaOZtfqNOoCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tj8VDFNJAn1R6Mwe6lsWV5FfLoIvJbJgPn37MSNmKtsO3Wu64b0ID/a1rxoXX5XQoXSuFBT/DmjpjIInNb2UatctC1kx0ZCqA+PcXopGQ42ZGsGyf3nSh1PtBwBG1NhkygA7CXUX/jb/lC8IYUBCsOjz5dLp8DMlchPamf/iyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXVQK7Ep; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so493311a12.0;
        Wed, 05 Feb 2025 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738792079; x=1739396879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6i+YHxCQF5tGzp+tynIdxn0d/qSZ4zyFVpI/YTgnME=;
        b=dXVQK7EpR51+EBk6fuLAZvc7H2wbC9O3Wf84df3UdFUZ32z6fL7D0Dn+2/h97Yj9Hb
         G34WVSNQRbPmLRCGKFesakDs56EEPDZUfb0JG/6Xirm5xl0wRlD7YPcTlZVr/vsCypv+
         C8NLrbIp2vg7YMWvr8aVgpf5MymBjpZGAa15dSHO5mLtOp4InwtQSb1KdQegZcSpHFnb
         KAjBwU3w+JXZS7iMCTd4Jix7rYNAxnRYywvAUD9UxL+Xz0UEEpqNO7zETdsuqcMezgl7
         VWUrIF9nwUPgJJuhgJdhsgVojPlrn8WkVeA+aol5D15wzDPuOKLIhtJPGKaO6K7Ega7Q
         YecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738792079; x=1739396879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6i+YHxCQF5tGzp+tynIdxn0d/qSZ4zyFVpI/YTgnME=;
        b=NSbQdahNLCaSYN2gYBSONQQHWARN0tA1Mg+/Xnrf6jndmEp0XJMMGrUrJ/NyssFxm+
         ElK8Wm0kJITGJpm9oISL6qcB8kriVyLV/TrWJmfe2NdcFFhPO8g1avE4rj5arRiZnoOz
         rSmaTVM9vXzcKj/3LWJzuA0lcvg5GEL2r/Cusrvhl6mnuXVjnNhEAfAnjoOvMzIg+PUK
         ElmbRbYyNNuAp2qz8d0LWe65FazCsK2VqEMg6UY4C2HQ3rp8W1y6ojLbaOkAQsphAv0A
         iDRGUSQnvWPXA+NlHpklrOXOhli+qak4lgwilJRuCIuad7N+BJTrit9X19gilheA+qZ7
         jgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYgiYQkDhLtLsXQKdP/An2le8wYCjEYF0CsctA1s1l4ZRZylYr8zsKhPK6WsBmO1CGqZyuHkiz3mga@vger.kernel.org, AJvYcCW3Q+5i2g+1aS3Wk8V00lEGp5Syapno4SvXpnQznvkn8AZXQ25QZEx91xvDr6cFdxwxUU4WikPq5MnACYOv@vger.kernel.org, AJvYcCXmiS6/jsFultjaNs7N9AWe4xZ2vQMzb6QQRZaFTI+RkxcGYh6ay7X9YFPZqsXxNKZQb9Gq6/pTcRJV7lZkeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBIjF5YnYLkoeNhcYYewYSCTZxZOs0wwxtF10SReOlx8abOxZa
	pA2yMgzwE3X4m36l3Su4bLpnUzsCKiYQhi8f45IwNUzOnkWMm1c3nhGcccjPqQ6DgC13Di6ICcC
	YdEpYUBJzxxixughJz1YSHfkuNak=
X-Gm-Gg: ASbGncvL9ca1O0+Pd+2JeRxANl0o3WRRcMYf2dEtL5oPg51PFaiX43NhXK54TGhUqsA
	KLsizQGdEzL3kMm3JdN/uL8XJJ1TGhsYxTDTMqyHU7ZY4YtpQ2KdaPhSwIBFBidN3eo/CrsU8
X-Google-Smtp-Source: AGHT+IHuIm9TVX2/szx/f6rvESqIiVKGpbxWTxtp1L9/8uypxPz9Nt5HgI5n2b13ogw7E5/q4gU1H2eLlH6Wzm1pHRU=
X-Received: by 2002:a05:6402:2087:b0:5dc:c3c6:5826 with SMTP id
 4fb4d7f45d1cf-5dcecca9240mr896823a12.7.1738792078232; Wed, 05 Feb 2025
 13:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117185947.ylums2dhmo3j6hol@pali> <20250202152343.ahy4hnzbfuzreirz@pali>
 <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com>
 <20250203221955.bgvlkp273o3wnzmf@pali> <CAOQ4uxhkB6oTJm7DvQxFbxkQ1u_KMUFEL0eWKVYf39hnuYrnfQ@mail.gmail.com>
 <20250203233403.5a5pcgl5xylj47nb@pali> <CAOQ4uxisXgDOuE1oDH6qtLYoiFeG55kjpUJaXDxZ+tp2ck++Sg@mail.gmail.com>
 <20250204212638.3hhlbc5muutnlluw@pali> <CAOQ4uxg5k5FP43y93FRujj54kVk8TyXD2AeO_VFJ2m+aB=b1_Q@mail.gmail.com>
 <20250205181645.4ps3kzafyasg4dgj@pali> <20250205190445.ceffnr4vipxsybhn@pali>
In-Reply-To: <20250205190445.ceffnr4vipxsybhn@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 5 Feb 2025 22:47:46 +0100
X-Gm-Features: AWEUYZmuFn7hrrwub0e6n0y_WkZc8m_cenbqemcvv3rXpzYE8Kx-kuRkhWVpFiU
Message-ID: <CAOQ4uxhtgX4V-zcrkcobZpULvbH2X2RtahM-FJ2JH_S511J+7Q@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > What could be useful for userspace is also ability to figure out which
> > > > FS_DOSATTRIB_* are supported by the filesystem. Because for example UDF
> > > > on-disk format supports only FS_DOSATTRIB_HIDDEN bit. And FAT only those
> > > > attributes which are in the lowest byte.
> > > >
> > >
> > > Exactly.
> > > statx has this solved with the stx_attributes_mask field.
> > >
> > > We could do the same for FS_IOC_FS[GS]ETXATTR, but because
> > > right now, this API does not verify that fsx_pad is zero, we will need to
> > > define a new set of ioctl consants FS_IOC_[GS]ETFSXATTR2
> > > with the exact same functionality but that userspace knows that they
> > > publish and respect the dosattrib mask:
> >
> > I understand and this is a problem.
> >
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -868,9 +868,11 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> > >         case FS_IOC_SETFLAGS:
> > >                 return ioctl_setflags(filp, argp);
> > >
> > > +       case FS_IOC_GETFSXATTR2:
> > >         case FS_IOC_FSGETXATTR:
> > >                 return ioctl_fsgetxattr(filp, argp);
> > >
> > > +       case FS_IOC_SETFSXATTR2:
> > >         case FS_IOC_FSSETXATTR:
> > >                 return ioctl_fssetxattr(filp, argp);
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -145,7 +145,8 @@ struct fsxattr {
> > >         __u32           fsx_nextents;   /* nextents field value (get)   */
> > >         __u32           fsx_projid;     /* project identifier (get/set) */
> > >         __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> > > -       unsigned char   fsx_pad[8];
> > > +       __u32           fsx_dosattrib;  /* dosattrib field value (get/set) */
> > > +       __u32           fsx_dosattrib_mask; /* dosattrib field validity mask */
> > >  };
> > >
> > >  /*
> > > @@ -238,6 +248,9 @@ struct fsxattr {
> > >  #define FS_IOC32_SETFLAGS              _IOW('f', 2, int)
> > >  #define FS_IOC32_GETVERSION            _IOR('v', 1, int)
> > >  #define FS_IOC32_SETVERSION            _IOW('v', 2, int)
> > > +#define FS_IOC_GETFSXATTR2              _IOR('x', 31, struct fsxattr)
> > > +#define FS_IOC_SETFSXATTR2              _IOW('x', 32, struct fsxattr)
> > > +/* Duplicate legacy ioctl numbers for backward compact */
> > >  #define FS_IOC_FSGETXATTR              _IOR('X', 31, struct fsxattr)
> > >  #define FS_IOC_FSSETXATTR              _IOW('X', 32, struct fsxattr)
> > >  #define FS_IOC_GETFSLABEL              _IOR(0x94, 49, char[FSLABEL_MAX])
> > >
> > > We could also use this opportunity to define a larger fsxattr2 struct
> > > that also includes an fsx_xflags_mask field, so that the xflags namespace
> > > could also be extended in a backward compat way going forward:
> > >
> > > @@ -145,7 +145,21 @@ struct fsxattr {
> > >         __u32           fsx_nextents;   /* nextents field value (get)   */
> > >         __u32           fsx_projid;     /* project identifier (get/set) */
> > >         __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> > >         unsigned char   fsx_pad[8];
> > >
> > >  };
> > > +
> > > +/*
> > > + * Structure for FS_IOC_[GS]ETFSXATTR2.
> > > + */
> > > +struct fsxattr2 {
> > > +       __u32           fsx_xflags;     /* xflags field value (get/set) */
> > > +       __u32           fsx_extsize;    /* extsize field value (get/set)*/
> > > +       __u32           fsx_nextents;   /* nextents field value (get)   */
> > > +       __u32           fsx_projid;     /* project identifier (get/set) */
> > > +       __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> > > +       __u32           fsx_xflags_mask; /* xflags field validity mask */
> > > +       __u32           fsx_dosattrib;  /* dosattrib field value (get/set) */
> > > +       __u32           fsx_dosattrib_mask; /* dosattrib field validity mask */
> > > +};
> > >
> > > And you'd also need to flug those new mask and dosattrib
> > > via struct fileattr into filesystems - too much to explain.
> > > try to figure it out (unless someone objects) and if you can't figure
> > > it out let me know.
> >
> > Yea, I think that this is thing which I should be able to figure out
> > once I start changing it.
> >
> > Anyway, I have alternative idea to the problem with fsx_pad. What about
> > introducing new fsx_xflags flag which would say that fsx_pad=fsx_dosattrib
> > is present? E.g.
> >
> > #define FS_XFLAG_HASDOSATTRIB 0x40000000
> >
> > Then we would not need new FS_IOC_GETFSXATTR2/FS_IOC_SETFSXATTR2 ioctls.
> >
> > Also fsx_pad has 8 bytes, which can store both attrib and mask, so new
> > struct fsxattr2 would not be needed too.
>
> In case we decide to not do 1-to-1 mapping of Windows FILE_ATTRIBUTE_*

The 1-to-1 is definitely not a requirement of the API.

> constants to these new Linux DOSATTRIB_* constants then we do not need
> 32-bit variable, but just 16-bit variable (I counted that we need just
> 10 bits for now).

The "for now" part is what worries me in this sentence.

> fsx_pad has currently 64 bits and we could use it for:
> - 32 bits for fsx_xflags_mask
> - 16 bits for fsx_dosattrib
> - 16 bits for fsx_dosattrib_mask

This is possible.

> And therefore no need for FS_IOC_GETFSXATTR2/FS_IOC_SETFSXATTR2 iocl or
> struct fsxattr2. Just an idea how to simplify new API. Maybe together

no need for struct fsxattr2.
but regarding no new ioctl I am not so sure.

> with new fsx_xflags bit to indicate that fsx_xflags_mask field is present:
> #define FS_XFLAG_HASXFLAGSMASK 0x20000000
>

I don't think that this flag is needed because there is no filesystem
with empty xflags_mask, so any non zero value of xflags_mask
is equivalent to setting this flag.

This is for the get side. For the set side things are more complicated.
A proper backward compat API should reject (-EINVAL) unknown flags.
As far as I can tell ioctl_fssetxattr() does not at any time verify that
fsx_pad is zero and as far as I can tell xfs_fileattr_set() does not
check for unsupported fsx_xflags.

So unless I am missing something, FS_IOC_FSSETXATTR will silently
ignore dosattrib flags (and mask) when called on an old kernel.
This is the justification of FS_IOC_SETFSXATTR2 - it will fail on an
old kernel, so application can trust that if it works - it also respects
dosattib and the masks.

Yes, applications can call FS_IOC_FSGETXATTR, check non zero
mask and deduce that FS_IOC_FSSETXATTR will respect the mask
This will probably work, but it is not a very clean API IMO.

Thanks,
Amir.

