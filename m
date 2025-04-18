Return-Path: <linux-fsdevel+bounces-46704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B747A93FEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 00:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696F48A377E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 22:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266291E49F;
	Fri, 18 Apr 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9Re2D3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7824EA87
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745015880; cv=none; b=HAGRksk7TOBZdcIvhkKqhmF9PiVFEAY3NcsLZ42yHoIFbj2hRXN3Up+2MvwojjQWt4TKZsoEM+kio79afTLljB1GpAHmf2KtTVEEqTsqkwdbDSv/s6HM6lL4our8meGMz+kg9tk1ME+bJ4GbMo1MCy5FR3bYKBPG4UGvh6smV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745015880; c=relaxed/simple;
	bh=jhlVIX3kVkp0e8b8M1KKUzJQCkrzQ5wwin9Rpr4WNZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxIwO29M5oFO+HhlIrvhMJqaUUxheNHZT2K/ynbLqDE9TBBihbb4q+p1ZDx5FICO+oDlySVlB8ftIP8Rle4WPs5EZkyRo6+LemVY8mHTVnnNmj5Ee+KO5rf2RP93c74GKEkqkpy/vHVlxywpyoTvYB1ZawrN5JMjK4s7JNj9C40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9Re2D3m; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb415dd8faso365848466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745015876; x=1745620676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dxsBkFJqqqJVl5emxTP1cW4ht/4IQNzzj8ot/QCAZE=;
        b=C9Re2D3ma76Qz4VtT1XpumlfVQFVew/u7LXEE1yjc0UZm2LdURvtbuAOOfj8sqa8BU
         jqKgLtzLSc6phxa2cIvxxukFArgy8pkGOkSY6MGf/qYnUzjMvvXe/UgfrV/pRMdyqgAa
         5K8UbCYOrSByucpjKe/I4SHYzZqO37hB4diK2yLkkKInP0WiibpE0J6o4Kq74FImF4aL
         H05H8KmViy4xDf5jnNQ5w0MGDfNVrO3AjxaSBeGkL1bcrxBzoOubHbRmDZYm+l/LFR5V
         4XbfK+gNq7ECEEVGpS1g3JwNq6A5t1EnHvHYda9sIUUsGucdDiStnHxFrJpLDFhIshpj
         2RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745015876; x=1745620676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dxsBkFJqqqJVl5emxTP1cW4ht/4IQNzzj8ot/QCAZE=;
        b=t68cZLtDjz5y1k+P53ugXIc854vSPCGDywhjcQDYPP3oJJcWgXXt0bLjW+of4GOkP7
         3HSCFzC1FUjzVZKVu/PmUIdr39+TeuuqDPzgWEAkV/ROGnISC8t8W9ZMYBkah/HYCvAb
         acO3ApfmlCbNjoM/EiIFP9kTyiph6QyfrSVXd+IxHe2OC6JfKN6fwnMzBGerzm21AK7G
         0CqzCi2NA4Gud98BDb6jHu/wHirGfpa/VvIyfHVNcyxGMTei7MNU41Ru5lCcZWMGRb7I
         S4Lx3up/XdY+aBmm1tncdJOgB1/un3ui1JrVVQ0ylt7BXo7hESxb8yIhomtflcU1BKMP
         o7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXHlZWjvceSblm9i9hYC/cNMBPaIqehgnkR1MQy8yVSBvmNpb7H9ijfvBCoCXz6Ugw2jDCAGsE0dIKU0PY8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2R5tydV91wyBt4E4ET8wA8YQsQeXlSwnbaYbcSdS4mtgaDAuN
	k8UyMF5XXV1EKnu5pvOW2HhEPD9lUG3V8CbYkTJioYWWhMW8uQceq0BiZ8MZyNAYG2KJCWQiwfh
	4hvrYGQQ6iUOMPDyIE/oWaYKu4dD4hkvOJJE=
X-Gm-Gg: ASbGncue8kBWQPx4xOqrF/JGrPjdNJr+lsBX4OfXAkQphyXTvP40xyuCprqR/YIhMd1
	xIMr2rDOuyYdpFYKH1VQ9Pw7o9yyHHLxyVdKnAIsIEIwZE6pPi0BkZGmNkwIhZ2PUiy45TBbc3h
	4i4IXiaewJEPyC7NOQn9SUlQ==
X-Google-Smtp-Source: AGHT+IH+vbnQyh+VKLt9CCnZcAzZNdYhIS6Xv9XbeB15opzzvtZu1Jco5rPeEwowYwfmEQoKUBj5X6X6XuTakyArjhk=
X-Received: by 2002:a17:906:d54e:b0:ac6:d9fa:46c8 with SMTP id
 a640c23a62f3a-acb74d65aeamr360227666b.39.1745015875420; Fri, 18 Apr 2025
 15:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgXO0XJzYmijXu=3yDF_hq3E1yPUxHqhwka19-_jeaNFA@mail.gmail.com>
 <20250408185506.3692124-1-ibrahimjirdeh@meta.com> <CAOQ4uxjnjSeDpzk9j6QBQzhiSwwmOAejefxNL3Ar49BuCzBsKg@mail.gmail.com>
 <d2n57euuuy2gd63gweovkyvcya3igjttdabgpz4txxtf4v2pou@3eb7slijnhcl>
