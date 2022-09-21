Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77F55E56B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 01:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIUX1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 19:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIUX1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:27:34 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20020A2229
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 16:27:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2AC428AA2FE;
        Thu, 22 Sep 2022 09:27:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ob97p-00AZv9-Tq; Thu, 22 Sep 2022 09:27:29 +1000
Date:   Thu, 22 Sep 2022 09:27:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20220921232729.GE3144495@dread.disaster.area>
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=632b9de4
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=rWvmsOj6DGqUwbSOZ4gA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 11, 2022 at 09:12:06PM +0300, Amir Goldstein wrote:
> Hi Jan,
> 
> I wanted to consult with you about preliminary design thoughts
> for implementing a hierarchical storage manager (HSM)
> with fanotify.
> 
> I have been in contact with some developers in the past
> who were interested in using fanotify to implement HSM
> (to replace old DMAPI implementation).
> 
> Basically, FAN_OPEN_PERM + FAN_MARK_FILESYSTEM
> should be enough to implement a basic HSM, but it is not
> sufficient for implementing more advanced HSM features.

Ah, I wondered where the people with that DMAPI application went all
those years ago after I told them they should look into using
fanotify to replace the dependency they had on the DMAPI patched
XFS that SGI maintained for years for SLES kernels...

> Some of the HSM feature that I would like are:
> - blocking hook before access to file range and fill that range
> - blocking hook before lookup of child and optionally create child

Ok, so these are to replace the DMAPI hooks that provided a blocking
userspace upcall to the HSM to allow it fetch data from offline
teirs that wasn't currently in the filesystem itself. i.e. the inode
currently has a hole over that range of data, but before the read
can proceed the HSM needs to retreive the data from the remote
storage and write it into the local filesystem.

I think that you've missed a bunch of blocking notifications that
are needed, though. e.g. truncate needs to block while the HSM
records the file ranges it is storing offline are now freed.
fallocate() needs to block while it waits for the HSM to tell it the
ranges of the file that actually contain data and so should need to
be taken into account. (e.g. ZERO_RANGE needs to wait for offline
data to be invalidated, COLLAPSE_RANGE needs offline data to be
recalled just like a read() operation, etc).

IOWs, any operation that manipulates the extent map or the data in
the file needs a blocking upcall to the HSM so that it can restore
and invalidate the offline data across the range of the operation
that is about to be performed....

> My thoughts on the UAPI were:
> - Allow new combination of FAN_CLASS_PRE_CONTENT
>   and FAN_REPORT_FID/DFID_NAME
> - This combination does not allow any of the existing events
>   in mask
> - It Allows only new events such as FAN_PRE_ACCESS
>   FAN_PRE_MODIFY and FAN_PRE_LOOKUP
> - FAN_PRE_ACCESS and FAN_PRE_MODIFY can have
>   optional file range info
> - All the FAN_PRE_ events are called outside vfs locks and
>   specifically before sb_writers lock as in my fsnotify_pre_modify [1]
>   POC
> 
> That last part is important because the HSM daemon will
> need to make modifications to the accessed file/directory
> before allowing the operation to proceed.

Yes, and that was the biggest problem with DMAPI - the locking
involved. DMAPI operations have to block without holding any locks
that the IO path, truncate, fallocate, etc might need, but once they
are unblocked they need to regain those locks to allow the operation
to proceed. This was by far the ugliest part of the DMAPI patches,
and ultimately, the reason why it was never merged.

> Naturally that opens the possibility for new userspace
> deadlocks. Nothing that is not already possible with permission
> event, but maybe deadlocks that are more inviting to trip over.
> 
> I am not sure if we need to do anything about this, but we
> could make it easier to ignore events from the HSM daemon
> itself if we want to, to make the userspace implementation easier.

XFS used "invisible IO" as the mechanism for avoiding sending DMAPI
events for operations that we initiated by the HSM to move data into
and out of the filesystem.

