Return-Path: <linux-fsdevel+bounces-37561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989F9F3CBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDF4161B39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CCF1D416E;
	Mon, 16 Dec 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD2k4VSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157D1CEADD
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384286; cv=none; b=svSu5czTXB31kD2b69rRBR3uffeyuT05pDobbq5N0/Dp3QV4US6dcO46CWdCSyBqatm/NAPxGovqikytI4am30CisdUsjiDMiM0pkFJpbyX68l2EyoeKl4VKlR8hCXyZMnM/fgkI9tPer7ZVBN+zKyPz3G8D2jOk8ETmKCIowwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384286; c=relaxed/simple;
	bh=hWdY+04EN6EW/QdqGgAHckunYNPVTuTB2FuaGZxVCqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peSBN35vWHXlJwGpCwGtO/tEbNnJn3MxCZ1iLA0iq/fv4iIhWQcCJ/H3ZP5onzCTY4O1sMmgRRv6EflBKon3cBQB6wSx9BGN5AXhn49IzRuwgGSo4odN548JahtVo99JA8DB27T4pjXNM064utM9c0DZdtZNvHLrVzSrHX/CAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD2k4VSj; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679d366adeso43713491cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 13:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734384283; x=1734989083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNlFC2HVAmjZD0Y5Gvs5UCZsd7nBIiQl3mnb5w3LaL8=;
        b=WD2k4VSj6td/MD51V2d/+kfqCIo360ucNQvLo5x52zqon4gcPtVtLSTNAvMC0v0Oh0
         Sszbz1ZGZn4WKd2GflKkbQiZeTHFvTkc6wFruoAJB7TBC79aF80GEPmtEBEJ8x7tsMRj
         OSZEcJOdlUQJUoDpRfwGo68VDSc2lwWObOIJ3D4DHttDN5WkEQMveP4J2+2FAGsSeIU/
         475HdBlOwu4bLUGtUTblJjIfEudA1x86Yg05ePvXE366R5jawW1U/oLkEuOhRFEcDv36
         ve3l1fNsHzF02PjiOOYVq7YOXc4wUVlywQrBhNhXe+pKAXD5kaLFOT6AMIADT+6Lvm+0
         p5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734384283; x=1734989083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNlFC2HVAmjZD0Y5Gvs5UCZsd7nBIiQl3mnb5w3LaL8=;
        b=PvmVZxWpNN8jSelZHPOWAqfjYvRRT1vPnipqScggNzYXTZHqvoq09hMGWIWI2suUpT
         s10P/BErqUDbd6B6al0ncBdANcA+kmM8oaj9STpeyNTcu0ZQgwmLk62PIq8knYbhybXg
         wyxlf2Mz9DYJuiJ3EYeGPO9m3olI30IfHZ9kP5pBx5GLDCwhxgSwxvvJwXYVLSQj3dQP
         8lhpebyUiRETL64rXIOtx97b7lkR0nqlkQxdJyuDDu+pKuzJyEbtfDRLXETnBDhntCOW
         qljrE1EKHjEDzl0APsfDpjYINStTUDVUmrcMWyEH+zRbNk8WVg/nYL4u9khQUh+biP4+
         gOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhJvxueLZHtix9hqltJFUikvCnBAYP5KN3224U0t5limwCioj87SBnSrEH8drEihqGGPxkxMhj99ML8e1P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ydwBrcddvDDDqJ/rLa7rcaEeCrOC+EizY0YBZYTWDeWj47YE
	7kw10HAEnXKmccWa5ymmjmkHq22LctYZtZPGgGTn3g97hnQ6vdfTcx+lR+Wl76L8ksdIUNyuC7I
	NvLdNuKOeJpylJLkqnAuosAuVZH4=
X-Gm-Gg: ASbGncsCWOLkHdlLPwg4re1XtRMtMlHewX2EuHqQeA/TQknD4YtCIsXHOT5qkF+KHY8
	PgDAZZJiTZpibvMJZJRnpucU7ao4ZMUiv5Rjsffk=
X-Google-Smtp-Source: AGHT+IGPPfFmWo/R2YGTOAkEarSARb3neRJ0qpFO4BFE/ag8dUtQ/IkFd8kHND9ImIrtdbnQ4BOHxDW5gTl7HSdMOx8=
X-Received: by 2002:ac8:7f0c:0:b0:467:85f9:2a6c with SMTP id
 d75a77b69052e-468f8d486a3mr17747361cf.10.1734384283240; Mon, 16 Dec 2024
 13:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <CAMHPp_TVTvKC4xcuSy=kHB+5r8pTa-72bAaJF+dCp8PnrK=m7A@mail.gmail.com>
 <CAJnrk1YK7V04cifqDXfVHBZvUhJqXrpiXUETJQ1NDvgKY4+9iQ@mail.gmail.com>
