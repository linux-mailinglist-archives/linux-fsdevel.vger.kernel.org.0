Return-Path: <linux-fsdevel+bounces-54879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D0B0482E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5303A8F0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792DD246BD9;
	Mon, 14 Jul 2025 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilnCb2IZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F622083
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523177; cv=none; b=h193CqDMBM47/sQtETRCCgLXcDTVlh9ZO/eBdjASdF+DTYojgsN9UoZb1vuib0BW6GhKoiKac/nvy1X71wxLHEgqcxRweIdiDOuWcHerppvfSWN6AcPZ913p347RM5Sx4Jvbk9rEVszVVD+wgoxJQElNS6SHGu3Ix5309zGR+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523177; c=relaxed/simple;
	bh=oQTyodSNbW5xD6dVQHQL2XBVMfnrXB+rNZmBT4wd6Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jySTji8HVvZoDz5y2fGFpQs6TdENZtQARpvnEr8ue6ZGVgyyIhpx2xNEBuHCofz/j6xDAs0oEmvnJsJhqeZ9siiAxJT1y2sabRucF6Xfqp93vR2hywj+3LXNPq3AHmPxbHVAR21MNAEUE22buqrQagF93cGhXlezYZjtSetmfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilnCb2IZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1189936366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752523174; x=1753127974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0hJHPy1IhLWeKDC6u165+BeW2SDTYk/X30Y05+ca3g=;
        b=ilnCb2IZEkcmt4xOgDYWa7q/htp03k0XhXw/NmgBXXqqKL97n9X8X5CkwtwXCCUWT/
         5Fpa8yOTkuV8B3gvTbMI0OuYwBInvIHXzkBKCYGAnYmaAXN8BOH+ZZRr0R0n4Ix5RfGV
         g9Rn7wn66R/b1qofk1zfJcKcvOZUHY9XnYeg+wyW+JPaPBhfQTpSjQAvZwn1980Y/ysP
         ufydNvBvgZhrOd1ZuH3kKmj7PNJml1Gp5lBlavI04N6VmaR2EoYphsMHum1R0v05uAQw
         howS9W+Xh1puSncLnKNE8M2GgZnytiTErUYEicoWXB+6jDhfkgxiOXEd9cQxtwfmPpVv
         DC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752523174; x=1753127974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0hJHPy1IhLWeKDC6u165+BeW2SDTYk/X30Y05+ca3g=;
        b=YV8vBHZpR4xHr86PEnlv/jCUNvazv6csv6SdbQHUuI4dcrPmGPGNilvarmqt1OkCgT
         2Ov7sx9FbzO8TsqaSlhJAnDaNlYTbiqM4yXCvrF0jW+ycq2QEzLD9Y9fjXfvfy/MlQ1B
         N/SBqcfId3/Q+AG5Vqa4WbJpqbIW2pkMjML0LZoY5L1vu6PYfZ2NlH0+3GkP32TD0X3D
         TQzPDwEl9Sdk7QGuAIO/37cccX8fIGEly1IZyhJq0GyXO3oZroKcQxEC6c9oYekNPGj3
         s78dmDIZvJ3Ih3wScsmNRjf4qDnMsArRI2Vjfmpmk0jwFi9gYrVp8c3BGePhlv6UBh/Z
         FGTg==
X-Forwarded-Encrypted: i=1; AJvYcCUTha3+RWNaZruz1WdNICOpQWN4zcrIsDYvIX5SduEOlFaZcrw5gZspTcGqSO6hzZExXJ+GitgMBN44+odC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3c/fw5jruh80qm+Oimw9lWRXHKZTnK01SKfvmVeJxjicfNz2T
	IJqbXceU+wDI5PlNfXOLN3AA/Tbt2VdFkJV/xJ4/BoqA2ldvSUEOXeABe5hxuESr9Wd3ov+zE9X
	b8+Xqy+huIRLM4/3fgVXz0TxTKQZUGTpLn/ynedpsHw==
X-Gm-Gg: ASbGncuhEaaubEYAsFMX/PVwyVPPYMc4i1wSTa1UeYSQAh0/19P69XI0UsvaDX8HW05
	jjVikMucNcMhm9FT768S1HDxyBebfhDHsSRs9LuWQ+Fz3cAIb81cIxbKKNiqCtAK8u/OEimMvDD
	KSfaBZdKGLQLQ8fVxDhznp+SoD846jPAMTU5Wb0k94U2R55e+6CHfk5vxO4+5CTmYWltmQrH7sK
	+JfIRk=
