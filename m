Return-Path: <linux-fsdevel+bounces-23709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D47931A77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFEF282BFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B328174E;
	Mon, 15 Jul 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwcYoPp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE019168BD;
	Mon, 15 Jul 2024 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069126; cv=none; b=Gd78qW0VqHGDH65Phpaevc6kYo1gjm4twQakyAt/Ywq6FShEOaba0Yp7h3sq4tovom/9OFj5WGR0TYdIwVvqlVtNI2b7FnZL1/xZe1b6Pu6UfSQI667MrZZGIiXs9okCcGyMvMOD56NV9zaakLZGjIp2qidLHMIK9mdza8A4YXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069126; c=relaxed/simple;
	bh=8i85EK+gun0FN88fLvRAutodiK0/jDE/37q/V70/Pv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj4xN4diUR0wH2n17S7LTHcvhxhLi7aAHj+fXM5Pzv6yXls/HHJOuMJEPMgYXDyupl5tbfmS/PIJ/KkdLmfa8a4v8GrFhH4XVwb+Qb3UgQJIQFLqqdhudMTp3F2pEH763AGdrkAQuUCxgCluWeMraQZqZ3TugHuNkAxdsAgNB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwcYoPp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6415FC32782;
	Mon, 15 Jul 2024 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721069125;
	bh=8i85EK+gun0FN88fLvRAutodiK0/jDE/37q/V70/Pv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwcYoPp90SKY3geCcPte/wJb5BvKK6+t9hh52olaxt9tSVCJ6+QlAWsy62f8rTaXP
	 jvFfGgbFNrlGOtUboDVaekPwTGHdqWF1742BCWlGRbXftvB10vgWr1OTALTt/Y+3o/
	 GVhRfxhEnpub7A3ffJv7LFyjdR2KCYV9BderbU1vU886yill98T5786iejine+86dg
	 i6xfD/8ypI/kHDq3zxCaenM0+EnGguKtAbs/wdPvUqnfOTAjBJcD96WvzwvK+Te3BV
	 Aob4uT1rGyRMfLL8XH9XbFvK44Lt8PLhHPDEtnbtElA1xYcArHYGQWUnwB9fdY7HsN
	 ke2qnFL+UYZBA==
Date: Mon, 15 Jul 2024 11:45:24 -0700
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
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 5/9] Documentation: add a new file documenting
 multigrain timestamps
Message-ID: <20240715184524.GE103014@frogsfrogsfrogs>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-5-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-5-48e5d34bd2ba@kernel.org>

On Mon, Jul 15, 2024 at 08:48:56AM -0400, Jeff Layton wrote:
> Add a high-level document that describes how multigrain timestamps work,
> rationale for them, and some info about implementation and tradeoffs.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Seems fine to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
> +
> +Updating the mtime always implies a change to the ctime, but updating the
> +atime due to a read request does not.
> +
> +Multigrain timestamps are only tracked for the ctime and the mtime. atimes are
> +not affected and always use the coarse-grained value (subject to the floor).
> +
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

