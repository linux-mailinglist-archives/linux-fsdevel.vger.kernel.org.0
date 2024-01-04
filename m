Return-Path: <linux-fsdevel+bounces-7336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E834823A97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 03:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2757C1F26294
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ABB46B3;
	Thu,  4 Jan 2024 02:24:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F651FB4;
	Thu,  4 Jan 2024 02:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861D3C433C7;
	Thu,  4 Jan 2024 02:24:02 +0000 (UTC)
Date: Wed, 3 Jan 2024 21:25:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240103212506.41432d12@gandalf.local.home>
In-Reply-To: <20240104014837.GO1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240104014837.GO1674809@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 01:48:37 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Jan 03, 2024 at 08:32:46PM -0500, Steven Rostedt wrote:
> 
> > +	/* Get the tracefs root from the parent */
> > +	inode = d_inode(dentry->d_parent);
> > +	inode = d_inode(inode->i_sb->s_root);  
> 
> That makes no sense.  First of all, for any positive dentry we have
> dentry->d_sb == dentry->d_inode->i_sb.  And it's the same for all
> dentries on given superblock.  So what's the point of that dance?
> If you want the root inode, just go for d_inode(dentry->d_sb->s_root)
> and be done with that...

That was more of thinking that the dentry and dentry->d_parent are
different. As dentry is part of eventfs and dentry->d_parent is part of
tracefs. Currently they both have the same superblock so yeah, I could just
write it that way too and it would work. But in my head, I was thinking
that they behave differently and maybe one day eventfs would get its own
superblock which would not work.

To explain this better:

  /sys/kernel/tracing/ is the parent of /sys/kernel/tracing/events

But everything but "events" in /sys/kernel/tracing/* is part of tracefs.
Everything in /sys/kernel/tracing/events is part of eventfs.

That was my thought process. But as both tracefs and eventfs still use
tracefs_get_inode(), it would work as you state.

I'll update that, as I don't foresee that eventfs will become its own file
system.

Thanks,

-- Steve

