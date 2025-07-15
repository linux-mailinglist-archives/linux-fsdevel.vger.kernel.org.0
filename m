Return-Path: <linux-fsdevel+bounces-54988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCFAB061FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D861C2319F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6511F4CBE;
	Tue, 15 Jul 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgqHNwW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23661531E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591016; cv=none; b=qEHhNo67TvXkk4+iGuYGi737CA+4/6WjilqjTaCW0slQiu00JYehdhIyNav5dj1bbQ4oJa2DP121zrO1uCO9SkkLpJhhPxO5VZ0E4RRlGlH2tH8MlwMkD7ECep2ZK1yGcDT1dIaA6ChcSNotRa9haBngcRmDyHm9MSl8niDqDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591016; c=relaxed/simple;
	bh=/MdFCOQZw8RoJCrTmncbOmjBAsxyX3NXHVvl/vkjl7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9ZZipmPBdGdvII6PodoGMDBe4AsG8iZXQOXZG/zmsLmfeFLQIVi2ycU43uOCLcMiHkzBJMjQVwZATFapEmG67JFba6nmymiDaN6XWAxZ2e4qn9LKiUqeQohfbzm6/jQ8Z6twQxKj6EXp6/x08L6A3H/VMXPQezqQ0tkwYY1IBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgqHNwW0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so13510302a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752591013; x=1753195813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MdFCOQZw8RoJCrTmncbOmjBAsxyX3NXHVvl/vkjl7Y=;
        b=JgqHNwW039Nf4RCwSKWtR6fz+6WUObUvX+JKld8F4muvK9xz0M58vUTEHMIy8yUnYh
         kEreMHUWkG8MCaAw26aeW3+PZI3AMsfkakP0doxFuMi8T7bE0IL/+VBZjtOaB6i0rs3p
         I20BA/6u/ti4SOUnH1ilCjuUy1BBGkGj8wl9ZRRyoY8h+/LJVO+LzihLz9ardm66KXqL
         Og03Ukavdef1NgSIrLy0SdM8Lwbk/ql+nfW2u5K/PAPx84/YL3xwV1bs0wkruOQCSIHl
         OnILXxPgIMCNB89fcCdHGEcr1iZ2twnwWYJzweDMtHGu6Sp6ZoWdSmKFZ7rrcY58ID0G
         RNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752591013; x=1753195813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MdFCOQZw8RoJCrTmncbOmjBAsxyX3NXHVvl/vkjl7Y=;
        b=mpaj9jia+O+DVlj+JtBMZTvmVx5olEpRPEtuQ+FsChCd6jOY4OyzdTHvwthdaIrU98
         SkQvdLGaGFmDSvIbpc7S/sZnGSg8lavjxiKIadGjCSORfhi9Ot010v1W0fjcuLObS8dh
         0llBq3Uxdw/Z2/98kKhJ2ir64bmBp+T8zZ4M3vWMD6In0jrSYe+K2YW574QjEkYXCQ60
         uwkP7WOBvpWAJkBflvpCprbipMk+dw0fShRH7PchRXvjWfEbhMY/JpRvhY9uQXkd8Jco
         Y5Afvcb3QM9Npcs55hJWGbz679soD/6AGHR0xZnTMDf7BCHgaAWxvwoMEBQGuycVfmPV
         TDcA==
X-Forwarded-Encrypted: i=1; AJvYcCWvICOecPVac8QXnK26/TO+w+Lw1RuupTbcXvcbT/yl1F+X76Fe+XbGeOxusaL9Om8CRUNT0IKR+HaRWdbd@vger.kernel.org
X-Gm-Message-State: AOJu0YymaJPZ1am+EOEVmIs5vLLjY3c53ubXX1bEIjmIAvhoMSb89b/p
	jaGkX9hOaFeRm2FrjGFWFbP5hC2vr+23GtJdvH30g2nCTIBf+uuXCUc94vp7A7c0asWIl7O90ia
	7smLhcaypRisxmPX3x3sqH5Z0MZocTf6lO/rOsBs=
X-Gm-Gg: ASbGncsoxgiP//XuZRtcTlZZNGF9mRKtiwrRskw0r6c1cIvU+iwzoB1JtAFUc9SxQaA
	ZAiiQcuCiEv9Y0f0f2e2FjYNQldyDPOiOiyy5rBR0zwcrgfWqM5rQ9BmQNYQ2hIUhNuq0IB2LYL
	OWlBsrHp95Ji+/uVrYBklQHNkhSo/dVv0hS+vY4tHYFK0yTTZ94jecfA42j1lXsi4PkRNHur7Zu
	qEWkes=
X-Google-Smtp-Source: AGHT+IG3JEZdUk9ncwLKWAwtr9tOjUCKC8ncovRA1rwXjh6YDDobZ+Vp7tEnpY+1MTQLw12GFRFLsDvSygo1a7R5nhI=
X-Received: by 2002:a17:907:f810:b0:ae0:a465:1c20 with SMTP id
 a640c23a62f3a-ae9b5c2bf92mr403473766b.14.1752591012458; Tue, 15 Jul 2025
 07:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
 <20250711223041.1249535-1-ibrahimjirdeh@meta.com> <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
 <sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn>
 <CAOQ4uxj6EF5G=0RAE45ovVLqbro9TJP-WdP-ixwAgnr7zg-2wA@mail.gmail.com> <f5xtqk4gpbeowtnbiegbfosnpjr4ge42rfebjgyz66cxxzmhse@fjn44egzgdpt>
