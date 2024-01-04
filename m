Return-Path: <linux-fsdevel+bounces-7407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD489824824
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75BEB24619
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 18:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C0E28E14;
	Thu,  4 Jan 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wAJEnhjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203EA28DBD;
	Thu,  4 Jan 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vlx+ZyzaT4C42cyQHsUsGkWLG7RTQETHcAtkqa33ebs=; b=wAJEnhjHNPQBPFB+B3TeYLwccW
	Jmi4jOF2JdAvFz/Mwtn3bpmQC6Eoyh2SiclUtxYPwIe+GaHAUdMuB176cxT0Wh9/D+VA/whIzSXNg
	sWUfZesAuVyDEujCKhLQnScShAzJw09YGhXG7XsPf5Q6UMI8iKvaIZ+o+El7Dh8I/uvRZPA4Usfxo
	dozADWUa+Cu1hHyBMyZWmt0NMtAPz9fZrFj4iVx6xMxarGgriaIWekUYg90FgECYuIQPLRHWKUImd
	kHatuLbhLvzUqX5/yIwWm1LesyzVaFtiwvpPg+KKQkiGfOqJioUu1Z+nIMCHc4tMb+6pVxm5vbppa
	lw1vk29Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rLSOs-002CW8-1f;
	Thu, 04 Jan 2024 18:25:03 +0000
Date: Thu, 4 Jan 2024 18:25:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240104182502.GR1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home>
 <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104100544.593030e0@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 04, 2024 at 10:05:44AM -0500, Steven Rostedt wrote:

> This is the "tribal knowledge" I'm talking about. I really didn't know how
> the root dentry parent worked. I guess that makes sense, as it matches the
> '..' of a directory, and the '/' directory '..' points to itself. Although
> mounted file systems do not behave that way. My /proc/.. is '/'. I just
> figured that the dentry->d_parent would be similar. Learn something everyday.

What would you expect to happen if you have the same filesystem mounted in
several places?  Having separate dentry trees would be a nightmare - you'd
get cache coherency problems from hell.  It's survivable for procfs, but
for something like a normal local filesystem it'd become very painful.
And if we want them to share dentry tree, how do you choose where the ..
would lead from the root dentry?

The way it's done is that linkage between the trees is done separately -
there's a tree of struct mount (well, forest, really - different processes
can easily have separate trees, which is how namespaces are done) and
each node in the mount tree refers to a dentry (sub)tree in some filesystem
instance.  Location is represented by (mount, dentry) pair and handling of
.. is basically (modulo refcounting, locking, error handling, etc.)
	while dentry == subtree_root(mount) && mount != mountpoint_mount(mount)
		// cross into the mountpoint under it
		dentry = mountpoint_dentry(mount)
		mount = mountpoint_mount(mount)
	go_into(mount, dentry->d_parent)

Note that you can have e.g. /usr/lib/gcc/x86_64-linux-gnu/12 mounted on /mnt/blah:
; mount --bind /usr/lib/gcc/x86_64-linux-gnu/12 /mnt/blah
will do it.  Then e.g. /mnt/blah/include will resolve to the same dentry as
/usr/lib/gcc/x86_64-linux-gnu/12/include, etc.
; chdir /mnt/blah
; ls
32                 crtprec80.o        libgomp.so         libsanitizer.spec
cc1                g++-mapper-server  libgomp.spec       libssp_nonshared.a
cc1plus            include            libitm.a           libstdc++.a
collect2           libasan.a          libitm.so          libstdc++fs.a
crtbegin.o         libasan_preinit.o  libitm.spec        libstdc++.so
crtbeginS.o        libasan.so         liblsan.a          libsupc++.a
crtbeginT.o        libatomic.a        liblsan_preinit.o  libtsan.a
crtend.o           libatomic.so       liblsan.so         libtsan_preinit.o
crtendS.o          libbacktrace.a     liblto_plugin.so   libtsan.so
crtfastmath.o      libcc1.so          libobjc.a          libubsan.a
crtoffloadbegin.o  libgcc.a           libobjc_gc.a       libubsan.so
crtoffloadend.o    libgcc_eh.a        libobjc_gc.so      lto1
crtoffloadtable.o  libgcc_s.so        libobjc.so         lto-wrapper
crtprec32.o        libgcov.a          libquadmath.a      plugin
crtprec64.o        libgomp.a          libquadmath.so     x32

We obviously want .. to resolve to /mnt, though.
; ls ..
; ls /usr/lib/gcc/x86_64-linux-gnu/
12

So the trigger for "cross into underlying mountpoint" has to be "dentry is
the root of subtree mount refers to" - it depends upon the mount we are
in.

> >  Filesystem object contents belongs here; multiple hardlinks
> > have different dentries and the same inode.
> 
> So, can I assume that an inode could only have as many dentries as hard
> links? I know directories are only allowed to have a single hard link. Is
> that why they can only have a single dentry?

Not quite.  Single alias for directories is more about cache coherency
fun; we really can't afford multiple aliases for those.  For non-directories
it's possible to have an entirely disconnected dentry refering to that
sucker; if somebody hands you an fhandle with no indication of the parent
directory, you might end up having to do one of those, no matter how many
times you find the same inode later.  Not an issue for tracefs, though.

