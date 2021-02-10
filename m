Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47181315B48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 01:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhBJAdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 19:33:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235085AbhBJAKQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:10:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BEE464E02;
        Wed, 10 Feb 2021 00:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612915773;
        bh=zENo8bFy9YbvfnV6mY9wxRWqluaqpUG+3BdXcek4EBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFYHLLLhPWanK9XrCSTvNDtSeuU8mhysN4YSi36/R+UgA1lx4I6CiyfTp/rN0yHgY
         eeIDbpK+ql8qfB7KYBiraz/ZGAt6DlpHFQnIKVGil7WzazHCeo+wZ8aylq/bKb2cCd
         /jMrlJMwgpgmLJE9x2Amc00UFnzPbkY7ueQItMldBtAVdXmTZvyrp2cnNTulCdy91Q
         gfOJtDt7zZMahrM9n19NRws5/BUWLZutrtllxv2h1+XH2S+JuQNCon+6pS9DsBwVM7
         oHiFayTcfz5KMGpNJB6Ha4+0stb7fS/du5L50B3u4j3XNGyLJ6OGGKfw6phNOwcnIW
         7sHmClAZuXjtA==
Date:   Tue, 9 Feb 2021 16:09:32 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, jack@suse.com, viro@zeniv.linux.org.uk,
        amir73il@gmail.com, dhowells@redhat.com, david@fromorbit.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <20210210000932.GH7190@magnolia>
References: <87lfcne59g.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfcne59g.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

Sorry that it has taken me nearly three weeks to respond to this; I've
been buried in XFS refactoring for 5.12. :(

I forget if I've ever really laid out the user stories (or whatever)
that I envision for XFS.  I think they're pretty close to what you've
outlined for ext4, downthread discussions notwithstanding. :/

The first usecase is, I think, the common one where a program has an
open file descriptor and wants to know when some kind of error happens
to that open file or its metadata so that it can start application-level
recovery processes.

I think the information exported by struct fanotify_event_error_hdr
corresponds almost exactly to this use case since it only identifies an
error, an inode, and an offset, which are (more or less) general
concepts inside the vfs, and probably could be accomplished without help
from individual filesystems.

I would add a u32 context code so that programs can distinguish between
errors in file data, xattrs, inode metadata, or a general filesystem
error, but otherwise it looks fine to me.  I don't think we need to (or
should) report function names and line numbers here.

(Someone would have to make fanotify work for non-admin processes
though, which if that fails, makes this part less generally useful.)

-----

The second usecase is very filesystem specific and administrative in
nature, and I bet this would be where our paths diverge.  But that's
probably ok, since exposing the details of an event requires a client
that's tightly integrated with the fs implementation details, which
pretty much means a program that we ship in {x,e2,*}fsprogs.

Over the last couple of years, XFS has grown ioctl interfaces for
reporting corruption errors to administrative programs and for xfs_scrub
to initiate checks of metadata structures.  Someday we'll be able to
perform repairs online too.

The metadata corruption reporting interfaces are split into three
categories corresponding to principal fs objects.  In other words, we
can report on the state of file metadata, allocation group metadata, or
full filesystem metadata.  So far, each of these three groups has
sufficiently few types of metadata that we can summarize what's wrong
with a u32 bitmap.

For XFS, the following would suffice for a monitoring daemon that could
become part of xfsprogs:

struct notify_xfs_corruption_error {
	__kernel_fsid_t fsid;

	__u32 group; /* FS, AG, or INODE */
	__u32 sick; /* bitset of XFS_{AG,FSOP,BS}_GEOM_SICK_* */
	union {
		struct {
			__u64 inode;
			__u32 gen;
		};
		__u32 agno;
	};
};

(A real implementation would include a flags field and not have a union
in the middle of it, but this is the bare minimum of what I think I
want for xfs_scrubd having implemented zero of this.)

Upon receipt of this structure, the monitoring daemon can translate
those three fields into calls into the [future] online repair ioctls and
fix the filesystem.  Or it can shut down the fs and kill everything
running on it, I dunno. :)

There would only be one monitoring daemon running for the whole xfs
filesystem, so you could require CAP_SYS_ADMIN and FAN_MARK_MOUNT to
prove that the daemon can get to the actual filesystem root directory.
IOWs, the visibility semantics can be "only the sysadmin and only in the
init namespace" initially.

This structure /could/ include an instruction pointer for more advanced
reporting, but it's not a hard requirement to have such a thing.  As far
as xfs is concerned, something decided the fs was bad, and the only
thing to do now is to recover.  I don't think it matters critically
whether the notices are presented via fanotify or watch_queue.