In-Reply-To: <f5xtqk4gpbeowtnbiegbfosnpjr4ge42rfebjgyz66cxxzmhse@fjn44egzgdpt>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 Jul 2025 16:50:00 +0200
X-Gm-Features: Ac12FXw89I3DCU4kdg4f4i8Xk6mNnI6MSQOInEfNc5vRmMpJv5YXXUNcXIYEO5w
Message-ID: <CAOQ4uxiPwaq5J9iDAjEQuP4QSXfxi8993ShpAJRfYQA3Dd0Vrg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 2:11=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 14-07-25 21:59:22, Amir Goldstein wrote:
> > On Mon, Jul 14, 2025 at 7:25=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > > I don't think there is much to lose from this retry behavior.
> > > > The only reason we want to opt-in for it is to avoid surprises of
> > > > behavior change in existing deployments.
> > > >
> > > > While we could have FAN_RETRY_UNANSWERED as an
> > > > independent feature without a handover ioctl,
> > > > In order to avoid test matrix bloat, at least for a start (we can r=
elax later),
> > > > I don't think that we should allow it as an independent feature
> > > > and especially not for legacy modes (i.e. for Anti-Virus) unless th=
ere
> > > > is a concrete user requesting/testing these use cases.
> > >
> > > With queue-fd design I agree there's no reason not to have the "resen=
d
> > > pending events" behavior from the start.
> > >
> > > > Going on about feature dependency.
> > > >
> > > > Practically, a handover ioctl is useless without
> > > > FAN_REPORT_RESPONSE_ID, so for sure we need to require
> > > > FAN_REPORT_RESPONSE_ID for the handover ioctl feature.
> > > >
> > > > Because I do not see an immediate use case for
> > > > FAN_REPORT_RESPONSE_ID without handover,
> > > > I would start by only allowing them together and consider relaxing
> > > > later if such a use case is found.
> > >
> > > We can tie them together but I think queue-fd design doesn't require
> > > FAN_REPORT_RESPONSE_ID. Since we resend events anyway, we'd generate =
new
> > > fds for events as well and things would just work AFAICT.
> > >
> >
> > Right. hmm.
> > I'd still like to consider the opportunity of the new-ish API for
> > deprecating some old legacy API baggage.
> >
> > For example: do you consider the fact that async events are mixed
> > together with permission/pre-content events in the same queue
> > an historic mistake or a feature?
>
> So far I do consider it a feature although not a particularly useful one.
> Given fanotify doesn't guarantee ordering of events and async events can
> arbitrarily skip over the permission events there's no substantial
> difference to having two notification groups.

I am not sure I understand your claim.
It sounds like you are arguing for my case, because mixing
mergeable async events and non-mergeable permission events
in the same queue can be very confusing.
Therefore, I consider it an anti-feature.
Users can get the same functionality from having two groups,
with much more sane semantics.

> If you can make a good case
> of what would be simpler if we disallowed that I'm open to consider
> disallowing that.
>

Clearly, handling permission events should have had higher priority,
but we do not have a priority queue, nor do we provide any means
for userspace to handle permission events before async events.

Nudging users to separate the events of different urgency to
different queues/groups can allow userspace to read from the
higher priority fd first as they should.

> > I'm tempted, as we split the control fd from the queue fd to limit
> > a queue to events of the same "type".
> > Maybe an O_RDONLY async queue fd
> > or an O_RDWR permission events queue fd
> > or only allow the latter with the new API?
>
> There's value in restricting unneeded functionality and there's also valu=
e
> in having features not influencing one another so the balance has to be
> found :).

<nod>

> So far I don't find that disallowing async events with queue fd
> or restricting fd mode for queue fd would simplify our life in a
> significant way but maybe I'm missing something.
>

It only simplifies our life if we are going to be honest about test coverag=
e.
When we return a pending permission events to the head of the queue
when queue fd is closed, does it matter if the queue has async events
or other permission events or a mix of them?

Logically, it shouldn't matter, but assuming that for tests is not the
best practice.
Thus, reducing the test matrix for a new feature by removing a
configuration that
I consider misguided feels like a good idea, but I am also feeling
that my opinion
on this matter is very biased, so I'd be happy if you can provide a more
objective decision about the restrictions.

> > Please note that FAN_CLOEXEC and FAN_NONBLOCK
> > currently apply to the control fd.
> > I guess they can also apply to the queue fd,
> > Anyway the control fd should not be O_RDWR
> > probably O_RDONLY even though it's not for reading.
>
> I guess the ioctl to create queue fd can take desired flags for the queue
> fd so we don't have to second guess what the application wants.
>

Correct, but note that FAN_NONBLOCK is meaningless
to the io-less control fd.

Thanks,
Amir.

