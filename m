Return-Path: <linux-fsdevel+bounces-37748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703349F6CBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950D016A1E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12E1FA8C0;
	Wed, 18 Dec 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcTbCBRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D01F9EC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544625; cv=none; b=Y0c89guSdPLQ0R/K3RhAveDWVqxDhCl1RLnHbNr18/RczLH9hmQG7XpHt7A4tO3DYJg4kLR45uND1tcYPo/za/eCJhmLqWizi85jPLq+U8NpC4q4D7w9kPR42xksPoPc/YntTlrwUQekjtqIkOG40JMrzsklYsyOB7xGjTo0jSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544625; c=relaxed/simple;
	bh=Aa6zTvRGA3AGk7GHgcaPzsGFSwc3m+vgvA0OxU3F99U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJtNyaylTz/hKSf3fu431uxdtLcIMN+9YPL1KaBe/3CTeYWTlfxcjCi1qYgXk+pvpgJkocjtVn1lP+g0TMjngOyhGrkncGKAJT4As7z5bdxRbJQUVFCk2lF5b9E1i2Pdw4Lo9u3q1HPTLU1ROLyraTDspPrfxdaznnUwimFxRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcTbCBRc; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46677ef6910so72366001cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734544623; x=1735149423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeAbf5fkQK1wjNIYMP5vfxIUlqu3wkzaB7y/jhluM+k=;
        b=IcTbCBRcqv1dkg/6BhfLjoxD9c82fsZS+6IH4epKm+VogchWXSWAnV4TNdg2IRSy/f
         5jvcwZht20w3M8K6f/tGyqcPyapMNNzMwoM01/N9gsibkx/9tIrBYxkwXojYVLQIT5Mh
         Zk1SZCP27YMyI6IuJ8eGaUl+f/cN8XOTak0xqke/FnE1kPS0YFo06Vo2AYKnBu09JdjG
         n5R/btGlmQ4p11wB91MhN5N5O7MABEfjxv3+e1WTgHJD/gIj/4CwzK8v7H/TlsrgvZvx
         /bjcNCY/V9M3ELIyH5J6R1V1Hf4FRbJ/gQyk+xg7JNsDK2o1xrGBLx8SuwEjZtYNjyXa
         WSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544623; x=1735149423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeAbf5fkQK1wjNIYMP5vfxIUlqu3wkzaB7y/jhluM+k=;
        b=sCzdfbpbbe+zAAzLgXIpwsYWG09zN2bTTzQRGCXQN2ZiLdtW6dva3g7W8aSyBSbeD9
         k5+x890lac9cO5fIrX09uSUF+VdSukJU2bKvYgTbqplkv1JUfh/hui3uhomijWo9pEem
         4Ayy+Q8GJ+DH4c8Kwyg8KP8xuU+qDW8Eugn0ngvvoTTNPDjhiv07JaVq0L56sHkOMFLD
         hC1yXYcf1tbtRRBloP2zBysIObDYrzszf49j6kgxJKqNBFAU1mDtpM8FReIt3HNxi99e
         kqyZE4axufmKWzvLA2ub5Wl+Z6QX8p/a1NiP8vc/pZH3kgIVyiIMGzMzDqLUqjLtp2uO
         YGlA==
X-Forwarded-Encrypted: i=1; AJvYcCVnvrEvUQqD9lZkQoGtHFLgYXfg1YcijrXg978dfJ2T4Xb6yV0pjmgZaNvR95jl6SwO9bxzOvNI6E/y+1P1@vger.kernel.org
X-Gm-Message-State: AOJu0YznJPmggSS3UqVkTFBw2T2NsRFmNbo4xM9ZVjsjUyidIHLYqtBo
	22cUZB+1Gf0lD1zbvS8u4elTB81DGPTunycXORyxHKFkz3P3uz1WnecA5rXUj3VQvmy5bmWHQDG
	8CSlLtNmmSkJKgeEZbwkNmvq9T64=
X-Gm-Gg: ASbGnct3eRMGeXZEbD5GoyhlA5nVbM+4vJZ97xChnUrl4faGwiqGkVRgM1YsWdHJv9a
	yPAFCY1kwBDkPirwVUBI21IVCCa3vA1Dufu/ehjw=
