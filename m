Return-Path: <linux-fsdevel+bounces-39714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447DA172A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B1C3A5CA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BF91EF08A;
	Mon, 20 Jan 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK+6z1U4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15087DA82;
	Mon, 20 Jan 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397315; cv=none; b=gbdSn25TgsidDaEk0ZhAFwllutrleVMlxi21RWRy8ZlS6wUh6E0WVkeiJZRCepY93JYtG8SSXVO37fAjxdApOFDLYWgW8pMaZzNRLRQ/h6qSv2u++fk0oUBVqtrrRGJmox9oMUyuUH3FmukMM2fFtK2JhSHQcoKPF4bXSwt8KCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397315; c=relaxed/simple;
	bh=PgA6WKVGJd6mr324fppbzG5n2luG0LzLUciQS34aqao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG+C9cUqmY5Y2vUTULwbB85bOv3uBTqcyE4LTKN3SKC2WzZuxb6qDXJqR2A79T23UOVNFkXp4INFBPwKX8CkUCWbLHJiwDCR2u6iqDzFvEHZPGiI7LoRM+DbNiWu+eivD2oy8gviw3UqKZyVc0zKWloVLmN1R7Mb+1U6W7/wa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK+6z1U4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso8257106a12.2;
        Mon, 20 Jan 2025 10:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737397312; x=1738002112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN32+FgudI9axY//m66xC1dlO5vc+weY/KUhjN1COJ4=;
        b=kK+6z1U4pbKfTbP5t0jgdZEC3gXeE6iVtrP932cwhjfBsZxK2Yzvfc/ctA3kxnU/1K
         CicsuQ05WIn3/Sqs6QrAfzK0UKt3caQtREKY2EwQ1PDnMLr6pfXBH43D4iWjmbApa0Or
         CGJP7ULgnOoxZCrx1arJ/j6hcUg5Jntq92wQfrQLS1k21MK+qTZb4V2ujOnhP4xQkkaP
         OUEUioIlqlG+qHBYNcz5NDc+c2SIdsW6ec1EfMmU0P8w2gLUMdaEeAuCso45LAyVZIUW
         adQrzZlY0HADrrU2leTZi6P64jNf9Qx6/GSUb4/t6knhlDkPdfB6W5eckm3fvF5Ua61Y
         8l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737397312; x=1738002112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN32+FgudI9axY//m66xC1dlO5vc+weY/KUhjN1COJ4=;
        b=N7PdVHpzDkIYNK4iVvTsiVdin3CkchVdKpBg3cyjM6T0NxjdDoJpkbdWDVMuigowie
         +at5U40sS3tDnQ0ejBjYEpacWGuifQpKxMS8T7y8w5UeyecjH3jBG3RPTp2r+wEapzmz
         gRYqhHaZ+6Yi7ZZ58eB9zhGdxv8hifudUH0PB6ZyZojGg7p1QXgrZ2CY0dATOaE2Srkr
         iHma+a+ZJciqdQ03H/w2UJrtfNdJNVR1o5V8aRyJTiKt+q3XSszybvI4ZYoHdKaRhyVV
         sV+55WSFAY3oyspfVl7axDwrSu5IcgAHITYAURlVS2yXGmKkl/uSvfR0h82JWvsPkxGX
         0w0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEHSWzf7gbVeZRKJeBc2bT8vqlDALD8EoKbQTBdC+Dyb1WXfjfDVGw4SZAWstxz0b4TV70Fz/+uCwl@vger.kernel.org, AJvYcCXqTvK1I9xoPk2hIngU3cTlq2akis5TFGTDxAVKSToYvuBMYMfSLfVDaG47iZtWXLY9y1YenWvRRRJarLLX@vger.kernel.org