The tricky problem here is (I think?) how to multiplex different
filesystem types wanting to send corruption reports to userspace.  I
suppose you could define the fs metadata error format as:

	[struct fanotify_event_metadata]
	[optional struct fanotify_event_info_fid]
	[u32 magic code corresponding to statvfs.f_type?]
	[fs-specific blob of data here]

And then you'd use fanotify_event_metadata.event_len to figure out the
length of the fs-specific blob.  That way XFS could export the short
structure I outlined above, and ext4 can emit instruction pointer
addresses or strings or whatever else you and Ted settle on.

If that sounds like "Well you go plumb in the fanotify bits with just
enough information for dispatching and then we'll go write our own xfs
specific thing"... yep. :)

To be clear: I'm advocating for cleaving these two usescases completely
apart, and not mixing them at all like what you defined below, because I
now think these are totally separate use cases.

I don't want to get too far into the implementation details, but FWIW
XFS maintains its health state tracking in the incore data structures,
so it's no problem for us to defer the actual fsnotify calls to a
workqueue if we're in an atomic context.

Ok, now I'll go through this and respond point by point.

On Wed, Jan 20, 2021 at 05:13:15PM -0300, Gabriel Krisman Bertazi wrote:
> 
> My apologies for the long email.
> 
> Please let me know your thoughts.
> 
> 1 Summary
> =========
> 
>   I'm looking for a filesystem-agnostic mechanism to report filesystem
>   errors to a monitoring tool in userspace.  I experimented first with
>   the watch_queue API but decided to move to fanotify for a few reasons.
> 
> 
> 2 Background
> ============
> 
>   I submitted a first set of patches, based on David Howells' original
>   superblock notifications patchset, that I expanded into error
>   reporting and had an example implementation for ext4.  Upstream review
>   has revealed a few design problems:
> 
>   - Including the "function:line" tuple in the notification allows the
>     uniquely identification of the error origin but it also ties the
>     decodification of the error to the source code, i.e. <function:line>
>     is expected to change between releases.
> 
>   - Useful debug data (inode number, block group) have formats specific
>     to the filesystems, and my design wouldn't be expansible to
>     filesystems other than ext4.

Yes, hence proposing one set of generic notifications for most user
programs, and a second interface for fs-specific daemons that we can
ship in ${fs}progs.  My opinions have shifted a bit since the last
posting.

>   - The implementation allowed an error string description (equivalent
>     to what would be thrown in dmesg) that is too short, as it needs to
>     fit in a single notification.
> 
>   - How the user sees the filesystem.  The original patch points to a
>     mountpoint but uses the term superblock.  This is to differentiate
>     from another mechanism in development to watch mounting operations.
> 
>   - Visibility of objects.  A bind mount of a subtree shouldn't receive
>     notifications of objects outside of that bind mount.
> 
> 
> 2.1 Other constraints of the watch_queue API
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   watch_queue is a fairly new framework, which has one upstream user in
>   the keyring subsystem.  watch_queue is designed to submit very short
>   (max of 128 bytes) atomic notifications to userspace in a fast manner
>   through a ring buffer.  There is no current mechanism to link
>   notifications that require more than one slot and such mechanism
>   wouldn't be trivial to implement, since buffer overruns could
>   overwrite the beginning/end of a multi part notification.  In

<nod> This second round of iteration in my head showed me that the two
event notification use cases are divergent enough that the tagged
notification scheme that I think I triggered last time isn't necessary
at all.

>   addition, watch_queue requires an out-of-band overflow notification
>   mechanism, which would need to be implemented aside from the system
>   call, in a separate API.

Yikes.

> 2.2 fanotify vs watch_queue
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   watch_queue is designed for efficiency and fast submission of a large
>   number of notifications.  It doesn't require memory allocation in the
>   submission path, but with a flexibility cost, such as limited
>   notification size.  fanotify is more flexible, allows for larger
>   notifications and better filtering, but requires allocations on the
>   submission path.
> 
>   On the other hand, fanotify already has support for the visibility
>   semantics we are looking for. fsnotify allows an inode to notify only
>   its subtree, mountpoints, or the entire filesystem, depending on the
>   watcher flags, while an equivalent support would need to be written
>   from scratch for watch_queue.  fanotify also has in-band overflow
>   handling, already implemented.  Finally, since fanotify supports much
>   larger notifications, there is no need to link separate notifications,
>   preventing buffer overruns from erasing parts of a notification chain.
> 
>   fanotify is based on fsnotify, and the infrastructure for the
>   visibility semantics is mostly implemented by fsnotify itself.  It
>   would be possible to make error notifications a new mechanism on top
>   of fsnotify, without modifying fanotify, but that would require
>   exposing a very similar interface to userspace, new system calls, and
>   that doesn't seem justifiable since we can extend fanotify syscalls
>   without ABI breakage.

