Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD2D349C8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 23:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhCYWxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 18:53:45 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44213 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230341AbhCYWxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:53:20 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B1E1810423D5;
        Fri, 26 Mar 2021 09:53:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lPYqf-006koK-9E; Fri, 26 Mar 2021 09:53:05 +1100
Date:   Fri, 26 Mar 2021 09:53:05 +1100
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
Message-ID: <20210325225305.GM63242@dread.disaster.area>
References: <20210322171118.446536-1-amir73il@gmail.com>
 <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area>
 <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
 <20210324005421.GK63242@dread.disaster.area>
 <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8
        a=7db4axj67mjesEHiGaIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=fCgQI5UlmZDRPDxm0A3o:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:53:25AM +0200, Amir Goldstein wrote:
> On Wed, Mar 24, 2021 at 2:54 AM Dave Chinner <david@fromorbit.com> wrote:
> > On Tue, Mar 23, 2021 at 11:35:46AM +0200, Amir Goldstein wrote:
> > > On Tue, Mar 23, 2021 at 9:26 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Tue, Mar 23, 2021 at 06:50:44AM +0200, Amir Goldstein wrote:
> > > Leaving fanotify out of the picture, the question that the prospect user is
> > > trying answer is:
> > > "Is the object at $PATH or at $FD the same object that was observed at
> > >  'an earlier time'?"
> > >
> > > With XFS, that question can be answered (< 100% certainty)
> > > using the XFS_IOC_PATH_TO_FSHANDLE interface.
> >
> > Actually, there's a bit more to it than that. See below.
> >
> > > name_to_handle_at(2) + statfs(2) is a generic interface that provides
> > > this answer with less certainty, but it could provide the answer
> > > with the same certainty for XFS.
> >
> > Let me see if I get this straight....
> >
> > Because the VFS filehandle interface does not cater for this by
> > giving you a fshandle that is persistent, you have to know what path
> > the filehandle was derived from to be able to open a mountfd for
> > open_by_handle_at() on the file handle you have stored in userspace.
> 
> That is what NFS and DMAPI need, but this is not what I asked for.
> I specifically asked for the ability to answer the question:
> "Is the object at $PATH or at $FD the same object that was observed at
>  'an earlier time'?"

Define "at an earlier time". Once it means "across system reboots"
then the problem scope becomes a lot larger...

> Note that as opposed to open_by_handle_at(), which requires
> capabilities, checking the identity of the object does not require any
> capabilities beyond search/read access permissions to the object.

How do you check the identity of a file handle without a filesystem
identifier in it? having an external f_fsid isn't really sufficient
- you need to query the filesytem for it's identifier and determine
if the file handle contains that same identifier...

> Furthermore, with name_to_handle_at(fd, ..., AT_EMPTY_PATH)
> and fstatfs() there are none of the races you mention below and
> fanotify obviously captures a valid {fsid,fhandle} tuple.

Except that fsid is not guaranteed to be the same across mounts, let
alone reboots. There is no guarantee of uniqueness, either. IOWs, in
the bigger picture, f_fsid isn't something that can provide a
guaranteed answer to your "is $obj the same as it was at $TIME"...

You can't even infer a path from the fsid, even if it is unique, The
fsid doesn't tell you what *mount point* it refers to. i.e in
the present of bind mounts, there can be multiple disjoint directory
heirachies that correspond to the same fsid...

