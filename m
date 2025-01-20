Return-Path: <linux-fsdevel+bounces-39729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5AA17310
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5596E1887F1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91071EE7BB;
	Mon, 20 Jan 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGRoJos4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDE8479;
	Mon, 20 Jan 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737400475; cv=none; b=fmin2I7GxrvuSVteqo9xS73knKipEbsqtHZeWU9irXmwa5qi2PLcU5Z4FQElaXKzO19fFUXLr3GvyugsbW4gKzCUqnag0DqfcTy7cEFl6muhqDV+Mi1im88kcHe8Opn+WfG3yO/Vi1E9HMaAaWrqfi56XcEUlvwWh7tN3yKigew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737400475; c=relaxed/simple;
	bh=m4Ir0aFuuHTuv48o3tLcKCv7Hgu6l0NGVoMxf6fCNuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5VT++7yq109bYS6A2v+9stIqdRlSbbIw5DfE7QxLwNaXMAMj6okccFVbMVvFfHMC3NSbK6ZAuREkoK+6es0KXsoRTJppPImhIAzwNM0cTYgn2SxvAVqLQj89K+i1pYwXqerDXUm2+x0B/dD7Sb1SXQ/R5fQaOogPFf4GaaB99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGRoJos4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso8531318a12.1;
        Mon, 20 Jan 2025 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737400472; x=1738005272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRSs8e+6gxe23W24Ufx+7uDk4bOUzTVeUlOPZuxDCk=;
        b=NGRoJos4LZnCbJd/zRZZHj1q+2IH9KU4hD1z5HZK4vqdiJ6tAP4ap7B8FxZyXaQ5Mx
         HIh9jZJNvXFRNbnoz9GCfuTyK+F94jXLzfl+PXF5MZta7OgqhN6myzC+BKGOC/iBq5zw
         +JadFQhRUwnWf2YUC97/FGlwQqTcs+BTIcoUfz8UA8USr6754yTU8zjOEzXxXiZLERO4
         kQJzTI4Y7BgdZwIlsHdPEoNyIESZLB3Rfq7GXnFtlyhs/lIIcpNDqpTLmT7ocFEDcl23
         8RBcKlqXufqSJsYmhOI+LU4vGtuL59FT/vIVwL12RnfOf60kvkZ7s+6qcdkxG53AGU8r
         DQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737400472; x=1738005272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yRSs8e+6gxe23W24Ufx+7uDk4bOUzTVeUlOPZuxDCk=;
        b=R8dBaMYCIiILWzUPgnDZEMYjpWfQm9Gs93MvVsuc65nKY9Rdv0tbv+nQXbmSYA9mik
         dnMo4VTEk1vRrdng5CbksPSNuy+7J+bp8t7OHvCWh040IpHFyX5sMREWM+3O/cEQFxnO
         flUQhN/RaWLpfedhxsR4L/yGWOkF1wStobN33BdDTInCzPJjSPOI0eflH9DMXJnlnS7f
         AmMZIiNrgKI5V7RU4VVKH3+qAIsWOAbJB0LKaNTAJafZ6cRqGYXBtIsAx6nLLG4p0Ks0
         DC1Vb+NA0qpnRbGSFhxt8yY4XY/3HH5BUzA+XBCb/Yv4ovq1qNivsPmMeO/GGjLPopqB
         oeJg==
X-Forwarded-Encrypted: i=1; AJvYcCW8ckqcF+s6AtGJYE4eSqtLxGQonOtjtqlTkw9KfgBEtYzYyGnw1DhBv6F0WFmM5klYO+G9B8hvpd574Vk2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NTmzqr91PyCrHX37n/6h3ycnDt51DixJJg3oMrAP9d743S5M
	2sMiZMLIqvxMHJ2HSNozEVql4GeQhDYdg/52Kmt5gmGm12YY0h0YD3z7FyMBfDv+2tWkwozlu+u
	yfo2Ry9ff1fNWxgZ5fT0teSTHlZqLCSar9/Y=
X-Gm-Gg: ASbGncv78atxxID2B7FLyCsYEFRyccIrrTIzdS8yoGzluGQ6ZWnbEkISmbPbLTHLuA0
	OXCemxanzY0BlALUQAws8ZSW9+9+4k519QMuueLZGF8wp4TlUhkc=
X-Google-Smtp-Source: AGHT+IFcUzPOoAUHgCBUbVYheLbbWbOEHUhSlHXtiLzahtxHeZ+6H69RA3C/pYKtmiooSqNWjVKNRIDCHvPl+6+/A4c=
X-Received: by 2002:a17:906:478d:b0:aa6:8781:9909 with SMTP id
 a640c23a62f3a-ab38b17b91cmr1529469066b.29.1737400471211; Mon, 20 Jan 2025
 11:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120172016.397916-1-amir73il@gmail.com> <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
 <CAOQ4uxgQbEwww8QFHo2wHMm2K2XR+UmOL3qTbr-gJuxqZxqnsQ@mail.gmail.com> <9fc1d00dc27daad851f8152572764ae6fe604374.camel@hammerspace.com>
