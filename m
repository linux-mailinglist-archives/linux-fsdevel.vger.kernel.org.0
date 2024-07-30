Return-Path: <linux-fsdevel+bounces-24532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FC9406BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFF51C227BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2795D167DB9;
	Tue, 30 Jul 2024 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JoYAGMyB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395033999;
	Tue, 30 Jul 2024 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316175; cv=none; b=BBQi07UzPvo5uTs1rHOv9NJM3T2IE0LfnUDO8oSk/Et1ApoY7CItrPGb8HS2YGig/19laBFscYXetu5MrPDweJ6ED7RfY51jvsf3qoH44Lf55sSq3wf24l6hJJnujlvpmpX6CJ6O+YF422DYLYElJHBGEI2nCErGJujvvAfvvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316175; c=relaxed/simple;
	bh=gyd7lgr2uBIfrG4wvQT8YL6vBG36VAjgfYxcfN79Sa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gAomlwVwjc15QNJ5in7pYKHonGs0KfG4kGI/U0a7j5jQoRZf77Fj9gpq9DrEFOE4x0fPZ6oEGWopItmNnuVE6rFFKJRkM4IDx6DuDFAMmYgBi6sagmJfa5ma1FyNcwkDE74OAnYz9lUoZhNonWSqBht2LMYiZoUQ/FIcQNnWg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JoYAGMyB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Qs5xSi+EA+j/SCvVf/Fb0RXnC64zVBILT0rM5vsSW4I=; b=JoYAGMyBT+isbw/bhlQZgs5mS7
	NzBlk22DvoGEWLfEK27VDos8Pqu6M3A2NFTLoklIUC405+d8pipkMGKFDcNUPSEG+apTCtm17X9DA
	0mvTglsL8ggnHgE00oCQSKRJbPgYDWpwyXiwyc8ib4E7Rv4wfwOd54rDh/XRMRq1qh2+uvPJQ0Mxg
	KCGQB8XqWYGyBqsP30XO8YlftZVcus9CzH1GJbKLKpC8W3MH0ESCLosABDLdSUE0zqzaQDQrSVt/J
	5LxYpWvUHrfCkygd75AihclG8gKupaLgdtHq9UQbBP1oUjVsUBtKp1zAAWEaGGHSeFyJd+AovTg82
	TDKtpbqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sYf71-000000009PP-0HLF;
	Tue, 30 Jul 2024 05:09:27 +0000
Date: Tue, 30 Jul 2024 06:09:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

		Background
		==========

	Most of the system calls use file descriptors to refer to opened
files (struct file references) currently stored in the given slot(s) of
caller's descriptor table.  There are obvious exceptions (e.g. close(),
dup2(), etc.) where a file descriptor argument is used for more than
that, but those are few.  The common case is something like read(), write(),
etc. - the syscalls that just want to do something with the file specified
by descriptor given by the caller.

	Such system calls need a primitive that would find the struct
file reference by descriptor.  However, finding the reference is not
enough - several threads might share the same descriptor table, so there's
a possibility that descriptor passed to a syscall in one such thread
will be closed by another while the first one is using the file.

	Lifetime of struct file is controlled by refcount; each
reference in a descriptor table contributes to it and struct file
is not shut down until its refcount drops to zero.

	There is a primitive (fget()) that takes a file descriptor and
returns either an extra reference to corresponding struct file (incrementing
its refcount) or NULL (if descriptor is not currently opened).  Decrement
of refcount is done by fput().  We could use that pair of primitives for
all such system calls -
	struct file *file = fget(fd);
	if (file) {	// fd is opened, file contains a cloned reference
		do something
		fput(file);	// release the reference we'd cloned
	} else {	// fd is not opened
		do something else
	}
That way we are guaranteed that file won't be shut down while we are
using it.  That works, but incrmenting and decrementing refcount has
an overhead and for some applications it's non-negligible.

	There is a fairly common case when we don't need to bump the
reference count of struct file: if descriptor table is not shared with
any other threads, we know that nobody else is going to modify it.
In that case we could borrow the struct file reference rather than
cloning it - the reference we'd found in descriptor table is not going
anywhere, making sure that file refcount will remain positive.

	That, of course, does not extend to keeping the file reference
past the return from syscall, passing it to other threads, etc. -
for those uses we have to bump the file refcount, no matter what.
The borrowed reference is not going to remain valid forever; the things
that may terminate its validity are
	* return to userland (close(2) might follow immediately)
	* removing and dropping some reference from descriptor table
(some ioctls have to be careful because of that; they can't outright
close a descriptor - removing a file reference from descriptor table
is fine, but dropping it must be delayed)
	* spawning a thread that would share descriptor table.  Note
that this is the only thing that could turn a previously unshared
table into a shared one.
As long as the borrowing thread does not do any of the above, it is
safe.

	We do need to remember whether we decided to clone or to borrow -
while an unshared descriptor table can't become shared (as long as we
abide by the rules above), the opposite can easily happen.  So when
it comes to deciding whether we need to drop the reference once we
are done with it, we can't just repeat the check - its outcome might
be different by that point.

		struct fd
		=========

	struct fd is the object we use to represent those borrowed or
cloned struct file references.
Valid values are:
	* a cloned file reference; contributes to file refcount,
needs to be dropped when we are done.
	* a borrowed file reference; does *not* contribute to
file refcount.  No need to drop refcount when we are done, but
we need to be guaranteed that original reference will not be
dropped until we are done.
	* empty.
[Note: the current representation is going to change; in the following
I'm going to use a couple of helpers that are currently open-coded
in mainline]

Equivalent of the fget()-based snippet above would be

	struct fd f = fdget(fd);
	if (!fd_empty(f)) { // fd is opened, fd_file(f) is a live file reference
		do something, using fd_file(f)
		fdput(f);
	} else {	// fd is not opened
		do something else
	}

Rules:
	* fdget(n) yields an empty value iff descriptor #n is not open;
otherwise it either borrows or clones the struct file reference that
descriptor refers to.
	* fd_empty(f) is a predicate checking if f is empty.
	* fd_file(f) is NULL if f is empty; otherwise it returns
a pointer to struct file instance that is guaranteed to have a positive
refcount at least until fdput(f).
	* any non-empty instance *MUST* be passed to fdput() exactly once.
Forgetting to do it is a leak; doing it twice is a potential UAF.
[not entirely true - at the moment we have one ugly wart that manages to
get away with violating that rule; sockfd_lookup_light() is really
special that way ;-/]
	* fdput(empty) is a no-op.
	* things that would invalidate the borrowed file references
are not allowed between fdget() and matching fdput().

There are several additional twists.

First of all, most of the syscalls refuse to act upon O_PATH-opened files -
if given a descriptor that corresponds to such file, they fail in the
same way as if it hadn't been opened.  fdget() (as well as fget()) is
where that is handled - we treat finding a reference to O_PATH-opened
file as "no file reference for that descriptor".

