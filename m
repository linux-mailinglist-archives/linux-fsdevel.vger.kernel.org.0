Return-Path: <linux-fsdevel+bounces-55915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB30B0FDEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 02:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF7A560CF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE69211F;
	Thu, 24 Jul 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP7hReDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB47632
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315742; cv=none; b=tpAolHkbVCQu6dYfGIP0lC2RLxkdjuzhHW0s2/iLv4iBZ7B4z54xnKGVl1gf9Xg0lDm9CS72mWy/NdExrN4ftb5PvDFa6SFteWIpCFLRHFfuQSfp8GHPq1kPWUQR/LJG3X2IGdfYUOPLgku1C50fg8kqWg3/jdrdGIMMICeXLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315742; c=relaxed/simple;
	bh=AgdmRaa71JX++4/4RUdrTGgmckWtZBLdiCYFTCf6JtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyDrMA90EOkRRhrrAbQv3WDP99CL57Aib6hmAYGS6t2+mA4ssx6cexWwJqNwU5yEO2MpRtDPSAP57mCRRmKM6uQuN6EEiMwg0jWHbKu1w9GphLpsVIbX5fqFFoeg/+PWXQx4RKo9pGBJD20AIBxunxhYJ0VAlr/MfoheqMyXFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP7hReDh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab3802455eso5784821cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 17:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753315740; x=1753920540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBkJBl8N5+De/q+ueNBwZ5ngErkP0Mn84LPFvlaquTU=;
        b=eP7hReDh4BPaW6Z1drDbmj/qrASSMGT9r1VotAx1AUIh/CgUPIEbw0k96CfmlO6n6s
         wTuob5yFGIPG2www2oZIAhcHjbJV/0AZrD3/2RJF23yoO4734iQ9gB+lifRycwmkg2q2
         +wN0gGsK5Ak08dl0uKdFt9zC+AstfkerAEqdIqoMaM/mUhF1iuK74s1/V9iXBH0geHJr
         o4RMZKNay7orLMzTjgnjIJVPPiOzSZ45J9Gc6oOt82vJgil+xjust0Q02Nw9iku+EHgC
         /9cxZVZ7AS5qcojI5x55WX81BR9uhbom8R8GPhNw04578Jnihb/JHOCE+TAx0sBK9ImO
         hXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753315740; x=1753920540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBkJBl8N5+De/q+ueNBwZ5ngErkP0Mn84LPFvlaquTU=;
        b=peN+/hm7R5wixl99M89U6XAi59UEeuYhxkLqBgIcg2rzoE/C4nO5fIEqDol2mYADE7
         4c7GA83qHX5F9pFdXTEOdSd5IwIOhlFdP3mm+YC58RcSuR90RO2KsNFhvvP92UBzCXHP
         rH0zsASm1AMuLKmSIiW25v6EjUkNZEqMDd23PJ3WRtMcoRK0AGc7dlNSW9FW1+VgeWjA
         4Eame7Ns5Dx10xYlTBAFA4Julqsg6685TVhwgkx0bbSFUlWtRAdOm/DBi4c3boY/w4oU
         IlRhIO7f73HXcoZXq/pVVLVvNH2QFVR0wZbHQA8iWQRFb5ToocEUh6m8ITYcQz7novWs
         ZJRw==
X-Forwarded-Encrypted: i=1; AJvYcCWnM8za7tt7qJpxmAQCY2zxPPe1Olwpu8RSnwhiDZRTzMPyDFY4PhhYFjgy6w+cd7qosXA8u/WlmGAYv3nm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sA5aHa1TwdkFmO6H1knvLnHd+LIkkVLXulcZu1YYL2U0LhN1
	qMcCubTPeJX669S+7uhvAmj6dF36A1OtJ0xrMogS8zXlHr+8up2+8UUCOPWwhpA/o9ZiAk9l50V
	ADXrO5oSK3VghIGXwMOi5fNpix4F2/ME=
X-Gm-Gg: ASbGncsOBQi9gednQGfx5hfGu7L2m/PWDVYPf0dHUfkYx5CCCLR8ctifGkOF2ENkzoc
	e5UX3EJpTPtTGtMjOsNQo257lggIeg7thokHURM24kHmdrzuoAXGjzKcxSx9uhuWJLwleFiV/q7
	VMT70eKPRhCp+pYiJJMrFQ/vA/rn9uwZBtBX8PfdoSYjWRv0wkZ8Z41xD/EYFEeHiACRMj6FEPd
	eBKCuo=
