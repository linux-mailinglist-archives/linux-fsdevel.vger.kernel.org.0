Return-Path: <linux-fsdevel+bounces-37738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3592F9F6A1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 16:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C8A7A3704
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0265139579;
	Wed, 18 Dec 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2RZmPxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFC983CD2
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535957; cv=none; b=WgftWf8pTYpPQOUMTs+D5fdxWfN2wF1FNlPHG+IB3sVHdTHrBJzpXf/Cmi3lRd1GYaBk2FmPKNU8bX0bluWrH9tNADn8AUj9QnDCAgKaNrjGGtRcRrBNRBSAObfIbAoc7DiJdw6CVsnV/xqldwk580C+GSIM64kZxxEZX0ogh48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535957; c=relaxed/simple;
	bh=0EGMseKQ9kx8vVueDFKuCrNxD0SMS7ens3WJVVlctIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKWkq7kRji8iUo/CpYeaweTBuaeuqdH64HoC39vtsZqnjm6R+AGM81GaT3q0w9PaneLRww61Z5zWsOdN69a4NEuyIcoR1KLImj938J0WVVTXIxwS6B+03Fqtc6TF3WeVdpBUbr+idWzHOO8X5qGw2pAGRRRvivb8riAYbjpna/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2RZmPxX; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4678cd314b6so64901001cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 07:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734535954; x=1735140754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWsiw9I5pv4FapkM3jVZP2M6Eu9YyFuGhG4KVmdnWeQ=;
        b=D2RZmPxX38ynrqXfqiuDRaHGkSkuK+/gmkunf+Ee7kzvPN/ZrEoPg0+UQ7AszdpNqW
         qGQ2S/ODFA9cswcWvvWI3s28qsqFB3Xwo/lIVqEs8LOgSKGiqkWUiEZlmc9tGjSVHHBS
         On0Yrle105AE/oSllD45diEJ3bCHkDFc6A3EBAZ4a3eJf/w3yUkGcLyHLw/rKFxxD31x
         JeB8YzWt9DLWvqv5WQqCiL/8xixEAtJugj612YY6HkwzxUwqWUyViP4fb3zOMwNy4Vhb
         rVZrV1Yo+CEBC/YS+1p+vmkzVle2zxTuo1UIIbbeRKN8XSEclBIh//7aZu4p+tI7qvUj
         FMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734535954; x=1735140754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWsiw9I5pv4FapkM3jVZP2M6Eu9YyFuGhG4KVmdnWeQ=;
        b=baRHrk8s12bE0SVo5D9IesvA0KOUgKMSxiJ/h9s1PEhQ05s+jiLiflhYCWSNe8qcB4
         j03b5jTrqYaxPga7MBD69dJI4DZv1uMZCE8mh4kCXqM72BNmCdlWBungo6DvlC2qBQqr
         aSR9A28nULHW5/zMMdLeRZQuLHqwECks95G7MFhSAi3DM/PyZCZIuET/484g/1nLOdht
         hl+6xslEKwhWPMY4pVZoM8JHcHitnH4IlYqzRjvBpIJWpaOqAdG7E8s4apYweFFz8uGq
         9JQtc4R8rXNlS7hrNPDvAndMSdZtm47HbaSER5yEdfAROj44bC0DRhCLhnJFey02opm0
         LGaw==
X-Forwarded-Encrypted: i=1; AJvYcCVP/FLFgUhA65JWRNXa0NTxfqS4+3CrElrCj61eLj1QM94L+d+3UIFDe8WVDsI0rlRvck+5o50Yko/o2PUE@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMcYnFTq+YHgfdyAYn28ZadAIT5H18//Oe9KLymg2NQwaIiFi
	APpF9XIc+Nc5ljHqRuUqQAoKHOMyrY2lno1Cmw8ExX390u4/pyBrJn29rdcCk66X0CNqF1kc3mp
	daQcr0ds0a6RI4jOmQp5g2VhnINA=
