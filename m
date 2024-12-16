Return-Path: <linux-fsdevel+bounces-37563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DC9F3D3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 23:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390E9188CCDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF231D54E3;
	Mon, 16 Dec 2024 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHbWP7i5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF5BA49
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386963; cv=none; b=eQu9tUG2b5CoD4WLAy/1qeIwURir5CwKsovZrfgtf+Q+bkH7kMpOZ7smcsIn8qpzaG5sHR8CtuVU/tRneGin1/Yl9aDxvWfTn0LxjZBvNBkGdga2L3fS70FyKHlcm1ouEuE1r5Bqw6vhn1y1zrgwgseheWkXCPhFQdbnWuOMkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386963; c=relaxed/simple;
	bh=TdvRfYxpR0JZ5f9w2q4bXxcAOrmtV4uv9NgS3049SJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNqxWXyFky1Sg1oQ9VxlEit+SMsC8F+eD+IRjQgzxJbZt7oLglw+xarhfCTo0c/EHinxKeT4fonPNHash0iDPJMnY3vUfQjDx/nYDarpp+mbNxLz8N/v7Hh9J5kMFO6LxD2+Kxf/BglvJlV37/jbXnuWendIoIetGNvXRbrnP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHbWP7i5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467bc28277eso18357271cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734386961; x=1734991761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDHWZP/h/CaU9U+J6JEfwMIiTMGF1E1fmCJx7kXU854=;
        b=JHbWP7i5RgpZVfgSTh8R3D/FVU9cZz7WUPxHPgAScm+xBWXfORMZ/890FGlutMqKJP
         AqFGhOZDtyOYeQ2/0qYXrM0F3hymBZ8aRToxmWcsKwF2OpXLUm8MET1Dz9Pfit9+21E2
         TT+vD8PRoJeMx67xUVTgShR69oTUO95Z0T7Lk4luDqNfRtzOpMyyJ5rbe2SG5BfIUnQu
         EVHmdiqTF5RynG67OLQbADIOgytx2GRCbV6OOq/JuORzHyMcEcjSIVhRKmoUr5mri+OH
         VZCy25G6magPYe6BHHxzcPeIrNltgnlBXhd+lQu9/wd1rA/MkVCDtN4R6iGCsAJq2MtT
         iQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734386961; x=1734991761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDHWZP/h/CaU9U+J6JEfwMIiTMGF1E1fmCJx7kXU854=;
        b=DJGtTiZkmmB7bWy0lVZ3j0uZf+mI5yt734Eh+DzN60j0pAiWIRb3pCdKm2AfgQe1SN
         PfLeLtQ4RJh2vEGVhi2wx9ct6EL9l9xA4hLRA9sly6p5dF/xboXrrjOLoIHbIG1MVh8Z
         m6xesfqIKzjyAhhGoBMvhaY45zI04PwqFlq8XjqBqXobfDZ6YIZ/zIUbkem8s5VO+po7
         A7hEaZaBhOpai73yPqk0IchCUgLUIwVaF/ejH2YBhMR5GDBzfZuG9hqJfszozY7Aw7Cc
         ZTkQWh0OxwBpqeNJmCX0npfTQh6HL0iH4hzY2moXBEUlMDQ448Oh6I2viUBBgExSVSxq
         NXLA==
X-Forwarded-Encrypted: i=1; AJvYcCX3/rxJiC8LXkXMQBbbYzHue1bg5v4gGb5NuEjtmq1fwQi0pFR7392D9JpfHo1clBgTjBfS2qL59Rqb73Oq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhp+pu8YJ99ryzU4YNle0FsWRbsYstxneP91igfdDAuwg2Le+E
	9yWRWdQiRexjEtIy5y8SWoayCVN8oMypcUmr1UimSd8wcrIxepENPZrFZ8delEBAIzTDOqRjmB4
	wQYKAF5uSvTRsgukcODUfROG3L8k=
X-Gm-Gg: ASbGncv81m2sd2LYR+ZOn9p9kDoS0TyJbuep4DV76oCU9gaORvEMkMUfcjn6p4mDgdp
	wrgawsQh8F5RULQXDC1pqXuBdoCtfGaS+8etoOmY=
