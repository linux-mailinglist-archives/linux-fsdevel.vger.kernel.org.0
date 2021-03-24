Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E015346E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 01:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhCXAyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 20:54:51 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:43259 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233600AbhCXAyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 20:54:25 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 5377164032;
        Wed, 24 Mar 2021 11:54:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lOrmv-0061Zh-CW; Wed, 24 Mar 2021 11:54:21 +1100
Date:   Wed, 24 Mar 2021 11:54:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
Message-ID: <20210324005421.GK63242@dread.disaster.area>
References: <20210322171118.446536-1-amir73il@gmail.com>
 <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area>
 <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8
        a=N0d8Qoj7gSbW1E7g6xMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=fCgQI5UlmZDRPDxm0A3o:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:35:46AM +0200, Amir Goldstein wrote:
> On Tue, Mar 23, 2021 at 9:26 AM Dave Chinner <david@fromorbit.com> wrote:
> > On Tue, Mar 23, 2021 at 06:50:44AM +0200, Amir Goldstein wrote:
> > > On Tue, Mar 23, 2021 at 1:03 AM Dave Chinner <david@fromorbit.com> wrote:
> For most use cases, getting a unique fsid that is not "persistent"
> would be fine. Many use case will probably be watching a single
> filesystem and then the value of fsid in the event doesn't matter at all.
> 
> If, however, at some point in the future, someone were to write
> a listener that stores events in a persistent queue for later processing
> it would be more "convenient" if fsid values were "persistent".

Ok, that is what I suspected - that you want to write filehandles to
a userspace database of some sort for later processing and so you
need to also store the filesystem that the filehandle belongs to.

FWIW, that's something XFS started doing a couple of decades ago for
DMAPI based prioprietary HSM implementations. They were build around
a massive userspace database that indexed the contents of the
fileystem via file handles and were kept up to date via
notifications through the DMAPI interface.

> > > > However, changing the uuid on XFS is an offline (unmounted)
> > > > operation, so there will be no fanotify marks present when it is
> > > > changed. Hence when it is remounted, there will be a new f_fsid
> > > > returned in statvfs(), just like what happens now, and all
> > > > applications dependent on "persistent" fsids (and persistent
> > > > filehandles for that matter) will now get ESTALE errors...
> > > >
> > > > And, worse, mp->m_fixed_fsid (and XFS superblock UUIDs in general)
> > > > are not unique if you've got snapshots and they've been mounted via
> > > > "-o nouuid" to avoid XFS's duplicate uuid checking. This is one of
> > > > the reasons that the duplicate checking exists - so that fshandles
> > > > are unique and resolve to a single filesystem....
> > >
> > > Both of the caveats of uuid you mentioned are not a big concern for
> > > fanotify because the nature of f_fsid can be understood by the event
> > > listener before setting the multi-fs watch (i.e. in case of fsid collision).
> >
> > Sorry, I don't understand what "the nature of f_fsid can be
> > understood" means. What meaning are you trying to infer from 8 bytes
> > of opaque data in f_fsid?
> >
> 
> When the program is requested to watch multiple filesystems, it starts by
> querying their fsid. In case of an fsid collision, the program knows that it
> will not be able to tell which filesystem the event originated in, so the
> program can print a descriptive error to the user.

Ok, so it can handle collisions, but it cannot detect things like
two filesystems swapping fsids because device ordering changed at
boot time. i.e. there no way to determine the difference between
f_fsid change vs the same filesystems with stable f_fsid being
mounted in different locations....

> > > Regardless of the fanotify uapi and whether it's good or bad, do you insist
> > > that the value of f_fsid exposed by xfs needs to be the bdev number and
> > > not derived from uuid?
> >
> > I'm not insisting that it needs to be the bdev number. I'm trying to
> > understand why it needs to be changed, what the impact of that
> > change is and whether there are other alternatives before I form an
> > opinion on whether we should make this user visible filesystem
> > identifier change or not...
> >
> > > One thing we could do is in the "-o nouuid" case that you mentioned
> > > we continue to use the bdev number for f_fsid.
> > > Would you like me to make that change?
> >
> > No, I need to you stop rushing around in a hurry to change code and
> > assuming that everyone knows every little detail of fanotify and the
> > problems that need to be solved. Slow down and explain clearly and
> > concisely why f_fsid needs to be persistent, how it gets used to
> > optimise <something> when it is persistent, and what the impact of
> > it not being persistent is.
> >
> 
> Fair enough.
> I'm in a position of disadvantage having no real users to request this change.
> XFS is certainly "not broken", so the argument for "not fixing" it is valid.
> 
> Nevertheless bdev can change on modern systems even without reboot
> for example for loop mounted images, so please consider investing the time
> in forming an opinion about making this change for the sake of making f_fsid
> more meaningful for any caller of statfs(2) not only for fanotify listeners.
> 
> Leaving fanotify out of the picture, the question that the prospect user is
> trying answer is:
> "Is the object at $PATH or at $FD the same object that was observed at
>  'an earlier time'?"
> 
> With XFS, that question can be answered (< 100% certainty)
> using the XFS_IOC_PATH_TO_FSHANDLE interface.

