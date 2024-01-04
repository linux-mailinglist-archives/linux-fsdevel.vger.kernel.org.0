Return-Path: <linux-fsdevel+bounces-7411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094F8248AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB362854B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86E2C191;
	Thu,  4 Jan 2024 19:09:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030A28E15;
	Thu,  4 Jan 2024 19:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34AEC433C8;
	Thu,  4 Jan 2024 19:09:11 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:10:17 -0500
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
Message-ID: <20240104141017.4cd8451f@gandalf.local.home>
In-Reply-To: <20240104182502.GR1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240104014837.GO1674809@ZenIV>
	<20240103212506.41432d12@gandalf.local.home>
	<20240104043945.GQ1674809@ZenIV>
	<20240104100544.593030e0@gandalf.local.home>
	<20240104182502.GR1674809@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 18:25:02 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Thu, Jan 04, 2024 at 10:05:44AM -0500, Steven Rostedt wrote:
> 
> > This is the "tribal knowledge" I'm talking about. I really didn't know how
> > the root dentry parent worked. I guess that makes sense, as it matches the
> > '..' of a directory, and the '/' directory '..' points to itself. Although
> > mounted file systems do not behave that way. My /proc/.. is '/'. I just
> > figured that the dentry->d_parent would be similar. Learn something everyday.  
> 
> What would you expect to happen if you have the same filesystem mounted in
> several places?  Having separate dentry trees would be a nightmare - you'd
> get cache coherency problems from hell.  It's survivable for procfs, but
> for something like a normal local filesystem it'd become very painful.
> And if we want them to share dentry tree, how do you choose where the ..
> would lead from the root dentry?

My mistake was thinking that the dentry was attached more to the path than
the inode. But that doesn't seem to be the case. I wasn't sure if there was
a way to get to a dentry from the inode. I see the i_dentry list, which is
a list, where I got some of my idea that dentry was closer to path than inode.

> 
> The way it's done is that linkage between the trees is done separately -
> there's a tree of struct mount (well, forest, really - different processes
> can easily have separate trees, which is how namespaces are done) and
> each node in the mount tree refers to a dentry (sub)tree in some filesystem
> instance.  Location is represented by (mount, dentry) pair and handling of
> .. is basically (modulo refcounting, locking, error handling, etc.)
> 	while dentry == subtree_root(mount) && mount != mountpoint_mount(mount)
> 		// cross into the mountpoint under it
> 		dentry = mountpoint_dentry(mount)
> 		mount = mountpoint_mount(mount)
> 	go_into(mount, dentry->d_parent)
> 
> Note that you can have e.g. /usr/lib/gcc/x86_64-linux-gnu/12 mounted on /mnt/blah:
> ; mount --bind /usr/lib/gcc/x86_64-linux-gnu/12 /mnt/blah
> will do it.  Then e.g. /mnt/blah/include will resolve to the same dentry as
> /usr/lib/gcc/x86_64-linux-gnu/12/include, etc.
> ; chdir /mnt/blah
> ; ls
> 32                 crtprec80.o        libgomp.so         libsanitizer.spec
> cc1                g++-mapper-server  libgomp.spec       libssp_nonshared.a
> cc1plus            include            libitm.a           libstdc++.a
> collect2           libasan.a          libitm.so          libstdc++fs.a
> crtbegin.o         libasan_preinit.o  libitm.spec        libstdc++.so
> crtbeginS.o        libasan.so         liblsan.a          libsupc++.a
> crtbeginT.o        libatomic.a        liblsan_preinit.o  libtsan.a
> crtend.o           libatomic.so       liblsan.so         libtsan_preinit.o
> crtendS.o          libbacktrace.a     liblto_plugin.so   libtsan.so
> crtfastmath.o      libcc1.so          libobjc.a          libubsan.a
> crtoffloadbegin.o  libgcc.a           libobjc_gc.a       libubsan.so
> crtoffloadend.o    libgcc_eh.a        libobjc_gc.so      lto1
> crtoffloadtable.o  libgcc_s.so        libobjc.so         lto-wrapper
> crtprec32.o        libgcov.a          libquadmath.a      plugin
> crtprec64.o        libgomp.a          libquadmath.so     x32
> 
> We obviously want .. to resolve to /mnt, though.
> ; ls ..
> ; ls /usr/lib/gcc/x86_64-linux-gnu/
> 12
> 
> So the trigger for "cross into underlying mountpoint" has to be "dentry is
> the root of subtree mount refers to" - it depends upon the mount we are
> in.
> 
> > >  Filesystem object contents belongs here; multiple hardlinks
> > > have different dentries and the same inode.  
> > 
> > So, can I assume that an inode could only have as many dentries as hard
> > links? I know directories are only allowed to have a single hard link. Is
> > that why they can only have a single dentry?  
> 
> Not quite.  Single alias for directories is more about cache coherency
> fun; we really can't afford multiple aliases for those.  For non-directories
> it's possible to have an entirely disconnected dentry refering to that
> sucker; if somebody hands you an fhandle with no indication of the parent
> directory, you might end up having to do one of those, no matter how many
> times you find the same inode later.  Not an issue for tracefs, though.
> 
> > > namespace: mount tree.  Unlike everything prior, this one is a part of
> > > process state - same as descriptor table, mappings, etc.  
> > 
> > And I'm guessing namespace is for containers. At least that's what I've
> > been assuming they are for.  
> 
> It predates containers by quite a few years, but yes, that's one of the
> users.  It is related to virtual machines, in the same sense the set
> of memory mappings is - each thread can be thought of as a VM, with
> a bunch of components.  Just as mmap() manipulates the virtual address
> translation for the threads that share memory space with the caller,
> mount() manipulates the pathname resolution for the threads that share
> the namespace with the caller.
> 
> > > descriptor table: mapping from numbers to IO channels (opened files).  
> > 
> > This is that "process fd table" I mentioned above (I wrote that before
> > reading this).
> >   
> > > Again, a part of process state.  dup() creates a new entry, with
> > > reference to the same file as the old one; multiple open() of the  
> > 
> > Hmm, wouldn't "dup()" create another "file" that just points to the same
> > dentry? It wouldn't be the "same file", or did you mean "file" from the
> > user space point of view?  
> 
> No.  The difference between open() and dup() is that the latter will
> result in a descriptor that really refers to the same file.  Current
> IO position belongs to IO channel; it doesn't matter for e.g. terminals,
> but for regular file it immediately becomes an issue.
> 	fd1 = open("foo", 0);
> 	fd2 = open("foo", 0);
> 	read(fd1, &c1, 1);
> 	read(fd2, &c2, 1);
> will result in the first byte of foo read into c1 and c2, but
> 	fd1 = open("foo", 0);
> 	fd2 = dup(fd1);
> 	read(fd1, &c1, 1);
> 	read(fd2, &c2, 1);
> will have the first byte of foo in c1 and the second one - in c2.
> open() yields a new IO channel attached to new descriptor; dup()
> (and dup2()) attaches the existing IO channel to new descriptor.
> fork() acts like dup() in that respect - child gets its descriptor
> table populated with references to the same IO channels as the
> parent does.

