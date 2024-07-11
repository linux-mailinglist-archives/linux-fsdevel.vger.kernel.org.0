Return-Path: <linux-fsdevel+bounces-23591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E846C92EF5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 21:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997AB2836B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CB916EBFC;
	Thu, 11 Jul 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thMYX9Sc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5748288B5;
	Thu, 11 Jul 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725160; cv=none; b=TWis4xAqneRqgCvygfDX+ZSM42MCqVNUULS2MObutAzEvUKiGcObW1rSs0I5CA52PmQASeeHvIc0u3ypIqyfxotmtI2Car7NjQqRALCUIF+jdZZYli7fwxyyrXhKdA202vp+kMVor29hu7wDqkKwI8jPVVEZyemIxbjgGvQyrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725160; c=relaxed/simple;
	bh=f79aMT31G+Ladq5Y5IfX7kG5UX38505CTWzlDx7OFOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hze4koYiHzkwG+cTEN2xv6XhgBpTkEWQXuJkcYvTwKlgcFToUgO+mDj+Rt+Bxr8OdX5cEmIGVAiXPg0eaDsJXugxZ8IO6X4CRnqozDnoGLA3lAcO7/8dp2GszW5ePiGWb1njYFYN0dXZcBsXKjDNXFZIgzMfsfKsVzP7wPKaFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thMYX9Sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D65C116B1;
	Thu, 11 Jul 2024 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720725160;
	bh=f79aMT31G+Ladq5Y5IfX7kG5UX38505CTWzlDx7OFOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thMYX9ScLkPKicmopXpO7DygDDuXYmppMj0eSPlM2QSEsXddTvwUFcu77vpQKfkb2
	 IDZLLeSjje+vUizSCqrrtECNXREQuFPHalvlh11WNavlCgjH997Y4DrihAejuQEfRU
	 /8lfggF1vIWoxtrJKnW+4Av4BAaIwPGDssPuk6bhkqY4wt9DJbQj4xefGcK3sx/0rk
	 btrGeglbfsscbFrMSDcgInY4QfzX72692GsW2EPynNI4Rkrt1ONPVbR2td/Ksu9mFo
	 edCln4xR4G49OOYgxQ9euB5jlScgvK2DH0a1FBBbYzI1WkS74Gh+IeloREQJIGuS5I
	 zlbPAZ2/d58Xg==
Date: Thu, 11 Jul 2024 12:12:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 5/9] Documentation: add a new file documenting
 multigrain timestamps
Message-ID: <20240711191239.GR612460@frogsfrogsfrogs>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
 <20240711-mgtime-v5-5-37bb5b465feb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-mgtime-v5-5-37bb5b465feb@kernel.org>

On Thu, Jul 11, 2024 at 07:08:09AM -0400, Jeff Layton wrote:
> Add a high-level document that describes how multigrain timestamps work,
> rationale for them, and some info about implementation and tradeoffs.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/multigrain-ts.rst | 120 ++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
> new file mode 100644
> index 000000000000..5cefc204ecec
> --- /dev/null
> +++ b/Documentation/filesystems/multigrain-ts.rst
> @@ -0,0 +1,120 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Multigrain Timestamps
> +=====================
> +
> +Introduction
> +============
> +Historically, the kernel has always used coarse time values to stamp
> +inodes. This value is updated on every jiffy, so any change that happens
> +within that jiffy will end up with the same timestamp.
> +
> +When the kernel goes to stamp an inode (due to a read or write), it first gets
> +the current time and then compares it to the existing timestamp(s) to see
> +whether anything will change. If nothing changed, then it can avoid updating
> +the inode's metadata.
> +
> +Coarse timestamps are therefore good from a performance standpoint, since they
> +reduce the need for metadata updates, but bad from the standpoint of
> +determining whether anything has changed, since a lot of things can happen in a
> +jiffy.
> +
> +They are particularly troublesome with NFSv3, where unchanging timestamps can
> +make it difficult to tell whether to invalidate caches. NFSv4 provides a
> +dedicated change attribute that should always show a visible change, but not
> +all filesystems implement this properly, causing the NFS server to substitute
> +the ctime in many cases.
> +
> +Multigrain timestamps aim to remedy this by selectively using fine-grained
> +timestamps when a file has had its timestamps queried recently, and the current
> +coarse-grained time does not cause a change.
> +
> +Inode Timestamps
> +================
> +There are currently 3 timestamps in the inode that are updated to the current
> +wallclock time on different activity:
> +
> +ctime:
> +  The inode change time. This is stamped with the current time whenever
> +  the inode's metadata is changed. Note that this value is not settable
> +  from userland.
> +
> +mtime:
> +  The inode modification time. This is stamped with the current time
> +  any time a file's contents change.
> +
> +atime:
> +  The inode access time. This is stamped whenever an inode's contents are
> +  read. Widely considered to be a terrible mistake. Usually avoided with
> +  options like noatime or relatime.

