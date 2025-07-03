Return-Path: <linux-fsdevel+bounces-53815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E932AAF7DBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA5A189BB82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215724C07A;
	Thu,  3 Jul 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fgQbuPoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979124C068
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559741; cv=none; b=OvwjtKyEGKA7Mwv2tdQ+y2ct4dSn0S4cI1WM8PpWcJ/rjWEgLq3drvYIvl/CiI5LAzQkbaU52Ug8t01tKUWv6iTVIVjFJqL1sjyCMR1ugMUHVr8pi8YqowVcy1UOMIYYQzUo6HJ2pHQ8uQxNoV6qMiTOpGWBIfRas2ZHbCGpU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559741; c=relaxed/simple;
	bh=gdZmBMfeXsKq4/7JgyXZhrWZPSmEqLgpVKOVbalyu+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDMgO4WoZih3U1aKkRsJjRLIay/hxPEO94Y4frrrinJiD1Qo7OlgBNTKXkefQ+QR7zlj7Lqfw7Q0asJMGu78VlnYO9s4noMjVWeaTJ6bB58Pu8QQvs7o8icoQBLuJznqxHKEvWoFkbUNI8DR9+MiDA6AkFRRan6huZPzbq62ejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fgQbuPoQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a77ea7ed49so16112651cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751559736; x=1752164536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMBffgttmkxxA4/eZf8nyaQOMbEUx2oThNSpJ0q+Ivw=;
        b=fgQbuPoQaXTCUlR/g6fXI6qHisgXsbCQCYo5BPpZe+hQ0WA6d4rufsG0TRHZsRI6oS
         9kSIaDuFypAmXqW6W8+zX8bNvxkNs0n3DMYs3Eky3PCosqlbUeoDB84Luw9XiPlLvZqW
         C3p7q/Duybk4eGJ5trvJhQiwHiQH8ragQC25A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751559736; x=1752164536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMBffgttmkxxA4/eZf8nyaQOMbEUx2oThNSpJ0q+Ivw=;
        b=JsokvgoAsj4k4ZsTgvbuCVSN16sqhgfXC6pyWXGkVA5F2btPzgjx9aNDdIFwfVSozZ
         n4ZC2EbLKfo6zh6UqE6J/zj06ulgoaIobFaXhdhe3qEzYraRD6byC49+c5nsqJoigzq1
         uwPo3LHv3vFQKSvXlD1bqoslqlsgTnihyvE4/RBUF3vD9sn0RqPdkqwnxrOnv0v0Y3+I
         Fvhc3VFmgsCzD2huvvgqbiGMwwCTvnNTgl0RKbebadwTyTJyQvmKmzLbyi7x3Ar4YMKc
         BaaljDV8Mvnr9sfLsjjO5+K1p3nyq/vyeIuu8zrYThOWI/JeUn2rsmW1XNXFQ9PrqxYu
         xP5w==
X-Forwarded-Encrypted: i=1; AJvYcCV5wDLttN72q6S60VEG7YDKHiFqPxsxBIIujtMbE8JQ8K/EvalxVy1pSuyln8E4CBGB+RWFKT8NDo3oNwLe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5WnF+41M9j9uQzcBPsvohQGunQYXX2nGECe76bhUIt7TmyC/
	cqMumt5CQ0V7HmcnrT8/3RvFvl6Ymy3ICGM6N2/PHHYBt1i9x4EIRSL/U0mrG3Ohv9c3P6rjTAq
	5xjeusiaJvT1qQPrfGJ27Y1nfNX99EWZq1rCGZGM+iw==
X-Gm-Gg: ASbGncuXCkG0Pir0+TwopTCfv3rMhErV09b3J4mcEAuIEXFvNyUGhyu57z1UHN2K8UE
	p5rTroQlMCM+kbYbt8LuCtdFnltbprqCvdc++E5sgVNu1dfIzMlQG+UOgNIP4frDnrgxI8iJaZm
	SHHCTg3qJGlUnUf2FrOO1rkmTH4NbBST1BxBBY6za4HFpwbAppcJVIdUHD6pfyi6S5OLw4GMlkx
	ton