> > And that open_by_handle_at() returns an ephemeral mount ID, so the
> > kernel does not provide what you need to use open_by_handle_at()
> > immediately.
> >
> > To turn this ephemeral mount ID into a stable identifier you have to
> > look up /proc/self/mounts to find the mount point, then statvfs()
> > the mount point to get the f_fsid.
> >
> > To use the handle, you then need to open the path to the stored
> > mount point, check that f_fsid still matches what you originally
> > looked up, then you can run open_by_handle_at() on the file handle.
> > If you have an open fd on the filesystem and f_fsid matches, you
> > have the filesystem pinned until you close the mount fd, and so you
> > can just sort your queued filehandles by f_fsid and process them all
> > while you have the mount fd open....
> >
> > Is that right?
> 
> It's not wrong, but it's irrelevant to the requirement, which was to
> *identify* the object, not to *access* the object.
> See more below...
> 
> >
> > But that still leaves a problem in that the VFS filehandle does not
> > contain a filesystem identifier itself, so you can never actually
> > verify that the filehandle belongs to the mount that you opened for
> > that f_fsid. i.e. The file handle is built by exportfs_encode_fh(),
> > which filesystems use to encode inode/gen/parent information.
> > Nothing else is placed in the VFS handle, so the file handle cannot
> > be used to identify what filesystem it came from.
> >
> > These seem like a fundamental problems for storing VFS handles
> > across reboots: identifying the filesystem is not atomic with the
> > file handle generation and it that identification is not encoded
> > into the file handle for later verification.
> >
> > IOWs, if you get the fsid translation wrong, the filehandle will end
> > up being used on the wrong filesystem and userspace has no way of
> > knowing that this occurred - it will get ESTALE or data that isn't
> > what it expected. Either way, it'll look like data corruption to the
> > application(s). Using f_fsid for this seems fragile to me and has
> > potential to break in unexpected ways in highly dynamic
> > environments.
> >
> 
> The potential damage sounds bad when you put it this way, but in fact
> it really depends on the use case. For the use case of NFS client it's true
> you MUST NOT get the wrong object when resolving file handles.
> 
> With fanotify, this is not the case.
> When a listener gets an event with an object identifier, the listener cannot
> infer the path of that object.
> 
> If the listener has several objects open (e.g. tail -f A B C) then when getting
> an event, the identifier can be used to match the open file with certainty
> (having verified no collisions of identifiers after opening the files).

Sorry, you've lost me. How on do you reliably match a {fsid, fhandle}
to an open file descriptor? You've got to have more information
available than just a fd, fsid and a fhandle...

> If the listener is watching multiple directories (e.g. inotifywatch --recursive)
> then the listener has two options:
> 1. Keep open fds for all watches dirs - this is what inotify_add_watch()
>     does internally (not fds per-se but keeping an elevated i_count)
> 2. Keep fid->path map for all watches dirs and accept the fact that the
>     cached path information may be stale
> 
> The 2nd option is valid for applications that use the events as hints
> to take action. An indexer application, for example, doesn't care if
> it will scan a directory where there were no changes as long as it will
> get the correct hint eventually.
>
> So if an indexer application were to act on FAN_MOVE events by
> scanning the entire subtree under the parent dir where an entry was
> renamed, the index will be eventually consistent, regardless of all
> the events on objects with stale path cache that may have been
> received after the rename.

Sure, but you don't need a file handle for this. you can just scan
the directory heirachy any time you get a notification for that
fsid. Even if you have multiple directory heirarchies that you
are watching on a given mount.

I'm -guessing- that you are using the filehandle to differentiate
between different watched heirarchies, and you do that by taking a
name_to_handle_at() snapshot of the path when the watch is set, yes?

AFAICT, the application cannot  care about whether it loses
events across reboot because the indexer already needs to scan after
boot to so that it is coherent with whatever state the filesystem is
in after recovery.

> > The XFS filehandle exposed by the ioctls, and the NFS filehandle for
> > that matter, both include an identifier for the filesystem they
> > belong to in the file handle. This identifier matches the stable
> > filesystem identifier held by the filesystem (or the NFS export
> > table), and hence the kernel could resolve whether the filehandle
> > itself has been directed at the correct filesystem.
> >
> > The XFS ioctls do not do this fshandle checking - this is something
> > performed by the libhandle library (part of xfsprogs).  libhandle
> > knows the format of the XFS filehandles, so it peaks inside them to
> > extract the fsid to determine where to direct them.
> >
> > Applications must first initialise filesystems that file handles can
> > be used on by calling path_to_fshandle() to populate an open file
> > cache.  Behind the scenes, this calls XFS_IOC_PATH_TO_FSHANDLE to
> > associate a {fd, path, fshandle} tuple for that filesystem. The
> > libhandle operations then match the fsid embedded in the file handle
> > to the known open fshandles, and if they match it uses the
> > associated fd to issue the ioctl to the correct filesystem.
> >
> > This fshandle fd is held open for as long as the application is
> > running, so it pins the filesystem and so the fshandle obtained at
> > init time is guaranteed to be valid until the application exits.
> > Hence on startup an app simply needs to walk the paths it is
> > interested in and call path_to_fshandle() on all of them, but
> > otherwise it does not need to know what filesystem a filehandle
> > belongs to - the libhandle implementation takes care of that
> > entirely....
> >
> > IOWs, this whole "find the right filesystem for the file handle"
> > implementation is largely abstracted away from userspace by
> > libhandle. Hence just looking at what the the XFS ioctls do does not
> > give the whole picture of how stable filehandles were actually used
> > by applications...
> >
> > I suspect that the right thing to do here is extend the VFS
> > filehandles to contain an 8 byte fsid prefix (supplied by a new an
> > export op) and an AT_FSID flag for name_to_handle_at() to return
> > just the 8 byte fsid that is used by handles on that filesystem.
> > This provides the filesystems with a well defined API for providing
> > a stable identifier instead of redefining what filesystems need to
> > return in some other UAPI.
> >
> > This also means that userspace can be entirely filesystem agnostic
> > and it doesn't need to rely on parsing proc files to translate
> > ephemeral mount IDs to paths, statvfs() and hoping that f_fsid is
> > stable enough that it doesn't get the destination wrong.  It also
> > means that fanotify UAPI probably no longer needs to supply a
> > f_fsid with the filehandle because it is built into the
> > filehandle....
> >
> 
> That is one option. Let's call it the "bullet proof" option.