X-Google-Smtp-Source: AGHT+IEYwxganDgWdPxIT+pJuCExk0qIMeVWDWeFMkMdNfYkPK+NtRz6/7nyPB0g2oH6TWsWGb5MSiwT0zi8gbdlXoM=
X-Received: by 2002:a17:907:a08d:b0:ae3:c72f:6383 with SMTP id
 a640c23a62f3a-ae9b5c2f52emr85701566b.17.1752523173969; Mon, 14 Jul 2025
 12:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
 <20250711223041.1249535-1-ibrahimjirdeh@meta.com> <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
 <sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn>
In-Reply-To: <sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Jul 2025 21:59:22 +0200
X-Gm-Features: Ac12FXyToJBVNpBecYssH9WMr7GHCRNZ9mwNJdjRVyDRjuUAPBJ2BXMvOX8SXEY
Message-ID: <CAOQ4uxj6EF5G=0RAE45ovVLqbro9TJP-WdP-ixwAgnr7zg-2wA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:25=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 12-07-25 10:08:25, Amir Goldstein wrote:
> > On Sat, Jul 12, 2025 at 12:37=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@=
meta.com> wrote:
> > >
> > > > On Thu, Jul 3, 2025 at 4:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > >
> > > > > On Thu 03-07-25 10:27:17, Amir Goldstein wrote:
> > > > > > On Thu, Jul 3, 2025 at 9:10=E2=80=AFAM Ibrahim Jirdeh <ibrahimj=
irdeh@meta.com> wrote:
> > > > > > >
> > > > > > > > On Wed, Jul 2, 2025 at 6:15=E2=80=AFPM Jan Kara <jack@suse.=
cz> wrote:
> > > > > > > > > Eventually the new service starts and we are in the situa=
tion I describe 3
> > > > > > > > > paragraphs above about handling pending events.
> > > > > > > > >
> > > > > > > > > So if we'd implement resending of pending events after gr=
oup closure, I
> > > > > > > > > don't see how default response (at least in its current f=
orm) would be
> > > > > > > > > useful for anything.
> > > > > > > > >
> > > > > > > > > Why I like the proposal of resending pending events:
> > > > > > > > > a) No spurious FAN_DENY errors in case of service crash
> > > > > > > > > b) No need for new concept (and API) for default response=
, just a feature
> > > > > > > > >    flag.
> > > > > > > > > c) With additional ioctl to trigger resending pending eve=
nts without group
> > > > > > > > >    closure, the newly started service can simply reuse th=
e
> > > > > > > > >    same notification group (even in case of old service c=
rash) thus
> > > > > > > > >    inheriting all placed marks (which is something Ibrahi=
m would like to
> > > > > > > > >    have).
> > > > > > > >
> > > > > > >
> > > > > > > I'm also a fan of the approach of support for resending pendi=
ng events. As
> > > > > > > mentioned exposing this behavior as an ioctl and thereby remo=
ving the need to
> > > > > > > recreate fanotify group makes the usage a fair bit simpler fo=
r our case.
> > > > > > >
> > > > > > > One basic question I have (mainly for understanding), is if t=
he FAN_RETRY flag is
> > > > > > > set in the proposed patch, in the case where there is one exi=
sting group being
> > > > > > > closed (ie no handover setup), what would be the behavior for=
 pending events?
> > > > > > > Is it the same as now, events are allowed, just that they get=
 resent once?
> > > > > >
> > > > > > Yes, same as now.
> > > > > > Instead of replying FAN_ALLOW, syscall is being restarted
> > > > > > to check if a new watcher was added since this watcher took the=
 event.