X-Gm-Gg: ASbGncvOZuoWPdzirLHT+Ec7aQt2Z/hSCaPbnyW8Iy8Gs8iBvYAI5CU06j3rCMhOiZI
	GvkreZ3rlQgZav2zIfqbVBF2YWh157IzKbkuVpEA=
X-Google-Smtp-Source: AGHT+IH1A+S/2W/40HsNaeSVcEykyO5/hZRlqQNZoF0YIahsypXIjdYJLxu1cxsTPXAHbQYlkVVpjuI9GUnEW4eDi2I=
X-Received: by 2002:a05:622a:15c9:b0:467:57c8:ca31 with SMTP id
 d75a77b69052e-46908ecc83fmr58456561cf.46.1734535954357; Wed, 18 Dec 2024
 07:32:34 -0800 (PST)
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
 <CAMHPp_RO_Bqe9mvtMntJsAb+JjwDercPT8NsT5W3e=_gqa_4AQ@mail.gmail.com> <CAJnrk1bsMfvtTdAhp4JsB5V-8YrrBLjmrvJJzVDyMQWJWNTOig@mail.gmail.com>
In-Reply-To: <CAJnrk1bsMfvtTdAhp4JsB5V-8YrrBLjmrvJJzVDyMQWJWNTOig@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Wed, 18 Dec 2024 10:32:23 -0500
Message-ID: <CAMHPp_S51EtFtX_W9F3XdRwiwOVGzK2P8=1NNSFxamyr0a3XyA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, Dec 17, 2024 at 12:02=E2=80=AFPM Etienne Martineau
> <etmartin4313@gmail.com> wrote:
> >
> > On Mon, Dec 16, 2024 at 8:26=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 2:09=E2=80=AFPM Etienne Martineau
> > > <etmartin4313@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 16, 2024 at 1:21=E2=80=AFPM Joanne Koong <joannelkoong@=
gmail.com> wrote:
> > > > >
> > > > > On Mon, Dec 16, 2024 at 9:51=E2=80=AFAM Etienne Martineau
> > > > > <etmartin4313@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 16, 2024 at 12:32=E2=80=AFPM Joanne Koong <joannelk=
oong@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayton@=
kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > > > > > > > > There are situations where fuse servers can become unresp=
onsive or
> > > > > > > > > stuck, for example if the server is deadlocked. Currently=
, there's no
> > > > > > > > > good way to detect if a server is stuck and needs to be k=
illed manually.
> > > > > > > > >
> > > > > > > > > This commit adds an option for enforcing a timeout (in se=
conds) for
> > > > > > > > > requests where if the timeout elapses without the server =
responding to
> > > > > > > > > the request, the connection will be automatically aborted=
.
> > > > > > > > >
> > > > > > > > > Please note that these timeouts are not 100% precise. For=
 example, the
> > > > > > > > > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ=
 seconds beyond
