Return-Path: <linux-fsdevel+bounces-39761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51555A17B3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E023E1883DC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE2196DB1;
	Tue, 21 Jan 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFoN0lJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B986219E0;
	Tue, 21 Jan 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454641; cv=none; b=YOvUw5zHQhIieY34h4d3dxE+WcUztvPdp1VD27tDJ64UcDbcizLRXnlFUjG9itixRjwVolMc535MqprsVa8PYGIup+Ja4cTAd4Cn77AjIz1PAPUGbKjPRm8hnxEl0ak42kkbEPXZnu3HwMPMcq75OKcJBWhB2ciDKyU0btCIQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454641; c=relaxed/simple;
	bh=Xur4GV5SouyddyhhnNH66OnYKS1jg5U1G1kMfo/1Plc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuTYMuH0tr18xp9oHGHFz2vsjVeXzR2+fAcnRyAgbjvW1JijfsmqaonguTFLJWSPaI6mWhwjNCVDdaIWNtS/WojzUkFH+QfCPePjX+3om//0AxboJr/ZYPQ/YwIQkwczDMkesDCfTpa8tAuYq96ECZBp5XB5hhyRN9xn4Lqh3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFoN0lJ9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so7369108a12.1;
        Tue, 21 Jan 2025 02:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737454638; x=1738059438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhU6kygyg87h1PfTczri/IBHAXfnFM7UhqWm6epNX7w=;
        b=gFoN0lJ990/z9RaZB8Rgtize/zc9yBQq0FO9K4oacAe2wIrwSEteqkP3Rqc27MktRL
         OTMhjIjGSZt3RLxrkx1GvvrfE5hE8/eS65F+04kqmVazia7WwAizoelrVLICHq7UewkX
         HiycZdSF8sFQ35FKepoqh9CVUZEOFR91tI5aWzYCAT/JFHsjclSdeAVrNubCy+AquQu8
         tD0b6jzSg5C++Kd5NHIkeCy3qibst2cch11VrtfrfTovgWtGgKtj9LuKRmMWUpNnOWFZ
         4C/vfEYrpHRShEjhgvDBp2WZLfWDhUK6QJ022d+qEJxBpRQJBZv4yD8HlKWQYiLhhEku
         aTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737454638; x=1738059438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhU6kygyg87h1PfTczri/IBHAXfnFM7UhqWm6epNX7w=;
        b=VSzjgr0+ZEMhP0ScVkk3/1JT7tj4o9j4+QNRX1voWr1pieAaXroHtpVRgqGwulSLb9
         RyFwY23hCZW0o+S8EOBBpaER4szWUmIPxIuTXbCERC3uEmkmMIVKRC2VrmRPzD2cr0CA
         be/6bhe1BiEU3bkkydBFyzOcQBsoN4SBv/8734UGf0v5mWfpKq7FbylwtoUVrKspJeg5
         XSgCfn+G0UB5ue2+zJV5Y5Qy+mxG4Ya3kwDW4M9U2D09JvZJ/IF8T0ypQ2vaxQk1ROnN
         JBKSK30gVL1U7Vjt+XmzcOZLpoQzt1M408E/KkCAeArwlz2yGl0aHvHZU3TV5MwAWfGx
         F4pw==
X-Forwarded-Encrypted: i=1; AJvYcCUzFHuXj60bt0eywsoCJXZx5OexG3509PBJWZw3qwTphI2HpEXuNO5g6pqdK9XlIXiNpB64hgPkmMAn@vger.kernel.org, AJvYcCXNaX7lfaxQq9kOZo0255f2cWRwj0XN58tqMAsSb8z+KmpEIsVlNlvkxYIs0gI3Iv+YqJIo5EQIpI4b4U4n@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4cbVR/vR0R18w4GqyfQlt5nqzNEg/I4a8WWsGIYeerNYVwA/
	Z114vWsG1cQ8jYh2BTcjMWibu2EDFh6n7RU7MBIF/kutjcRdOnVHZvmyPhWbfUYAM0KuxyNWSs8
	bu82/WQockv+Jo+fJR4OaApBBW+w=
X-Gm-Gg: ASbGncueqrGxRztJXxQMTmM2PgO7z4lR0mMVEC+leRG3S4BN5kM4yU67aBawDfUCbvk
	p4+nr/ukyh0hYoAy6J8k3nfkLfpigN0DZS0bdnfNBpNbpduyye1w=
X-Google-Smtp-Source: AGHT+IEK+Mdz+qeXyWjOMMmWO+6Vvh9ouVjzVBebsC6C6BwpXUgZaztyp6xjbDygO9FQ679YVRjKa+sYMfEnyDDkRA8=
X-Received: by 2002:a05:6402:1e8a:b0:5da:1229:2692 with SMTP id
 4fb4d7f45d1cf-5db7db2b2a7mr17397509a12.28.1737454637081; Tue, 21 Jan 2025
 02:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhXuHPsaqzH7SJ-W93dX4ZCJip3CN_P9ZY5f5eb95k6Qg@mail.gmail.com>
 <173741417318.22054.17226687272828997971@noble.neil.brown.name>
