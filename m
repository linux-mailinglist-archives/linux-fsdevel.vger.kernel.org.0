Return-Path: <linux-fsdevel+bounces-23980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2760B93718D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 02:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53DA1F217F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351531FA5;
	Fri, 19 Jul 2024 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b033bfjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4D15CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721349440; cv=none; b=q7wXbs1CKLv+8+kM8agmzlLH/18QSoGsaAK145/k3BGK+3vdweQ2mS5/+EjQYRKT46AmNb75wEc02oiiXAHBb7JL7SCJGUP3n/QdRmxEMLn1SIlbII/mK7yVWpx5VElkn7W3z3tQJ7LvLOvJHObuJV1yaUkofD5d2pOanpDmZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721349440; c=relaxed/simple;
	bh=g0/EF/qP3U08AfEWR2Jn+uUpYl+dQQ6XpaQl5kizvqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMbckld9qp5IDNiRjF8VPg96wSMQ0N0HKa6sppi5kWGMLSehU7OSVJCuM7N23PAKFQ2HriS0IyareccGhkpc53ZDfsbHvw6mU1tYj92tO6TxJe+Dts4i9G2NmnIJD4DcCSEIsBJGk+AwmItVPiQJNBrA6ZqZjgrdiblC8iLTslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b033bfjV; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e05ed8a5526so1433463276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721349438; x=1721954238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It4gPOgE7HqmeSSd8n5qC3MC5Cqkp9S2HO7gU3jexYQ=;
        b=b033bfjVMxJS5IrcsEBoievEhon/TdtmrEHzbf599P9HtLURqcZIWBzOVUwL65wUgx
         VcYLA/sllRDfXf0KeMiyl3Hpm2UzSMNSNSUfjng3/FfdmgNshsH85qtSjoObBEcHlkf8
         stXyfOfrkf/q0i3mgZ7L/jgEsgwMFegWObxHc//FYOaIU0YSyDEdEGQek3btoF8+RkAT
         0jMS3vmH6ybbfi+dOtmA2rFpQVpEr6AgjMSPZmKvLNptsZF5OwGvlUSRl3Gwy8m0zM+k
         nf3fjKnMA6B9zpd47EGBgyjjS0leLHSDoWF3Tb1MltQ3Q8QcoLsoXKrx+RPrDLHeBHUW
         44Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721349438; x=1721954238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It4gPOgE7HqmeSSd8n5qC3MC5Cqkp9S2HO7gU3jexYQ=;
        b=jXc+eDDWqpSeIg7C/JbnFkoT65BScdF/USMVUQisz0fz7VYOaiV7DQ73PpcvbDMXuF
         B1WG3ox58MLP8np7Y51GQpdGV0YsXsYR8DonjBDw/ovka8TWHxwmdhgAsykBdyw1Xgv3
         CGbBM3/mKSpYlCsIjOZBiVe2mFREdGgvzZCOToLvZYnxTSVnbRtUBY63KFyFoLyJs3rK
         w6rPT+na7iwHZ484u1Edjzt1De8XK8Osjav/2wjyxxQgvW68yqY/ccqphMvtsRQRIUMJ
         d027AWxlbpamQgR2N0yYjV/LfekLn+XLg4oUuHjQDvYGdtl6wYir39xVBse7/ogYzxt6
         1NVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhCx1i6Uh9rSLTXUSci1qaqXrW2yvpUE5X/8/lHd+BtzuisDIAKkEOtYxqaT4tlfSLVPvtATzpEjpt8EtkGVSCykoTGzRQKOaYfpNsVA==
X-Gm-Message-State: AOJu0YzkmH4zbjzkSTtJdvBc2qo9UR58OoJH3xGKfBZmEk7A+aqUypD6
	QoQ5A6CEsYuFt9LYoCppj2lRkTYxhZFH/iBlj9nFLbuGWrtG5wVlFjX6pCimZwStfmClZTuaeh9
	z04VbfnLggMZn+h9wrxVjjx+KsI8fNiOG
X-Google-Smtp-Source: AGHT+IFLxhlqGKDAqrvZY60EUSw8z8kcLsH0rhOgtIE639PxDGFkkK3DIS+H+f3EiQT+AhUjXMqvJxnNbONgL8O3A3g=
X-Received: by 2002:a05:6902:218e:b0:e08:5e16:3b61 with SMTP id
 3f1490d57ef6-e085e1640a6mr1072481276.26.1721349437822; Thu, 18 Jul 2024
 17:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
 <951dd7ff-d131-4a54-90b9-268722c33219@fastmail.fm> <CAJnrk1Zy1cek+V-D2F6xbk=Xz=z9b3v=9W+FzH+yAxmpqvmdYA@mail.gmail.com>
 <0d34890b-0769-4b0c-86b7-0a43601962d4@aakef.fastmail.fm>