> > > > > > > > > the requested timeout due to internal implementation, in =
order to
> > > > > > > > > mitigate overhead.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  fs/fuse/fuse_i.h | 22 +++++++++++++
> > > > > > > > >  fs/fuse/inode.c  | 23 ++++++++++++++
> > > > > > > > >  3 files changed, 128 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > > > > > index 27ccae63495d..e97ba860ffcd 100644
> > > > > > > > > --- a/fs/fuse/dev.c
> > > > > > > > > +++ b/fs/fuse/dev.c
> > > > > > > > >
> > > > > > > > >  static struct fuse_req *fuse_request_alloc(struct fuse_m=
ount *fm, gfp_t flags)
> > > > > > > > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_co=
nn *fc)
> > > > > > > > >               spin_unlock(&fc->lock);
> > > > > > > > >
> > > > > > > > >               end_requests(&to_end);
> > > > > > > > > +
> > > > > > > > > +             if (fc->timeout.req_timeout)
> > > > > > > > > +                     cancel_delayed_work(&fc->timeout.wo=
rk);
> > > > > > > >
> > > > > > > > As Sergey pointed out, this should be a cancel_delayed_work=
_sync(). The
> > > > > > > > workqueue job can still be running after cancel_delayed_wor=
k(), and
> > > > > > > > since it requeues itself, this might not be enough to kill =
it
> > > > > > > > completely.
> > > > > > >
> > > > > > > I don't think we need to synchronously cancel it when a conne=
ction is
> > > > > > > aborted. The fuse_check_timeout() workqueue job can be simult=
aneously
> > > > > > > running when cancel_delayed_work() is called and can requeue =
itself,
> > > > > > > but then on the next trigger of the job, it will check whethe=
r the
> > > > > > > connection was aborted (eg the if (!fc->connected)... return;=
 lines in
> > > > > > > fuse_check_timeout()) and will not requeue itself if the conn=
ection
> > > > > > > was aborted. This seemed like the simplest / cleanest approac=
h to me.
> > > > > > >
> > > > > > Is there a scenario where the next trigger of the job dereferen=
ce
> > > > > > struct fuse_conn *fc which already got freed because say the FU=
SE
> > > > > > server has terminated?
> > > > >
> > > > > This isn't possible because the struct fuse_conn *fc gets freed o=
nly
> > > > > after the call to "cancel_delayed_work_sync(&fc->timeout.work);" =
that
> > > > > synchronously cancels the workqueue job. This happens in the
> > > > > fuse_conn_put() function.
> > > > >
> > > > cancel_delayed_work_sync() won't prevent the work from re-queuing
> > > > itself if it's already running.
> > > > I think we need some flag like Sergey pointed out here
> > > >   https://lore.kernel.org/linux-fsdevel/CAMHPp_S2ANAguT6fYfNcXjTZxU=
14nh2Zv=3D5=3D8dG8qUnD3F8e7A@mail.gmail.com/T/#m543550031f31a9210996ccf815d=
5bc2a4290f540
> > > > Maybe we don't requeue when fc->count becomes 0?
> > >
> > > The connection will have been aborted when cancel_delayed_work_sync()
> > > is called (otherwise we will have a lot of memory crashes/leaks). If
> > > the fuse_check_timeout() workqueue job is running while
> > > cancel_delayed_work_sync() is called, there's the "if (!fc->connected=
)
> > > { ... return; }" path that returns and avoids requeueing.
> > >
> > I ran some tests and from what I see, calling
> > cancel_delayed_work_sync() on a workqueue that is currently running
> > and re-queueing itself is enough to kill it completely. For that
> > reason I believe we don't even need the cancel_delayed_work() in
> > fuse_abort_conn() because everything is taken care of by
> > fuse_conn_put();
>
> I think the cancel_delayed_work() in fuse_abort_conn() would still be
> good to have. There are some instances where the connection gets
> aborted but the connection doesn't get freed (eg user forgets to
> unmount the fuse filesystem or the unmount only happens a lot later).
> When the connection is aborted however, this will automatically cancel
> the workqueue job on the next run (on the next run, the job won't
> requeue itself if it sees that the connection was aborted) so we
> technically don't need the cancel_delayed_work() because of this, but
> imo it'd be good to minimize the number of workqueue jobs that get run
> and canceling it asap is preferable.
>
Ok, it makes sense.
Also in fuse_check_timeout() does it make sense to leverage
fc->num_waiting to save some cycle in the function?
Something like:

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e97ba860ffcd..344af61124f4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -97,6 +97,10 @@ void fuse_check_timeout(struct work_struct *work)
                spin_unlock(&fc->lock);
                return;
        }
+       if (!fc->num_waiting){
+               spin_unlock(&fc->lock);
+               goto out;
+       }
        list_for_each_entry(fud, &fc->devices, entry) {
                fpq =3D &fud->pq;
                spin_lock(&fpq->lock);
@@ -113,6 +117,7 @@ void fuse_check_timeout(struct work_struct *work)
        }
        spin_unlock(&fc->lock);

+out:
        queue_delayed_work(system_wq, &fc->timeout.work,
                           secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
        return;

thanks
Etienne

>
> Thanks,
> Joanne
>