In-Reply-To: <d2n57euuuy2gd63gweovkyvcya3igjttdabgpz4txxtf4v2pou@3eb7slijnhcl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 19 Apr 2025 00:37:44 +0200
X-Gm-Features: ATxdqUF4kim6US0m3ZJt7k-kcO8qia40Eqmdnwcsr3cphNURWilMjfTPVgk11fU
Message-ID: <CAOQ4uxgBqR0hC2v2AbktjiWqfeEiJHsZq00Uhpg2PY3HyjGkpg@mail.gmail.com>
Subject: Re: Reseting pending fanotify events
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 5:51=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 09-04-25 14:36:16, Amir Goldstein wrote:
> > On Tue, Apr 8, 2025 at 8:55=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@me=
ta.com> wrote:
> > >
> > > > 1. Start a new server instance
> > > > 2. Set default response in case of new instance crash
> > > > 3. Hand over a ref of the existing group fd to the new instance if =
the
> > > > old instance is running
> > > > 4. Start handling events in new instance (*)
> > > > 5. Stop handling new events in old instance, but complete pending e=
vents
> > > > 6. Shutdown old instance
> > >
> > > I think this should work for our case, we will only need to reconstru=
ct
> > > the group/interested mask in case of crash. I can help add the featur=
e for
> > > setting different default responses.
> > >
> >
> > Please go ahead.
> >
> > We did not yet get any feedback from Jan on this idea,
> > but ain't nothing like a patch to solicit feedback.
>
> I'm sorry for the delay but I wanted to find time to give a deeper though=
t
> to this.
>

Same here. I had to think hard.

> > > > I might have had some patches similar to this floating around.
> > > > If you are interested in this feature, I could write and test a pro=
per patch.
> > >
> > > That would be appreciated if its not too much trouble, the approach o=
utlined
> > > in sketch should be enough for our use-case (pending the sb vs mount =
monitoring
> > > point you've raised).
> > >
> >
> > Well, the only problem is when I can get to it, which does not appear t=
o be
> > anytime soon. If this is an urgent issue for you I could give you more =
pointers
> > to  try and do it yourself.
> >
> > There is one design decision that we would need to make before
> > getting to the implementation.
> > Assuming that this API is acceptable:
> >
> > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM | FAN_MARK_DEFAULT=
, ...
> >
> > What happens when fd is closed?
> > Can the sbinfo->default_mask out live the group fd?
>
> So I think there are two options how to consistently handle this and we
> need to decide which one to pick. Do we want to:
>
> a) tie the concept to a particular notification group - i.e., if a partic=
ular
> notification group is not existing anymore, we want events on particular
> object(s) auto-rejected.
>
> or
>
> b) tie the concept to the object itself - i.e., if there's no notificatio=
n
> group handling events for the object, auto-reject the events.
>
> Both has its advantages and disadvantages. With a) we can easily have
> multiple handlers cooperate on one filesystem (e.g. an HSM and antivirus
> solution), the notification group can just register itself as mandatory f=
or
> all events on the superblock object and we don't have to care about detai=
ls
> how the notification group watches for events or so. But what gets comple=
x
> with this variant is how to hand over control from the old to the new
> version of the service or even worse how to recover from crashed service =
-
> you need to register the new group as mandatory and somehow "unregister"
> the crashed one.
>

I prefer this option, but with a variant -
The group has two fds:
one control-only fd (RDONLY) to keep it alive and add marks
and one queue-fd (RDWR) to handle events.

The control fd can be placed in the fd store.
When service crashes, the queue fd is closed so the group
cannot handle events and default response is returned.

When the service starts it finds the control fd in the fd store and
issues an ioctl or something to get the queue fd.

> For b) hand-over or crash recovery is simple. As soon as someone places a
> mark over given object, it is implicitly the new handler for the object a=
nd
> auto-reject does not trigger. But if you set that e.g. all events on the
> superblock need to be handled, then you really have to setup watches so
> that notification system understands each event really got handled (which
> potentially conflicts with the effort to avoid handling uninteresting
> events). Also any coexistence of two services using this facility is goin=
g
> to be "interesting".
>
> > I think that closing this group should remove the default mask
> > and then the default mask is at least visible at fdinfo of this fd.
>
> Once we decide the above dilema, we can decide on what's the best way to
> set these and also about visibility (I agree that is very important as
> well).

With the control fd design, this problem is also solved - the marks
are still visible on the control fd, and so will be the default response
and the state of the queue fd.

Thanks,
Amir.

