Return-Path: <linux-fsdevel+bounces-53814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBABAF7DA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1031CC0C9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E42EF662;
	Thu,  3 Jul 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR1OlAxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5F239099
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558959; cv=none; b=ub9tt9NOAZ2rgkaL5wTAyIzmdDqXkDB4zw6e6junIZyLnMf4txDZdvriuz2xSLya1WDMicb671S+AzG+yHtOt4YO19KgOwk/kLPBFzYINJQibDZvk4a3N/pe7y177V0y1vsm5siPRUwYXDZw1mvceHJOlT5f4uHA9nDFnMUOEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558959; c=relaxed/simple;
	bh=9dMexpUH3aV5aLJEJeF9XGFvv979Ndp7x8v5u3/XssI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJQjM461glXJ5g/GAuvjBOV4hlVTxSmOEM1r+KTMiQ6ebkQI+6bm2D9h+y0b62eVyeBZFlSlUmiG7Ee+qhRP236LPyhEe/vLOzFkRfODFwsa5rbt7dd9UP4Dcutu/MF5zMihfkfLqvM1oRtSLzQqmVH21oAYH35EISCmPgif8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR1OlAxK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3a604b43bso11340266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751558955; x=1752163755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP4tACoHZbh4VhWfrCWN7lh9GYnJuBttlYcEpFv1jXI=;
        b=PR1OlAxKWdcp6LS1aRo3W5/ZE8chbi8XEzbQerYnjZ01T2YOlAricALuMO6qyrQ8K+
         qSW2bfcu6Car/0e7nmlg18xbvKKsNq0ggqcrDdhmAVba6sBtsSBlVwZq3rXC77pJd5Gc
         xjMfUox3eM3EvCW9Kerxgypn2t6sviXqJz0Ild6onGrOf6JGbogwMo1GK8k+N6G4qhpv
         rJURyQHOsyoDA8u7qYUaFTkexa9vPT+fXmb80gkj9+JcvSskeIx68PIRkvBTnYyhKvqq
         GcrqEP3Wp/p+GxM2za+IT9m16H7EiK19AyGME0RIiq5i7PgrTTUd9rhfHUTOgeaSmmtv
         94RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558955; x=1752163755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP4tACoHZbh4VhWfrCWN7lh9GYnJuBttlYcEpFv1jXI=;
        b=fpRBxbjteFfV7bCH2y9C6O0EFUaGmrvjTVg1+2U4qZjzdeCSLelZx1rDdg6JQdXNKr
         lQnjrgxp6xEEGVG1fs7MdXPU0aW0Jaoan+Gj4h2fC3ijNYwgXQHCl0Yc0JrtHQsAPZbY
         iNqbSwLL1I3qOfs5X329mLiW970YEzSew3GRTmbv12bljbjj59j4KM07otyUUZ5wsorp
         bXWv50V/0/wmRilPRxOHducB9Eg+6LeDf4nZFUzIKZ8nG53icUd5jEttC51D2CohZkeS
         S7xIHjvGMhNuHt4c+nace8sVHes8lXEjv67QD37FbYyyDNMj43hyVZtNOh07gmxGrXoL
         KGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVtE5dY5sb2aZlKcXl0oXlGe5hs4bNh8g8BjxbtXjNHNb1rw594da9lRbpRmklXVheR7IBJy0GyD7r8CQS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jHrgE48TRhDf+MiD5JgYZLLHxnjYt2QKhIoT6yjWJ8nSdo1b
	A1tO2eANVqR8n3AaHqROVT+ex/uRy+bVfFtuustAZQngqV2z78jQh+v0qB3OcI8pjNlqBj5azuA
	4AFEGab/4sOFNKnXmPvjT3wfe7aLUUL4=
X-Gm-Gg: ASbGncu61+fkiXhwluboqZMrxQqHzfMmtqKaEEpYVEYCAjv9JUXLIY68EgoXht6H9AD
	mHSHCPehWvxZf4CCcFeG+JZfRSqj34nD+YLdZgNX9YNJXKqg5bGhwckTwUutZgOMpjfImhGNt58
	5wTrc9r3c5TtZqWAoGm3BPD8OVI1sRsAyBqp8lkIUM7buCvvoywu6RXg==
