Return-Path: <linux-fsdevel+bounces-40641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE51A261C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13633A6E91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED520D4E4;
	Mon,  3 Feb 2025 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev57djv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032920408E;
	Mon,  3 Feb 2025 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605137; cv=none; b=ZcTzM1K4g5715x3RIj66Cdw1MPv5IF5U/LY875/3GlWZzRU6wQtLmgWgZGbOa1lZpC8ZEmq2klGPP3gPSXv9XhPT3vaqGXkvXt2Z4UCN9V1vLpXeHiL8DN51HF6kFW1Wf2kzviazK16N35Um1JCxSxVm65c9r3ofIlOF2HMi4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605137; c=relaxed/simple;
	bh=P0RoswY0+AJqETBMt9ZIW6PNqPRpzzaPO7LkE0HlZF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5QwFNpSxbKOmomRKAaFPIyWt7JpgVHI9gVJfqM2XcJkPbTPRiNZhe2936S2jj8mg6M4SKGGO4XK1x+F5dYbh5Q5q+Lc2lESrk2WOeLqlFD5ZqG2I+JaORgriNa61g2m8EM2E0UWSo44OsLuCCNtfFlFoTqrmTFTQ9OntYP+Rr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev57djv/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467b74a1754so60209901cf.1;
        Mon, 03 Feb 2025 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738605135; x=1739209935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7SddpEEnyBlG53QOHEeJ2JqaXIY+D6eAvSPy1hu6T8=;
        b=ev57djv/MQMw3XNBXk3IlYmvRIp0tqeDEh62ABuqP2GOjs8F2Y4Sj5TC3IiiZDEqEg
         al0/B6FF1ICGy6JM/FuoNvV2p2Ayz4g0dHuHdkqLsuYK4Q/z1jDY0MT/jeCQMjhf7TFM
         3avUOnVrgIqSwiPBfOpp5Au12NWcwI0v+95ITQFwGaqDrIP9s7sZAvHGY1Qzba5yD+dK
         2Sca0YjJIFJ/r+DUGx5hEEYceiFlMrVw1y5mA4R38rkNS9pLfhUzcT1HnZWDYFyj2jfG
         a9msfecPXFi7bMOK6Cc6VPq4KSUbY28zXJCyWgj7menuI4N2Pqdi7w4CBH2o8ClUsBzB
         iA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605135; x=1739209935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7SddpEEnyBlG53QOHEeJ2JqaXIY+D6eAvSPy1hu6T8=;
        b=dIBf/njlpvhk++ouWSk+TTFi+brc8OGqdi/cDudrukBTeYqtenZ155ak/oaT4VSyKD
         FwFWB2YE2w/cnwJ80IoPlpOovjO3Q9ZqELLmhzFHhv51Op8YPFk7qAnAsAA99UylcUyw
         EDfaEYArC4aC18//4LaJIAnBBQJ/XXYkUCjG3via8ESrU2qW4qjo8fxbOJnEnQtCRwmd
         E905tblg9aaxEYa8H0D+ieLytdjoR/FlMg+KSDqyY0jM3M2kD/wafGq8e163hmUF8Hpp
         G93ob81mSUGdGZBHq4V4zMj1p3g5PLCbA7VJneS9INigQ2bSO7/J1HoGZ/G3uzfExS7Z
         XhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjJ6l9ZqUms8H92Ocp8tj0a2Flr1kSvXlRSs5nAFo32O5oOZo04viYxkuMyJxcpU4Bu5LJmUl46sjyB5+z@vger.kernel.org, AJvYcCUo0g/3jAA5G4+fUfYQU8zDvzRSCvTqbbuyQD1Qp8fZMi2F9qTdazMEm/C5veoa9GMUdi/PH+41ZU61n5o+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AJjY1W6Cxuf46UVtY7gA7N5HtYgrQvIlIz+mjkWabXvB6RZY
	vJI/EMsjNx82Tousu9yKqEj/34VTuimmP2A9Uu7N/LfagLH4yz6YxvT0XsiXWWaagj3+G7jaHme
	qtQTRj5a/1oLiyfoCwHV6wesNOAUdCg==
