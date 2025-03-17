Return-Path: <linux-fsdevel+bounces-44212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F690A65C80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 19:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549D9175747
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D41B4240;
	Mon, 17 Mar 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfVDfMSl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49119048F
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236001; cv=none; b=Obkhzt5U57rwKTfHz3Ku1T46X33RwSNDUZNUcUK2ZNLGxnEFQQtd2ISbtQbO5HB4jgvv8F4z4WlpsG66qB67yRNrJlm9Wn0DQMJCgAtzhpk4PrZsJTs/K0yz/YLHwVMs+bZXVHgYFMdOWvqwcX21uyMlDg1DJjl9c9EYoZCxt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236001; c=relaxed/simple;
	bh=FHfXp0x3Kpv/pjN0flWLfSJvjVZvj3KRmIIj5EvlSLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnU7b+FI1pVwgeQbzlcCkb6Y41P5gty7I6fTcK1cla62y+rcl7ZRM9m+Ifer9Fd4AT2Jsn5XxP1UxFUn+5VFTuV3TBeXBPA8vBYz1Cxs5g4i08WoJztNTNYzGoKaTlzngaiGtbTSPifJfMdgRtSnFReyzla1tOA54TpJ74OrUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfVDfMSl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476a304a8edso44093361cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235999; x=1742840799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uybi13LHjDwJuvAHDmMno3j/USTtVJ3V+FgK9e6yMEo=;
        b=LfVDfMSlRa0t72p1zhx2ALBsXQKpmkS9LB/qLPrr560NErZ5+bdXKXU3l+L2H2SykK
         dmbzgzBPaP4pUckhaOrcipGcFIVKVMkWmcXFAOFy8+EfUisl7JODvGtffKUoXH5r0EBO
         2agfZw9TTVLkgbe0Mwte/XYBv30JnTUwiF4EZAQbyFhkjOwatsLXbZm9tbLELcBXqV3W
         LebF+QKSNNJaT0P1ZQFcem7VQsLB2//GyXnQioaras48MUeCfKnqOXvKjp4SUik6Mc72
         kBvvI0efW4E+1vrqHg2jlyMxQAF+UpuET17c3+hYKtS0x1YAfapnF7MgSRgaG7vR0woK
         Chww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235999; x=1742840799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uybi13LHjDwJuvAHDmMno3j/USTtVJ3V+FgK9e6yMEo=;
        b=tKl/dxGBoBtOTsooz76KeuSyobovEjlKebnteUGE9Ud/mFPVutJnHLit6tg7ZFN/oB
         owgRbbvLnmkQrArruBJ246vZrhgVHt94+MKUtqjAXrwWp0SaMgnGDZfotUwH1Y3iT1La
         rPb6JYNAMf7gIuZ8zC+k1lxZGW6BJ9hxzP8U5sO5qrlncih+d64E+LQSnihOKn7kepEr
         HNLsxkGtrZybR4C9eKbHU1AqTPgkk9d5vXuWbx2ux7fMhsxJB+agdIR8AcXGwbxbAi1F
         WuAuilSWG0yatRBr+PaafArsbxERWfEklNUkWs8JC2xaXwyNzVsChxWqP9bJpxqCNGxx
         V41g==
X-Forwarded-Encrypted: i=1; AJvYcCUAL3DCpdjjC64QmeO87e0C9pVE7qZhopBMfIcOgP7HfE31X1kVubfJGTyq6xn81r9t+zP9AwbKRGqQ0O40@vger.kernel.org
X-Gm-Message-State: AOJu0YwLihlsHoRKi0rfLWryrnfRfh/48EAZ1mANTPKvXXbjLckyKACK
	sb4RlWZikxNaidHlkJquNrOYc7u+Lk+F32HSLdwi//X4cNVCwrmW8YAYj64GwQKh/pvrgDOPf5Q
	qmDVtltc0PiS0gELcAVPzBWOzLRY=
