Return-Path: <linux-fsdevel+bounces-54753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4392B029E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3921581AE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 08:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1AE22258C;
	Sat, 12 Jul 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMJBT3Kj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C5221FD4
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752307721; cv=none; b=AJK6riKPpd9x0/wEIiD4STvxvHhdq9SsnsHxuN4tcYqBT5ARQIygvpWfTlzibbWVpW6raheSa5d4OIX3TiNMmKCtl3EUCdixuu3GK2DDetEnsTf9uabj4ojoQGUrbZlIAlynnEcs2uqqObgVSotcEAz/xLfUzGtDUUdfmWB9YiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752307721; c=relaxed/simple;
	bh=wQCikia+WI3Zyjx/wk/OWs8BoWxYDfuDANWwAGC8E2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD4fNes4cpbh8gsKQCiR+kucYw3oF0E9L0nLbC/QtTY/NoSjSMIYJPcCCQNMCMcRRLsr/kRnZQBR4AY82ZjSTbhXoKTeF7AR2VyvsTLTsd1NFWX3IdX1Zhb0g00w6ONhBD9y1ofbNnYzbF3gV3OmdRSpdi8ntuIYiRIEGFZUyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMJBT3Kj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1634699f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 01:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752307717; x=1752912517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cvcj8WbhMtIUXFR9GVqpeL13vSyUhacuL+uVhzrnsqM=;
        b=fMJBT3Kj8F/Fb6/vgpTWLqRmPjVZlvCvMgutKu49Jmm2j586hoR0DaMY5hEEc85i5t
         fbkdG0iq3Li3Tb7AK5xnZ3ifATl/wbCE0YTxABrDaI2eBxgFp6opT6XUN2DnvkFjAebC
         7QWERMUVXIxbTI82kogE3AwEdzsFe+GiJWyrTyHAwwb9/PXl8xRqjli7vTsM3IMCXtf6
         zSqe81LCqzgCfcjwHUQAyaWI94zw943iU0hrYrmvAvIx978EyRm0iLyFMpC6wI7HQVpT
         r1kpXZJeFawP6PjR3UQhYRxzrqyUnoYKh0rqJhhNjweuCjAyNoqJ4UAcR+8lOmU1L0oj
         +mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752307717; x=1752912517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cvcj8WbhMtIUXFR9GVqpeL13vSyUhacuL+uVhzrnsqM=;
        b=resapr6xDbztUE7IWbFPFpspWHx0YHXyOG2Ik+Xy+gQK2qreHHMSKLcEXFvdOrL0WL
         bm6W3j63e8Be+4n1QXrCk9PSozzfDu5+QLslQ1iTBU4a07Yuk6yPe/73FdDHZfd9tm47
         jzPRsJq9+SKkkquMEpSkduMHTHgRyZl/+HmNRFe4uh3T2cS9qrAa8OexbycSOmv7QvV1
         s97jKf2Dft3XmrSbwM9JUaizA+vPKkWen83pCBwXkUWFQMptlz/143kV4gZnaXkracmV
         4egf5L0P9619ZTpgxl2Kui0C4+Jj/LiXiPUIUWcWWhDOr1knajPZ5GewaNEgjaBJmEgH
         7U8g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8Q1i3bKzL1dSbKMZkyN/zojplZxCcLILOesXxL0RXSXHHHXsU3j+OBFa8b9uuw+FbEceE8Me30DxzRyp@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNpmgsLCgLz0eE8NcZUyTE9BvANz3y3u2FG6pY9+dkp5OZWrP
	YEbhDv/mV7cGhmYgiuCAGNc7JDv1zTgC5jYfThrWSc9RBktB/NbvAXUWyCu+EeQzAf1xf2JEvQH
	IuBlZDP4A9w+8YGsbVA9WtDN3C4VFUXQ=
X-Gm-Gg: ASbGncvit5M6ZJ04JZyumZef6XXRla1qmvUd9IABG5v+rK1ZWVh+DMtMH1t9JNW4kmU
	9+E2wLBnKrsHgj8EeSU9wjmD85+tLhx9tAh498jdF2NHYMpL3bZq2rtDyK/L5D132Xo6YFOanHj
	Hxf8PCv9Y7z/rOtQWMn9EY5TzSqFzAF7z93dD3lX7RNCvf4oUd+lKIER1Bv9FEVB1mfFwirvgBZ
	kpWXtZIHb2I/5gnng==
X-Google-Smtp-Source: AGHT+IH1u9NI/zJRnifZbsOFKy8zs0SJvRL2xwq+GiJMHhbIFlHdNA9kRhTKFZ1n5xzL9z5qheaGyiTuICCUkQ7WjAs=
X-Received: by 2002:a05:6000:491b:b0:3b5:e244:52f9 with SMTP id
 ffacd0b85a97d-3b5f35857d0mr5200937f8f.40.1752307717173; Sat, 12 Jul 2025
 01:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
 <20250711223041.1249535-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250711223041.1249535-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Jul 2025 10:08:25 +0200
