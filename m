Return-Path: <linux-fsdevel+bounces-23895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8A934794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 07:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D5B2177E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 05:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E243AD5;
	Thu, 18 Jul 2024 05:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4AovA3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25D800
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721280277; cv=none; b=jy4l77n11EVmKT93XH6kgtBvrSBSGO7ZU6YZQQT/IFX91H53a0UeCVsdnVezijm9evFgmyAtmKqNXBT9Y830GZUdYdeNapyFrudSc7hp4jAMOTKnqIRgt8neNSp0p4GIpb19RFOcYSdHwCzG9xeryXt8wcPPO4s8qNmMBj32ayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721280277; c=relaxed/simple;
	bh=ZR7t9WtCS68u92/7v/svhmB1yoc0v/LvnaqjgmbKyvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2BMd2c9KJzUaMSz86aucfHHG7m2xPCGkvp+xenLetoIINuEoxznkillSRi+FtvkhUWgUJ1UECxtui6EpUJ9w7oEpwaMNaMqXRvuLw8xJ7Te4uMh2buDflbIGIGxAPWte8KfrZ46aTwulzu2rdrAZB3FMRqYJla8aynxgf0q56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4AovA3w; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447e1eb0117so2430271cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721280274; x=1721885074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ9yMVM5RwAz9wDs8/r7m4X/rruGm+LOEFcbSXh9ukI=;
        b=J4AovA3wrJyQzgAr5b9bK5VpGsWi8O+0ly1wGjOaape7EVKbpL0Dl+fppOsaD7VdEy
         uxjVDmxJW0GXTbUHahAh6c/NvcRuOKuhOHjchMDaJlwZOd6TzukXuVHOx9tNLxI6ocq7
         URio+FXQ/fUJgZDs/y0mjPA4mIjbjtqj3OEnCFF7Hhcn6YlBCNYiniLBf+KpYTa7hgTb
         z+UMGpfY3u663TcxxJ70aQ+kCNYK1BeSfBrrVwtoXdc5E48vphTgnwL9LKTcHsWSZxus
         4e0DUhXPefINDB8yZh1+hLuTE1PaMPVjpOMthqFsSxMmqpYnSehyBcqzBAbFtG7726T/
         DCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721280274; x=1721885074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQ9yMVM5RwAz9wDs8/r7m4X/rruGm+LOEFcbSXh9ukI=;
        b=rWMOGR00Li7Pl+Y3I00K+nzXXohriB8aF4ouB4Vi2sqB53iMa7vfCxGztnvBsbfslz
         LuMVBvIfPE4O2nFqNi46a8Qm5XdFjhZAen0Bj/8jUmS3jCmqBQ3eTie0u+QWNy31EoBa
         PE3r3kyRkNKrhN77N+0PYJ4j5AlkktBmH3RF99bjVv5/q9G/bWElvYH/UxRT7L363Tws
         eafj6HbEcxFtcmpufIcLHs494D9JZqpKoNW9C3Lde5pBqcmgfIL+Tmon2FE13FRGJsHm
         3ZYKaxfOdLuzKS3lg2uLlQA6np9M2ycC5P+k8B7q6fXu9SnOAOTRNR+n1/mmQGtpO9M7
         zE/w==
X-Forwarded-Encrypted: i=1; AJvYcCWzFby88pzEsIQ2YFv0gBHCSWZ/+YkoLgJpr0Cyr0xBwPpEqLDKIAdNHfcm6aoZsylZL6jTM4p8bWd3xUpL12Osw6HSTk+uggedVfGA+g==
X-Gm-Message-State: AOJu0YzVoNZ9ZFBnCT6eddjROB0cl92WnkrxH/k/XWBg+Xs33/f1kFfE
	3wpwBiFJ+bOqR0tCON6Mvax7V+z7CZzgpazZBlg9XKb5tz+UQOjSSsQD2UyX2z0hNpQegLn7+bk
	rmamrJqj9i+pbK/VmnaFnqf8Z/fc=
X-Google-Smtp-Source: AGHT+IGwBN9gQStIbd5ZKg19Cetl4VHYA51pNQwI8dLNh3hRNL8147rQ3BUbeK66yFcAR2rgEdJE9WSK6j6vqvq4yBM=
X-Received: by 2002:a05:622a:144a:b0:446:342e:42fd with SMTP id
 d75a77b69052e-44f8619104emr43054601cf.9.1721280274033; Wed, 17 Jul 2024
 22:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717213458.1613347-1-joannelkoong@gmail.com> <951dd7ff-d131-4a54-90b9-268722c33219@fastmail.fm>
In-Reply-To: <951dd7ff-d131-4a54-90b9-268722c33219@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 17 Jul 2024 22:24:23 -0700
Message-ID: <CAJnrk1Zy1cek+V-D2F6xbk=Xz=z9b3v=9W+FzH+yAxmpqvmdYA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	osandov@osandov.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 3:23=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> On 7/17/24 23:34, Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or take
> > too long to reply to a request. Currently there is no upper bound on
> > how long a request may take, which may be frustrating to users who get
> > stuck waiting for a request to complete.
> >
> > This commit adds a daemon timeout option (in seconds) for fuse requests=
.
> > If the timeout elapses before the request is replied to, the request wi=
ll
> > fail with -ETIME.
> >
> > There are 3 possibilities for a request that times out:
> > a) The request times out before the request has been sent to userspace
> > b) The request times out after the request has been sent to userspace
> > and before it receives a reply from the server
> > c) The request times out after the request has been sent to userspace
> > and the server replies while the kernel is timing out the request
> >
> > Proper synchronization must be added to ensure that the request is
> > handled correctly in all of these cases. To this effect, there is a new
> > FR_PROCESSING bit added to the request flags, which is set atomically b=
y
> > either the timeout handler (see fuse_request_timeout()) which is invoke=
d
> > after the request timeout elapses or set by the request reply handler
> > (see dev_do_write()), whichever gets there first.
> >
> > If the reply handler and the timeout handler are executing simultaneous=
ly
> > and the reply handler sets FR_PROCESSING before the timeout handler, th=
en
> > the request is re-queued onto the waitqueue and the kernel will process=
 the