X-Gm-Gg: ASbGncsUJ+nszPOg6um2oX2V7mLQNXDErfC/MhAHeB91xOOkP5+/X+FnYxFnzSf1f51
	Oxo844ttj5tMTlGdMwWWp1Kpys13mWviJMlxHLYF8+s7V7MzE8Y+PMKne1kXG/h4UPJmS4hYGVV
	ZoUhJiK8kkhxC+43uToJX1SGOad2GBHtL2usCLW7TX96GTFTsRUcc1
X-Google-Smtp-Source: AGHT+IEmHxIOrf4vYGC/OGDl5/gJaw5dm86oj2gnZnuikMrlsZ4RtRhXEjP1T5k/VnqTZf4AlB2D1goSKT4b7MXc/PY=
X-Received: by 2002:a05:622a:4008:b0:476:8816:6d17 with SMTP id
 d75a77b69052e-476fc96e6a8mr9998991cf.6.1742235998809; Mon, 17 Mar 2025
 11:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314205033.762641-1-joannelkoong@gmail.com> <2e6bb462-159f-4e7c-af7c-53f2eb44270d@fastmail.fm>
In-Reply-To: <2e6bb462-159f-4e7c-af7c-53f2eb44270d@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 17 Mar 2025 11:26:28 -0700
X-Gm-Features: AQ5f1JrWzJFAlMvYwVwJX-mBPpWAeRp5IA0d8_zS6sW3fbOAwOjzDLsbdSPwrDo
Message-ID: <CAJnrk1YyFNbyPzFebhauf1eXRaGT-pR0De=OkzL9P0mTsv1rmQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix uring race condition for null dereference of fc
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:51=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 3/14/25 21:50, Joanne Koong wrote:
> > There is a race condition leading to a kernel crash from a null
> > dereference when attemping to access fc->lock in
> > fuse_uring_create_queue(). fc may be NULL in the case where another
> > thread is creating the uring in fuse_uring_create() and has set
> > fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> > reads ring->fc.
> >
> > This fix passes fc to fuse_uring_create_queue() instead of accessing it
> > through ring->fc.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands"=
)
> > ---
> >  fs/fuse/dev_uring.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index ab8c26042aa8..64f1ae308dc4 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -250,10 +250,10 @@ static struct fuse_ring *fuse_uring_create(struct=
 fuse_conn *fc)
> >       return res;
> >  }
> >
> > -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_rin=
g *ring,
> > +static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_con=
n *fc,
> > +                                                    struct fuse_ring *=
ring,
> >                                                      int qid)
> >  {
> > -     struct fuse_conn *fc =3D ring->fc;
> >       struct fuse_ring_queue *queue;
> >       struct list_head *pq;
> >
> > @@ -1088,7 +1088,7 @@ static int fuse_uring_register(struct io_uring_cm=
d *cmd,
> >
> >       queue =3D ring->queues[qid];
> >       if (!queue) {
> > -             queue =3D fuse_uring_create_queue(ring, qid);
> > +             queue =3D fuse_uring_create_queue(fc, ring, qid);
> >               if (!queue)
> >                       return err;
> >       }
>
> I wonder if we could get more issues,
> fuse_uring_register()
> {
>         struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
>         ...
>         if (qid >=3D ring->nr_queues) {
>
> ...
> }
>
> In fuse_uring_create()
> {
> ...
>         fc->ring =3D ring;
>         ring->nr_queues =3D nr_queues;
>         ring->fc =3D fc;
>         ring->max_payload_sz =3D max_payload_size;
> ...
> }
>
>
> I.e. we cannot trust any of the values assigned after fc->ring?

Seems like it, great point. I think we'll need to do the smp memory
barrier way after all then. I'll send that as v3.


> Sorry about this, I should have noticed before :(

No worries at all, I appreciate all the work you've put getting uring
into fuse :)


Thanks,
Joanne
>
>
> Thanks,
> Bernd

