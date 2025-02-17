Return-Path: <linux-fsdevel+bounces-41829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57266A37D2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 09:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120B6189441E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCE1A0BF3;
	Mon, 17 Feb 2025 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb5DbcLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944F192B63;
	Mon, 17 Feb 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780838; cv=none; b=E125kq+ti/hH2txGkSndQjXLdcDBIZc3lrK0ITFn8Q6SNGX6B8meG99KQCtCy4gPGFIv0ePWKH4t52RrNWCkxO4jDdswuCAcwJtnrH8vSpHmsaXj4Oi4FQIRkT7qJQBqlL1LFNedZaYDGwutDFuZ3VVXDDX95EeEbYU+SLPhGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780838; c=relaxed/simple;
	bh=aYMGrn64Kj8+XUy+ThxhUZUXBMw73ZzLm2kSi9L4eeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu6E01r6V5bttuCIteEkwOn31h6N6aHwEcmsq3keQKSPClzVkPz1iKiLnYHhY/QFL+tWdQNvAQs794R/njvSLnehkMlFwYQt5jY3iDaCCdXVB+Pz0oG1IYXpW2TbuD7x1GbE7hOC+Uh+uDrQ6LitiRcHg/5C1lVI+Ri8UqOdaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb5DbcLd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso667763066b.1;
        Mon, 17 Feb 2025 00:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739780834; x=1740385634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCaeIZCZWpaYMBNzoSvrkc+Jc4wWEETmv90VAz6ClNM=;
        b=bb5DbcLdW02+Q06/a8YSyKY+UCbd0mZaBwNBQ8hEU+9fy9yggarEfUO0DNOFpy/3hv
         XGIO2wSuJ/m1KbD5x0880RDygmWg7tWrbkc5r395FBnKrbEPM9XbeLSGNU9elxaG0ZUX
         xUs/vgRFX+LuRRGnK/Iz61KovJloBVgZS+ERqpEPa9miUsnQRWfl7kDPtXih2yXQVqmL
         8nEOKNPXaIkbHX/WoL+zbGKekckrq4yCFZBPilosGEdBpdYn/1dQEjYGzrhzF/xk2gZD
         ltdm+hKmeJ2dMwCfpXHgAtEfoxR20Qd9QEFdU58D/uv26bC+zcm8hzeYPv9m/gbBzYaa
         7RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739780834; x=1740385634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCaeIZCZWpaYMBNzoSvrkc+Jc4wWEETmv90VAz6ClNM=;
        b=gFvyTKGAb1nISDmlUVmzWkjqVsNL2OjR5MNXhOOa6WQ6pXcbYGTJd9ZJXHis2MwDRv
         ZfKBTu6ceIBjtmJ0rtqF0eXZ4hUYqec2FfeEGsyRMQeggEcLhwumY1A/Sloz3sN1IjJO
         RxX3aLJIzzM84bFDFvTqSzUBkydT4Rbj8GAy5unc3AqXis/XygdY+i1OpoTXEo7aSyrf
         k2GMMTC9+VnGDU1tG+6NGtQM6vAhtrWtxNDNrBFeGdvwToeqhLuNBmHV8ciz1AirvtR8
         iK6sgGQm2vpRlrV3PY2FB7KMNY1ezDwyUe5lVtRCyJdg+YkAgNSZ8qcABzIARWJGiKGB
         5Mfw==
X-Forwarded-Encrypted: i=1; AJvYcCUdZJo1BqegrsQTYngQjhSZNUL4VpoD87oH958sTtNvNzP+9/PzEUBo7UCnm9aZ8pUNXnw3zindttdI8hJ/0g==@vger.kernel.org, AJvYcCXCf3nLjHwdH7h6Ym4G5//RN8QmpO+cmrUlKlZyLiwU74rv6c2BbQJ4GMGzqjfcUu77wq9tCl0U+UX1BeU4@vger.kernel.org, AJvYcCXs8OjYU+sFwjyk8ZG819h37sYeJcyLPRAIdsjQ0c6GQoy+Pb3k5XbQLmpWlObPEmdqB79CK1eLTpG0@vger.kernel.org
X-Gm-Message-State: AOJu0YxApoLzCx5VLK+U4dHp0Zn+ESyThqIOJyCI5Qr9rGHyiSP7y/iY
	eYBq2g9A87NxVNBWhElzLC1h9ynAHcbSIkCmmaWrg7CNMR3wcDZedtn9mo8zol9cMEn95hvYDyn
	YowpE2U+AjsN9yhQG6ePCFv/+Ukk=
X-Gm-Gg: ASbGncu4sITAI5/SirI1VWZidnxtR3HspaR8qGCoyHIqJTYRCDt4bQ0+D/d3Od7GZ1r
	OnuKnwdAJsieAo5B2Rd+WObx8Pw4n4vnIBuFt8naYBf4Kb72h6DzpSbW8ot9ZL31ZfK69/NzG
X-Google-Smtp-Source: AGHT+IHDZqOZ0xB2lJ0rRdbEv4y+IkVEP20zTVgqh41o3/YbcQqnDRnko/AhQFY6wtH9NYADNEOhWrlPCqwcQ5ycssM=
X-Received: by 2002:a17:906:3087:b0:ab7:b643:edd3 with SMTP id
 a640c23a62f3a-abb70921ademr785528566b.11.1739780833784; Mon, 17 Feb 2025
 00:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216164029.20673-1-pali@kernel.org> <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain> <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali> <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <20250216211717.f7mvmh4lwpopbukn@pali>