In-Reply-To: <173741417318.22054.17226687272828997971@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Jan 2025 11:17:05 +0100
X-Gm-Features: AbW1kvbPlVEODLcstiuUec3KVMSWnewJhYP6zeFR-ektFCOKgrgvjFVWsiND05s
Message-ID: <CAOQ4uxjOmhA315gWbo6AarEtmRzHG9cf_b=hnMnNDXMtNm24AQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 12:03=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 21 Jan 2025, Amir Goldstein wrote:
> > On Mon, Jan 20, 2025 at 8:29=E2=80=AFPM Trond Myklebust <trondmy@hammer=
space.com> wrote:
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
> > > > > > > > v4 client maps NFS4ERR_FILE_OPEN =3D> EBUSY for all operati=
ons.
> > > > > > > >
> > > > > > > > v4 server only maps EBUSY =3D> NFS4ERR_FILE_OPEN for
> > > > > > > > rmdir()/unlink()
> > > > > > > > although it is also possible to get EBUSY from rename() for
> > > > > > > > the
> > > > > > > > same
> > > > > > > > reason (victim is a local mount point).
> > > > > > > >
> > > > > > > > Filesystems could return EBUSY for other operations, so jus=
t
> > > > > > > > map
> > > > > > > > it
> > > > > > > > in server for all operations.
> > > > > > > >
> > > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Chuck,
> > > > > > > >
> > > > > > > > I ran into this error with a FUSE filesystem and returns -
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
> > > > > > > > @@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp,
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
> > > > > > It is not a transient error, not in the case of a fuse file ope=
n
> > > > > > (it is busy as in locked for as long as it is going to be locke=
d)
> > > > > > and not in the case of failure to unlink/rename a local
> > > > > > mountpoint.
> > > > > > NFS4ERR_DELAY will cause the client to retry for a long time?
> > > > > >
> > > > > > > NFS4ERR_FILE_OPEN is not supposed to apply
> > > > > > > to directories, and so clients would be very confused about h=
ow
> > > > > > > to
> > > > > > > recover if you were to return it in this situation.
> > > > > >
> > > > > > Do you mean specifically for OPEN command, because commit
> > > > > > 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.=
")
> > > > > > added the NFS4ERR_FILE_OPEN response for directories five years
> > > > > > ago and vfs_rmdir can certainly return a non-transient EBUSY.
> > > > > >
> > > > >
> > > > > I'm saying that clients expect NFS4ERR_FILE_OPEN to be returned i=
n
> > > > > response to LINK, REMOVE or RENAME only in situations where the
> > > > > error
> > > > > itself applies to a regular file.
> > > >
> > > > This is very far from what upstream nfsd code implements (since 201=
9)
> > > > 1. out of the above, only REMOVE returns NFS4ERR_FILE_OPEN
> > > > 2. NFS4ERR_FILE_OPEN is not limited to non-dir
> > > > 3. NFS4ERR_FILE_OPEN is not limited to silly renamed file -
> > > >     it will also be the response for trying to rmdir a mount point
> > > >     or trying to unlink a file which is a bind mount point
> > >
> > > Fair enough. I believe the name given to this kind of server behaviou=
r
> > > is "bug".
> > >
> > > >
> > > > > The protocol says that the client can expect this return value to
> > > > > mean
> > > > > it is dealing with a server with Windows-like semantics that
> > > > > doesn't
> > > > > allow these particular operations while the file is being held
> > > > > open. It
> > > > > says nothing about expecting the same behaviour for mountpoints,
> > > > > and
> > > > > since the latter have a very different life cycle than file open
> > > > > state
> > > > > does, you should not treat those cases as being the same.
> > > >
> > > > The two cases are currently indistinguishable in nfsd_unlink(), but
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
> > > When doing LINK, RENAME, REMOVE on a mount point, I'd suggest returni=
ng
> > > NFS4ERR_XDEV, since that is literally a case of trying to perform the
> > > operation across a filesystem boundary.
> >
> > I would not recommend doing that. vfs hides those tests in vfs_rename()=
, etc
> > I don't think that nfsd should repeat them for this specialize interpre=
tation,
> > because to be clear, this is specially not an EXDEV situation as far as=
 vfs
> > is concerned.
> >
> > >
> > > Otherwise, since Linux doesn't implement Windows behaviour w.r.t. lin=
k,
> > > rename or remove, it would seem that NFS4ERR_ACCESS is indeed the mos=
t
> > > appropriate error, no? It's certainly the right behaviour for
> > > sillyrenamed files.
> >
> > If NFS4ERR_ACCESS is acceptable for sillyrenamed files, we can map
> > EBUSY to NFS4ERR_ACCESS always and be done with it, but TBH,
> > reading the explanation for the chosen error code, I tend to agree with=
 it.
> > It is a very nice added benefit for me that the NFS clients get EBUSY w=
hen
> > the server gets an EBUSY, so I don't see what's the problem with that.
>
> I agreed with it when I wrote it :-) but now I find Trond's argument to
> be quite compelling.  Fomr rfc5661:
>
> 15.1.4.5.  NFS4ERR_FILE_OPEN (Error Code 10046)
>
>    The operation is not allowed because a file involved in the operation
>    is currently open.  Servers may, but are not required to, disallow
>    linking-to, removing, or renaming open files.
>
> This doesn't seem to cover "rmdir" of a mountpoint.
>
> However NFS4ERR_XDEV is only permitted for LINK and RENAME, not for
> REMOVE, so we cannot use that.
>
> NFS4ERR_ACCESS says "Indicates permission denied" but there is no
> permission issue here.
>
> NFS4ERR_INVAL might be ok.  "The arguments for this operation are not
> valid for some reason" is suitably vague.
>
> NFS4ERR_NOTEMPTY "An attempt was made to remove a directory that was not
> empty." could be argued as it "contains" a mountpoint in some sense.
>
> I'd favour NFS4ERR_INVAL today.  I might change my mind again tomorrow.
>

I will follow the guidance of 2019 Neil and go with NFS4ERR_ACCESS
because it matches the current behavior of NFS v2,3 and because
Trond also said it is the appropriate error for sillyrenamed files.

Thanks,
Amir.

