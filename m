Return-Path: <linux-fsdevel+bounces-37658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B209F5750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 21:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1A67A3ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCB1D89EC;
	Tue, 17 Dec 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxEoLZFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45013AA41
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465748; cv=none; b=StZ4NYZaBZSCkVxVMOMxWC4NNw4JzAC/bWtStERGqUyufFKSoa6ZaqIZ7dd9KP4Kea51vV5u22ZPkgFEVQLaOh1HV6bqo+wwMrUAbhW6NOUjEWBnhYMWKF5BFDJtovy51iFNpYWz6mRh9mpUpGNnJl9ufK14pdgIdMePLeBSmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465748; c=relaxed/simple;
	bh=leeSLealap7on7tt8vm1sDvJeVjUkHyN3E0WXpuF0f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUnn+9b0qJZ/NyNNm/CpaXqDN2ByvniK17WB8rqH/dIpIhmSkSf1cfa/nQg8b87Wf/NyTyURwEvsdBxAnaxgNp5piJHRxqsvDy2wmgdjTYvcBGTfP/3GY3anxu80/Qkq8SPwt9YUWzsxn7Cf7R8/MtjOKEFs4hnPjC+MPw9dIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxEoLZFn; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-468f6b3a439so15582701cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734465744; x=1735070544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgESMm3xkoHM1FCzU0kdD07/Lz2uFKmg8o9hRS+pLwM=;
        b=RxEoLZFndz3BfGXBxmIld3SItiS6F/zk+lW92Dg3YlRUl7oK6+0u51UgUS6HpzcodJ
         S5AvC9Nxh5Gf4tyXKFuWf9LxVNs5RbVYPIoOKr+kevcvItM4WRCk+YlZQEdQZG2b8zm7
         8p7zXkf4EBlBMuJcxCvDkhBZ8p4OHi4J/+Z5OhQ7/9/fuVP0prDlop5/IU4zTzpcCieP
         B31OmipZzMT0pJ+4o9NDFpBHhC1KxHb+LhZQSB5M5pgu1FIrXzqbnDzYy88GtKZgPyz3
         miNXFtoGlnJZ4UrXTzHvCLO6t6Ffbg1RvMK09zRS+q1mmZReOCAMHHZJvSovKrPfKBau
         aq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734465744; x=1735070544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgESMm3xkoHM1FCzU0kdD07/Lz2uFKmg8o9hRS+pLwM=;
        b=a5AhbpKCWtxD8y8LjWm5CjM2O+BS0MriOx0mE5Zi5E+rg2LG58SsiltJWpZQQGYQOq
         74VsQv1r6MB6iNIsNxhaqEth+NAddHHW7XQKQZE4Hbe1w6d1XiHnhCP6ahQIE8h+Lq0e
         vOZWnNJCxfJbSixYPCC2OI1CCaJDWKQs+mQCazbyMD3rfbHG6+kAWYmYAB55O9sPpSVM
         uo4pMWf0KUzV5EPNkYMqWFznXQo92bBcKBw2bHqMVjreGdbn0+VbNtTZhHKu7tPuk/Q9
         ecDEiID+U2FLLindjSjMwLYIAUUAkPTW1XeOMenIcg7YAYovXWyVu12ChulY1EURSs2H
         rHkg==
X-Forwarded-Encrypted: i=1; AJvYcCXXTIo0hqGHLNsTIAIv81BTLDyBcT3JhkPNkrhl0dz3BWzkElGmltTd9tixBGGxoKInSDHO1nCG2TZBf8vI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0toBh2q6K24ImJzM9lR9XkEPtXuR75Y/J9+5rFpDQZ0wMYJPI
	19RyS4TH7sNG7FJB5vis2v/EYdLcrRs2mbR/DrdFk66yYCuCc+IZYJDPoGStRmlzqtuCtgGPbtr
	k/ngdW8uaB2EmUt87OoSUoSIQF/8=
X-Gm-Gg: ASbGncu0RTcI3CdEfOgkfrVU4NgJo1MyhL8ACqGUGKS6cMrIXuJaXQ8r8VVUNKnrTg4
	cMHOYPJfvt5Bcsm/YFZBCLEC+MORmNHEWbuPBVqo=
X-Google-Smtp-Source: AGHT+IHh9Uca6UxvmIKqMIePkB4JZMJsxUOsS5rLW+JrPYOTTnUZMSrm41W7zlQDBo7SueCcTqHmkwYRYMAK/guqBXE=
X-Received: by 2002:ac8:57d1:0:b0:467:73f3:887d with SMTP id
 d75a77b69052e-46908e2089dmr2021341cf.33.1734465744620; Tue, 17 Dec 2024
 12:02:24 -0800 (PST)
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
 <CAMHPp_TkRV_izpSqzboz7YnWVijxTwJyQao6iZ5cczDXHXmN8g@mail.gmail.com> <CAJnrk1abKAr=V+JOSpHSQGrjYE7b_LDCLoBkCJLnF6-Egp+kXg@mail.gmail.com>