X-Google-Smtp-Source: AGHT+IGKNHRTl0p4kJMuoMUgIMLoY1xhIYqQWO0y4IHPIdwc9tJxrBhMXEJ8COMr6E0MsB21tkiDX9Ev5GiKxWu+pwY=
X-Received: by 2002:a05:622a:1451:b0:466:9bc4:578 with SMTP id
 d75a77b69052e-46908debacfmr52677841cf.22.1734544622664; Wed, 18 Dec 2024
 09:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
 <CAJnrk1a+hxtv5kiaEJu-m-C35E8Bbg-ehd8yRjc1fBd2Amm8Ug@mail.gmail.com>
 <CAMHPp_Srx+u9XN9SLNe58weMKnUoq9XbN9sNHBJAn9eiA0kYnw@mail.gmail.com>
 <CAJnrk1YBYYV=wazzTfMEQcd8vaSkYAGraHz2fHoJJaVibybxaQ@mail.gmail.com>
 <CAMHPp_TkRV_izpSqzboz7YnWVijxTwJyQao6iZ5cczDXHXmN8g@mail.gmail.com>
 <CAJnrk1abKAr=V+JOSpHSQGrjYE7b_LDCLoBkCJLnF6-Egp+kXg@mail.gmail.com>
 <CAMHPp_RO_Bqe9mvtMntJsAb+JjwDercPT8NsT5W3e=_gqa_4AQ@mail.gmail.com>
 <CAJnrk1bsMfvtTdAhp4JsB5V-8YrrBLjmrvJJzVDyMQWJWNTOig@mail.gmail.com> <CAMHPp_S51EtFtX_W9F3XdRwiwOVGzK2P8=1NNSFxamyr0a3XyA@mail.gmail.com>
In-Reply-To: <CAMHPp_S51EtFtX_W9F3XdRwiwOVGzK2P8=1NNSFxamyr0a3XyA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Dec 2024 09:56:51 -0800
Message-ID: <CAJnrk1bVqMRB7QB=rFf3aNEdjgFaOGbOc9Evsnrj7b+2NAWCsA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 7:32=E2=80=AFAM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> On Tue, Dec 17, 2024 at 3:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Tue, Dec 17, 2024 at 12:02=E2=80=AFPM Etienne Martineau
> > <etmartin4313@gmail.com> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 8:26=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Mon, Dec 16, 2024 at 2:09=E2=80=AFPM Etienne Martineau
> > > > <etmartin4313@gmail.com> wrote:
> > > > >
> > > > > On Mon, Dec 16, 2024 at 1:21=E2=80=AFPM Joanne Koong <joannelkoon=
g@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 16, 2024 at 9:51=E2=80=AFAM Etienne Martineau
> > > > > > <etmartin4313@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 16, 2024 at 12:32=E2=80=AFPM Joanne Koong <joanne=
lkoong@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayto=
n@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > > > > > > > > > There are situations where fuse servers can become unre=
sponsive or
> > > > > > > > > > stuck, for example if the server is deadlocked. Current=
ly, there's no
> > > > > > > > > > good way to detect if a server is stuck and needs to be=
 killed manually.
> > > > > > > > > >
> > > > > > > > > > This commit adds an option for enforcing a timeout (in =
seconds) for
> > > > > > > > > > requests where if the timeout elapses without the serve=
r responding to
> > > > > > > > > > the request, the connection will be automatically abort=
ed.
> > > > > > > > > >
> > > > > > > > > > Please note that these timeouts are not 100% precise. F=
or example, the
> > > > > > > > > > request may take roughly an extra FUSE_TIMEOUT_TIMER_FR=
EQ seconds beyond
> > > > > > > > > > the requested timeout due to internal implementation, i=
n order to
> > > > > > > > > > mitigate overhead.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > > > > > > > >  fs/fuse/fuse_i.h | 22 +++++++++++++
> > > > > > > > > >  fs/fuse/inode.c  | 23 ++++++++++++++
> > > > > > > > > >  3 files changed, 128 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > > > > > > index 27ccae63495d..e97ba860ffcd 100644
> > > > > > > > > > --- a/fs/fuse/dev.c
> > > > > > > > > > +++ b/fs/fuse/dev.c
> > > > > > > > > >
> > > > > > > > > >  static struct fuse_req *fuse_request_alloc(struct fuse=
_mount *fm, gfp_t flags)
> > > > > > > > > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_=
conn *fc)
> > > > > > > > > >               spin_unlock(&fc->lock);
> > > > > > > > > >
> > > > > > > > > >               end_requests(&to_end);
> > > > > > > > > > +
> > > > > > > > > > +             if (fc->timeout.req_timeout)
> > > > > > > > > > +                     cancel_delayed_work(&fc->timeout.=
work);
> > > > > > > > >
> > > > > > > > > As Sergey pointed out, this should be a cancel_delayed_wo=
rk_sync(). The
> > > > > > > > > workqueue job can still be running after cancel_delayed_w=
ork(), and
> > > > > > > > > since it requeues itself, this might not be enough to kil=
l it
> > > > > > > > > completely.
> > > > > > > >
> > > > > > > > I don't think we need to synchronously cancel it when a con=
nection is
> > > > > > > > aborted. The fuse_check_timeout() workqueue job can be simu=
ltaneously
> > > > > > > > running when cancel_delayed_work() is called and can requeu=
e itself,
> > > > > > > > but then on the next trigger of the job, it will check whet=
her the
> > > > > > > > connection was aborted (eg the if (!fc->connected)... retur=
n; lines in
> > > > > > > > fuse_check_timeout()) and will not requeue itself if the co=
nnection
> > > > > > > > was aborted. This seemed like the simplest / cleanest appro=
ach to me.
> > > > > > > >
> > > > > > > Is there a scenario where the next trigger of the job derefer=
ence
> > > > > > > struct fuse_conn *fc which already got freed because say the =
FUSE
> > > > > > > server has terminated?
> > > > > >
> > > > > > This isn't possible because the struct fuse_conn *fc gets freed=
 only