However, there are syscalls that do allow O_PATH files - ...at(2)
family is the chief example.  E.g. mkdirat(fd, "foo", 0777) (create
a subdirectory named foo in whatever directory fd refers to) has
no problem with fd being an O_PATH-opened file - that's what it
is usually passed, actually.  There are other syscalls like that
(fchdir(2), etc.); for those we have fget_raw() and fdget_raw() -
same as fget()/fdget(), except that O_PATH-opened files are not
rejected.  Other than that, the rules for fdget_raw() are the same
as for fdget() - it needs to be paired with fdput(), etc.

Next, there are syscalls that want a serialization for their use
of current IO position of file they are acting upon.  That serialization
is on per-struct file basis (as is the IO position itself) and it's
done on file->f_pos_mutex.  The rules are rather convoluted,
but the bottom line is that ->f_pos_mutex needs to be taken in
some, but not all cases.  What's more, we can't just repeat the
checks when it comes to releasing that mutex - we need to
remember whether we'd takeng it or not.  In other words, for those
users we have an additional bit of information to be stored in
struct fd - "->f_pos_mutex needs to be released when we are done".

fdget_pos() handles that; it starts with doing what fdget() would,
then if ->f_pos_mutex needs to be taken, takes it and sets the
"needs to be released in the end" flag.

We could have fdput() handle that, but since fdget() and fdget_raw()
callers outnumber fdget_pos() ones by more than an order of magnitude,
it's better to have a separate destructor (fdput_pos()) to be used
with fdget_pos().  That way we don't get the pointless checks in
syscalls that don't need that serialization.

fdput_pos() must be paired with fdget_pos() - using it with fdget() or
fdget_raw() is a bug, and so's using fdput() with fdget_pos().

The absolute majority of instances comes from fdget(), fdget_raw(),
fdget_pos() (134, 14 and 12 callers resp., as of 6.10-rc1) or explicit
initializers for an empty struct fd (4 instances).

