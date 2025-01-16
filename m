Return-Path: <linux-fsdevel+bounces-39423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00048A1403C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE193AB99D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402ED22E40F;
	Thu, 16 Jan 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwB6iJlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8522C9F7;
	Thu, 16 Jan 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047109; cv=none; b=JAENyoygshHrOtC4oF3UeycFTHweejrEinr47D3Ode715TQ/KBMuoO+Y5NeHvYkKlGrulZtkGOU25qdu4ZMG/GNr9EIbqPcuFyyKj6+uBk/Wu3XiWJ9zrSa8W917YXVQdElwoT8+lhEtPLY/ctJug8GFadPu23BDNxaitnSOkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047109; c=relaxed/simple;
	bh=bt9y7VMDd0fT8+5ucQ7LFgobPd/mUYZhUZBToLQTzzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaPSsMvz2c4Uw8Ak5/dEUrsW8jV+9fhcbNG3/ohTxWVinMrwt0/Wirt3S2duP1LXeqR9Zjhg/9fwRjnummFesnrZFWoVDMS91+Yzu6Purr5+gN9oOP2Drfdo0yrnR/rEykCciLmhY7pk6vS3duRHumaKTcZj/LD0Cr1i1bJ7jD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwB6iJlX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso1737991a91.2;
        Thu, 16 Jan 2025 09:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737047107; x=1737651907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnpCMEbA1t6ETGycFi8o/fEWUvj0t1FqGQCoyHe7flA=;
        b=fwB6iJlXNcNTWpfWl6C1N2roLwK932b65H1gSHa8xdXVUAvX2TrRl0bMl7w+GD7Y/+
         POBBfJZWrHJjYdxjvAXgCcQw9gBh7ALjE7fvvlOS8Azjkhg7nD4YrbWU0G3tmOB+xpWR
         B7oPox47EFzWb6DjQSjxxq8EXIZHq2Gk4EfC6p4g/r8/sgIvUt5sSVCC8gFiRv+mAukg
         kPCGCZaQ7i51TeZS40O+i7xzHbrUoPN+vd1EMFJWh2RCmfV3CHzRlqkYiHtBpx4YLFI4
         kFSjhiaQ24VJubpa0PPSI0Xwaj1Wsdhh0gawjloGg/g7TYBNjYeKG6TShxhSwrEDrlyq
         SuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047107; x=1737651907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnpCMEbA1t6ETGycFi8o/fEWUvj0t1FqGQCoyHe7flA=;
        b=fa/e4I8+fP43HAri8aynm0L7NxdRa2HUGvyOFAJgbZwBP/JjHsFUYx75b4AYXj0Thb
         vh1quvBj27YrpVDVDDFDLtM68jnGej6/eVurzGJNi8F3gINkG5pzUjjxgfOfVo9j5EVR
         VbK+kc0Zen0TISvp/XQmvXLUv47c03zG4CVMWvG4eF/osyMmGlZOxWgUDjJBHkOY9+Ly
         zTZing8jZDfqeqvROHKYf92UJrh1f0af34vb+333m6tFEL6f+PxSwsZU3Q7sDIURDmlW
         QW6v0nENOxFQaXBu07349SAaHfXpga9QWtWUvuu7ojc2w8F+xE1RkaeR4MUrjHmXKip3
         l1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSXcurdNwXLDdXiPt+7kIEBIq6yITmqZAJyGQ5JC3Lwf0h71N44xRPC0B8EQ+PeEdUACFB/tNvUHdGOlyK@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbEwEnPHYZSR20yMXCXuO/lFtZxgfaI8ZyNbopBmjTFHXJAhQ
	Wpcbi5yCnsA2Wdlr0NlTlAF1QjxxLKXNEdhKzlhJUW0E7HehdS4oUYVJJtCnYTjL2Y/QmkhYm7t
	D2dlhbGnHlQYdSWl4A7Gp2WgREOFdMB+J
X-Gm-Gg: ASbGncs/Bvmrd0Tf5y6LRjgIz0m6KUAQGEuAiLw4JQPomlxqyck0Lto6UjkVQzcIss6
	MnLko3XmmNDzabSAmS6rRf9E51NGLEDnVOz2RkQ==
X-Google-Smtp-Source: AGHT+IEqp9NlkXPCINvC+Ma4YceyC/nQi+JWYo90oQd4Hq8BFTq0yAfo662i/zn1B/F5a2ledPo7J1qBRO3TlC9rBEA=
X-Received: by 2002:a17:90b:5448:b0:2f4:f7f8:fc8b with SMTP id
 98e67ed59e1d1-2f548f1c430mr46508897a91.27.1737047107199; Thu, 16 Jan 2025
 09:05:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9a168461fc4665edffde6d8606920a34312f8932.camel@ibm.com>
 <CAOi1vP9uiR_7R-sa7-5tBU853uNVo6wPBBHDpEib3CyRvWsqLQ@mail.gmail.com> <6d4a79f4f0ac82f9287168a55694b7768d5b235d.camel@ibm.com>
