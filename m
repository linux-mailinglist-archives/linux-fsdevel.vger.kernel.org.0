Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3029F255104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgH0WZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 18:25:05 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34739 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgH0WZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:25:04 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0D4F43A6A54;
        Fri, 28 Aug 2020 08:24:59 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kBQKI-0007MV-08; Fri, 28 Aug 2020 08:24:58 +1000
Date:   Fri, 28 Aug 2020 08:24:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200827222457.GB12096@dread.disaster.area>
References: <20200728105503.GE2699@work-vm>
 <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827152207.GJ14765@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=PmPOVSaARcegLJGSYz8A:9 a=BTFHRCzL-o9Ki4Ns:21 a=yLgFWm4NFjOP3-qm:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 04:22:07PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 17, 2020 at 10:29:30AM +1000, Dave Chinner wrote:
> > To implement ADS, we'd likely consider adding a new physical inode
> > "ADS fork" which, internally, maps to a separate directory
> > structure. This provides us with the ADS namespace for each inode
> > and a mechanism that instantiates a physical inode per ADS. IOWs,
> > each ADS can be referenced by the VFS natively and independently as
> > an inode (native "file as a directory" semantics). Hence existing
> > create/unlink APIs work for managing ADS, readdir() can list all
> > your ADS, you can keep per ADS xattrs, etc....
> > 
> > IOWs, with a filesystem inode fork implementation like this for ADS,
> > all we really need is for the VFS to pass a magic command to
> > ->lookup() to tell us to use the ADS namespace attached to the inode
> > rather than use the primary inode type/state to perform the
> > operation.
> > 
> > Hence all the ADS support infrastructure is essentially dentry cache
> > infrastructure allowing a dentry to be both a file and directory,
> > and providing the pathname resolution that recognises an ADS
> > redirection. Name that however you want - we've got to do an on-disk
> > format change to support ADS, so we can tell the VFS we support ADS
> > or not. And we have no cares about existing names in the filesystem
> > conflicting with the ADS pathname identifier because it's a mkfs
> > time decision. Given that special flags are needed for the openat()
> > call to resolve an ADS (e.g. O_ALT), we know if we should parse the
> > ADS identifier as an ADS the moment it is seen...
> 
> I think this is equivalent to saying "Linux will never support ADS".
> Al has some choice words on having the dentry cache support objects which
> are both files and directories.  You run into some "fun" locking issues.
> And there's lots of things you just don't want to permit, like mounting
> a new filesystem on top of some ADS, or chrooting a process into an ADS,
> or renaming an ADS into a different file.

I know all this. My point is that the behaviour required by ADS
objects is that of a seekable data file. That requires a struct file
that points at a struct inode, page cache mapping, etc to all work
as they currently do. It also means that how ADS are managed and
presented to userspace is entirely a VFS construct. Indeed,
everything you mention above is functionality controlled/implemented
by the VFS via the dentry cache...

> I think what would satisfy people is allowing actual "alternate data
> streams" to exist in files.  You always start out by opening a file,
> then the presentation layer is a syscall that lets you enumerate the
> data streams available for this file, and another syscall that returns
> an fd for one of those streams.

You could do this with a getdents_at() syscall that has an AT_ALT
flag or something like that. i.e. iterate the streams on the inode
(whether it be a regular file or a directory!) and report them as
dirents to userspace. Userspace can then openat2(fd, name, O_ALT)
and there is your user API.

The VFS can deal with openat2(fd, stream_name, O_ALT) however it
wants - it doesn't need the dentry cache pathwalk here - just vector
straight to the filesystem's ->lookup mechanism on the inode
attached to the "dirfd" passed in. 

AFAICT, the dentry cache only needs to be involved if we want to
-cache- the ADS namespace. I don't think we need to cache the ADS
namespace as long as the inode is cached by the filesystem - just
let the fs and let it do an inode cache lookup and instantiation for
ADS inodes (eg as XFS already does for internal inode accesses
during bulkstat, quotacheck, etc). We don't cache the xattr
namespaces in the VFS - the filesystem is responsible for doing that
if required - so I don't think this would be a problem for ADS
access...