Ah, looking at the code I use dup() in, it's mostly for pipes in
and for redirecting stdout,stdin, etc. So yeah, that makes sense.

> 
> Any Unix since about '71 has it done that way and the same goes
> for NT, DOS, etc. - you can't implement redirects to/from regular
> files without that distinction.

Yep, which is what I used it for. Just forgot the details.

> 
> > > same pathname will each yield a separate opened file.  _Some_ state
> > > belongs here (close-on-exec, mostly).  Note that there's no such
> > > thing as "the descriptor of this file" - not even "the user-supplied
> > > number that had been used to get the file we are currently reading
> > > from", since that number might be refering to something entirely
> > > different right after we'd resolved it to opened file and that
> > > happens *without* disrupting the operation.  
> > 
> > This last paragraph confused me. What do you mean by ""referring to
> > something entirely different"?  
> 
> 	Two threads share descriptor table; one of them is in
> read(fd, ...), another does dup2(fd2, fd).  If read() gets past the
> point where it gets struct file reference, it will keep accessing that
> IO channel.  dup2() will replace the reference in descriptor table,
> but that won't disrupt the read()...

Oh, OK. So basically if fd 4 is a reference to /tmp/foo and you open
/tmp/bar which gets fd2, and one thread is reading fd 4 (/tmp/foo), the
other thread doing dup2(fd2, fd) will make fd 4 a reference to /tmp/bar but
the read will finish reading /tmp/foo.

But if the first thread were to do another read(fd, ...) it would then read
/tmp/bar. In other words, it allows read() to stay atomic with respect to
what it is reading until it returns.

> 
> > 
> > Thanks for this overview. It was very useful, and something I think we
> > should add to kernel doc. I did read Documentation/filesystems/vfs.rst but
> > honestly, I think your writeup here is a better overview.  
> 
> At the very least it would need serious reordering ;-/

Yeah, but this is all great information. Thanks for explaining it.

-- Steve

