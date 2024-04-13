Return-Path: <linux-fsdevel+bounces-16851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC28A3B58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF750B2141E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20E91CABA;
	Sat, 13 Apr 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1bIhQS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3D1802B
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712991057; cv=none; b=dDqBHFPSJSk8C8AAVfPPHCsXOz8VSFLvJ1KhAufLIcLcQBdHHvEYG4myPcxNZKXlWbuqK6876pE71aA7qVrflwFiXKBvxVLQLRU0Bg50FAaumS94D5qcM8MQjgCE0impky08ZqPbE545ClYQEpKFGrkHxoVpEROYqb9LRoTZ0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712991057; c=relaxed/simple;
	bh=xreK+p+a49f+H6KVJdqxyZREz/rIkKzcMkolcfPee2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcKQ9az4XoPF4HNnPXzEmQwnjrhr7yrKwj5LF2s+3ELaZXO9ECG6mN+beGJFaxtTdFfsbtlt9J82qQQJXJYbtrgBLVXZH9BxybQuQTewilRGHyJ+E47nB2GZBK9w2XtTpxyX1e40UoLbIQ67Svgx5soO4zJsDWJIBo0eqq7c4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1bIhQS+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b514d3cf4so13235276d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 23:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712991054; x=1713595854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCfJQVFq+jS7iOYNSYs+3q9X46OUF9pfCNaxNst7Jbs=;
        b=h1bIhQS+IRhsd2lhl2P3piWidm3bqFF7laPBIx8y7znZJKlbkqVHa+b1W1AV4ex8dj
         jQDIK9ttXLi1wGPZtxneFrSdzgrA1TafsWXGZKKAe7mMCubyDA8ZjA5zEIvAHbYmjoX3
         pST8ztAi0SSecDjN4ZrCUYB0GVmz2VSC1uX4YxzshVsEFuPo7SH1UhVcBDueqRzzIVzN
         DHdnLGpqjYqCogWf+UbF1orGK7fwvMk8zDBeRqCRwj7M64R78GOcd9q2ZYTvh7cTqtBF
         rp0rTC/VcS95dmqtGFCK62/2dK6eL0pVm88fkXosF+6Yvl+9ISpR+jvlz3vp+Hxaf5an
         j1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712991054; x=1713595854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCfJQVFq+jS7iOYNSYs+3q9X46OUF9pfCNaxNst7Jbs=;
        b=vt5aV5IrSreXmjfRXkoMuR7BS3uisxvm4n0tx0A3IM5G0e/20vd/1nyuPZbDUlIEHt
         JRyqs2tffMh7he8TPxDP6HLoWYCQNxaqwK90IhmebakoiK3Q0JS2AqiR0GSlxvIsiTPv
         pNCSSPRNJNI3NcUfI3T+YDXW2vDyPIqIr0zsnrHFLVzfJOe8YI0u7x2MzH3gvXl/srRL
         Sh5Qd/UWH8MUOO7CG81OU/BBRJ7vqMb85iX7mBWQafoFDyCjslU2EMAc4xHybCr9Lt4G
         6WnRaNrpZd3gv5nHlNVkCV8aXGxqtB9wjkgUYIiQslwSjOIqL82P5wh0h4DCI5VA7AXS
         nkVA==
X-Forwarded-Encrypted: i=1; AJvYcCUV9aIaft0og/23JtJYBMJDwO+J5QHAHrP7eEkth6R+8fR7e77jXAQtGjotyd7eNINRVImlFxCKIFH9J69ieQeSl2HLevZ2FTCbezQxyQ==
X-Gm-Message-State: AOJu0Yx1tps7ZcuyFXCS4EpXyIq4lnSCV444AvTNhYDm2dCULnGcVqyr
	NMZFlRpHYERGeGQqd4Q1fdjEyPXriLebHupuSuYc/aE97VEl4hTzK5XeqgnypdLCd3Mzt14XQRR
	8GWLv5pBRKEOHCaqNyWX5SEBMUB8=