In-Reply-To: <0d34890b-0769-4b0c-86b7-0a43601962d4@aakef.fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 18 Jul 2024 17:37:06 -0700
Message-ID: <CAJnrk1Z6WAQU=zmseoPcGymwYy6Ng8Rak07DyVybZxCJHm1ESg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse requests
To: Bernd Schubert <bs_lists@aakef.fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	osandov@osandov.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 3:11=E2=80=AFPM Bernd Schubert
<bs_lists@aakef.fastmail.fm> wrote:
>
>
>
> On 7/18/24 07:24, Joanne Koong wrote:
> > On Wed, Jul 17, 2024 at 3:23=E2=80=AFPM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Hi Joanne,
> >>
> >> On 7/17/24 23:34, Joanne Koong wrote:
> >>> There are situations where fuse servers can become unresponsive or ta=
ke
> >>> too long to reply to a request. Currently there is no upper bound on
> >>> how long a request may take, which may be frustrating to users who ge=
t
> >>> stuck waiting for a request to complete.
> >>>
> >>> This commit adds a daemon timeout option (in seconds) for fuse reques=
ts.
> >>> If the timeout elapses before the request is replied to, the request =
will
> >>> fail with -ETIME.
> >>>
> >>> There are 3 possibilities for a request that times out:
> >>> a) The request times out before the request has been sent to userspac=
e
> >>> b) The request times out after the request has been sent to userspace
> >>> and before it receives a reply from the server
> >>> c) The request times out after the request has been sent to userspace
> >>> and the server replies while the kernel is timing out the request
> >>>
> >>> Proper synchronization must be added to ensure that the request is
> >>> handled correctly in all of these cases. To this effect, there is a n=
ew
> >>> FR_PROCESSING bit added to the request flags, which is set atomically=
 by
> >>> either the timeout handler (see fuse_request_timeout()) which is invo=
ked
> >>> after the request timeout elapses or set by the request reply handler
> >>> (see dev_do_write()), whichever gets there first.
> >>>
> >>> If the reply handler and the timeout handler are executing simultaneo=
usly
> >>> and the reply handler sets FR_PROCESSING before the timeout handler, =
then
> >>> the request is re-queued onto the waitqueue and the kernel will proce=
ss the
> >>> reply as though the timeout did not elapse. If the timeout handler se=
ts
> >>> FR_PROCESSING before the reply handler, then the request will fail wi=
th
> >>> -ETIME and the request will be cleaned up.
> >>>
> >>> Proper acquires on the request reference must be added to ensure that=
 the
> >>> timeout handler does not drop the last refcount on the request while =
the
> >>> reply handler (dev_do_write()) or forwarder handler (dev_do_read()) i=
s
> >>> still accessing the request. (By "forwarder handler", this is the han=
dler
> >>> that forwards the request to userspace).
> >>>
> >>> Currently, this is the lifecycle of the request refcount:
> >>>
> >>> Request is created:
> >>> fuse_simple_request -> allocates request, sets refcount to 1
> >>>   __fuse_request_send -> acquires refcount
> >>>     queues request and waits for reply...
> >>> fuse_simple_request -> drops refcount
> >>>
> >>> Request is freed:
> >>> fuse_dev_do_write
> >>>   fuse_request_end -> drops refcount on request
> >>>
> >>> The timeout handler drops the refcount on the request so that the
> >>> request is properly cleaned up if a reply is never received. Because =
of
> >>> this, both the forwarder handler and the reply handler must acquire a=
 refcount
