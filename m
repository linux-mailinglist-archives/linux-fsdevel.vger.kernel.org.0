Return-Path: <linux-fsdevel+bounces-14052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9720876FC0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 09:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E331281E6F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA94374D1;
	Sat,  9 Mar 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gw7MIuSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4B364C7
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709972068; cv=none; b=RWM/zFEZsdCDPoKpN2RIVuayl4qv2IOdCUydgOU95MjdOZnvGV2VapzArtxjnfWEu3jDit6dq4ZIRG0SeO1meSxMDEP68dliiUPGK1p8qJfdl/nodgPi5n739/ShWOAPrVxkUzaudhov6YRHUGcDWJqb2YWb1ftMvgqjS8FGDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709972068; c=relaxed/simple;
	bh=Zj+BenKkxKHpalRXBQkHD9wRUn4EnSmK3ArIkneWNkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WuwqW9qADICYjdQWz65e+l/9b+H0ys9OXxwYum53/Ww3QRTW0aUEjLwyph5BaYEGDd5Nseh7U8hqXhzKtOE9of0KFRJ10ICCYdbkmftqdWB1hHY4pVCAfDKVGOLh1WQfXfxuqpzoOt+391Ea11Rqh6cEQD1l+MIf0sxGQ6WywCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gw7MIuSO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so2784745276.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Mar 2024 00:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709972066; x=1710576866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zC0aLyXqPfGUviRMbp3VRFDq2l1kCoNPVOwtFgQkl8=;
        b=gw7MIuSOhtUfBwWJFChlXrlzaXKGgVzMRzRPlnUGes994GjitB7dKMKrPNMkO2Extw
         3dE95rQ6JT/SkV3C4Y7F4vKg8kTJEP5D+D2R37dtINDt1wqW25RW+39eiNWPPTvWctfO
         nDXMhZRDWp8m5Xi6XPXx43iDWVZMrv0pWUBgu/MH4kUaULuQsb6N18Yz+zyG9q68TWI8
         Gihbqea0bLB686/aRiro51tdmtChKWX5T27fDzOg/qJ21sFSld1qBpY4pAgRhGtqjgKO
         dbvp4p4hpcY6h7VydQKaOw7dHkegjt9HSOn+9V5tGUos0hi/fMQfGkRHZu8IIOhnOiwk
         1jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709972066; x=1710576866;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5zC0aLyXqPfGUviRMbp3VRFDq2l1kCoNPVOwtFgQkl8=;
        b=DDinFp7c77n5pksO4Pk6vVhsFmZ4GpUQuWQi91DrloL3HORcfF2FuYefPQMsf1pQxN
         2bdUwUdXvaX+y7FjSAVHfccuhN268yrRuggEbE+JsNCtoIxwN95L7UGGcsKzS8B9OyMn
         kYQZo7CfbX+UQVpik3vJPkbGod+IMKPWvUslbxQGcQmwZT+XsfDCcF5e9dQefzLpsNqR
         U2kS1BA+lQKs6moogMNqdcypT0JDSUqS++YyVg7F/n9XWiRq4S6lus7cYyy0H2m5q5Ap
         Q9fDX08yGzbUEHtf292KV4VIyolsMYqA0ieRhPCI+iHGy2f0GkUe52pCgFxV+qrHttby
         63tw==
X-Forwarded-Encrypted: i=1; AJvYcCVsR4zDYFL3FKlXDKftDpNfe8VZMrAfwC2aFqFJkmymQ90NIbqI/MVWE8Oh5voqYh2BMAVEQWFU1l5FDOVvRMBFUlnGTODzXLy7w8fivw==
X-Gm-Message-State: AOJu0Yxa2I8nknm2Ij5oE4PwfMYrbRKIdZ4Fz9PlWO08r3FlViKY+snA
	zNawrgK3jTY5gyXuaZzULk3+igMk+LpfCxTcPx5SOAzs8RBf0oRJKmEh92lNR1pEY5oMNXCO5mG
	H2A==
X-Google-Smtp-Source: AGHT+IGK6QYdafFcLyYsICEWWH+xVji7gs887JC1gWlCuYwUVKjZW7oa0Z5XEMTt/aixO0PA2Btn7+hrkDw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:f07:b0:dcf:f526:4cc6 with SMTP id
 et7-20020a0569020f0700b00dcff5264cc6mr60502ybb.11.1709972066250; Sat, 09 Mar
 2024 00:14:26 -0800 (PST)
