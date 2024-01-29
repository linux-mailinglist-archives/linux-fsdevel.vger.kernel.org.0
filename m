Return-Path: <linux-fsdevel+bounces-9387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38547840954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48DD1F22F71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD229153500;
	Mon, 29 Jan 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfd48Iqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A3152E03
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540920; cv=none; b=nkaNcJjIjVQZzS4/P/W9Z9V42p1pycRk+bOceUvvQAraKm8rUzhGCF9jaAkuB4ciIaBumlj+9uFBsLXFhNBtUZ/op/0OFWi4rHKhRs2Eaq1nn3YjME3ePXvyoxGWNwuQDO0sHEGqCSFT6aX19K24shiNmWQxsKrfum46qelTHq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540920; c=relaxed/simple;
	bh=7FXRGCG/f/woumMxDrjET2pGT5bSeHmMVwMIDmuhlBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj6zIUQTT0Ic6ng6VyBWuk9bexKwK1B697L+7V4nKz5i3ggez8Jmd8/00e7+gyOXVv50PlYdPLWPIA8481jFHcdK4ryRnrQ3ztg+4cCtdfllvcr+fAJB0/8rbsVXxWhAGzrsKHtXIlYNDhqJV6UwkIoBQIv8Qq4NAddEHif5FGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfd48Iqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB94C433F1;
	Mon, 29 Jan 2024 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706540919;
	bh=7FXRGCG/f/woumMxDrjET2pGT5bSeHmMVwMIDmuhlBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfd48Iqg7JltRCl1j/I5FJ9W8hfnKtXc/vtUpQ2WtZncFrus7U2XgvZJmoUzkcy45
	 3PiPEBAV6eXKMzgDIyHB2shuixeZsMv0KHjJ0NA6WKI8EiyQ57wc9Y4kYzZCgbjmR+
	 446imBcz8VvO2HbzpY/GFke5wV0Jv5H1PjXREVJbtKeKn6iiAyPiCoGwpEPCV0iSRz
	 f3M0ImMXNZMP0LhwnGDMPKN+qXo8VRZ/vxaha1RDYRDAGiNXnZt4IBD+XVzM96ekpx
	 SwbISnKdFj1VPgQ6JQcC19TtAlzvvNrhA22byp1/2XdrG/1Z4wUwCbn2Bf9HjsXbI9
	 OYGyZTcD2v8MA==
Date: Mon, 29 Jan 2024 16:08:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Amir Goldstein <amir73il@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <20240129-umrechnen-kaiman-cb591bc22fc5@brauner>
References: <2024012528-caviar-gumming-a14b@gregkh>
 <20240125214007.67d45fcf@rorschach.local.home>
 <2024012634-rotten-conjoined-0a98@gregkh>
 <20240126101553.7c22b054@gandalf.local.home>
 <2024012600-dose-happiest-f57d@gregkh>
 <20240126114451.17be7e15@gandalf.local.home>
 <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
 <d661e4a68a799d8ae85f0eab67b1074bfde6a87b.camel@HansenPartnership.com>
 <ZbVGLXu4DuomEvJH@casper.infradead.org>
 <CAHk-=whXg6zAHWZ7f+CdOg5GOMffR3RSDVyvORTZhipxp5iAFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whXg6zAHWZ7f+CdOg5GOMffR3RSDVyvORTZhipxp5iAFQ@mail.gmail.com>

> But no. You should *not* look at a virtual filesystem as a guide how
> to write a filesystem, or how to use the VFS. Look at a real FS. A
> simple one, and preferably one that is built from the ground up to
> look like a POSIX one, so that you don't end up getting confused by
> all the nasty hacks to make it all look ok.
> 
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
> disk - because that's obviously filesystem-specific - and instead just
> look at the interface.

I agree and I have to say I'm getting annoyed with this thread.

And I want to fundamentally oppose the notion that it's too difficult to
write a virtual filesystem. Just one look at how many virtual
filesystems we already have and how many are proposed. Recent example is
that KVM wanted to implement restricted memory as a stacking layer on
top of tmpfs which I luckily caught early and told them not to do.

If at all a surprising amount of people that have nothing to do with
filesystems manage to write filesystem drivers quickly and propose them
upstream. And I hope people take a couple of months to write a decently
sized/complex (virtual) filesystem.

And specifically for virtual filesystems they often aren't alike at
all. And that's got nothing to do with the VFS abstractions. It's
simply because a virtual filesystem is often used for purposes when
developers think that they want a filesystem like userspace interface
but don't want all of the actual filesystem semantics that come with it.
So they all differ from each other and what functionality they actually
implement.

And I somewhat oppose the notion that the VFS isn't documented. We do
have extensive documentation for locking rules, a constantly updated
changelog with fundamental changes to all VFS APIs and expectations
around it. Including very intricate details for the reader that really
needs to know everything. I wrote a whole document just on permission
checking and idmappings when we added that to the VFS. Both
implementation and theoretical background. 

And stuff like overlayfs or shiftfs are completely separate stories
because they're even more special as they're (virtual) stacking
filesystems that challenge the VFS in way more radical ways than regular
virtual filesystems.

And I think (Amir may forgive me) that stacking filesystems are
generally an absolutely terrible idea as they complicate the VFS
massively and put us through an insane amount of pain. One just needs to
look at how much additional VFS machinery we have because of that and
how complicated our callchains can become because of that. It's just not
correct to even compare them to a boring virtual filesystem like
binderfs or bpffs.

