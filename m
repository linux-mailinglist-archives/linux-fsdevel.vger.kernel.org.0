Return-Path: <linux-fsdevel+bounces-37662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C49F57DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 21:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5B8166C38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 20:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFAB1F9AAE;
	Tue, 17 Dec 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTYSoomN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0181F9426
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467837; cv=none; b=IgXB4N68s1EOxjqWUds/cgsm+9dgD7K6uvEN6EAHlEvmnth6Q/60O3IkEGJRFYA1EOQp+T5l0E2uC6ZMQrLxLKj4r32+yCCe7j2luCAfVJDArc2e0g99UtLejduygZInUT7/NCFY+WwCVmcBRbm/+DCEjxOvRFZYxSXfr23DqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467837; c=relaxed/simple;
	bh=HOLWalmuq7Ja4JrVZfqhosc2XqvzTk2g0gfYzQ2f7MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/UmgIGaO+Ec756/fKvNXQjG/6JrloPXkrN4ev08Y8D/2NfwHogOyd43k/6v1ureShCfEJnEwyHTols1/DBjhNfF938nwehH9VYCzVNbDvQxQCPJvqlC1aVlBYjNJYWw+nzOMqU0nJcoFHH+akthy5GdB2Gq8UbsC1eCLnzGQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTYSoomN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46772a0f8fbso51020771cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734467834; x=1735072634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4aQeHn6ALUhlGTqI3Oyq7uhH0Y94e4vPVKUo8jsQqo=;
        b=fTYSoomN31ZLe7TvEj1XFqqJcBo4fgsWlqefJA81dMS4rogHLcJL8xhyo7kkzLJjly
         p86zrMaAaICWTb4/floshUS/PaS8H15nQwqO+kXpLIvKhc2wt6vgdQtNqakDEHdBvKI9
         BHbYMChfgndqseX9/waUpHYwS1pCz30/RjEVzOfR2UHquEcfWlzsIG2FlEmxPNlwkLOX
         Tk5UoUFRfZMLMggviWbeBwppIxG5S5wlCWT5Lb0wTxtEYXRWpLTlbYyd7ejvH9kxoiUS
         93NTa6Xs2nhIjWQGYt041UuflM0ZSYjH5OOaeHE6dkDruEMy1nN/FbLBe26aUdtkY2H3
         emAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734467834; x=1735072634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4aQeHn6ALUhlGTqI3Oyq7uhH0Y94e4vPVKUo8jsQqo=;
        b=nRQi7Em1uTOmdX7ujcEht+QLhpYNzPHt1VVM48h7Evm00bJNUXIKhZrvXMAIMQ1bhD
         f7jWOzYltr0i/VkeZRQJzp6yQhrB++QiC+3gnIIpJIe+u49AZVTIpjNYw1iY+BXP0KCq
         4pp3WTt4QmUiDhQcuAOidA8EtOLPFMh7/FpCgevkczMRRCnQ3WdqJ49Z+J/wVc363Wdr
         oG4UPJk+BAzz/VMC2rhe1MwQuBQrZhcWIsen6tym9OfKp93mqVyjxeky1S/ucyb8r7SB
         riZFanclBkXmRIOAOoZ+NtZzhk+b/SKb1HRN1GIXQBMPA4fMt/O18atMhaj3yU/EuzgG
         gw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEuW+YugVpMXl4NmD7IWqonA/9lxdh4BAuD1erfcPYzeT/QaPf8WwBEhou+kiJp9OwLg06UWA2fRCD0KJj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57sNEqdNjiij7epM2RAOO46HDJlR3Du8wEq4T5fqcd2XDybUR
	MHwGVMgm4nW1hule8AOLZMCDJo4f6ht7R821la+wF3fQMwrRA5w6Of4yMgvx6xrgg6ZcEut/VAt
	9a6ezfl8CDKoi/FJN5Mcz7sZHrkE=
X-Gm-Gg: ASbGncszr49QPdlCq5UCgIqQ1tUwjDxhgOzJwdlwDZNCIxS5TpdCaf57sd62//u5PkR
	oa+zQ5ep5lPGJxl0tnvsqNezBfgVFBDjBk57jpLA=
X-Google-Smtp-Source: AGHT+IE3eD1+tlJm9LVb2lX0uLMsBXttSEq8ccjPnlZUwMuMmVenJDG7lddwfVqr7Y2CwJlSEaNViZHZCk7C5GNrjgg=
X-Received: by 2002:a05:622a:1444:b0:467:6508:2385 with SMTP id
 d75a77b69052e-46908e6ed6bmr4910671cf.34.1734467834234; Tue, 17 Dec 2024
 12:37:14 -0800 (PST)
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
 <CAJnrk1abKAr=V+JOSpHSQGrjYE7b_LDCLoBkCJLnF6-Egp+kXg@mail.gmail.com> <CAMHPp_RO_Bqe9mvtMntJsAb+JjwDercPT8NsT5W3e=_gqa_4AQ@mail.gmail.com>
