Return-Path: <linux-fsdevel+bounces-39862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC7A19984
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFE516B9AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C6F215F51;
	Wed, 22 Jan 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GipBCVNx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630291607AC;
	Wed, 22 Jan 2025 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576714; cv=none; b=OpufJfJUF3kYvexJK+Uoxe1T/J2Ez2U8n2jDkavFLLfvt0eX+tUegyA8q43uW4bwUGiO1yihVUlzFrPb5ZfqeEy65T8jf6QvNvT2h15CzKnAI4ixg4Mkc7R/Bx6Je5kBe4Nn5IZGdUmFjJWralmgCVkdwzS1O/rcz4dRmxGeTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576714; c=relaxed/simple;
	bh=xBihi7dNreWMzaceKWKxWPtRKMk+hiSWNyQ9CmdGQO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwbJz/HdZUTURB9aPjEHW7iewrd0XRCFpbQ58j10t10A91e9ekkM8jJkJOS1TnIJ2wknzAHM8OkpnXgj9WBED2COpJeQis5vccAv5AmdCJb0OQuwuI8NqWIbHAujPecg3gtE4VbHWZzWWwZn0l1oLZmVsHJXef3JrW1TIyykz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GipBCVNx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso2467129a12.0;
        Wed, 22 Jan 2025 12:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737576710; x=1738181510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTPkI92GuTCrKXb0d1+FDO10PR5BjBDuYslaw6jsxdg=;
        b=GipBCVNxom/Ic6IyW6weGwe6bQKIk3ETL+V530wjB1XEikMDfBdf1mOtWgXAxpx8iT
         y6gnS2oCVGhMmARXPoUDSkjNEClxJOnUydvjUbTHuf6dmrap0fy5gl4rDtz1K9QkRTKE
         o4kcNaJ4m3CD+lbIf2j7EAJhCUQVAso9nRjXKh8jD+3+3GRsMwu0KGWyvRkQjBWjU/9u
         9iHwqRxhr+iHV4TbzDp/Hc6U3FlhRGrUHCFpqeMEUI2ZTwgPOuasiIoB0JgQLf928Lju
         JmvvAsCLSojRNp+PXIbbbeRvtetnjehjYnIQIKho4U8yu5CA6ql3liVPLIVczfMV5mRS
         YPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737576710; x=1738181510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTPkI92GuTCrKXb0d1+FDO10PR5BjBDuYslaw6jsxdg=;
        b=MCeptN8mCbj7ZkLVdz4woLXAxDpdj7rPaUTTtMEh0CjCku+CmWg0NVf85t31I4W1Xi
         SL1lD93bDmYfVib1Pep0xX9lHiyPjG7ZXydsgC2Q8qULrvWbA61s887Rx9KPGytHt06A
         cIOB7RcVg6jnzgdyzYV0SYHteKqsOreBy7/J198gzRvd257NAjlmtv0hcJM9SVYl7CuE
         3tAcWbfSWrifxa8cFHDn9WSxlJlWIYtoZ+XpG6EQeae5MnHS9GgJZ6l5HjjE86EKnUAp
         svDnKGMBzvvlVtOncb9V+CmoMU8p8R072sabZiaCGwBAFs9zHV/5mtCIAkdYC/afBQWN
         YiNw==
X-Forwarded-Encrypted: i=1; AJvYcCVEQevFTTUqH0g7ugbBm32vClYALCbuC37JcsAMl/n1UafkpRV49obm8WX96hnqED9Rc0vtEZfKmfgc7x51@vger.kernel.org, AJvYcCVO9EU5jh6lx7W9/M4dtWZ0eZqW5K6YidyJE3pkIaDdZXpbCjj1xHkZxszie1q4PqJXZl4RI0ylE80R@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwNO6IO2f7DeBa8zz4fS83ZxATbXvxsIEXnsnOLJfJLDulkKC
	XtAIkT+Vx/ZoqDiNY2xitqRh0+cGA1WJXKfT2tC6Be9m6IMidbloHN+sepIFMNVSej56FYgvWDC
	+25TPOOOBpHGIwuQiR55jvyhxbqU=
X-Gm-Gg: ASbGncvcCUMIGYwB488JmYUr2oq7pHHSJaw26jEYLa4CMmNE1lMhL0P1lsEeWNyjBwA
	HCO6jMAOLdVdemAKiPWi773uJs9SSS3hZpr4gOyEO108GWXfDQHo=
X-Google-Smtp-Source: AGHT+IHK2/ameRjIgPI1iNsY5XznymEDMCSrff0kyjQwGh6dHT1ykdsmr6yvVuOd8Chi2FmU7pZobn42Q+BIsy4vSzI=
X-Received: by 2002:a17:907:7e82:b0:aa5:1d68:1f43 with SMTP id
 a640c23a62f3a-ab662968428mr63938666b.11.1737576710058; Wed, 22 Jan 2025
 12:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
 <173750034870.22054.1620003974639602049@noble.neil.brown.name>
 <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com>
 <c2401cbe-eae9-44ab-b36c-5f91b42c430d@oracle.com> <CAOQ4uxi3=tLsRNyoJk4WPWK5fZrZG=o_8wYBM6f4Cc5Y48DbrA@mail.gmail.com>
 <50c4f76e-0d5b-41a7-921e-32c812bd92f3@oracle.com> <CAOQ4uxiVLTv94=Xkiqw4NJHa8RysE3bGDx64TLuLF+nxkOh-Eg@mail.gmail.com>
 <d36de874-7603-478b-a01e-b7d1eb7110d3@oracle.com>