X-Gm-Message-State: AOJu0YzvjyKWKQEs6ZKvgLkxujF/vAooDlhxxSBScnX6ITYikEumtNkV
	kqNId+Vd0uC3b8SC4P5jBfUCKmGBUEha7NsvRccdMl9wQbE+GqZXYQOCcc64YG3xahaxy3C8sIc
	U/7pxYfAMuapZFWPnZc0pyCj08lA=
X-Gm-Gg: ASbGncuaubuwabWaTlogkoi+Q2x5ZO4xsBXtXGtug/uAcR/ztFe0ItiGNMq0kyzV6NX
	SPIyLRop4QvfpuNBUwZCqRCyHpBZSbNg+FhcvC/Nz0vyGPubFiGI=
X-Google-Smtp-Source: AGHT+IECy2M8hjyahogIwFRcS6qh/6/7ocrWFvpKZUu+K2HyTcPfyyJiaszBkQLV42AXFI2g+7yWBq0zUZkHkPdZkL0=
X-Received: by 2002:a17:907:9694:b0:aab:f014:fc9a with SMTP id
 a640c23a62f3a-ab38b10f4c6mr1175357566b.22.1737397311727; Mon, 20 Jan 2025
 10:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120172016.397916-1-amir73il@gmail.com> <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
In-Reply-To: <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Jan 2025 19:21:40 +0100
X-Gm-Features: AbW1kvbeshnUUrA5Riy9ZRVynnO2n5lRaCDroHxDnnF_jly84u2aN1c95JO9Tmg
Message-ID: <CAOQ4uxgQbEwww8QFHo2wHMm2K2XR+UmOL3qTbr-gJuxqZxqnsQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 6:28=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Mon, 2025-01-20 at 18:20 +0100, Amir Goldstein wrote:
> > v4 client maps NFS4ERR_FILE_OPEN =3D> EBUSY for all operations.
> >
> > v4 server only maps EBUSY =3D> NFS4ERR_FILE_OPEN for rmdir()/unlink()
> > although it is also possible to get EBUSY from rename() for the same
> > reason (victim is a local mount point).
> >
> > Filesystems could return EBUSY for other operations, so just map it
> > in server for all operations.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Chuck,
> >
> > I ran into this error with a FUSE filesystem and returns -EBUSY on
> > open,
> > but I noticed that vfs can also return EBUSY at least for rename().
> >
> > Thanks,
> > Amir.
> >
> >  fs/nfsd/vfs.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 29cb7b812d713..a61f99c081894 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -100,6 +100,7 @@ nfserrno (int errno)
> >               { nfserr_perm, -ENOKEY },
> >               { nfserr_no_grace, -ENOGRACE},
> >               { nfserr_io, -EBADMSG },
> > +             { nfserr_file_open, -EBUSY},
> >       };
> >       int     i;
> >
> > @@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
> > svc_fh *fhp, int type,
> >  out_drop_write:
> >       fh_drop_write(fhp);
> >  out_nfserr:
> > -     if (host_err =3D=3D -EBUSY) {
> > -             /* name is mounted-on. There is no perfect
> > -              * error status.
> > -              */
> > -             err =3D nfserr_file_open;
> > -     } else {
> > -             err =3D nfserrno(host_err);
> > -     }
> > +     err =3D nfserrno(host_err);
> >  out:
> >       return err;
> >  out_unlock:
>
> If this is a transient error, then it would seem that NFS4ERR_DELAY
> would be more appropriate.

It is not a transient error, not in the case of a fuse file open
(it is busy as in locked for as long as it is going to be locked)
and not in the case of failure to unlink/rename a local mountpoint.
NFS4ERR_DELAY will cause the client to retry for a long time?

> NFS4ERR_FILE_OPEN is not supposed to apply
> to directories, and so clients would be very confused about how to
> recover if you were to return it in this situation.

Do you mean specifically for OPEN command, because commit
466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
added the NFS4ERR_FILE_OPEN response for directories five years
ago and vfs_rmdir can certainly return a non-transient EBUSY.

Thanks,
Amir.

