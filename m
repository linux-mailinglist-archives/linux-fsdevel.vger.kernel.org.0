Return-Path: <linux-fsdevel+bounces-41806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFBEA37784
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 21:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C8E3AC921
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CE1A3146;
	Sun, 16 Feb 2025 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUzl0Lg5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D03199BC;
	Sun, 16 Feb 2025 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739738598; cv=none; b=FOCASfYqzyzP5ykrbs8bFD1RL9v8e4f72xZ5X+IYRZfkuXwIfUibWru6t+finNqvyLCGcPxm9x6NiqkZwQ4Lfy/52CXJkoNqDhqmGuWzD6shEedS79yOLCV9rOCDc4jGd4QiE6z5Su2GddbPmb4KvRE+joEz+EBfu+aNT1jKMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739738598; c=relaxed/simple;
	bh=i0TnNL0mPBsj9x/8IMTCWEHhpfJOfnbuh57vSruKwk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPZc6rSMupAe1XZN/pJAjt4wtLCh3VHEYq2mzqBCW1fG2doUjdVzED5Dx74r0zlh0tXzObHDXso+hKaKtZS46lSOxjrzDzquXDPH3ezKnJIQAl9HVWgNCIvSpSvqMVPVg9rd6wgzTsHxs64IU9M4UtWZ22aWL6GBTQa7Ovv1Fa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUzl0Lg5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaecf50578eso737002766b.2;
        Sun, 16 Feb 2025 12:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739738595; x=1740343395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDJHN/sJdzU0XnFW/6OJr3ce70GFSWfqBMLTWdzeAvA=;
        b=eUzl0Lg5YDTEdAxgOoabQVe7Nzzsdh+UzOCWAG++1SlPZzpsYdRiOKZM1l00nZqTVP
         UnaoFTW47h3cp9NPiHuZU4rVI8ZcSztQV83QT8LwVtOG/vA6OOn2ixuJbrOaGQBy5pG7
         tFxqVLJt8GFbd9UarUaPx9XaORmwQU1d/cmtRzqVqklSysL6ugIrFI8Av13bbHiyRogS
         X/ZKyfpHtPLGh/jQIDm87reBFM4JabfvVaocRVp6CCLXXxkwP7uoVjrQJkrNgVcLlFCy
         pjmlonA3ziEoVwppSLLBaP5n1/XZnuolDBhHDM0R++O7RKcNN7/+2HN0+qTqrNLsro/o
         6KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739738595; x=1740343395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDJHN/sJdzU0XnFW/6OJr3ce70GFSWfqBMLTWdzeAvA=;
        b=fLuvCCpL59itS70HO5PKK+kL/OCvH7Lx1tl26Xx6PR6vskScalCrzGfRgTku2Q/NQe
         Fzu29nEqE/2SEV+Pcjx9rSxoGkmSbWVWjhEolnwXbpOU9FCUerPf+5zpgnVnbiCUXJ8u
         VedMvP/rzWXBYduKUQll6clDDCOxDhtcD4cDnm82pIqjOiG5UyzJKUTXE98/08K7jV34
         jKib9XtZSqO+f6X1jSHRTyW7txUU0WFKPAOtfWs0IidC5+f6qWRPVGdhks6NuqFeuSeJ
         fZOm1MlE8t7YoEXtE4dL/FFTWNOeCH1bubTxHX5alFgXWDGrmq8IcniJvjg5LPle96ez
         Xx7g==
X-Forwarded-Encrypted: i=1; AJvYcCUjtlW+GWUve93zchMKJmFph6aMYIU/kxxBEjJOFt05WNNRcSyDDEl+P9nd+L0Uas9SDyY5+DkJUAO/6ZqIsg==@vger.kernel.org, AJvYcCWcFpmawLKh/WpsTq/A5cXdBGtruB9CtH/gbdsD1ycA7aufXTameFE1o1G/aNzophnMU2oZ8PpQhaGG@vger.kernel.org, AJvYcCX+kn+rlygNCfTKSrT8fBilPaK6qSTxRqIoQPfkvQRuyzMM1hvyBDteYw+4Q+UCJ1GJnyQiuQi1JVIQqTRB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90LFHULpEnlxjyiuvIVGovKSeVwi+NXP8lEMzfldcDTQnxiNM
	s1Ic+nCWnZY6dIicIM4i3rvXfTHTbwA2dSwXIRs1mmAMNkkJhQVk//F5ZxeUOeS9D7ExcKTumYv
	uMDMNPn9g+QYGmKuQGe8Br6xIVpk=
