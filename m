Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB369316052
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 08:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhBJHsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 02:48:45 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:39847 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232939AbhBJHrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:47:51 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id D85E01ACE4B;
        Wed, 10 Feb 2021 18:46:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l9kDB-00FMjl-1T; Wed, 10 Feb 2021 18:46:57 +1100
Date:   Wed, 10 Feb 2021 18:46:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Theodore Ts'o <tytso@mit.edu>, jack@suse.com,
        viro@zeniv.linux.org.uk, amir73il@gmail.com, dhowells@redhat.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <20210210074657.GT4626@dread.disaster.area>
References: <87lfcne59g.fsf@collabora.com>
 <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
 <20210208221916.GN4626@dread.disaster.area>
 <20210209173543.GE19070@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209173543.GE19070@quack2.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8
        a=ZfyyHKyGg-6E1BsyQ84A:9 a=BWgsYcyC2udOlYJQ:21 a=IML-LwJYaeEhDV5b:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 06:35:43PM +0100, Jan Kara wrote:
> On Tue 09-02-21 09:19:16, Dave Chinner wrote:
> > On Mon, Feb 08, 2021 at 01:49:41PM -0500, Gabriel Krisman Bertazi wrote:
> > > "Theodore Ts'o" <tytso@mit.edu> writes:
> > For XFS, we want to be able to hook up the verifier error reports
> > to a notification. We want to be able to hook all our corruption
> > reports to a notification. We want to be able to hook all our
> > writeback errors to a notification. We want to be able to hook all
> > our ENOSPC and EDQUOT errors to a notification. And that's just the
> > obvious stuff that notifications are useful for.
> 
> I agree with you here but I'd like to get the usecases spelled out to be
> able to better evaluate the information we need to pass. I can imagine for
> ENOSPC errors this can be stuff like thin provisioning sending red alert to
> sysadmin - this would be fs-wide event. I have somewhat hard time coming up
> with a case where notification of ENOSPC / EDQUOT for a particular file /
> dir would be useful.

An example is containers that the admins configure with project
quotas as directory quotas so that individual containers have their
own independent space accounting and enforcement by the host.  Apps
inside the container to monitor for their own ENOSPC events
(triggered by project quota EDQUOT) instead of the filesystem wide
ENOSPC.

> I can see a usecase where an application wishes to monitor all its files /
> dirs for any type for error fatal error (ENOSPC, EDQUOT, EIO).

*nod*

We also have cluster level management tools wanting to know about
failure events inside data stores that it hads out of containers
and/or guests. That's where things like corruption reports come in -
being able to flag errors at the management interface that something
whent wrong with the filesystem used by container X, with some level
of detail of what actually got damaged (e.g. file X at offset Y for
length Z is bad).

> Here scoping
> makes a lot of sense from application POV. It may be somewhat tricky to
> reliably provide the notification though. If we say spot inconsistency in
> block allocation structure during page writeback (be it btree in XFS case
> or bitmap in ext4 case), we report the error there in the code for that
> structure but that is not necessarily aware of the inode so we need to make
> sure to generate another notification in upper layers where we can associate
> the error with the inode as well.

Yes, that's what we already do in XFS. The initial corruption
detection site generates the corruption warning, and then if higher
layers can't back out because the fs is in an unrecoverable state,
then shutdown and more error messages are generated. There are
multiple levels of warnings/error messages in filesystems, I thought
that was pretty clear to every one so I'm really very surprised that
nobody is thinking that notifications have different scopes, levels
and meanings, just like the message we send to syslog do....

Indeed, once the filesystem is in a global shutdown or error state,
we don't emit further corruption errors, so we wouldn't emit further
error notifications, either.

Essentially, we're not talking about anything new here - this is
already how we use the syslog for corruption and shutdown reporting.
I'm not sure why using a "notification" instead of a "printk()"
seems to make people think this is a unsolvable problem, because we
have already solved it....

> Even worse if we spot some error e.g. during
> journal commit, we (at least in ext4 case) don't have enough information to
> trace back affected inodes anymore.

Failure in the journal is fatal error, and we shut down. That
generates the shutdown notification, and we don't emit anything else
once the shutdown is complete. Further analysis is up to the admin,
not the notification subsystem.

> So how do we handle such cases? Do we
> actively queue error notifications for all inodes? Or do we lazily wait for
> some operation associated with a particular inode to fail to queue
> notification? I can see pros and cons for both...

I'd say that you're vastly over complicating the problem. There is
no point in generating a notification storm from the filesystem once
a fatal error has already been tripped over and the filesystem shut
down.  We don't flood the syslog like this, and we shouldn't flood
the system with unnecessary notifications, either.

This implies that "fatal error" notifications should probably be
broadcast over all "error" watches on that filesystem, regardless of their
scope, because the filesystem is basically saying "everything has
failed". And then no further error notifications are generated,
because everything is already been told "it's broken".

But, really, that's a scoping discussion, not a use case....

> What usecases you had in mind?

Data loss events being reported to userspace so desktop
notifications can be raised. Or management interface notifications
can be raised. Or repair utilities can determine if the problem can
be fixed automatically.

I mean, that's the whole sticking point with DAX+reflink - being
able to reverse map the physical storage to the user data so that
when the storage gets torched by a MCE we can do the right thing.
And part of that "right thing" is notifying the apps and admins that
they data just went up in a cloud of high energy particles...