Actually, there's a bit more to it than that. See below.

> name_to_handle_at(2) + statfs(2) is a generic interface that provides
> this answer with less certainty, but it could provide the answer
> with the same certainty for XFS.

Let me see if I get this straight....

Because the VFS filehandle interface does not cater for this by
giving you a fshandle that is persistent, you have to know what path
the filehandle was derived from to be able to open a mountfd for
open_by_handle_at() on the file handle you have stored in userspace.
And that open_by_handle_at() returns an ephemeral mount ID, so the
kernel does not provide what you need to use open_by_handle_at()
immediately.

To turn this ephemeral mount ID into a stable identifier you have to
look up /proc/self/mounts to find the mount point, then statvfs()
the mount point to get the f_fsid.

To use the handle, you then need to open the path to the stored
mount point, check that f_fsid still matches what you originally
looked up, then you can run open_by_handle_at() on the file handle.
If you have an open fd on the filesystem and f_fsid matches, you
have the filesystem pinned until you close the mount fd, and so you
can just sort your queued filehandles by f_fsid and process them all
while you have the mount fd open....

Is that right?

But that still leaves a problem in that the VFS filehandle does not
contain a filesystem identifier itself, so you can never actually
verify that the filehandle belongs to the mount that you opened for
that f_fsid. i.e. The file handle is built by exportfs_encode_fh(),
which filesystems use to encode inode/gen/parent information.
Nothing else is placed in the VFS handle, so the file handle cannot
be used to identify what filesystem it came from.

These seem like a fundamental problems for storing VFS handles
across reboots: identifying the filesystem is not atomic with the
file handle generation and it that identification is not encoded
into the file handle for later verification.

IOWs, if you get the fsid translation wrong, the filehandle will end
up being used on the wrong filesystem and userspace has no way of
knowing that this occurred - it will get ESTALE or data that isn't
what it expected. Either way, it'll look like data corruption to the
application(s). Using f_fsid for this seems fragile to me and has
potential to break in unexpected ways in highly dynamic
environments.

The XFS filehandle exposed by the ioctls, and the NFS filehandle for
that matter, both include an identifier for the filesystem they
belong to in the file handle. This identifier matches the stable
filesystem identifier held by the filesystem (or the NFS export
table), and hence the kernel could resolve whether the filehandle
itself has been directed at the correct filesystem.

The XFS ioctls do not do this fshandle checking - this is something
performed by the libhandle library (part of xfsprogs).  libhandle
knows the format of the XFS filehandles, so it peaks inside them to
extract the fsid to determine where to direct them. 

Applications must first initialise filesystems that file handles can
be used on by calling path_to_fshandle() to populate an open file
cache.  Behind the scenes, this calls XFS_IOC_PATH_TO_FSHANDLE to
associate a {fd, path, fshandle} tuple for that filesystem. The
libhandle operations then match the fsid embedded in the file handle
to the known open fshandles, and if they match it uses the
associated fd to issue the ioctl to the correct filesystem.

This fshandle fd is held open for as long as the application is
running, so it pins the filesystem and so the fshandle obtained at
init time is guaranteed to be valid until the application exits.
Hence on startup an app simply needs to walk the paths it is
interested in and call path_to_fshandle() on all of them, but
otherwise it does not need to know what filesystem a filehandle
belongs to - the libhandle implementation takes care of that
entirely....

IOWs, this whole "find the right filesystem for the file handle"
implementation is largely abstracted away from userspace by
libhandle. Hence just looking at what the the XFS ioctls do does not
give the whole picture of how stable filehandles were actually used
by applications...

I suspect that the right thing to do here is extend the VFS
filehandles to contain an 8 byte fsid prefix (supplied by a new an
export op) and an AT_FSID flag for name_to_handle_at() to return
just the 8 byte fsid that is used by handles on that filesystem.
This provides the filesystems with a well defined API for providing
a stable identifier instead of redefining what filesystems need to
return in some other UAPI.

This also means that userspace can be entirely filesystem agnostic
and it doesn't need to rely on parsing proc files to translate
ephemeral mount IDs to paths, statvfs() and hoping that f_fsid is
stable enough that it doesn't get the destination wrong.  It also
means that fanotify UAPI probably no longer needs to supply a
f_fsid with the filehandle because it is built into the
filehandle....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