Date: Sat, 9 Mar 2024 09:14:24 +0100
In-Reply-To: <CAHC9VhRnUbu2jRwUhLGboAgus_oFEPyddu=mv-OMLg93HHk17w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com> <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area> <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <20240308.saiheoxai7eT@digikod.net> <CAHC9VhSjMLzfjm8re+3GN4PrAjO2qQW4Rf4o1wLchPDuqD-0Pw@mail.gmail.com>
 <20240308.eeZ1uungeeSa@digikod.net> <CAHC9VhRnUbu2jRwUhLGboAgus_oFEPyddu=mv-OMLg93HHk17w@mail.gmail.com>
Message-ID: <ZewaYKO073V7P6Qy@google.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 05:25:21PM -0500, Paul Moore wrote:
> On Fri, Mar 8, 2024 at 3:12=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> > On Fri, Mar 08, 2024 at 02:22:58PM -0500, Paul Moore wrote:
> > > On Fri, Mar 8, 2024 at 4:29=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > > > Let's replace "safe IOCTL" with "IOCTL always allowed in a Landlock
> > > > sandbox".
> > >
> > > Which is a problem from a LSM perspective as we want to avoid hooks
> > > which are tightly bound to a single LSM or security model.  It's okay
> > > if a new hook only has a single LSM implementation, but the hook's
> > > definition should be such that it is reasonably generalized to suppor=
t
> > > multiple LSM/models.
> >
> > As any new hook, there is a first user.  Obviously this new hook would
> > not be restricted to Landlock, it is a generic approach.  I'm pretty
> > sure a few hooks are only used by one LSM though. ;)
>=20
> Sure, as I said above, it's okay for there to only be a single LSM
> implementation, but the basic idea behind the hook needs to have some
> hope of being generic.  Your "let's redefine a safe ioctl as 'IOCTL
> always allowed in a Landlock sandbox'" doesn't fill me with confidence
> about the hook being generic; who knows, maybe it will be, but in the
> absence of a patch, I'm left with descriptions like those.

FWIW, the existing IOCTL hook is used in the following places:

* TOMOYO: seemingly configurable per IOCTL command?  (I did not dig deeper)
* SELinux: has a hardcoded switch of IOCTL commands, some with special chec=
ks.
  These are also a subset of the do_vfs_ioctl() commands,
  plus KDSKBENT, KDSKBSENT (from ioctl_console(2)).
* Smack: Decomposes the IOCTL command number to look at the _IOC_WRITE and
  _IOC_READ bits. (This is a known problematic approach, because (1) these =
bits
  describe whether the argument is getting read or written, not whether the
  operation is a mutating one, and (2) some IOCTL commands do not adhere to=
 the
  convention and don't use these macros)

AppArmor does not use the LSM IOCTL hook.


> > > I understand that this makes things a bit more
> > > complicated for Landlock's initial ioctl implementation, but
> > > considering my thoughts above and the fact that Landlock's ioctl
> > > protections are still evolving I'd rather not add a lot of extra hook=
s
> > > right now.
> >
> > Without this hook, we'll need to rely on a list of allowed IOCTLs, whic=
h
> > will be out-of-sync eventually.  It would be a maintenance burden and a=
n
> > hacky approach.
>=20
> Welcome to the painful world of a LSM developer, ioctls are not the
> only place where this is a problem, and it should be easy enough to
> watch for changes in the ioctl list and update your favorite LSM
> accordingly.  Honestly, I think that is kinda the right thing anyway,
> I'm skeptical that one could have a generic solution that would
> automatically allow or disallow a new ioctl without potentially
> breaking your favorite LSM's security model.  If a new ioctl is
> introduced it seems like having someone manually review it's impact on
> your LSM would be a good idea.

We are concerned that we will miss a change in do_vfs_ioctl(), which we wou=
ld
like to reflect in the matching Landlock code.  Do other LSMs have any
approaches for that which go beyond just watching the do_vfs_ioctl()
implementation for changes?


> > We're definitely open to new proposals, but until now this is the best
> > approach we found from a maintenance, performance, and security point o=
f
> > view.
>=20
> At this point it's probably a good idea to post another RFC patch with
> your revised idea, if nothing else it will help rule out any
> confusion.  While I remain skeptical, perhaps I am misunderstanding
> the design and you'll get my apology and an ACK, but be warned that as
> of right now I'm not convinced.

Thanks you for your feedback!

Here is V10 with the approach where we use a new LSM hook:
https://lore.kernel.org/all/20240309075320.160128-1-gnoack@google.com/

I hope this helps to clarify the approach a bit.  I'm explaining it in more
detail again in the commit which adds the LSM hook, including a call graph,=
 and
avoiding the word "safe" this time ;-)

Let me know what you think!

Thanks!
=E2=80=94G=C3=BCnther

