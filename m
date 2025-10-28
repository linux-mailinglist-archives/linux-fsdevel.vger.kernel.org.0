Return-Path: <linux-fsdevel+bounces-65967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59FC176DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE922355AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 23:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96837306B3D;
	Tue, 28 Oct 2025 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaDhf5Yv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B62DCF50
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695820; cv=none; b=okGvF6bR6PLvhg0f1dqKMUHVxChcGnSN5SsmSFixRBHhTsFphbZItMQvgxQUQCnF0PiiJ2Y2TDhqbfHFcdYFpYTEjsAPNwLOu7IQvX5mjUE4R9YOyV21WCGAv53BwYYs6oHfR3UEMGPuVagpdod5eFEVr3dwf6AacA7qR8/f77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695820; c=relaxed/simple;
	bh=W9iwwWMdcHDdc1sWjWQNoTO6cfNmSIQglhxMo7bS5AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9fj/7gUYdHcUVOizet1uEgTcLJ2NDVKZfRLgtGI1mSenYIU5vSjy/FgxUCYO6ii5lDST5SNQ0v+RV6I6Oo31HIXs5hevGJZzoDLsDU4z9H3KDocfPGevp5+Pa7ztMAgDyYgskdiWwKif9FJtH2BJsccgqkmbhvGZeJ4PQq0xlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaDhf5Yv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed101e8496so9793131cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761695817; x=1762300617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pOE73Fi34Qqb5u5P7wGKtluv5/pQiFWSPE20X2L4m8=;
        b=NaDhf5YvaHBBszuSbl6vzf/rDNBs1lI04mWI7LbmiWCbgBLZKg/oJ6jEt7IS6+HVLM
         exSf36js8IthucltDZ9l6ACuwzEVs2OHYBLX2amouoSqVzCCI8TBSoAdEG6GJdyJXScW
         jh6fwTBVNKGyFOhZicp0zBYMAVVmh5YxZs3Ds/jbbEjtJw53KIgVys0uaR6RKZz5CTuk
         87qWOBy+uAZMIVSAkw+GkUOPwOxgvYYRxFKQ2GGRxf2h48Z1Ma37c+L3PhXwVUSGwCga
         ZH6NQOS7y3lh/8igK0AW617X9/Mm7wrGA0Jjx4RaSuyTOPakiwz/FWHvrnQcy7KjADm4
         kVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695817; x=1762300617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pOE73Fi34Qqb5u5P7wGKtluv5/pQiFWSPE20X2L4m8=;
        b=nRW52R8ovfYMbGkNcEVN9MvpDNu71s4gRkX0OBwzNKgrwtrPEXwe5g7EhJ7icQHIhg
         Vae6q+Pp0ZUY0ONrSxWEeHQJQTwhV8k3lJNgFd9G4LTJpfHjo9qNGKCY5+6I1Rdg7fDx
         Ymv46R2PiQ1o8la8UaDtGyGlGmc/EihGcZ9eMtJRFYaSjh5JpKlxBRQyPmB3aK8hTnr7
         kFAWrKfO2bid+zMzNhin0M4koES3tsx9hjwGpNKp9rt+ie6S8FcDuv9kEjovPmblGOYk
         inwLIfwcsUWsxzcKNQhozzYfJ/HiSkHyjTPeiGWCH8UizOJJCmur6jq9qPUTwXozZJNo
         +sRA==
X-Forwarded-Encrypted: i=1; AJvYcCXVaIVIUoAE5KSHZIU5k0aNEXc+e82+9cg1pvZqfpfkvJ8cEH4ARp+TugHuuHxdjE2vaz3ZGXj6mGU7Bsfn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xr8PhpUedqvlEy+GI4I906+7HuPQG+m+fWJRW0KP8lIp0mW5
	bK6soQat0kR4RU4stXpSFBJk6l8XrquHbwsU16j1Vq2Z8xOa1XlbYaIE6+wsKcGV17/UFRq1ock
	aYN9z4G7DVR1JuHw91Ntx8Dtj7NQ0ZYU=
X-Gm-Gg: ASbGncsBlyDmZEWI6Zt8vDsoiXq0NHL8OhvqhcuxmDmQOlYJePOZlVDDBD2aDNMZUT4
	HV3lJg6m/m3WTuzUGapfha0L2hlv1fLM/Id6UdkxR/ic529a3Xht9YlqR+/N/0HyVCsYk4mt8/D
	7Z9zQyFXjKCLEAW2O+re3oksQBCI42+6fJl5baOOzryCFtI823JHNf6x79hGlXUyOx3OinNFpVs
	LUn+Ktf3ZLVsS17xbcUl8XxDB8/H+HXk2D1hOFNOlQ35U2gGwi00tnDDxL5d2s4X4QeNNsCVET2
	I6o33TWAYjcEZdY=
