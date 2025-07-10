Return-Path: <linux-fsdevel+bounces-54409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0030FAFF754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 05:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537DA5A5E89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD027FB37;
	Thu, 10 Jul 2025 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="SvChjIa7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3E2236F4;
	Thu, 10 Jul 2025 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116929; cv=none; b=ntPx8hCnRY4eqMXzeMu4D2kzn3+syhllDuY3Jl2zabNNCg1y4GETjAtZIId2m/k2tLsAbrttCw8kM9zfTMR8CMFpKs6xuhItd+0DQ2D4fNZ7HKHr5lX1l1OUQsIzkZvsjy6AJmg98WsmvMPMaxJAZI4Bde0f4utBniY8tEPc6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116929; c=relaxed/simple;
	bh=F6VR5nKGe13Ow2g6gzB5e4obS87Lei+0BennH96UY8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WuL7TJei1gJD79+dRllz4bAg+PHUtAvV986OhA7hxPfvrYydeaq/iGmKjeWE8yWaxVvtv/zgdOmzZRzMhnviBH771DjjMJbU/xz4P3eU+v0b7MDpOI67tJOxJGM5iD/4urpG/wRBTHyWAm+vGWYSZS11FPetD65lPu7g0Un/hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=SvChjIa7; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1752116919;
	bh=VoLYoa/kgM+7MBKFJTPf56TyoyMCg93r0/6R25VCQ3I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SvChjIa7a2JcuhNzepxuLaNu7vmlhIJEZEY11axUpZMZWwl0zZuS0YtSmOf3hnV5r
	 BqapAhbH3iDMfrUxkZxe5fpfuZlA6OE/tZPfJ/y5pD6yR1fiJsUb75LbXbH0sDrTp/
	 JkB399jTUDuGuqB6/daQa4XJzGYUjAlkdpxc0/NA=
Received: from [IPv6:110::1f] (unknown [IPv6:2409:874d:200:3037::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 2A41A65F62;
	Wed,  9 Jul 2025 23:08:30 -0400 (EDT)
Message-ID: <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
From: Xi Ruoyao <xry111@xry111.site>
To: Christian Brauner <brauner@kernel.org>, Nam Cao <namcao@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider	
 <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara	
 <jack@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John
 Ogness	 <john.ogness@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 linux-rt-users@vger.kernel.org, Joe Damato	 <jdamato@fastly.com>, Martin
 Karsten <mkarsten@uwaterloo.ca>, Jens Axboe	 <axboe@kernel.dk>
Date: Thu, 10 Jul 2025 11:08:18 +0800
In-Reply-To: <20250701-wochen-bespannt-33e745d23ff6@brauner>
References: <20250527090836.1290532-1-namcao@linutronix.de>
	 <20250701-wochen-bespannt-33e745d23ff6@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 14:03 +0200, Christian Brauner wrote:
> On Tue, 27 May 2025 11:08:36 +0200, Nam Cao wrote:
> > The ready event list of an epoll object is protected by read-write
> > semaphore:
> >=20
> > =C2=A0 - The consumer (waiter) acquires the write lock and takes items.
> > =C2=A0 - the producer (waker) takes the read lock and adds items.
> >=20
> > The point of this design is enabling epoll to scale well with large num=
ber
> > of producers, as multiple producers can hold the read lock at the same
> > time.
> >=20
> > [...]
>=20
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.

Hi,

After upgrading my kernel to the recent mainline I've encountered some
stability issue, like:

- When GDM started gnome-shell, the screen often froze and the only
thing I could do was to switch into a VT and reboot.
- Sometimes gnome-shell started "fine" but then starting an application
(like gnome-console) needed to wait for about a minute.
- Sometimes the system shutdown process hangs waiting for a service to
stop.
- Rarely the system boot process hangs for no obvious reason.

Most strangely in all the cases there are nothing alarming in dmesg or
system journal.

I'm unsure if this is the culprit but I'm almost sure it's the trigger.
Maybe there's some race condition in my userspace that the priority
inversion had happened to hide...  but anyway reverting this patch
seemed to "fix" the issue.

Any thoughts or pointers to diagnose further?

--=20
Xi Ruoyao <xry111@xry111.site>

