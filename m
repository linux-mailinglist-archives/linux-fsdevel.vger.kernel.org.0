Return-Path: <linux-fsdevel+bounces-58212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11492B2B2FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACC217F04D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B322DFA8;
	Mon, 18 Aug 2025 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pX1JEWFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5C3451B2;
	Mon, 18 Aug 2025 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550571; cv=none; b=KT7npvCGwpgWdMX+ENwkvaWAiHJ1F//JHuskx1wOsHLfJXu5CnAzFtlAUeAC0+YN1Vz6TKALLqoBcRI+6M1eS9LNJb2fHnv0qbiwMQRpd+hf7TUF2dHCq6+SFwfMyttn38p2/zroQiAIAhINWitwbUaOOW5pT30R87I/FfjtidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550571; c=relaxed/simple;
	bh=iHNS6FhLliru/r+JtYwvqPttXpvmBgwqpvAicyftaPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvu3kLLrGOqKmaQJxY8Ya3dKQVSGM3wt9CG5DlJvpnGF5yzrB7V9ZVgT1X4DN/Gn9zqhH9GQE6mAsHGmW8LuI5vlY6ctxiKsAsA+rkGI9PUMn7PFtAIabwx2CtXVsihRYmqtVRShMXGkeJzZbq5lCC13Lk8oIHrBZA3fCS30pHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pX1JEWFA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mdNreSZpM1rgTL5F3WLSo0lukmMLp8Ss+6FskITPhHM=; b=pX1JEWFAZTUAV02v7rtvCcy8XC
	2wh23p1LNYd4KhG36CEH95Lq9FLdwTPUvd2ubiglDgI3/0MB7HrXM3mWW5ATsmwkM1CBdkhi1OXS/
	XsmhVSwBM3SgZm9w0RmN9ruzax/6QNXeS3biMM4vxSi1BRALJuGWI71b+Ydlx3faJmBkgtQgkBoLz
	EOshfsYwxb7osDFoi//lUIysZpSF+1RjsrsKnLb7TtRCdX99Q1sux6//u5wFsugbvqQhhQVOx89p1
	8Pcnmst8H04EemB91V8ujDTaPyQqKcDxyzGjX12QlRqUWHk66hIbikPq5oqWWghvpCSWv5XbCt7Rh
	NRdQUHcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo6ti-00000008Pwj-0gmz;
	Mon, 18 Aug 2025 20:56:06 +0000
Date: Mon, 18 Aug 2025 21:56:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: Re: [RFC] {do_,}lock_mount() behaviour wrt races and move_mount(2)
 with empty to_path (was Re: [PATCH] fs/namespace.c: fix mountpath handling
 in do_lock_mount())
Message-ID: <20250818205606.GD222315@ZenIV>
References: <20250818172235.178899-1-seokwoo.chung130@gmail.com>
 <20250818201428.GC222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818201428.GC222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 18, 2025 at 09:14:28PM +0100, Al Viro wrote:

> Alternative would be to treat these races as "act as if we'd won and
> the other guy had overmounted ours", i.e. *NOT* follow mounts.  Again,
> for old syscalls that's fine - if another thread has raced with us and
> mounted something on top of the place we want to mount on, it could just
> as easily have come *after* we'd completed mount(2) and mounted their
> stuff on top of ours.  If userland is not fine with such outcome, it needs
> to provide serialization between the callers.  For move_mount(2)... again,
> the only real question is empty to_path case.
> 
> Comments?

Thinking about it a bit more...  Unfortunately, there's another corner
case: "." as mountpoint.  That would affect that old syscalls as well
and I'm not sure that there's no userland code that relies upon the
current behaviour.

Background: pathname resolution does *NOT* follow mounts on the starting
point and it does not follow mounts after "."

; mkdir /tmp/foo
; mount -t tmpfs none /tmp/foo
; cd /tmp/foo
; echo under > a
; cat /tmp/foo/a
under
; mount -t tmpfs none /tmp/foo
; cat a
under
; cat /tmp/foo/a
cat: /tmp/foo/a: no such file or directory
; echo under > b
; cat b
under
; cat /tmp/foo/b
cat: /tmp/foo/b: no such file or directory
;

It's been a bad decision (if it can be called that - it's been more
of an accident, AFAICT), but it's decades too late to change it.
And interaction with mount is also fun: mount(2) *DOES* follow mounts
on the end of any pathname, no matter what.  So in case when we are
standing in an overmounted directory, ls . will show the contents of
that directory, but mount <something> . will mount on top of whatever's
mounted there.

So the alternative I've mentioned above would change the behaviour of
old syscalls in a corner case that just might be actually used in userland
code - including the scripts run at the boot time, of all things ;-/

IOW, it probably falls under "can't touch that, no matter how much we'd
like to" ;-/  Pity, that...

That leaves the question of MOVE_MOUNT_BENEATH with empty pathname -
do we want a variant that would say "slide precisely under the opened
directory I gave you, no matter what might overmount it"?

At the very least this corner case needs to be documented in move_mount(2)
- behaviour of
	move_mount(_, _, dir_fd, "",
		   MOVE_MOUNT_T_EMPTY | MOVE_MOUNT_BENEATH)
has two apriori reasonable variants ("slide right under the top of
whatever pile there might be over dir_fd" and "slide right under dir_fd
itself, no matter what pile might be on top of that") and leaving it
unspecified is not good, IMO...