The rest (11 instances, all in overlayfs) arguably should be using
a separate type, similar to struct fd, but not identical to it.
These instances do not come from descriptor table (which means different
rules for what's allowed while using them) and they would be better off
with "error such and such" instead of "empty".  We could try to do
something similar to the way ERR_PTR() abuses pointer types, but
shoehorning that into struct fd ends up with too much headache both
for those instances in overlayfs and for the normal struct fd users;
it's better to use a separate type.


		Code Audit
		==========

Looking through the users of struct fd early in 6.10 cycle has caught
several leaks, as well as a bunch of assorted UAF.  That kind of stuff
keeps cropping up; it would be nice to have as much as possible done
automatically.

The way audit went:
	1.  struct fd is never a member of struct or union.
	2.  no global variables of that type.
	
	3.  Pointers to struct fd:
	3a.  very few such pointers anywhere - they only occur as
arguments to 4 functions (ovl_real_fdget_meta(), ovl_real_fdget(),
timerfd_fget() and perf_fget_light()).	All calls of these functions
are direct ones.  The values passed in such arguments are either
addresses of local struct fd variables in the callers or, in case of
ovl_real_fdget_meta() call in ovl_real_fdget() equal to the corresponding
argument of the latter (i.e. an address of local variable in caller's
caller).  These functions are basically constructors with lousy calling
conventions.
	3b.  none of those 4 functions ever convert the struct fd *
argument to anything, explicitly or implicitly.
	3c.  nothing is ever cast to such pointers.  Implicit conversions
are excluded by the above.
	3d.  the only places where we take address of struct fd are in
arguments of calls of those 4 functions.
	3e.  In other words, all pointers to struct fd are addresses of
local variables of such type.  No dynamically allocated instances exist
- only local variables, formal arguments of functions and return values
of functions.

	4.  the only functions that return struct fd are fdget(),
fdget_raw(), fdget_pos() and their common helper (__to_fd(), not called
by anything else).  All of those are called only directly, return value
is always stored into a local struct fd variable in the caller.  Return
value is formed as a compound literal in __to_fd().  With 4 exceptions
the local variable in question is uninitialized.  Exceptions are
	4a.  xfs_find_handle() and ib_uverbs_open_xrcd() - assignment
is conditional, variable has been initialized empty and later there's
an unconditional fdput().
	4b.  two places in do_mq_notify() - both store to the variable
that is either uninitialized or reused after prior fdput().
	5.  the variable passed to disguised constructors (see above)
is almost always uninitialized.  The only exception is the call of
perf_fget_light() from perf_event_open() - there the variable has been
initialized empty, with conditional call of perf_fget_light() assigning
to it and an unconditional fdput() done downstream.

	6.  Stores to struct fd happen in
	6a.  explicit initializers with fdget{,_raw,_pos}().
	6b.  assignments of the value returned by fdget{,_raw,_pos}()
into uninitialized variables.
	6c.  assignments of the value returned by fdget{,_raw,_pos}()
into empty-initialized variables (see above).
	6d.  assignments of the value returned by fdget{,_raw,_pos}()
into a variable that had been passed to fdput() (see above).
	6e.  explicit initializers with empty (in 3 cases mentioned above)
	6f.  field-by-field assignments to previously uninitialized
variable done by ovl_real_fdget{,_meta}()
	6g.  whole-structure move from local variable to caller's local
variable in perf_fget_light() and timerfd_fget().  The target is either
uninitialized or, in one case, previously initialized empty (see above).
	6h.  In other words, with very few exceptions the variables
are assign-once.

	7.  few functions take struct fd as an argument.  There are two
destructors (fdput() and fdput_pos(), the latter calling the former
unconditionally) and 4 irregulars.
	7a.  vmsplice_type(); only one caller, returns 0 or -EBADF,
equivalent to fdput() if -EBADF has been returned.  struct fd argument
comes from caller's local variable (initialized by prior fdget()), caller
buggers off if it got negative.  IMO we'd be better off expanding it in
its sole call site.
	7b.  ____bpf_prog_get().  Almost the same story.  The difference
is, return value is not an integer - it's either ERR_PTR(...) or the
struct bpf_prog * value found in ->private_data of bpf-prog opened file.
The caller buggers off immediately if IS_ERR() is true.  Not a leak,
but only because ->private_data for those files is never an ERR_PTR(...)
value.  Not that hard to prove, though.
	7c.  map_get_sys_perms(); might as well have been given fd.file
as an argument, neutral from the lifetime POV (immutable borrow, for
rust crowd)
	7d.  __bpf_map_get().  Similar to ____bpf_prog_get(), except
that it wants the file to be bpf-map one.  Again, correctness depends
upon the proof that ->private_data is never ERR_PTR(...) for any of those.
Always immediately downstream of fdget()...  Frankly, I would rather
lift fdput() into the handling of failure exit in the caller - that
would turn what's left into imm borrow argument...

	8.  The only places where we touch a variable downstream of
fdput() are two reuses in do_mq_notify().  In those two cases the
next access after fdput() is assignment of fdget() result.

	9.  The lack of access to uninitialized instances:
	9a.  The first access to any instance is either storing
fdget{,_raw,_pos}() return value in it, or the call of one of the
disguised initializers.  The former initializes the entire struct fd.
	9b.  ovl_read_fdget() returns 0 or -E..., and in the latter
case all callers bugger off without looking at the junk left in
struct fd (and junk it is).  In case when it returns 0, it does
store a valid value in struct fd it's been asked to initialize.
	9c.  ovl_real_fdget_meta() - same story; the only twist is
that it might be tail-called by ovl_real_fdget().
	9d.  timerfd_fget() leaves the target uninitialized when
it returns a negative value.  Callers bugger off immediately if
they see an error.  If it has returned zero, the value left in
the target is something fdget() returned.
	9e.  perf_fget_light() - exact same story.

	10.  Lack of leaks:
	10a.  All calls of fdput_pos() that return a non-empty
value are followed by exactly one call of fdput_pos().
	10b.  Most of the calls of fdget{,_raw}() that return non-empty
value are followed by exactly one call of fdput().  There are several
exceptions.
	10c.  There are two outright leaks (ppc kvm and lirc).
	10d.  timerfd_fget() and perf_fget_light() might move the result
into caller-supplied variable and return 0.  No fdput() in that case -
it's going to be done by caller to the moved value.
	10e.  sockfd_lookup_light() is really, really special.
On success, it forgets the struct fd instance it has done fdget() into,
and returns the "borrowed or cloned" flag via *fput_needed and struct
socket pointer associated with fd.file via return value.  File pointer
is lost; the caller eventually recovers it from ->file pointer in the
struct socket it got and does conditional fput().  That works, but proof
of correctness is highly unpleasant.  The worst part is, it does not
really buy us anything.  We could as well have lifted that struct fd
(along with fdget() and fdput() on failures) into the callers, and used
fdput() instead of this fput_light() song and dance.  Better code
generation and much simpler proof of correctness that way...
	10f.  All successful calls of ovl_real_fdget{,_meta}(),
timerfd_fget() and perf_fget_light() are followed by exactly one call
of fdput().

	That pretty much concludes the analysis as far as memory
safety of struct fd uses goes.  There had been several places where
UAF got caught in the same functions (e.g. fetching ->private_data
and accessing the object it points to after we'd done fdput(),
without anything to guarantee that the object will live past
the file shutdown that becomes possible at that point), plus the
usual scattering of bugs one catches when looking through random
places in the tree.

	It wasn't impossibly hard, but it would be nice to reduce the
amount of PITA next time around.

		How to make it less painful?
		============================

Quite a bit of headache in the audit above had been caused by
irregularities that are relatively easy to deal with:

1.  One low-hanging fruit is sockfd_lookup_light() - getting rid of
that is as simple as turning
	int fput_needed;
	sock = sockfd_lookup_light(fd, &err, &fput_needed);
	if (!sock)
		return err;
	...
	fput_light(sock->file, fput_needed);
into
	struct fd f = fdget(fd);
	if (!f.file)
		return -EBADF;
        sock = sock_from_file(f.file);
	if (!sock) {
		fdput(f);
		return -ENOTSOCK;
	}
	...
	fdput(f);
or, possibly,
	CLASS(fd, f)(fd);
	if (fd_empty(f))
		return -EBADF;
        sock = sock_from_file(fd_file(f));
	if (!sock)
		return -ENOTSOCK;
	...
sockfd_lookup_light() and fput_light() go away, along with the very
unpleasant side trip in the proof of correctness.  At least that
way we have "every non-empty instance must get to destructor" as
a hard rule.

2.  Getting rid of passing struct fd by reference.  There are very
few places where we do that - a couple in overlayfs, timerfd_fget()
and perf_fget_light().

2a.  overlayfs stuff is not quite a match for struct fd.  There we want
not "file reference or nothing" - it's "file reference or an error".
For pointers we can do that by use of ERR_PTR(); strictly speaking, that's
an abuse of C pointers, but the kernel does make sure that the uppermost
page worth of virtual addresses never gets mapped and no architecture
we care about has those as trap representations.  It might be possible
to use the same trick for struct fd; however, for most of the regular
struct fd users that would be a pointless headache - it would pessimize
the code generation for no real benefit.  I considered a possibility of
using represenation of ERR_PTR(-EBADF) for empty struct fd, but that's
far from being consistent among the struct fd users and that ends up
with bad code generation even for the users that want to treat empty as
"fail with -EBADF".

It's better to introduce a separate type, say, struct fderr.
Representable values:
	* borrowed file reference (address of struct file instance)
	* cloned file reference (address of struct file instance)
	* error (a small negative integer).
With sane constructors we get rid of the field-by-field mess in
ovl_real_fdget{,_meta}() and have them serve as initializers,
always returning a valid struct fderr value.

2b.  timerfd_fget() trivially folds into its callers.  perf_fget_light(),
OTOH, is better off converted to is_perf_file(struct fd), with fdget()
and fdput() on failures lifted into the callers.

3.  It would be nice to have all instances assign-once.  We are not
far away from that; with overlayfs stuff taken care of we only have to
deal with reuses in do_mq_notify() and several assignments of fdget()
result into a variable that is currently empty.

Reuses in do_mq_notify() are trivial to get rid of - it's the only user
of netlink_getsockbyfilp() and passing it a descriptor instead of struct
file * (and shifting the fdget()/fdput() pair around the call into the
function itself) is all it takes.

That leaves xfs_find_handle(), ib_uverbs_open_xrcd(), perf_event_open(2).

xfs_find_handle() is basically
	if asked to work by fd
		fdget
		use file_inode() of resulting file
	else
		user_path_at
		use ->dentry->d_inode of resulting path
	do work, using inode
	if asked to work by fd
		fdput
	else
		path_put
IMO it's easier to convert that to
	if asked to work by fd
		fdget
		pin and copy ->f_path of resulting file
		fdput
	else
		user_path_at
	do work, using path.dentry->d_inode
	path_put
Simpler control flow that way, if nothing else...

perf_event_open() and ib_uverbs_open_xrcd() are both basically
	if (fd != -1) {
		fdget
		if empty
			fail
		...
	}
	do some work
	fdput
and seeing that fdget(-1) will always yield empty, we could turn
that into
	fdget	// empty from fdget(-1) is not an error here
	if (fd != -1)
		if empty
			fail
		...
	...
	fdput

I'm not certain if it's the best way to deal with that.  However,
it's very local and with that done we get assign-once for all struct
fd instances.


4.  We are very close to having fdput() done in the same function that
has called fdget().  Exceptions: vmsplice_type(), ____bpf_prog_get() and
__bpf_map_get().  The former two are easier to fold into their respective
sole callers, the last one...  just lift the fdput() on failure into the
callers.  Among other things, the proof of memory safety no longer has to
rely upon file->private_data never being ERR_PTR(...) for bpffs files.
Original calling conventions made it impossible for the caller to tell
whether __bpf_map_get() has returned ERR_PTR(-EINVAL) because it has found
the file not be a bpf map one (in which case it would've done fdput())
or because it found a bpf map file whose ->private_data happened to be
ERR_PTR(-EINVAL) (in which case fdput() would _not_ have been done).
In fact, the latter would never happen, but proving that added a needless
distraction.


This takes care of the irregularities in the audit above.
What remains is verifying that all instances are
	* initialized in the function where they are declared
	* never reassigned
	* never used uninitialized
	* destructor is called in the same function, always
exactly once unless the constructor has yielded an empty
	* never touched after the call of destructor
	* never passed anywhere by reference


		Making compiler do the rest of the work
		=======================================

That does make for a more straightforward audit.  However, it looks like
we could get most of that work done by compiler, if we could make use of
__cleanup without too much PITA.  We even have convenient helpers for
that - CLASS(fd_{,raw}, f)(fd); will have f declared and initialized,
with automatic fdput() whenever we leave the scope.


There are several issues with that approach, though.  First of all, we
want the compiler to see that fdput(empty) is a no-op.  Otherwise we'll
get pointless junk on the EBADF failure exits. Currently it ends up
generating a pointless test + skipped call of fput() there; the reason
is that compiler doesn't know that fdget() et.al.  never return a value
with NULL pointer and non-zero flags.

It's not that hard to deal with - the real primitives behind fdget()
et.al. are returning an unsigned long value, unpacked by (inlined)
__to_fd() into the current struct file * + int.  Linus suggested that
keeping that unsigned long around with the extractions done by inlined
accessors should generate a sane code and that turns out to be the case.
Turning struct fd into a struct-wrapped unsinged long, with
	fd_empty(f) => unlikely(f.word == 0)
	fd_file(f) => (struct file *)(f.word & ~3)
	fdput(f) => if (f.word & 1) fput(fd_file(f))
ends up with compiler doing the right thing.  The cost is the patch
footprint, of course - we need to switch f.file to fd_file(f) all over
the tree, and it's not doable with simple search and replace; there are
false positives, etc.  Might become a PITA at merge time; however,
actual update of that from 6.10-rc1 to 6.11-rc1 had brought surprisingly
few conflicts.


Unfortunately, there are more subtle issues.

The main reason why struct fd might be amenable to __cleanup-based
approaches is that delaying the calls of fdput() is fairly harmless.
If descriptor table had not been shared in the first place, fdput()
is a no-op; if it had been shared, another thread could have bumped
the refcount of our file for a while, so we had no warranty that
fdput() would've driven the refcount to zero.  Delaying fdput_pos()
is potentially more damaging, since it involves releasing a mutex,
but it's always done to local variable defined in the same function
and the only things ever done between it and return are sys_inc{r,w}()
and add_{r,w}char().  Those never call anything else, so even if we delay
the calls of fdput_pos() all the way to the end of function where their
argument is defined, we won't get any deadlocks.

So the lifetime of struct fd instance could be stretched to the end of
whatever scope we are in.  However, there is another kind of trouble -
if fdget() is not in the very beginning of the scope, we might have
	do something
	if (failed)
		goto out;
	f = fdget(...);
	....
	fdput(f);
out:
	do something else
which is *not* going to tolerate shifting the fdput() downstream.
If that "do something else" is simply a return - not a problem, we
can simply replace the goto with return.  If it's something trickier,
we have a problem.


The really bad problem (and one of the reasons why I'm cautious about
__cleanup()-based approaches in general) is that gcc does *NOT* notice
a problem in the pattern that comes from the "goto around fdget()/fdput()"
trouble case above:
	if (foo)
		goto l;
	some_type var __cleanup(destructor) = expr;
	...
l:	// no uses of of var from that point on
It quietly produces garbage, at least up to gcc 12.  clang does catch
that kind of bugs, but we can neither make it mandatory (not all
targets are supported, to start with) nor bump the minimal gcc version
from 5.1 all the way to 13.  For this series most of the affected code
is covered by LLVM=1 builds and the few places not covered were not
hard to examine manually.  Note that this "goto around" thing is not
a pure theory; I've run into it several times in this series.  Any
patches that convert to CLASS(...) use need to watch out for that
kind of trouble.


Let's take a look at the prep cleanups from that POV:

	* sockfd_lookup_light() elimination.  sockfd_lookup_light() has
13 callers; 7 of those (__sys_bind(), __sys_listen(), __sys_getsockname(),
___sys_getpeername(), __sys_setsockopt(), __sys_getsockopt(),
__sys_shutdown()) are as simple as it gets; sockfd_lookup_light()
call is the first thing done in the scope, fput_light() is immediately
followed by return.  Those clearly can be converted to CLASS(fd) without
any trouble for code generation, provided that representation change for
struct fd is already done.  The rest (__sys_sendto(), __sys_recvfrom(),
__sys_sendmsg(), __sys_sendmmsg(), __sys_recvmsg(), do_recvmmsg()) have
some work (and failure exits) prior to the call of sockfd_lookup_light(),
but all of those failure exits are plain returns and fput_light() is
still immediately followed by return.  In other words, those can also
be converted to CLASS(fd) without any problems.
	Doing that ends up with cleaner control flow in the callers.
Looks like CLASS(fd) conversion is the thing to do for those.

	* overlayfs struct fderr stuff.  There the things get trickier;
we obviously need a separate DEFINE_CLASS there (different constructor,
if nothing else), but that's not all.  Some callers of ovl_real_fdget()
are simple (ovl_splie_read(), ovl_fadvise(), ovl_flush()) - nothing
before ovl_real_fdget(), fdput() at the very end.  Those can be converted
easily.  ovl_fsync() would be the same way, except for a different
constructor.  Two more (ovl_llseek() and ovl_read_iter()) have
work (and exits) prior to the call of ovl_real_fdget(), but those
exits are plain returns.  Also converts just fine.
	Unfortunately, there are 4 callers that are done under
inode_lock() on the overlayfs file.  For two of them (ovl_write_iter()
and ovl_splice_write()) we would end up with fdput() reordered past
the inode_unlock(), but that would be it; however, for ovl_fallocate()
and ovl_copyfile() we really have a problem - the pattern in those is
	inode_lock()
	...
	file_remove_privs() and goto out_unlock if that fails
	ovl_real_fdget()
	work
	fdput()
	out_unlock: inode_unlock()
There pushing fdput() downstream would be a real bug.

	Not sure what would be the best way to deal with that.
Theoretically, we could have that inode_unlock() done via __cleanup;
that would've solved the immediate problem, but I really hate that idea.
That's the kind of attractive nuisance that is pretty much guaranteed to
spread and it _will_ end up a source of deadlocks.  For now I went with
the minimally invasive approach and added a scope from ovl_real_fdget()
to fdput() in each of those 4 functions; that makes all of them trivial
to convert.  Another option would be to take the same areas into helper
functions...

	Unlike the sockfd_lookup_light() removal, I think it's better to
keep the conversion to CLASS(...) separate from the prep cleanup per se.


	* timerfd_fget().  Two callers, do_timerfd_gettime() calls
timerfd_fget() at the very beginning, do_timerfd_settime() - after
a check with immediate return on failure.  In both cases fdput()
is immediately followed by return.  Trivial conversion to CLASS(fd).

	* perf_fget_light().  Same picture in both callers - if descriptor
is not -1, we want it to be an opened perf file (with -EBADF otherwise)
and the object we are really interested in is the ->private_data of the
perf file in question.  That object is valid as long as the file is
open.  In _perf_ioctl() we have
		if (arg != -1) {
			struct perf_event *output_event;
			struct fd output;
			ret = perf_fget_light(arg, &output);
			if (ret)
				return ret;
			output_event = fd_file(output)->private_data;
			ret = perf_event_set_output(event, output_event);
			fdput(output);
		} else {
			ret = perf_event_set_output(event, NULL);
		}
and naive conversion would be
		if (arg != -1) {
			CLASS(fd, output)(arg);
			struct perf_event *output_event;
			if (!is_perf_file(output))
				return -EBADF;
			output_event = fd_file(output)->private_data;
			return perf_event_set_output(event, output_event);
		} else {
			return perf_event_set_output(event, NULL);
		}
which, while correct, is really asking for trouble - it would tempt
a reader to lift the declaration of output_event outside of that
if, turning it into
		struct perf_event *output_event = NULL;
		if (arg != -1) {
			CLASS(fd, output)(arg);
			if (!is_perf_file(output))
				return -EBADF;
			output_event = fd_file(output)->private_data;
		}
		return perf_event_set_output(event, output_event);
but that would be an instant UAF - we can't use output_event after
the (now implicit) fdput(output).  We need output in the same scope
as output_event, so IMO the variant least likely to invite trouble
down the road would be this:
		struct perf_event *output_event = NULL;
		CLASS(fd, output)(arg);	// arg == -1 => empty
		if (arg != -1) {
			if (!is_perf_file(output))
				return -EBADF;
			output_event = fd_file(output)->private_data;
		}
		return perf_event_set_output(event, output_event);
The situation in the other caller (perf_event_open(2)) is similar;
there we have a conditional assignment replacing empty with the result
of fdget() when group_fd is not equal to -1.  Again, lifting fdget()
outside of the check for descriptor being -1 avoids the headache.
This case is also easy to convert to CLASS(fd) - all failure exits prior
to fdget() are plain returns and the only thing downstream of fdput()
(put_unused_fd()) can be safely transposed with it.

	NB: transposition can be avoided if put_unused_fd() itself
is done via __cleanup(); I was (and still am) sceptical about that,
but Christian added such DEFINE_CLASS lately.  And yes, blind conversion
to that would be a problem ;-/
	
	* do_mq_notify() reuses: netlink_getsockbyfd() converts to
CLASS(fd, ...) trivially.  The call of fdget() remaining in do_mq_notify()
is _not_ trivial to convert, thanks to the weirdness past the matching
fdput():
	fdput(f);
out:
	if (sock)
		netlink_detachskb(sock, nc);
	else
free_skb:
		dev_kfree_skb(nc);
	return ret;
Unfortunately, there are gotos from before the fdget() both to 'out'
and to 'free_skb'.  Those gotos are bollocks, though - not only because
microoptimizing such failure exits is a bad idea; all gotos to 'free_skb'
should really have been calls of kfree_skb(nc) followed by return.
With that done, we are left with no way to reach 'out' with !sock &&
nc, so that dev_kfree_skb() becomes a dead code.
	After that do_mq_notify() can be switched to CLASS(fd) - all
failure exits prior to fdget() are returns and the only thing downstream
of fdput() is a call of netlink_detachskb(), which can be safely done
before the fdput().

	* getting rid of reassignment in xfs_find_handle().  Result is
trivial to convert to CLASS(fd) - we have fdget() in the very beginning
of scope and fdput() at the very end, several lines later...

	* ib_uverbs_open_xrcd().  FWIW, a closer look shows that the
damn thing is buggy - it accepts _any_ descriptor and pins the associated
inode.  mount tmpfs, open a file there, feed it to that, unmount and
watch the show...  AFAICS, that's done for the sake of libibverbs and
I've no idea how it's actually used - all examples I'd been able to
find use -1 for descriptor here.  Needs to be discussed with infiniband
folks (Sean Hefty?).  For now, leave that as-is.

	* Expanding the vmsplice_type() call.  Result is trivial to convert
to CLASS(fd) - the only failure exit prior to fdget() is a return, all
fdput() are immediately followed by returns.

	* Expanding ____bpf_prog_get() call.  Result is trivial to convert -
fdget() is the very first thing done, all fdput() are immediately followed
by returns.

	* Lifting fdput() from __bpf_map_get().  There are 15
callers.  bpf_map_meta_alloc(), bpf_map_fd_get_ptr(), bpf_map_get(),
bpf_map_get_with_uref() are trivially converted to CLASS(fd); fdget()
is the very first thing done, all fdput() are immediately followed
by returns.  map_lookup_elem(), map_update_elem(), map_delete_elem(),
map_get_next_key(), map_lookup_and_delete_elem(), map_freeze(),
bpf_map_do_batch(), sock_map_get_from_fd(), sock_map_prog_detach()
and sock_map_bpf_prog_query() are also trivial - the only failure
exits prior to fdget() are plain returns and all fdput() are immediately
followed by returns.
	However, the caller in resolve_pseudo_ldimm64() is not trivial.
What happens there is a pass through the array of insns, decoding and
massaging some of two-slot insns.  Massage involves getting a bpf_map by
descriptor we extract from instruction, attaching a reference to that
map to program we are rewriting and replacing the insn with equivalent
that uses that map.  There's a bunch of sanity checks, each with fdput()
on failure, so a conversion to CLASS(fd) would be very nice to have;
unfortunately, there's both a bit of work done after fdput() *and* a goto
to that work from before the fdget().  The former wouldn't be a problem
(the work in question is transposable with fdput()), but the latter is
more serious.
	Lifting this "process one insn" into a helper resolves that,
and result is actually easier to read.
	With that done as a preparatory step, this caller of fdget()
(now in the helper) converts to CLASS(fd) trivially - all failure
exits prior to it are returns, all fdput() are immediately followed
by returns.


	In other words, prep cleanups are playing nice wrt CLASS(fd)
conversions.  There are several places in overlayfs where we need an
explicit extra scope, reordering fdput() with put_unused_fd()
in perf_event_open(2) and possibly something in ib_uverbs_open_xrcd() -
the last one left alone for now.


	With the prep done, most of the remaining values come from
fdget(); fdget_raw() and fdget_pos() are in minority.  fdget_raw()
already has CLASS equivalent (fd_raw); it turns out that _all_
existing callers of fdget_raw() are trivial to convert - all of
them are the very first thing in their scopes and corresponding
fdput() are immediately followed by leaving the scope (either
by return or, in one case, by being the last statement in the scope).
So fdget_raw() converts trivially.


	fdget_pos() doesn't have a matching CLASS() defined, so we'd need
to add one (with fdput_pos() for destructor).  All calls of fdget_pos()
are the very first things done in their scopes; in 10 cases out of 12
(osf_getdirentries(2), ksys_lseek(), llseek(2), ksys_read(), ksys_write(),
old_readdir(2), getdents(2), getdents64(2), old_readdir(2, compat),
getdents(2, compat)) the matching fdput_pos() is immediately followed
by return, making them trivial to convert.  In the remaining two
(do_readv() and do_writev()) there's add_{r,w}char() and inc_sysc{r,w}()
calls downstream of fdput(); fdput_pos() is transposable with those,
so these callers also can be converted.
	Incidentally, there's an inconsistency in rules for calling
inc_sysc{r,w}() - read(2) calls inc_syscr() only when descriptor is
actually opened, but readv(2) does it on every call, opened descriptor
or not.  Had been that way since 2005, when these counters had been
introduced...


	With that taken care of, all we have left is (a plenty of)
fdget() callers.  That falls into several classes:

1) Simple - fdget() done at the beginning of block, fdput() is the last
thing in the block and happens on all paths that leave the block.
Those are trivial to convert to CLASS(fd.....), with no behaviour
changes.
	kvm_spapr_tce_attach_iommu_group()
	kvm_vcpu_ioctl_enable_cap() [3 cases in it]
	spu_create(2)
	sgx_set_attribute()
	__sev_issue_cmd()
	sev_vm_move_enc_context_from()
	amdgpu_sched_process_priority_override()
	amdgpu_sched_context_priority_override()
	drm_syncobj_fd_to_handle()
	rc_dev_get_from_fd()
	__btrfs_ioctl_snap_create()
	eventfd_ctx_fdget()
	do_epoll_ctl() [two nested]
	ioctl_file_clone()
	ioctl(2)
	ioctl(2, compat)
	kernel_read_file_from_fd()
	fanotify_find_path()
	ksys_fallocate()
	fchmod(2)
	ksys_fchown()
	copy_file_range(2) [two nested]
	do_signalfd4()
	syncfs(2)
	do_fsync()
	ksys_sync_file_range()
	fsetxattr(2)
	fgetxattr(2)
	flistxattr(2)
	fremovexattr(2)
	io_attach_sq_data()
	io_sq_offload_create()
	btf_get_by_fd()
	bpf_link_get_from_fd()
	bpf_token_get_from_fd()
	perf_cgroup_connect()
	setns(2)
	pidfd_get_pid()
	prctl_set_mm_exe_file()
	get_watch_queue()
	ksys_fadvise64_64()
	ksys_readahead()
	get_net_ns_by_fd()
	get_ruleset_from_fd()
	kvm_vfio_file_del()
	fini_module()

2) same, but some work (and failure exits) might precede fdget();
fdput() is still immediately followed by leaving the scope.
	ucma_migrate_id()
	do_epoll_wait()
	__ext4_ioctl()
	__f2fs_ioc_move_range()
	fsconfig(2)
	fuse_dev_ioctl_clone()
	flock(2)
	fsmount(2)
	build_mount_idmapped()
	do_fanotify_mark()
	inotify_add_watch(2)
	do_sys_ftruncate()
	ksys_pread64()
	ksys_pwrite64()
	do_sendfile() [two nested]
	splice(2) [two nested]
	tee(2) [two nested]
	xfs_ioc_exchange_range()
	xfs_ioc_swapext() [two nested]
	do_mq_timedsend()
	do_mq_timedreceive()
	do_mq_getsetattr()
	bpf_obj_get_info_by_fd()
	pidfd_getfd(2)
	pidfd_send_signal(2)
	cgroupstats_user_cmd()
	ima_kexec_cmdline()
	read_trusted_verity_root_digests()
	kvm_vfio_file_set_spapr_tce()

