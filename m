Return-Path: <linux-fsdevel+bounces-39965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D99A1A71C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C64616401F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936521322E;
	Thu, 23 Jan 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/m82Fg+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D81212FA9;
	Thu, 23 Jan 2025 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737646185; cv=none; b=ohUlfZaR8akepNsACLk5k+FcVrSDLPT4ZO4KJrbTPSFdpe53DTFsb+cOOdf/peGPRgGWD6Yr7QyK/QmaiwydxSijCXJJHLHKkr59IE1t6wR7IdMc4CeYNun/ptlBLTwaeY8JPDRjjzuXpYjeZiul82FK2okCeBOcep7UJtwiLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737646185; c=relaxed/simple;
	bh=mq7xrx3xIvyXIlFgVyzri+Keu7fwWAeVYgwfmb8/ImM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtD7q2xRPb7VI1Dhf56Gr6EmYbKWmjMKTLXWXQQbNBi0wwZPey9cXsAdH/pufORm3aZjjNOIAVYRWkZ35TmipkavPT8e4lRj1kIZQXpkACL6iOURQfw8q4KinHz2/HJ1tKcHr9jbgrgghf0iefpaZwiaD5Kq9peKWWnhKkn/OQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/m82Fg+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso2094796a12.1;
        Thu, 23 Jan 2025 07:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737646182; x=1738250982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZECAaYfGleNUqSkOIWm4eUSCKBHjZFYJUrsrVpIH07Q=;
        b=O/m82Fg+TE48PlOM+y3r0xzbyl5jv0pfyk+ZDwmjzXxIMz1E7u/slA0giBLa9xGSNz
         3hf9iLz9lWIh3kFsQFQ9JC6/rvU7ARp/V0Ld+eo3Xr45sB8y06Vn8KXoWi3sqrnL1ydG
         DFs06cAt+PvPQX8nkta2q1OZEZC7sJ9ShIOZ5mDYkDUqa6WRDTntQ9di57uLvkTOzBg4
         2Uci3ZCflnjYcbLFEOrGZ3rQiE9uwB/ERbkxUgz6Hbw6mya2P+nqzu8kH6lxp9laGYIU
         Sye36L72zOtCRm/R/LF1saAnnQgvMm9ove1H8azFyMkf4GjTXAnFmsqNwiRjGO7Vkvb2
         W16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737646182; x=1738250982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZECAaYfGleNUqSkOIWm4eUSCKBHjZFYJUrsrVpIH07Q=;
        b=NUSHVYbMCWrUVm1xxad7pj7iwRoa4sSH5Miu7JdCtdzKk3Xq8Gra6SUMkOoTZenhUw
         WQ24FjF2Sc1DTjoHsltpn4PAxOLRD57CymwR3PtBLsYCKy5YlYc6r0tSRi3hieRVmZeK
         xA7gGp3z+N10fCyTNevAcLxdCkkytEHc0ldEWbzFrA9/1dcuF1faUALYqG2l8upjVzFt
         a4Wq4usdOM8ycni+H67d+CGHz+ewWnRJQJ5CjBl1FPCXkmSwVR5aira+EZMLu58rJMMM
         naXGrtV2pIg+z1MSFXn7K+ZfM+uU12EWTwAlLROHBcPupo02A8aKRtJ9TGQAzq8Lax3c
         J7mg==
X-Forwarded-Encrypted: i=1; AJvYcCUlnItrS6XACDZVFa5ARNWnmwZ0q55QsfQrxZ3a6aB/rb/EFi9dsrKp29HY8f6dxLRczLaHphazzq0s@vger.kernel.org, AJvYcCXjOGNArvaqYLx+we4KxmfJcM2XeuTiVuaeetg7tgtrZrKZFkfaWhOoj4PWb4imfSTkPuhcznc9T+dWK1B9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0jY2gKYKSzi/nFkhN1521Dv3DClRGavMCL9MblY2qDM0Sg3X
	ed7AG/2gOSeorCYQC3q6VH7c2soDDDSP/QbuNsvwv5Sy8wBmjfww6FVJ9K+eIqh82zLssHKICeh
	90PG4IZEmszzaILILoh9adYU8JgGPrpK57S8=