> > reply as though the timeout did not elapse. If the timeout handler sets
> > FR_PROCESSING before the reply handler, then the request will fail with
> > -ETIME and the request will be cleaned up.
> >
> > Proper acquires on the request reference must be added to ensure that t=
he
> > timeout handler does not drop the last refcount on the request while th=
e
> > reply handler (dev_do_write()) or forwarder handler (dev_do_read()) is
> > still accessing the request. (By "forwarder handler", this is the handl=
er
> > that forwards the request to userspace).
> >
> > Currently, this is the lifecycle of the request refcount:
> >
> > Request is created:
> > fuse_simple_request -> allocates request, sets refcount to 1
> >   __fuse_request_send -> acquires refcount
> >     queues request and waits for reply...
> > fuse_simple_request -> drops refcount
> >
> > Request is freed:
> > fuse_dev_do_write
> >   fuse_request_end -> drops refcount on request
> >
> > The timeout handler drops the refcount on the request so that the
> > request is properly cleaned up if a reply is never received. Because of
> > this, both the forwarder handler and the reply handler must acquire a r=
efcount
> > on the request while it accesses the request, and the refcount must be
> > acquired while the lock of the list the request is on is held.
> >
> > There is a potential race if the request is being forwarded to
> > userspace while the timeout handler is executing (eg FR_PENDING has
> > already been cleared but dev_do_read() hasn't finished executing). This
> > is a problem because this would free the request but the request has no=
t
> > been removed from the fpq list it's on. To prevent this, dev_do_read()
> > must check FR_PROCESSING at the end of its logic and remove the request
> > from the fpq list if the timeout occurred.
> >
> > There is also the case where the connection may be aborted or the
> > device may be released while the timeout handler is running. To protect
> > against an extra refcount drop on the request, the timeout handler
> > checks the connected state of the list and lets the abort handler drop =
the
> > last reference if the abort is running simultaneously. Similarly, the
> > timeout handler also needs to check if the req->out.h.error is set to
> > -ESTALE, which indicates that the device release is cleaning up the
> > request. In both these cases, the timeout handler will return without
> > dropping the refcount.
> >
> > Please also note that background requests are not applicable for timeou=
ts
> > since they are asynchronous.
>
>
> This and that thread here actually make me wonder if this is the right
> approach
>
> https://lore.kernel.org/lkml/20240613040147.329220-1-haifeng.xu@shopee.co=
m/T/
>
>
> In  th3 thread above a request got interrupted, but fuse-server still
> does not manage stop it. From my point of view, interrupting a request
> suggests to add a rather short kernel lifetime for it. With that one

Hi Bernd,

I believe this solution fixes the problem outlined in that thread
(namely, that the process gets stuck waiting for a reply). If the
request is interrupted before it times out, the kernel will wait with
a timeout again on the request (timeout would start over, but the
request will still eventually sooner or later time out). I'm not sure
I agree that we want to cancel the request altogether if it's
interrupted. For example, if the user uses the user-defined signal
SIGUSR1, it can be unexpected and arbitrary behavior for the request
to be aborted by the kernel. I also don't think this can be consistent
for what the fuse server will see since some requests may have already
been forwarded to userspace when the request is aborted and some
requests may not have.

I think if we were to enforce that the request should be aborted when
it's interrupted regardless of whether a timeout is specified or not,
then we should do it similarly to how the timeout handler logic
handles it in this patch,rather than the implementation in the thread
linked above (namely, that the request should be explicitly cleaned up
immediately instead of when the interrupt request sends a reply); I
don't believe the implementation in the link handles the case where
for example the fuse server is in a deadlock and does not reply to the
interrupt request. Also, as I understand it, it is optional for
servers to reply or not to the interrupt request.

> either needs to wake up in intervals and check if request timeout got
> exceeded or it needs to be an async kernel thread. I think that async
> thread would also allow to give a timeout to background requests.

in my opinion, background requests do not need timeouts. As I
understand it, background requests are used only for direct i/o async
read/writes, writing back dirty pages,and readahead requests generated
by the kernel. I don't think fuse servers would have a need for timing
out background requests.

>
> Or we add an async timeout to bg and interupted requests additionally?

The interrupted request will already have a timeout on it since it
waits with a timeout again for the reply after it's interrupted.

>
>
> (I only basically reviewed, can't do carefully right now - on vacation
> and as I just noticed, on a laptop that gives me electric shocks when I
> connect it to power.)

No worries, thanks for your comments and hope you have a great
vacation (without getting shocked :))!


Thanks,
Joanne
>
>
> Thanks,
> Bernd
>
>

>

