Return-Path: <linux-fsdevel+bounces-39760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD56A17B27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC723A20E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76961F03CE;
	Tue, 21 Jan 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+03zYpp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD311EF08A;
	Tue, 21 Jan 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454493; cv=none; b=C2p22iHMm1akiTrBfat1BoSZVt8FbZYwz1z+g02BLcy+BYKKXH6wsgiTSXDKYRSWIKj34hXVlQHsajEJlFiBLs+KqwcwuI+ykLhz+0yDjWltLI09AZzmbtNq4m6rcYBOxuVC3HLi76CvkHyaTvL3Qr12cBDJh+om/gfHh2Yxg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454493; c=relaxed/simple;
	bh=cV4bLORwr4F4du8QcuRycftA1pl8gNFVZJzX7hzMyfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oza1V/Jor7M7Xg7cv9Iby7NxvxF0eH9rvTufhPdvUOgqpoIfe2BNxq4klAmIJxGDVqFNZzNCUzvNFPjjZTZWy764vFGKIVB+j4s1hYBVrM1+vd9C6OUGGGqGeQ2hgFQV5yWcnfg4W6FUYCVz7TyLPg+ySSBQ0ho530HZ9i6zH1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+03zYpp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab322ecd75dso954823466b.0;
        Tue, 21 Jan 2025 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737454489; x=1738059289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuEtKeQpgLFLLMDeF63QGCMsK3CX26cpME0Sh3NqfxI=;
        b=H+03zYpptTEooIz78C0OKIi4xc/hUClWX2sz9FuN8A7NHsulJBE3JsTh7lprl3q04O
         7cE2VbnJh5tPzvZDSf8sXykuQBE4g7xpgcVZv3baawyIGE3RDE58HLVsA75IDIOaJD3s
         Y7joZWIddZLuSS4O+fizHawWIekDhLWwSQup3arCnSzW/uEYu81FP1nJvBzvww1hz828
         XT7O046Ywa+w9DlJ8LvFSNGpro/vynGvH2tn+zAeAv/TRInd2xh5mSVtr7HaSeljJurX
         ibHk0/Tv5FTxo28i1AaON0o+F5rjrGIEAKLgBh2zjsgFh59tnuOfNVO7SOGtcxrePI9Y
         n6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737454489; x=1738059289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuEtKeQpgLFLLMDeF63QGCMsK3CX26cpME0Sh3NqfxI=;
        b=xU7tAK3ARgNvLvpzvxeVJn5V0yPZ0ARdPrRMEAyDB20AW1oRzqekZOeVAuZX7qSlD6
         2PXFy8UUtu3YihEUSBgb7I1NCXNF7jI2qrhXyFNHuG/mwz6iWCkSq3a2ZfvqlOYHnr3i
         mYGWrPVXY9LbQc0yazzaCtqLninHWgr4thzX/nLY6cAvhdAzlxrUB6h/XARVR/16AXLE
         O7fbnola7byufu9Sfg7wdZjcfK3+czUmrjGMwP63rREP22aaY8S2Rw/MSs1Hf0Rb5TvG
         J77Nc6bdtL019EyoI6o61mLXurdMZP2frYV0K8uWiRH314Ygdxoq4GpD3mP81SuXBAk5
         ejyg==
X-Forwarded-Encrypted: i=1; AJvYcCUiPQaUZ+LpkPNtIWPZb3uj0eaYyfMZAHHxXOcnj0za708fy932BH/B3YrYQVivYs6TmcDnafxsqyOa3Din@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQ/8upnD4DUsESMKN5is0A7DBoVt6rlQzC4sIbUphIO3xqith
	2x/OoHYhHxYWKT5fPfaUsLjTESGc6xEkC6z831fXz9i2d/67yGAFjHywe2aTaXHVVtHkJsI52vG
	1EHOYoXEPQRE2YEwVDa1UBo142gk=
X-Gm-Gg: ASbGncvkdlzSWiheOWMD8koIObo4KTjHb6ek9d0kSRpDnKTjDlq5a2m1F8R1/pL7r/F
	gmyPQKO5jD+lvylzfr3dMo0UUyV0f0ydkmJd1y7isoITX1CeOJHI=
