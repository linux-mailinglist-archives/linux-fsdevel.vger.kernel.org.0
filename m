Return-Path: <linux-fsdevel+bounces-37251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E1F9F0030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C4E188B46F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158A1DE4F0;
	Thu, 12 Dec 2024 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnARpPmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE031B4154
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046233; cv=none; b=Zu+9A7iq0eOEcr3A999ftF3Of+okRC/6CRrQPoYg3rp90sYvewUcsqMErN0enLelu22U/YDqcuHRcOCwlo69y7SSUxOYpcAbYIj8Y+D7uz/grg6p8uGFhfCxSo8KcyA95R4ozv4BUzXMZxLZGD4CtuWD1xvYtjdo9cdvQfV41QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046233; c=relaxed/simple;
	bh=htHBtvtljJ+rt+h2HTql5LrUaaCkz9dqgmJ2l+HF1xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUS/xdFo1H5EyTVopnW1HQo75BLXa0fXWMzA3fqXg6+6WfXYsT2BTZdx9pB1+JwjSeT+kztmJBvBrKje8LQdwrp297qrxhya1cayKaiQyjGFZOZrglmxeka9uq9k894CWGYUmu+W8EE0LYzjDIQpIXb2Iw/3wzO9DVFF1nrLLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnARpPmj; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46772a0f85bso10839631cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 15:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046230; x=1734651030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ey92Pb0mKp7aWHeJgEN6tWkJfaRdaha9Tg/C/+ETOQ=;
        b=VnARpPmj03o6LPFxs9YhuF3Rs+fSc9Py6GmbfVkuSBmgaZAWIW0jcrjYWz5LoY0iSz
         BEHBbP3h381dRh8YZt4KV3bCMH9uHxgIaMX14JWvwhi3MW6efAjAh519FNKLiJko4OkB
         wiIvwfoJvfEOKp4JMSasP2ZV5jOj6qeqipa6ET5mRxMLoyT23c77jetoplU7UVd4jwlr
         8/h23K6QxWdhsnspIgD1WMiNo0qBYknRQ0Ymle7NUUJDdBXtmfQZkOxn72zPH7V3Z3Bp
         60MalnovNu/mqJpotdyuCT67HGE6TSohduOqwkYAkHhHWGCo+4jA6tRu3bBUuWH3qUm6
         y5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046230; x=1734651030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ey92Pb0mKp7aWHeJgEN6tWkJfaRdaha9Tg/C/+ETOQ=;
        b=MxjS4ozljpzVqRyZ8f5IjyQfcOhe762spFbZbpArxp9cwtF1FBHz299L/zRm2uWbjh
         UZyCU2G4Vdg8gGTRlvB49OJ0obN4HeqBEDYHQ48yN7X45Vsfh/zSraVqxjgRZ/LnaIcZ
         ZkT8IBgd3Nvw8I/ojM3/elEKZfQD9/YQr7sBES+cjGGZ+E0dJ2l0ovpejzsqjvKhq6KX
         5FOkD8eQCKzb30wRXulImwru2HehyV/AZCnAKDkD/vP26s0jwS4nOVhICkATC8nUtHFC
         r/00wLAQv3Q2UyJD2t4mEK9FTshWrxrXG7CueJzTfVuDSaq+mKn18LpFIWPRiQVsIm/Y
         CSzQ==
X-Gm-Message-State: AOJu0YzweQ1WgIx6P7U5pChHrIPA/nkbjI+RZDsgLC9iECViIljVPEhD
	bjfltu9j1JPswKDVDJcEEH7Mg4nq1qdlmOCfx1CH1RkjZIc0wRH2GDgx4+gsK/EFuKx+PVYxMPw
	/+/mapwZ6xNNzi8utWv8TtZuIayk=
X-Gm-Gg: ASbGncsatToPo2zovY3LVvuTs9X3qHOAfHic+oUV1G9yzdekuJ8g4Qpz4YJrIUFnyl2
	crXPU2wGZwPLUYWWRMjyEoR3B+DlWK5Xtz6Zofj5g0YfQ30dlvGSp
X-Google-Smtp-Source: AGHT+IHSgOrQMtyr58SfhPs3VVFedL2VVPlBc4tbmqB2e3Y/NQndHLNjGYm0h2+H+foOmmOoxHhpNP2ZfaEXgtN2GPg=
X-Received: by 2002:a05:622a:58cc:b0:467:5da6:8096 with SMTP id
 d75a77b69052e-467a583dd3amr8823531cf.44.1734046230447; Thu, 12 Dec 2024
 15:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com>
 <20241211194522.31977-2-etmartin4313@gmail.com> <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
 <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com>
 <CAJnrk1bBFGA8SQ+LvhENVb5n+MOgg=X3Ft-9g=T_3JN4aot7Mg@mail.gmail.com> <CAMHPp_SkzQ6pzoiFh9YFp1vC+2JvJ1NDdXtor2uN-JzLeicVwg@mail.gmail.com>
