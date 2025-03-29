Return-Path: <linux-fsdevel+bounces-45247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC2A75389
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 01:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEB116E9C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 00:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633A61DED78;
	Sat, 29 Mar 2025 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="dRH3IKf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF91C1F22;
	Sat, 29 Mar 2025 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206439; cv=none; b=hQRdCznzzhEX73SPufJcon6TUl0Alr0i0Fdu7U8ZRunXGayShbOBVzOpRIME8SnB2IfkBZuOLhDmFbjpGbeaRecPpBMWhlXODZpE1K5DLM+8YyNDd4FjVTMLzq5q7UR15r8q3ledZoUL7RJPfa0SEmbpEqEvJDs8V3giLCHK7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206439; c=relaxed/simple;
	bh=fT67FrQej/+ZYovLEOVgqKXz1l/vshEY1c55YfXzjrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJEzFzbJTQAG67sZ8LCx9OJ9h1VNnCcvrYJLs319KliqR4c6hCRKHMECCqo7TKnIW1dKkW7CAckD0dWQKuVMQR3ZCv+7ztR3mYEYHaETuy9PsBUapcn8Rk52HWn7HtHQ2BTIQDO/OVPkQJYlwon2NFIqi6z2ia0odYF/jvNb4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=dRH3IKf/; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 55C6714C2DB;
	Sat, 29 Mar 2025 01:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1743206429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+SWJObZEgFLwJrdpTWZD73anQoqylNb1/+kC0CAjO+o=;
	b=dRH3IKf/EjZP4pzYmtyLNkDAAW7ujhYHO+kRFu3au9m/HmNCQfhXdw9AwyfQrkvPkuFOBA
	zJ2FfIwZgjNHMFWzeEVj72wpw+ykJGFBI8YiGnKmfOHSzFD5/8dcLDCZ+0T4Eh1nwQp0sc
	BZdVa9LDOxY6I9g2jhWT407QDTA9e/6lAHLxmJvzV8/5SauzuhqX9paucXmbH1RiF/30og
	Y3wU+yvZeM7Ml5vD3DWgYvkW57JYSl/CIxK29soMzUkKBKQYf2ub1OqFpLvi3cDv90CfPs
	WK84rQdAV2n49H1KhM9KzCUPEphI8UD/uBJ79d4KUh8f8tY76iWAUsdCFdGldw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 782df18d;
	Sat, 29 Mar 2025 00:00:22 +0000 (UTC)
Date: Sat, 29 Mar 2025 09:00:07 +0900
From: asmadeus@codewreck.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, ericvh@kernel.org,
	jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com,
	netfs@lists.linux.dev, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <Z-c4B7NbHM3pgQOa@codewreck.org>
References: <20250328144928.GC29527@redhat.com>
 <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
 <20250328170011.GD29527@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250328170011.GD29527@redhat.com>

Oleg Nesterov wrote on Fri, Mar 28, 2025 at 06:00:12PM +0100:
> As for the patches from me or Prateek (thanks again!), I think that
> the maintainers should take a look.
> 
> But at this point I am mostly confident that the bisected commit aaec5a95d5961
> ("pipe_read: don't wake up the writer if the pipe is still full") is innocent,
> it just reveals yet another problem.
> 
> I guess (I hope ;) Prateek agrees.

Right, so your patch sounds better than Prateek's initial blowing
up workaround, but it's a bit weird anyway so let me recap:
- that syz repro has this unnatural pattern where the replies are all
written before the requests are sent
- 9p_read_work() (read worker) has an optimization that if there is no
in fly request then there obviously must be nothing to read (9p is 100%
client initiated, there's no way the server should send something
first), so at this point the reader task is idle
(OTOH, we're checking for rx right at p9_conn_create() before anything
is sent, so it's not like we're consistent on this...)
- p9_fd_request() (sending a new request) has another optimization that
only checks for tx: at this point if another request was already in
flight then the rx task should have a poll going on for rx, and if there
were no in flight request yet then there should be no point in checking
for rx, so p9_fd_request() only kick in the tx worker if there is room
to send
- at this point I don't really get the logic that'll wake the rx thread
up either... p9_pollwake() will trigger p9_poll_workfn() (through
p9_poll_work) which will call p9_poll_mux() and get the reader kicking
again, but I don't know how the waitqueue mechanism is supposed to work
(see p9_pollwait())
I'd have expected the tx task to somehow nudge this on, but it
doesn't?...
- due to the new optimization (aaec5a95d59615 "pipe_read: don't wake up
the writer if the pipe is still full"), that 'if there is room to send'
check started failing and tx thread doesn't start? Because syzbot passed
us a pipe that was already full, or they messed with it after mount?
I'm not clear about this point, but I think it's the key here -- the 9p
"mount by fd" is great for local pseudo filesystems and things like that
but it's been abused by syzbot too much, and I don't want to spend too
much time making sure that any unholy things they do with these fd
works. If possible I'd like to mark that fd unusable by userspace but
I'm honestly doubtful it's possible (if e.g. it was dup'd or something
before mount for example...)

So, yeah, well, okay I don't mind the patch even if it doesn't make
sense with a regular server.
We don't really care about trans fd performance either so it's fine if
it's a bit slower, and the error Prateek added might happen in a real
case if tx queue is full of real requests so I think your approach is
good enough.

If we understand what's happening here I think it's as good as anything
else, but I'd just like it clear in the commit message what syzbot is
doing and why the regression happened

Thank you both for the thorough analysis and follow ups!
-- 
Dominique Martinet | Asmadeus