X-Gm-Features: Ac12FXykbhLZHLIBVDT7LXT8zywouz12IZxFn9LLvZzsYlCld9iqGF2GvNQ7QPI
Message-ID: <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 12:37=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta=
.com> wrote:
>
> > On Thu, Jul 3, 2025 at 4:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 03-07-25 10:27:17, Amir Goldstein wrote:
> > > > On Thu, Jul 3, 2025 at 9:10=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirde=
h@meta.com> wrote:
> > > > >
> > > > > > On Wed, Jul 2, 2025 at 6:15=E2=80=AFPM Jan Kara <jack@suse.cz> =
wrote:
> > > > > > > Eventually the new service starts and we are in the situation=
 I describe 3
> > > > > > > paragraphs above about handling pending events.
> > > > > > >
> > > > > > > So if we'd implement resending of pending events after group =
closure, I
> > > > > > > don't see how default response (at least in its current form)=
 would be
> > > > > > > useful for anything.
> > > > > > >
> > > > > > > Why I like the proposal of resending pending events:
> > > > > > > a) No spurious FAN_DENY errors in case of service crash
> > > > > > > b) No need for new concept (and API) for default response, ju=
st a feature
> > > > > > >    flag.
> > > > > > > c) With additional ioctl to trigger resending pending events =
without group
> > > > > > >    closure, the newly started service can simply reuse the
> > > > > > >    same notification group (even in case of old service crash=
) thus
> > > > > > >    inheriting all placed marks (which is something Ibrahim wo=
uld like to
> > > > > > >    have).
> > > > > >
> > > > >
> > > > > I'm also a fan of the approach of support for resending pending e=
vents. As
> > > > > mentioned exposing this behavior as an ioctl and thereby removing=
 the need to
> > > > > recreate fanotify group makes the usage a fair bit simpler for ou=
r case.
> > > > >
> > > > > One basic question I have (mainly for understanding), is if the F=
AN_RETRY flag is
> > > > > set in the proposed patch, in the case where there is one existin=
g group being
> > > > > closed (ie no handover setup), what would be the behavior for pen=
ding events?
> > > > > Is it the same as now, events are allowed, just that they get res=
ent once?
> > > >
> > > > Yes, same as now.
> > > > Instead of replying FAN_ALLOW, syscall is being restarted
> > > > to check if a new watcher was added since this watcher took the eve=
nt.
> > >
> > > Yes, just it isn't the whole syscall that's restarted but only the
> > > fsnotify() call.
>
> I was trying out the resend patch Jan posted in this thread along with a
> simple ioctl to trigger the resend flow - it worked well, any remaining
> concerns with exposing this functionality? If not I could go ahead and
> pull in Jan's change and post it with additional ioctl.

I do not have any concern about the retry behavior itself,
but about the ioctl, feature dependency and test matrix.

Regarding the ioctl, it occured to me that it may be a foot gun.
Once the new group interrupts all the in-flight events,
if due to a userland bug, this is done without full collaboration
with old group, there could be nasty races of both old and new
groups responding to the same event, and with recyclable
ida response ids that could cause a real mess.

Of course you can say it is userspace blame, but the smooth
handover from old service to new service instance is not always
easy to get right, hence, a foot gun.

If we implement the control-fd/queue-fd design, we would
not have this problem.
The ioctl to open an event-queue-fd would fail it a queue
handler fd is already open.
IOW, the handover is kernel controlled and much safer.
For the sake of discussion let's call this feature
FAN_CONTROL_FD and let it allow the ioctl
IOC_FAN_OPEN_QUEUE_FD.

The simpler functionality of FAN_RETRY_UNANSWERED
may be useful regardless of the handover ioctl (?), but if we
agree that the correct design for handover is the control fd design,
and this design will require a feature flag anyway,
then I don't think that we need two feature flags.

If users want the retry unanswered functionality, they can use the
new API for control fd, regardless of whether they intend to store
the fd and do handover or not.

The control fd API means that when a *queue* fd is released,
events remain in pending state until a new queue fd is opened
and can also imply the retry unanswered behavior,
when the *control* fd is released.

I don't think there is much to lose from this retry behavior.
The only reason we want to opt-in for it is to avoid surprises of
behavior change in existing deployments.

While we could have FAN_RETRY_UNANSWERED as an
independent feature without a handover ioctl,
In order to avoid test matrix bloat, at least for a start (we can relax lat=
er),
I don't think that we should allow it as an independent feature
and especially not for legacy modes (i.e. for Anti-Virus) unless there
is a concrete user requesting/testing these use cases.

Going on about feature dependency.

Practically, a handover ioctl is useless without
FAN_REPORT_RESPONSE_ID, so for sure we need to require
FAN_REPORT_RESPONSE_ID for the handover ioctl feature.

Because I do not see an immediate use case for
FAN_REPORT_RESPONSE_ID without handover,
I would start by only allowing them together and consider relaxing
later if such a use case is found.

I will even consider taking this further and start with
FAN_CLASS_PRE_CONTENT_FID requiring
both the new feature flags.

Currently my pre-dir-content patches allow reporting event->fd,
but that is only because they *can* not because they *should*.
Whether or not we want to allow pre-dir-content events with
event->fd is still an open question.

Until we have an answer to this question based on use case,
once again, I prefer the conservative way of merging the
maximal-restrictions/minimal-test-matrix and I would like to
require  FAN_REPORT_RESPONSE_ID and control fd for
FAN_CLASS_PRE_CONTENT_FID.

This rant became longer than I had intended.

Am I missing anything about meta use cases
or the risks in the resend pending events ioctl?

Thanks,
Amir.