"Reliable". "Provides well defined behaviour". "Guarantees".

> Another option, let's call it the "pragmatic" options, is that you accept
> that my patch shouldn't break anything and agree to apply it.

"shouldn't break anything" is the problem. You can assert all you
want that nothing will break, but history tells us that even the
most benign UAPI changes can break unexpected stuff in unexpected
ways.

That's the fundamental problem. We *know* that what you are trying
to do with filehandles and fsid has -explicit, well known- issues.
What we have here is a new interface that
is .... problematic, and now it needs to redefine other parts
of the UAPI to make "problems" with the new interface go away.

Yes, we really suck at APIs, but that doesn't mean hacking a UAPI
around to work around problems in another UAPI is the right answer.

> In that case, a future indexer (or whatever) application author can use
> fanotify, name_to_handle_at() and fstats() as is and document that after
> mount cycle, the indexer may get confused and miss changes in obscure
> filesystems that nobody uses on desktops and servers.

But anyone wanting to use this for a HSM style application that
needs a guarantee that the filehandle can be resolved to the correct
filesystem for open_by_handle_at() is SOL?

IOWs, this proposal is not really fixing the underlying problem,
it's just kicking the can down the road.

> The third option, let's call it the "sad" option, is that we do nothing
> and said future indexer application author will need to find ways to
> work around this deficiency or document that after mount cycle, the
> indexer may get confused and miss changes in commonly used
> desktop and server filesystems (i.e. XFS).

Which it already needs to do, because there are many, many
filesysetms out there that have f_fsid that change on every mount.

> <side bar>
> I think that what indexer author would really want is not "persistent fsid"
> but rather a "persistent change journal" [1].
> I have not abandoned this effort and I have a POC [2] for a new fsnotify
> backend (not fanotify) based on inputs that also you provided in LSFMM.
> In this POC, which is temporarily reusing the code of overlayfs index,
> the persistent identifier of an object is {s_uuid,fhandle}.
> </side bar>

Yup, that's pretty much what HSMs on top of DMAPI did. But then the
app developers realised that they can still miss events, especially
when the system crashes. Not to mention that the filesystem may not
actually replay all the changes it reports to userspace during
journal recovery because it is using asynchronous journalling and so
much of the pending in memory change was lost, even though change
events were reported to userspace....

Hence doing stuff like "fanotify intents" doesn't actually solve any
"missing event" problems - it just creates more complex coherency
problems because you cannot co-ordinate "intent done" events with
filesystem journal completion points sanely. The fanotify journal
needs to change state atomically with the filesystem journal state,
and that's not really something that can be done by a layer above
the filesystem....

Hence the introduction of the bulkstat interface in XFS for fast,
efficient scanning of all the inodes in the filesystem for changes.
The HSMs -always- scanned the filesystems after an unclean mount
(i.e. not having a registered unmount event recorded in the
userspace application event database) because the filesystem and the
userspace database state are never in sync after a crash event.

And, well, because userspace applications can crash and/or have bugs
that lose events, these HSMs would also do periodic scans to
determine if it had missed anything. When you are indexing hundreds
of millions of files and many petabytes of storage across disk and
tape (this was the typical scale of DMAPI installations in the mid
2000s), you care about proactively catching that one event that was
missed because of a transient memory allocation event under heavy
production load....

> Would you be willing to accept the "pragmatic" option?

It doesn't really seem "pragmatic" to me. It looks "convenient" for
fanotify to redefine what f_fsid means, but I'm not convinced that
we should be changing another UAPI to paper over a sub-optimal UAPI
in relatively new and largely unused fanotify functionality....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
