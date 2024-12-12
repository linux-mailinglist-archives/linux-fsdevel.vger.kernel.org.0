Return-Path: <linux-fsdevel+bounces-37239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BCC9EFF84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B28162495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4231DE4CC;
	Thu, 12 Dec 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlJ/0jQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1301DE4F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043571; cv=none; b=czO+e868ZErAUlpZ5kagc5BumXipHDfxAkqrZDwcMBFC1PPPRFMhzT6d8AOeitP4v+TiO3UQkCqymv3Dl15IrnT+32uCHu4qEzIGsrHISNzxTCUj6ZY+mv9ltzFs6E5FXaZrvQ85Hgl5WBiYEzzjxCEbJc93Btf6xb9kjRROhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043571; c=relaxed/simple;
	bh=brJtGeywAh2RcSCblJ4ynN9qAUYKZWVUiqs4IsngeKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAZR3XIge6StV8bamDUI6CId36UmkZShlgge+5zU27qJgk9pkGYue0hNuyPtPd2L2IlkUG8n7XaLOPQs0sT5trA7nDJYrSHTSSNVj9tdZ8AVCAbdmKXv+voE2eajH+AhrpPmDzWzwCO2uDuLEysu2rUx6dExuvtBKixhO12ZsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlJ/0jQb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4674f1427deso13220131cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 14:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734043567; x=1734648367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x9m2abco5h7+Ny6HHWO9gA6uminAuiaKkTH+QH+dQk=;
        b=SlJ/0jQblxoGCE1DiK9YjSseh27tII2HCvoS5pJ/i6FWUGwY6k25biv5yTaIDxQw7x
         M8JtcXQQUqrpuE23Sc2Izqv2eIiw8Tqp61Qj8hiFQoEdtipTYHR0d3RzSs8o9wFlucu4
         nM3DK2n5jcKJ+fIuszW6DofOSGxhq05ZLu76Ypz8mqYbMiRIEEVRmmvX98aSOjTwIUmA
         lYb8Rm6idTmKWyN8EKngoBcDAzIX03lRuQraVEbJMPigeQTfmrpXf3wpQIpGxuyCOHWH
         3IkvD0s69X0gr19OSPlreMPozK6Sm189SUVhDj8EgIp1l+YbqJDK7+FmXNwu2zR+rify
         R8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043567; x=1734648367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1x9m2abco5h7+Ny6HHWO9gA6uminAuiaKkTH+QH+dQk=;
        b=QKwh/nKQfiarc3YFUjPfnzqLsY+2LlYLnaAariN2WQpYh54r+BItQb/BOuMGVD5fXs
         E7pnp/xNWfrW8pLAzHHZY5MzlA0OsQQnP96RJCnVMpXpMkT1L+zIVPPAfv41l0aFpR9n
         7kFNC2IF0NCfJeO5sM+tFoDtMTNRzuPnXCHQ1IiKeqxws3mG2yKNgmV1vZr23OuQxsbm
         YOBhUoBl70gM9IWryS9aHqErd2nv4gUlY/CU6alZBSjglJCNqswpYbSwW1rw/FwWkHub
         XoDfwX9/+0mzRVZU8sQkRXGGTM7YQHKYwzE+m2y/hg+ojYz8DMJh+VbrKzGDZlxZ9K8O
         sOOg==
X-Gm-Message-State: AOJu0YzNlL26Q7/KmKzs3HXSfOeivtXnmkY5kowk9DKbdjL+RiawglFx
	dyz+NL/tUVViDBXs6pv7tUlo2T+cmpcEiPBCXVgReT7GFJO4HYIvGf9sNb6G1S61vEouWCJAo24
	mEn9cwqCbuqYdJj/YrQZBobiLeNs=
X-Gm-Gg: ASbGncvP5EWHbuzjBu2nTrtYR1DZMM9C7NfEV5r73NVNvWdurM76gc/jP8IklCbGt9f
	UFGEp3oXfYNSHLTDOrtiBG4cfmyDTtMFbtlosvNg=
X-Google-Smtp-Source: AGHT+IH2MzPih6Cljx5F/Gb8NBqMAd00RMi1Lp0jU+HPgS3kcRCtkbHGXftzO+swd8aiq1RA0b+4RBXTcqCZ16Dp9jM=
X-Received: by 2002:a05:622a:1dcb:b0:466:8cc1:6221 with SMTP id
 d75a77b69052e-467a58380eemr6847411cf.50.1734043567142; Thu, 12 Dec 2024
 14:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com>
 <20241211194522.31977-2-etmartin4313@gmail.com> <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
 <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com> <CAJnrk1bBFGA8SQ+LvhENVb5n+MOgg=X3Ft-9g=T_3JN4aot7Mg@mail.gmail.com>
