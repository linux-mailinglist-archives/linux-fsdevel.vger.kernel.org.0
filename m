Return-Path: <linux-fsdevel+bounces-37517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA59F38C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9AC1892933
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03220A5C2;
	Mon, 16 Dec 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd/chQqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF820969D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372902; cv=none; b=RNQbz9wMkB0CTgSAEwdE3nlLsMyf3L46hItxr7hi92iL7Prs2srxoH1mhn7/pjxyyyMm1pXTtoyr/p+wTKRdcO2vQGwEpCZzUspvARVMar8ji8s5HRLoJ8GoYNEPKqkz4T1/nBCKwmihRuPloH0wec3dIC7qIUUp7ATmGL5hy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372902; c=relaxed/simple;
	bh=DEyDlJAG3mkgm/c2n0B6/2Or6CQQ2YOm+PizimGEcGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAE8CX4awBEwRqWxIKyMEKyHdNk4MTguzORE4sRItq3hdWImBYc2BEH4kBc1bBmITnPrwlCuuwpryDQvKB+Ay8FPGeQdKyNmkCBj0EA1CYAMT09A8vB1yLzkCrp8f8D1/VYjs2G0pw//qUthgX5Uhyeky9f96jOA95LOuo+0yZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd/chQqB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46792996074so52400841cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372899; x=1734977699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+aytey6JkyGp7Xn1Ysw42EawxVv062JOckMBTCmPB8=;
        b=nd/chQqBk1XVE2x5llefDJ9Uj3lFVlITICHqvJceLmpLUQHNDMS0dpQYztigAC/3k7
         /ZYzzEjj0O83ps0WT2KITBwIqpV/HFKLE2YUnQfn/D8hVOXmGFeR8ZszBxwVzhnwvh6p
         XZUfE8kEMrvob14s9ypyfIPeGssz4QPu38Te7vvrfpZ2EE3sA4j7bK22F22m6D0/hGkU
         Unyq4S/I+u6Se4XApWM4vedk3GDM4BGHrwGAl0R8CLHV3Q9Ut+PsmoB8mDsIh0+4OaWx
         iwFpDSni6L5FdYxQ5SODX4eFYqi0PbphRp3XzrNuy1GbsAJSGBDFQ5cmh7y07Po0eKaS
         DA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372899; x=1734977699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+aytey6JkyGp7Xn1Ysw42EawxVv062JOckMBTCmPB8=;
        b=t03Cnl0LtyzfhebDOpBQSfNZIV4DMUZ6fscCsvp0ADVArO7edKQlxAhD2WYcB9GzIC
         hhc9rokZnVVkcZFSRhDGIiPotdIwhnpGRmjXuzYNKh764k3tOn9Xp31v3uDI+UlM3Nfu
         +XUBysH7AM/XNRCN7W//viS3wCU7vBE9D9NzA7VvafhKleehtYH4999LB+3wF7YIwUbj
         iUYhjd6aKzxLknflVuR/bGPzDtkxjeRE8YPK+v+jDCvKd/J/VmR1i8JK2U5nSSrP2i2P
         sMRcXgSz550tWms5C3B/4zJhfwwwOlOy28byO1pVqmeY4DQOIHc6J75gLvpyeUtaq6iG
         khkA==
X-Forwarded-Encrypted: i=1; AJvYcCVJzs1Ttewti+bvuy5MxkY4ex/2L8zfKxLgyxq2iVr+y/Nd8F0nvSrXu68obZWwGxsG5YV9Fl0+IYmVWA6r@vger.kernel.org
X-Gm-Message-State: AOJu0YwRx+KdQCsmP+Oe0YVpsMNvt6KX5VHdFjSL7kz7f/90TBVf3R3U
	PVQXq96fefgP9AOmK19NX93TvMgBQHap/mvCP5ESHJvcCzhpb3sURKrginlRkv1GKyg/VnijLJx
	jCb96svM//jvynlNb8sA81SonuRQ=
X-Gm-Gg: ASbGncuJ4Q1jH05SAzAWkZpm5q0R4Fwfx4olvhveefihmkcUseRcCY18WWrFAtMzN8Z
	NHV1QULl1l5C89U0F5bSpWZggGv1Xov22MSZ/YTV4SBJ2Mbrh7WfcXQ==
X-Google-Smtp-Source: AGHT+IEcMy/F/biYVNrxYCifLxTsvfvdNIqM02+PB5UbsuiUd+g2pqImZ1FNr2oGx4O2enWhv7IGpN5P3SLPR8xtXqU=
X-Received: by 2002:a05:622a:144c:b0:467:73c7:9fc5 with SMTP id
 d75a77b69052e-468f8aed094mr7377311cf.23.1734372899537; Mon, 16 Dec 2024
 10:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <CAMHPp_TVTvKC4xcuSy=kHB+5r8pTa-72bAaJF+dCp8PnrK=m7A@mail.gmail.com>
