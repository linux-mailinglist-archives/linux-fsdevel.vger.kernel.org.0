Return-Path: <linux-fsdevel+bounces-55138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4259B07377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D37562EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45084233722;
	Wed, 16 Jul 2025 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WegJomiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98E194A60
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661916; cv=none; b=DWSPTg92p1ZlxsdOSi6aBj4wJOb13gc9dK4a4pP1ebLv+tLsA0j6MKTjBegaflzCuzF/ogJXkzJxllkp+2VkELqViZ7Trtu24to30jWlOlapE2662H4w/gb/LXWeNwK/Sgno+sjeJudWw4evS6Rowdi+jJKnadmLwSSUlB2LAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661916; c=relaxed/simple;
	bh=gr5QG0YH2UpPzGHX1KHPcof2oOLL8zjJpR3OXyrugsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+mpYIVGynjCUgxl1er5JIQMyNEyCN+SSeZqQ5tL/I7SfeeQlzRjl162laYM3QqviNkqUBl0FN1EN9H0Ix2gJQVFc+ORrEGMKLUDUQ37dlQeY5pPZHwkP1INFGM5/mTJXJUeJ7jkQyHj6kzzko+BGzbL4xOY8wjEXch/eaVFHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WegJomiq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so1240874666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752661913; x=1753266713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhL2AoE2ythlEoecizp5TatYHcmxLK30nxCN89DwVmc=;
        b=WegJomiqrI0zY3IwqDfr2tCeJyCYMkYt1oAhWo3PAfc0H0LL2S1Lt7Y+SLaviimpiu
         0r9PKXUDPkrUlXWSDp7L4hwLxQ5hSNH4SSmaOPv1fJoixoKEv+xTWKPRI8yiYS8ZSJXz
         RF3oZFIe9cmxsRlafmbXEISEgwa/gIjoTruAIvSfBjLjO+Pa6xLg/sxRQqRgUjox8bZx
         EbPDvHx6uEhIRgTBDwVwArY2ve/ZdA4T1qfcTe86mA99CRhJlLqk6xsb21nQItkZjWzk
         Nrvb3oNtldTSDE0LAUC9IEa+ECrrlsypxW3VsasHGQseawfPfAGDKTZbGaF/T7DXWutE
         3dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661913; x=1753266713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhL2AoE2ythlEoecizp5TatYHcmxLK30nxCN89DwVmc=;
        b=gtJVxxMJWMXPnieyzOt16wlSZ9KqrTTxVuRj0Yi3NurBxtglP7NrcTCLeHOZ/Htdh5
         J80KmtimJK45uiWiVTUENGXc0k1Cp/w1scXflT3KWczacMJEm0qFVxEBRLATIuX8Xzyu
         UO9WEJJNh1d2tqiae7dsWfErsf0lP3TymxCeRyh8dvevRuJOqdsRxf7VMXgwMb1ivKmK
         pJdcM95qUosIJMYGKzSf2jQ15AtjqiE3XlpNwxymIyp96FAj+JUr4MbeWqsWJLule1Pa
         QTKHwg6Y1czCslNfEGI8SWsd5j7tVKXzWRWO+tSJQ0FlqHJD9lv8hI+ZtX73fh3tEJtz
         insA==
X-Forwarded-Encrypted: i=1; AJvYcCV0XaK6NOTTqDRKm8Z1hv14q2+U7emk3Nvj1CkU/d/axQAZ6Rtv1CvlTP8xiQSSa5JcrQoMAL0PgrC5Z5mC@vger.kernel.org
X-Gm-Message-State: AOJu0YyfvVov0v5l67eUDc83RnJ7/mP4yACjZO2tNI4LmAoH1MsM06Mk
	f776/Nml3DqNT6fGHBtJCbPZltL4RDt/YHyCfeGGFwbgtN1Jak8w5JLrMOIJXh2wM46EbCGlx6t
	nFZZZROgbNYGTZyqfhMetopBN5q+ppgk=
