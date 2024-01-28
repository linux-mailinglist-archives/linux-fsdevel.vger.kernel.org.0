Return-Path: <linux-fsdevel+bounces-9251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E183F9D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 21:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C1D1F2116F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 20:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253193CF53;
	Sun, 28 Jan 2024 20:15:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF23BB5F;
	Sun, 28 Jan 2024 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472945; cv=none; b=ub1dnZKGqt9kNkOrhaD/OTR2Hi+SyaE1DyLS/ec7g/FGs87rylb8db1JBV6B890w+eRI6AlbWaF5FnVwqJDenRGsCp+lrKrsVbsWXsgM7FMLMB+Q0UQ1xYTO38WbFGI/fjlfExXajokYYXARxoqmGYp7IRV7gPt7f3EimCKIJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472945; c=relaxed/simple;
	bh=pFr1DiLFI4cfzFEXpgmCMhOrp6BnJ4EUT0iNE3+3WM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O13SlP69iFokxyVP1g/Lfg87m22Jd9tGq8IRsvM0K601VqGy2Ylqon/eRrKTHmiuqN/J/UglSZTHZRGnk6rt5ab2P3I4LF5VZY8+qI1pwSR0kZ/uWsEeA6vLNwTbVnCsDWVIV8cqrzouxPX3eo20smeeVYmemk0rdVCBupheRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C131DC433C7;
	Sun, 28 Jan 2024 20:15:43 +0000 (UTC)
Date: Sun, 28 Jan 2024 15:15:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128151542.6efa2118@rorschach.local.home>
In-Reply-To: <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 13:47:32 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> So here's an attempt at some fairly trivial but entirely untested cleanup.
> 
> I have *not* tested this at all, and I assume you have some extensive
> test-suite that you run. So these are "signed-off' in the sense that
> the patch looks fine, it builds in one configuration for me, but maybe
> there's something really odd going on.
> 
> The first patch is trivial dead code removal.

Ah yes. That was leftover code from the mount dentry walk that I
removed. I missed that code removal.

> 
> The second patch is because I really do not understand the reason for
> the 'ei->dentry' pointer, and it just looks messy.

I have to understand how the dentry lookup works. Basically, when the
ei gets deleted, it can't be freed until all dentries it references
(including its children) are no longer being accessed. Does that lookup
get called only when a dentry with the name doesn't already exist?

That is, can I assume that eventfs_root_lookup() is only called when
the VFS file system could not find an existing dentry and it has to
create one?

If that's the case, then I can remove the ei->dentry and just add a ref
counter that it was accessed. Then the final dput() should call
eventfs_set_ei_status_free() (I hate that name and need to change it),
and if the ei->is_freed is set, it can free the ei.

The eventfs_remove_dir() can free the ei (after SRCU) if it has no
references, otherwise it needs to wait for the final dput() to do the
free.

Again, if the ->lookup() only gets called if no dentry exists (where
ei->dentry would already be NULL), then I can do this.

I think the ei->dentry was required for the dir wrapper logic that we
removed.

> 
> It looks _particularly_ messy when it is mixed up in operations that
> really do not need it and really shouldn't use it.
> 
> The eventfs_find_events() code was using the dentry parent pointer to
> find the parent (fine, and simple), then looking up the tracefs inode
> using that (fine so far), but then it looked up the dentry using
> *that*. But it already *had* the dentry - it's that parent dentry it
> just used to find the tracefs inode. The code looked nonsensical.

That was probably from rewriting that function a few different ways.

> 
> Similarly, it then (in the set_top_events_ownership() helper) used
> 'ei->dentry' to update the events attr, but all that really wants is
> the superblock root. So instead of passing a dentry, just pass the
> superblock pointer, which you can find in either the dentry or in the
> VFS inode, depending on which level you're working at.
> 
> There are tons of other 'ei->dentry' uses, and I didn't look at those.
> Baby steps. But this *seems* like an obvious cleanup, and many small
> obvious cleanups later and perhaps the 'ei->dentry' pointer (and the
> '->d_children[]' array) can eventually go away. They should all be
> entirely useless - there's really no reason for a filesystem to hold
> on to back-pointers of dentries.
> 
> Anybody willing to run the test-suite on this?

It passed the ftrace selftests that are in the kernel, although the
ownership test fails if you run it a second time. That fails before
this patch too. It's because the test assumes that there's been no
chgrp done on any of the files/directories, which then permanently
assigns owership and ignores the default. The test needs to be fixed to
handle this case, as it calls chgrp and chown so itself is permanently
assigning ownership.

I'll have to run this on my entire test suit.

-- Steve



