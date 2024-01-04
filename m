Return-Path: <linux-fsdevel+bounces-7384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAF82449B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D670B24CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8B249F8;
	Thu,  4 Jan 2024 15:04:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A489249E6;
	Thu,  4 Jan 2024 15:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEE2C433C7;
	Thu,  4 Jan 2024 15:04:39 +0000 (UTC)
Date: Thu, 4 Jan 2024 10:05:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240104100544.593030e0@gandalf.local.home>
In-Reply-To: <20240104043945.GQ1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240104014837.GO1674809@ZenIV>
	<20240103212506.41432d12@gandalf.local.home>
	<20240104043945.GQ1674809@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 04:39:45 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Jan 03, 2024 at 09:25:06PM -0500, Steven Rostedt wrote:
> > On Thu, 4 Jan 2024 01:48:37 +0000
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> >   
> > > On Wed, Jan 03, 2024 at 08:32:46PM -0500, Steven Rostedt wrote:
> > >   
> > > > +	/* Get the tracefs root from the parent */
> > > > +	inode = d_inode(dentry->d_parent);
> > > > +	inode = d_inode(inode->i_sb->s_root);    
> > > 
> > > That makes no sense.  First of all, for any positive dentry we have
> > > dentry->d_sb == dentry->d_inode->i_sb.  And it's the same for all
> > > dentries on given superblock.  So what's the point of that dance?
> > > If you want the root inode, just go for d_inode(dentry->d_sb->s_root)
> > > and be done with that...  
> > 
> > That was more of thinking that the dentry and dentry->d_parent are
> > different. As dentry is part of eventfs and dentry->d_parent is part of
> > tracefs.  
> 
> ???
> 
> >Currently they both have the same superblock so yeah, I could just
> > write it that way too and it would work. But in my head, I was thinking
> > that they behave differently and maybe one day eventfs would get its own
> > superblock which would not work.  
> 
> ->d_parent *always* points to the same filesystem; if you get an (automounted?)  
> mountpoint there, ->d_parent simply won't work - it will point to dentry itself.
> 

This is the "tribal knowledge" I'm talking about. I really didn't know how
the root dentry parent worked. I guess that makes sense, as it matches the
'..' of a directory, and the '/' directory '..' points to itself. Although
mounted file systems do not behave that way. My /proc/.. is '/'. I just
figured that the dentry->d_parent would be similar. Learn something everyday.

> > To explain this better:
> > 
> >   /sys/kernel/tracing/ is the parent of /sys/kernel/tracing/events
> > 
> > But everything but "events" in /sys/kernel/tracing/* is part of tracefs.
> > Everything in /sys/kernel/tracing/events is part of eventfs.
> > 
> > That was my thought process. But as both tracefs and eventfs still use
> > tracefs_get_inode(), it would work as you state.
> > 
> > I'll update that, as I don't foresee that eventfs will become its own file
> > system.  
> 
> There is no way to get to underlying mountpoint by dentry - simply because
> the same fs instance can be mounted in any number of places.

OK, so the dentry is still separate from the path and tied closer to the
inode.

> 
> A crude overview of taxonomy:
> 
> file_system_type: what filesystem instances belong to.  Not quite the same
> thing as fs driver (one driver can provide several of those).  Usually
> it's 1-to-1, but that's not required (e.g. NFS vs NFSv4, or ext[234], or...).

I don't know the difference between NFS and NFSv4 as I just used whatever
was the latest. But I understand the ext[234] part.

> 
> super_block: individual filesystem instance.  Hosts dentry tree (connected or
> several disconnected parts - think NFSv4 or the state while trying to get
> a dentry by fhandle, etc.).

I don't know how NFSv4 works, I'm only a user of it, I never actually
looked at the code. So that's not the best example, at least for me.

> 
> dentry: object in a filesystem's directory tree(s).  Always belongs to
> specific filesystem instance - that relationship never changes.  Tree
> structure (and names) _within_ _filesystem_ belong on that level.
> ->d_parent is part of that tree structure; never NULL, root of a (sub)tree  
> has it pointing to itself.  Might be negative, might refer to a filesystem object
> (file, directory, symlink, etc.).

This is useful.

> 
> inode: filesystem object (file, directory, etc.).  Always belongs to
> specific filesystem instance.  Non-directory inodes might have any
> number of dentry instances (aliases) refering to it; a directory one - no 
> more than one.

This above is very useful knowledge that I did not know. That directory
inodes can only have a single dentry.

>  Filesystem object contents belongs here; multiple hardlinks
> have different dentries and the same inode.

So, can I assume that an inode could only have as many dentries as hard
links? I know directories are only allowed to have a single hard link. Is
that why they can only have a single dentry?

>  Of course, filesystem type in
> question might have no such thing as multiple hardlinks - that's up to
> filesystem.  In general there is no way to find (or enumerate) such links;
> e.g. a local filesystem might have an extra hardlink somewhere we had
> never looked at and there won't be any dentries for such hardlinks and
> no way to get them short of doing the full search of the entire tree.
> The situation with e.g. NFS client is even worse, obviously.
> 
> mount: in a sense, mount to super_block is what dentry is to inode.  It
> provides a view of (sub)tree hosted in given filesystem instance.  The
> same filesystem may have any number of mounts, refering to its subtrees
> (possibly the same subtree for each, possibly all different - up to
> the callers of mount(2)).  They form mount tree(s) - that's where the
> notions related to "this mounted on top of that" belong.  Note that
> they can be moved around - with no telling the filesystem about that
> happening.  Again, there's no such thing as "the mountpoint of given
> filesystem instance" - it might be mounted in any number of places
> at the same time.  Specific mount - sure, no problem, except that it
> can move around.
> 
> namespace: mount tree.  Unlike everything prior, this one is a part of
> process state - same as descriptor table, mappings, etc.

And I'm guessing namespace is for containers. At least that's what I've
been assuming they are for.

> 
> file: opened IO channel.  It does refer to specific mount and specific
> dentry (and thus filesystem instance and an inode on it).  Current
> IO position lives here, so does any per-open(2) state.

And IIUC, this is what maps to a processes fd table. That is, the process's
file descriptor number it passes to the kernel will be mapped to this
"file".

> 
> descriptor table: mapping from numbers to IO channels (opened files).

This is that "process fd table" I mentioned above (I wrote that before
reading this).

> Again, a part of process state.  dup() creates a new entry, with
> reference to the same file as the old one; multiple open() of the

Hmm, wouldn't "dup()" create another "file" that just points to the same
dentry? It wouldn't be the "same file", or did you mean "file" from the
user space point of view?

> same pathname will each yield a separate opened file.  _Some_ state
> belongs here (close-on-exec, mostly).  Note that there's no such
> thing as "the descriptor of this file" - not even "the user-supplied
> number that had been used to get the file we are currently reading
> from", since that number might be refering to something entirely
> different right after we'd resolved it to opened file and that
> happens *without* disrupting the operation.

This last paragraph confused me. What do you mean by ""referring to
something entirely different"?

Thanks for this overview. It was very useful, and something I think we
should add to kernel doc. I did read Documentation/filesystems/vfs.rst but
honestly, I think your writeup here is a better overview.

-- Steve

