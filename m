Return-Path: <linux-fsdevel+bounces-58702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA9B30995
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D497C6082CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E072D47FB;
	Thu, 21 Aug 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NQNQCiS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20A7262F;
	Thu, 21 Aug 2025 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816566; cv=none; b=O8BGlOL6UiIQcEAo9KF8MUHQbs1Ghi+5IBDuJCppriSaGlKxnQYE4H42mt4951vXXJKhvBGZ4b2T/bsdUA0wHHMh3nd9cVCz5NOHdWRphNp90T/b2KSANN6u5Kshm6uH9TtjSb2saJKHd7uXsJRRuxL/uiKdcV1W37GS9SuIXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816566; c=relaxed/simple;
	bh=xO0+39O03QMzTJvycdF9AB9Q4yStemFa0AkzpNo8SFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYIR5uZ71C76fBnJXdAfawa4vvRl7MdsaSdvdhO2k/2i5dgFL8DH0YfBBnT2+kh1xMkq8zwMj6JEVIUDw38IGxv6J0oECy9JgGgWt9m+N4fEHxc5sMYRb3/EGYNehM/1crA45el47/Sm5LBYrGBmnkQQ8mmGQEyRLOycv30+/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NQNQCiS+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M5fdkSinOLEsx8CVxm+D7u+eTJmqya4T5yF1QxGe0ls=; b=NQNQCiS+m8f6HhJLcFzJnxN0FR
	potx5tDK939ZqPe3ExCjToyQhG/yl+fI8JpxldS9kcrRbiO/CQTj/G2RrI5q4CXjB/X5Z4TZOW5pg
	iufnCTqAIY1Smy9j9vH4P5u0OIG84iZTX7geADsFDDTF8iHZpkJ17we/Ufe95q52dwNdarJ72RW6I
	2fzac4qFQacZq14rvSGixiWqFrRE7d+gHcAZFdLULdLcTIiWB3OBQXHjfZ6IMQs7V43yrLQH5pSzO
	UsEX6NxunEguhp8cyvbUT67CBPOM292Ah8wnW0AosTDYdjHk/0mAK0yP0Pfp/P9tKRGMGysDyAfUX
	EaV793WQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upE5q-00000003Lwx-48Ux;
	Thu, 21 Aug 2025 22:49:15 +0000
Date: Thu, 21 Aug 2025 23:49:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250821224914.GD39973@ZenIV>
References: <20250813150610.521355442@linutronix.de>
 <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
 <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
 <20250818222111.GE222315@ZenIV>
 <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
 <20250819003908.GF222315@ZenIV>
 <20250820234815.GA656679@ZenIV>
 <20250821-erkunden-gazellen-924d52f0a1c6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-erkunden-gazellen-924d52f0a1c6@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 21, 2025 at 09:45:22AM +0200, Christian Brauner wrote:
> On Thu, Aug 21, 2025 at 12:48:15AM +0100, Al Viro wrote:
> > On Tue, Aug 19, 2025 at 01:39:09AM +0100, Al Viro wrote:
> > > I'm still trying to come up with something edible for lock_mount() -
> > > the best approximation I've got so far is
> > > 
> > > 	CLASS(lock_mount, mp)(path);
> > > 	if (IS_ERR(mp.mp))
> > > 		bugger off
> > 
> > ... and that does not work, since DEFINE_CLASS() has constructor return
> > a value that gets copied into the local variable in question.
> > 
> > Which is unusable for situations when a part of what constructor is
> > doing is insertion of that local variable into a list.
> > 
> > __cleanup() per se is still usable, but... no DEFINE_CLASS for that kind
> > of data structures ;-/
> 
> Just add the custom infrastructure that we need for this to work out imho.

Obviously...  I'm going to put that into a branch on top of -rc3 and keep
the more infrastructural parts in the beginning, so they could be merged
into other branches in vfs/vfs.git without disrupting things on reordering.

> If it's useful outside of our own realm then we can add it to cleanup.h
> and if not we can just add our own header...

lock_mount() et.al. are purely fs/namespace.c, so no header is needed at
all.  FWIW, existing guards in there have problems - I ended up with

DEFINE_LOCK_GUARD_0(namespace_excl, namespace_lock(), namespace_unlock())
DEFINE_LOCK_GUARD_0(namespace_shared, down_read(&namespace_sem),
				      up_read(&namespace_sem))
in fs/namespace.c and
DEFINE_LOCK_GUARD_0(mount_writer, write_seqlock(&mount_lock),
		    write_sequnlock(&mount_lock))
DEFINE_LOCK_GUARD_0(mount_locked_reader, read_seqlock_excl(&mount_lock),
		    read_sequnlock_excl(&mount_lock))
in fs/mount.h; I'm doing conversions to those where they clearly are
good fit and documenting as I go.

mount_lock ones really should not be done in a blanket way - right
now they are wrong in quite a few cases, where writer is used instead
of the locked reader; we'll need to sort that out and I'd rather
keep the open-coded ones for the stuff yet to be considered and/or
tricky.

BTW, the comments I'm using for functions are along the lines of
 * locks: mount_locked_reader || namespace_shared && is_mounted(mnt)
this one - for is_path_reachable().  If you look through the comments
there you'll see things like "vfsmount lock must be held for write" and
the rwlock those are refering to had been gone for more than a decade...

DEFINE_LOCK_GUARD_0 vs. DEFINE_GUARD makes for saner code generation;
having it essenitally check IS_ERR_OR_NULL(&namespace_sem) is already
ridiculous, but when it decides to sacrifice a register for that, complete
with a bunch of spills...

