Return-Path: <linux-fsdevel+bounces-25816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA5950C67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96705285015
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295181A3BA0;
	Tue, 13 Aug 2024 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WozYlAm2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CA1A38F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574338; cv=none; b=aC+zeP4AfSjRbBmUro1NLNwUUXLNbFLwmQHStbeM3c7Yt3GWZxURp7mzei+x96i+7RbAzf7hwRIU2FFueI6Haphd46k+Pv8vGrERu+fhKkkWzHghuH7486KfrMS6of2P9KdNgRGoTKcUk/Fa1V0Jfwmf0lJhY/9Mn5ukH2LWhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574338; c=relaxed/simple;
	bh=QLBms9jm35gcWLy69kgtiXdP9NCp+gHBrxBGtJCSUQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsZB+odDF3U/0gkxHiyXIwKpolwlmXmALugo+6W4SmYKIJsZBZ3wcR0UkS5rxCC2r9nfAEHrbeY1YbymGA/XfXqcouOGpU09zkTFXE0uZrSBYQunopsRTvX06U+NA3PNegemiL1nEnRwt3eXzJDew7bm7IANwfCkVvHSR/Bl5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WozYlAm2; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44ff99fcd42so31597391cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723574336; x=1724179136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl7nqGi3lOoOY6/lgGA3zFM73EovJBpH/t+hkyv7UI8=;
        b=WozYlAm2qbm3lx/QZkkaDxjR5sJ/MuzMp75nCFucorEFYx/kOetBJZBpB/uSY9yCqS
         TUKHNXmYjG7ny3KnmbHyGg5d/fcP4sFmtbvrLV9laNQDFiBquskNcYuxsciWmMQ0vbgv
         9mGHuvnSn/5q0gZmMBOMGG35uo1gDWFnG1UBuS8c3AMlJjvXmhjnuabzhK7t5wbzjd0y
         Yhd/v93M88fUZHHXAfuijI0BhOyLFNNJrAa/RVzswnlYRsokiKPRu9ejeZhP9PkiFv9L
         V8PlCnzVWlsKSYjIw9K9rVKE8ESiLrIzdRlQFHGL+9AGXtQ8Gbdc/f4wNBG5QUIFOu5D
         7n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723574336; x=1724179136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vl7nqGi3lOoOY6/lgGA3zFM73EovJBpH/t+hkyv7UI8=;
        b=kVeTKYcwybh3NLKwYvqbgTMuxddJMeXVWBWP9kYNBgonuDqCxYtD3WAjHl0fGtmXtx
         vts1Fgkl9MwYGgc8rH7/ADd5lzo+O3VfL/WvdMZgGYpFbgZ9xpfMTCmEBvQpjSC6o/NJ
         WwraRUnJtUFbWvsjBXQ7qwDtszHGxBtUFdzTes8sijlsHbPO4+sXhAfvIfXgQV5Wm+4L
         lRKJtWs3RDvO/pCGr8iYkXwHH5pw7VMxifTosdDwuZ6sXKAatlWfmiJB9zwr6sSd/3Ky
         XIbNrq+Sx80RIvD3JNpCoMsYAyxhMVUrMBoOtacPeNXqXnayvFsqA06w6+R+BQFIx3e8
         Jqag==
X-Forwarded-Encrypted: i=1; AJvYcCUgtFejnnjHunx6a4H9PL4OjVmCNSMo+YQ8p6nraONBo2N/y81CDs1kN3333q2WW7TZ0mmrEUuAmvojrkVHTo8uXqZdVD+/pZv0QcMTdA==
X-Gm-Message-State: AOJu0YytKnwVkQN0HdzBPr4MpCeT36LmkfpXIvYnjN4C7T0UTnwJsAL+
	QcP1cD/I9mmOfgC8WIbRrKNEYFkLQMJ6+VGUdQ8C7ADNXtpj1jkKP0q2L85qBxkDfkpgsAYK7fE
	pGdI4PeQ/NbLrcnR7OhoRg3S2aRk=
X-Google-Smtp-Source: AGHT+IHNEn9NZiHYBr5PA5hASKl9WuMjPkM8GjE3iQ3ymfjAuPYlUMcsfxvIKUXEL1UA71PG9ueV1PPlAMgi+N4kwtg=
X-Received: by 2002:a05:622a:1f98:b0:44f:f06a:d6f5 with SMTP id
 d75a77b69052e-4535bb370dcmr2900581cf.36.1723574335793; Tue, 13 Aug 2024
 11:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-2-joannelkoong@gmail.com> <3754bc57-a887-4ac1-86cd-7858bacdb595@fastmail.fm>