> >>> on the request while it accesses the request, and the refcount must b=
e
> >>> acquired while the lock of the list the request is on is held.
> >>>
> >>> There is a potential race if the request is being forwarded to
> >>> userspace while the timeout handler is executing (eg FR_PENDING has
> >>> already been cleared but dev_do_read() hasn't finished executing). Th=
is
> >>> is a problem because this would free the request but the request has =
not
> >>> been removed from the fpq list it's on. To prevent this, dev_do_read(=
)
> >>> must check FR_PROCESSING at the end of its logic and remove the reque=
st
> >>> from the fpq list if the timeout occurred.
> >>>
> >>> There is also the case where the connection may be aborted or the
> >>> device may be released while the timeout handler is running. To prote=
ct
> >>> against an extra refcount drop on the request, the timeout handler
> >>> checks the connected state of the list and lets the abort handler dro=
p the
> >>> last reference if the abort is running simultaneously. Similarly, the
> >>> timeout handler also needs to check if the req->out.h.error is set to
> >>> -ESTALE, which indicates that the device release is cleaning up the
> >>> request. In both these cases, the timeout handler will return without
> >>> dropping the refcount.
> >>>
> >>> Please also note that background requests are not applicable for time=
outs
> >>> since they are asynchronous.
> >>
> >>
> >> This and that thread here actually make me wonder if this is the right
> >> approach
> >>
> >> https://lore.kernel.org/lkml/20240613040147.329220-1-haifeng.xu@shopee=
.com/T/
> >>
> >>
> >> In  th3 thread above a request got interrupted, but fuse-server still
> >> does not manage stop it. From my point of view, interrupting a request
> >> suggests to add a rather short kernel lifetime for it. With that one
> >
> > Hi Bernd,
> >
> > I believe this solution fixes the problem outlined in that thread
> > (namely, that the process gets stuck waiting for a reply). If the
> > request is interrupted before it times out, the kernel will wait with
> > a timeout again on the request (timeout would start over, but the
> > request will still eventually sooner or later time out). I'm not sure
> > I agree that we want to cancel the request altogether if it's
> > interrupted. For example, if the user uses the user-defined signal
> > SIGUSR1, it can be unexpected and arbitrary behavior for the request
> > to be aborted by the kernel. I also don't think this can be consistent
> > for what the fuse server will see since some requests may have already
> > been forwarded to userspace when the request is aborted and some
> > requests may not have.
> >
> > I think if we were to enforce that the request should be aborted when
> > it's interrupted regardless of whether a timeout is specified or not,
> > then we should do it similarly to how the timeout handler logic
> > handles it in this patch,rather than the implementation in the thread
> > linked above (namely, that the request should be explicitly cleaned up
> > immediately instead of when the interrupt request sends a reply); I
> > don't believe the implementation in the link handles the case where
> > for example the fuse server is in a deadlock and does not reply to the
> > interrupt request. Also, as I understand it, it is optional for
> > servers to reply or not to the interrupt request.
>
> Hi Joanne,
>
> yeah, the solution in the link above is definitely not ideal and I think
> a timout based solution would be better. But I think your patch wouldn't
> work either right now, unless server side sets a request timeout.
> Btw, I would rename the variable 'daemon_timeout' to somethink like
> req_timeout.
>
Hi Bernd,

I think we need to figure out if we indeed want the kernel to abort
interrupted requests if no request timeout was explicitly set by the
server. I'm leaning towards no, for the reasons in my previous reply;
in addition to that I'm also not sure if we would be potentially
breaking existing filesystems if we introduced this new behavior.
Curious to hear your and others' thoughts on this.

(Btw, if we did want to add this in, i think the change would be
actually pretty simple. We could pretty much just reuse all the logic
that's implemented in the timeout handling code. It's very much the
same scenario (request getting aborted and needing to protect against
races with different handlers))

I will rename daemon_timeout to req_timeout in v2. Thanks for the suggestio=
n.

> >
> >> either needs to wake up in intervals and check if request timeout got
> >> exceeded or it needs to be an async kernel thread. I think that async
> >> thread would also allow to give a timeout to background requests.
> >
> > in my opinion, background requests do not need timeouts. As I
> > understand it, background requests are used only for direct i/o async
> > read/writes, writing back dirty pages,and readahead requests generated
> > by the kernel. I don't think fuse servers would have a need for timing
> > out background requests.
>
> There is another discussion here, where timeouts are a possible although
> ugly solution to avoid page copies
>
> https://lore.kernel.org/linux-kernel/233a9fdf-13ea-488b-a593-5566fc9f5d92=
@fastmail.fm/T/
>
Thanks for the link, it's an interesting read.

>
> That is the bg writeback code path.
>
> >
> >>
> >> Or we add an async timeout to bg and interupted requests additionally?
> >
> > The interrupted request will already have a timeout on it since it
> > waits with a timeout again for the reply after it's interrupted.
>
> If daemon side configures timeouts. And interrupted requests might want
> to have a different timeout. I will check when I'm back if we can update
> your patch a bit for that.
>
> Your patch hooks in quite nicely and basically without overhead into fg
> (sync) requests. Timing out bg requests will have a bit overhead (unless
> I miss something), so maybe we need two solutions here. And if we want
> to go that route at all, to avoid these extra fuse page copies.
>
Agreed, I think if we do decide to go down this route, it seems
cleaner to me to have the background request timeouts handled
separately. Maybe something like having a timer per batch (where
"batch" is the group of requests that get flushed at the same time)?
That seems to me like the approach with the least overhead.


Thanks,
Joanne
>
> >
> >>
> >>
> >> (I only basically reviewed, can't do carefully right now - on vacation
> >> and as I just noticed, on a laptop that gives me electric shocks when =
I
> >> connect it to power.)
> >
> > No worries, thanks for your comments and hope you have a great
> > vacation (without getting shocked :))!
>
> Thank you! For now I'm not connecting power, 3h of battery left :)
>
>
> Thanks,
> Bernd

