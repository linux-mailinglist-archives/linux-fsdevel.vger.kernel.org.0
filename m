Return-Path: <linux-fsdevel+bounces-24692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3F94322F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 16:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08909284D28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397CC1BBBD3;
	Wed, 31 Jul 2024 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO9UrY4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B51BBBC0;
	Wed, 31 Jul 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436751; cv=none; b=aZAq3LdflcHVtVd7g7ZEUWihUPyAaQiO07VcSp9MHJ+KgC9t2m9QrjOvCL7nM+KJePBJ10qleFTd/8EOG/WaNQ3uOdv03NP+0dIhzznqgFgp51bK1gV1V0o+BEHp/MuOL04L7uMHZtRMZPEdGykDWv0B5AuJIurtnHBnz2WuXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436751; c=relaxed/simple;
	bh=Z2KAjo8igGx1GqUFLJxsni1rTAHJZQ5kzFZTFWGu4QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPFMXUICpVnxL0zdlWa6BjaxWbcqXvI3klZhVydTcdenjQUhuny6RrJSuDrE4qZgGAzqx7lBVxidr9dU2bXAoCSq8sEZaB8EI6kJngvcuXsMTUNggaNHb2wUT3D5wEEzuX5HYDeLAmPk2MHZsOQ2MLe1XrErrXtYhpPmFYMrJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO9UrY4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDA7C116B1;
	Wed, 31 Jul 2024 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722436751;
	bh=Z2KAjo8igGx1GqUFLJxsni1rTAHJZQ5kzFZTFWGu4QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZO9UrY4shavGi32AhjGhU0PIc5WumFGsoaq3Pdh/zQAC9/fafRZXVR9Js9J/fISTh
	 hnKbtDDnheNibWpVdscDHtSRGCkZ2ENcSIF1AUSeQMsKN8ekrW2zgpVhcDcfroomqv
	 CKOP9vw76i1htnPmVxHL3pRKGOD4ArtwKshJaOwqOe3KUMH9yLEttZjo4rW5QYOWRx
	 YBf3p35a1OXhOywPP5r7jZ19l777UMJ46vw/bBBRTwCRM/XObks85G8YMIQXZYNp1x
	 pvjTRO44HLelRd/baO0wMmsBjiyqcBsWSupSH5HSiziWBL9a2lpxESroUj2zg/2XnP
	 PGz0no2hjdP/g==
Date: Wed, 31 Jul 2024 16:39:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jeff Xu <jeffxu@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4] proc: add config & param to block forcing mem writes
Message-ID: <20240731-gefilde-rehabilitieren-75f77dbdd79f@brauner>
References: <20240730132528.1143520-1-adrian.ratiu@collabora.com>
 <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
 <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
 <3ea8c0-66aa3900-3-2bfd8e00@3451942>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ea8c0-66aa3900-3-2bfd8e00@3451942>

On Wed, Jul 31, 2024 at 02:15:54PM GMT, Adrian Ratiu wrote:
> On Wednesday, July 31, 2024 02:18 EEST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Tue, 30 Jul 2024 at 16:09, Jeff Xu <jeffxu@google.com> wrote:
> > >
> > > > +               task = get_proc_task(file_inode(file));
> > > > +               if (task) {
> > > > +                       ptrace_active = task->ptrace && task->mm == mm && task->parent == current;
> > >
> > > Do we need to call "read_lock(&tasklist_lock);" ?
> > > see comments in ptrace_check_attach() of  kernel/ptrace.c
> > 
> > Well, technically I guess the tasklist_lock should be taken.
> > 
> > Practically speaking, maybe just using READ_ONCE() for these fields
> > would really be sufficient.
> > 
> > Yes, it could "race" with the task exiting or just detaching, but the
> > logic would basically be "at one point we were tracing it", and since
> > this fundamentally a "one-point" situation (with the actual _accesses_
> > happening later anyway), logically that should be sufficient.
> > 
> > I mean - none of this is about "permissions" per se. We actually did
> > the proper *permission* check at open() time regardless of all this
> > code. This is more of a further tightening of the rules (ie it has
> > gone from "are we allowed to ptrace" to "are we actually actively
> > ptracing".
> > 
> > I suspect that the main difference between the two situations is
> > probably (a) one extra step required and (b) whatever extra system
> > call security things people might have which may disable an actual
> > ptrace() or whatever..
> 
> Either approach is fine with me.
> 
> Will leave v4 a few days longer in case others have a stronger
> opinion or to gather & address more feedback.
> 
> If no one objects by then, I'll send v5 with READ_ONCE().

I'll just change that directly. No need to resend for that thing.