That leaves relatively few callers.  Further look at those shows
	* an fdget() call in ib_uverbs_open_xrcd() - to be left alone for
now.
	* do_p{read,write}v().  fdput() is followed by inc_sysc{r,w}() and
possibly add_{r,w}char() there; it's the same story as in do_{read,write}v(),
except that here we use fdget()/fdput() instead of fdget_pos()/fdput_pos(),
and we can transpose those with fdput() just as we could with fdput_pos().
	* cachestat(2).  fdput() is followed by copy_to_user() there,
and it obviously can be transposed with it.  Again, a harmless reorder
is all it takes.
	* spu_run(2).  spufs_calls_put() is transposable with fdput();
might or might not be worth converting spufs_calls_put() to __cleanup - doing
that would get rid of transposition.  Actually, such conversion does look
good...
	* media_request_get_by_fd().  Debugging printk after fdput() on
failure exit path.  Transposable with fdput().
	* coda_parse_fd().  Nearly the same, with invalf() in role of
debugging printk.
	* cifs_ioctl_copychunk().  fdput() is followed by mnt_drop_file_write(); 
all failure exits before fdget() are returns and fdput() _can_ be moved past
mnt_drop_file_write().  Alternatively, we could add a scope there (from
fdget() to fdput()) _OR_ make mnt_{want,drop}_file_write() usable via
CLASS; either would avoid reordering.  The latter is surprisingly plausible,
but that's a separate series.
	* vfs_dedupe_file_range().  fdput() is followed by checking