THen there's stuff that is indicitive of imminent failure.
Notification of transient errors during metadata operations, the
number of retries before success, when we end up with permanently
retrying because the storage is actually toast writes so unmount
will eventually fail, etc.

When there is a filesysetm health status change. Notification that a
filesystem capacity has changed (e.g. grow/shrink). notification
that a filesystem has been frozen. That allocation groups are
running low on space, that we are out of inode space, the reserve
block pool has been depleted, etc.

IOWs, storage management and monitoring is a common case I keep
hearing about. I here more vague requirements from higher level
application stacks (cloudy stuff) that they need stuff like
per-container space management and notifications. But the one thing
that nobody wants to do is scrape and/or parse text messages.

Another class of use case is applications being able to monitor
their files for writeback errors and such notifications containing
the inode, offset and length in them where the failure occurred so
that the actual data loss can be dealt with (e.g. by rewriting the
data) before the application has removed it from it's write buffers.
Right now we have no way to tell the user application where the
writeback error occurred, just that EIO happened -some where- at
-some time in the past- when they next do something with data...

> > If you want an idea of all the different types of metadata objects
> > we need to have different notifications for, look at the GETFSMAP
> > ioctl man page. It lists all the different types of objects we are
> > likely to emit notifications for from XFS (e.g. free space
> > btree corruption at record index X to Y) because, well, that's the
> > sort of information we're already dumping to the kernel log....
> > 
> > Hence from a design perspective, we need to separate the contents of
> > the notification from the mechanism used to configure, filter and
> > emit notifications to userspace.  That is, it doesn't matter if we
> > add a magic new syscall or use fanotify to configure watches and
> > transfer messages to userspace, the contents of the message is going
> > to be the exactly the same, and the API that the filesystem
> > implementations are going to call to emit a notification to
> > userspace is exactly the same.
> > 
> > So a generic message structure looks something like this:
> > 
> > <notification type>		(msg structure type)
> > <notification location>		(encoded file/line info)
> > <object type>			(inode, dir, btree, bmap, block, etc)
> > <object ID>			{bdev, object}
> > <range>				{offset, length} (range in object)
> > <notification version>		(notification data version)
> > <notification data>		(filesystem specific data)
> 
> There's a caveat though that 'object type' is necessarily filesystem
> specific and with new filesystem wanting to support this we'll likely need
> to add more object types. So it is questionable how "generic error parser"
> would be able to use this type of information and whether this doesn't need
> to be in the fs-specific blob.

Well, there are only so many generic types. If we start with the
basic ones such as "regular file" "directory" "user data extent"
and "internal metadata" we cover most bases. That's the reason I
said "filesystem specific diagnostic data can follow the generic
message". This allows the filesystem to say "Fatal internal metadata
error" to userspace and then in it's custom field say "journal write
IO error at block XYZ".

Monitoring tools don't need to know it was a journal error, the
context they react to is "fatal error". Whoever (or whatever) is
tasked with responding to that error can then look at the diagnostic
information supplied with the notification. i.e.:

Severity: fatal
Scope: global
Type: Internal metadata
Object: Journal
Location: <bdev>
Range: <extent>
Error: ENODEV
Diagnostic data: <Write error ENODEV in journal at block XYZ>

A data loss event would indicate that a data extent went bad,
identify it as belonging to inode X at offset Y, length Z. i.e.

Severity: Data Corruption
Scope: inode
Type: User Data
Object: <Extent>
Location: <inode>
Range: <logical offset, length>
Diagnostic data: "writeback failed at inode X, offset Y, len Z due to ENOSPC from bdev"

If the data corruption happens in the inode metadata (e.g. the block
map), the event would be a little different:

Severity: Data Corruption
Scope: inode
Type: Internal Metadata
Object: <Extent>
Location: <inode>
Range: <logical offset, length>
Diagnostic data: "BMBT block at block XYZ failed checksum, cannot read extent records"

So they tell userspace the same thing, but the actual details of the
cause of the data loss over that range of th file are quite
different.

Perhaps an space usage event:

Severity: Information
Scope: Global
Type: Capacity
Total space: X
Available space: Y

Or a directory quota warning:

Severity: Warning
Scope: Project Quota
Type: Low Capacity
Object: <project id>
Total space: X
Available space: Y

IOWs, the notification message header is nothing but a
classification scheme that the notification scoping subsystem uses
for filtering and distribution. If we just stick to the major
objects a filesystem exposes to uses (regular files, directories,
extended attributes, quota, Capacity and internal metadata) and
important events (corruption, errors and emergency actions) then we
cover most of what all filesystems are going to need to tell
userspace.

> Also versioning fs specific blobs with 'notification version' tends to get
> somewhat cumbersome if you need to update the scheme, thus bump the
> version, which breaks all existing parsers (and I won't even speak about
> the percentage of parses that won't bother with checking the version and
> just blindly try to parse whatever they get assuming incorrect things ;).
> We've been there more than once... But this is more of a side remark - once
> other problems are settled I believe we can come up with reasonably
> extensible scheme for blob passing pretty easily.

Yup, I just threw it in there because we need to ensure that the
message protocol format is both extensible and revocable. We will
make mistakes, but we can also ensure we don't have to live with
those mistakes forever.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
