Return-Path: <linux-fsdevel+bounces-55452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2E6B0A9D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA5D1C8245C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B0D2E7F33;
	Fri, 18 Jul 2025 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi9MYAsr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF12E7F00
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861056; cv=none; b=j80isXjSgt/5gxXEIkiOJnuI3wCRoQ6vBpo5hT1mLc7pBpteUyJRyYAzgxrXjZB2oTy35B3olBE2f6aLnzuX7qVIpwZsuMIbMH5s5im3dWNp0KXVB3jaXwhj1UBO6LTmUsscCoBrgHB25iY9sgRZwd0ATAdbhNVsUiYiyVAzixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861056; c=relaxed/simple;
	bh=fN3U90rbyjkWX5wDfh7g2a8AlfDBEiDrZ9vgZPA8r7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY7OPxBhz/N87nHGQvzPijGMtL9zUZ8wNhIDAt0gBF0W9xFkQlAOk+rGstte6jwDM9SaiJgldDJe3pRPW6lGiyMAw0nFeig+blGTeWZlFoL9hFFAjeVVNxq8sfzOzmj9E8AYCLOXAzqMaysDHvUy3oCnk2t1lS3igtLVwkwaKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi9MYAsr; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4abac5b1f28so17332531cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752861053; x=1753465853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T92o1flEDwRDEiofqdo4f0ffqgL7/RWz9SFHalU3qk=;
        b=gi9MYAsrXm3nWxTgA8RKmZib76flEi2XWo9gsSH2Pn7gwGEGP2+2I4EHgSSIqRvv70
         aI452+J/Mida0IQIjwc0R48H35rrNvOmFGT6GODAa/1J8NVjiYnJOwxrngTA5c9XP6yT
         uZaFOk0BDDSwKYxq51qdxkdSDJtEyW4QUCRPhAL/OmF40kr9VjZ4o2ovKE4G7BlFggne
         SwFCHmfIDXGnIJ8IOyFE5NsFOpE4px6CnX5/6zC1EomnbexV7uQeFZqwUzYK1Urox1ig
         FKH+FbVIJNA6G9dJRHTBChi5vkoZfn7ynt7Y2Nh6Fr0vC+YbMHJC0mWH6z69xzrsXh8s
         7vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752861053; x=1753465853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1T92o1flEDwRDEiofqdo4f0ffqgL7/RWz9SFHalU3qk=;
        b=XAQEhpIt5UHKsHizAT0Rxs1d9NxJZ1yhk4gAPki2/ZiFNE2HoqibtaPJGzTllIzLnl
         Fg5IjmP32voGH1d5Qwb+CA/B9X0V5dYyuPrgQFY0ZCNmUx/+S/RG5r7bDAdMEGXIOe+m
         uwbPk7VTP8lNjCLVnN4XaMD7Hj5XHixiDdV+31wIaXOcwE5bcJvbURwSq6pVJ3/J5WHU
         2mIZfFdgAz+bdQlmK/goAN3noIJ6Fm4DdeMWSXv4bk/CkIPIPmQ+yeFkDm89fbvkhmvq
         A/L+Y8m6WbQwysc6EkgRS5nnbR/cnouM6TY8yBlCYOT1p5ViawpdJAvmxZSkzja3sxEi
         wbyA==
X-Forwarded-Encrypted: i=1; AJvYcCVH11lloceYXv3pNIvY98Yr5/7C4t3N/0QedtYKJ6JwU/EEclYxCDUbKlIMxj0xxzL7gXLxt5UupF+FvzYK@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDN2RbbsQZmVlHTHQCUhcUdw+yQMjUvOOnUymbKDEcM/+kCOI
	brKKcaWhxHxSqyxKy4rd0HDFq+UgccjfBf+DKBJ+LbxH1sbkSjZSYAVY7Ao58bo8+4Uh1zMrkSI
	JS0i8Fo4kFVntn38SFX21HX8TOSqIMx+UAQ==
X-Gm-Gg: ASbGncuQhPpOGOClRAbv5Km5GRHYEMcA+JZhGG4FjLSedh/qDWas5oMhsE0fxlJ+Q5N
	UTi40L3myry8CTaL741aayZYcAjKEJn48QRQ3oEKLe84hNdykooJBRaWPXCSWQrSd6eRH3yWScl
	z9tJcNbQ8FIo5ov3UkIbzTlSIXVbySNpSPlovJ539a44/jpwS9/SkFUGrX7mm/cS/LwIU8as/yZ
	dtY79+V+MJpNTe92lxXPfc=
X-Google-Smtp-Source: AGHT+IGUQu0PqDJKLGI5Y1NKQnySJx1uPz2hk/IOMZu8BiZpg6EWlzlWYwwgGkuq74olMCD4wmwXG/DAu4LlobGpmz8=
X-Received: by 2002:a05:622a:302:b0:4ab:95a7:71d4 with SMTP id
 d75a77b69052e-4aba3e88556mr102053121cf.54.1752861053273; Fri, 18 Jul 2025
 10:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs> <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
In-Reply-To: <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 18 Jul 2025 10:50:41 -0700
X-Gm-Features: Ac12FXw7U5yEuRnVFjjo1Ss95W25w1ADfAv-O0ZG-MW4GnH5vOcur90BJosaKm4
Message-ID: <CAJnrk1bvt=tr-87WLRx=KtGUsES09=hhpM=mspsaEezVORVLnQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: Bernd Schubert <bernd@bsbernd.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	John@groves.net, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 9:37=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 7/18/25 01:26, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > +/*
> > + * Flush all pending requests and wait for them.  Only call this funct=
ion when
> > + * it is no longer possible for other threads to add requests.
> > + */
> > +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)
>
> I wonder if this should have "abort" in its name. Because it is not a
> simple flush attempt, but also sets fc->blocked and fc->max_background.
>
> > +{
> > +     unsigned long deadline;
> > +
> > +     spin_lock(&fc->lock);
> > +     if (!fc->connected) {
> > +             spin_unlock(&fc->lock);
> > +             return;
> > +     }
> > +
> > +     /* Push all the background requests to the queue. */
> > +     spin_lock(&fc->bg_lock);
> > +     fc->blocked =3D 0;
> > +     fc->max_background =3D UINT_MAX;
> > +     flush_bg_queue(fc);
> > +     spin_unlock(&fc->bg_lock);
> > +     spin_unlock(&fc->lock);
> > +
> > +     /*
> > +      * Wait 30s for all the events to complete or abort.  Touch the
> > +      * watchdog once per second so that we don't trip the hangcheck t=
imer
> > +      * while waiting for the fuse server.
> > +      */
> > +     deadline =3D jiffies + timeout;
> > +     smp_mb();
> > +     while (fc->connected &&
> > +            (!timeout || time_before(jiffies, deadline)) &&
> > +            wait_event_timeout(fc->blocked_waitq,
> > +                     !fc->connected || atomic_read(&fc->num_waiting) =
=3D=3D 0,
> > +                     HZ) =3D=3D 0)
> > +             touch_softlockup_watchdog();
> > +}
> > +
> >  /*
> >   * Abort all requests.
> >   *
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 9572bdef49eecc..1734c263da3a77 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -2047,6 +2047,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
> >  {
> >       struct fuse_conn *fc =3D fm->fc;
> >
> > +     fuse_flush_requests(fc, 30 * HZ);
>
> I think fc->connected should be set to 0, to avoid that new requests can
> be allocated.

fuse_abort_conn() logic is gated on "if (fc->connected)" so I think
fc->connected can only get set to 0 within fuse_abort_conn()


Thanks,
Joanne