fatal_signal_pending() (and aborting the loop in such case).  Transposable
with that check.  Yes, it'll probably end up with slightly fatter code
(call after the check has returned false + call on the almost never taken
out-of-line path instead of one call before the check), but it's not worth
bothering with explicit extra scope there (or dragging the check into
the loop condition, for that matter).
	* do_select().  IMO the simplest solution is to take the logics
from fdget() to fdput() into an inlined helper - with existing wait_key_set()
subsumed into that.  No reordering.
	* do_pollfd().  Setting pollfd->revents is downstream of fdput() and
has a goto from before fdget() leading to it.  Solution: lift it into the
only caller of do_pollfd().  No reordering.
	* bpf_token_create().  Hell knows - it copies ->f_path, grabs
a reference to it and does fdput().  struct path is dropped at the very
end.  My preference would be to have file reference kept thourough the
entire thing instead and just use file->f_path instead of its copy.
However, security_bpf_token_create(token, attr, &path) in there takes
struct path *, rather than const struct path.  Hell knows why - the
only LSM that has the corresponding hook ignores the path argument
completely.  Need to discuss with LSM folks.
	* o2hb_region_dev_store() - would've been in the class
above, if not for pointless gotos to return statement just
past the fdput().  Prep commit before the conversions to regularize
that caller.
	* privcmd_ioeventfd_assign() that shouldn't be using fdget() at
