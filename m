Return-Path: <linux-fsdevel+bounces-58278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD34B2BDA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 11:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6640F16BFF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C831AF17;
	Tue, 19 Aug 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR0S9UmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CA272E5E;
	Tue, 19 Aug 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596419; cv=none; b=EeSCn4vLloke/tDHr3h8kfxCSs8RaXQ3mHg3TeZqiE2ZiGjPzyeK6vcJKjabUtl54v9aZWU5l2OgC/aOUh2fu5jlqFh19OVz3pAEW8xus9KH96UdDf3eQTyGVsbQY7/QFhKGrKY5PCtOxuhsnRaqO6OYrSfgHjSNmLOpuckRFQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596419; c=relaxed/simple;
	bh=rdvjR6w1soJ5Re7TnMtBegz/KXx41Ml5kV2g16OtOVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIMqcu6BHXIwBM6Lci8Z+seHcaxoM84jyrrWKotmAmP0y6GJFPl5hPXWXTCHT63Ko451dBXuV6E5xFAhXrZCEVZ8yKKqON2vSmdo7DNH/3GwxS1KyC6Vlmt1BKMM6Hd0GTf3HqhPX6QU2zRi+xM9KU3raKOKNZcboeLNZE+bzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR0S9UmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9459C4CEF1;
	Tue, 19 Aug 2025 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755596418;
	bh=rdvjR6w1soJ5Re7TnMtBegz/KXx41Ml5kV2g16OtOVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DR0S9UmUqMYlQNb2b7xa+qjznbqXx0JSZIEvWgOukEP11LA6IZfSf9fHERuZIrD0F
	 AMbzcIOzsTzqy8xloECiBlt+J1Ri1aQutWpXc9dG5gLugfg7PToGQhYCRqfeOniz8/
	 rMk29q4n3EApeLAV4+gLiquAG3XqOKTaNV/72/yvM+nSoB8Xgdh2gxGcAomutMuQn0
	 wrWZ37F7mUc33a7r/hDdEoYsX+jtdJXbZFpM9ldp5cJ4U96rNEssDM/1iROvlGZXxq
	 wi0U8vTkRSmAHXE5OpTA7gKVmKWVd8ip2c6Ts20QU8wNNeEzMHwBni2hRSUn44Y++I
	 yhaQZGbJV5W4Q==
Date: Tue, 19 Aug 2025 11:40:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ryan Chung <seokwoo.chung130@gmail.com>
Subject: Re: [RFC] {do_,}lock_mount() behaviour wrt races and move_mount(2)
 with empty to_path (was Re: [PATCH] fs/namespace.c: fix mountpath handling
 in do_lock_mount())
Message-ID: <20250819-qualifizieren-draht-f209a541ac6c@brauner>
References: <20250818172235.178899-1-seokwoo.chung130@gmail.com>
 <20250818201428.GC222315@ZenIV>
 <20250818205606.GD222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818205606.GD222315@ZenIV>

On Mon, Aug 18, 2025 at 09:56:06PM +0100, Al Viro wrote:
> On Mon, Aug 18, 2025 at 09:14:28PM +0100, Al Viro wrote:
> 
> > Alternative would be to treat these races as "act as if we'd won and
> > the other guy had overmounted ours", i.e. *NOT* follow mounts.  Again,
> > for old syscalls that's fine - if another thread has raced with us and
> > mounted something on top of the place we want to mount on, it could just
> > as easily have come *after* we'd completed mount(2) and mounted their
> > stuff on top of ours.  If userland is not fine with such outcome, it needs
> > to provide serialization between the callers.  For move_mount(2)... again,
> > the only real question is empty to_path case.
> > 
> > Comments?
> 
> Thinking about it a bit more...  Unfortunately, there's another corner
> case: "." as mountpoint.  That would affect that old syscalls as well
> and I'm not sure that there's no userland code that relies upon the
> current behaviour.
> 
> Background: pathname resolution does *NOT* follow mounts on the starting
> point and it does not follow mounts after "."
> 
> ; mkdir /tmp/foo
> ; mount -t tmpfs none /tmp/foo
> ; cd /tmp/foo
> ; echo under > a
> ; cat /tmp/foo/a
> under
> ; mount -t tmpfs none /tmp/foo
> ; cat a
> under
> ; cat /tmp/foo/a
> cat: /tmp/foo/a: no such file or directory
> ; echo under > b
> ; cat b
> under
> ; cat /tmp/foo/b
> cat: /tmp/foo/b: no such file or directory
> ;
> 
> It's been a bad decision (if it can be called that - it's been more
> of an accident, AFAICT), but it's decades too late to change it.
> And interaction with mount is also fun: mount(2) *DOES* follow mounts
> on the end of any pathname, no matter what.  So in case when we are
> standing in an overmounted directory, ls . will show the contents of
> that directory, but mount <something> . will mount on top of whatever's
> mounted there.
> 
> So the alternative I've mentioned above would change the behaviour of
> old syscalls in a corner case that just might be actually used in userland
> code - including the scripts run at the boot time, of all things ;-/
> 
> IOW, it probably falls under "can't touch that, no matter how much we'd
> like to" ;-/  Pity, that...
> 
> That leaves the question of MOVE_MOUNT_BENEATH with empty pathname -
> do we want a variant that would say "slide precisely under the opened
> directory I gave you, no matter what might overmount it"?

Afaict, right now MOVE_MOUNT_BENEATH will take the overmount into
account even for "." just like mount(2) will lookup the topmost mount no
matter what. That is what userspace expects. I don't think we need a
variant where "." ignores overmounts for MOVE_MOUNT_BENEATH and really
not unless someone has a specific use-case for it. If it comes to that
we should probably add a new flag.

> 
> At the very least this corner case needs to be documented in move_mount(2)
> - behaviour of
> 	move_mount(_, _, dir_fd, "",
> 		   MOVE_MOUNT_T_EMPTY | MOVE_MOUNT_BENEATH)
> has two apriori reasonable variants ("slide right under the top of
> whatever pile there might be over dir_fd" and "slide right under dir_fd

Yes, that's what's intended and documented also what I wrote in my
commit messages and what the selftests should test for. I specifically
did not make it deviate from standard mount(2) behavior.

> itself, no matter what pile might be on top of that") and leaving it
> unspecified is not good, IMO...

Sure, Aleksa can pull that into his documentation patches.

