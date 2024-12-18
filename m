Return-Path: <linux-fsdevel+bounces-37763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA389F6FB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D350F16A953
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 21:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721021FCCFB;
	Wed, 18 Dec 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJyTk+hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227371FC7E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558335; cv=none; b=SaEgIohhVhhydOirMWL9qZQkEOyfIWhaaD9lk2SnILk5Vs/1r3opX04Oh3oX+0C6iaUptcjnQ69VI+YpLo7tUdyMS1gBxFojmKa2hRVHMFjn1tcApszEun0Og74DdHO8RtzvQxb+5iPqis6+3uLHyBtgSsqJhDF+7qveDQ58v+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558335; c=relaxed/simple;
	bh=ePjvbAPz+tJLrK41s9dSALyOk6Aw/Ct4oISvTNJqTlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Npt0H45Fw1UaGwGzyg3iJDQoO1gnoHsNpHcfA8NwImO6dZk4wZgBLJgjXa6PcsWmp4Vu7zmh0WdKOyowqL3pRnEVURUKv6kPEOkjG+RW9Bfm75I+xmOPfF97Pbk4GCAjeKyJQBkiup5+r3QmcakzDymQZF/h02VM/SrEANUMCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJyTk+hd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-468f6b3a439so626681cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 13:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734558333; x=1735163133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT3JHOuUd7B1xibCTrYTfKHmuyc34acvdFPk6qiylAM=;
        b=iJyTk+hd7vDRO+NDcYSXzI5ctZo2VnMkEcsT4QfKjdBAQACbS2zkRw1eBjAnGg4Lnj
         hZ0fPr+CKd5WtSqqYepFczM3TvwMmgOc9SwPRi8kWvbb7NBrUoL2BxG1i8D7xKu8Cfcd
         /K5T9Ub63HB7aa3PfKCMQSK3ZbdBdEtDuBRvsTTuLtspYvDFIKlut40KWOSRJWPs62ho
         7N+5eqz7sEUTqovywQtx1U+Z6Cmx8RbfybsZW5MeCBEc9NI7hNMlIrJtsbFQLWJQ9pNN
         YlBwOYvH4sKAiYkZsSFWtc4kqfplAgIMVO3TIX3UF0a0rgfVzJibDFxVrKpYWmRjzJTy
         xECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734558333; x=1735163133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT3JHOuUd7B1xibCTrYTfKHmuyc34acvdFPk6qiylAM=;
        b=J9lNEES+QEfZBN2mW8UuZ20RjKuhVDptv0Y1ymdMgGzoOTeVO7Qv3A5rWuMDDHJYhc
         LmR0TKmKbh9feCJ10KbEInRhr8C5FktuapWUPaejIVusHgOu4bVdad0RI5yQQlmpZEHu
         4L247K7MTO6juWyhRpfj3eyWl68Z10++FAQ7fjVvGQ6S5DvDak78zLrBpemzmstj7PKp
         h9LpLmmbhqC7bvepPuA5OubwKM/yERR31e8IUOIbWNg1P+3Hx9LIeah1fhfBIEb73Yep
         p5nAbiNNZB4/K0WNuGftOqV5Bkpe1UvbyKbO5COtVSVbtc3KYTPC1ZEEzcR+Vgd54ZZe
         YvkA==
X-Forwarded-Encrypted: i=1; AJvYcCXNeLIBTUKfvpUkPUkU0uayWgpcdi7A3QGW0I1gEUdvCa7QUaamg5pTuDdeNU/LMg62xwukUsXhDcX7M1OB@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZjmDWp3ydrEplcxcOr9Mwq/U21W327UdappbeI7YdxUXdHU5
	BY3cbgo5CZ/xtOdI5K8hnpr2kwbaGRShpHtptLoNJc8XghdRyVs0fNHixJDqHYdfhxaUh2VTtsa
	QptHssZP0iuyXmT675SPhYfNfpHo=
X-Gm-Gg: ASbGncuV4D2CM4aSmaq79gV63ghyivCf7CCT2I7xkVNGSFnXzhECTHCrT4Ab+gmqwg+
	i86Ui2moqL4z79VSJBv3lChNjVJYUdjM3zeoaLTQebIpkED3u6Ns2+g==
X-Google-Smtp-Source: AGHT+IEp8rbfv+bg4CrUxMusAZIIweo3JYrB2waMidgxROo2nDu+6zDPzmWzRYI3ThGi2xArqX6DS10/NNvlG7sVmQw=
X-Received: by 2002:a05:622a:18a7:b0:466:9f89:3d72 with SMTP id
 d75a77b69052e-46908e7ca4fmr75908231cf.36.1734558333070; Wed, 18 Dec 2024
 13:45:33 -0800 (PST)
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
 <CAJnrk1YBYYV=wazzTfMEQcd8vaSkYAGraHz2fHoJJaVibybxaQ@mail.gmail.com> <CAMHPp_TkRV_izpSqzboz7YnWVijxTwJyQao6iZ5cczDXHXmN8g@mail.gmail.com>
