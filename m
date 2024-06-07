Return-Path: <linux-fsdevel+bounces-21263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2C900932
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26EB2859A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56948197A99;
	Fri,  7 Jun 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnY1zHUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697526288
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774243; cv=none; b=pdxa6XZ0YIau1L4e+JPTAVw0WODvszGHjTxJQa5+ChTHA+9eNkzMs6uVy+YzocxQE7yp3uNpPXXknTorXl5/iV0xfX5QTXuejptN65It6dq5v/ZG/6NcswWjJfnj+l7do1jodiMsiqXVfOLmu3ZaeX+gU/LyZRdm8qapoY1ssic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774243; c=relaxed/simple;
	bh=TRuhBxGqdc0XVJo1BRsSpiDjCPjMhqZcQFC4UGdwGVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBQai6yrT6qQbnmgvcQkX756YgGLr3Hv7nBJG5HOBBjptlOsUHXZuTRJpIQe8nH1dVAJ/yI7Zqp8qfJYYWA7mk8yILHQyIaHALO8B32fuJsi1XZpglwU/JW8wa5yrXb+CXWgcYI6Ou5cNCZkaQscLUZvaj718UOvrCW8IuHrAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnY1zHUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7503CC2BBFC;
	Fri,  7 Jun 2024 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774243;
	bh=TRuhBxGqdc0XVJo1BRsSpiDjCPjMhqZcQFC4UGdwGVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnY1zHUXDQ8VpUyD3Gt1BnjoT/Bn6dC5vcy6GoxJbKPgVynq2zfRLa05r2XIPDYbm
	 6uS24YiTyDjYoqCBeohp3ptHfCF7hMIRtDn1rDVzyv8COPYcFO3vgEC5AYQ9EsM99+
	 rdX4HJUne2tgb+Cg50s9Hx45zhvUUyVw/85fQy904xSQsOuui7vDn1LeLNFbF6apqm
	 4tANIQ3EWjW6kd7heM1RLuzgZ/ooi5tylHHXgynvIKa7/VV5c04BZUnYzPUNLpO+h2
	 L3HP2ACCXxwjUGZ9mJ/RYAp3uoVQ5X+AFs8v+nSDvRHPYDiRM51MUHSRthZbPpp5fe
	 ydcAMEZXMpEjA==
Date: Fri, 7 Jun 2024 17:30:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHES][RFC] rework of struct fd handling
Message-ID: <20240607-abhob-gesehen-ed7db9af5eca@brauner>
References: <20240607015656.GX1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607015656.GX1629371@ZenIV>

On Fri, Jun 07, 2024 at 02:56:56AM +0100, Al Viro wrote:
> 	Experimental series trying to sanitize the handling
> of struct fd.  Lightly tested, in serious need of review.
> 
> It's 6.10-rc1-based, lives in 
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.fd
> Individual patches in followups, descriptions below.

Looks overall like a good approach to me and I really like that we're
not renaming struct fd.

(IMHO, you should just send the CLASS(fd_pos) cleanup helper addition
upstream for this cycle because it's the only thing we're missing. And
that'll likely make conversions in individual patches/per subsystem
easier as well.)