In-Reply-To: <d36de874-7603-478b-a01e-b7d1eb7110d3@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Jan 2025 21:11:38 +0100
X-Gm-Features: AbW1kvYYiGXA_LgUmU7rKfDIG6HRKT2LXkqHprUsv9YrvW-Occ32Em3B-z90fEI
Message-ID: <CAOQ4uxgnQ-4azkpsPm+tyd7zgXWUxXq7vWCfksPPF864rpN27Q@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 8:20=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/22/25 1:53 PM, Amir Goldstein wrote:
> >>> I am fine with handling EBUSY in unlink/rmdir/rename/open
> >>> only for now if that is what everyone prefers.
> >>
> >> As far as I can tell, NFSv2 and NFSv3 REMOVE/RMDIR are working
> >> correctly. NFSv4 REMOVE needs to return a status code that depends
> >> on whether the target object is a file or not. Probably not much more
> >> than something like this:
> >>
> >>          status =3D vfs_unlink( ... );
> >> +       /* RFC 8881 Section 18.25.4 paragraph 5 */
> >> +       if (status =3D=3D nfserr_file_open && !S_ISREG(...))
> >> +               status =3D nfserr_access;
> >>
> >> added to nfsd4_remove().
> >
> > Don't you think it's a bit awkward mapping back and forth like this?
>
> Yes, it's awkward. It's an artifact of the way NFSD's VFS helpers have
> been co-opted for new versions of the NFS protocol over the years.
>
> With NFSv2 and NFSv3, the operations and their permitted status codes
> are roughly similar so that these VFS helpers can be re-used without
> a lot of fuss. This is also why, internally, the symbolic status codes
> are named without the version number in them (ie, nfserr_inval).
>
> With NFSv4, the world is more complicated.
>
> The NFSv4 code was prototyped 20 years ago using these NFSv2/3 helpers,
> and is never revisited until there's a bug. Thus there is quite a bit of
> technical debt in fs/nfsd/vfs.c that we're replacing over time.
>
> IMO it would be better if these VFS helpers returned errno values and
> then the callers should figure out the conversion to an NFS status code.
> I suspect that's difficult because some of the functions invoked by the
> VFS helpers (like fh_verify() ) also return NFS status codes. We just
> spent some time extracting NFS version-specific code from fh_verify().
>
>
> > Don't you think something like this is a more sane way to keep the
> > mapping rules in one place:
> >
> > @@ -111,6 +111,26 @@ nfserrno (int errno)
> >          return nfserr_io;
> >   }
> >
> > +static __be32
> > +nfsd_map_errno(int host_err, int may_flags, int type)
> > +{
> > +       switch (host_err) {
> > +       case -EBUSY:
> > +               /*
> > +                * According to RFC 8881 Section 18.25.4 paragraph 5,
> > +                * removal of regular file can fail with NFS4ERR_FILE_O=
PEN.
> > +                * For failure to remove directory we return NFS4ERR_AC=
CESS,
> > +                * same as NFS4ERR_FILE_OPEN is mapped in v3 and v2.
> > +                */
> > +               if (may_flags =3D=3D NFSD_MAY_REMOVE && type =3D=3D S_I=
FREG)
> > +                       return nfserr_file_open;
> > +               else
> > +                       return nfserr_acces;
> > +       }
> > +
> > +       return nfserrno(host_err);
> > +}
> > +
> >   /*
> >    * Called from nfsd_lookup and encode_dirent. Check if we have crosse=
d
> >    * a mount point.
> > @@ -2006,14 +2026,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
> > svc_fh *fhp, int type,
> >   out_drop_write:
> >          fh_drop_write(fhp);
> >   out_nfserr:
> > -       if (host_err =3D=3D -EBUSY) {
> > -               /* name is mounted-on. There is no perfect
> > -                * error status.
> > -                */
> > -               err =3D nfserr_file_open;
> > -       } else {
> > -               err =3D nfserrno(host_err);
> > -       }
> > +       err =3D nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
> >   out:
> >          return err;
>
> No, I don't.
>
> NFSD has Kconfig options that disable support for some versions of NFS.
> The code that manages which status code to return really needs to be
> inside the functions that are enabled or disabled by Kconfig.
>
> As I keep repeating: there is no good way to handle the NFS status codes
> in one set of functions. Each NFS version has its variations that
> require special handling.
>
>

ok.

> >> Let's visit RENAME once that is addressed.
> >
> > And then next patch would be:
> >
> > @@ -1828,6 +1828,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct
> > svc_fh *ffhp, char *fname, int flen,
> >          __be32          err;
> >          int             host_err;
> >          bool            close_cached =3D false;
> > +       int             type;
> >
> >          err =3D fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
> >          if (err)
> > @@ -1922,8 +1923,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct
> > svc_fh *ffhp, char *fname, int flen,
> >    out_dput_new:
> >          dput(ndentry);
> >    out_dput_old:
> > +       type =3D d_inode(odentry)->i_mode & S_IFMT;
> >          dput(odentry);
> >    out_nfserr:
> > -        err =3D nfserrno(host_err);
> > +       err =3D nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
>
> Same problem here: the NFS version-specific status codes have to be
> figured out in the callers, not in nfsd_rename(). The status codes
> are not common to all NFS versions.
>
>

ok.

> >> Then handle OPEN as a third patch, because I bet we are going to meet
> >> some complications there.
> >
> > Did you think of anything better to do for OPEN other than NFS4ERR_ACCE=
SS?
>
> I haven't even started to think about that yet.
>

ok. Let me know when you have any ideas about that.

My goal is to fix EBUSY WARN for open from FUSE.
The rest is cleanup that I don't mind doing on the way.

Thanks,
Amir.

