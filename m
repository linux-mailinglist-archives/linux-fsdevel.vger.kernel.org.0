Return-Path: <linux-fsdevel+bounces-37518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D529F38CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 19:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0932163126
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DEC2063E0;
	Mon, 16 Dec 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6r/wabG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645A203D4C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373294; cv=none; b=VGVpQ26dqM0pUn9yNGXC1oAIt9c6IKiKfurZnqumcVw8dDmLDM1JZ5kRWER0ppphTQADTdXlME+uEROMisS44NYsQxmLK+QJx+sEOPcQxeESitmw7TtKZKGwpVlvvto9cIL70k1QrLiYqbZuN0wxdoOdkA2aakemx2gIZW8sMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373294; c=relaxed/simple;
	bh=F3i+bC40DJNiXrZdpea9VnPx2jbHC47pcMg2VRbMlWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHq2InJIOTAsziE0iwmLNYjZShnVPJKHhYejiocs47kPhmKg6uEiCNzNPBpS4SodR3+knFp+Yvgt+0b/1LqoRmCWYTdZzwWQ7IfhKR5kDX8qoWZMcnyCVcoakmxv+Hzgm+HrNCaa57Dt2Uvojn+S+EPt35lb+oHaS8cXrozcn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6r/wabG; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467918c35easo20125601cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 10:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734373292; x=1734978092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7kmEE+C8OM3LoGFL9nIl1TO3KjX+zL0PG5E9tfoMUM=;
        b=N6r/wabG6BHaMJW58jqOra/vrqbXGYuy/LGaap4TfMLzQuaWi4bfi/FaVW/Amdb8sS
         8tMMOzkSbtQTaFGHE59jvBb4ilATzs6nBZ2beN5QMqJD8/vYeEDhV9lPS42jF3JfKUDW
         NxLGLX2wi4VOEry7TQPTXEYzrsCkUqJmClv4J9VKBsO/ORlHvlDwYJ/+iwnW5pzxtCtM
         d6c1np08jHeYy7ijvlzdZ04zANIJSxDskBp0yVj4Dh9PlGekMO59sBOYY8otq5d2fa2g
         KTqEIdI+o14pYBTtpZqL3HChU3X3/7IbiA/zn7UuzcG3+ROAZwqA52Mpu4V5AFJ1nBgd
         XdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373292; x=1734978092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7kmEE+C8OM3LoGFL9nIl1TO3KjX+zL0PG5E9tfoMUM=;
        b=OXt8UMs89mOW5Bvsq3Y5KJLv6KoWnMRPUnMpRpcDfc8UETHN9vRodYcxZRqEsYNE8f
         d7K0ro3EMB6aK8S874EexC2u3LnaqGRFMMbONewkG5yBkUPz6bFsY+hJTNhIJtxkyT+J
         BG4raH+AkW2ngkr5aNxktSnltLbS/b84C0ZrWlPZtw+OKLvVREawKxNziu38vPP2DUbp
         6a22u2Euy1aHlp6mmkfFjP/+uPmHgjamWhCZEGmzJ1WwwWCsJGtHTVXlCkbIBP/UkaFv
         MrfYVIKvDtHx5n9qZC89s3gcAf+9HOdR+yGCjbor1p3grruxg4TbXy0/MJLd6xLTGOy4
         JqLw==
X-Forwarded-Encrypted: i=1; AJvYcCVNkh9HOI39VcKMNc9DmwqbQ7WgZ4QWx2cBQr+//wzci173/wHCPF+w0etUdVPNOx8V2Ri7/EmObL3sLZmH@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNDs+Aoe8UvaLylaJTRJBTnJTLecLUdSP+6Crjttu1DcnhYc7
	rIdWf66VqbtY6Ri97CbOfq46et+nUa9oTKUNOtj/pi6LkNvD10ObMVI8i6IIZUBaveQ2OdsEN8k
	9QqEu7t4Dbxic1VXqV43C33Q6jp0=