In-Reply-To: <CAMHPp_TVTvKC4xcuSy=kHB+5r8pTa-72bAaJF+dCp8PnrK=m7A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Dec 2024 10:14:48 -0800
Message-ID: <CAJnrk1YK7V04cifqDXfVHBZvUhJqXrpiXUETJQ1NDvgKY4+9iQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 6:35=E2=80=AFPM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> On Fri, Dec 13, 2024 at 9:29=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is deadlocked. Currently, there's no
> > good way to detect if a server is stuck and needs to be killed manually=
.
> >
> > This commit adds an option for enforcing a timeout (in seconds) for
> > requests where if the timeout elapses without the server responding to
> > the request, the connection will be automatically aborted.
> >
> > Please note that these timeouts are not 100% precise. For example, the
> > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyon=
d
> > the requested timeout due to internal implementation, in order to
> > mitigate overhead.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h | 22 +++++++++++++
> >  fs/fuse/inode.c  | 23 ++++++++++++++
> >  3 files changed, 128 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 27ccae63495d..e97ba860ffcd 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -45,6 +45,85 @@ static struct fuse_dev *fuse_get_dev(struct file *fi=
le)
> >         return READ_ONCE(file->private_data);
> >  }
> >
> > +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req=
)
> > +{
> > +       return time_is_before_jiffies(req->create_time + fc->timeout.re=
q_timeout);
> > +}
> > +
> > +/*
> > + * Check if any requests aren't being completed by the time the reques=
t timeout
> > + * elapses. To do so, we:
> > + * - check the fiq pending list
> > + * - check the bg queue
> > + * - check the fpq io and processing lists
> > + *
> > + * To make this fast, we only check against the head request on each l=
ist since
> > + * these are generally queued in order of creation time (eg newer requ=
ests get
> > + * queued to the tail). We might miss a few edge cases (eg requests tr=
ansitioning
> > + * between lists, re-sent requests at the head of the pending list hav=
ing a
> > + * later creation time than other requests on that list, etc.) but tha=
t is fine
> > + * since if the request never gets fulfilled, it will eventually be ca=
ught.
> > + */
> > +void fuse_check_timeout(struct work_struct *work)
> > +{
> > +       struct delayed_work *dwork =3D to_delayed_work(work);
> > +       struct fuse_conn *fc =3D container_of(dwork, struct fuse_conn,
> > +                                           timeout.work);
> > +       struct fuse_iqueue *fiq =3D &fc->iq;
> > +       struct fuse_req *req;
> > +       struct fuse_dev *fud;
> > +       struct fuse_pqueue *fpq;
> > +       bool expired =3D false;
> > +       int i;
> > +
> > +       spin_lock(&fiq->lock);
> > +       req =3D list_first_entry_or_null(&fiq->pending, struct fuse_req=
, list);
> > +       if (req)
> > +               expired =3D request_expired(fc, req);
> > +       spin_unlock(&fiq->lock);
> > +       if (expired)
> > +               goto abort_conn;
> > +
> > +       spin_lock(&fc->bg_lock);
> > +       req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse_req=
, list);
> > +       if (req)
> > +               expired =3D request_expired(fc, req);
> > +       spin_unlock(&fc->bg_lock);
> > +       if (expired)
> > +               goto abort_conn;
> > +
> > +       spin_lock(&fc->lock);
> > +       if (!fc->connected) {
> > +               spin_unlock(&fc->lock);
> > +               return;
> > +       }
> > +       list_for_each_entry(fud, &fc->devices, entry) {
> > +               fpq =3D &fud->pq;
> > +               spin_lock(&fpq->lock);
>
> Can fuse_dev_release() run concurrently to this path here?
> If yes say fuse_dev_release() comes in first, grab the fpq->lock and
> splice the
> fpq->processing[i] list into &to_end and release the fpq->lock which
> unblock this
> path.
>
> Then here we start checking req off the fpq->processing[i] list which is
> getting evicted on the other side by fuse_dev_release->end_requests(&to_e=
nd);
>
> Maybe we need a cancel_delayed_work_sync() at the beginning of
> fuse_dev_release ?

Yes, fuse_dev_release() can run concurrently to this path here. If
fuse_dev_release() comes in first, grabs the fpq->lock and splices the
fpq->processing[i] lists into &to_end, then releases the fpq->lock,
and then this fuse_check_timeout() grabs the fpq->lock, it'll see no
requests on the fpq->processing[i] lists. When the requests are
spliced onto the to_end list in fuse_dev_release(), they are removed
from the &fpq->processing[i] list.

For that reason I don't think we need a cancel_delayed_work_sync() at
the beginning of fuse_dev_release(), but also a connection can have
multiple devs associated with it and the workqueue job is
per-connection and not per-device.


Thanks,
Joanne

> Thanks
> Etienne
>
> > +               req =3D list_first_entry_or_null(&fpq->io, struct fuse_=
req, list);
> > +               if (req && request_expired(fc, req))
> > +                       goto fpq_abort;
> > +
> > +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > +                       req =3D list_first_entry_or_null(&fpq->processi=
ng[i], struct fuse_req, list);
> > +                       if (req && request_expired(fc, req))
> > +                               goto fpq_abort;
> > +               }
> > +               spin_unlock(&fpq->lock);
> > +       }
> > +       spin_unlock(&fc->lock);
> > +
> > +       queue_delayed_work(system_wq, &fc->timeout.work,
> > +                          secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
> > +       return;
> > +
> > +fpq_abort:
> > +       spin_unlock(&fpq->lock);
> > +       spin_unlock(&fc->lock);
> > +abort_conn:
> > +       fuse_abort_conn(fc);
> > +}
> > +