In-Reply-To: <CAMHPp_SkzQ6pzoiFh9YFp1vC+2JvJ1NDdXtor2uN-JzLeicVwg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Dec 2024 15:30:19 -0800
Message-ID: <CAJnrk1azDwJ0BFm7Y40XHqqHmDvsfPpw2WR9LeZTzZ6M5uarXg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, etmartin@cisco.com, 
	"ioworker0@gmail.com" <ioworker0@gmail.com>, joel.granados@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 2:46=E2=80=AFPM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> On Thu, Dec 12, 2024 at 4:48=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Wed, Dec 11, 2024 at 3:04=E2=80=AFPM Etienne Martineau
> > <etmartin4313@gmail.com> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 5:04=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Wed, Dec 11, 2024 at 11:45=E2=80=AFAM <etmartin4313@gmail.com> w=
rote:
> > > > >
> > > > > From: Etienne Martineau <etmartin4313@gmail.com>
> > > > >
> > > > > This patch abort connection if HUNG_TASK_PANIC is set and a FUSE =
server
> > > > > is getting stuck for too long. A slow FUSE server may tripped the
> > > > > hang check timer for legitimate reasons hence consider disabling
> > > > > HUNG_TASK_PANIC in that scenario.
> > > > >
> > > > > Without this patch, an unresponsive / buggy / malicious FUSE serv=
er can
> > > > > leave the clients in D state for a long period of time and on sys=
tem where
> > > > > HUNG_TASK_PANIC is set, trigger a catastrophic reload.
> > > > >
> > > > > So, if HUNG_TASK_PANIC checking is enabled, we should wake up per=
iodically
> > > > > to abort connections that exceed the timeout value which is defin=
e to be
> > > > > half the HUNG_TASK_TIMEOUT period, which keeps overhead low. The =
timer
> > > > > is per connection and runs only if there are active FUSE request =
pending.
> > > >
> > > > Hi Etienne,
> > > >
> > > > For your use case, does the generic request timeouts logic and
> > > > max_request_timeout systemctl implemented in [1] and [2] not suffic=
e?
> > > > IMO I don't think we should have logic specifically checking for hu=
ng
> > > > task timeouts in fuse, if the generic solution can be used.
> > > >
> > > > Thanks,
> > > > Joanne
> > >
> > > We need a way to avoid catastrophic reloads on systems where HUNG_TAS=
K_PANIC
> > > is set while a buggy / malicious FUSE server stops responding.
> > > I would argue that this is much needed in stable branches as well...
> > >
> > > For that reason, I believe we need to keep things simple for step #1
> > > e.g. there is no
> > > need to introduce another knob as we already have HUNG_TASK_TIMEOUT w=
hich
> > > holds the source of truth.
> > >
> > > IMO introducing those new knobs will put an unnecessary burden on sys=
admins into
> > > something that is error prone because unlike
> > >   CONFIG_DETECT_HUNG_TASK=3Dy
> > >   CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> > > which is built-in, the "default_request_timeout" /
> > > "max_request_timeout" needs to be
> > > set appropriately after every reboot and failure to do so may have
> > > nasty consequences.
> >
> > imo, it is not important to directly defend against the hung task case
> > inside the fuse code itself. imo, the generic timeout should be used
> > instead. As I understand it, hung task panic is mostly enabled for
> > debug purposes and is enabled through a sysctl. imo, if the system
> > admin enables the hung task panic sysctl value, then it is not too
> > much of a burden for them to also set the fuse max request timeout
> > sysctl.
> >
> >
> > Thanks,
> > Joanne
> >
> Yes, based on the comments received so far I agree that generic timeout i=
s the
> prefered approach. Looks like we are amongst the few that run production
> systems with hung task panic set. So yeah, I will match fuse max request
> timeout with hung task timeout to get the equivalent behavior.

Sounds great. Just FYI, the timeouts in fuse won't be 100% precise -
they'll have an upper margin of error associated with it (this is
included in the documentation for the sysctl, since it's very
non-obvious). For example, if the max request timeout is set to 600
seconds, it may fire off a little after 600 seconds. So it'd be best
if you set the fuse max request timeout to be below the hung task
timeout to be sure. IIRC, Sergey is doing the same thing [1].


[1] https://lore.kernel.org/linux-fsdevel/20241128115455.GG10431@google.com=
/

>
> On a slightly different matter, I realized that in some scenarios
> there is no benefit
> in stopping the timer when reaching the last request because another
> request can come
> right after and then we have to start the timer once again which keeps bo=
uncing
> between cancel_delayed_work_sync() and queue_delayed_work().
>
> So I think it's best to stick with your approach of starting the timer
> when the connection
> is initially established. I can re-work this patch if needed?

Thanks for testing out the timeout functionality. I'm planning to
submit v10 of the generic timeout patch to use workqueues early next
week. The time granularity will also be changed to work in seconds
instead of minutes, as noted for Sergey's and your use case. I'll make
sure you get cc'ed on that patchset.

>
> I've been doing some testing and so far I hit timeout in bg_queue and
> fpq->processing
> but I cannot trigger timeouts in fiq->pending somehow?

You can trigger the fiq->pending timeout by having your fuse server
never read from /dev/fuse, which will keep the request on the
fiq->pending list when the timeout hits. The request is only taken off
the fiq->pending list when fuse reads a request into the server's
buffer (see fuse_dev_do_read()).


Thanks,
Joanne
>
> thanks
> Etienne