> > namespace: mount tree.  Unlike everything prior, this one is a part of
> > process state - same as descriptor table, mappings, etc.
> 
> And I'm guessing namespace is for containers. At least that's what I've
> been assuming they are for.

It predates containers by quite a few years, but yes, that's one of the
users.  It is related to virtual machines, in the same sense the set
of memory mappings is - each thread can be thought of as a VM, with
a bunch of components.  Just as mmap() manipulates the virtual address
translation for the threads that share memory space with the caller,
mount() manipulates the pathname resolution for the threads that share
the namespace with the caller.

> > descriptor table: mapping from numbers to IO channels (opened files).
> 
> This is that "process fd table" I mentioned above (I wrote that before
> reading this).
> 
> > Again, a part of process state.  dup() creates a new entry, with
> > reference to the same file as the old one; multiple open() of the
> 
> Hmm, wouldn't "dup()" create another "file" that just points to the same
> dentry? It wouldn't be the "same file", or did you mean "file" from the
> user space point of view?

No.  The difference between open() and dup() is that the latter will
result in a descriptor that really refers to the same file.  Current
IO position belongs to IO channel; it doesn't matter for e.g. terminals,
but for regular file it immediately becomes an issue.
	fd1 = open("foo", 0);
	fd2 = open("foo", 0);
	read(fd1, &c1, 1);
	read(fd2, &c2, 1);
will result in the first byte of foo read into c1 and c2, but
	fd1 = open("foo", 0);
	fd2 = dup(fd1);
	read(fd1, &c1, 1);
	read(fd2, &c2, 1);
will have the first byte of foo in c1 and the second one - in c2.
open() yields a new IO channel attached to new descriptor; dup()
(and dup2()) attaches the existing IO channel to new descriptor.
fork() acts like dup() in that respect - child gets its descriptor
table populated with references to the same IO channels as the
parent does.

Any Unix since about '71 has it done that way and the same goes
for NT, DOS, etc. - you can't implement redirects to/from regular
files without that distinction.

Unfortunately, the terms are clumsy as hell - POSIX ends up with
"file descriptor" (for numbers) vs. "file description" (for IO
channels), which is hard to distinguish when reading and just
as hard to distinguish when listening.  "Opened file" (as IO
channel) vs. "file on disc" (as collection of data that might
be accessed via said channels) distinction on top of that also
doesn't help, to put it mildly.  It's many decades too late to
do anything about, unfortunately.  Pity the UNIX 101 students... ;-/

The bottom line:
	* struct file represents an IO channel; it might be operating
on various objects, including regular files, pipes, sockets, etc.
	* current IO position is a property of IO channel.
	* struct files_struct represents a descriptor table; each of
those maps numbers to IO channels.
	* each thread uses a descriptor table to turn numbers ("file
descriptors") into struct file references.  Different threads might
share the same descriptor table or have separate descriptor tables.
current->files points to the descriptor table of the current thread.
	* open() creates a new IO channel and attaches it to an
unused position in descriptor table.
	* dup(n) takes the IO channel from position 'n' in descriptor
table and attaches it to an unused position.
	* dup2(old, new) takes the IO channel from position 'old' and
attaches it to position 'new'; if there used to be something in position
'new', it gets detached.
	* close(n) takes the IO channel from position 'n', flushes and
detaches it.  Note that it IO channel itself is *NOT* closed until
all references to it are gone.  E.g. open() + fork() + (in parent) close()
will end up with the child's descriptor table keeping a reference to
IO channel established by open(); close() in parent will not shut the
channel down.  The same goes for implicit close() done by dup2() or
by exit(), etc.
	* things like mmap() retain struct file references;
open() + mmap() + close() ends up with struct file left (in vma->vm_file)
alive and well for as long as the mapping exists, nevermind the reference
that used to be in descriptor table.  In other words, IO channels can
exist with no references in any descriptor tables.  There are other
ways for such situation to occur (e.g. SCM_RIGHTS stuff); it's entirely
normal.

> > same pathname will each yield a separate opened file.  _Some_ state
> > belongs here (close-on-exec, mostly).  Note that there's no such
> > thing as "the descriptor of this file" - not even "the user-supplied
> > number that had been used to get the file we are currently reading
> > from", since that number might be refering to something entirely
> > different right after we'd resolved it to opened file and that
> > happens *without* disrupting the operation.
> 
> This last paragraph confused me. What do you mean by ""referring to
> something entirely different"?

	Two threads share descriptor table; one of them is in
read(fd, ...), another does dup2(fd2, fd).  If read() gets past the
point where it gets struct file reference, it will keep accessing that
IO channel.  dup2() will replace the reference in descriptor table,
but that won't disrupt the read()...

> 
> Thanks for this overview. It was very useful, and something I think we
> should add to kernel doc. I did read Documentation/filesystems/vfs.rst but
> honestly, I think your writeup here is a better overview.

At the very least it would need serious reordering ;-/

