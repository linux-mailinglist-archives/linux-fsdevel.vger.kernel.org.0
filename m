Return-Path: <linux-fsdevel+bounces-39743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD200A173FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 22:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0663A2772
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 21:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F191EF082;
	Mon, 20 Jan 2025 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzZvWUwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107119882F;
	Mon, 20 Jan 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407490; cv=none; b=gWMVWL/Ezz5sL8WqZjEXSubp7gPhVyI96g84+oRHjAD9cUQXddZlcCUiwGTPMFzZUQRMX1MIwqVAqY2wwpPYHOV4oMxFahK2/Q4NLC+gLjaur/KiNKdtlD46u3eF5OTJ7r/BxEAXjz+bnzQIl0dlsgJLpeobmncx2Eqcfr/eXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407490; c=relaxed/simple;
	bh=DP6DXfSaM1NHPMMhphmfsVCE38cEYjD3lDNcFBPU7Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BToHnBV16rGDSOkp32mWUXhgPWEfqHMpIrJ8Ufjl7H1am60OPcHIt+M11FzuSkM/aN+aN2M2761uGZYwrDY2ynqGgKrTy6TMMJZ70jmCXZjbJ3r0hAWUbt9JBDnOhoLrMGDChJ1EcoTh+o4QTI9EVa1/Wqgpht1Q4vUt7TsY62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzZvWUwa; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso7597619a12.2;
        Mon, 20 Jan 2025 13:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737407487; x=1738012287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kODO8nlk2zQZ2Nyd+pzWj/60aCkRp6Qygs7biagrV2Y=;
        b=gzZvWUwa+p/htTPP19iezFYHUUL2Ywa2XHy0O3WxExjIWJ0A5BOswwDnsfpx8u1Kn/
         yVELDeDC8kODOZ2eLJLwtEqto79bUp3ZeNuhFWnY576Z1oAEHk5hcUxH/lIf6t4TVCR9
         oeZJ5PiM7vjhkkHHQ8XO1GHQValVMWpfRnp2Mi6eZSE9GEJ4qt16XDuqCo5sBF7B8z2s
         pRKDouddOvxLES4eCkPpFAhSrzlRMaul4HPE04YU7a1z1laaCV2GyZ8LVvKbFL/8JjMI
         54AWlz/MZcGIVn9AKnxkP3+zv4hoH8wNuGSgKJmGD9eXwe5M8QY3Zi+Pi0F/GEvxbEji
         zPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737407487; x=1738012287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kODO8nlk2zQZ2Nyd+pzWj/60aCkRp6Qygs7biagrV2Y=;
        b=l8bAu6yl/ANYX1trc7cYW/x66crYuWxgNSTUKOv14GRcbkRVxU/RAVp5WHAlfXRpid
         4t7MlSGW1m7pZrwLkXaTlCYlkbAwrek9k3izk2XEv/jzg27aTkDn76lM8ArCWNOLRRhY
         2m8mZHnrjLbeww+NIWrbd5cnRYFrxBUB0JQLN4Emgf9Sreo/xT1VLLwR0FxjAQtlyI+d
         jt3VQIbzii4To3++0oPhSpmnGyPEK6HzJz9Zs5dVC6iOF0VqMMNRpdE8sVd8Wjp8RKYO
         6w3ynwu9U6jKl73rXzqZAoMgJXw+i09V/N78sN+lQGFOOfwrCdhGjw1Tamsj2M/5I6Pq
         Japw==
X-Forwarded-Encrypted: i=1; AJvYcCVCFdOZu/oNAmVFUfzx2SufCvm1KfGUEVwdXQwgdCwQ1UciA2t6E8ZV4MTmTdTz57yw5LOULJVU4UQ3lllT@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcpMBWq4eGJ2iWLzW8LqNU0Dp0Hv+7jDfPFTUndsHWVSlfp/P
	AWVpCWVCvFC4/HcCOnArEKYYMlIO+S8THRLRomaSQtFbl334qcUkdOhqognWyygKoOd1saoABql
	NXSPnjrIPteL4MfePVA2pz6ZTssd+1jiTwR8=
X-Gm-Gg: ASbGncvm0D1lJ1BsEIP4DBmzXHyTacN7NivRlBJB2TWDtXJ7FPNQSQUwttnHDbh1LzG
	syVDcx5CeKlKfBkdh6llyHU8wsDBMc2kaXD2iBqVmhDEX4T5mgVk=