X-Gm-Gg: ASbGncvuyKxhIgOVJeWt2+Bw9d48yll+bY+vq1RfqPnB13Ty9l3AIBrEvIFQuOLXmhG
	8+qtV4Ca88izZa5pFwOzwLInwd1h6iT4KYzK6zzm23o14V26095R7OwfkF0sp6hZ1lqIdsmeG9X
	YFbEPOl5ih710R
X-Google-Smtp-Source: AGHT+IHMY1S16xluNRDROmopUrH6WsIvdxS+mm3gKbskF+Lz33/I690JHJCiDzl9Ad8HkCYIxgcnGeyjl04qPQquY9Q=
X-Received: by 2002:ac8:5e09:0:b0:467:5e56:8677 with SMTP id
 d75a77b69052e-46fd0add787mr347691321cf.30.1738605134481; Mon, 03 Feb 2025
 09:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-fuse-sysfs-v1-1-36faa01f2338@kernel.org>
 <CAJnrk1Zz+QHVctL61bXwaoY4b3DFVJ+PvKw6Qq6_D=MvBQoD+w@mail.gmail.com> <115733465f444bd127c5a0a1db1215980b4607c9.camel@kernel.org>
In-Reply-To: <115733465f444bd127c5a0a1db1215980b4607c9.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 09:52:03 -0800
X-Gm-Features: AWEUYZl-n6mV4ItSl9nTQcPnKzAy0FgJmDdgp065dWeOJKls3Xuq_74r1DLWGAs
Message-ID: <CAJnrk1avqA3A8sdc-ywn5Qj2xq3ZqxVsZr-JXyzPUR3OYx3atA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a new "connections" file to show longest
 waiting reqeust
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:42=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Mon, 2025-02-03 at 09:31 -0800, Joanne Koong wrote:
> > On Mon, Feb 3, 2025 at 8:37=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > Add a new file to the "connections" directory that shows how long (in
> > > seconds) the oldest fuse_req in the processing hash or pending queue =
has
> > > been waiting.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > This is based on top of Joanne's work, as it requires the "create_tim=
e"
> > > field in fuse_req.  We have some internal detection of hung fuse serv=
er
> > > processes that relies on seeing elevated values in the "waiting" sysf=
s
> > > file. The problem with that method is that it can't detect when highl=
y
> > > serialized workloads on a FUSE mount are hung. This adds another metr=
ic
> > > that we can use to detect when fuse mounts are hung.
> > > ---
> > >  fs/fuse/control.c | 56 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/fuse_i.h  |  2 +-
> > >  2 files changed, 57 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> > > index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..b213db11a2d7d85c4403b=
aa61f9f7850fed150a8 100644
> > > --- a/fs/fuse/control.c
> > > +++ b/fs/fuse/control.c
> > > @@ -180,6 +180,55 @@ static ssize_t fuse_conn_congestion_threshold_wr=
ite(struct file *file,
> > >         return ret;
> > >  }
> > >
> > > +/* Show how long (in s) the oldest request has been waiting */
> > > +static ssize_t fuse_conn_oldest_read(struct file *file, char __user =
*buf,
> > > +                                     size_t len, loff_t *ppos)
> > > +{
> > > +       char tmp[32];
> > > +       size_t size;
> > > +       unsigned long oldest =3D jiffies;
> > > +
> > > +       if (!*ppos) {
> > > +               struct fuse_conn *fc =3D fuse_ctl_file_conn_get(file)=
;
> > > +               struct fuse_iqueue *fiq =3D &fc->iq;
> > > +               struct fuse_dev *fud;
> > > +               struct fuse_req *req;
> > > +
> > > +               if (!fc)
> > > +                       return 0;
> > > +
> > > +               spin_lock(&fc->lock);
> > > +               list_for_each_entry(fud, &fc->devices, entry) {
> > > +                       struct fuse_pqueue *fpq =3D &fud->pq;
> > > +                       int i;
> > > +
> > > +                       spin_lock(&fpq->lock);
> > > +                       for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > > +                               if (list_empty(&fpq->processing[i]))
> > > +                                       continue;
> > > +                               /*
> > > +                                * Only check the first request in th=
e queue. The
> > > +                                * assumption is that the one at the =
head of the list
> > > +                                * will always be the oldest.
> > > +                                */
> > > +                               req =3D list_first_entry(&fpq->proces=
sing[i], struct fuse_req, list);
> >
> > This probably doesn't matter in actuality, but maybe
> > list_first_entry_or_null() on fpq->processing[i] would be more optimal
> > here than "list_empty()" and "list_first_entry()" since that'll
> > minimize the number of READ_ONCE() calls we'd need to do.
> >
>
> I don't think the above will do more than one READ_ONCE, but I agree
> that list_first_entry_or_null() is more idiomatic. I'll switch to that.

Ah I just checked and you're right, it doesn't. I must have
misremembered this from the last time I looked at list.h

>
> > > +                               if (req->create_time < oldest)
> > > +                                       oldest =3D req->create_time;
> > > +                       }
> > > +                       spin_unlock(&fpq->lock);
> > > +               }
> > > +               if (!list_empty(&fiq->pending)) {
> >
> > I think we'll need to grab the fiq->lock here first before checking fiq=
->pending
> >
>
> Doh! Will fix.
>
> > > +                       req =3D list_first_entry(&fiq->pending, struc=
t fuse_req, list);
> > > +                       if (req->create_time < oldest)
> > > +                               oldest =3D req->create_time;
> > > +               }
> > > +               spin_unlock(&fc->lock);
> > > +               fuse_conn_put(fc);
> > > +       }
> > > +       size =3D sprintf(tmp, "%ld\n", (jiffies - oldest)/HZ);
> >
> > If there are no requests, I think this will still return a non-zero
> > value since jiffies is a bit more than what the last "oldest =3D
> > jiffies" was, which might be confusing. Maybe we should just return 0
> > in this case?
> >
> >
>
> You should only see a non-zero value in that case if it takes more than
> a second to walk the hash. Possible, but pretty unlikely.
>
>
> > > +       return simple_read_from_buffer(buf, len, ppos, tmp, size);
> > > +}
> > > +
> > >  static const struct file_operations fuse_ctl_abort_ops =3D {
> > >         .open =3D nonseekable_open,
> > >         .write =3D fuse_conn_abort_write,
> > > @@ -202,6 +251,11 @@ static const struct file_operations fuse_conn_co=
ngestion_threshold_ops =3D {
> > >         .write =3D fuse_conn_congestion_threshold_write,
> > >  };
> > >
> > > +static const struct file_operations fuse_ctl_oldest_ops =3D {
> > > +       .open =3D nonseekable_open,
> > > +       .read =3D fuse_conn_oldest_read,
> > > +};
> > > +
> > >  static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
> > >                                           struct fuse_conn *fc,
> > >                                           const char *name,
> > > @@ -264,6 +318,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
> > >
> > >         if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 040=
0, 1,
> > >                                  NULL, &fuse_ctl_waiting_ops) ||
> > > +           !fuse_ctl_add_dentry(parent, fc, "oldest", S_IFREG | 0400=
, 1,
> > > +                                NULL, &fuse_ctl_oldest_ops) ||
> > >             !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200,=
 1,
> > >                                  NULL, &fuse_ctl_abort_ops) ||
> > >             !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFRE=
G | 0600,
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index dcc1c327a0574b1fd1adda4b7ca047aa353b6a0a..b46c26bc977ad2d75d10f=
b306d3ecc4caf2c53bd 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -42,7 +42,7 @@
> > >  #define FUSE_NAME_MAX 1024
> > >
> > >  /** Number of dentries for each connection in the control filesystem=
 */
> > > -#define FUSE_CTL_NUM_DENTRIES 5
> > > +#define FUSE_CTL_NUM_DENTRIES 6
> > >
> > >  /* Frequency (in seconds) of request timeout checks, if opted into *=
/
> > >  #define FUSE_TIMEOUT_TIMER_FREQ 15
> > >
> > > ---
> > > base-commit: 9afd7336f3acbe5678cca3b3bc5baefb51ce9564
> > > change-id: 20250203-fuse-sysfs-ce351d105cf0
> > >
> > > Best regards,
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> > >
> > >
>
> Thanks for the review!
> --
> Jeff Layton <jlayton@kernel.org>