> 
> Shortlog:
> Al Viro (19):
>       powerpc: fix a file leak in kvm_vcpu_ioctl_enable_cap()
>       lirc: rc_dev_get_from_fd(): fix file leak
>       introduce fd_file(), convert all accessors to it.
>       struct fd: representation change
>       add struct fd constructors, get rid of __to_fd()
>       net/socket.c: switch to CLASS(fd)
>       introduce struct fderr, convert overlayfs uses to that
>       fdget_raw() users: switch to CLASS(fd_raw, ...)
>       css_set_fork(): switch to CLASS(fd_raw, ...)
>       introduce "fd_pos" class
>       switch simple users of fdget() to CLASS(fd, ...)
>       bpf: switch to CLASS(fd, ...)
>       convert vmsplice() to CLASS(fd, ...)
>       finit_module(): convert to CLASS(fd, ...)
>       timerfd: switch to CLASS(fd, ...)
>       do_mq_notify(): switch to CLASS(fd, ...)
>       simplify xfs_find_handle() a bit
>       convert kernel/events/core.c
>       deal with the last remaing boolean uses of fd_file()
> 
> Diffstat:
>  arch/alpha/kernel/osf_sys.c                |   7 +-
>  arch/arm/kernel/sys_oabi-compat.c          |  18 +-
>  arch/powerpc/kvm/book3s_64_vio.c           |   9 +-
>  arch/powerpc/kvm/powerpc.c                 |  26 +--
>  arch/powerpc/platforms/cell/spu_syscalls.c |  17 +-
>  arch/x86/kernel/cpu/sgx/main.c             |  10 +-
>  arch/x86/kvm/svm/sev.c                     |  43 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  |  27 +--
>  drivers/gpu/drm/drm_syncobj.c              |  11 +-
>  drivers/infiniband/core/ucma.c             |  21 +-
>  drivers/infiniband/core/uverbs_cmd.c       |  12 +-
>  drivers/media/mc/mc-request.c              |  22 +-
>  drivers/media/rc/lirc_dev.c                |  13 +-
>  drivers/vfio/group.c                       |  10 +-
>  drivers/vfio/virqfd.c                      |  20 +-
>  drivers/virt/acrn/irqfd.c                  |  14 +-
>  drivers/xen/privcmd.c                      |  35 ++--
>  fs/btrfs/ioctl.c                           |   7 +-
>  fs/coda/inode.c                            |  13 +-
>  fs/eventfd.c                               |   9 +-
>  fs/eventpoll.c                             |  62 ++----
>  fs/ext4/ioctl.c                            |  23 +-
>  fs/f2fs/file.c                             |  17 +-
>  fs/fcntl.c                                 |  74 +++----
>  fs/fhandle.c                               |   7 +-
>  fs/file.c                                  |  26 +--
>  fs/fsopen.c                                |  23 +-
>  fs/fuse/dev.c                              |  10 +-
>  fs/ioctl.c                                 |  47 ++---
>  fs/kernel_read_file.c                      |  12 +-
>  fs/locks.c                                 |  27 +--
>  fs/namei.c                                 |  19 +-
>  fs/namespace.c                             |  53 ++---
>  fs/notify/fanotify/fanotify_user.c         |  50 ++---
>  fs/notify/inotify/inotify_user.c           |  44 ++--
>  fs/ocfs2/cluster/heartbeat.c               |  17 +-
>  fs/open.c                                  |  67 +++---
>  fs/overlayfs/file.c                        | 187 +++++++----------
>  fs/quota/quota.c                           |  18 +-
>  fs/read_write.c                            | 227 +++++++++-----------
>  fs/readdir.c                               |  38 ++--
>  fs/remap_range.c                           |  11 +-
>  fs/select.c                                |  17 +-
>  fs/signalfd.c                              |  11 +-
>  fs/smb/client/ioctl.c                      |  17 +-
>  fs/splice.c                                |  82 +++-----
>  fs/stat.c                                  |  10 +-
>  fs/statfs.c                                |  12 +-
>  fs/sync.c                                  |  33 ++-
>  fs/timerfd.c                               |  42 ++--
>  fs/utimes.c                                |  11 +-
>  fs/xattr.c                                 |  64 +++---
>  fs/xfs/xfs_exchrange.c                     |  12 +-
>  fs/xfs/xfs_handle.c                        |  16 +-
>  fs/xfs/xfs_ioctl.c                         |  85 +++-----
>  include/linux/bpf.h                        |   9 +-
>  include/linux/cleanup.h                    |   2 +-
>  include/linux/file.h                       |  89 +++++---
>  io_uring/sqpoll.c                          |  31 +--
>  ipc/mqueue.c                               | 126 +++++------
>  kernel/bpf/bpf_inode_storage.c             |  29 +--
>  kernel/bpf/btf.c                           |  13 +-
>  kernel/bpf/map_in_map.c                    |  37 +---
>  kernel/bpf/syscall.c                       | 197 ++++++-----------
>  kernel/bpf/token.c                         |  19 +-
>  kernel/bpf/verifier.c                      |  20 +-
>  kernel/cgroup/cgroup.c                     |  21 +-
>  kernel/events/core.c                       |  67 +++---
>  kernel/module/main.c                       |  15 +-
>  kernel/nsproxy.c                           |  15 +-
>  kernel/pid.c                               |  26 +--
>  kernel/signal.c                            |  33 ++-
>  kernel/sys.c                               |  21 +-
>  kernel/taskstats.c                         |  20 +-
>  kernel/watch_queue.c                       |   8 +-
>  mm/fadvise.c                               |  10 +-
>  mm/filemap.c                               |  19 +-
>  mm/memcontrol.c                            |  37 ++--
>  mm/readahead.c                             |  25 +--
>  net/core/net_namespace.c                   |  14 +-
>  net/core/sock_map.c                        |  23 +-
>  net/socket.c                               | 325 +++++++++++++----------------
>  security/integrity/ima/ima_main.c          |   9 +-
>  security/landlock/syscalls.c               |  57 ++---
>  security/loadpin/loadpin.c                 |  10 +-
>  sound/core/pcm_native.c                    |   6 +-
>  virt/kvm/eventfd.c                         |  19 +-
>  virt/kvm/vfio.c                            |  18 +-
>  88 files changed, 1234 insertions(+), 1951 deletions(-)
> 
> 01/19) powerpc: fix a file leak in kvm_vcpu_ioctl_enable_cap()
> 02/19) lirc: rc_dev_get_from_fd(): fix file leak
> 
> 	First two patches are obvious leak fixes - missing fdput()
> on one a failure exits.
> 
> 03/19) introduce fd_file(), convert all accessors to it.
> 
> 	For any changes of struct fd representation we need to
> turn existing accesses to fields into calls of wrappers.
> Accesses to struct fd::flags are very few (3 in linux/file.h,
> 1 in net/socket.c, 3 in fs/overlayfs/file.c and 3 more in
> explicit initializers).
> 	Those can be dealt with in the commit converting to
> new layout; accesses to struct fd::file are too many for that.
> 	This commit converts (almost) all of f.file to
> fd_file(f).  It's not entirely mechanical ('file' is used as
> a member name more than just in struct fd) and it does not
> even attempt to distinguish the uses in pointer context from
> those in boolean context; the latter will be eventually turned
> into a separate helper (fd_empty()).
> 
> NB: this commit is where I'd expect arseloads of conflicts
> through the cycle, simply because of the breadth of area being
> touched.  The biggest one, as well (500 lines modified).
> Might be worth splitting - not sure.
> 
> 04/19) struct fd: representation change
> 
> 	The absolute majority of instances comes from fdget() and its
> relatives; the underlying primitives actually return a struct file
> reference and a couple of flags encoded into an unsigned long - the lower
> two bits of file address are always zero, so we can stash the flags
> into those.  On the way out we use __to_fd() to unpack that unsigned
> long into struct fd.
> 	Let's use that representation for struct fd itself - make it
> a structure with a single unsigned long member (.word), with the value
> equal either to (unsigned long)p | flags, p being an address of some
> struct file instance, or to 0 for an empty fd.
> 	Note that we never used a struct fd instance with NULL ->file
> and non-zero ->flags; the emptiness had been checked as (!f.file) and
> we expected e.g. fdput(empty) to be a no-op.  With new representation
> we can use (!f.word) for emptiness check; that is enough for compiler
> to figure out that (f.word & FDPUT_FPUT) will be false and that fdput(f)
> will be a no-op in such case.
> 	For now the new predicate (fd_empty(f)) has no users; all the
> existing checks have form (!fd_file(f)).  We will convert to fd_empty()
> use later; here we only define it (and tell the compiler that it's
> unlikely to return true).
> 	This commit only deals with representation change; there will
> be followups.
> 	NOTE: overlayfs part is _not_ in the final form - it will be
> massaged shortly.
> 
> 05/19) add struct fd constructors, get rid of __to_fd()
> 
> 	Make __fdget() et.al. return struct fd directly.
> New helpers: BORROWED_FD(file) and CLONED_FD(file), for
> borrowed and cloned file references resp.
> 	NOTE: this might need tuning; in particular, inline on
> __fget_light() is there to keep the code generation same as
> before - we probably want to keep it inlined in fdget() et.al.
> (especially so in fdget_pos()), but that needs profiling.
> 
> 
> Next two commits deal with the worst irregularities in struct fd use:
> in net/socket.c we have fdget() without matching fdput() - fdget() is
> done in sockfd_lookup_light(), then the results are passed (in modified
> form) to caller, which deals with conditional fput().  And in
> overlayfs we have an almost-but-not-quite struct fd shoehorned into
> struct fd, with ugly calling conventions as the result of that.
> I'm not sure what order would be better for these two commits.
> 
> 06/19) net/socket.c: switch to CLASS(fd)
> 
> 	I strongly suspect that important part in sockfd_lookup_light() is
> avoiding needless file refcount operations, not the marginal reduction of
> the register pressure from not keeping a struct file pointer in the caller.
> 	If that's true, we should get the same benefits from straight
> fdget()/fdput().  And AFAICS with sane use of CLASS(fd) we can get a better
> code generation...
> 	Would be nice if somebody tested it on networking test suites
> (including benchmarks)...
> 
> 	sockfd_lookup_light() does fdget(), uses sock_from_file() to
> get the associated socket and returns the struct socket reference to
> the caller, along with "do we need to fput()" flag.  No matching fdput(),
> the caller does its equivalent manually, using the fact that sock->file
> points to the struct file the socket has come from.
> 	Get rid of that - have the callers do fdget()/fdput() and
> use sock_from_file() directly.  That kills sockfd_lookup_light()
> and fput_light() (no users left).
> 	What's more, we can get rid of explicit fdget()/fdput() by
> switching to CLASS(fd, ...) - code generation does not suffer, since
> now fdput() inserted on "descriptor is not opened" failure exit
> is recognized to be a no-op by compiler.
> 	We could split that commit in two (getting rid of sockd_lookup_light()
> and switch to CLASS(fd, ...)), but AFAICS it ends up being harder to read
> that way.
> 
> 07/19) introduce struct fderr, convert overlayfs uses to that
> 
> Similar to struct fd; unlike struct fd, it can represent
> error values.
> Accessors:
> * fd_empty(f):	true if f represents an error
> * fd_file(f):	just as for struct fd it yields a pointer to
> 		struct file if fd_empty(f) is false.  If
> 		fd_empty(f) is true, fd_file(f) is guaranteed
> 		_not_ to be an address of any object (IS_ERR()
> 		will be true in that case)
> * fd_error(f):	if f represents an error, returns that error,
> 		otherwise the return value is junk.
> Constructors:
> * ERR_FD(-E...):	an instance encoding given error [ERR_FDERR, perhaps?]
> * BORROWED_FDERR(file):	if file points to a struct file instance,
> 			return a struct fderr representing that file
> 			reference with no flags set.
> 			if file is an ERR_PTR(-E...), return a struct
> 			fderr representing that error.
> 			file MUST NOT be NULL.
> * CLONED_FDERR(file):	similar, but in case when file points to
> 			a struct file instance, set FDPUT_FPUT in flags.
> fdput_err() serves as a destructor.
> See fs/overlayfs/file.c for example of use.
> 
> 08/19) fdget_raw() users: switch to CLASS(fd_raw, ...)
> 	all convert trivially
> 09/19) css_set_fork(): switch to CLASS(fd_raw, ...)
> 	reference acquired there by fget_raw() is not stashed anywhere -
> we could as well borrow instead.
> 
> 10/19) introduce "fd_pos" class
> 	fdget_pos() for constructor, fdput_pos() for cleanup, users of
> fd..._pos() converted.
> 
> 11/19) switch simple users of fdget() to CLASS(fd, ...)
> 	low-hanging fruit; that's another likely source of conflicts
> over the cycle and it might make a lot of sense to split; fortunately,
> it can be split pretty much on per-function basis - chunks are independent
> from each other.
> 
> 12/19) bpf: switch to CLASS(fd, ...)
> 	Calling conventions for __bpf_map_get() would be more convenient
> if it left fpdut() on failure to callers.  Makes for simpler logics
> in the callers.
> 	Among other things, the proof of memory safety no longer has to
> rely upon file->private_data never being ERR_PTR(...) for bpffs files.
> Original calling conventions made it impossible for the caller to tell
> whether __bpf_map_get() has returned ERR_PTR(-EINVAL) because it has found
> the file not be a bpf map one (in which case it would've done fdput())
> or because it found that ERR_PTR(-EINVAL) in file->private_data of a
> bpf map file (in which case fdput() would _not_ have been done).
> 	With that calling conventions change it's easy to switch all
> bpffs users to CLASS(fd, ...).
> 
> 13/19) convert vmsplice() to CLASS(fd, ...)
> 	Irregularity here is fdput() not in the same scope as fdget();
> we could just lift it out vmsplice_type() in vmsplice(2), but there's
> no much point keeping vmsplice_type() separate after that...
> 
> 14/19) finit_module(): convert to CLASS(fd, ...)
> 	Slightly unidiomatic emptiness check; just lift it out of
> idempotent_init_module() and into finit_module(2) and that's it.
> 
> 15/19) timerfd: switch to CLASS(fd, ...)
> 	Fold timerfd_fget() into both callers to have fdget() and fdput()
> in the same scope.  Could be done in different ways, but this is probably
> the smallest solution.
> 
> 16/19) do_mq_notify(): switch to CLASS(fd, ...)
> 	a minor twist is the reuse of struct fd instance in there
> 
> 17/19) simplify xfs_find_handle() a bit
> 	XFS_IOC_FD_TO_HANDLE can grab a reference to copied ->f_path and
> let the file go; results in simpler control flow - cleanup is
> the same for both "by descriptor" and "by pathname" cases.
> 	NOTE: grabbing f->f_path to pin file_inode(f) is valid, since
> we are dealing with XFS files here - no reassignments of file_inode().
> 
> 18/19) convert kernel/events/core.c
> 	a questionable trick in perf_event_open(2) - deliberate call of
> fdget(-1), expecting it to yield empty
> 
> 19/19) deal with the last remaing boolean uses of fd_file()
> 	... replacing them with uses of fd_empty()

