Return-Path: <linux-fsdevel+bounces-54868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB7DB044DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4658F18863B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91525C80E;
	Mon, 14 Jul 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4nIIqC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D523C8A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508777; cv=none; b=uQR7CCXwLiPBUO4KBWK2khGcfe9XjGPrvyKONcdHvGwk1hudukKACoHdRcUTGqvgIcYOHbvQ6vgUIi4Ypu7Ru8EbbGnAGJguD6aH/xXLOlMo9GawdWLuxzLkPsQy5SPoxCMf/cXzH5oK+PxvvwSyjWS79pfN782RaclUi7M14Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508777; c=relaxed/simple;
	bh=ib63dkylYgDS3i4nBK1gkzNNisARPAkl0UcQDrn6L9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm+2P23gKq1AZMddYbXiem7u0OfCfzGaBRdK8K662Ltyn0tjSmoQTe1EGD0r1b9o7r+QQIYpSxoNMbTBMilEQaVzeXV89rYrpi5XA/UbToF00NvpwxW/4fXt5YUo5xl3QNwg/qqhSJuuDLdASKDwFr8/+HmGolvuPvW69rcRzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4nIIqC8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so942164066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752508774; x=1753113574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib63dkylYgDS3i4nBK1gkzNNisARPAkl0UcQDrn6L9U=;
        b=X4nIIqC8NdsTTBWgDivRLCeDR2nqNm9gx6rpx+CI55e9hyV6F7xYeHSIyIPoCh5mxK
         faVee05w15f7V1mig9FkppV2LzaKBau6ci2QYtgxFGiMkaOl5LDzaE6QGd/SttE1qxuo
         sryvZLWd3yzg9Av35pfdEKd8BmJXYQ93+WUUBfV7isB5SbDnUeW6fzFqXC4LaTNms94W
         M/cMtpzKobMbNSGPQClnNxgn9TnAOPkgvtfWPYXj4l1HECLKLgjmEZzCFh13RFTods55
         uSxWgTS3NQdzqBtGpDCFAzQ0Xa09TDG13sb3Pcx0NduSJJ++xOTP+QUJeQEhtDSRu6xq
         JR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508774; x=1753113574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib63dkylYgDS3i4nBK1gkzNNisARPAkl0UcQDrn6L9U=;
        b=nb6DkP2p8/qKrUp+wWN2ftlKFy83T9ibB4L0RLTyog8ULP6BP2yOb1uT3gr8vVTaax
         M9xBQQzZDi1eK91PiJfe/vRUJQFUTTk6fQbvjqTuJ4CtGL4auAxl7NuF2m92rIuuzViE
         igc/rlehG9aMWtqWDa+o1UJX2hgAKKdlOXpitbOwax88z4+zJ5i78FkrnqFbLTXyEun5
         o93/tkAP6w4Jav/WogdMajsfvDb1bEjNXnebxHhoibO1vD6mL49I2uA+zC+9FgHuJ5Tu
         YlbsASb06DuMQfYgCRT7n5UmwV2RTtTHJtCE4JA2JnK4YcgSza7l1fZ1gLfVTSOgXPq5
         R9FA==
X-Forwarded-Encrypted: i=1; AJvYcCVbaj0eBp2mS6gQwF8HhxLyUO8SPw22VmIuzrXNAJcKAr/Gl7c3WWr+UMLlXB2eIW85OBKddvQYnu6LMQfp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8K/cc4q6FMI7G3oTSKcR6BYnRQGekMasfBpkudHB4WRMGIGTo
	IX8grA4dOTVs1rt6K73T5C4qBAkhBZdL6HyEWQGkfqsrEirIofdzpiE8trACi35nDTqOfX1p6ED
	Mz0fO08zAVLyYNy+70DXJ2s6KJf3rrZJugnaxxLySeA==
X-Gm-Gg: ASbGnctFurcpLXaMc0blqZOsnnWCDNcUb3JiB8U6oDefw/XVQOTce/oF53U99IXBqPi
	qzLAYUJWPV4KFfCs8jrckoADl7bG+abeATTkx+LtSZw4cJNQtlLH69FgeljV4ivM8Et4Qs3yUlf
	P6sr9IPqGMxj7XgRAS38X7xQezLly4w8CxQm2/JUnE9f8ilx3/EccVw+J1Cexs4fTFUizADzLHp
	OP3n5o=