In-Reply-To: <6d4a79f4f0ac82f9287168a55694b7768d5b235d.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 16 Jan 2025 18:04:55 +0100
X-Gm-Features: AbW1kvYrcitg_iSqYwzYOXBFanVO8UXDVo_r08dfBB7Psr1-01ICgvn7Wff9E6k
Message-ID: <CAOi1vP-J8Od5UQGPX6P=+SZw_YTa+yg+S=EBgKB5LRKCsdvW1A@mail.gmail.com>
Subject: Re: [PATCH] ceph: Introduce CONFIG_CEPH_LIB_DEBUG and CONFIG_CEPH_FS_DEBUG
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:01=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hi Ilya,
>
> On Thu, 2025-01-16 at 00:04 +0100, Ilya Dryomov wrote:
> > On Wed, Jan 15, 2025 at 1:41=E2=80=AFAM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > >
>
> <skipped>
>
> > >
> > > -void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor
> > > *cursor,
> > > -                              struct ceph_msg *msg, size_t length)
> > > +int ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor,
> > > +                             struct ceph_msg *msg, size_t length)
> > >  {
> > > +#ifdef CONFIG_CEPH_LIB_DEBUG
> > >         BUG_ON(!length);
> > >         BUG_ON(length > msg->data_length);
> > >         BUG_ON(!msg->num_data_items);
> > > +#else
> > > +       if (!length)
> > > +               return -EINVAL;
> > > +
> > > +       if (length > msg->data_length)
> > > +               return -EINVAL;
> > > +
> > > +       if (!msg->num_data_items)
> > > +               return -EINVAL;
> > > +#endif /* CONFIG_CEPH_LIB_DEBUG */
> >
> > Hi Slava,
> >
> > I don't think this is a good idea.  I'm all for returning errors
> > where
> > it makes sense and is possible and such cases don't actually need to
> > be
> > conditioned on a CONFIG option.  Here, this EINVAL error would be
> > raised very far away from the cause -- potentially seconds later and
> > in
> > a different thread or even a different kernel module.  It would still
> > (eventually) hang the client because the messenger wouldn't be able
> > to
> > make progress for that connection/session.
> >
>
> First of all, let's split the patch on two parts:
> (1) CONFIG options suggestion;
> (2) practical application of CONFIG option.
>
> I believe that such CONFIG option is useful for adding
> pre-condition and post-condition checks in methods that
> could be executed in debug compilation and it will be
> excluded from release compilation for production case.
>
> Potentially, the first application of this CONFIG option
> is not good enough. However, the kernel crash is good for
> the problem investigation (debug compilation, for example),
> but end-user would like to see working kernel but not crashed one.
> And returning error is a way to behave in a nice way,
> from my point of view.

We can definitely consider such a CONFIG option where there is a good
application for it.

>
> > With this patch in place, in the scenario that you have been chasing
> > where CephFS apparently asks to read X bytes but sets up a reply
> > message with a data buffer that is smaller than X bytes, the
> > messenger
> > would enter a busy loop, endlessly reporting the new error,
> > "faulting",
> > reestablishing the session, resending the outstanding read request
> > and
> > attempting to fit the reply into the same (short) reply message.  I'd
> > argue that an endless loop is worse than an easily identifiable
> > BUG_ON
> > in one of the kworker threads.
> >
> > There is no good way to process the new error, at least not with the
> > current structure of the messenger.  In theory, the read request
> > could
> > be failed, but that would require wider changes and a bunch of
> > special
> > case code that would be there just to recover from what could have
> > been
> > a BUG_ON for an obvious programming error.
> >
>
> Yes, I totally see your point. But I believe that as kernel crash as
> busy loop is wrong behavior. Ideally, we need to report the error and
> continue to work without kernel crash or busy loop. Would we rework
> the logic to be more user-friendly and to behave more nicely?

I'm not sure it would be worth the effort in this particular case.

> I don't quite follow why do we have busy loop even if we know that
> request is failed? Generally speaking, failed request should be
> discarded, from the common sense. :)

The messenger assumes that most errors are transient, so it simply
reestablishes the session and resends outstanding requests.  The main
reason for this is that depending on how far in the message the error
is raised, a corresponding request may not be known yet (consider
a scenario where the error pops up before the messenger gets to the
fields that identify the request, for example) or there may not be
a external request to fail at all.  If the request is identified and
the error is assumed to be permanent, the request can indeed be failed
to the submitter, but currently there is no support for that.  There is
something more crude where the OSD client can tell the messenger to
skip the message and move on -- see get_reply() and @skip parameter
in net/ceph/osd_client.c.  Normally it's used to skip over duplicate or
misdirected messages, but it can also be used to skip a message on
a would-be-permanent error that is associated with that particular
message.  With that, the submitter is never going to see a reply to
that request and would likely get stuck due to that at some point, but
once again these are almost always basic logic errors.

Thanks,

                Ilya

