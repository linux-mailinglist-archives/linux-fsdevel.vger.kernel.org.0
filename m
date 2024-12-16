Return-Path: <linux-fsdevel+bounces-37516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7019F37E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 18:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EBE1885EF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6857206F18;
	Mon, 16 Dec 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR/7/Dmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C61206F14
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371483; cv=none; b=KFK9CmMlYlRsEISPrLLfg4xrMM00YbNTq6GMDSNhLvXpSGMw3t9ogIwKJOPnmU3VUPpLeMHcZvQx+75titWU6RpbRbKUWOCQ1jWdHoDy5BxSN0VCKs2FeOMGM/sxiwmQV84RK1ZQpUSqfBXGpyX1R6JqFhPLirKJcLzC8pJMZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371483; c=relaxed/simple;
	bh=V5E4QtbW0HUaIEfJWy+x4wuU12sAV7eoyk6B6WDZA2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dp9+HQCP97K01Yt2WRuTMJFHPCdaL0wdOd/IOHwZcqWhR0fcNCtoKw9erc3Ls9GuCtvJ1KkBPWQqvEm8tVHJS2M6biyg1s/qqpiOyfbeoGBAFYadHoZNSIyjQI8zyYdcaSBIpxTllQKwUjiXNuMvFyOZyNZnOVI3tmxoPASN8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR/7/Dmf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6e8814842so405595885a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734371480; x=1734976280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmvalRM3eBJ6ARlMlnGAZMlpJUZpAYq4VlOpJDVVLzQ=;
        b=lR/7/DmffIcIMFNVJVf2naXwwhEbBFTQmTW89l6QlNMXdNiQv4CgUnIH0HG0Icaq++
         PEq/quNjB5FtqCjhdON5eQIm5aZfyXI5pdN8jS/U6p5Aj4xxCsht+gJPLcnHiHgdAzhT
         k0sfXiXjcJhiGfrlwJ0gqZqG5+auyAVffm1eflIqGUmns5BJck20Wle7GA3WAgt+k0lA
         hG4HbPWBE/ybHBNCwigC//kVIGCfxmNtsavjsYxoPVKIDLmqc6gK8arhJJ/iWD/6ZOQm
         89jawv0k92wssoUsqItAf1DJLwqBotZFxceBqQax937tk9jOddaLJxtURL3J4jvR4mTy
         sPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371480; x=1734976280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmvalRM3eBJ6ARlMlnGAZMlpJUZpAYq4VlOpJDVVLzQ=;
        b=A/AloxTf+C2wZjNEbNCKbnJwFk9ulLySyMKLepKTQ3SviKIdMets/kPPdk6qHwEJ3g
         gdgMjwZkUFmEK8ZNt/aE0uqsSOhsuslkEgfqUBK2kRFxxxWpqWIF8Jd16vtIMeP0qwAp
         mJm3ow068K3Nkhm2T77x+xRl2KkjtsMTJdsFdOfQSWIUPrCuo2+j3mPgHkkwWN5tK7y3
         lwJfqq0yYWND/CULq67zaV6OMFGB3TqR1zeTBSLs2IwYTfKRLS5BYIPYwLAIvxBl9XBk
         06W69081Wd98moPe5Rt8lAUsHrfexDCLLZ0vKIS3Y8hXGczbM70LkD1a3cv7ebBFWQqY
         2SqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYC+QUYNpclTqamFjOmzVDqpcWfE4JQgzb4ejBnyBWv/HiI//y+mBfvslcV0athl+p1CV7oo8jbARe75Px@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYIvNdN8hns1t+neQeLbLABduVYoeDF8pkQqRua35JzblTV1O
	w3v/OHQB+JgaEw2F/3dsIxSvzWv0Ln1fGsaCrJlWHm4EHkJLtG0+DKMQOD3rSl7EDjxQoMCOc9/
	NhspHhnXWd/KVRrn7pyFG5dpJKUI=
X-Gm-Gg: ASbGncuv4Pw/+/6VWHQfm2YYUrpLfAgCSHZVPHznIGRwFmGAwcHSjA7yw0RgDaMI3fx
	HR9Ihc5CkorM5l8YmfkQB89yNrV6XpLIkjrraTUU=
X-Google-Smtp-Source: AGHT+IEM47Es0qgaZ/H/gjlJD9aRPWtzztJLe3R7614Md2e6lsnGQoRLX6ccQYaN+kaOgYl51yKpG+bj0K32H5PWOrk=
X-Received: by 2002:a05:620a:199a:b0:7b6:d089:2757 with SMTP id
 af79cd13be357-7b6fbf2207bmr1899897685a.35.1734371480539; Mon, 16 Dec 2024
 09:51:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
 <CAJnrk1a+hxtv5kiaEJu-m-C35E8Bbg-ehd8yRjc1fBd2Amm8Ug@mail.gmail.com>
In-Reply-To: <CAJnrk1a+hxtv5kiaEJu-m-C35E8Bbg-ehd8yRjc1fBd2Amm8Ug@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Mon, 16 Dec 2024 12:51:08 -0500
Message-ID: <CAMHPp_Srx+u9XN9SLNe58weMKnUoq9XbN9sNHBJAn9eiA0kYnw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 12:32=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > > There are situations where fuse servers can become unresponsive or
> > > stuck, for example if the server is deadlocked. Currently, there's no
> > > good way to detect if a server is stuck and needs to be killed manual=
ly.
> > >
> > > This commit adds an option for enforcing a timeout (in seconds) for
> > > requests where if the timeout elapses without the server responding t=
o
> > > the request, the connection will be automatically aborted.
> > >
> > > Please note that these timeouts are not 100% precise. For example, th=
e
> > > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds bey=
ond
> > > the requested timeout due to internal implementation, in order to
> > > mitigate overhead.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  fs/fuse/fuse_i.h | 22 +++++++++++++
> > >  fs/fuse/inode.c  | 23 ++++++++++++++
> > >  3 files changed, 128 insertions(+)
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 27ccae63495d..e97ba860ffcd 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > >
> > >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gf=
p_t flags)
> > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
> > >               spin_unlock(&fc->lock);
> > >
> > >               end_requests(&to_end);
> > > +
> > > +             if (fc->timeout.req_timeout)
> > > +                     cancel_delayed_work(&fc->timeout.work);
> >
> > As Sergey pointed out, this should be a cancel_delayed_work_sync(). The
> > workqueue job can still be running after cancel_delayed_work(), and
> > since it requeues itself, this might not be enough to kill it
> > completely.
>
> I don't think we need to synchronously cancel it when a connection is
> aborted. The fuse_check_timeout() workqueue job can be simultaneously
> running when cancel_delayed_work() is called and can requeue itself,
> but then on the next trigger of the job, it will check whether the
> connection was aborted (eg the if (!fc->connected)... return; lines in
> fuse_check_timeout()) and will not requeue itself if the connection
> was aborted. This seemed like the simplest / cleanest approach to me.
>
Is there a scenario where the next trigger of the job dereference
struct fuse_conn *fc which already got freed because say the FUSE
server has terminated?
Thanks,
Etienne