In-Reply-To: <20250216211717.f7mvmh4lwpopbukn@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Feb 2025 09:27:02 +0100
X-Gm-Features: AWEUYZmQ050mBGZ0GNMtIV4aguuUnqH7mbVIERyptSEOO10-ZbO8HKx2uyV8zJk
Message-ID: <CAOQ4uxgmc+p4-MtFp5WZGCE2DOzcTH22_5X0=phhsbEO9v57HQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Theodore Tso <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steve French <sfrench@samba.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 10:17=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> =
wrote:
>
> On Sunday 16 February 2025 21:43:02 Amir Goldstein wrote:
> > On Sun, Feb 16, 2025 at 9:24=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > >
> > > On Sunday 16 February 2025 21:17:55 Amir Goldstein wrote:
> > > > On Sun, Feb 16, 2025 at 7:34=E2=80=AFPM Eric Biggers <ebiggers@kern=
el.org> wrote:
> > > > >
> > > > > On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Roh=C3=A1r wrote:
> > > > > > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits vi=
a FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> > > > > >
> > > > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > >
> > > > > Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATT=
R, and how does
> > > > > this interact with the existing fscrypt support in ext4, f2fs, ub=
ifs, and ceph
> > > > > which use that flag?
> > > >
> > > > As far as I can tell, after fileattr_fill_xflags() call in
> > > > ioctl_fssetxattr(), the call
> > > > to ext4_fileattr_set() should behave exactly the same if it came so=
me
> > > > FS_IOC_FSSETXATTR or from FS_IOC_SETFLAGS.
> > > > IOW, EXT4_FL_USER_MODIFIABLE mask will still apply.
> > > >
> > > > However, unlike the legacy API, we now have an opportunity to deal =
with
> > > > EXT4_FL_USER_MODIFIABLE better than this:
> > > >         /*
> > > >          * chattr(1) grabs flags via GETFLAGS, modifies the result =
and
> > > >          * passes that to SETFLAGS. So we cannot easily make SETFLA=
GS
> > > >          * more restrictive than just silently masking off visible =
but
> > > >          * not settable flags as we always did.
> > > >          */
> > > >
> > > > if we have the xflags_mask in the new API (not only the xflags) the=
n
> > > > chattr(1) can set EXT4_FL_USER_MODIFIABLE in xflags_mask
> > > > ext4_fileattr_set() can verify that
> > > > (xflags_mask & ~EXT4_FL_USER_MODIFIABLE =3D=3D 0).
> > > >
> > > > However, Pali, this is an important point that your RFC did not fol=
low -
> > > > AFAICT, the current kernel code of ext4_fileattr_set() and xfs_file=
attr_set()
> > > > (and other fs) does not return any error for unknown xflags, it jus=
t
> > > > ignores them.
> > > >
> > > > This is why a new ioctl pair FS_IOC_[GS]ETFSXATTR2 is needed IMO
> > > > before adding support to ANY new xflags, whether they are mapped to
> > > > existing flags like in this patch or are completely new xflags.
> > > >
> > > > Thanks,
> > > > Amir.
> > >
> > > But xflags_mask is available in this new API. It is available if the
> > > FS_XFLAG_HASEXTFIELDS flag is set. So I think that the ext4 improveme=
nt
> > > mentioned above can be included into this new API.
> > >
> > > Or I'm missing something?
> >
> > Yes, you are missing something very fundamental to backward compat API =
-
> > You cannot change the existing kernels.
> >
> > You should ask yourself one question:
> > What happens if I execute the old ioctl FS_IOC_FSSETXATTR
> > on an existing old kernel with the new extended flags?
> >
> > The answer, to the best of my code emulation abilities is that
> > old kernel will ignore the new xflags including FS_XFLAG_HASEXTFIELDS
> > and this is suboptimal, because it would be better for the new chattr t=
ool
> > to get -EINVAL when trying to set new xflags and mask on an old kernel.
> >
> > It is true that the new chattr can call the old FS_IOC_FSGETXATTR
> > ioctl and see that it has no FS_XFLAG_HASEXTFIELDS,
>
> Yes, this was my intention how the backward and forward compatibility
> will work. I thought that reusing existing IOCTL is better than creating
> new IOCTL and duplicating functionality.
>
> > so I agree that a new ioctl is not absolutely necessary,
> > but I still believe that it is a better API design.
>
> If it is a bad idea then for sure I can prepare new IOCTL and move all
> new functionality only into the new IOCTL, no problem.
>

Well, there is at least one flaw in using the get ioctl for support detecti=
on,
as Eric pointed out -
the settable xflags set is a subset of the gettable flags set.

Let's ask some stake holders shall we?

Ted, Darrick, Eric,

What is your opinion on the plan presented in this patch set to extend the =
API:

1. Add some of the *_FL flags to FS_XFLAG_COMMON [*]
2. Add fsx_xflags2 for more xflags
3. Add fsx_xflags{,2}_mask to declare the supported in/out xflags
4. Should we use the existing FS_IOC_FSSETXATTR ioctl which ignores
   setting unknown flags or define a new v2 ioctl FS_IOC_SETFSXATTR_V2
   which properly fails on unknown flags [**]

[*] we can consider adding all of the flags used by actively maintained fs =
to
    FS_XFLAGS_COMMON, something like the set of F2FS_GETTABLE_FS_FL,
    maybe even split them to FS_XFLAGS_COMMON_[GS]ETTABLE
[**] we can either return EINVAL for unknown flags or make the ioctl _IOWR
     and return the set of flags that were not ignored

Thanks,
Amir.