In-Reply-To: <CAJnrk1bBFGA8SQ+LvhENVb5n+MOgg=X3Ft-9g=T_3JN4aot7Mg@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Thu, 12 Dec 2024 17:45:56 -0500
Message-ID: <CAMHPp_SkzQ6pzoiFh9YFp1vC+2JvJ1NDdXtor2uN-JzLeicVwg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, etmartin@cisco.com, 
	"ioworker0@gmail.com" <ioworker0@gmail.com>, joel.granados@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 4:48=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Dec 11, 2024 at 3:04=E2=80=AFPM Etienne Martineau
> <etmartin4313@gmail.com> wrote:
> >
> > On Wed, Dec 11, 2024 at 5:04=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 11:45=E2=80=AFAM <etmartin4313@gmail.com> wro=
te:
> > > >
> > > > From: Etienne Martineau <etmartin4313@gmail.com>
> > > >
> > > > This patch abort connection if HUNG_TASK_PANIC is set and a FUSE se=
rver
> > > > is getting stuck for too long. A slow FUSE server may tripped the
> > > > hang check timer for legitimate reasons hence consider disabling
> > > > HUNG_TASK_PANIC in that scenario.
> > > >
> > > > Without this patch, an unresponsive / buggy / malicious FUSE server=
 can
> > > > leave the clients in D state for a long period of time and on syste=
m where
> > > > HUNG_TASK_PANIC is set, trigger a catastrophic reload.
> > > >
> > > > So, if HUNG_TASK_PANIC checking is enabled, we should wake up perio=
dically
> > > > to abort connections that exceed the timeout value which is define =
to be
> > > > half the HUNG_TASK_TIMEOUT period, which keeps overhead low. The ti=
mer
> > > > is per connection and runs only if there are active FUSE request pe=
nding.
> > >
> > > Hi Etienne,
> > >
> > > For your use case, does the generic request timeouts logic and
> > > max_request_timeout systemctl implemented in [1] and [2] not suffice?
> > > IMO I don't think we should have logic specifically checking for hung
> > > task timeouts in fuse, if the generic solution can be used.
> > >
> > > Thanks,
> > > Joanne
> >
> > We need a way to avoid catastrophic reloads on systems where HUNG_TASK_=
PANIC
> > is set while a buggy / malicious FUSE server stops responding.
> > I would argue that this is much needed in stable branches as well...
> >
> > For that reason, I believe we need to keep things simple for step #1
> > e.g. there is no
> > need to introduce another knob as we already have HUNG_TASK_TIMEOUT whi=
ch
> > holds the source of truth.
> >
> > IMO introducing those new knobs will put an unnecessary burden on sysad=
mins into
> > something that is error prone because unlike
> >   CONFIG_DETECT_HUNG_TASK=3Dy
> >   CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> > which is built-in, the "default_request_timeout" /
> > "max_request_timeout" needs to be
> > set appropriately after every reboot and failure to do so may have
> > nasty consequences.
>
> imo, it is not important to directly defend against the hung task case
> inside the fuse code itself. imo, the generic timeout should be used
> instead. As I understand it, hung task panic is mostly enabled for
> debug purposes and is enabled through a sysctl. imo, if the system
> admin enables the hung task panic sysctl value, then it is not too
> much of a burden for them to also set the fuse max request timeout
> sysctl.
>
>
> Thanks,
> Joanne
>
Yes, based on the comments received so far I agree that generic timeout is =
the
prefered approach. Looks like we are amongst the few that run production
systems with hung task panic set. So yeah, I will match fuse max request
timeout with hung task timeout to get the equivalent behavior.

On a slightly different matter, I realized that in some scenarios
there is no benefit
in stopping the timer when reaching the last request because another
request can come
right after and then we have to start the timer once again which keeps boun=
cing
between cancel_delayed_work_sync() and queue_delayed_work().

So I think it's best to stick with your approach of starting the timer
when the connection
is initially established. I can re-work this patch if needed?

I've been doing some testing and so far I hit timeout in bg_queue and
fpq->processing
but I cannot trigger timeouts in fiq->pending somehow?

thanks
Etienne