In-Reply-To: <CAJnrk1YK7V04cifqDXfVHBZvUhJqXrpiXUETJQ1NDvgKY4+9iQ@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Mon, 16 Dec 2024 16:24:32 -0500
Message-ID: <CAMHPp_S2ANAguT6fYfNcXjTZxU14nh2Zv=5=8dG8qUnD3F8e7A@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:15=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Sun, Dec 15, 2024 at 6:35=E2=80=AFPM Etienne Martineau
> <etmartin4313@gmail.com> wrote:
> >
> > On Fri, Dec 13, 2024 at 9:29=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
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
> > > @@ -45,6 +45,85 @@ static struct fuse_dev *fuse_get_dev(struct file *=
file)
> > >         return READ_ONCE(file->private_data);
> > >  }
> > >
> > > +static bool request_expired(struct fuse_conn *fc, struct fuse_req *r=
eq)
> > > +{
> > > +       return time_is_before_jiffies(req->create_time + fc->timeout.=
req_timeout);
> > > +}
> > > +
> > > +/*
> > > + * Check if any requests aren't being completed by the time the requ=
est timeout
> > > + * elapses. To do so, we:
> > > + * - check the fiq pending list
> > > + * - check the bg queue
> > > + * - check the fpq io and processing lists
> > > + *
> > > + * To make this fast, we only check against the head request on each=
 list since
> > > + * these are generally queued in order of creation time (eg newer re=
quests get
> > > + * queued to the tail). We might miss a few edge cases (eg requests =
transitioning
> > > + * between lists, re-sent requests at the head of the pending list h=
aving a
> > > + * later creation time than other requests on that list, etc.) but t=
hat is fine
> > > + * since if the request never gets fulfilled, it will eventually be =
caught.
> > > + */
> > > +void fuse_check_timeout(struct work_struct *work)
> > > +{
> > > +       struct delayed_work *dwork =3D to_delayed_work(work);
> > > +       struct fuse_conn *fc =3D container_of(dwork, struct fuse_conn=
,
> > > +                                           timeout.work);
> > > +       struct fuse_iqueue *fiq =3D &fc->iq;
> > > +       struct fuse_req *req;
> > > +       struct fuse_dev *fud;
> > > +       struct fuse_pqueue *fpq;
> > > +       bool expired =3D false;
> > > +       int i;
> > > +
> > > +       spin_lock(&fiq->lock);
> > > +       req =3D list_first_entry_or_null(&fiq->pending, struct fuse_r=
eq, list);
> > > +       if (req)
> > > +               expired =3D request_expired(fc, req);
> > > +       spin_unlock(&fiq->lock);
> > > +       if (expired)
> > > +               goto abort_conn;
> > > +
> > > +       spin_lock(&fc->bg_lock);
> > > +       req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse_r=
eq, list);
> > > +       if (req)
> > > +               expired =3D request_expired(fc, req);
> > > +       spin_unlock(&fc->bg_lock);
> > > +       if (expired)
> > > +               goto abort_conn;
> > > +
> > > +       spin_lock(&fc->lock);
> > > +       if (!fc->connected) {
> > > +               spin_unlock(&fc->lock);
> > > +               return;
> > > +       }
> > > +       list_for_each_entry(fud, &fc->devices, entry) {
> > > +               fpq =3D &fud->pq;
> > > +               spin_lock(&fpq->lock);
> >
> > Can fuse_dev_release() run concurrently to this path here?
> > If yes say fuse_dev_release() comes in first, grab the fpq->lock and
> > splice the
> > fpq->processing[i] list into &to_end and release the fpq->lock which
> > unblock this
> > path.
> >
> > Then here we start checking req off the fpq->processing[i] list which i=
s
> > getting evicted on the other side by fuse_dev_release->end_requests(&to=
_end);
> >
> > Maybe we need a cancel_delayed_work_sync() at the beginning of
> > fuse_dev_release ?
>
> Yes, fuse_dev_release() can run concurrently to this path here. If
> fuse_dev_release() comes in first, grabs the fpq->lock and splices the
> fpq->processing[i] lists into &to_end, then releases the fpq->lock,
> and then this fuse_check_timeout() grabs the fpq->lock, it'll see no
> requests on the fpq->processing[i] lists. When the requests are
> spliced onto the to_end list in fuse_dev_release(), they are removed
> from the &fpq->processing[i] list.
Yes, good point about list splice. After all, I realized that the same
locking sequence is present in fuse_abort_conn() which is proven to
work. ( otherwise we would have heard about race issues coming from
fuse_dev_release() against concurrent fuse_conn_abort_write() )

> For that reason I don't think we need a cancel_delayed_work_sync() at
> the beginning of fuse_dev_release(), but also a connection can have
> multiple devs associated with it and the workqueue job is
> per-connection and not per-device.
Ok got it.
Thanks,
Etienne

>
>
> Thanks,
> Joanne
>
> > Thanks
> > Etienne
> >
> > > +               req =3D list_first_entry_or_null(&fpq->io, struct fus=
e_req, list);
> > > +               if (req && request_expired(fc, req))
> > > +                       goto fpq_abort;
> > > +
> > > +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > > +                       req =3D list_first_entry_or_null(&fpq->proces=
sing[i], struct fuse_req, list);
> > > +                       if (req && request_expired(fc, req))
> > > +                               goto fpq_abort;
> > > +               }
> > > +               spin_unlock(&fpq->lock);
> > > +       }
> > > +       spin_unlock(&fc->lock);
> > > +
> > > +       queue_delayed_work(system_wq, &fc->timeout.work,
> > > +                          secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
> > > +       return;
> > > +
> > > +fpq_abort:
> > > +       spin_unlock(&fpq->lock);
> > > +       spin_unlock(&fc->lock);
> > > +abort_conn:
> > > +       fuse_abort_conn(fc);
> > > +}
> > > +