> > > > >
> > > > > Yes, just it isn't the whole syscall that's restarted but only th=
e
> > > > > fsnotify() call.
> > >
> > > I was trying out the resend patch Jan posted in this thread along wit=
h a
> > > simple ioctl to trigger the resend flow - it worked well, any remaini=
ng
> > > concerns with exposing this functionality? If not I could go ahead an=
d
> > > pull in Jan's change and post it with additional ioctl.
> >
> > I do not have any concern about the retry behavior itself,
> > but about the ioctl, feature dependency and test matrix.
> >
> > Regarding the ioctl, it occured to me that it may be a foot gun.
> > Once the new group interrupts all the in-flight events,
> > if due to a userland bug, this is done without full collaboration
> > with old group, there could be nasty races of both old and new
> > groups responding to the same event, and with recyclable
> > ida response ids that could cause a real mess.
> >
> > Of course you can say it is userspace blame, but the smooth
> > handover from old service to new service instance is not always
> > easy to get right, hence, a foot gun.
> >
> > If we implement the control-fd/queue-fd design, we would
> > not have this problem.
> > The ioctl to open an event-queue-fd would fail it a queue
> > handler fd is already open.
> > IOW, the handover is kernel controlled and much safer.
> > For the sake of discussion let's call this feature
> > FAN_CONTROL_FD and let it allow the ioctl
> > IOC_FAN_OPEN_QUEUE_FD.
>
> I agree this is probably a safer variant.
>
> > The simpler functionality of FAN_RETRY_UNANSWERED
> > may be useful regardless of the handover ioctl (?), but if we
> > agree that the correct design for handover is the control fd design,
> > and this design will require a feature flag anyway,
> > then I don't think that we need two feature flags.
> >
> > If users want the retry unanswered functionality, they can use the
> > new API for control fd, regardless of whether they intend to store
> > the fd and do handover or not.
> >
> > The control fd API means that when a *queue* fd is released,
> > events remain in pending state until a new queue fd is opened
> > and can also imply the retry unanswered behavior,
> > when the *control* fd is released.
>
> Right, given with queue-fd design we actually have clear "successor" fd
> where to report already reported but not answered events. So we can just
> move back unanswered events on close of old queue fd so they'd be reporte=
d
> again on read from the new queue fd. So there will be no need to bother
> other notification groups with resent events with this design.
>

Yes,  we'd need to be careful with this new event state transition
to make sure that we "recycle" the event properly.

> > I don't think there is much to lose from this retry behavior.
> > The only reason we want to opt-in for it is to avoid surprises of
> > behavior change in existing deployments.
> >
> > While we could have FAN_RETRY_UNANSWERED as an
> > independent feature without a handover ioctl,
> > In order to avoid test matrix bloat, at least for a start (we can relax=
 later),
> > I don't think that we should allow it as an independent feature
> > and especially not for legacy modes (i.e. for Anti-Virus) unless there
> > is a concrete user requesting/testing these use cases.
>
> With queue-fd design I agree there's no reason not to have the "resend
> pending events" behavior from the start.
>
> > Going on about feature dependency.
> >
> > Practically, a handover ioctl is useless without
> > FAN_REPORT_RESPONSE_ID, so for sure we need to require
> > FAN_REPORT_RESPONSE_ID for the handover ioctl feature.
> >
> > Because I do not see an immediate use case for
> > FAN_REPORT_RESPONSE_ID without handover,
> > I would start by only allowing them together and consider relaxing
> > later if such a use case is found.
>
> We can tie them together but I think queue-fd design doesn't require
> FAN_REPORT_RESPONSE_ID. Since we resend events anyway, we'd generate new
> fds for events as well and things would just work AFAICT.
>

Right. hmm.
I'd still like to consider the opportunity of the new-ish API for
deprecating some old legacy API baggage.

For example: do you consider the fact that async events are mixed
together with permission/pre-content events in the same queue
an historic mistake or a feature?

I'm tempted, as we split the control fd from the queue fd to limit
a queue to events of the same "type".
Maybe an O_RDONLY async queue fd
or an O_RDWR permission events queue fd
or only allow the latter with the new API?

I am not sure what the best semantics would be and I'd hate to
send Ibrahim on another walk into the woods with this added
requirement.

WDYT? Is it worth adding some limitations that may be relaxed later?
which? I'd be ok with limiting to permission events only for a start.

Ibrahim,

Please note that FAN_CLOEXEC and FAN_NONBLOCK
currently apply to the control fd.
I guess they can also apply to the queue fd,
Anyway the control fd should not be O_RDWR
probably O_RDONLY even though it's not for reading.

Thanks,
Amir.