X-Gm-Gg: ASbGncuXbpI3VNw+KNZd7vrhn3Ke1gqyvge3BDJ2vdTwvxe0EfTVm7Lcg47mi+01k5n
	rNfjQgtWMEaQxh6NC+CcO+sD+qYEdGowFe30+ZMZu3VyPU96kn/eXpuqAE/Do4QVZ+2xuEbjaLr
	yBX+SOrnOCelE420C3NJOIT2a9snyeHRczB2IWtEEJSUmFXv//nyz7nBOfrPuaD/ugdX3r9fOxs
	t6xr+g=
X-Google-Smtp-Source: AGHT+IEYwTjsWEgRbWLzxeUWWCvDsAKwlVBlmYPkETt+WzHGwh6xYuKPf6KwZE35YRWWGSO0Qd5K3T+NUK5wD5hPG+8=
X-Received: by 2002:a17:907:f1e9:b0:ae0:635c:a400 with SMTP id
 a640c23a62f3a-ae9ce196c5fmr186168466b.51.1752661912602; Wed, 16 Jul 2025
 03:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
 <20250711223041.1249535-1-ibrahimjirdeh@meta.com> <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
 <sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn>
 <CAOQ4uxj6EF5G=0RAE45ovVLqbro9TJP-WdP-ixwAgnr7zg-2wA@mail.gmail.com>
 <f5xtqk4gpbeowtnbiegbfosnpjr4ge42rfebjgyz66cxxzmhse@fjn44egzgdpt>
 <CAOQ4uxiPwaq5J9iDAjEQuP4QSXfxi8993ShpAJRfYQA3Dd0Vrg@mail.gmail.com> <fiur7goc4ber7iwzkvm6ufbnulxkvdlfwqe2wjq3w3zcw73eit@cvhs5ndfkhcq>
