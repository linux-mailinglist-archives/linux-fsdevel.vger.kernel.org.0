Return-Path: <linux-fsdevel+bounces-9223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975FB83EFF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 21:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE9283B96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 20:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7612E651;
	Sat, 27 Jan 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="TYsQMUAM";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="x4V4W3/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6872E645
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706387016; cv=none; b=SrhykX83S+BrOfZOm1z1WJxRIDI0U7LDG/Kk3T4JukU9g4XcgDeaMtp6KhitISBDoydGcdB2U/QXozSptQNhqmhpE5ybkMUYvqwmWbMZcMQhuAvFtJUx9YjfTSeSeobQRld37fv2wIEzSsXK1C6bueArztABBGg6aR0CQbJs1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706387016; c=relaxed/simple;
	bh=G5sQ2mdEKBWsC4av1zwuswWx4yayKcsyOSHxGlVZIKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AqKciSrS8dVVkx73tzNXpED+c+0rR+97HeoCOMRkr8Zawatfnp3hJJAJfV79K4bmoSG1wggEwz8T6eGG41zNQByKkpeAUchu/7ezOvEgKV0xnsmwtoydiDUhq08G07gAp/0jOdScSsgQFc0a8C5pt/46ediD7rX2XhFqXaH7d64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=TYsQMUAM; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=x4V4W3/D; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706387013;
	bh=G5sQ2mdEKBWsC4av1zwuswWx4yayKcsyOSHxGlVZIKU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=TYsQMUAMiOVZI7P1LGIASb4pV5WhG9xpC187jeNXIECQj+IzviwgrV7USF9BJXbj4
	 gIQVEPbp/CKxR9SSSrfVEXMLz4kRm9Pfld3GTa+r5UKjy+Y1NVVt97DVM6zWchjAbQ
	 Ydq4Q8mNUPeyp2wlSBIG7McvRictD4s2UwR97K7w=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 522E71285ED1;
	Sat, 27 Jan 2024 15:23:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HVQ2fmJtf6UN; Sat, 27 Jan 2024 15:23:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706387012;
	bh=G5sQ2mdEKBWsC4av1zwuswWx4yayKcsyOSHxGlVZIKU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=x4V4W3/DWV20FUp602j0U58rTBeJ7DZblXe6kPzUhpvVijqI8DjoSIYonkRZqvVPg
	 ZvEuDLvIoHgeSiKCxjzU6DtoV8g7Sn4ldlqxdeUZ+pMvyDweTyn5ji6PXAp1P0Td+r
	 HBz5mlvZVD2sKwjqgXWGrb6jY3MAItu0OZxJtWhk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D66C31285EC7;
	Sat, 27 Jan 2024 15:23:31 -0500 (EST)
Message-ID: <2b5c46a4dc3cb8206079d4dfc661df53939ee06a.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox
	 <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>
Date: Sat, 27 Jan 2024 15:23:29 -0500
In-Reply-To: <CAHk-=whXg6zAHWZ7f+CdOg5GOMffR3RSDVyvORTZhipxp5iAFQ@mail.gmail.com>
References: <2024012522-shorten-deviator-9f45@gregkh>
	 <20240125205055.2752ac1c@rorschach.local.home>
	 <2024012528-caviar-gumming-a14b@gregkh>
	 <20240125214007.67d45fcf@rorschach.local.home>
	 <2024012634-rotten-conjoined-0a98@gregkh>
	 <20240126101553.7c22b054@gandalf.local.home>
	 <2024012600-dose-happiest-f57d@gregkh>
	 <20240126114451.17be7e15@gandalf.local.home>
	 <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
	 <d661e4a68a799d8ae85f0eab67b1074bfde6a87b.camel@HansenPartnership.com>
	 <ZbVGLXu4DuomEvJH@casper.infradead.org>
	 <CAHk-=whXg6zAHWZ7f+CdOg5GOMffR3RSDVyvORTZhipxp5iAFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-01-27 at 11:44 -0800, Linus Torvalds wrote:
[...]
>  (c) none of the above is generally true of virtual filesystems
> 
> Sure, *some* virtual filesystems are designed to act like a
> filesystem from the ground up. Something like "tmpfs" is obviously a
> virtual filesystem, but it's "virtual" only in the sense that it
> doesn't have much of a backing store. It's still designed primarily
> to *be* a filesystem, and the only operations that happen on it are
> filesystem operations.
> 
> So ignore 'tmpfs' here, and think about all the other virtual
> filesystems we have.