In-Reply-To: <CAMHPp_TkRV_izpSqzboz7YnWVijxTwJyQao6iZ5cczDXHXmN8g@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Dec 2024 13:45:22 -0800
Message-ID: <CAJnrk1bXJ0dOx4CZFGR-ZGEmTXnoa8Pee1Cd7Zcdky5yW25LmQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 2:09=E2=80=AFPM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> On Mon, Dec 16, 2024 at 1:21=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Mon, Dec 16, 2024 at 9:51=E2=80=AFAM Etienne Martineau
> > <etmartin4313@gmail.com> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 12:32=E2=80=AFPM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> > > >
> > > > On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >
> > > > > On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > > > > > There are situations where fuse servers can become unresponsive=
 or
> > > > > > stuck, for example if the server is deadlocked. Currently, ther=
e's no
> > > > > > good way to detect if a server is stuck and needs to be killed =
manually.
> > > > > >
> > > > > > This commit adds an option for enforcing a timeout (in seconds)=
 for
> > > > > > requests where if the timeout elapses without the server respon=
ding to
> > > > > > the request, the connection will be automatically aborted.
> > > > > >
> > > > > > Please note that these timeouts are not 100% precise. For examp=
le, the
> > > > > > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ secon=
ds beyond
> > > > > > the requested timeout due to internal implementation, in order =
to
> > > > > > mitigate overhead.
> > > > > >
> > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > ---
> > > > > >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> > > > > >  fs/fuse/fuse_i.h | 22 +++++++++++++
> > > > > >  fs/fuse/inode.c  | 23 ++++++++++++++
> > > > > >  3 files changed, 128 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > > index 27ccae63495d..e97ba860ffcd 100644
> > > > > > --- a/fs/fuse/dev.c
> > > > > > +++ b/fs/fuse/dev.c
> > > > > >
> > > > > >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *=
fm, gfp_t flags)
> > > > > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc=
)
> > > > > >               spin_unlock(&fc->lock);
> > > > > >
> > > > > >               end_requests(&to_end);
> > > > > > +
> > > > > > +             if (fc->timeout.req_timeout)
> > > > > > +                     cancel_delayed_work(&fc->timeout.work);
> > > > >
> > > > > As Sergey pointed out, this should be a cancel_delayed_work_sync(=
). The
> > > > > workqueue job can still be running after cancel_delayed_work(), a=
nd
> > > > > since it requeues itself, this might not be enough to kill it
> > > > > completely.
> > > >
> > > > I don't think we need to synchronously cancel it when a connection =
is
> > > > aborted. The fuse_check_timeout() workqueue job can be simultaneous=
ly
> > > > running when cancel_delayed_work() is called and can requeue itself=
,
> > > > but then on the next trigger of the job, it will check whether the
> > > > connection was aborted (eg the if (!fc->connected)... return; lines=
 in
> > > > fuse_check_timeout()) and will not requeue itself if the connection
> > > > was aborted. This seemed like the simplest / cleanest approach to m=
e.
> > > >
> > > Is there a scenario where the next trigger of the job dereference
> > > struct fuse_conn *fc which already got freed because say the FUSE
> > > server has terminated?
> >
> > This isn't possible because the struct fuse_conn *fc gets freed only
> > after the call to "cancel_delayed_work_sync(&fc->timeout.work);" that
> > synchronously cancels the workqueue job. This happens in the
> > fuse_conn_put() function.
> >
> cancel_delayed_work_sync() won't prevent the work from re-queuing
> itself if it's already running.

Also btw, I think cancel_delayed_work_sync() does actually prevent the
work from re-queuing itself if it's already running. The api comment
(in kernel/workqueue.c) says:

* Cancel @work and wait for its execution to finish. This function can be u=
sed
* even if the work re-queues itself or migrates to another workqueue. On re=
turn
* from this function, @work is guaranteed to be not pending or executing on=
 any
* CPU as long as there aren't racing enqueues.


> I think we need some flag like Sergey pointed out here
>   https://lore.kernel.org/linux-fsdevel/CAMHPp_S2ANAguT6fYfNcXjTZxU14nh2Z=
v=3D5=3D8dG8qUnD3F8e7A@mail.gmail.com/T/#m543550031f31a9210996ccf815d5bc2a4=
290f540
> Maybe we don't requeue when fc->count becomes 0?
> Thanks,
> Etienne
> >
> > Thanks,
> > Joanne
> >

