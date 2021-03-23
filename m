Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0273458A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 08:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCWH0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 03:26:54 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:50209 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhCWH01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:26:27 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 121A478BFCE;
        Tue, 23 Mar 2021 18:26:09 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lObQV-005kQN-Nh; Tue, 23 Mar 2021 18:26:07 +1100
Date:   Tue, 23 Mar 2021 18:26:07 +1100
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
Message-ID: <20210323072607.GF63242@dread.disaster.area>
References: <20210322171118.446536-1-amir73il@gmail.com>
 <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8 a=pGLkceISAAAA:8
        a=qPVhv03ko5a3r7EVbR0A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=iDYLZJqqcMiNGDj8:21 a=CxZJzayQX-zNgOXB:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 06:50:44AM +0200, Amir Goldstein wrote:
> On Tue, Mar 23, 2021 at 1:03 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Mar 22, 2021 at 07:11:18PM +0200, Amir Goldstein wrote:
> > > Some filesystems on persistent storage backend use a digest of the
> > > filesystem's persistent uuid as the value for f_fsid returned by
> > > statfs(2).
> > >
> > > xfs, as many other filesystem provide the non-persistent block device
> > > number as the value of f_fsid.
> > >
> > > Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
> > > for identifying objects using file_handle and f_fsid in events.
> >
> > The filesystem id is encoded into the VFS filehandle - it does not
> > need some special external identifier to identify the filesystem it
> > belongs to....
> >
> 
> Let's take it from the start.
> There is no requirement for fanotify to get a persistent fs id, we just need
> a unique fs id that is known to userspace, so the statfs API is good enough
> for our needs.

So why change the code then? If it ain't broke, don't fix it...

> See quote from fanotify.7:
> 
> " The fields of the fanotify_event_info_fid structure are as follows:
> ...
>        fsid   This  is  a  unique identifier of the filesystem
> containing the object associated with the event.  It is a structure of
> type __kernel_fsid_t and contains the same value as f_fsid when
>               calling statfs(2).
> 
>        file_handle
>               This is a variable length structure of type struct
> file_handle.  It is an opaque handle that corresponds to a specified
> object on a filesystem as returned by name_to_handle_at(2).  It
>               can  be  used  to uniquely identify a file on a
> filesystem and can be passed as an argument to open_by_handle_at(2).
> ..."
> 
> So the main objective is to "uniquely identify an object" which was observed
> before (i.e. at the time of setting a watch) and a secondary objective is to
> resolve a path from the identifier, which requires extra privileges.
> 
> This definition does not specify the lifetime of the identifier and
> indeed, in most
> cases, uniqueness in the system while filesystem is mounted should suffice
> as that is also the lifetime of the fanotify mark.
> 
> But the fanotify group can outlive the mounted filesystem and it can be used
> to watch multiple filesystems. It's not really a problem per-se that
> xfs filesystems
> can change and reuse f_fsid, it is just less friendly that's all.
> 
> I am trying to understand your objection to making this "friendly" change.

"friendly" isn't a useful way to describe whether a change is
desirable of whether code works correctly or not. If it's broken or
not fit for purpose, it doesn't matter how "friendly" it might be -
it's still broken...

I'm asking why using a device encoding is a problem, because
it will not change across mount/unmount cycles as the backing device
doesn't change. It *may* change across reboots, but then what does
fanotify care about in that case? Something has to re-establish all
watches from scratch at that point, so who cares if the fsid has
changed?

So what problem is "persistence" across reboots solving?  You say
it's "friendly" but that has no technical definition I know of....

> > i.e. it's use is entirely isolated to
> > the file handle interface for identifying the filesystem the handle
> > belongs to. This is messy, but XFS inherited this "fixed fsid"
> > interface from Irix filehandles and was needed to port
> > xfsdump/xfsrestore to Linux.  Realistically, it is not functionality
> > that should be duplicated/exposed more widely on Linux...
> 
> Other filesystems expose a uuid digest as f_fsid: ext4, btrfs, ocfs2
> and many more. XFS is really the exception among the big local fs.
> This is not exposing anything new at all.

I'm not suggesting that it is. I'm asking you to explain what the
problem it solves is so I have the context necessary to evaluate the
impact of making such a userspace visible change might be....

> I would say it is more similar to the way that the generation part of
> the file handle has improved over the years in different filesystems
> to provide better uniqueness guarantees.