In-Reply-To: <CAMHPp_RO_Bqe9mvtMntJsAb+JjwDercPT8NsT5W3e=_gqa_4AQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Dec 2024 12:37:03 -0800
Message-ID: <CAJnrk1bsMfvtTdAhp4JsB5V-8YrrBLjmrvJJzVDyMQWJWNTOig@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:02=E2=80=AFPM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> On Mon, Dec 16, 2024 at 8:26=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Mon, Dec 16, 2024 at 2:09=E2=80=AFPM Etienne Martineau
> > <etmartin4313@gmail.com> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 1:21=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Mon, Dec 16, 2024 at 9:51=E2=80=AFAM Etienne Martineau
> > > > <etmartin4313@gmail.com> wrote:
> > > > >
> > > > > On Mon, Dec 16, 2024 at 12:32=E2=80=AFPM Joanne Koong <joannelkoo=
ng@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayton@ke=
rnel.org> wrote:
> > > > > > >
> > > > > > > On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > > > > > > > There are situations where fuse servers can become unrespon=
sive or
> > > > > > > > stuck, for example if the server is deadlocked. Currently, =
there's no
> > > > > > > > good way to detect if a server is stuck and needs to be kil=
led manually.
> > > > > > > >
> > > > > > > > This commit adds an option for enforcing a timeout (in seco=
nds) for
> > > > > > > > requests where if the timeout elapses without the server re=
sponding to
> > > > > > > > the request, the connection will be automatically aborted.
> > > > > > > >
> > > > > > > > Please note that these timeouts are not 100% precise. For e=
xample, the
> > > > > > > > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ s=
econds beyond
> > > > > > > > the requested timeout due to internal implementation, in or=
der to
> > > > > > > > mitigate overhead.
> > > > > > > >
> > > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > > ---
> > > > > > > >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++=
++++++++++++
> > > > > > > >  fs/fuse/fuse_i.h | 22 +++++++++++++
> > > > > > > >  fs/fuse/inode.c  | 23 ++++++++++++++
> > > > > > > >  3 files changed, 128 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > > > > index 27ccae63495d..e97ba860ffcd 100644
> > > > > > > > --- a/fs/fuse/dev.c
> > > > > > > > +++ b/fs/fuse/dev.c
> > > > > > > >
> > > > > > > >  static struct fuse_req *fuse_request_alloc(struct fuse_mou=
nt *fm, gfp_t flags)
> > > > > > > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn=
 *fc)
> > > > > > > >               spin_unlock(&fc->lock);
> > > > > > > >
> > > > > > > >               end_requests(&to_end);
> > > > > > > > +
> > > > > > > > +             if (fc->timeout.req_timeout)
> > > > > > > > +                     cancel_delayed_work(&fc->timeout.work=
);
> > > > > > >
> > > > > > > As Sergey pointed out, this should be a cancel_delayed_work_s=
ync(). The
> > > > > > > workqueue job can still be running after cancel_delayed_work(=
), and
> > > > > > > since it requeues itself, this might not be enough to kill it
> > > > > > > completely.
> > > > > >
> > > > > > I don't think we need to synchronously cancel it when a connect=
ion is
> > > > > > aborted. The fuse_check_timeout() workqueue job can be simultan=
eously
> > > > > > running when cancel_delayed_work() is called and can requeue it=
self,
> > > > > > but then on the next trigger of the job, it will check whether =
the
> > > > > > connection was aborted (eg the if (!fc->connected)... return; l=
ines in
> > > > > > fuse_check_timeout()) and will not requeue itself if the connec=
tion
> > > > > > was aborted. This seemed like the simplest / cleanest approach =
to me.
> > > > > >
> > > > > Is there a scenario where the next trigger of the job dereference
> > > > > struct fuse_conn *fc which already got freed because say the FUSE
> > > > > server has terminated?
> > > >
> > > > This isn't possible because the struct fuse_conn *fc gets freed onl=
y
> > > > after the call to "cancel_delayed_work_sync(&fc->timeout.work);" th=
at
> > > > synchronously cancels the workqueue job. This happens in the
> > > > fuse_conn_put() function.
> > > >
> > > cancel_delayed_work_sync() won't prevent the work from re-queuing
> > > itself if it's already running.
> > > I think we need some flag like Sergey pointed out here
> > >   https://lore.kernel.org/linux-fsdevel/CAMHPp_S2ANAguT6fYfNcXjTZxU14=
nh2Zv=3D5=3D8dG8qUnD3F8e7A@mail.gmail.com/T/#m543550031f31a9210996ccf815d5b=
c2a4290f540
> > > Maybe we don't requeue when fc->count becomes 0?
> >
> > The connection will have been aborted when cancel_delayed_work_sync()
> > is called (otherwise we will have a lot of memory crashes/leaks). If
> > the fuse_check_timeout() workqueue job is running while
> > cancel_delayed_work_sync() is called, there's the "if (!fc->connected)
> > { ... return; }" path that returns and avoids requeueing.
> >
> I ran some tests and from what I see, calling
> cancel_delayed_work_sync() on a workqueue that is currently running
> and re-queueing itself is enough to kill it completely. For that
> reason I believe we don't even need the cancel_delayed_work() in
> fuse_abort_conn() because everything is taken care of by
> fuse_conn_put();

I think the cancel_delayed_work() in fuse_abort_conn() would still be
good to have. There are some instances where the connection gets
aborted but the connection doesn't get freed (eg user forgets to
unmount the fuse filesystem or the unmount only happens a lot later).
When the connection is aborted however, this will automatically cancel
the workqueue job on the next run (on the next run, the job won't
requeue itself if it sees that the connection was aborted) so we
technically don't need the cancel_delayed_work() because of this, but
imo it'd be good to minimize the number of workqueue jobs that get run
and canceling it asap is preferable.


Thanks,
Joanne

> thanks,
> Etienne
>
> >
> > Thanks,
> > Joanne