all - it actually open-codes eventfd_ctx_fdget() and it ought to just
call it, same as privcmd_ioeventfd_deassign() does.
	* irqfd and friends.  Failure exits prior to fdget() are plain
returns, with one exception (privcmd, where a failure in copy_from_user()
results in goto to the place where we kfree() the thing we'd just
allocated), the only thing downstream of fdput() is (on failure exit)
a kfree() and fdput() can be moved past that.  For privcmd we also need
to move fdget() up - I'd taken it to just before the allocation, leaving
the emptiness check where it was, so that the error values wouldn't
change.  Not pretty, to put it mildly.	That's vfio_virqfd_enable(),
acrn_irqfd_assign(), privcmd_irqfd_assign() and kvm_irqfd_assign().
	* memcg_write_event_control().  Several issues here - for one thing,
its string handling is fucked; accepted inputs are
	<spaces><number> <number><spaces>
or
	<spaces><number> <number> <arguments><spaces>
The numbers represent two file descriptors; <arguments> is a string that
gets interpreted in a way that depends upon the sysfs file we are using.
memcg_write_event_control() starts with parsing the string it had been
given; it decodes the numbers and leaves 'buf' pointing to the location
2 bytes past the end of the second number.  In the second form (with
arguments present) that would point to arguments string.  Unfortunately,
if there'd been neither arguments nor trailing spaces, that pointer
goes 1 byte past the NUL.  And that pointer gets used for further
parsing of arguments.  The original array is what the userland had
passed to write(2), with NUL appended to it.  So a write() of 4095-byte
array, filled with a bunch of spaces followed by a descriptor, space and
another descriptor (and no NUL anywhere) will end up trying to pass
an unmapped address to strcmp().
	Another issue is that the cleanup logics is really messy -