In-Reply-To: <fiur7goc4ber7iwzkvm6ufbnulxkvdlfwqe2wjq3w3zcw73eit@cvhs5ndfkhcq>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 12:31:41 +0200
X-Gm-Features: Ac12FXzDqDGvmkvFpRR5-il3my963mQfFaQtmGMadIdmywMwlYD1g-Oe9BaomWc
Message-ID: <CAOQ4uxhwQaDaq+LUtMggY9bkPECNHDYQKgh8Dfe0-iDm7FiLbA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:55=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 15-07-25 16:50:00, Amir Goldstein wrote:
> > On Tue, Jul 15, 2025 at 2:11=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 14-07-25 21:59:22, Amir Goldstein wrote:
> > > > On Mon, Jul 14, 2025 at 7:25=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > > > I don't think there is much to lose from this retry behavior.
> > > > > > The only reason we want to opt-in for it is to avoid surprises =
of
> > > > > > behavior change in existing deployments.
> > > > > >
> > > > > > While we could have FAN_RETRY_UNANSWERED as an
> > > > > > independent feature without a handover ioctl,
> > > > > > In order to avoid test matrix bloat, at least for a start (we c=
an relax later),
> > > > > > I don't think that we should allow it as an independent feature
> > > > > > and especially not for legacy modes (i.e. for Anti-Virus) unles=
s there
> > > > > > is a concrete user requesting/testing these use cases.
> > > > >
> > > > > With queue-fd design I agree there's no reason not to have the "r=
esend
> > > > > pending events" behavior from the start.
> > > > >
> > > > > > Going on about feature dependency.
> > > > > >
> > > > > > Practically, a handover ioctl is useless without
> > > > > > FAN_REPORT_RESPONSE_ID, so for sure we need to require
> > > > > > FAN_REPORT_RESPONSE_ID for the handover ioctl feature.
> > > > > >
> > > > > > Because I do not see an immediate use case for
> > > > > > FAN_REPORT_RESPONSE_ID without handover,
> > > > > > I would start by only allowing them together and consider relax=
ing
> > > > > > later if such a use case is found.
> > > > >
> > > > > We can tie them together but I think queue-fd design doesn't requ=
ire
> > > > > FAN_REPORT_RESPONSE_ID. Since we resend events anyway, we'd gener=
ate new
> > > > > fds for events as well and things would just work AFAICT.
> > > > >
> > > >
> > > > Right. hmm.
> > > > I'd still like to consider the opportunity of the new-ish API for
> > > > deprecating some old legacy API baggage.
> > > >
> > > > For example: do you consider the fact that async events are mixed
> > > > together with permission/pre-content events in the same queue
> > > > an historic mistake or a feature?
> > >
> > > So far I do consider it a feature although not a particularly useful =
one.
> > > Given fanotify doesn't guarantee ordering of events and async events =
can
> > > arbitrarily skip over the permission events there's no substantial
> > > difference to having two notification groups.
> >
> > I am not sure I understand your claim.
> > It sounds like you are arguing for my case, because mixing
> > mergeable async events and non-mergeable permission events
> > in the same queue can be very confusing.
> > Therefore, I consider it an anti-feature.
> > Users can get the same functionality from having two groups,
> > with much more sane semantics.
>
> I'd say with the same semantics but less expectations about possibly nice=
r
> semantics :). But we agree two groups are a cleaner way to achieve the
> same and give userspace more flexibility with handling the events at the
> same time.
>
> > > > I'm tempted, as we split the control fd from the queue fd to limit
> > > > a queue to events of the same "type".
> > > > Maybe an O_RDONLY async queue fd
> > > > or an O_RDWR permission events queue fd
> > > > or only allow the latter with the new API?
> > >
> > > There's value in restricting unneeded functionality and there's also =
value
> > > in having features not influencing one another so the balance has to =
be
> > > found :).
> >
> > <nod>
> >
> > > So far I don't find that disallowing async events with queue fd
> > > or restricting fd mode for queue fd would simplify our life in a
> > > significant way but maybe I'm missing something.
> > >
> >
> > It only simplifies our life if we are going to be honest about test cov=
erage.
> > When we return a pending permission events to the head of the queue
> > when queue fd is closed, does it matter if the queue has async events
> > or other permission events or a mix of them?
> >
> > Logically, it shouldn't matter, but assuming that for tests is not the
> > best practice.
>
> Agreed.
>
> > Thus, reducing the test matrix for a new feature by removing a
> > configuration that I consider misguided feels like a good idea, but I a=
m
> > also feeling that my opinion on this matter is very biased, so I'd be
> > happy if you can provide a more objective decision about the
> > restrictions.
>
> Heh, nobody is objective :). We are all biased by our past experiences.
> Which is why discussing things together is so beneficial. I agree about
> the benefit of simplier testing and that hardly anybody is going to miss
> the functionality, what still isn't 100% clear to me how the restrictions
> would be implemented in the API. So user creates fanotify_group() with
> control fd feature flag. Now will he have to specify in advance whether t=
he
> group is for permission events or not? Already when creating the group
> (i.e., another feature flag? Or infered from group priority?)? Or when
> creating queue fd? Or will the group switch based on marks being placed t=
o
> it? I think explicit selection is less confusing than implicit by placed
> marks. Using group priority looks appealing at first sight but currently
> group priorities also have implications about order in which we deliver
> events (both async and permission) to groups and it would be also somewha=
t
> confusing that FAN_CLASS_PRE_CONTENT groups may still likely use
> FAN_OPEN_PERM event. So maybe it's not that great fit. Hum... Or we can
> have a single feature flag (good name needed!) that will create group wit=
h
> control fd *and* restricted to permission events only. That actually seem=
s
> like the least confusing option to me now.

I was thinking inferred from group priority along with control fd feature f=
lag,
but I agree that being more explicit is better.

How about tying the name to your FAN_RETRY patch
and including its functionality along with the control fd:

FAN_RESTARTABLE_EVENTS
       Events for fanotify groups initialized with this flag will be restar=
ted
       if the group file descriptor is closed after reading the
permission events
       and before responding to the event.
       This means that if an event handler program gets stuck, a new event
       handler can be started before killing the old event handler,
without missing
       the permission event.
       The file descriptor returned from fanotify_init() cannot be
used to read and
       respond to permission events, only to configure marks.
       The IOC_FAN_OPEN_QUEUE_FD ioctl is required to acquire a secondary
       event queue file descriptor.  This event queue file descriptor is us=
ed to
       read the permission events and respond to them.
       When the queue file descriptor is closed, events that were read from=
 the
       queue but not responded to, are returned to the queue and can be han=
dled
       by another instance of the program that opens a new queue file
descriptor.
       The use of either FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT
       is required along with this flag.
       Only permission events and pre-content events are allowed to be
set in mark
       masks of a group that was initialized with this flag.

Thanks,
Amir.

