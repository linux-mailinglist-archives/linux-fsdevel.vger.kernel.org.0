Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5F2DDC90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 02:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgLRBHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 20:07:35 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:34849 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729123AbgLRBHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 20:07:35 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 68B2958FE29;
        Fri, 18 Dec 2020 12:06:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kq4EH-0055xX-Rv; Fri, 18 Dec 2020 12:06:45 +1100
Date:   Fri, 18 Dec 2020 12:06:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 4/8] vfs: Add superblock notifications
Message-ID: <20201218010645.GA1199812@dread.disaster.area>
References: <20201208003117.342047-1-krisman@collabora.com>
 <20201208003117.342047-5-krisman@collabora.com>
 <20201210220914.GG4170059@dread.disaster.area>
 <87ft4cukor.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft4cukor.fsf@collabora.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=20KFwNOVAAAA:8 a=bIklqNNcAAAA:8
        a=7-415B0cAAAA:8 a=BAjqJaPzbBLsPg9D8GYA:9 a=9gaeUh4213YzDVK8:21
        a=21pc6Q3nKQSEouU-:21 a=CjuIK1q_8ugA:10 a=EkVPmbJYC8N8lJNKmfU-:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 05:55:32PM -0300, Gabriel Krisman Bertazi wrote:
> 
> 
> Dave,
> 
> Thanks a lot for the very detailed review.
> 
> > On Mon, Dec 07, 2020 at 09:31:13PM -0300, Gabriel Krisman Bertazi wrote:
> >> From: David Howells <dhowells@redhat.com>
> >> 
> >> Add a superblock event notification facility whereby notifications about
> >> superblock events, such as I/O errors (EIO), quota limits being hit
> >> (EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
> >> process asynchronously.  Note that this does not cover vfsmount topology
> >> changes.  watch_mount() is used for that.
> >
> > watch_mount() is not in the upstream tree, nor is it defined in this
> > patch set.
> 
> 
> That is my mistake, not the author's.  I picked this from a longer series that has
> a watch_mount implementation, but didn't include it.  Only the commit message
> is bad, not the patch absence.
> 
> >> Records are of the following format:
> >> 
> >> 	struct superblock_notification {
> >> 		struct watch_notification watch;
> >> 		__u64	sb_id;
> >> 	} *n;
> >> 
> >> Where:
> >> 
> >> 	n->watch.type will be WATCH_TYPE_SB_NOTIFY.
> >> 
> >> 	n->watch.subtype will indicate the type of event, such as
> >> 	NOTIFY_SUPERBLOCK_READONLY.
> >> 
> >> 	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
> >> 	record.
> >> 
> >> 	n->watch.info & WATCH_INFO_ID will be the fifth argument to
> >> 	watch_sb(), shifted.
> >> 
> >> 	n->watch.info & NOTIFY_SUPERBLOCK_IS_NOW_RO will be used for
> >> 	NOTIFY_SUPERBLOCK_READONLY, being set if the superblock becomes
> >> 	R/O, and being cleared otherwise.
> >> 
> >> 	n->sb_id will be the ID of the superblock, as can be retrieved with
> >> 	the fsinfo() syscall, as part of the fsinfo_sb_notifications
> >> 	attribute in the watch_id field.
> >> 
> >> Note that it is permissible for event records to be of variable length -
> >> or, at least, the length may be dependent on the subtype.  Note also that
> >> the queue can be shared between multiple notifications of various types.
> >
> > /me puts on his "We really, really, REALLY suck at APIs" hat.
> >
> > This adds a new syscall that has a complex structure associated with
> > in. This needs a full man page specification written for it
> > describing the parameters, the protocol structures, behaviour, etc
> > before we can really review this. It really also needs full test
> > infrastructure for every aspect of the syscall written from the man
> > page (not the implementation) for fstests so that we end up with a
> > consistent implementation for every filesystem that implements these
> > watches.
> 
> I see.  I was thinking the other way around, getting a design accepted
> by you all before writing down documentation, but that makes a lot of
> sense. In fact, I'm taking a step back and writing a text proposal,
> without patches, such that we can agree on the main points before I
> start coding.
> 
> > Other things:
> >
> > - Scoping: inode/block related information is not "superblock"
> >   information. What about errors in non-inode related objects?
> 
> The previous RFC separated inode error notifications from other types,
> but my idea was to have different notifications types for each object.
> 
> 
> > - offets into files/devices/objects need to be in bytes, not blocks
> > - errors can span multiple contiguous blocks, so the notification
> >   needs to report the -byte range- the error corresponds to.
> > - superblocks can have multiple block devices under them with
> >   individual address ranges. Hence we need {object,dev,offset,len}
> >   to uniquely identify where an error occurred in a filesystem.
> > - userspace face structures need padding and flags/version/size
> >   information so we can tell what shape the structure being passed
> >   is. It is guaranteed that we will want to expand the structure
> >   definitions in future, maybe even deprecate some...
> > - syscall has no flags field.
> > - syscall is of "at" type (relative path via dfd) so probably shoudl
> >   be called "watch..._at()"
> 
> will do all the above.
> 
> >
> > Fundamentally, though, I'm struggling to understand what the
> > difference between watch_mount() and watch_sb() is going to be.
> > "superblock" watches seem like the wrong abstraction for a path
> > based watch interface. Superblocks can be shared across multiple
> > disjoint paths, subvolumes and even filesystems.
> 
> As far as I understand the original patchset, watch_mount was designed
> to monitor mountpoint operations (mount, umount,.. ) in a sub-tree,
> while watch_sb monitors filesystem operations and errors.  I'm not
> working with watch_mount, my current interest is in having a
> notifications mechanism for filesystem errors, which seemed to fit
> nicely with the watch_sb patchset for watch_queue.

<shrug>

The previous patches are not part of your proposal, and if they are
not likely to be merged, then we don't really care what they are
or what they did. The only thing that matters here is what your
patchset is trying to implement and whether that is appropriate or
not...

> > The path based user API is really asking to watch a mount, not a
> > superblock. We don't otherwise expose superblocks to userspace at
> > all, so this seems like the API is somewhat exposing internal kernel
> > implementation behind mounts. However, there -is- a watch_mount()
> > syscall floating around somewhere, so it makes me wonder exactly why
> > we need a second syscall and interface protocol to expose
> > essentially the same path-based watch information to userspace.
> 
> I think these are indeed different syscalls, but maybe a bit misnamed.
> 
> If not by path, how could we uniquely identify an entire filesystem?

Exactly why do we need to uniquely identify a filesystem based on
it's superblock? Surely it's already been identified by path by the
application that registered the watch?

> Maybe pointing to a block device that has a valid filesystem and in the
> case of fs spawning through multiple devices, consider all of them?  But
> that would not work for some misc filesystems, like tmpfs.

It can't be block device based at all - think NFS, CIFS, etc. We
can't use UUIDs, because not all filesystem have them, and snapshots
often have identical UUIDs.

Really, I think "superblock" notifications are extremely problematic
because the same superblock can be shared across different security
contexts. I'm not sure what the solution might be, but I really
don't like the idea of a mechanism that can report errors in objects
outside the visibility of a namespaced container to that container
just because it has access to some path inside a much bigger
filesystem that is mostly out of bounds to that container.

> > Without having that syscall the same patchset, or a reference to
> > that patchset (and man page documenting the interface), I have no
> > idea what it does or why it is different or why it can't be used for
> > these error notifications....
> 
> As a short summary, My goal is an error reporting mechanism for ext4
> (preferably that can also be used by other filesystems)

There's no "preferably" here. Either it is generic and usable by all
other filesystems, or it's not functionality that should be merged
into the VFS or exposed by a syscall.

> that allows a
> userspace application to monitor errors on the filesystem without losing
> information and without having to parse a convoluted dmesg.  The
> watch_queue API seem to expose exactly the infrastructure for this kind
> of thing.  As I said, I'm gonna send a proposal with more details
> because, I'd really like to have something that can be used by several
> filesystems.

Yes, I know what the desired functionality is, it's just that it's
not as simple as "redirect global error messages to global pipe"
such as what we do with printk and dmesg...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