X-Gm-Gg: ASbGncuiO0ETpSBs4G3E48/KXlDjqEcxEMu7y2c8Rx6WlEAGRfDWChQNPlkzh4pV7ak
	PS02c4zd14t8lMqxtavkFEPhyC6WYFHMcilpe8As3ZX/cRbuTSPL6oA==
X-Google-Smtp-Source: AGHT+IEnls9BWHLm7jx6P0LDyvGQUpE7o2sQytHmjWOtkqvRO+Ro/rNkZMhpZbSUdeRceP5+ru8frlGFawv/WHufFfs=
X-Received: by 2002:ac8:5f8f:0:b0:467:6133:3372 with SMTP id
 d75a77b69052e-467a577ecc9mr229467011cf.25.1734373291207; Mon, 16 Dec 2024
 10:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
 <CAJnrk1a+hxtv5kiaEJu-m-C35E8Bbg-ehd8yRjc1fBd2Amm8Ug@mail.gmail.com> <CAMHPp_Srx+u9XN9SLNe58weMKnUoq9XbN9sNHBJAn9eiA0kYnw@mail.gmail.com>
In-Reply-To: <CAMHPp_Srx+u9XN9SLNe58weMKnUoq9XbN9sNHBJAn9eiA0kYnw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Dec 2024 10:21:20 -0800
Message-ID: <CAJnrk1YBYYV=wazzTfMEQcd8vaSkYAGraHz2fHoJJaVibybxaQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 9:51=E2=80=AFAM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> On Mon, Dec 16, 2024 at 12:32=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > On Sat, Dec 14, 2024 at 4:10=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> > > > There are situations where fuse servers can become unresponsive or
> > > > stuck, for example if the server is deadlocked. Currently, there's =
no
> > > > good way to detect if a server is stuck and needs to be killed manu=
ally.
> > > >
> > > > This commit adds an option for enforcing a timeout (in seconds) for
> > > > requests where if the timeout elapses without the server responding=
 to
> > > > the request, the connection will be automatically aborted.
> > > >
> > > > Please note that these timeouts are not 100% precise. For example, =
the
> > > > request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds b=
eyond
> > > > the requested timeout due to internal implementation, in order to
> > > > mitigate overhead.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  fs/fuse/fuse_i.h | 22 +++++++++++++
> > > >  fs/fuse/inode.c  | 23 ++++++++++++++
> > > >  3 files changed, 128 insertions(+)
> > > >
> > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > index 27ccae63495d..e97ba860ffcd 100644
> > > > --- a/fs/fuse/dev.c
> > > > +++ b/fs/fuse/dev.c
> > > >
> > > >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, =
gfp_t flags)
> > > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
> > > >               spin_unlock(&fc->lock);
> > > >
> > > >               end_requests(&to_end);
> > > > +
> > > > +             if (fc->timeout.req_timeout)
> > > > +                     cancel_delayed_work(&fc->timeout.work);
> > >
> > > As Sergey pointed out, this should be a cancel_delayed_work_sync(). T=
he
> > > workqueue job can still be running after cancel_delayed_work(), and
> > > since it requeues itself, this might not be enough to kill it
> > > completely.
> >
> > I don't think we need to synchronously cancel it when a connection is
> > aborted. The fuse_check_timeout() workqueue job can be simultaneously
> > running when cancel_delayed_work() is called and can requeue itself,
> > but then on the next trigger of the job, it will check whether the
> > connection was aborted (eg the if (!fc->connected)... return; lines in
> > fuse_check_timeout()) and will not requeue itself if the connection
> > was aborted. This seemed like the simplest / cleanest approach to me.
> >
> Is there a scenario where the next trigger of the job dereference
> struct fuse_conn *fc which already got freed because say the FUSE
> server has terminated?

This isn't possible because the struct fuse_conn *fc gets freed only
after the call to "cancel_delayed_work_sync(&fc->timeout.work);" that
synchronously cancels the workqueue job. This happens in the
fuse_conn_put() function.


Thanks,
Joanne

> Thanks,
> Etienne

