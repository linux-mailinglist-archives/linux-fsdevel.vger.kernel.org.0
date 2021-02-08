Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22703142C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBHWUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 17:20:23 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:60940 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229754AbhBHWUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:20:16 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 18AAD82ED4A;
        Tue,  9 Feb 2021 09:19:17 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l9EsG-00DCej-Bc; Tue, 09 Feb 2021 09:19:16 +1100
Date:   Tue, 9 Feb 2021 09:19:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, jack@suse.com,
        viro@zeniv.linux.org.uk, amir73il@gmail.com, dhowells@redhat.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <20210208221916.GN4626@dread.disaster.area>
References: <87lfcne59g.fsf@collabora.com>
 <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnvi8ke2.fsf@collabora.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=qV-HCVVFyzWQJ8xtPesA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 01:49:41PM -0500, Gabriel Krisman Bertazi wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> 
> > On Tue, Feb 02, 2021 at 03:26:35PM -0500, Gabriel Krisman Bertazi wrote:
> >> 
> >> Thanks for the explanation.  That makes sense to me.  For corruptions
> >> where it is impossible to map to a mountpoint, I thought they could be
> >> considered global filesystem errors, being exposed only to someone
> >> watching the entire filesystem (like FAN_MARK_FILESYSTEM).
> >
> > At least for ext4, there are only 3 ext4_error_*() that we could map
> > to a subtree without having to make changes to the call points:
> >
> > % grep -i ext4_error_file\( fs/ext4/*.c  | wc -l
> > 3
> > % grep -i ext4_error_inode\( fs/ext4/*.c  | wc -l
> > 79
> > % grep -i ext4_error\( fs/ext4/*.c  | wc -l
> > 42
> >
> > So in practice, unless we want to make a lot of changes to ext4, most
> > of them will be global file system errors....
> >
> >> But, as you mentioned regarding the google use case, the entire idea of
> >> watching a subtree is a bit beyond the scope of my use-case, and was
> >> only added given the feedback on the previous proposal of this feature.
> >> While nice to have, I don't have the need to watch different mountpoints
> >> for errors, only the entire filesystem.
> >
> > I suspect that for most use cases, the most interesting thing is the
> > first error.  We already record this in the ext4 superblock, because
> > unfortunately, I can't guarantee that system administrators have
> > correctly configured their system logs, so when handling upstream bug
> > reports, I can just ask them to run dumpe2fs -h on the file system:
> >
> > FS Error count:           2
> > First error time:         Tue Feb  2 16:27:42 2021
> > First error function:     ext4_lookup
> > First error line #:       1704
> > First error inode #:      12
> > First error err:          EFSCORRUPTED
> > Last error time:          Tue Feb  2 16:27:59 2021
> > Last error function:      ext4_lookup
> > Last error line #:        1704
> > Last error inode #:       12
> > Last error err:           EFSCORRUPTED
> >
> > So it's not just the Google case.  I'd argue for most system
> > administrator, one of the most useful things is when the file system
> > was first found to be corrupted, so they can try correlating file
> > system corruptions, with, say, reports of I/O errors, or OOM kils,
> > etc.  This can also be useful for correlating the start of file system
> > problems with problems at the application layer --- say, MongoDB,
> > MySQL, etc.
> >
> > The reason why a notification system useful is because if you are
> > using database some kind of high-availability replication system, and
> > if there are problems detected in the file system of the primary MySQL
> > server, you'd want to have the system fail over to the secondary MySQL
> > server.  Sure, you *could* do this by polling the superblock, but
> > that's not the most efficient way to do things.
> 
> Hi Ted,
> 
> I think this closes a full circle back to my original proposal.  It
> doesn't have the complexities of objects other than superblock
> notifications, doesn't require allocations.  I sent an RFC for that a
> while ago [1] which resulted in this discussion and the current
> implementation.

Yup, we're back to "Design for Google/ext4 requirements only", and
ignoring that other filesystems and users also have non-trivial
requirements for userspace error notifications.

> For the sake of a having a proposal and a way to move forward, I'm not
> sure what would be the next step here.  I could revive the previous
> implementation, addressing some issues like avoiding the superblock
> name, the way we refer to blocks and using CAP_SYS_ADMIN.  I think that
> implementation solves the usecase you explained with more simplicity.
> But I'm not sure Darrick and Dave (all in cc) will be convinced by this
> approach of global pipe where we send messages for the entire
> filesystem, as Dave described it in the previous implementation.

Nope, not convinced at all. As a generic interface, it cannot be
designed explicitly for the needs of a single filesystem, especially
when there are other filesystems needing to implement similar
functionality.

As Amir pointed up earlier in the thread, XFS already already has
extensive per-object verification and error reporting facilicities
that we would like to hook up to such a generic error reporting
mechanism. These use generic mechanisms within XFS, and we've
largely standardised the code interally to implement this (e.g. the
xfs_failaddr as a mechanism of efficiently encoding the exact check
that failed out of the hundreds of verification checks we do).

If we've already got largely standardised, efficient mechanisms for
doing all of this in a filesystem, then why would we want to throw
that all away when implementing a generic userspace notification
channel? We know exactly what we need to present with userspace, so
even if other filesystems don't need exactly the same detail of
information, they still need to supply a subset of that same
information to userspace.

The ext4-based proposals keep mentioning dumping text strings and
encoded structures that are ext4 error specific, instead of starting
from a generic notification structure that defines the object in the
filesystem and location within the object that the notification is
for. e.g the {bdev, object, offset, length} object ID tuple I
mention here:

https://lore.kernel.org/linux-ext4/20201210220914.GG4170059@dread.disaster.area/

For XFS, we want to be able to hook up the verifier error reports
to a notification. We want to be able to hook all our corruption
reports to a notification. We want to be able to hook all our
writeback errors to a notification. We want to be able to hook all
our ENOSPC and EDQUOT errors to a notification. And that's just the
obvious stuff that notifications are useful for.

If you want an idea of all the different types of metadata objects
we need to have different notifications for, look at the GETFSMAP
ioctl man page. It lists all the different types of objects we are
likely to emit notifications for from XFS (e.g. free space
btree corruption at record index X to Y) because, well, that's the
sort of information we're already dumping to the kernel log....

Hence from a design perspective, we need to separate the contents of
the notification from the mechanism used to configure, filter and
emit notifications to userspace.  That is, it doesn't matter if we
add a magic new syscall or use fanotify to configure watches and
transfer messages to userspace, the contents of the message is going
to be the exactly the same, and the API that the filesystem
implementations are going to call to emit a notification to
userspace is exactly the same.

So a generic message structure looks something like this:

<notification type>		(msg structure type)
<notification location>		(encoded file/line info)
<object type>			(inode, dir, btree, bmap, block, etc)
<object ID>			{bdev, object}
<range>				{offset, length} (range in object)
<notification version>		(notification data version)
<notification data>		(filesystem specific data)

The first six fields are generic and always needed and defined by
the kernel/user ABI (i.e. fixed forever in time). The notification
data is the custom message information from the filesystem, defined
by the filesystem, and is not covered by kernel ABI requirements
(similar to current dmesg output). That message could be a string,
an encoded structure, etc, but it's opaque to the notification layer
and just gets dumped to userspace in the notification. Generic tools
can parse the generic fields to give basic notification information,
debug/diagnostic tools can turn that fs specific information into
something useful for admins and support engineers.

IOWs, there is nothing that needs to be ext4 or XFS specific in the
notification infrastructure, just enough generic information for
generic tools to be useful, and a custom field for filesystem
specific diagnostic information to be included in the notification.

At this point, we just don't care about where in the filesystem the
notification is generated - the notification infrastructure assigns
the errors according to the scope the filesystem maps the object
type to. e.g. if fanotify is the userspace ABI, then global metadata
corruptions go to FA_MARK_FILESYSTEM watchers but not FA_MARK_MOUNT.
The individual operations that get an -EFSCORRUPTED error emits a
notification to FA_MARK_INODE watchers on that inode. And so on.

If a new syscall is added, then it also needs to be able to scope
error notifications like this because we would really like to have
per-directory and per-inode notifications supported if at all
possible. But that is a separate discussion to the message contents
and API filesystems will use to create notifications on demand...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