X-Google-Smtp-Source: AGHT+IGGP1HKwZM77I4tbU9tkDqur8QTuFHGdrZEsO++7UMhjoMhkR3IdrvJZaE4/PNYvrtJ8yrqIyL8e5j+oEWn8Cc=
X-Received: by 2002:a17:907:9308:b0:ae3:c521:db6 with SMTP id
 a640c23a62f3a-ae3d8baffe4mr389356766b.58.1751558954872; Thu, 03 Jul 2025
 09:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjTtyn04XC65hv2MVsRByGyvxJ0wK=-FZmb1sH1w0CFtA@mail.gmail.com>
 <20250703070916.217663-1-ibrahimjirdeh@meta.com> <CAOQ4uxgfhf6g71_8y5iXLmNVMBvYVtpPJgd9PNXQzZnqa2=CkQ@mail.gmail.com>
 <26dpu7ouochrzo4koexbwofgygqo7mhjbvswzhvqhf46i3kbvc@d6dzwpg6agoc>
In-Reply-To: <26dpu7ouochrzo4koexbwofgygqo7mhjbvswzhvqhf46i3kbvc@d6dzwpg6agoc>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Jul 2025 18:09:01 +0200
X-Gm-Features: Ac12FXxdR-Pi4UpFf7e_-tRj0eWvKQjqSxcgZfD638gDVUxfz7yuaproBR0XKBA
Message-ID: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 4:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 03-07-25 10:27:17, Amir Goldstein wrote:
> > On Thu, Jul 3, 2025 at 9:10=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@me=
ta.com> wrote:
> > >
> > > > On Wed, Jul 2, 2025 at 6:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > > Eventually the new service starts and we are in the situation I d=
escribe 3
> > > > > paragraphs above about handling pending events.
> > > > >
> > > > > So if we'd implement resending of pending events after group clos=
ure, I
> > > > > don't see how default response (at least in its current form) wou=
ld be
> > > > > useful for anything.
> > > > >
> > > > > Why I like the proposal of resending pending events:
> > > > > a) No spurious FAN_DENY errors in case of service crash
> > > > > b) No need for new concept (and API) for default response, just a=
 feature
> > > > >    flag.
> > > > > c) With additional ioctl to trigger resending pending events with=
out group
> > > > >    closure, the newly started service can simply reuse the
> > > > >    same notification group (even in case of old service crash) th=
us
> > > > >    inheriting all placed marks (which is something Ibrahim would =
like to
> > > > >    have).
> > > >
> > >
> > > I'm also a fan of the approach of support for resending pending event=
s. As
> > > mentioned exposing this behavior as an ioctl and thereby removing the=
 need to
> > > recreate fanotify group makes the usage a fair bit simpler for our ca=
se.
> > >
> > > One basic question I have (mainly for understanding), is if the FAN_R=
ETRY flag is
> > > set in the proposed patch, in the case where there is one existing gr=
oup being
> > > closed (ie no handover setup), what would be the behavior for pending=
 events?
> > > Is it the same as now, events are allowed, just that they get resent =
once?
> >
> > Yes, same as now.
> > Instead of replying FAN_ALLOW, syscall is being restarted
> > to check if a new watcher was added since this watcher took the event.
>
> Yes, just it isn't the whole syscall that's restarted but only the
> fsnotify() call.
>

Right. I missed that.

> > Wondering out loud:
> > Currently we order the marks on the mark obj_list,
> > within the same priority group, first-subscribed-last-handled.
> >
> > I never stopped to think if this order made sense or not.
> > Seems like it was just the easier way to implement insert by priority o=
rder.
> >
> > But if we order the marks first-subscribed-first-handled within the sam=
e
> > priority group, we won't need to restart the syscall to restart mark
> > list iteration.
> >
> > The new group of the newly started daemon, will be next in the mark lis=
t
> > after the current stopped group returns FAN_ALLOW.
> > Isn't that a tad less intrusive handover then restarting the syscall
> > and causing a bunch of unrelated subsystems to observe the restart?
> >
> > And I think that the first-subscribed-first-handled order makes a bit m=
ore
> > sense logically.
> > I mean, if admin really cares about making some super important securit=
y
> > group first, admin could make sure that its a priority service that
> > starts very early
> > admin cannot make sure that the important group starts last...
>
> So this idea also briefly crossed my mind yesterday but I didn't look int=
o
> it in detail. Looking at how we currently do mark iteration in fsnotify
> this won't be very easy to implement. iter_info has an array of marks, so=
me
> of those are marks we are currently reporting to, some of those may be fr=
om
> the next group to report to. Some may be even NULL because for this mark
> type there were no more marks to report to. So it's difficult to make sur=
e
> iter_into will properly pick freshly added group and its marks without
> completely restarting mark iteration. I'm not saying it cannot be done bu=
t
> I'm not sure it's worth the hassle.
>

Yes, I see what you mean.
Restarting fsnotify() seems more sensible.

Thanks,
Amir.