> > > > > > after the call to "cancel_delayed_work_sync(&fc->timeout.work);=
" that
> > > > > > synchronously cancels the workqueue job. This happens in the
> > > > > > fuse_conn_put() function.
> > > > > >
> > > > > cancel_delayed_work_sync() won't prevent the work from re-queuing
> > > > > itself if it's already running.
> > > > > I think we need some flag like Sergey pointed out here
> > > > >   https://lore.kernel.org/linux-fsdevel/CAMHPp_S2ANAguT6fYfNcXjTZ=
xU14nh2Zv=3D5=3D8dG8qUnD3F8e7A@mail.gmail.com/T/#m543550031f31a9210996ccf81=
5d5bc2a4290f540
> > > > > Maybe we don't requeue when fc->count becomes 0?
> > > >
> > > > The connection will have been aborted when cancel_delayed_work_sync=
()
> > > > is called (otherwise we will have a lot of memory crashes/leaks). I=
f
> > > > the fuse_check_timeout() workqueue job is running while
> > > > cancel_delayed_work_sync() is called, there's the "if (!fc->connect=
ed)
> > > > { ... return; }" path that returns and avoids requeueing.
> > > >
> > > I ran some tests and from what I see, calling
> > > cancel_delayed_work_sync() on a workqueue that is currently running
> > > and re-queueing itself is enough to kill it completely. For that
> > > reason I believe we don't even need the cancel_delayed_work() in
> > > fuse_abort_conn() because everything is taken care of by
> > > fuse_conn_put();
> >
> > I think the cancel_delayed_work() in fuse_abort_conn() would still be
> > good to have. There are some instances where the connection gets
> > aborted but the connection doesn't get freed (eg user forgets to
> > unmount the fuse filesystem or the unmount only happens a lot later).
> > When the connection is aborted however, this will automatically cancel
> > the workqueue job on the next run (on the next run, the job won't
> > requeue itself if it sees that the connection was aborted) so we
> > technically don't need the cancel_delayed_work() because of this, but
> > imo it'd be good to minimize the number of workqueue jobs that get run
> > and canceling it asap is preferable.
> >
> Ok, it makes sense.
> Also in fuse_check_timeout() does it make sense to leverage
> fc->num_waiting to save some cycle in the function?
> Something like:
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e97ba860ffcd..344af61124f4 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -97,6 +97,10 @@ void fuse_check_timeout(struct work_struct *work)
>                 spin_unlock(&fc->lock);
>                 return;
>         }
> +       if (!fc->num_waiting){
> +               spin_unlock(&fc->lock);
> +               goto out;
> +       }
>         list_for_each_entry(fud, &fc->devices, entry) {
>                 fpq =3D &fud->pq;
>                 spin_lock(&fpq->lock);
> @@ -113,6 +117,7 @@ void fuse_check_timeout(struct work_struct *work)
>         }
>         spin_unlock(&fc->lock);
>
> +out:
>         queue_delayed_work(system_wq, &fc->timeout.work,
>                            secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
>         return;
>

I like this idea and it makes sense to me. I think "fc->num_waiting"
needs to be atomically read though, which doesn't depend on holding
the fc lock, so we could do this check at the top of the function
before grabbing the fiq lock and checking any expirations. I'll
incorporate this into v11.


Thanks,
Joanne

> thanks
> Etienne
>
> >
> > Thanks,
> > Joanne
> >