X-Google-Smtp-Source: AGHT+IH2pRfnVIpRmARiBYqg4taA/i8kG/uPtgtnUgvFSZ2JfplimstGOmNSgzP30Wh9drmNtzly9Msy2YJT9GXqZvc=
X-Received: by 2002:a05:6214:11aa:b0:699:23f8:1044 with SMTP id
 u10-20020a05621411aa00b0069923f81044mr4915120qvv.11.1712991054613; Fri, 12
 Apr 2024 23:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407155758.575216-1-amir73il@gmail.com> <20240407155758.575216-2-amir73il@gmail.com>
 <CAJfpegs+Uc=hrE508Wkif6BbYOMTp3wjQwrbo==FkL2r6sr0Uw@mail.gmail.com>
 <CAOQ4uxgFBqfpU=w6qBvHCWXYzrfG6VXtxi_wMaJTtjnDAmZs3Q@mail.gmail.com>
 <CAJfpegtFB8k+_Bq+NB9ykewrNZ-j5vdZJ9WaBZ_P2m-_8sZ5EQ@mail.gmail.com> <CAOQ4uxjtDAuMezRXCiVpBPoTXt6d5G0TWJxb=3QVCvp1+VN59w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjtDAuMezRXCiVpBPoTXt6d5G0TWJxb=3QVCvp1+VN59w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 13 Apr 2024 09:50:43 +0300
Message-ID: <CAOQ4uxi4Sm7X6bJ44tpkZBhKm-XHGFW-EuYZHcNKMp59E+ybTg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: fix wrong ff->iomode state changes from
 parallel dio write
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 7:18=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Tue, Apr 9, 2024 at 6:32=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Tue, 9 Apr 2024 at 17:10, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Apr 9, 2024 at 4:33=E2=80=AFPM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > > >
> > > > On Sun, 7 Apr 2024 at 17:58, Amir Goldstein <amir73il@gmail.com> wr=
ote:
> > > > >
> > > > > There is a confusion with fuse_file_uncached_io_{start,end} inter=
face.
> > > > > These helpers do two things when called from passthrough open()/r=
elease():
> > > > > 1. Take/drop negative refcount of fi->iocachectr (inode uncached =
io mode)
> > > > > 2. State change ff->iomode IOM_NONE <-> IOM_UNCACHED (file uncach=
ed open)
> > > > >
> > > > > The calls from parallel dio write path need to take a reference o=
n
> > > > > fi->iocachectr, but they should not be changing ff->iomode state,
> > > > > because in this case, the fi->iocachectr reference does not stick=
 around
> > > > > until file release().
> > > >
> > > > Okay.
> > > >
> > > > >
> > > > > Factor out helpers fuse_inode_uncached_io_{start,end}, to be used=
 from
> > > > > parallel dio write path and rename fuse_file_*cached_io_{start,en=
d}
> > > > > helpers to fuse_file_*cached_io_{open,release} to clarify the dif=
ference.
> > > > >
> > > > > Add a check of ff->iomode in mmap(), so that fuse_file_cached_io_=
open()
> > > > > is called only on first mmap of direct_io file.
> > > >
> > > > Is this supposed to be an optimization?
> > >
> > > No.
> > > The reason I did this is because I wanted to differentiate
> > > the refcount semantics (start/end)
> > > from the state semantics (open/release)
> > > and to make it clearer that there is only one state change
> > > and refcount increment on the first mmap().
> > >
> > > > AFAICS it's wrong, because it
> > > > moves the check outside of any relevant locks.
> > > >
> > >
> > > Aren't concurrent mmap serialized on some lock?
> >
> > Only on current->mm, which doesn't serialize mmaps of the same file in
> > different processes.
> >
> > >
> > > Anyway, I think that the only "bug" that this can trigger is the
> > > WARN_ON(ff->iomode !=3D IOM_NONE)
> > > so if we ....
> > >
> > > >
> > > > > @@ -56,8 +57,7 @@ int fuse_file_cached_io_start(struct inode *ino=
de, struct fuse_file *ff)
> > > > >                 return -ETXTBSY;
> > > > >         }
> > > > >
> > > > > -       WARN_ON(ff->iomode =3D=3D IOM_UNCACHED);
> > > > > -       if (ff->iomode =3D=3D IOM_NONE) {
> > > > > +       if (!WARN_ON(ff->iomode !=3D IOM_NONE)) {
> > > >
> > > > This double negation is ugly.  Just let the compiler optimize away =
the
> > > > second comparison.
> > >
> > > ...drop this change, we should be good.
> > >
> > > If you agree, do you need me to re-post?
> >
> > Okay, but then what's the point of the unlocked check?
>
> As I wrote, I just did it to emphasize the open-once
> semantics.
> If you do not like the unlocked check, feel free to remove it.

Miklos,

I see that you removed the unlocked check in the fix staged for-next.
Please also remove this from commit message:

    Add a check of ff->iomode in mmap(), so that fuse_file_cached_io_open()=
 is
    called only on first mmap of direct_io file.

Thanks,
Amir.