The fact that ADS inodes would not be in the dentry cache and hence
not visible to pathwalks at all then means that all of the issues
such as mounting over them, chroot, etc don't exist in the first
place...

> As long as nobody gets the bright idea to be able to link that fd into
> the directory structure somewhere, this should avoid any problems with
> unwanted things being done to an ADS.  Chunks of your implementation
> described above should be fine for this.

I can see the need for rename and linkat linking O_TMPFILE fd's into
ADS names, though. e.g. to be able to do safe overwrites of ADS
data.

From a fs management POV, we'll also want to be able to do things
like defrag ADS inodes, which means we'll need to be able to do
atomic inode operations (e.g. swap extents) between O_TMPFILE inodes
and ADS inodes, etc. So in addition to the VFS interfaces, there's a
bunch of filesystem admin stuff that will need to be made ADS aware,
and it's likely there will be fs specific ioctls that need to be
modifed/added to manipulate ADS inodes directly...

> I thought through some of this a while back, and came up with this list:
> 
> > Work as expected:
> > mmap(), read(), write(), close(), splice(), sendfile(), fallocate(),
> > ftruncate(), dup(), dup2(), dup3(), utimensat(), futimens(), select(),
> > poll(), lseek(), fcntl(): F_DUPFD, F_GETFD, F_GETFL, F_SETFL, F_SETLK,
> > F_SETLKW, F_GETLK, F_GETOWN, F_SETOWN, F_GETSIG, F_SETSIG, F_SETLEASE,
> > F_GETLEASE)
> >
> > Return error if fd refers to the non-default stream:
> > linkat(), symlinkat(), mknodat(), mkdirat()
> >
> > Remove a stream from a file:
> > unlinkat()
> >
> > Open an existing stream in a file or create a new stream in a file:
> > openat()
> >
> > fstat()
> > st_ino may be different for different names.  st_dev may be different.
> > st_mode will match the object for files, even if it is changed after
> > creation.  For directories, it will match except that execute permission
> > will be removed and S_IFMT will be S_ISREG (do we want to define a
> > new S_ISSTRM?).  st_nlink will be 1.  st_uid and st_gid will match.
> > It will have its own st_atime/st_mtime/st_ctime.  Accessing a stream
> > will not update its parent's atime/mtime/ctime.
> >
> > renameat()
> > If olddirfd + oldpath refers to a stream then newdirfd + newpath must
> > refer to a stream within the same parent object.  If that stream exists,
> > it is removed.  If olddirfd + oldpath does not refer to a stream,
> > then newdirfd + newpath must not refer to a stream.
> >
> > The two file specifications must resolve to the same parent object.
> > It is possible to use renameat() to rename a stream within an object,
> > but not to move a stream from one object to another.  If newpath refers
> > to an existing named stream, it is removed.
> 
> I don't seem to have come up with an actual syscall for enumerating the
> stream names.  I kind of think a fresh syscall might be the right way to
> go.

Why reinvent the wheel? getdentsat() seems like the right interface
to use here because it matches up with all the other *at(AT_ALT)
style interfaces we'd be using to operate on ADS... :P

> For the benefit of shell scripts, I think an argument to 'cat' to open
> an ADS and an lsads command should be enough.
> 
> Oh, and I would think we might want i_blocks of the 'host' inode to
> reflect the blocks allocated to all the data streams attached to the
> inode.  That should address at least parts of the data exfiltration
> concern.

I think that's a problem, because metadata blocks that are invisible
to userspace are also accounted to the inode block count, so a user
cannot know if the difference between the data file size and the
block count stat() reports is block mapping metadata, xattrs,
speculative delayed allocation reservations, etc. It's just not a
useful signal because it's already so overloaded with invisible
stuff....

It also means that every block map modification to an ADS inode also
has to lock and modify the host inode. That's going to mean adding a
heap of complexity to the filesystem transaction models because now
there are two independent inodes that have to be locked we doing a
single inode operations instead of largely being a simple drop in...

IOWs, if ADS visibility is required (which I don't think anyone will
argue against) I'd suggest that statx() has a flag added to indicate
ADS exist on the inode. Then it's easy to discover through a
standard interface....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
