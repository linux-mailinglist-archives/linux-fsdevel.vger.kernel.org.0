Return-Path: <linux-fsdevel+bounces-45005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDA2A700BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9641171FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2729C32F;
	Tue, 25 Mar 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="O5CWBoq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB425C6F8;
	Tue, 25 Mar 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906192; cv=none; b=r5RCs+tRkWWk0HTOUiIQZV13alsyDTgR8zChg4Gtdl1IPoBadzVkXVwF5v00j2o94ztK0/DMH/b1RFe0aqpC89JlEGae2MSKNPc/prk1F64n4jdI0S6JhuAfQl8FH3EPn4+EVb3xdol17+NtGyDwHbiXCiFPRf7+REGGemXR/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906192; c=relaxed/simple;
	bh=2UlbQzwJ0TGvc1B6KjjApIAPc4og6KLs/E2BXmKzIFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe1BjRI8mzCD+N4j6wmTidw3dasOl2CXIdD3uPpFf9u2Hmd7gpeDW1zDAUoROZZzbsmPkgmhQcf9pJbbYDaam17OgfHHCWF31rpqKhAUMr7NQ3ZCCBE2+iANF1z+clO/SwPeREwHvNNoBkT1GUhCC4KcfQiAHarM2Ib+HUvh50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=O5CWBoq4; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4E17714C2D3;
	Tue, 25 Mar 2025 13:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742906182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhnoa2DjGfYLI5fp/EEFgTAJMpRgEkHcRWbC4261OTk=;
	b=O5CWBoq4VffukBT/JS0fum6G9wxKHvtTa5qWUwP3ugx93dIL9YfZ60izX5AjqRXqQtMWhC
	NKCrr5guHNvErJ+En/S11rj0LNo/iU5Q4sZZtG/q9MUnI6bSVQ9D5DenJ5aqIYrdofu7v9
	fmPqgUNnqPocyccEavwBvXup+S/f8r6tDyrZKx7ky/xBXSN5ahQV4y5bQiIHEbFFdht2Y0
	z0WLQdS9BUanDVE9TkZaYre4bv7kFvfvwdV4lbbAphVIcEGwjOtb4dqWmPqnZtktK0eqcS
	6QoKVeu3cB/GB6d0zfV5OI59TwNs8ceZYdVKpYUf8je/FAWQJ5e6rv/lukTVTw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c1272fae;
	Tue, 25 Mar 2025 12:36:15 +0000 (UTC)
Date: Tue, 25 Mar 2025 21:36:00 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <Z-KjMEokv_Hs6qGh@codewreck.org>
References: <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
 <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325121526.GA7904@redhat.com>

Thanks for the Cc

Just replying quickly without looking at anything

Oleg Nesterov wrote on Tue, Mar 25, 2025 at 01:15:26PM +0100:
> All I can say right now is that the "sigpending" logic in p9_client_rpc()
> looks wrong. If nothing else:
> 
> 	- clear_thread_flag(TIF_SIGPENDING) is not enough, it won't make
> 	  signal_pending() false if TIF_NOTIFY_SIGNAL is set.
> 
> 	- otoh, if signal_pending() was true because of pending SIGKILL,
> 	  then after clear_thread_flag(TIF_SIGPENDING) wait_event_killable()
> 	  will act as uninterruptible wait_event().

Yeah, this is effectively an unkillable event loop once a flush has been
sent; this is a known issue.
I've tried to address this with async rpc (so we could send the flush
and forget about it), but that caused other regressions and I never had
time to dig into these...

The patches date back 2018 and probably won't even apply cleanly
anymore, but if anyone cares they are here:
https://lore.kernel.org/all/1544532108-21689-3-git-send-email-asmadeus@codewreck.org/T/#u

(the hard work of refcounting was done just before that in order to kill
this pattern, I just pretty much ran out of free time at that point,
hobbies are hard...)

So: sorry, it's probably possible to improve this, but it won't be easy
nor immediate.

> > c->trans_mod->request() calls p9_fd_request() in net/9p/trans_fd.c
> > which basically does a p9_fd_poll().
> >
> > Previously, the above would fail with err as -EIO which would
> > cause the client to "Disconnect" and the retry logic would make
> > progress. Now however, the err returned is -ERESTARTSYS which
> > will not cause a disconnect and the retry logic will hang
> > somewhere in p9_client_rpc() later.

Now, if you got this far I think it'll be easier to make whatever
changed error out with EIO again instead; I'll try to check the rest of
the thread later this week as I didn't follow this thread at all.

Thanks,
-- 
Dominique