X-Google-Smtp-Source: AGHT+IF8RRUZopnAs1FYXcppXTlPgY/pYuHLu/1RznedXoWyLUb0Xem2V0syRfABrXGgHAI2mC+jPM8trPz+LBiUQv4=
X-Received: by 2002:a17:907:3f8d:b0:ae6:c334:af3a with SMTP id
 a640c23a62f3a-ae9b5bc951cmr15661266b.6.1752508773770; Mon, 14 Jul 2025
 08:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
 <20250714070113.1690928-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250714070113.1690928-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Jul 2025 17:59:22 +0200
X-Gm-Features: Ac12FXyyAEknEwgWoUbqacRRxDctMG3CumKRB4tzmSC3CgE74AvpLvbDM5kKZng
Message-ID: <CAOQ4uxgHre+mCOka8dNgzioOShYidxgd=zkX5zcSt8cq89kTXg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 9:02=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> On 7/12/25, 1:08 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73i=
l@gmail.com>> wrote:
>
> > Regarding the ioctl, it occured to me that it may be a foot gun.
> > Once the new group interrupts all the in-flight events,
> > if due to a userland bug, this is done without full collaboration
> > with old group, there could be nasty races of both old and new
> > groups responding to the same event, and with recyclable
> > ida response ids that could cause a real mess.
>
> Makes sense. I had only considered an "ideal" usage where the resend
> ioctl is synchronized. Sounds reasonable to provide stronger guarantees
> within the surfaced api.
>
> > If we implement the control-fd/queue-fd design, we would
> > not have this problem.
> > The ioctl to open an event-queue-fd would fail it a queue
> > handler fd is already open.
>
> I had a few questions around the control-fd/queue-fd api you outlined.
> Most basically, in the new design, do we now only allow reading events /
> writing responses through the issued queue-fd.
>

Correct.

The fanotify control fd is what keeps the group object alive
and it is used for fanotify_mark() and for the ioctl that generated
the queue-fd.

The queue-fd is for fanotify_read (events) and fanotify_write
(responses).

> > The control fd API means that when a *queue* fd is released,
> > events remain in pending state until a new queue fd is opened
> > and can also imply the retry unanswered behavior,
> > when the *control* fd is released.
>
> It may match what you are saying, but is it safe to simply trigger the
> retry unanswered flow for pending events (events that are read but not
> answered) on queue fd release.

Yes you are right. This makes sense.
I did not say this correctly. I wrote it more accurately.

> And similarly the control fd release would
> just match the current release flow of allowing / resending all queued
> events + destroying group.

Yes, that allows a handover without a fd store.
- Start new group, setup marks, open queue fd, don't read from it
- Stop old group
- New group starts reading events (including the resent ones)

>
> And in terms of api usage does something like the following look
> reasonable for the handover:
>
> - Control fd is still kept in fd store just like current setup
> - Queue fd is not. This way on daemon restart/crash we will always resend
> any pending events via the queue fd release
> - On daemon startup always call ioctl to reissue a new queue fd
>

Yes. Exactly. sounds simple and natural.
There may be complications, but I do not see them yet.

> > Because I do not see an immediate use case for
> > FAN_REPORT_RESPONSE_ID without handover,
> > I would start by only allowing them together and consider relaxing
> > later if such a use case is found.
> >
> > I will even consider taking this further and start with
> > FAN_CLASS_PRE_CONTENT_FID requiring
> > both the new feature flags.
>
> The feature dependence sounds reasonable to me. We will need both
> FAN_REPORT_RESPONSE_ID and retry behavior + something like proposed
> control fd api to robustly handle pending events.
>
> > Am I missing anything about meta use cases
> > or the risks in the resend pending events ioctl?
>
> I don't think theres any other complications related to pending events in
> our use case. And based on my understanding of the api you proposed, it
> should address our case well. I can just briefly mention why its desirabl=
e
> to have some mechanism to trigger resend while still using the same
> group, I might have added this in a previous discussion. Apart from
> interested (mounts of) directories, we are also adding ignore marks for
> all populated files. So we would need to recreate this state if just
> relying on retry behavior triggering on group close. Its doable on the
> use case side but probably a bit tricky versus being able to continue
> to use the existing group which has proper state.

I needed no explanation - this was clear to me but maybe
someone else did so good that you wrote it ;)

But I think that besides the convenience of keeping the marks,
it is not really doable to restart the service with guarantee that:
- You won't lose any event
- User will not be denied access between services

Especially, if the old service instance could be hung and killed by a watch=
dog,
IMO the restart mechanism is a must for a smooth and safe handover.

Thanks,
Amir.