X-Google-Smtp-Source: AGHT+IHVLYvRngha+u7prnndEF8J3wsfus07LdefJUVgXjdpsr7qrJf1xqllPk9NVFke5EViY4vs7SpGWiEOo6PPMKo=
X-Received: by 2002:a05:622a:13d2:b0:466:7e33:9582 with SMTP id
 d75a77b69052e-467a5829f0cmr263409951cf.37.1734386960870; Mon, 16 Dec 2024
 14:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
 <CAJnrk1a+hxtv5kiaEJu-m-C35E8Bbg-ehd8yRjc1fBd2Amm8Ug@mail.gmail.com>
 <CAMHPp_Srx+u9XN9SLNe58weMKnUoq9XbN9sNHBJAn9eiA0kYnw@mail.gmail.com> <CAJnrk1YBYYV=wazzTfMEQcd8vaSkYAGraHz2fHoJJaVibybxaQ@mail.gmail.com>
In-Reply-To: <CAJnrk1YBYYV=wazzTfMEQcd8vaSkYAGraHz2fHoJJaVibybxaQ@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Mon, 16 Dec 2024 17:09:10 -0500
Message-ID: <CAMHPp_TkRV_izpSqzboz7YnWVijxTwJyQao6iZ5cczDXHXmN8g@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:21=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Dec 16, 2024 at 9:51=E2=80=AFAM Etienne Martineau
> <etmartin4313@gmail.com> wrote:
> >
> > On Mon, Dec 16, 2024 at 12:32=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > >
> > > On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > >
> > > > On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > > > > There are situations where fuse servers can become unresponsive o=
r
> > > > > stuck, for example if the server is deadlocked. Currently, there'=
s no
> > > > > good way to detect if a server is stuck and needs to be killed ma=
nually.
> > > > >
> > > > > This commit adds an option for enforcing a timeout (in seconds) f=
or
> > > > > requests where if the timeout elapses without the server respondi=
ng to
> > > > > the request, the connection will be automatically aborted.
> > > > >
> > > > > Please note that these timeouts are not 100% precise. For example=
, the
> > > > > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds=
 beyond
> > > > > the requested timeout due to internal implementation, in order to
> > > > > mitigate overhead.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > > >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  fs/fuse/fuse_i.h | 22 +++++++++++++
> > > > >  fs/fuse/inode.c  | 23 ++++++++++++++
> > > > >  3 files changed, 128 insertions(+)
> > > > >
> > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > index 27ccae63495d..e97ba860ffcd 100644
> > > > > --- a/fs/fuse/dev.c
> > > > > +++ b/fs/fuse/dev.c
> > > > >
> > > > >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm=
, gfp_t flags)
> > > > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
> > > > >               spin_unlock(&fc->lock);
> > > > >
> > > > >               end_requests(&to_end);
> > > > > +
> > > > > +             if (fc->timeout.req_timeout)
> > > > > +                     cancel_delayed_work(&fc->timeout.work);
> > > >
> > > > As Sergey pointed out, this should be a cancel_delayed_work_sync().=
 The
> > > > workqueue job can still be running after cancel_delayed_work(), and
> > > > since it requeues itself, this might not be enough to kill it
> > > > completely.
> > >
> > > I don't think we need to synchronously cancel it when a connection is
> > > aborted. The fuse_check_timeout() workqueue job can be simultaneously
> > > running when cancel_delayed_work() is called and can requeue itself,
> > > but then on the next trigger of the job, it will check whether the
> > > connection was aborted (eg the if (!fc->connected)... return; lines i=
n
> > > fuse_check_timeout()) and will not requeue itself if the connection
> > > was aborted. This seemed like the simplest / cleanest approach to me.
> > >
> > Is there a scenario where the next trigger of the job dereference
> > struct fuse_conn *fc which already got freed because say the FUSE
> > server has terminated?
>
> This isn't possible because the struct fuse_conn *fc gets freed only
> after the call to "cancel_delayed_work_sync(&fc->timeout.work);" that
> synchronously cancels the workqueue job. This happens in the
> fuse_conn_put() function.
>
cancel_delayed_work_sync() won't prevent the work from re-queuing
itself if it's already running.
I think we need some flag like Sergey pointed out here
  https://lore.kernel.org/linux-fsdevel/CAMHPp_S2ANAguT6fYfNcXjTZxU14nh2Zv=
=3D5=3D8dG8qUnD3F8e7A@mail.gmail.com/T/#m543550031f31a9210996ccf815d5bc2a42=
90f540
Maybe we don't requeue when fc->count becomes 0?
Thanks,
Etienne
>
> Thanks,
> Joanne
>