X-Google-Smtp-Source: AGHT+IHSQn/YsyC7DxRyHJeMq0bBsg/h8l78N8u/8N2eSpqxA35IlgBci4WecJ3vSWVgKXaKu9AGuQkuF9B6CFVYWfU=
X-Received: by 2002:a17:907:72c3:b0:aab:882e:921e with SMTP id
 a640c23a62f3a-ab38cbabdd0mr1565273066b.2.1737454488868; Tue, 21 Jan 2025
 02:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120172016.397916-1-amir73il@gmail.com> <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
 <CAOQ4uxgQbEwww8QFHo2wHMm2K2XR+UmOL3qTbr-gJuxqZxqnsQ@mail.gmail.com>
 <9fc1d00dc27daad851f8152572764ae6fe604374.camel@hammerspace.com>
 <CAOQ4uxiLsfK0zRGdMCqsvUzsQ05gkvQCJbsUiRcrS3o-sCPf1A@mail.gmail.com>
 <f7c76f0e70762a731de62f2db67cddba79ad03d0.camel@hammerspace.com>
 <CAOQ4uxhXuHPsaqzH7SJ-W93dX4ZCJip3CN_P9ZY5f5eb95k6Qg@mail.gmail.com> <c439ea3a925b237c9b2fb127a17819ccef898a58.camel@hammerspace.com>