No, it's most definitely not. Userspace never sees the inode
generation number.  The inode generation can only be changed when an
inode goes through a life cycle. If you change it in the middle of a
referenced inode's life, then you invalidate valid file handles
(i.e.  ESTALE) for no good reason. But we can change the way we
modify the generation number when the inode cycle out of existence
without any impact on external APIs because the change of generation
number is necessary to invalidate the filehandle in that case.

So the way we have changed generation number selection over time
does not impact the actual users of file handles - they still only
get ESTALE when the inode is unlinked and is no longer accessible
and nobody even notices that we changed generation number selection
algorithms.

> > The export-derived "filesystem ID" is what should be exported to
> > userspace in combination with the file handle to identify the fs the
> > handle belongs to because then you have consistent behaviour and a
> > change that invalidates the filehandle will also invalidate the
> > fshandle....
> >
> 
> nfsd has a much stronger persistent file handles requirement than
> fanotify. There is no need to make things more complicated than
> they need to be.

Userspace filehandles have exactly the same persistence requirements
as NFS file handles. fanotify might not have the same requirements
as NFS, but that doesn't change the persistence requirements
for userspace handles....

> > However, changing the uuid on XFS is an offline (unmounted)
> > operation, so there will be no fanotify marks present when it is
> > changed. Hence when it is remounted, there will be a new f_fsid
> > returned in statvfs(), just like what happens now, and all
> > applications dependent on "persistent" fsids (and persistent
> > filehandles for that matter) will now get ESTALE errors...
> >
> > And, worse, mp->m_fixed_fsid (and XFS superblock UUIDs in general)
> > are not unique if you've got snapshots and they've been mounted via
> > "-o nouuid" to avoid XFS's duplicate uuid checking. This is one of
> > the reasons that the duplicate checking exists - so that fshandles
> > are unique and resolve to a single filesystem....
> 
> Both of the caveats of uuid you mentioned are not a big concern for
> fanotify because the nature of f_fsid can be understood by the event
> listener before setting the multi-fs watch (i.e. in case of fsid collision).

Sorry, I don't understand what "the nature of f_fsid can be
understood" means. What meaning are you trying to infer from 8 bytes
of opaque data in f_fsid?

> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Guys,
> > >
> > > This change would be useful for fanotify users.
> > > Do you see any problems with that minor change of uapi?
> >
> > Yes.
> >
> > IMO, we shouldn't be making a syscall interface rely on the
> > undefined, filesystem specific behaviour a value some other syscall
> > exposes to userspace. This means the fsid has no defined or
> > standardised behaviour applications can rely on and can't be
> > guaranteed unique and unchanging by fanotify. This seems like a
> > lose-lose situation for everyone...
> >
> 
> The fanotify uapi guarantee is to provide the same value of f_fsid
> observed by statfs() uapi. The statfs() uapi guarantee about f_fsid is
> a bit vague, but it's good enough for our needs:
> 
> "...The  general idea is that f_fsid contains some random stuff such that the
>  pair (f_fsid,ino) uniquely determines a file.  Some operating systems use
>  (a variation on) the device number, or the device number combined with the
>  filesystem type..."

Mixed messaging!

You start by saying "f_fsid needs persistence", then say "it doesn't
need persistence, then say "device number based f_fsid is
sub-optimal", then saying "the statfs() defined f_fsid is good
enough" despite the fact is says "(a variation on) the device
number" is a documented way of implementing it and you've said that
is sub-optimal.

I''ve got no clue what fanotify wants or needs from f_fsid now.

> Regardless of the fanotify uapi and whether it's good or bad, do you insist
> that the value of f_fsid exposed by xfs needs to be the bdev number and
> not derived from uuid?

I'm not insisting that it needs to be the bdev number. I'm trying to
understand why it needs to be changed, what the impact of that
change is and whether there are other alternatives before I form an
opinion on whether we should make this user visible filesystem
identifier change or not...

> One thing we could do is in the "-o nouuid" case that you mentioned
> we continue to use the bdev number for f_fsid.
> Would you like me to make that change?

No, I need to you stop rushing around in a hurry to change code and
assuming that everyone knows every little detail of fanotify and the
problems that need to be solved. Slow down and explain clearly and
concisely why f_fsid needs to be persistent, how it gets used to
optimise <something> when it is persistent, and what the impact of
it not being persistent is.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
