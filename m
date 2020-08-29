Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6D2568FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgH2QH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgH2QHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 12:07:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455F2C061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c6jw6hOkzbgakloCPa1BH/0xrcSnaGmlIlVCUEeB6pA=; b=rW/wIl6dTrGuFaJhCTQREiKIK0
        SFa6xCaEwQoGCVHtoZPlGmvcxBchYa2e53M1VhWEXRaV/Ld/0nPiZHlVhHEW48RQvDrACllGU4sdB
        TrixAUbyNxd1yl4GhQrd9FGMSc3ZWhYW/emAEMP2axMVqoXc12kU26BSUN14IRetVt/jBI+oWGNEy
        8LtPuybrQEcTV32/jrL3dTDE5lMLEyPDzo8Lq35AAI92TDmc1b7A7qrMAT+Rvt3usYq389+1aRbVY
        IpwGuNM2P9G/6VDdVCPxAbPaHPverE2GE5JAYR0kqEVbG4FwFN0K4zEF5Y3okeEVVo2T9eHbTxAUy
        KQYVEFbA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC3Nt-0007OK-QD; Sat, 29 Aug 2020 16:07:17 +0000
Date:   Sat, 29 Aug 2020 17:07:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200829160717.GS14765@casper.infradead.org>
References: <20200728105503.GE2699@work-vm>
 <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827222457.GB12096@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 08:24:57AM +1000, Dave Chinner wrote:
> On Thu, Aug 27, 2020 at 04:22:07PM +0100, Matthew Wilcox wrote:
> > On Mon, Aug 17, 2020 at 10:29:30AM +1000, Dave Chinner wrote:
> > > To implement ADS, we'd likely consider adding a new physical inode
> > > "ADS fork" which, internally, maps to a separate directory
> > > structure. This provides us with the ADS namespace for each inode
> > > and a mechanism that instantiates a physical inode per ADS. IOWs,
> > > each ADS can be referenced by the VFS natively and independently as
> > > an inode (native "file as a directory" semantics). Hence existing
> > > create/unlink APIs work for managing ADS, readdir() can list all
> > > your ADS, you can keep per ADS xattrs, etc....
> > > 
> > > IOWs, with a filesystem inode fork implementation like this for ADS,
> > > all we really need is for the VFS to pass a magic command to
> > > ->lookup() to tell us to use the ADS namespace attached to the inode
> > > rather than use the primary inode type/state to perform the
> > > operation.
> > > 
> > > Hence all the ADS support infrastructure is essentially dentry cache
> > > infrastructure allowing a dentry to be both a file and directory,
> > > and providing the pathname resolution that recognises an ADS
> > > redirection. Name that however you want - we've got to do an on-disk
> > > format change to support ADS, so we can tell the VFS we support ADS
> > > or not. And we have no cares about existing names in the filesystem
> > > conflicting with the ADS pathname identifier because it's a mkfs
> > > time decision. Given that special flags are needed for the openat()
> > > call to resolve an ADS (e.g. O_ALT), we know if we should parse the
> > > ADS identifier as an ADS the moment it is seen...
> > 
> > I think this is equivalent to saying "Linux will never support ADS".
> > Al has some choice words on having the dentry cache support objects which
> > are both files and directories.  You run into some "fun" locking issues.
> > And there's lots of things you just don't want to permit, like mounting
> > a new filesystem on top of some ADS, or chrooting a process into an ADS,
> > or renaming an ADS into a different file.
> 
> I know all this. My point is that the behaviour required by ADS
> objects is that of a seekable data file. That requires a struct file
> that points at a struct inode, page cache mapping, etc to all work
> as they currently do. It also means that how ADS are managed and
> presented to userspace is entirely a VFS construct. Indeed,
> everything you mention above is functionality controlled/implemented
> by the VFS via the dentry cache...

I agree with you that supporting named streams within a file requires
an independent inode for each stream.  I disagree with you that this is
dentry cache infrastructure.  I do not believe in giving each stream
its own dentry.  Either they share the default stream's dentry, or they
have no dentry (mild preference for no dentry).

> > I think what would satisfy people is allowing actual "alternate data
> > streams" to exist in files.  You always start out by opening a file,
> > then the presentation layer is a syscall that lets you enumerate the
> > data streams available for this file, and another syscall that returns
> > an fd for one of those streams.
> 
> You could do this with a getdents_at() syscall that has an AT_ALT
> flag or something like that. i.e. iterate the streams on the inode
> (whether it be a regular file or a directory!) and report them as
> dirents to userspace. Userspace can then openat2(fd, name, O_ALT)
> and there is your user API.

