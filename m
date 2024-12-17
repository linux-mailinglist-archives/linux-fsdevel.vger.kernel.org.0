Return-Path: <linux-fsdevel+bounces-37572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E859F3FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 02:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81A31882660
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 01:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F912FF69;
	Tue, 17 Dec 2024 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzzOgn6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C68C0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398790; cv=none; b=mBnr42MWbLq/fkmSQGIoRr5ikQZXm2W+gd90sBAJtwJtn5JLMTvV3ah30LmKsFPYIWTx5pukjm9ov2/UNYAuqCrL7zMy+Tgf2NrskIBES41FGVhRp1CzO0kvt+QDxv381cl+AqdnBn26okiJni+1iKBYU8Bkyau+DOMzVdHXMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398790; c=relaxed/simple;
	bh=kUKBERsF2RdJHisVhTSQAMi0sSik2OJ48iO5arxdXnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9ufr5za9xokISZCWTkb93RbdGlMLV7jr0j83uZYNjOYoN640T02d0QHieCB35GLNMSOSZydsXFSdFo2zXxOfbNrN8IuKUeFEvpgAME7yl9mkD3ODS17dWZUGJYVOa/xZRrIW7vRZfVhmLriUKxrhbkfk3QBOjWDgg2wMlW5lS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzzOgn6O; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4678afeb133so51350351cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 17:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734398785; x=1735003585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6kXz67OUhSEbBzBJMYEYPb0VXYu6BOrNLXELwSMMUI=;
        b=PzzOgn6Oz3erVL6UnXZUjsZEaNHdVQdntU+DfPsjsoghSqQAwIxs6Br+89Lcs/PPU+
         4H0YvHXwM9rAMHDN+2zMLUS94Zrtm9OVKnzjdUj+LZAOMR7hs7nfs0H052w2reBeG00v
         JnGwfkmMhgdsoL2YTycBABagfwxKFB9JOiaqXLJsABIIosv30hU6mUnefS/Fd8tj9MtJ
         u0EjedOwhiUhvaioTYxr4LxiESt99Y5d/gAwxH/Tg629tAAnWqjHNjN2I0dpKDad8dYQ
         Q9PJKGnK3n3xoP+NWCmZRd6bvT7FjT2LqBqA0hRAjFvTzFz3kY5EfUzICg7wZwINjlGZ
         QvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734398785; x=1735003585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6kXz67OUhSEbBzBJMYEYPb0VXYu6BOrNLXELwSMMUI=;
        b=HWhccQb+bWhXJmbXm7rjwb1WKOhrJOC3D40zagRrpJpYOZttGBdqZe9FouWjmO4xRp
         SF+pYJ6InSPixu3YRRehq+fsNtdDuwOqueCl9jgbm66zW5wof5BnwXwdgSqSo0stNJR2
         7GTAs/kbR7mWpTuxrNxxikfYXmTo4AQDFmSPo1i4XVm6c0Z/Fn9FvFdQoHQ1xyP1Djoz
         9lTs6TOZwc0t+S3zneQhTVUN7wf+ADzrzvT2wxKlJr35VYZEjLOIQ6pBqCC/5YcQMHGI
         geh/kS9nFF3fW5nAyzsR2q79A61Qkxq/2U3OIo0CwAZ0buw3SEPTq3+KQwYUKLUcqws1
         ff8A==
X-Forwarded-Encrypted: i=1; AJvYcCXl+wpOPUYNYgK46TlCb16oOM/reSNdj333ATJYLgqGmo84u4P0BkRHHhQOWDyY/GAuuZ5tkN3nmLsOkRSQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0ARAg7/fDeYQtXDwAyqLvNYX6umHCXj+HGesyzKuT9lLlLtu
	PAUsoRQVrXCzzGBIO2U9kEHpvHwib5s6TFiUXbyJQEq7aWYbo84j8xTfkeALlYLY18SWCFNuJo9
	mkjrEYmub3NZS8lUVK1LGcJ0FmdM=
X-Gm-Gg: ASbGnctJjhxJDoN0h2knf45r61TSULJY8p9kl0FvpnLPvn+aD67nV+7LgUYXcidNuw2
	KoXTSUDxf6gKfdujVCZFHQ1qJDtxORGkux20R1J8=
X-Google-Smtp-Source: AGHT+IGo4JGDhmJvfCiWcd9vqITqPOxsYCYVg6UXVTUEwTKVc4rkLZJfWcT2Pu9vQq+fnLs1RSUdOpLdjwcjEjUWjl8=
X-Received: by 2002:a05:622a:1a10:b0:465:2fba:71b5 with SMTP id
 d75a77b69052e-468f8da5990mr32357281cf.13.1734398785622; Mon, 16 Dec 2024
 17:26:25 -0800 (PST)
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
Date: Mon, 16 Dec 2024 17:26:14 -0800
Message-ID: <CAJnrk1abKAr=V+JOSpHSQGrjYE7b_LDCLoBkCJLnF6-Egp+kXg@mail.gmail.com>
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
> I think we need some flag like Sergey pointed out here
>   https://lore.kernel.org/linux-fsdevel/CAMHPp_S2ANAguT6fYfNcXjTZxU14nh2Z=
v=3D5=3D8dG8qUnD3F8e7A@mail.gmail.com/T/#m543550031f31a9210996ccf815d5bc2a4=
290f540
> Maybe we don't requeue when fc->count becomes 0?

The connection will have been aborted when cancel_delayed_work_sync()
is called (otherwise we will have a lot of memory crashes/leaks). If
the fuse_check_timeout() workqueue job is running while
cancel_delayed_work_sync() is called, there's the "if (!fc->connected)
{ ... return; }" path that returns and avoids requeueing.


Thanks,
Joanne

> Thanks,
> Etienne
> >
> > Thanks,
> > Joanne
> >

