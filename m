Return-Path: <linux-fsdevel+bounces-7340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE42823B8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 05:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B301C24B43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7812E65;
	Thu,  4 Jan 2024 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="B9UarvKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BA18647;
	Thu,  4 Jan 2024 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CtSYda2UUwOgNnyx2mXQ6hEwTW/gnpzF7k6u3XOdM2A=; b=B9UarvKkJb0/RMb4ElWH1LPDW+
	FR4n8bnbBClsSfL/lHmedGb6lDwATNVK3VPkzyXqD03DK22dCSflvnUy9hyADdYh4eQio6AeAkuhz
	Qt2WEJzoXloqD/DyW80hgQ5cU1QoMaWK2WkQiewuSv1sGDJfbYijLqwFHcdYgO6SkxWwXL2qLrlBS
	hGKFDVI70EB70wozcIznC18+3lp+M1xaLuXXhGr2JJCUVfTUFFs5RSZFHVRmUwpn2XoxF+m3VaskT
	DZ8rWkcbeKr42lr+Jn5SRabRthucua4FZ9OyTtlmDkCLnIO0Ucm9fueYZqDyHWCUYnI938KePinpr
	Yy6DSGyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rLFWD-001EqY-1X;
	Thu, 04 Jan 2024 04:39:45 +0000
Date: Thu, 4 Jan 2024 04:39:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240104043945.GQ1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103212506.41432d12@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 03, 2024 at 09:25:06PM -0500, Steven Rostedt wrote:
> On Thu, 4 Jan 2024 01:48:37 +0000
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > On Wed, Jan 03, 2024 at 08:32:46PM -0500, Steven Rostedt wrote:
> > 
> > > +	/* Get the tracefs root from the parent */
> > > +	inode = d_inode(dentry->d_parent);
> > > +	inode = d_inode(inode->i_sb->s_root);  
> > 
> > That makes no sense.  First of all, for any positive dentry we have
> > dentry->d_sb == dentry->d_inode->i_sb.  And it's the same for all
> > dentries on given superblock.  So what's the point of that dance?
> > If you want the root inode, just go for d_inode(dentry->d_sb->s_root)
> > and be done with that...
> 
> That was more of thinking that the dentry and dentry->d_parent are
> different. As dentry is part of eventfs and dentry->d_parent is part of
> tracefs.

???

>Currently they both have the same superblock so yeah, I could just
> write it that way too and it would work. But in my head, I was thinking
> that they behave differently and maybe one day eventfs would get its own
> superblock which would not work.

->d_parent *always* points to the same filesystem; if you get an (automounted?)
mountpoint there, ->d_parent simply won't work - it will point to dentry itself.

> To explain this better:
> 
>   /sys/kernel/tracing/ is the parent of /sys/kernel/tracing/events
> 
> But everything but "events" in /sys/kernel/tracing/* is part of tracefs.
> Everything in /sys/kernel/tracing/events is part of eventfs.
> 
> That was my thought process. But as both tracefs and eventfs still use
> tracefs_get_inode(), it would work as you state.
> 
> I'll update that, as I don't foresee that eventfs will become its own file
> system.

There is no way to get to underlying mountpoint by dentry - simply because
the same fs instance can be mounted in any number of places.

A crude overview of taxonomy:

file_system_type: what filesystem instances belong to.  Not quite the same
thing as fs driver (one driver can provide several of those).  Usually
it's 1-to-1, but that's not required (e.g. NFS vs NFSv4, or ext[234], or...).

super_block: individual filesystem instance.  Hosts dentry tree (connected or
several disconnected parts - think NFSv4 or the state while trying to get
a dentry by fhandle, etc.).

dentry: object in a filesystem's directory tree(s).  Always belongs to
specific filesystem instance - that relationship never changes.  Tree
structure (and names) _within_ _filesystem_ belong on that level.
->d_parent is part of that tree structure; never NULL, root of a (sub)tree
has it pointing to itself.  Might be negative, might refer to a filesystem object
(file, directory, symlink, etc.).

inode: filesystem object (file, directory, etc.).  Always belongs to
specific filesystem instance.  Non-directory inodes might have any
number of dentry instances (aliases) refering to it; a directory one - no 
more than one.  Filesystem object contents belongs here; multiple hardlinks
have different dentries and the same inode.  Of course, filesystem type in
question might have no such thing as multiple hardlinks - that's up to
filesystem.  In general there is no way to find (or enumerate) such links;
e.g. a local filesystem might have an extra hardlink somewhere we had
never looked at and there won't be any dentries for such hardlinks and
no way to get them short of doing the full search of the entire tree.
The situation with e.g. NFS client is even worse, obviously.

mount: in a sense, mount to super_block is what dentry is to inode.  It
provides a view of (sub)tree hosted in given filesystem instance.  The
same filesystem may have any number of mounts, refering to its subtrees
(possibly the same subtree for each, possibly all different - up to
the callers of mount(2)).  They form mount tree(s) - that's where the
notions related to "this mounted on top of that" belong.  Note that
they can be moved around - with no telling the filesystem about that
happening.  Again, there's no such thing as "the mountpoint of given
filesystem instance" - it might be mounted in any number of places
at the same time.  Specific mount - sure, no problem, except that it
can move around.

namespace: mount tree.  Unlike everything prior, this one is a part of
process state - same as descriptor table, mappings, etc.

file: opened IO channel.  It does refer to specific mount and specific
dentry (and thus filesystem instance and an inode on it).  Current
IO position lives here, so does any per-open(2) state.

descriptor table: mapping from numbers to IO channels (opened files).
Again, a part of process state.  dup() creates a new entry, with
reference to the same file as the old one; multiple open() of the
same pathname will each yield a separate opened file.  _Some_ state
belongs here (close-on-exec, mostly).  Note that there's no such
thing as "the descriptor of this file" - not even "the user-supplied
number that had been used to get the file we are currently reading
from", since that number might be refering to something entirely
different right after we'd resolved it to opened file and that
happens *without* disrupting the operation.