it gradually builds an object that will either end up shoved
into memcg->event_list (on success) or taken apart (on failure).
Theoretically, the latter could be turned into __cleanup-based
destruction, but that's way too much for this series.  The minimal massage
that would suffice for CLASS(fd) conversion is to move both fdget()
to the point before the kmalloc(), with matching fdput() moved to the
very end of cleanup sequence.  After that conversion becomes trivial,
but the whole thing is definitely not pretty.  It is similar to irqfd
stuff, actually; any sanitizing of cleanups in those would probably best
go together (possibly along with other eventfd users).


Overall, looks like conversion to CLASS(fd, ...) is doable with a bit of
preliminary work.  Problematic cases exist, but they are few.  I'd
done such branch (6.10-rc1-based).  The interesting part had been to
see how hard would it be to rebase to 6.11-rc1; that turned out to be
easier than I expected.

The current branch lives in 
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd

Individual patches in followups; it definitely needs review and testing.

Shortlog:
Al Viro (39):
      memcg_write_event_control(): fix a user-triggerable oops
      introduce fd_file(), convert all accessors to it.
      struct fd: representation change
      add struct fd constructors, get rid of __to_fd()
      regularize emptiness checks in fini_module(2) and vfs_dedupe_file_range()
      net/socket.c: switch to CLASS(fd)
      introduce struct fderr, convert overlayfs uses to that
      experimental: convert fs/overlayfs/file.c to CLASS(...)
      timerfd: switch to CLASS(fd, ...)
      get rid of perf_fget_light(), convert kernel/events/core.c to CLASS(fd)
      switch netlink_getsockbyfilp() to taking descriptor
      do_mq_notify(): saner skb freeing on failures
      do_mq_notify(): switch to CLASS(fd, ...)
      simplify xfs_find_handle() a bit
      convert vmsplice() to CLASS(fd, ...)
      convert __bpf_prog_get() to CLASS(fd, ...)
      bpf: resolve_pseudo_ldimm64(): take handling of a single ldimm64 insn into helper
      bpf maps: switch to CLASS(fd, ...)
      fdget_raw() users: switch to CLASS(fd_raw, ...)
      introduce "fd_pos" class, convert fdget_pos() users to it.
      o2hb_region_dev_store(): avoid goto around fdget()/fdput()
      privcmd_ioeventfd_assign(): don't open-code eventfd_ctx_fdget()
      fdget(), trivial conversions
      fdget(), more trivial conversions
      convert do_preadv()/do_pwritev()
      convert cachestat(2)
      switch spufs_calls_{get,put}() to CLASS() use
      convert spu_run(2)
      convert media_request_get_by_fd()
      convert coda_parse_fd()
      convert cifs_ioctl_copychunk()
      convert vfs_dedupe_file_range().
      convert do_select()
      do_pollfd(): convert to CLASS(fd)
      convert bpf_token_create()
      assorted variants of irqfd setup: convert to CLASS(fd)
      memcg_write_event_control(): switch to CLASS(fd)
      css_set_fork(): switch to CLASS(fd_raw, ...)
      deal with the last remaing boolean uses of fd_file()

Diffstat:
 arch/alpha/kernel/osf_sys.c                |   7 +-
 arch/arm/kernel/sys_oabi-compat.c          |  18 +-
 arch/powerpc/kvm/book3s_64_vio.c           |  23 +-
 arch/powerpc/kvm/powerpc.c                 |  30 +--
 arch/powerpc/platforms/cell/spu_syscalls.c |  68 ++----
 arch/x86/kernel/cpu/sgx/main.c             |  10 +-
 arch/x86/kvm/svm/sev.c                     |  43 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  |  27 +--
 drivers/gpu/drm/drm_syncobj.c              |  11 +-
 drivers/infiniband/core/ucma.c             |  21 +-
 drivers/infiniband/core/uverbs_cmd.c       |  12 +-
 drivers/media/mc/mc-request.c              |  22 +-
 drivers/media/rc/lirc_dev.c                |  15 +-
 drivers/vfio/group.c                       |  10 +-
 drivers/vfio/virqfd.c                      |  20 +-
 drivers/virt/acrn/irqfd.c                  |  17 +-
 drivers/xen/privcmd.c                      |  32 +--
 fs/btrfs/ioctl.c                           |   7 +-
 fs/coda/inode.c                            |  13 +-
 fs/eventfd.c                               |   9 +-
 fs/eventpoll.c                             |  62 ++----
 fs/ext4/ioctl.c                            |  23 +-
 fs/f2fs/file.c                             |  17 +-
 fs/fcntl.c                                 |  74 +++----
 fs/fhandle.c                               |   7 +-
 fs/file.c                                  |  26 +--
 fs/fsopen.c                                |  23 +-
 fs/fuse/dev.c                              |  10 +-
 fs/ioctl.c                                 |  47 ++---
 fs/kernel_read_file.c                      |  12 +-
 fs/locks.c                                 |  27 +--
 fs/namei.c                                 |  19 +-
 fs/namespace.c                             |  53 ++---
 fs/notify/fanotify/fanotify_user.c         |  50 ++---
 fs/notify/inotify/inotify_user.c           |  44 ++--
 fs/ocfs2/cluster/heartbeat.c               |  28 ++-
 fs/open.c                                  |  67 +++---
 fs/overlayfs/file.c                        | 195 ++++++++---------
 fs/quota/quota.c                           |  18 +-
 fs/read_write.c                            | 227 ++++++++------------
 fs/readdir.c                               |  38 ++--
 fs/remap_range.c                           |  11 +-
 fs/select.c                                |  50 ++---
 fs/signalfd.c                              |  11 +-
 fs/smb/client/ioctl.c                      |  17 +-
 fs/splice.c                                |  82 +++-----
 fs/stat.c                                  |  14 +-
 fs/statfs.c                                |  12 +-
 fs/sync.c                                  |  33 ++-
 fs/timerfd.c                               |  44 ++--
 fs/utimes.c                                |  11 +-
 fs/xattr.c                                 |  59 +++---
 fs/xfs/xfs_exchrange.c                     |  12 +-
 fs/xfs/xfs_handle.c                        |  16 +-
 fs/xfs/xfs_ioctl.c                         |  85 +++-----
 include/linux/bpf.h                        |   9 +-
 include/linux/cleanup.h                    |   2 +-
 include/linux/file.h                       |  86 +++++---
 include/linux/netlink.h                    |   2 +-
 io_uring/sqpoll.c                          |  31 +--
 ipc/mqueue.c                               | 137 ++++--------
 kernel/bpf/bpf_inode_storage.c             |  29 +--
 kernel/bpf/btf.c                           |  13 +-
 kernel/bpf/map_in_map.c                    |  38 +---
 kernel/bpf/syscall.c                       | 197 ++++++-----------
 kernel/bpf/token.c                         |  82 +++-----
 kernel/bpf/verifier.c                      | 327 ++++++++++++++---------------
 kernel/cgroup/cgroup.c                     |  21 +-
 kernel/events/core.c                       |  69 +++---
 kernel/module/main.c                       |  15 +-
 kernel/nsproxy.c                           |  15 +-
 kernel/pid.c                               |  26 +--
 kernel/signal.c                            |  33 ++-
 kernel/sys.c                               |  21 +-
 kernel/taskstats.c                         |  20 +-
 kernel/watch_queue.c                       |   8 +-
 mm/fadvise.c                               |  10 +-
 mm/filemap.c                               |  19 +-
 mm/memcontrol-v1.c                         |  59 +++---
 mm/readahead.c                             |  25 +--
 net/core/net_namespace.c                   |  14 +-
 net/core/sock_map.c                        |  23 +-
 net/netlink/af_netlink.c                   |   9 +-
 net/socket.c                               | 303 ++++++++++++--------------
 security/integrity/ima/ima_main.c          |   9 +-
 security/landlock/syscalls.c               |  57 ++---
 security/loadpin/loadpin.c                 |  10 +-
 sound/core/pcm_native.c                    |   6 +-
 virt/kvm/eventfd.c                         |  19 +-
 virt/kvm/vfio.c                            |  18 +-
 90 files changed, 1462 insertions(+), 2239 deletions(-)

