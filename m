Return-Path: <linux-fsdevel+bounces-40260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3D5A21491
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF793A877E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB4F1E048F;
	Tue, 28 Jan 2025 22:42:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B801C3BF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104158; cv=none; b=aGzy99vbNq4nAiLX8Muh6w9hg6r4r+Nz0NFYqoeo2d1YJF7xPTqbl/X6zVy2tJfUK1OuOkFsTfMlhJioKCizkCuMhPIKF05ckNSjhPInKQcKXD8yo0AeyUo3MY1bMfzYElM7X0Bkrwk+QZv+1L7YB7MnzqNdxLomQHWzSPVasII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104158; c=relaxed/simple;
	bh=TB0DIMymsq8xeqoU59UZS1odCQapCN6XHuNXBom30pI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHx5PH6CuVnoCHbsXje0zkSPVcWGAVURTKEP/b/2APdWREjARcy4oIO4DEi3yMuprdqAKtVB270454Vi9kJj7GQEQkhLM05eJqftsdeboPBGfU/yZnRFKybB6JjCg79R9t7pOJE+uG62K5LGeTVOgkbD0tn/NFUmW+BjjhA4FRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B5CC4CED3;
	Tue, 28 Jan 2025 22:42:36 +0000 (UTC)
Date: Tue, 28 Jan 2025 17:42:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, David Reaver
 <me@davidreaver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, James
 Bottomley <James.Bottomley@hansenpartnership.com>, Krister Johansen
 <kjlx@templeofstupid.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
Message-ID: <20250128174257.1e20c80f@gandalf.local.home>
In-Reply-To: <CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
References: <20250121153646.37895-1-me@davidreaver.com>
	<Z5h0Xf-6s_7AH8tf@infradead.org>
	<20250128102744.1b94a789@gandalf.local.home>
	<CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 14:05:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> Well, honestly, you were doing some odd things.

Some of those odd things were because of the use of the dentry as a handle,
which also required making an inode for every file. When the number of
event files blew up to 10s of thousands, that caused a lot of memory to be
used.

> 
> For a *simple* filesystem that actually acts as a filesystem, all you
> need is in libfs with things like &simple_dir_operations etc.
> 
> And we have a *lot* of perfectly regular users of things like that.
> Not like the ftrace mess that had very *non*-filesystem semantics with
> separate lifetime confusion etc, and that tried to maintain a separate
> notion of permissions etc.

I would also say that the proc file system is rather messy. But that's very
old and has a long history which probably built up its complexity.

> 
> To make matters worse, tracefs than had a completely different model
> for events, and these interacted oddly in non-filesystem ways.

Ideally, I rather it not have done it that way. To save memory, since every
event in eventfs has the same files, it was better to just make a single
array that represents those files for every event. That saved over 20
megabytes per tracing instance.

> 
> In other words, all the tracefs problems were self-inflicted, and a
> lot of them were because you wanted to go behind the vfs layers back
> because you had millions of nodes but didn't want to have millions of
> inodes etc.
> 
> That's not normal.
> 
> I mean, you can pretty much literally look at ramfs:
> 
>     fs/ramfs/inode.c
> 
> and it is a real example filesystem that does a lot of things, but
> almost all of it is just using the direct vfs helpers (simple_lookup /
> simple_link/ simple_rmdir etc etc). It plays *zero* games with
> dentries.

It's also a storage file system. It's just that it stores to memory which
looks like it simply uses the page cache where it never needs to write it
to disk. It's not a good example for a control interface.

> 
> Or look at fs/pstore.

Another storage device.

> 
> Or any number of other examples.
> 
> And no, nobody should *EVER* look at the horror that is tracefs and eventfs.

I believe kernfs is to cover control interfaces like sysfs and debugfs,
that actually changes kernel behavior when their files are written to. It's
also likely why procfs is such a mess because that too is a control
interface.

Yes, eventfs is "special", but tracefs could easily be converted to kernfs.
I believe Christian even wrote a POC that did that.

-- Steve