In-Reply-To: <c439ea3a925b237c9b2fb127a17819ccef898a58.camel@hammerspace.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Jan 2025 11:14:36 +0100
X-Gm-Features: AbW1kvbk9HN6gScXsJH_mjra6RY_GfR0Q0YZOlmVnsPBPygSRe78PJVpyLeLhwM
Message-ID: <CAOQ4uxgheec3hw3GOVSx41A1c8hOrjN08_=DrzpwWob7VFSHxA@mail.gmail.com>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "neilb@suse.de" <neilb@suse.de>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 11:15=E2=80=AFPM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Mon, 2025-01-20 at 22:11 +0100, Amir Goldstein wrote:
> > On Mon, Jan 20, 2025 at 8:29=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2025-01-20 at 20:14 +0100, Amir Goldstein wrote:
> > > > On Mon, Jan 20, 2025 at 7:45=E2=80=AFPM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Mon, 2025-01-20 at 19:21 +0100, Amir Goldstein wrote:
> > > > > > On Mon, Jan 20, 2025 at 6:28=E2=80=AFPM Trond Myklebust
> > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > >
> > > > > > > On Mon, 2025-01-20 at 18:20 +0100, Amir Goldstein wrote:
> > > > > > > > v4 client maps NFS4ERR_FILE_OPEN =3D> EBUSY for all
> > > > > > > > operations.
> > > > > > > >
> > > > > > > > v4 server only maps EBUSY =3D> NFS4ERR_FILE_OPEN for
> > > > > > > > rmdir()/unlink()
> > > > > > > > although it is also possible to get EBUSY from rename()
> > > > > > > > for
> > > > > > > > the
> > > > > > > > same
> > > > > > > > reason (victim is a local mount point).
> > > > > > > >
> > > > > > > > Filesystems could return EBUSY for other operations, so
> > > > > > > > just
> > > > > > > > map
> > > > > > > > it
> > > > > > > > in server for all operations.
> > > > > > > >
> > > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Chuck,
> > > > > > > >
> > > > > > > > I ran into this error with a FUSE filesystem and returns
> > > > > > > > -
> > > > > > > > EBUSY
> > > > > > > > on
> > > > > > > > open,
> > > > > > > > but I noticed that vfs can also return EBUSY at least for
> > > > > > > > rename().
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Amir.
> > > > > > > >
> > > > > > > >  fs/nfsd/vfs.c | 10 ++--------
> > > > > > > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > > > index 29cb7b812d713..a61f99c081894 100644
> > > > > > > > --- a/fs/nfsd/vfs.c
> > > > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > > > @@ -100,6 +100,7 @@ nfserrno (int errno)
> > > > > > > >               { nfserr_perm, -ENOKEY },
> > > > > > > >               { nfserr_no_grace, -ENOGRACE},
> > > > > > > >               { nfserr_io, -EBADMSG },
> > > > > > > > +             { nfserr_file_open, -EBUSY},
> > > > > > > >       };
> > > > > > > >       int     i;
> > > > > > > >
> > > > > > > > @@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst
> > > > > > > > *rqstp,
> > > > > > > > struct
> > > > > > > > svc_fh *fhp, int type,
> > > > > > > >  out_drop_write:
> > > > > > > >       fh_drop_write(fhp);
> > > > > > > >  out_nfserr:
> > > > > > > > -     if (host_err =3D=3D -EBUSY) {
> > > > > > > > -             /* name is mounted-on. There is no perfect
> > > > > > > > -              * error status.
> > > > > > > > -              */
> > > > > > > > -             err =3D nfserr_file_open;
> > > > > > > > -     } else {
> > > > > > > > -             err =3D nfserrno(host_err);
> > > > > > > > -     }
> > > > > > > > +     err =3D nfserrno(host_err);
> > > > > > > >  out:
> > > > > > > >       return err;
> > > > > > > >  out_unlock:
> > > > > > >
> > > > > > > If this is a transient error, then it would seem that
> > > > > > > NFS4ERR_DELAY
> > > > > > > would be more appropriate.
> > > > > >
> > > > > > It is not a transient error, not in the case of a fuse file
> > > > > > open
> > > > > > (it is busy as in locked for as long as it is going to be
> > > > > > locked)
> > > > > > and not in the case of failure to unlink/rename a local
> > > > > > mountpoint.
> > > > > > NFS4ERR_DELAY will cause the client to retry for a long time?
> > > > > >
> > > > > > > NFS4ERR_FILE_OPEN is not supposed to apply
> > > > > > > to directories, and so clients would be very confused about
> > > > > > > how
> > > > > > > to
> > > > > > > recover if you were to return it in this situation.
> > > > > >
> > > > > > Do you mean specifically for OPEN command, because commit
> > > > > > 466e16f0920f3 ("nfsd: check for EBUSY from
> > > > > > vfs_rmdir/vfs_unink.")
> > > > > > added the NFS4ERR_FILE_OPEN response for directories five
> > > > > > years
> > > > > > ago and vfs_rmdir can certainly return a non-transient EBUSY.
> > > > > >
> > > > >
> > > > > I'm saying that clients expect NFS4ERR_FILE_OPEN to be returned
> > > > > in
> > > > > response to LINK, REMOVE or RENAME only in situations where the
> > > > > error
> > > > > itself applies to a regular file.
> > > >
> > > > This is very far from what upstream nfsd code implements (since
> > > > 2019)
> > > > 1. out of the above, only REMOVE returns NFS4ERR_FILE_OPEN
> > > > 2. NFS4ERR_FILE_OPEN is not limited to non-dir
> > > > 3. NFS4ERR_FILE_OPEN is not limited to silly renamed file -
> > > >     it will also be the response for trying to rmdir a mount
> > > > point
> > > >     or trying to unlink a file which is a bind mount point
> > >
> > > Fair enough. I believe the name given to this kind of server
> > > behaviour
> > > is "bug".
> > >
> > > >
> > > > > The protocol says that the client can expect this return value
> > > > > to
> > > > > mean
> > > > > it is dealing with a server with Windows-like semantics that
> > > > > doesn't
> > > > > allow these particular operations while the file is being held
> > > > > open. It
> > > > > says nothing about expecting the same behaviour for
> > > > > mountpoints,
> > > > > and
> > > > > since the latter have a very different life cycle than file
> > > > > open
> > > > > state
> > > > > does, you should not treat those cases as being the same.
> > > >
> > > > The two cases are currently indistinguishable in nfsd_unlink(),
> > > > but
> > > > it could check DCACHE_NFSFS_RENAMED flag if we want to
> > > > limit NFS4ERR_FILE_OPEN to this specific case - again, this is
> > > > upstream code - nothing to do with my patch.
> > > >
> > > > FWIW, my observed behavior of Linux nfs client for this error
> > > > is about 1 second retries and failure with -EBUSY, which is fine
> > > > for my use case, but if you think there is a better error to map
> > > > EBUSY it's fine with me. nfsv3 maps it to EACCES anyway.
> > > >
> > > >
> > >
> > > When doing LINK, RENAME, REMOVE on a mount point, I'd suggest
> > > returning
> > > NFS4ERR_XDEV, since that is literally a case of trying to perform
> > > the
> > > operation across a filesystem boundary.
> >
> > I would not recommend doing that. vfs hides those tests in
> > vfs_rename(), etc
> > I don't think that nfsd should repeat them for this specialize
> > interpretation,
> > because to be clear, this is specially not an EXDEV situation as far
> > as vfs
> > is concerned.
>
> That's not how protocols work.
>
> The server is required to use the appropriate error as determined by
> the protocol spec. It is then up to the client to interpret that error
> according to its context.
>
> IOW: It doesn't matter what POSIX may say here, or what errors the VFS
> may want to see on the client. The server should be using NFS4ERR_XDEV
> because the spec says it should use that error to signal this
> condition.
>

Which condition exactly?
I really doubt that the spec know and refers to bind mounts
wrt NFS4ERR_XDEV

~# mount /dev/vdf /vdf
~# mount --bind /vdf /mnt/
~# mount --make-private /mnt/
~# mkdir /mnt/emptydir
~# mount -t tmpfs none /mnt/emptydir
~# rmdir /vdf/emptydir/
rmdir: failed to remove '/vdf/emptydir/': Device or resource busy
~# touch /vdf/a
~# strace -e renameat2 mv /vdf/a /vdf/emptydir/a
renameat2(AT_FDCWD, "/vdf/a", AT_FDCWD, "/vdf/emptydir/a", RENAME_NOREPLACE=
) =3D 0

The definition of this condition is outside the scope of the NFS protocol,
so I'd rather not special case it for nfsd.

Thanks,
Amir.