Maybe.  getdents is a little overkill; these things don't have inode
numbers (at least not ones which are meaningful to userspace), or
d_type.  I might be tempted by just read() on an fd like v7 unix.

> The VFS can deal with openat2(fd, stream_name, O_ALT) however it
> wants - it doesn't need the dentry cache pathwalk here - just vector
> straight to the filesystem's ->lookup mechanism on the inode
> attached to the "dirfd" passed in. 
>
> AFAICT, the dentry cache only needs to be involved if we want to
> -cache- the ADS namespace. I don't think we need to cache the ADS
> namespace as long as the inode is cached by the filesystem - just
> let the fs and let it do an inode cache lookup and instantiation for
> ADS inodes (eg as XFS already does for internal inode accesses
> during bulkstat, quotacheck, etc). We don't cache the xattr
> namespaces in the VFS - the filesystem is responsible for doing that
> if required - so I don't think this would be a problem for ADS
> access...
> 
> The fact that ADS inodes would not be in the dentry cache and hence
> not visible to pathwalks at all then means that all of the issues
> such as mounting over them, chroot, etc don't exist in the first
> place...

Wait, you've now switched from "this is dentry cache infrastructure"
to "it should not be in the dentry cache".  So I don't understand what
you're arguing for.

> > As long as nobody gets the bright idea to be able to link that fd into
> > the directory structure somewhere, this should avoid any problems with
> > unwanted things being done to an ADS.  Chunks of your implementation
> > described above should be fine for this.
> 
> I can see the need for rename and linkat linking O_TMPFILE fd's into
> ADS names, though. e.g. to be able to do safe overwrites of ADS
> data.

I don't have a problem with being able to create unnamed streams and
then atomically linking them into their containing file.

> From a fs management POV, we'll also want to be able to do things
> like defrag ADS inodes, which means we'll need to be able to do
> atomic inode operations (e.g. swap extents) between O_TMPFILE inodes
> and ADS inodes, etc. So in addition to the VFS interfaces, there's a
> bunch of filesystem admin stuff that will need to be made ADS aware,
> and it's likely there will be fs specific ioctls that need to be
> modifed/added to manipulate ADS inodes directly...

Yes, probably.

> > For the benefit of shell scripts, I think an argument to 'cat' to open
> > an ADS and an lsads command should be enough.
> > 
> > Oh, and I would think we might want i_blocks of the 'host' inode to
> > reflect the blocks allocated to all the data streams attached to the
> > inode.  That should address at least parts of the data exfiltration
> > concern.
> 
> I think that's a problem, because metadata blocks that are invisible
> to userspace are also accounted to the inode block count, so a user
> cannot know if the difference between the data file size and the
> block count stat() reports is block mapping metadata, xattrs,
> speculative delayed allocation reservations, etc. It's just not a
> useful signal because it's already so overloaded with invisible
> stuff....

My concern is that 'du' should not have to be made stream-aware to
continue to be accurate.  Yes, all these other things also contribute
to the space being used by a file, so it's not a very reliable signal,
but if you see a vast discrepancy (several gigabytes being used by a
file which is notionally a few hundred bytes), it's suspicious.

> It also means that every block map modification to an ADS inode also
> has to lock and modify the host inode. That's going to mean adding a
> heap of complexity to the filesystem transaction models because now
> there are two independent inodes that have to be locked we doing a
> single inode operations instead of largely being a simple drop in...

It doesn't have to be reflected in the on-disk inode.  As long as the
calling stat() returns the number of blocks allocated to all streams
contained in the file, you can implement that any way you want.

> IOWs, if ADS visibility is required (which I don't think anyone will
> argue against) I'd suggest that statx() has a flag added to indicate
> ADS exist on the inode. Then it's easy to discover through a
> standard interface....

The amount of space used has to be visible to unmodified utilities.
We could have an implementation where unmodified utilities walk all
the sub-streams at stat() time while statx() with the appropriate flag
reports disaggregated data (and is more efficient).


I think we have a group of people contributing to this thread who want
the plain "named streams" functionality that you and I are currently
discussing.  And then another group who want something more complex
where the "alternate" contents of the file could be a directory tree
with files and subdirectories and permissions ... essentially mounting
the contents of a ZIP file on top of itself.  And I think that's a level
of complexity we have to step away from.