Outline of the series:

01/39) memcg_write_event_control(): fix a user-triggerable oops
	will go into #fixes (or via cgroup tree); broken string
handling, caught during that audit, independent from the rest.

Representation change for struct fd:
02/39) introduce fd_file(), convert all accessors to it.
03/39) struct fd: representation change
04/39) add struct fd constructors, get rid of __to_fd()
05/39) regularize emptiness checks in fini_module(2) and vfs_dedupe_file_range()

By this point we have struct fd switched to new representation, accessors added,
all emptiness checks done directly on struct fd instances.

06/39) net/socket.c: switch to CLASS(fd)
	Get rid of the sockfd_lookup_light() and associated irregularities;
fput_light() gone, old users of sockfd_lookup_light() switched to CLASS(fd) +
sock_from_file().

Overlayfs stuff:
07/39) introduce struct fderr, convert overlayfs uses to that
08/39) experimental: convert fs/overlayfs/file.c to CLASS(...)
	
This introduces struct fderr and switches overlayfs to using that
instead of struct fd.

Getting rid of passing struct fd by reference:
09/39) timerfd: switch to CLASS(fd, ...)
10/39) get rid of perf_fget_light(), convert kernel/events/core.c to CLASS(fd)

do_mq_notify() regularization:
11/39) switch netlink_getsockbyfilp() to taking descriptor
12/39) do_mq_notify(): saner skb freeing on failures
13/39) do_mq_notify(): switch to CLASS(fd, ...)

After that the weirdness with reassignments in do_mq_notify() is gone
(and, IMO, result is easier to follow).

14/39) simplify xfs_find_handle() a bit
	Massage to get rid of reassignment there; simplifies control
flow...

Making sure that fdget() and fdput() are done in the same function:
15/39) convert vmsplice() to CLASS(fd, ...)
16/39) convert __bpf_prog_get() to CLASS(fd, ...)
17/39) bpf: resolve_pseudo_ldimm64(): take handling of a single ldimm64 insn into helper
18/39) bpf maps: switch to CLASS(fd, ...)

Deal with fdget_raw() and fdget_pos() users - all trivial to convert.
19/39) fdget_raw() users: switch to CLASS(fd_raw, ...)
20/39) introduce "fd_pos" class, convert fdget_pos() users to it.

Prep for fdget() conversions:
21/39) o2hb_region_dev_store(): avoid goto around fdget()/fdput()
22/39) privcmd_ioeventfd_assign(): don't open-code eventfd_ctx_fdget()

23/39) fdget(), trivial conversions.
	Big one: all callers that have fdget() done the first thing in
scope, with all matching fdput() immediately followed by leaving the
scope.  All of those are trivial to convert.
24/39) fdget(), more trivial conversions
	Same, except that fdget() is preceded by some work.  All fdput()
are still immediately followed by leaving the scope.  These are also
trivial to convert, and along with the previous commit that takes care
of the majority of fdget() calls.

25/39) convert do_preadv()/do_pwritev()
	fdput() is transposable with everything done after it (inc_syscw()
et.al.)
26/39) convert cachestat(2)
	fdput() is transposable with copy_to_user() downstream of it.

27/39) switch spufs_calls_{get,put}() to CLASS() use
28/39) convert spu_run(2)
	fdput() used to be followed by spufs_calls_put(); we could transpose
those two, but spufs_calls_get()/spufd_calls_put() itself can be converted
to CLASS() use and it's cleaner that way.

29/39) convert media_request_get_by_fd()
	fdput() is transposable with debugging printk
30/39) convert coda_parse_fd()
	fdput() is transposable with invalf()

31/39) convert cifs_ioctl_copychunk()
	fdput() moved past mnt_drop_file_write(); harmless, if somewhat
cringeworthy.  Reordering could be avoided either by adding an explicit
scope or by making mnt_drop_file_write() called via __cleanup...

32/39) convert vfs_dedupe_file_range()
	fdput() is followed by checking fatal_signal_pending() (and aborting
the loop in such case).  fdput() is transposable with that check.
Yes, it'll probably end up with slightly fatter code (call after the
check has returned false + call on the almost never taken out-of-line path
instead of one call before the check), but it's not worth bothering with
explicit extra scope there (or dragging the check into the loop condition,
for that matter).

33/39) convert do_select()
	take the logics from fdget() to fdput() into an inlined helper -
with existing wait_key_set() subsumed into that.
34/39) do_pollfd(): convert to CLASS(fd)
	lift setting ->revents into the caller, so that failure exits
(including the early one) would be plain returns.

35/39) convert bpf_token_create()
	keep file reference through the entire thing, don't bother with
grabbing struct path reference (except, for now, around the LSM call
and that only until it gets constified) and while we are at it, don't
confuse the hell out of readers by random mix of path.dentry->d_sb and
path.mnt->mnt_sb uses - these two are equal, so just put one of those
into a local variable and use that.

36/39) assorted variants of irqfd setup: convert to CLASS(fd)
	fdput() is transposable with kfree(); some reordering
is required in one of those (we do fdget() a bit earlier there).
37/39) memcg_write_event_control(): switch to CLASS(fd)
	similar to the previous.  As the matter of fact, there
might be a missing common helper or two hiding in both...

38/39) css_set_fork(): switch to CLASS(fd_raw, ...)
	could be separated from the series; its use of fget_raw()
could be converted to fdget_raw(), with the result convertible to
CLASS(fd_raw)

39/39) deal with the last remaing boolean uses of fd_file()
	most of them had been converted to fd_empty() by now; pick
the strugglers.