In-Reply-To: <3754bc57-a887-4ac1-86cd-7858bacdb595@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 13 Aug 2024 11:38:44 -0700
Message-ID: <CAJnrk1ae7V01GwegJBfGcUPUBS0Exg1bXsy=d05LEdSbcdryNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:04=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/8/24 21:01, Joanne Koong wrote:
>
> > @@ -1951,9 +2115,10 @@ static ssize_t fuse_dev_do_write(struct fuse_dev=
 *fud,
> >               goto copy_finish;
> >       }
> >
> > +     __fuse_get_request(req);
> > +
> >       /* Is it an interrupt reply ID? */
> >       if (oh.unique & FUSE_INT_REQ_BIT) {
> > -             __fuse_get_request(req);
> >               spin_unlock(&fpq->lock);
> >
> >               err =3D 0;
> > @@ -1969,6 +2134,13 @@ static ssize_t fuse_dev_do_write(struct fuse_dev=
 *fud,
> >               goto copy_finish;
> >       }
> >
> > +     if (test_and_set_bit(FR_FINISHING, &req->flags)) {
> > +             /* timeout handler is already finishing the request */
> > +             spin_unlock(&fpq->lock);
> > +             fuse_put_request(req);
> > +             goto copy_finish;
> > +     }
> > +
>
> It should be safe already with the FR_FINISHING flag and
> timer_delete_sync, but maybe we could unset req->fpq here to make that
> easier to read and to be double sure?

Sure, I can add this into v4. I'll add a comment as well explaining
that it's not necessary but is here as a safeguard to ensure that the
timeout handler is a no-op.

>
> >       clear_bit(FR_SENT, &req->flags);
> >       list_move(&req->list, &fpq->io);
> >       req->out.h =3D oh;
> > @@ -1995,6 +2167,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev =
*fud,
> >       spin_unlock(&fpq->lock);
> >
> >       fuse_request_end(req);
> > +     fuse_put_request(req);
> >  out:
> >       return err ? err : nbytes;
> >
> > @@ -2260,13 +2433,21 @@ int fuse_dev_release(struct inode *inode, struc=
t file *file)
> >       if (fud) {
> >               struct fuse_conn *fc =3D fud->fc;
> >               struct fuse_pqueue *fpq =3D &fud->pq;
> > +             struct fuse_req *req;
> >               LIST_HEAD(to_end);
> >               unsigned int i;
> >
> >               spin_lock(&fpq->lock);
> >               WARN_ON(!list_empty(&fpq->io));
> > -             for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++)
> > +             for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > +                     /*
> > +                      * Set the req error here so that the timeout
> > +                      * handler knows it's being released
> > +                      */
> > +                     list_for_each_entry(req, &fpq->processing[i], lis=
t)
> > +                             req->out.h.error =3D -ECONNABORTED;
> >                       list_splice_init(&fpq->processing[i], &to_end);
> > +             }
> >               spin_unlock(&fpq->lock);
> >
> >               end_requests(&to_end);
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index f23919610313..2b616c5977b4 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -375,6 +375,8 @@ struct fuse_io_priv {
> >   * FR_FINISHED:              request is finished
> >   * FR_PRIVATE:               request is on private list
> >   * FR_ASYNC:         request is asynchronous
> > + * FR_FINISHING:     request is being finished, by either the timeout =
handler
> > + *                   or the reply handler
> >   */
> >  enum fuse_req_flag {
> >       FR_ISREPLY,
> > @@ -389,6 +391,7 @@ enum fuse_req_flag {
> >       FR_FINISHED,
> >       FR_PRIVATE,
> >       FR_ASYNC,
> > +     FR_FINISHING,
> >  };
> >
> >  /**
> > @@ -435,6 +438,12 @@ struct fuse_req {
> >
> >       /** fuse_mount this request belongs to */
> >       struct fuse_mount *fm;
> > +
> > +     /** page queue this request has been added to */
> > +     struct fuse_pqueue *fpq;
>
> Processing queue?

You're right, this should be "processing queue", I'll make this change in v=
4.


Thanks,
Joanne
>
>
> Thanks,
> Bernd