And for btime/crtime (aka creation time) a filesystem can take the
coarse timestamp, right?  It's not settable by userspace, and I think
statx is the only way those are ever exposed.  QUERIED is never set when
the file is being created.

> +Updating the mtime always implies a change to the ctime, but updating the
> +atime due to a read request does not.
> +
> +Multigrain timestamps are only tracked for the ctime and the mtime. atimes are
> +not affected and always use the coarse-grained value (subject to the floor).

Is it ok if an atime update uses the same timespec as was used for a
ctime update?  There's a pending update for 6.11 that changes
xfs_trans_ichgtime to do:

	tv = current_time(inode);

	if (flags & XFS_ICHGTIME_MOD)
		inode_set_mtime_to_ts(inode, tv);
	if (flags & XFS_ICHGTIME_CHG)
		inode_set_ctime_to_ts(inode, tv);
	if (flags & XFS_ICHGTIME_ACCESS)
		inode_set_atime_to_ts(inode, tv);
	if (flags & XFS_ICHGTIME_CREATE)
		ip->i_crtime = tv;

So I guess xfs could do something like this to set @tv:

	if (flags & XFS_ICHGTIME_CHG)
		tv = inode_set_ctime_current(inode);
	else
		tv = current_time();
...
	if (flags & XFS_ICHGTIME_ACCESS)
		inode_set_atime_to_ts(inode, tv);

Thoughts?

> +Inode Timestamp Ordering
> +========================
> +
> +In addition to just providing info about changes to individual files, file
> +timestamps also serve an important purpose in applications like "make". These
> +programs measure timestamps in order to determine whether source files might be
> +newer than cached objects.
> +
> +Userland applications like make can only determine ordering based on
> +operational boundaries. For a syscall those are the syscall entry and exit
> +points. For io_uring or nfsd operations, that's the request submission and
> +response. In the case of concurrent operations, userland can make no
> +determination about the order in which things will occur.
> +
> +For instance, if a single thread modifies one file, and then another file in
> +sequence, the second file must show an equal or later mtime than the first. The
> +same is true if two threads are issuing similar operations that do not overlap
> +in time.
> +
> +If however, two threads have racing syscalls that overlap in time, then there
> +is no such guarantee, and the second file may appear to have been modified
> +before, after or at the same time as the first, regardless of which one was
> +submitted first.
> +
> +Multigrain Timestamps
> +=====================
> +Multigrain timestamps are aimed at ensuring that changes to a single file are
> +always recognizable, without violating the ordering guarantees when multiple
> +different files are modified. This affects the mtime and the ctime, but the
> +atime will always use coarse-grained timestamps.
> +
> +It uses an unused bit in the i_ctime_nsec field to indicate whether the mtime
> +or ctime has been queried. If either or both have, then the kernel takes
> +special care to ensure the next timestamp update will display a visible change.
> +This ensures tight cache coherency for use-cases like NFS, without sacrificing
> +the benefits of reduced metadata updates when files aren't being watched.
> +
> +The Ctime Floor Value
> +=====================
> +It's not sufficient to simply use fine or coarse-grained timestamps based on
> +whether the mtime or ctime has been queried. A file could get a fine grained
> +timestamp, and then a second file modified later could get a coarse-grained one
> +that appears earlier than the first, which would break the kernel's timestamp
> +ordering guarantees.
> +
> +To mitigate this problem, we maintain a global floor value that ensures that
> +this can't happen. The two files in the above example may appear to have been
> +modified at the same time in such a case, but they will never show the reverse
> +order. To avoid problems with realtime clock jumps, the floor is managed as a
> +monotonic ktime_t, and the values are converted to realtime clock values as
> +needed.

monotonic atomic64_t?

--D

> +
> +Implementation Notes
> +====================
> +Multigrain timestamps are intended for use by local filesystems that get
> +ctime values from the local clock. This is in contrast to network filesystems
> +and the like that just mirror timestamp values from a server.
> +
> +For most filesystems, it's sufficient to just set the FS_MGTIME flag in the
> +fstype->fs_flags in order to opt-in, providing the ctime is only ever set via
> +inode_set_ctime_current(). If the filesystem has a ->getattr routine that
> +doesn't call generic_fillattr, then you should have it call fill_mg_cmtime to
> +fill those values.
> 
> -- 
> 2.45.2
> 
> 

