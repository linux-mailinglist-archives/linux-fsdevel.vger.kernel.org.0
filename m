Return-Path: <linux-fsdevel+bounces-9107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B483E3DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4881C211F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BCB24A08;
	Fri, 26 Jan 2024 21:26:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBA4249EA;
	Fri, 26 Jan 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304385; cv=none; b=PL7zCA697Te1gG5ZX5Y/U79buhndpGSza1oeIbbyxy5GaUHJGJPD29LSzilSH5iFDe0uqpiuIVGg/w7xgVqlwlmnkXauUtFKa4beF8UkhZSqZIGDPBLfzYjtpSsf/gPJhfpZWbb6ShTBSgqTC7eztQJ/gQv9rADrn107lWw2gB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304385; c=relaxed/simple;
	bh=eO2PbaoyRZQ7eFdXYsMoTI8zvWtJ7nAM+Z/kZ5vVv24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfRhqEo1BhWiygswrfa9/FrnFIvK5urQN/ON5yw3p2wwXpYDclv+6DyVwUXBWahF2L5s4Ymfefeqc0ymVMSZhu6GNEh+9sMVjoy/0PfP1Bl3EBE5Ts8vhINjMQ17+cKEZouQTb7F3EB+Fhqk+dq2rPm38OfwpQb9DPG6wQNqtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A25C433C7;
	Fri, 26 Jan 2024 21:26:24 +0000 (UTC)
Date: Fri, 26 Jan 2024 16:26:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Devel
 <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240126162626.31d90da9@gandalf.local.home>
In-Reply-To: <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 12:25:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Steven,
>  stop making things more complicated than they need to be.
> 
> And dammit, STOP COPYING VFS LAYER FUNCTIONS.
> 
> It was a bad idea last time, it's a horribly bad idea this time too.
> 
> I'm not taking this kind of crap.
> 
> The whole "get_next_ino()" should be "atomic64_add_return()". End of story.

I originally wrote it that way, and thought to myself that the VFS version
is "faster" and switched to that.

My fault for being too much into micro-optimizations.

> 
> You arent' special. If the VFS functions don't work for you, you don't
> use them, but dammit, you also don't then steal them without
> understanding what they do, and why they were necessary.
> 
> The reason get_next_ino() is critical is because it's used by things
> like pipes and sockets etc that get created at high rates, the the
> inode numbers most definitely do not get cached.

Yes, I understood why it's optimized, and took it because it's been there
since 2010 and figured it's pretty solid.

> 
> You copied that function without understanding why it does what it
> does, and as a result your code IS GARBAGE.
> 
> AGAIN.
> 
> Honestly, kill this thing with fire. It was a bad idea. I'm putting my
> foot down, and you are *NOT* doing unique regular file inode numbers
> uintil somebody points to a real problem.
> 
> Because this whole "I make up problems, and then I write overly
> complicated crap code to solve them" has to stop,.

If I had just used the atomic_add_return() is it really that overly
complicated? Yes, I copied from VFS because I figured if they put in the
effort to make it faster then why not use that, even though it was overkill.

> 
> No more. This stops here.
> 
> I don't want to see a single eventfs patch that doesn't have a real
> bug report associated with it. And the next time I see you copying VFS
> functions (or any other core functions) without udnerstanding what the
> f*ck they do, and why they do it, I'm going to put you in my
> spam-filter for a week.
> 
> I'm done. I'm really *really* tired of having to look at eventfs garbage.

So we keep the same inode number until something breaks with it, even
though, using unique ones is not that complicated?

I'd be happy to change that patch to what I originally did before deciding
to copy get_next_ino():

unsigned int tracefs_get_next_ino(int files)
{
	static atomic_t next_inode;
	unsigned int res;

	do {
		res = atomic_add_return(files + 1, &next_inode);

		/* Check for overflow */
	} while (unlikely(res < files + 1));

	return res - files;
}

If I knew going back and copying over get_next_ino() was going to piss you
off so much, I wouldn't have done that.

Not to mention that the current code calls into get_next_ino() and then
throws it away. That is, eventfs gets its inode structure from tracefs that
adds the inode number to it using the VFS get_next_ino(). That gets thrown
away by the single inode assigned. This just makes it more likely that the
global get_inode_ino() is going to overflow due to eventfs, even though
eventfs isn't even using them.

I only did the one inode number because that's what you wanted. Is it that
you want to move away from having inode numbers completely? At least for
pseudo file systems? If that's the case, then we can look to get people to
start doing that. First it would be fixing tools like 'tar' to ignore the
inode numbers.

Otherwise, I really rather keep it the way it has always been. That is,
each file has its own unique inode number, and not have to deal with some
strange bug report because it's not. Is there another file system that has
just one inode number?

-- Steve