X-Google-Smtp-Source: AGHT+IGGQRVKtCo9frXtPGYlTmpm2a6jn9Bsx2tQmOI3tfjJkE0vFSCB1IJsWD4yEWFZUuLhM///Ci2Yn6PDtu67s4M=
X-Received: by 2002:ac8:7c43:0:b0:4e8:aa11:5869 with SMTP id
 d75a77b69052e-4ed15c3ae33mr13215301cf.70.1761695816975; Tue, 28 Oct 2025
 16:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
 <20251027222808.2332692-7-joannelkoong@gmail.com> <CADUfDZozW7s87j5AgKCHdZKwtR20kwj4L68D5kusbo9GPefHfg@mail.gmail.com>
In-Reply-To: <CADUfDZozW7s87j5AgKCHdZKwtR20kwj4L68D5kusbo9GPefHfg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 28 Oct 2025 16:56:45 -0700
X-Gm-Features: AWmQ_bmkacMH26mb-4zgiHr6DjzINP4yBWOEkOP7JkCVKJobSBLtH4uTRuhR7sE
Message-ID: <CAJnrk1aiUCt8vadwUWQBGe_kU+Vj_Ta7W0ZGe+RWn=smasJcOA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] fuse: add user_ prefix to userspace headers and
 payload fields
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	bschubert@ddn.com, asml.silence@gmail.com, io-uring@vger.kernel.org, 
	xiaobing.li@samsung.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:32=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Oct 27, 2025 at 3:29=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Rename the headers and payload fields to user_headers and user_payload.
> > This makes it explicit that these pointers reference userspace addresse=
s
> > and prepares for upcoming fixed buffer support, where there will be
> > separate fields for kernel-space pointers to the payload and headers.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c   | 17 ++++++++---------
> >  fs/fuse/dev_uring_i.h |  4 ++--
> >  2 files changed, 10 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index d96368e93e8d..c814b571494f 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -585,11 +585,11 @@ static void __user *get_user_ring_header(struct f=
use_ring_ent *ent,
> >  {
> >         switch (type) {
> >         case FUSE_URING_HEADER_IN_OUT:
> > -               return &ent->headers->in_out;
> > +               return &ent->user_headers->in_out;
> >         case FUSE_URING_HEADER_OP:
> > -               return &ent->headers->op_in;
> > +               return &ent->user_headers->op_in;
> >         case FUSE_URING_HEADER_RING_ENT:
> > -               return &ent->headers->ring_ent_in_out;
> > +               return &ent->user_headers->ring_ent_in_out;
> >         }
> >
> >         WARN_ON_ONCE(1);
> > @@ -645,7 +645,7 @@ static int fuse_uring_copy_from_ring(struct fuse_ri=
ng *ring,
> >         if (err)
> >                 return err;
> >
> > -       err =3D import_ubuf(ITER_SOURCE, ent->payload, ring->max_payloa=
d_sz,
> > +       err =3D import_ubuf(ITER_SOURCE, ent->user_payload, ring->max_p=
ayload_sz,
> >                           &iter);
> >         if (err)
> >                 return err;
> > @@ -674,7 +674,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring=
 *ring, struct fuse_req *req,
> >                 .commit_id =3D req->in.h.unique,
> >         };
> >
> > -       err =3D import_ubuf(ITER_DEST, ent->payload, ring->max_payload_=
sz, &iter);
> > +       err =3D import_ubuf(ITER_DEST, ent->user_payload, ring->max_pay=
load_sz, &iter);
> >         if (err) {
> >                 pr_info_ratelimited("fuse: Import of user buffer failed=
\n");
> >                 return err;
> > @@ -710,8 +710,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring=
 *ring, struct fuse_req *req,
> >
> >         ent_in_out.payload_sz =3D cs.ring.copied_sz;
> >         return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
> > -                                  &ent_in_out,
> > -                                  sizeof(ent_in_out));
> > +                                  &ent_in_out, sizeof(ent_in_out));
>
> nit: looks like an unnecessary formatting change here. Either drop it
> or move it to the earlier commit that added these lines?

I will move this to the earlier commit that added this.

Thanks,
Joanne
>
> Best,
> Caleb
>
> >  }
> >
> >  static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
> > @@ -1104,8 +1103,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *c=
md,
> >         INIT_LIST_HEAD(&ent->list);
> >
> >         ent->queue =3D queue;
> > -       ent->headers =3D iov[0].iov_base;
> > -       ent->payload =3D iov[1].iov_base;
> > +       ent->user_headers =3D iov[0].iov_base;
> > +       ent->user_payload =3D iov[1].iov_base;
> >
> >         atomic_inc(&ring->queue_refs);
> >         return ent;
> > diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> > index 51a563922ce1..381fd0b8156a 100644
> > --- a/fs/fuse/dev_uring_i.h
> > +++ b/fs/fuse/dev_uring_i.h
> > @@ -39,8 +39,8 @@ enum fuse_ring_req_state {
> >  /** A fuse ring entry, part of the ring queue */
> >  struct fuse_ring_ent {
> >         /* userspace buffer */
> > -       struct fuse_uring_req_header __user *headers;
> > -       void __user *payload;
> > +       struct fuse_uring_req_header __user *user_headers;
> > +       void __user *user_payload;
> >
> >         /* the ring queue that owns the request */
> >         struct fuse_ring_queue *queue;
> > --
> > 2.47.3
> >