X-Google-Smtp-Source: AGHT+IF0AVIFVOdolN77/iW34jeBXSu6bqkwAJ0F6w1zW4sA7j5Oyk7GTHhNxY2B8fpdhKFfDehtgboCfFqsb6GkyW4=
X-Received: by 2002:a17:907:72c6:b0:ab3:3eea:1ccc with SMTP id
 a640c23a62f3a-ab38b165f9cmr1641037166b.27.1737407486298; Mon, 20 Jan 2025
 13:11:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120172016.397916-1-amir73il@gmail.com> <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
 <CAOQ4uxgQbEwww8QFHo2wHMm2K2XR+UmOL3qTbr-gJuxqZxqnsQ@mail.gmail.com>
 <9fc1d00dc27daad851f8152572764ae6fe604374.camel@hammerspace.com>
 <CAOQ4uxiLsfK0zRGdMCqsvUzsQ05gkvQCJbsUiRcrS3o-sCPf1A@mail.gmail.com> <f7c76f0e70762a731de62f2db67cddba79ad03d0.camel@hammerspace.com>
In-Reply-To: <f7c76f0e70762a731de62f2db67cddba79ad03d0.camel@hammerspace.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Jan 2025 22:11:15 +0100
X-Gm-Features: AbW1kvZuJsmfJTMRONhLa151WG7uZ-IdrMrryKiRPHOys8uNOXJ2vMwO2BjUCTc
Message-ID: <CAOQ4uxhXuHPsaqzH7SJ-W93dX4ZCJip3CN_P9ZY5f5eb95k6Qg@mail.gmail.com>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:29=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Mon, 2025-01-20 at 20:14 +0100, Amir Goldstein wrote:
> > On Mon, Jan 20, 2025 at 7:45=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2025-01-20 at 19:21 +0100, Amir Goldstein wrote:
> > > > On Mon, Jan 20, 2025 at 6:28=E2=80=AFPM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Mon, 2025-01-20 at 18:20 +0100, Amir Goldstein wrote:
> > > > > > v4 client maps NFS4ERR_FILE_OPEN =3D> EBUSY for all operations.
> > > > > >
> > > > > > v4 server only maps EBUSY =3D> NFS4ERR_FILE_OPEN for
> > > > > > rmdir()/unlink()
> > > > > > although it is also possible to get EBUSY from rename() for
> > > > > > the
> > > > > > same
> > > > > > reason (victim is a local mount point).
> > > > > >
> > > > > > Filesystems could return EBUSY for other operations, so just
> > > > > > map
> > > > > > it
> > > > > > in server for all operations.
> > > > > >
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > ---
> > > > > >
> > > > > > Chuck,
> > > > > >
> > > > > > I ran into this error with a FUSE filesystem and returns -
> > > > > > EBUSY
> > > > > > on
> > > > > > open,
> > > > > > but I noticed that vfs can also return EBUSY at least for
> > > > > > rename().
> > > > > >
> > > > > > Thanks,
> > > > > > Amir.
> > > > > >
> > > > > >  fs/nfsd/vfs.c | 10 ++--------
> > > > > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > index 29cb7b812d713..a61f99c081894 100644
> > > > > > --- a/fs/nfsd/vfs.c
> > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > @@ -100,6 +100,7 @@ nfserrno (int errno)
> > > > > >               { nfserr_perm, -ENOKEY },
> > > > > >               { nfserr_no_grace, -ENOGRACE},
> > > > > >               { nfserr_io, -EBADMSG },
> > > > > > +             { nfserr_file_open, -EBUSY},
> > > > > >       };
> > > > > >       int     i;
> > > > > >
> > > > > > @@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp,
> > > > > > struct
> > > > > > svc_fh *fhp, int type,
> > > > > >  out_drop_write:
> > > > > >       fh_drop_write(fhp);
> > > > > >  out_nfserr:
> > > > > > -     if (host_err =3D=3D -EBUSY) {
> > > > > > -             /* name is mounted-on. There is no perfect
> > > > > > -              * error status.
> > > > > > -              */
> > > > > > -             err =3D nfserr_file_open;
> > > > > > -     } else {
> > > > > > -             err =3D nfserrno(host_err);
> > > > > > -     }
> > > > > > +     err =3D nfserrno(host_err);
> > > > > >  out:
> > > > > >       return err;
> > > > > >  out_unlock:
> > > > >
> > > > > If this is a transient error, then it would seem that
> > > > > NFS4ERR_DELAY
> > > > > would be more appropriate.
> > > >
> > > > It is not a transient error, not in the case of a fuse file open
> > > > (it is busy as in locked for as long as it is going to be locked)
> > > > and not in the case of failure to unlink/rename a local
> > > > mountpoint.
> > > > NFS4ERR_DELAY will cause the client to retry for a long time?
> > > >
> > > > > NFS4ERR_FILE_OPEN is not supposed to apply
> > > > > to directories, and so clients would be very confused about how
> > > > > to
> > > > > recover if you were to return it in this situation.
> > > >
> > > > Do you mean specifically for OPEN command, because commit
> > > > 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
> > > > added the NFS4ERR_FILE_OPEN response for directories five years
> > > > ago and vfs_rmdir can certainly return a non-transient EBUSY.
> > > >
> > >
> > > I'm saying that clients expect NFS4ERR_FILE_OPEN to be returned in
> > > response to LINK, REMOVE or RENAME only in situations where the
> > > error
> > > itself applies to a regular file.
> >
> > This is very far from what upstream nfsd code implements (since 2019)
> > 1. out of the above, only REMOVE returns NFS4ERR_FILE_OPEN
> > 2. NFS4ERR_FILE_OPEN is not limited to non-dir
> > 3. NFS4ERR_FILE_OPEN is not limited to silly renamed file -
> >     it will also be the response for trying to rmdir a mount point
> >     or trying to unlink a file which is a bind mount point
>
> Fair enough. I believe the name given to this kind of server behaviour
> is "bug".
>
> >
> > > The protocol says that the client can expect this return value to
> > > mean
> > > it is dealing with a server with Windows-like semantics that
> > > doesn't
> > > allow these particular operations while the file is being held
> > > open. It
> > > says nothing about expecting the same behaviour for mountpoints,
> > > and
> > > since the latter have a very different life cycle than file open
> > > state
> > > does, you should not treat those cases as being the same.
> >
> > The two cases are currently indistinguishable in nfsd_unlink(), but
> > it could check DCACHE_NFSFS_RENAMED flag if we want to
> > limit NFS4ERR_FILE_OPEN to this specific case - again, this is
> > upstream code - nothing to do with my patch.
> >
> > FWIW, my observed behavior of Linux nfs client for this error
> > is about 1 second retries and failure with -EBUSY, which is fine
> > for my use case, but if you think there is a better error to map
> > EBUSY it's fine with me. nfsv3 maps it to EACCES anyway.
> >
> >
>
> When doing LINK, RENAME, REMOVE on a mount point, I'd suggest returning
> NFS4ERR_XDEV, since that is literally a case of trying to perform the
> operation across a filesystem boundary.