X-Gm-Gg: ASbGnctVt3c7Vqw/66b4e8mcz5XeLJjmjeLobU8IRYFQdPQXAN7dpvz3dF/YimqR7bj
	kc//uptbZzc1Rs24BCalG5t0bPFdiI6fHHB3tx8jBg4qRDB28VGFOpIMT4JZlww==
X-Google-Smtp-Source: AGHT+IE4gRHcNuotkIImYzv2eMssKgR3m5o5L/JPHkYzfUqujxMnuNK/3PQ/osyH+KjlLG3ZviJC10TFRrENyd+TOa0=
X-Received: by 2002:a05:6402:26cb:b0:5d9:6633:8eb1 with SMTP id
 4fb4d7f45d1cf-5dc07e3dda5mr3712548a12.14.1737646181212; Thu, 23 Jan 2025
 07:29:41 -0800 (PST)
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
 <d36de874-7603-478b-a01e-b7d1eb7110d3@oracle.com> <CAOQ4uxgnQ-4azkpsPm+tyd7zgXWUxXq7vWCfksPPF864rpN27Q@mail.gmail.com>
 <6d3bdbf1-fab5-48f6-9664-ef27fb742c55@oracle.com>
In-Reply-To: <6d3bdbf1-fab5-48f6-9664-ef27fb742c55@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Jan 2025 16:29:29 +0100
X-Gm-Features: AWEUYZkjh2bWWLtEkFDpMZ-HT0Yo8D76Y7-EXPLb1I_Phsk6SK_G_nXMK1JHXbM
Message-ID: <CAOQ4uxiXEJzQLaOCiUfee6P5+NUp3yP-KksxaMsZJB2PRLfzUw@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 3:59=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/22/25 3:11 PM, Amir Goldstein wrote:
> > On Wed, Jan 22, 2025 at 8:20=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> On 1/22/25 1:53 PM, Amir Goldstein wrote:
> >>>>> I am fine with handling EBUSY in unlink/rmdir/rename/open
> >>>>> only for now if that is what everyone prefers.
> >>>>
> >>>> As far as I can tell, NFSv2 and NFSv3 REMOVE/RMDIR are working
> >>>> correctly. NFSv4 REMOVE needs to return a status code that depends
> >>>> on whether the target object is a file or not. Probably not much mor=
e
> >>>> than something like this:
> >>>>
> >>>>           status =3D vfs_unlink( ... );
> >>>> +       /* RFC 8881 Section 18.25.4 paragraph 5 */
> >>>> +       if (status =3D=3D nfserr_file_open && !S_ISREG(...))
> >>>> +               status =3D nfserr_access;
> >>>>
> >>>> added to nfsd4_remove().
> >>>
> >>> Don't you think it's a bit awkward mapping back and forth like this?
> >>
> >> Yes, it's awkward. It's an artifact of the way NFSD's VFS helpers have
> >> been co-opted for new versions of the NFS protocol over the years.
> >>
> >> With NFSv2 and NFSv3, the operations and their permitted status codes
> >> are roughly similar so that these VFS helpers can be re-used without
> >> a lot of fuss. This is also why, internally, the symbolic status codes
> >> are named without the version number in them (ie, nfserr_inval).
> >>
> >> With NFSv4, the world is more complicated.
> >>
> >> The NFSv4 code was prototyped 20 years ago using these NFSv2/3 helpers=
,
> >> and is never revisited until there's a bug. Thus there is quite a bit =
of
> >> technical debt in fs/nfsd/vfs.c that we're replacing over time.
> >>
> >> IMO it would be better if these VFS helpers returned errno values and
> >> then the callers should figure out the conversion to an NFS status cod=
e.
> >> I suspect that's difficult because some of the functions invoked by th=
e
> >> VFS helpers (like fh_verify() ) also return NFS status codes. We just
> >> spent some time extracting NFS version-specific code from fh_verify().
> >>
> >>
> >>> Don't you think something like this is a more sane way to keep the
> >>> mapping rules in one place:
> >>>
> >>> @@ -111,6 +111,26 @@ nfserrno (int errno)
> >>>           return nfserr_io;
> >>>    }
> >>>
> >>> +static __be32
> >>> +nfsd_map_errno(int host_err, int may_flags, int type)
> >>> +{
> >>> +       switch (host_err) {
> >>> +       case -EBUSY:
> >>> +               /*
> >>> +                * According to RFC 8881 Section 18.25.4 paragraph 5,
> >>> +                * removal of regular file can fail with NFS4ERR_FILE=
_OPEN.
> >>> +                * For failure to remove directory we return NFS4ERR_=
ACCESS,
> >>> +                * same as NFS4ERR_FILE_OPEN is mapped in v3 and v2.
> >>> +                */
> >>> +               if (may_flags =3D=3D NFSD_MAY_REMOVE && type =3D=3D S=
_IFREG)
> >>> +                       return nfserr_file_open;
> >>> +               else
> >>> +                       return nfserr_acces;
> >>> +       }
> >>> +
> >>> +       return nfserrno(host_err);
> >>> +}
> >>> +
> >>>    /*
> >>>     * Called from nfsd_lookup and encode_dirent. Check if we have cro=
ssed
> >>>     * a mount point.
> >>> @@ -2006,14 +2026,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
> >>> svc_fh *fhp, int type,
> >>>    out_drop_write:
> >>>           fh_drop_write(fhp);
> >>>    out_nfserr:
> >>> -       if (host_err =3D=3D -EBUSY) {
> >>> -               /* name is mounted-on. There is no perfect
> >>> -                * error status.
> >>> -                */
> >>> -               err =3D nfserr_file_open;
> >>> -       } else {
> >>> -               err =3D nfserrno(host_err);
> >>> -       }
> >>> +       err =3D nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
> >>>    out:
> >>>           return err;
> >>
> >> No, I don't.
> >>
> >> NFSD has Kconfig options that disable support for some versions of NFS=
.
> >> The code that manages which status code to return really needs to be
> >> inside the functions that are enabled or disabled by Kconfig.
> >>
> >> As I keep repeating: there is no good way to handle the NFS status cod=
es
> >> in one set of functions. Each NFS version has its variations that
> >> require special handling.
> >>
> >>
> >
> > ok.
> >
> >>>> Let's visit RENAME once that is addressed.
> >>>
> >>> And then next patch would be:
> >>>
> >>> @@ -1828,6 +1828,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct
> >>> svc_fh *ffhp, char *fname, int flen,
> >>>           __be32          err;
> >>>           int             host_err;
> >>>           bool            close_cached =3D false;
> >>> +       int             type;
> >>>
> >>>           err =3D fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
> >>>           if (err)
> >>> @@ -1922,8 +1923,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct
> >>> svc_fh *ffhp, char *fname, int flen,
> >>>     out_dput_new:
> >>>           dput(ndentry);
> >>>     out_dput_old:
> >>> +       type =3D d_inode(odentry)->i_mode & S_IFMT;
> >>>           dput(odentry);
> >>>     out_nfserr:
> >>> -        err =3D nfserrno(host_err);
> >>> +       err =3D nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
> >>
> >> Same problem here: the NFS version-specific status codes have to be
> >> figured out in the callers, not in nfsd_rename(). The status codes
> >> are not common to all NFS versions.
> >>
> >>
> >
> > ok.
> >
> >>>> Then handle OPEN as a third patch, because I bet we are going to mee=
t
> >>>> some complications there.
> >>>
> >>> Did you think of anything better to do for OPEN other than NFS4ERR_AC=
CESS?
> >>
> >> I haven't even started to think about that yet.
> >>
> >
> > ok. Let me know when you have any ideas about that.
> >
> > My goal is to fix EBUSY WARN for open from FUSE.
> > The rest is cleanup that I don't mind doing on the way.
>
> I've poked at nfsd4_remove(). It's not going to work the way I prefer.

Do you mean because the file type is not available there?

> But I'll take care of the clean up for remove, rename, and link.
>

FWIW, this is how I was going to solve this,
but I admit it is quite awkward:

https://github.com/amir73il/linux/commits/nfsd-fixes/

> Understood that fixing OPEN is your main priority.
>

I now realized that truncate can also return EBUSY in my FUSE fs :/
That's why I am disappointed that there is no "fall back"
mapping for EBUSY that fits all without a warning, but I will
wait to see how the cleanup goes and we will take it from there.

Thanks,
Amir.