<nod> AFAICT it sounds like fanotify is a good fit for that first
usecase I outlined.  It'd probably work for both.

> 3 Proposal
> ==========
> 
>   The error notification framework is based on fanotify instead of
>   watch_queue.  It is exposed through a new set of marks FAN_ERROR_*,
>   exposed through the fanotify_mark(2) API.
> 
>   fanotify (fsnotify-based) has the infrastructure in-place to link
>   notifications happening at filesystem objects to mountpoints and to
>   filesystems, and already exposes an interface with well defined
>   semantics of how those are exposed to watchers in different
>   mountpoints or different subtrees.
> 
>   A new message format is exposed, if the user passed
>   FAN_REPORT_DETAILED_ERROR fanotify_init(2) flag.  FAN_ERROR messages
>   don't have FID/DFID records.
> 
>   A FAN_REPORT_DETAILED_ERROR record has the same struct
>   fanotify_event_metadata header, but it is followed by one or more
>   additional information record as follows:
> 
>   struct fanotify_event_error_hdr {
>   	struct fanotify_event_info_header hdr;
>   	__u32 error;
>         __u64 inode;
>         __u64 offset;
>   }
> 
>   error is a VFS generic error number that can notify generic conditions
>   like EFSCORRUPT. If hdr.len is larger than sizeof(struct
>   fanotify_event_error_hdr), this structure is followed by an optional
>   filesystem specific record that further specifies the error,
>   originating object and debug data. This record has a generic header:
> 
>   struct fanotify_event_fs_error_hdr {
>   	struct fanotify_event_error_hdr hdr;
>         __kernel_fsid_t fsid;
>         __u32 fs_error;
>   }
> 
>   fs_error is a filesystem specific error record, potentially more
>   detailed than fanotify_event_error.hdr.error . Each type of filesystem

Er... is fs_error supposed to be a type code that tells the program that
the next byte is the start of a fanotify_event_ext4_inode_error
structure?

>   error has its own record type, that is used to report different
>   information useful for each type of error.  For instance, an ext4
>   lookup error, caused by an invalid inode type read from disk, produces
>   the following record:
> 
>   struct fanotify_event_ext4_inode_error {
>   	struct fanotify_event_fs_error_hdr hdr;
>         __u64 block;
>         __u32 inode_type;
>   }
> 
>   The separation between VFS and filesystem-specific error messages has
>   the benefit of always providing some information that an error has
>   occurred, regardless of filesystem-specific support, while allowing

Ok, so I think we've outlined similar-ish proposals.

>   capable filesystems to expose specific internal data to further
>   document the issue.  This scheme leaves to the filesystem to expose
>   more meaningful information as needed.  For instance, multi-disk
>   filesystems can single out the problematic disk, network filesystems
>   can expose a network error while accessing the server.
> 
> 
> 3.1 Visibility semantics
> ~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   Error reporting follows the same semantics of fanotify events.
>   Therefore, a watcher can request to watch the entire filesystem, a
>   single mountpoint or a subtree.
> 
> 
> 3.2 security implications
> ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   fanotify requires CAP_SYS_ADMIN.  My understanding is this requirement
>   suffices for most use cases but, according to fanotify documentation,
>   it could be relaxed without issues for the existing fanotify API.  For
>   instance, watching a subtree could be a allowed for a user who owns
>   that subtree.
> 
> 
> 3.3 error location
> ~~~~~~~~~~~~~~~~~~
> 
>   While exposing the exact line of code that triggered the notification
>   ties that notification to a specific kernel version, it is an
>   important information for those who completely control their
>   environment and kernel builds, such as cloud providers.  Therefore,
>   this proposal includes a mechanism to optionally include in the
>   notification the line of code where the error occurred
> 
>   A watcher who passes the flag FAN_REPORT_ERROR_LOCATION to
>   fanotify_init(2) receives an extra record for FAN_ERROR events:
> 
>   struct fanotify_event_fs_error_location {
>   	struct fanotify_event_info_header hdr;
>         u32 line;
>         char function[];
>   }
> 
>   This record identifies the place where the error occured.  function is
>   a VLA whose size extend to the end of the region delimited by hdr.len.
>   This VLA text-encodes the function name where the error occurred.
> 
> What do you think about his interface?  Would it be acceptable as part
> of fanotify, or should it be a new fsnotify mode?

I would say separate FAN_FILE_ERROR and FAN_FS_ERROR mode bits.

> Regarding semantics, I believe fanotify should solve the visibility
> problem for a subtree watcher not being able to see other branches
> notifications.  Do you think this would suffice?

It sounds like it.  I'll go brave reading the rest of the thread now.

--D

> 
> Thanks,
> 
> -- 
> Gabriel Krisman Bertazi