No doubt you've heard us talk about invisible IO in the past -
O_NOCMTIME is what that invisible IO has eventually turned into in a
modern Linux kernel. We still use that for invisible IO - xfs_fsr
uses it for moving data around during online defragmentation. The
entire purpose of invisible IO was to provide a path for HSMs and
userspace bulk data movers (e.g. HSM aware backup tools like
xfsdump) to do IO without generating unnecessary or recursive DMAPI
events....

IOWs, if we want a DMAPI replacement, we will need to formalise a
method of performing syscall based operations that will not trigger
HSM notification events.

The other thing that XFS had for DMAPI was persistent storage in the
inode of the event mask that inode should report events for. See
the di_dmevmask and di_dmstate fields defined in the on-disk inode
format here:

https://git.kernel.org/pub/scm/fs/xfs/xfs-documentation.git/tree/design/XFS_Filesystem_Structure/ondisk_inode.asciidoc

There's no detail for them, but the event mask indicated what DMAPI
events the inode should issue notifications for, and the state field
held information about DMAPI operations in progress.

The event field is the important one here - if the event field was
empty, access to the inode never generated DMAPI events. When the
HSM moved data offline, the "READ" event mask bit was set by the HSM
and that triggered DMAPI events for any operation that needed to
read data or manipulate the extent map. When the data was brought
entirely back online, the event masks count be cleared.

However, DMAPI also supports dual state operation, where the
data in the local filesystem is also duplicated in the offline
storage (e.g. immediately after a recall operation). This state can
persist until data or layout is changed in the local filesystem,
and so there's a "WRITE" event mask as well that allows the
filesystem to inform the HSM that data it may have in offline
storage is being changed.

The state field is there to tell the HSM that an operation was in
progress when the system crashed. As part of recovery, the HSM needs
to find all the inodes that had DM operations in progress and either
complete them or revert them to bring everything back to a
consistent state. THe SGI HSMs used the bulkstat interfaces to scan
the fs and find inodes that had a non-zero DM state field. This is
one of the reasons that having bulkstat scale out to scanning
millions of inodes a second ends up being important - coherency
checking between the ondisk filesystem state and the userspace
offline data tracking databases is a very important admin
operation..

The XFS dmapi event and state mask control APIs are now deprecated.
The XFS_IOC_FSSETDM ioctl could read and write the values, and the
the XFS V1 bulkstat ioctl could read them. There were also flags for
things like extent mapping ioctls (FIEMAP equivalent) that ensured
looking at the extent map didn't trigger DMAPI events and data
recall.

I guess what I'm trying to say is that there's a lot more to an
efficient implementation of a HSM event notification mechanism than
just implementing a couple of blocking upcalls. IF we want something
that will replace even simple DMAPI-based HSM use cases, we really
need to think through how to support all the operations that a
recall operation might needed for and hence have to block. ANd we
really should think about how to efficiently filter out unnecessary
events so that we don't drown the HSM in IO events it just doesn't
need to know about....

> Another thing that might be good to do is provide an administrative
> interface to iterate and abort pending fanotify permission/pre-content
> events.

That was generally something the DMAPI event consumer provided.

> You must have noticed the overlap between my old persistent
> change tracking journal and this design. The referenced branch
> is from that old POC.
> 
> I do believe that the use cases somewhat overlap and that the
> same building blocks could be used to implement a persistent
> change journal in userspace as you suggested back then.

That's a very different use case and set of requirements to a HSM.

A HSM tracks much, much larger amounts of data than a persistent
change journal. We had [C]XFS-DMAPI based HSMs running SLES in
production that tracked half a billion inodes and > 10PB of data 15
years ago. These days I'd expect "exabyte" to be the unit of
storage that large HSMs are storing.

> Thoughts?

I think that if the goal is to support HSMs with fanotify, we first
need to think about how we efficiently support all the functionality
HSMs require rather than just focus on a blocking fanotify read
operation. We don't need to implement everything, but at least
having a plan for things like handling the event filtering
requirements without the HSM having to walk the entire filesystem
and inject per-inode event filters after every mount would be a real
good idea....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