X-Gm-Gg: ASbGnctF4N/Ff0aOaAHCZGDJubXj6uV8TWZP2BcnH1a/mFcmPU+UMog783JFOLOQdQ8
	XQ1dVhfeBbBRaU7hXxbtonofLwDZvlwCKbiJVfDVR7/dMXKIx6i4Xhdt33vLjf2s1GGIW0W3V
X-Google-Smtp-Source: AGHT+IGOi//4xOghGQIZFfq9BmDtrZosP4mvSGO2Pxy90gGJJjvcF7ygnY9XFjY0r+Hra7YrFV0N7wN9Iseqmo31vCM=
X-Received: by 2002:a17:906:4fd5:b0:ab7:83c2:bdb7 with SMTP id
 a640c23a62f3a-abb70db35d5mr789033166b.49.1739738594621; Sun, 16 Feb 2025
 12:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216164029.20673-1-pali@kernel.org> <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain> <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
In-Reply-To: <20250216202441.d3re7lfky6bcozkv@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 16 Feb 2025 21:43:02 +0100
X-Gm-Features: AWEUYZmVfOewsk3c-4SQpyNVmUun_33bT4EmlDPGr8c9B4lBdvYa-m9s2qcLcNc
Message-ID: <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	ronnie sahlberg <ronniesahlberg@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steve French <sfrench@samba.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 9:24=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Sunday 16 February 2025 21:17:55 Amir Goldstein wrote:
> > On Sun, Feb 16, 2025 at 7:34=E2=80=AFPM Eric Biggers <ebiggers@kernel.o=
rg> wrote:
> > >
> > > On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Roh=C3=A1r wrote:
> > > > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS=
_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> > > >
> > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > >
> > > Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATTR, a=
nd how does
> > > this interact with the existing fscrypt support in ext4, f2fs, ubifs,=
 and ceph
> > > which use that flag?
> >
> > As far as I can tell, after fileattr_fill_xflags() call in
> > ioctl_fssetxattr(), the call
> > to ext4_fileattr_set() should behave exactly the same if it came some
> > FS_IOC_FSSETXATTR or from FS_IOC_SETFLAGS.
> > IOW, EXT4_FL_USER_MODIFIABLE mask will still apply.
> >
> > However, unlike the legacy API, we now have an opportunity to deal with
> > EXT4_FL_USER_MODIFIABLE better than this:
> >         /*
> >          * chattr(1) grabs flags via GETFLAGS, modifies the result and
> >          * passes that to SETFLAGS. So we cannot easily make SETFLAGS
> >          * more restrictive than just silently masking off visible but
> >          * not settable flags as we always did.
> >          */
> >
> > if we have the xflags_mask in the new API (not only the xflags) then
> > chattr(1) can set EXT4_FL_USER_MODIFIABLE in xflags_mask
> > ext4_fileattr_set() can verify that
> > (xflags_mask & ~EXT4_FL_USER_MODIFIABLE =3D=3D 0).
> >
> > However, Pali, this is an important point that your RFC did not follow =
-
> > AFAICT, the current kernel code of ext4_fileattr_set() and xfs_fileattr=
_set()
> > (and other fs) does not return any error for unknown xflags, it just
> > ignores them.
> >
> > This is why a new ioctl pair FS_IOC_[GS]ETFSXATTR2 is needed IMO
> > before adding support to ANY new xflags, whether they are mapped to
> > existing flags like in this patch or are completely new xflags.
> >
> > Thanks,
> > Amir.
>
> But xflags_mask is available in this new API. It is available if the
> FS_XFLAG_HASEXTFIELDS flag is set. So I think that the ext4 improvement
> mentioned above can be included into this new API.
>
> Or I'm missing something?

Yes, you are missing something very fundamental to backward compat API -
You cannot change the existing kernels.

You should ask yourself one question:
What happens if I execute the old ioctl FS_IOC_FSSETXATTR
on an existing old kernel with the new extended flags?

The answer, to the best of my code emulation abilities is that
old kernel will ignore the new xflags including FS_XFLAG_HASEXTFIELDS
and this is suboptimal, because it would be better for the new chattr tool
to get -EINVAL when trying to set new xflags and mask on an old kernel.

It is true that the new chattr can call the old FS_IOC_FSGETXATTR
ioctl and see that it has no FS_XFLAG_HASEXTFIELDS,
so I agree that a new ioctl is not absolutely necessary,
but I still believe that it is a better API design.

Would love to hear what other fs developers prefer.

Thanks,
Amir.