X-Google-Smtp-Source: AGHT+IEmxFmS0IK6kU4Ub4QP3oO3btkgaXK/62oAmV9I2BNgUokOrh9HeSRZhxuy4I/1nQFkfPN4sTcOnQD9uq/lQzE=
X-Received: by 2002:a05:622a:343:b0:4ab:7f5f:620b with SMTP id
 d75a77b69052e-4ae6e009e82mr72644391cf.34.1753315739563; Wed, 23 Jul 2025
 17:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-bg-flush-v1-0-cd7b089f3b23@ddn.com> <20250723-bg-flush-v1-2-cd7b089f3b23@ddn.com>
 <CAJnrk1bbT7QnEfY-Kp_NOmrS-EZW92qwddKTgruMKe-WGMneiA@mail.gmail.com>
In-Reply-To: <CAJnrk1bbT7QnEfY-Kp_NOmrS-EZW92qwddKTgruMKe-WGMneiA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Jul 2025 17:08:48 -0700
X-Gm-Features: Ac12FXwGCGnythh_Xwtp3ndKcmQWiSKUY3ylukm2qyCPWR7uLv5_TtQwQ4AXhGU
Message-ID: <CAJnrk1Y4hLdDF3_42Pib-KhxrtsBb+cJckT5ECAzL9Ksxz3mZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Flush the io-uring bg queue from fuse_uring_flush_bg
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 4:51=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, Jul 22, 2025 at 3:42=E2=80=AFPM Bernd Schubert <bschubert@ddn.com=
> wrote:
> >
> > This is useful to have a unique API to flush background requests.
> > For example when the bg queue gets flushed before
> > the remaining of fuse_conn_destroy().
> >
> > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > ---
> >  fs/fuse/dev.c         | 2 ++
> >  fs/fuse/dev_uring.c   | 3 +++
> >  fs/fuse/dev_uring_i.h | 4 ++++
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 5387e4239d6aa6f7a9780deaf581483cc28a5e68..d5f2fb82c04bf1ee7a35cb1=
d6d43e639270945af 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2408,6 +2408,8 @@ void fuse_flush_requests(struct fuse_conn *fc, un=
signed long timeout)
> >         spin_unlock(&fc->bg_lock);
> >         spin_unlock(&fc->lock);
> >
> > +       fuse_uring_flush_bg(fc);
>
> I think we'll need to get rid of the
> "WARN_ON_ONCE(ring->fc->max_background !=3D UINT_MAX);" in
> fuse_uring_flush_bg() since fuse_flush_requests() sets
> fc->max_background to UINT_MAX a few lines above before making this
> call.
>
Ahh never mind, just realized I read this check in reverse. this looks
fine to me.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Thanks,
> Joanne
>
> > +
> >         /*
> >          * Wait 30s for all the events to complete or abort.  Touch the
> >          * watchdog once per second so that we don't trip the hangcheck=
 timer
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index eca457d1005e7ecb9d220d5092d00cf60961afea..acf11eadbf3b6d999b310b5=
d8a4a6018e83cb2a9 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -123,6 +123,9 @@ void fuse_uring_flush_bg(struct fuse_conn *fc)
> >         struct fuse_ring_queue *queue;
> >         struct fuse_ring *ring =3D fc->ring;
> >
> > +       if (!ring)
> > +               return;
> > +
> >         for (qid =3D 0; qid < ring->nr_queues; qid++) {
> >                 queue =3D READ_ONCE(ring->queues[qid]);
> >                 if (!queue)
> > diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> > index 55f52508de3ced624ac17fba6da1b637b1697dff..ae806dd578f26fbeac12f88=
0cd7b6031a56aec00 100644
> > --- a/fs/fuse/dev_uring_i.h
> > +++ b/fs/fuse/dev_uring_i.h
> > @@ -206,6 +206,10 @@ static inline bool fuse_uring_request_expired(stru=
ct fuse_conn *fc)
> >         return false;
> >  }
> >
> > +static inline void fuse_uring_flush_bg(struct fuse_conn *fc)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_FUSE_IO_URING */
> >
> >  #endif /* _FS_FUSE_DEV_URING_I_H */
> >
> > --
> > 2.43.0
> >
> >

