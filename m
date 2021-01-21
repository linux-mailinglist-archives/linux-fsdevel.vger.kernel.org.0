Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08FB2FE923
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 12:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbhAULp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 06:45:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbhAULpk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:45:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3243ABDA;
        Thu, 21 Jan 2021 11:44:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 753D31E07FD; Thu, 21 Jan 2021 12:44:53 +0100 (CET)
Date:   Thu, 21 Jan 2021 12:44:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, jack@suse.com, viro@zeniv.linux.org.uk,
        amir73il@gmail.com, dhowells@redhat.com, david@fromorbit.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <20210121114453.GD24063@quack2.suse.cz>
References: <87lfcne59g.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfcne59g.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Gabriel,

On Wed 20-01-21 17:13:15, Gabriel Krisman Bertazi wrote:
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
> 
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
>   addition, watch_queue requires an out-of-band overflow notification
>   mechanism, which would need to be implemented aside from the system
>   call, in a separate API.
> 
> 
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

I agree fanotify could be used for propagating the error information from
kernel to userspace. But before we go to design how exactly the events
should look like, I'd like to hear a usecase (or usecases) for this
feature. Because the intended use very much determines which information we
need to propagate to userspace and what flexibility we need there.
 
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

So this depends on the use case. I can imagine that we could introduce new
event type FAN_FS_ERROR (like we currently have FAN_MODIFY, FAN_ACCESS,
FAN_CREATE, ...). This event type would be generated when error happens on
fs object - we can generate it associated with struct file, struct dentry,
or only superblock, depending on what information is available at the place
where fs spots the error. Similarly to how we generate other fsnotify
events. But here's the usecase question - is there really need for fine
granularity of error reporting (i.e., someone watching errors only on a
particular file, or directory)?

FAN_FS_ERROR could be supported in all types of fanotify notification
groups (although I'm not sure supporting normal fanotify mode really makes
sense for errors since that requires opening the file where error occurs
which is likely to fail anyway) and depending on other FAN_REPORT_ flags in
the notification group we'd generate appropriate information the
notification event (like FID, DFID, name, ...)

Then we can have FAN_REPORT_DETAILED_ERROR which would add to event more
information about the error like you write below - although identification
of the inode / fsid is IMO redundant - you can get all that information
(and more) from FID / DFID event info entries if you want it.

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
>   capable filesystems to expose specific internal data to further
>   document the issue.  This scheme leaves to the filesystem to expose
>   more meaningful information as needed.  For instance, multi-disk
>   filesystems can single out the problematic disk, network filesystems
>   can expose a network error while accessing the server.

And here I suspect we are already overengineering it and I'd really like to
see the usecases that warrant all the extensible information. Not just "it
might be useful for somebody" kind of thing but really concrete examples.
Adding new info is easy, removing it is impossible so we have to be really
careful when adding it... Also I'm opposed to having fs-dependent event
information. It will either get used and then we'll experience an explosion
of "this peculiar filesystem needs this additional bit of information" and
thus of configuration options, or it will fade into obsurity with only
few filesystems / tools using it and then we have mostly pointless
maintenance burden.

> 3.2 security implications
> ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   fanotify requires CAP_SYS_ADMIN.  My understanding is this requirement
>   suffices for most use cases but, according to fanotify documentation,
>   it could be relaxed without issues for the existing fanotify API.  For
>   instance, watching a subtree could be a allowed for a user who owns
>   that subtree.

Note that both 'subtree' watches and 'unpriviledged' watches are not yet
supported by fanotify. And it's uncertain in which form they'll get merged.
I don't think your proposal really relies on them so everything is fine but
I'd like to set the expectations properly.

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

Again, here I'd be interested in the usecases. We can always implement
things without this feature and later add it when there are real users
with clear requirements...

> What do you think about his interface?  Would it be acceptable as part
> of fanotify, or should it be a new fsnotify mode?

I think expanding fanotify makes more sense.

> Regarding semantics, I believe fanotify should solve the visibility
> problem for a subtree watcher not being able to see other branches
> notifications.  Do you think this would suffice?

Currently fanotify requires CAP_SYS_ADMIN as you noted above so visibility
is non-issue (only a possible performance hurdle due to too many events if
anything). If we add support to fanotify for less priviledged watchers,
then yes, we'll have to solve visibility for other types of events anyway,
error reporting is not special in that regard...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