In-Reply-To: <CAJnrk1abKAr=V+JOSpHSQGrjYE7b_LDCLoBkCJLnF6-Egp+kXg@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Tue, 17 Dec 2024 15:02:13 -0500
Message-ID: <CAMHPp_RO_Bqe9mvtMntJsAb+JjwDercPT8NsT5W3e=_gqa_4AQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:26=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Dec 16, 2024 at 2:09=E2=80=AFPM Etienne Martineau
> <etmartin4313@gmail.com> wrote:
> >
> > On Mon, Dec 16, 2024 at 1:21=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 9:51=E2=80=AFAM Etienne Martineau
> > > <etmartin4313@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 16, 2024 at 12:32=E2=80=AFPM Joanne Koong <joannelkoong=
@gmail.com> wrote:
> > > > >
> > > > > On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayton@kern=
el.org> wrote:
> > > > > >
> > > > > > On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > > > > > > There are situations where fuse servers can become unresponsi=
ve or
> > > > > > > stuck, for example if the server is deadlocked. Currently, th=
ere's no
> > > > > > > good way to detect if a server is stuck and needs to be kille=
d manually.
> > > > > > >
> > > > > > > This commit adds an option for enforcing a timeout (in second=
s) for
> > > > > > > requests where if the timeout elapses without the server resp=
onding to
> > > > > > > the request, the connection will be automatically aborted.
> > > > > > >
> > > > > > > Please note that these timeouts are not 100% precise. For exa=
mple, the
> > > > > > > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ sec=
onds beyond
> > > > > > > the requested timeout due to internal implementation, in orde=
r to
> > > > > > > mitigate overhead.
> > > > > > >
> > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > ---
> > > > > > >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> > > > > > >  fs/fuse/fuse_i.h | 22 +++++++++++++
> > > > > > >  fs/fuse/inode.c  | 23 ++++++++++++++
> > > > > > >  3 files changed, 128 insertions(+)
> > > > > > >
> > > > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > > > index 27ccae63495d..e97ba860ffcd 100644
> > > > > > > --- a/fs/fuse/dev.c
> > > > > > > +++ b/fs/fuse/dev.c
> > > > > > >
> > > > > > >  static struct fuse_req *fuse_request_alloc(struct fuse_mount=
 *fm, gfp_t flags)
> > > > > > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *=
fc)
> > > > > > >               spin_unlock(&fc->lock);
> > > > > > >
> > > > > > >               end_requests(&to_end);
> > > > > > > +
> > > > > > > +             if (fc->timeout.req_timeout)
> > > > > > > +                     cancel_delayed_work(&fc->timeout.work);
> > > > > >
> > > > > > As Sergey pointed out, this should be a cancel_delayed_work_syn=
c(). The
> > > > > > workqueue job can still be running after cancel_delayed_work(),=
 and
> > > > > > since it requeues itself, this might not be enough to kill it
> > > > > > completely.
> > > > >
> > > > > I don't think we need to synchronously cancel it when a connectio=
n is
> > > > > aborted. The fuse_check_timeout() workqueue job can be simultaneo=
usly
> > > > > running when cancel_delayed_work() is called and can requeue itse=
lf,
> > > > > but then on the next trigger of the job, it will check whether th=
e
> > > > > connection was aborted (eg the if (!fc->connected)... return; lin=
es in
> > > > > fuse_check_timeout()) and will not requeue itself if the connecti=
on
> > > > > was aborted. This seemed like the simplest / cleanest approach to=
 me.
> > > > >
> > > > Is there a scenario where the next trigger of the job dereference
> > > > struct fuse_conn *fc which already got freed because say the FUSE
> > > > server has terminated?
> > >
> > > This isn't possible because the struct fuse_conn *fc gets freed only
> > > after the call to "cancel_delayed_work_sync(&fc->timeout.work);" that
> > > synchronously cancels the workqueue job. This happens in the
> > > fuse_conn_put() function.
> > >
> > cancel_delayed_work_sync() won't prevent the work from re-queuing
> > itself if it's already running.
> > I think we need some flag like Sergey pointed out here
> >   https://lore.kernel.org/linux-fsdevel/CAMHPp_S2ANAguT6fYfNcXjTZxU14nh=
2Zv=3D5=3D8dG8qUnD3F8e7A@mail.gmail.com/T/#m543550031f31a9210996ccf815d5bc2=
a4290f540
> > Maybe we don't requeue when fc->count becomes 0?
>
> The connection will have been aborted when cancel_delayed_work_sync()
> is called (otherwise we will have a lot of memory crashes/leaks). If
> the fuse_check_timeout() workqueue job is running while
> cancel_delayed_work_sync() is called, there's the "if (!fc->connected)
> { ... return; }" path that returns and avoids requeueing.
>
I ran some tests and from what I see, calling
cancel_delayed_work_sync() on a workqueue that is currently running
and re-queueing itself is enough to kill it completely. For that
reason I believe we don't even need the cancel_delayed_work() in
fuse_abort_conn() because everything is taken care of by
fuse_conn_put();
thanks,
Etienne

>
> Thanks,
> Joanne