In-Reply-To: <9fc1d00dc27daad851f8152572764ae6fe604374.camel@hammerspace.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Jan 2025 20:14:20 +0100
X-Gm-Features: AbW1kvYewwcZsXhqWHHda1Y2pzgvs4z5Bj6UV6fmgaZSU4g8VGXppi9q3wbnYR0
Message-ID: <CAOQ4uxiLsfK0zRGdMCqsvUzsQ05gkvQCJbsUiRcrS3o-sCPf1A@mail.gmail.com>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 7:45=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Mon, 2025-01-20 at 19:21 +0100, Amir Goldstein wrote:
> > On Mon, Jan 20, 2025 at 6:28=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2025-01-20 at 18:20 +0100, Amir Goldstein wrote:
> > > > v4 client maps NFS4ERR_FILE_OPEN =3D> EBUSY for all operations.
> > > >
> > > > v4 server only maps EBUSY =3D> NFS4ERR_FILE_OPEN for
> > > > rmdir()/unlink()
> > > > although it is also possible to get EBUSY from rename() for the
> > > > same
> > > > reason (victim is a local mount point).
> > > >
> > > > Filesystems could return EBUSY for other operations, so just map
> > > > it
> > > > in server for all operations.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Chuck,
> > > >
> > > > I ran into this error with a FUSE filesystem and returns -EBUSY
> > > > on
> > > > open,
> > > > but I noticed that vfs can also return EBUSY at least for
> > > > rename().
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > >  fs/nfsd/vfs.c | 10 ++--------
> > > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > index 29cb7b812d713..a61f99c081894 100644
> > > > --- a/fs/nfsd/vfs.c
> > > > +++ b/fs/nfsd/vfs.c
> > > > @@ -100,6 +100,7 @@ nfserrno (int errno)
> > > >               { nfserr_perm, -ENOKEY },
> > > >               { nfserr_no_grace, -ENOGRACE},
> > > >               { nfserr_io, -EBADMSG },
> > > > +             { nfserr_file_open, -EBUSY},
> > > >       };
> > > >       int     i;
> > > >
> > > > @@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
> > > > svc_fh *fhp, int type,
> > > >  out_drop_write:
> > > >       fh_drop_write(fhp);
> > > >  out_nfserr:
> > > > -     if (host_err =3D=3D -EBUSY) {
> > > > -             /* name is mounted-on. There is no perfect
> > > > -              * error status.
> > > > -              */
> > > > -             err =3D nfserr_file_open;
> > > > -     } else {
> > > > -             err =3D nfserrno(host_err);
> > > > -     }
> > > > +     err =3D nfserrno(host_err);
> > > >  out:
> > > >       return err;
> > > >  out_unlock:
> > >
> > > If this is a transient error, then it would seem that NFS4ERR_DELAY
> > > would be more appropriate.
> >
> > It is not a transient error, not in the case of a fuse file open
> > (it is busy as in locked for as long as it is going to be locked)
> > and not in the case of failure to unlink/rename a local mountpoint.
> > NFS4ERR_DELAY will cause the client to retry for a long time?
> >
> > > NFS4ERR_FILE_OPEN is not supposed to apply
> > > to directories, and so clients would be very confused about how to
> > > recover if you were to return it in this situation.
> >
> > Do you mean specifically for OPEN command, because commit
> > 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
> > added the NFS4ERR_FILE_OPEN response for directories five years
> > ago and vfs_rmdir can certainly return a non-transient EBUSY.
> >
>
> I'm saying that clients expect NFS4ERR_FILE_OPEN to be returned in
> response to LINK, REMOVE or RENAME only in situations where the error
> itself applies to a regular file.

This is very far from what upstream nfsd code implements (since 2019)
1. out of the above, only REMOVE returns NFS4ERR_FILE_OPEN
2. NFS4ERR_FILE_OPEN is not limited to non-dir
3. NFS4ERR_FILE_OPEN is not limited to silly renamed file -
    it will also be the response for trying to rmdir a mount point
    or trying to unlink a file which is a bind mount point

> The protocol says that the client can expect this return value to mean
> it is dealing with a server with Windows-like semantics that doesn't
> allow these particular operations while the file is being held open. It
> says nothing about expecting the same behaviour for mountpoints, and
> since the latter have a very different life cycle than file open state
> does, you should not treat those cases as being the same.

The two cases are currently indistinguishable in nfsd_unlink(), but
it could check DCACHE_NFSFS_RENAMED flag if we want to
limit NFS4ERR_FILE_OPEN to this specific case - again, this is
upstream code - nothing to do with my patch.

FWIW, my observed behavior of Linux nfs client for this error
is about 1 second retries and failure with -EBUSY, which is fine
for my use case, but if you think there is a better error to map
EBUSY it's fine with me. nfsv3 maps it to EACCES anyway.

Thanks,
Amir.