Actually, I did look at tmpfs and it did help.

> And realize that hey aren't really designed to be filesystems per se
> - they are literally designed to be something entirely different, and
> the filesystem interface is then only a secondary thing - it's a
> window into a strange non-filesystem world where normal filesystem
> operations don't even exist, even if sometimes there can be some kind
> of convoluted transformation for them.
> 
> So you have "simple" things like just plain read-only files in /proc,
> and desp[ite being about as simple as they come, they fail miserably
> at the most fundamental part of a file: you can't even 'stat()' them
> and get sane file size data from them.

Well, this is a big piece of the problem: when constructing a virtual
filesystem what properties do I really need to care about (like stat or
uniqueness of inode numbers) and what can I simply ignore?  Ideally
this should be documented because you have to read a lot of code to get
an idea of what the must have properties are.  I think a simple summary
of this would go a long way to getting people somewhat out of the swamp
that sucks you in when you try to construct virtual filesystems.

> And "caching" - which was the #1 reason for most of the filesystem
> code - ends up being much less so, although it turns out that it's
> still hugely important because of the abstraction interface it
> allows.
> 
> So all those dentries, and all the complicated lookup code, end up
> still being quite important to make the virtual filesystem look like
> a filesystem at all: it's what gives you the 'getcwd()' system call,
> it's what still gives you the whole bind mount thing, it really ends
> up giving a lot of "structure" to the virtual filesystem that would
> be an absolute nightmare without it.  But it's a structure that is
> really designed for something else.

I actually found dentries (which were the foundation of shiftfs) quite
easy.  My biggest problem was the places in the code where we use a
bare dentry and I needed the struct mnt (or struct path) as well, but
that's a different discussion.

> Because the non-filesystem virtual part that a virtual filesystem is
> actually trying to expose _as_ a filesystem to user space usually has
> lifetime rules (and other rules) that are *entirely* unrelated to any
> filesystem activity. A user can "chdir()" into a directory that
> describes a process, but the lifetime of that process is then
> entirely unrelated to that, and it can go away as a process, while
> the directory still has to virtually exist.

On this alone, real filesystems do have the unplug problem as well
(device goes away while user is in the directory), so the solution that
works for them work for virtual filesystems as well.

> That's part of what the VFS code gives a virtual filesystem: the
> dentries etc end up being those things that hang around even when the
> virtual part that they described may have disappeared. And you *need*
> that, just to get sane UNIX 'home directory' semantics.
> 
> I think people often don't think of how much that VFS infrastructure
> protects them from.
> 
> But it's also why virtual filesystems are generally a complete mess:
> you have these two pieces, and they are really doing two *COMPLETELY*
> different things.
> 
> It's why I told Steven so forcefully that tracefs must not mess
> around with VFS internals. A virtual filesystem either needs to be a
> "real filesystem" aka tmpfs and just leave it *all* to the VFS layer,
> or it needs to just treat the dentries as a separate cache that the
> virtual filesystem is *not* in charge of, and trust the VFS layer to
> do the filesystem parts.
> 
> But no. You should *not* look at a virtual filesystem as a guide how
> to write a filesystem, or how to use the VFS. Look at a real FS. A
> simple one, and preferably one that is built from the ground up to
> look like a POSIX one, so that you don't end up getting confused by
> all the nasty hacks to make it all look ok.

Well, I did look at ext4 when I was wondering what a real filesystem
does, but we're back to having to read real and virtual filesystems now
just to understand what you have to do and hence we're back to the "how
do we make this easier" problem.

> IOW, while FAT is a simple filesystem, don't look at that one, just
> because then you end up with all the complications that come from
> decades of non-UNIX filesystem history.
> 
> I'd say "look at minix or sysv filesystems", except those may be
> simple but they also end up being so legacy that they aren't good
> examples. You shouldn't use buffer-heads for anything new. But they
> are still probably good examples for one thing: if you want to
> understand the real power of dentries, look at either of the minix or
> sysv 'namei.c' files. Just *look* at how simple they are. Ignore the
> internal implementation of how a directory entry is then looked up on
> disk - because that's obviously filesystem-specific - and instead
> just look at the interface.

So shall I put you down for helping with virtual filesystem
documentation then ... ?

James