X-Google-Smtp-Source: AGHT+IFpuWG2GvhxYtMxAUh8WB2KH6TdrkAQqKFkT6/brzKZ7LJ25FQ4et3TwOoMOt2zHTxyqqiGsJj1ooh5yXFVh9s=
X-Received: by 2002:ac8:5e12:0:b0:4a7:7c8e:1d5 with SMTP id
 d75a77b69052e-4a98aff555amr50766221cf.17.1751559735655; Thu, 03 Jul 2025
 09:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703130539.1696938-1-mszeredi@redhat.com> <CAOQ4uxjC6scXXVi0dHv-UahL2hBXVqLtZvn4BDvT6o_9+LcA7Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxjC6scXXVi0dHv-UahL2hBXVqLtZvn4BDvT6o_9+LcA7Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 3 Jul 2025 18:22:04 +0200
X-Gm-Features: Ac12FXzVLZyjUaGHMpszFZPAO4F7c7gwjMsNeVyaXNkm1jVqr5Ufm1y9QFji9_k
Message-ID: <CAJfpegty_ajdMjaqDN00opt7dvBwBQnMvDpAY=DnJxavsEsSSw@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: add watchdog for permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 17:47, Amir Goldstein <amir73il@gmail.com> wrote:

> Do you mean deadlock in userspace or deadlock on some kernel
> lock because the server is operating on the filesystem and the
> permission event was in a locked context?

Server is doing in a loop:

1) read perm event from from fanotify fd
2) do something to decide between allow/deny
3) write reply to fanotify

It doesn't matter where 2) gets stuck, in userspace or in the kernel,
the result is the same: a stuck open syscall.

> There is a nuance here.
> Your patch does not count the time from when the operation was queued
> and blocked.
>
> It counts the time from when the AV software *reads* the event.
> If AV software went off to take a nap and does not read events,
> you will not get a watchdog.

Right.

But server is unlikely to be doing anything between 3) and 1), so in
practice the head of the queue is unlikely to be stuck.  But maybe the
watchdog could be taught to handle that case as well (no outstanding
requests ad no forward progress in the queue).

> If it is, then I wonder if you could share some details about the
> analysis of the deadlocks.

It's very often plain recursion: handling the event triggers another
permission event,  in some roundabout way, obviously, otherwise it
would have been found in testing.

This is apparently a continuing problem for support teams,  because
when this happens the OS is the first to blame: "everything froze,
this is broke" and sometimes it's hard to convince customers and even
harder to convince AV vendors, that it's not in fact the OS.

> So are the deadlocks that you found happen on fs with atomic_open()?
> Technically, we can release the dir inode lock in finish_open()
> I think it's just a matter of code architecture to make this happen.

I don't think it's this.

> I think that's one of those features where sysctl knob is more useful to
> distros and admin than Kconfig.
> Might as well be a sysctl knob to control perm_group_timeout
> where 0 means off.

Okay.

> It is a bit odd to have a pid_t pid field here as well as
> struct pid *pid field in fae.pid (the event generating pid).
> So I think, either reuse fae.pid to keep reference to reader task_pid
> or leave this pid_t field here with a more specific name.

Yeah, I noticed the name conflict, then forgot about it.  Will fix.

> It would have been more natural and balanced to add group
> to watchdog list on fanotify_init().
>
> You can do that based on (group->priority > FSNOTIFY_PRIO_NORMAL)
> because while a program could create an fanotify group with
> priority FAN_CLASS_CONTENT and not add permission event
> watches, there is absolutely no reason to optimize for this case and
> not add this group to the "permission events capable" perm_group list.

Yeah, it's aesthetically more pleasing, but I wonder if it's worth it
having to explain why it's done this way.

A more self explanatory solution is to just move the list_empty()
inside the spinlock, and performance-wise it's not going to matter.

Thanks,
Miklos