I would not recommend doing that. vfs hides those tests in vfs_rename(), et=
c
I don't think that nfsd should repeat them for this specialize interpretati=
on,
because to be clear, this is specially not an EXDEV situation as far as vfs
is concerned.

>
> Otherwise, since Linux doesn't implement Windows behaviour w.r.t. link,
> rename or remove, it would seem that NFS4ERR_ACCESS is indeed the most
> appropriate error, no? It's certainly the right behaviour for
> sillyrenamed files.

If NFS4ERR_ACCESS is acceptable for sillyrenamed files, we can map
EBUSY to NFS4ERR_ACCESS always and be done with it, but TBH,
reading the explanation for the chosen error code, I tend to agree with it.
It is a very nice added benefit for me that the NFS clients get EBUSY when
the server gets an EBUSY, so I don't see what's the problem with that.

commit 466e16f0920f3ffdfa49713212fa334fb3dc08f1
Author: NeilBrown <neilb@suse.de>
Date:   Thu Nov 28 13:56:43 2019 +1100

    nfsd: check for EBUSY from vfs_rmdir/vfs_unink.

    vfs_rmdir and vfs_unlink can return -EBUSY if the
    target is a mountpoint.  This currently gets passed to
    nfserrno() by nfsd_unlink(), and that results in a WARNing,
    which is not user-friendly.

    Possibly the best NFSv4 error is NFS4ERR_FILE_OPEN, because
    there is a sense in which the object is currently in use
    by some other task.  The Linux NFSv4 client will map this
    back to EBUSY, which is an added benefit.

    For NFSv3, the best we can do is probably NFS3ERR_ACCES, which isn't
    true, but is not less true than the other options.

    Signed-off-by: NeilBrown <neilb@suse.de>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>


Thanks,
Amir.

