Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A99174A5A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 01:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCAAHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 19:07:04 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:60139 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727174AbgCAAHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:07:03 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3E1C17EAD0F;
        Sun,  1 Mar 2020 11:06:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j8C8D-00053a-FV; Sun, 01 Mar 2020 11:06:53 +1100
Date:   Sun, 1 Mar 2020 11:06:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Snitzer <snitzer@redhat.com>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, riteshh@linux.ibm.com,
        krisman@collabora.com, surajjs@amazon.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, Eric Whitney <enwlinux@gmail.com>,
        sblbir@amazon.com, Khazhismel Kumykov <khazhy@google.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
Message-ID: <20200301000653.GS10737@dread.disaster.area>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
 <A57E33D1-3D54-405A-8300-13F117DC4633@dilger.ca>
 <eda406cc-8ce3-e67a-37be-3e525b58d5a1@virtuozzo.com>
 <4933D88C-2A2D-4ACA-823E-BDFEE0CE143F@dilger.ca>
 <20200228211610.GQ10737@dread.disaster.area>
 <F2CA6010-F7E5-4891-A337-FA1FEB32B935@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2CA6010-F7E5-4891-A337-FA1FEB32B935@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=7-415B0cAAAA:8 a=TYBLyS7eAAAA:8 a=d3t3XxdUcUBxI7EExOIA:9
        a=vG0tVmWIGI90jERS:21 a=ssZfECPllHHjBRnG:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=zvYvwCWiE4KgVXXeO06c:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 01:12:52PM -0700, Andreas Dilger wrote:
> On Feb 28, 2020, at 2:16 PM, Dave Chinner <david@fromorbit.com> wrote:
> > 
> > On Fri, Feb 28, 2020 at 08:35:19AM -0700, Andreas Dilger wrote:
> >> On Feb 27, 2020, at 5:24 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>> 
> >>> So, this interface is 3-in-1:
> >>> 
> >>> 1)finds a placement for inodes extents;
> >> 
> >> The target allocation size would be sum(size of inodes), which should
> >> be relatively small in your case).
> >> 
> >>> 2)assigns this space to some temporary donor inode;
> >> 
> >> Maybe yes, or just reserves that space from being allocated by anyone.
> >> 
> >>> 3)calls ext4_move_extents() for each of them.
> >> 
> >> ... using the target space that was reserved earlier
> >> 
> >>> Do I understand you right?
> >> 
> >> Correct.  That is my "5 minutes thinking about an interface for grouping
> >> small files together without exposing kernel internals" proposal for this.
> > 
> > You don't need any special kernel interface with XFS for this. It is
> > simply:
> > 
> > 	mkdir tmpdir
> > 	create O_TMPFILEs in tmpdir
> > 
> > Now all the tmpfiles you create and their data will be co-located
> > around the location of the tmpdir inode. This is the natural
> > placement policy of the filesystem. i..e the filesystem assumes that
> > files in the same directory are all related, so will be accessed
> > together and so should be located in relatively close proximity to
> > each other.
> 
> Sure, this will likely get inodes allocate _close_ to each other on
> ext4 as well (the new directory will preferentially be located in a
> group that has free space), but it doesn't necessarily result in
> all of the files being packed densely.  For 1MB+4KB and 1MB-4KB files
> they will still prefer to be aligned on 1MB boundaries rather than
> packed together.

Userspace can control that, too, simply by choosing to relocate only
small files into a single directory, then relocating the large files
in a separate set of operations after flushing the small files and
having the packed tightly.

Seriously, userspace has a *lot* of control of how data is located
and packed simply by grouping the IO it wants to be written together
into the same logical groups (i.e. directories) in the same temporal
IO domain...

> >>> Can we introduce a flag, that some of inode is unmovable?
> >> 
> >> There are very few flags left in the ext4_inode->i_flags for use.
> >> You could use "IMMUTABLE" or "APPEND_ONLY" to mean that, but they
> >> also have other semantics.  The EXT4_NOTAIL_FL is for not merging the
> >> tail of a file, but ext4 doesn't have tails (that was in Reiserfs),
> >> so we might consider it a generic "do not merge" flag if set?
> > 
> > Indeed, thanks to XFS, ext4 already has an interface that can be
> > used to set/clear a "no defrag" flag such as you are asking for.
> > It's the FS_XFLAG_NODEFRAG bit in the FS_IOC_FS[GS]ETXATTR ioctl.
> > In XFS, that manages the XFS_DIFLAG_NODEFRAG on-disk inode flag,
> > and it has special meaning for directories. From the 'man 3 xfsctl'
> > man page where this interface came from:
> > 
> >      Bit 13 (0x2000) - XFS_XFLAG_NODEFRAG
> > 	No defragment file bit - the file should be skipped during a
> > 	defragmentation operation. When applied to  a directory,
> > 	new files and directories created will inherit the no-defrag
> > 	bit.
> 
> The interface is not the limiting factor here, but rather the number
> of flags available in the inode.

Yes, that's an internal ext4 issue, not a userspace API problem.

> Since chattr/lsattr from e2fsprogs
> was used as "common ground" for a few years, there are a number of
> flags in the namespace that don't actually have any meaning for ext4.

Yes, that's a shitty API bed that extN made for itself, isn't it?
We've sucked at API design for a long, long time. :/

But the chattr userspace application is also irrelevant to the
problem at hand: it already uses the FS_IOC_FS[GS]ETXATTR ioctl
interface for changing project quota IDs and the per-inode
inheritance flag. Hence how it manages the new flag is irrelevant,
but it also means we can't change the definition or behaviour of
existing flags it controls regardless of what filesystem those flags
act on.

> One of those flags is:
> 
> #define EXT4_NOTAIL_FL    0x00008000 /* file tail should not be merged */
> 
> This was added for Reiserfs, but it is not used by any other filesystem,
> so generalizing it slightly to mean "no migrate" is reasonable.  That
> doesn't affect Reiserfs in any way, and it would still be possible to
> also wire up the XFS_XFLAG_NODEFRAG bit to be stored as that flag.

Yes, ext4 could do that, but we are not allowed to redefine long
standing userspace API flags to mean something completely different.
That's effectively what you are proposing here if you allow ext4 to
manipulate the same on-disk flag via both FS_NOTAIL_FL and
FS_XFLAG_NODEFRAG. ie. the  FS_NOTAIL_FL flag is manipulated by
FS_IOC_[GS]ETFLAGS and is marked both as user visible and modifiable
by ext4 even though ti does nothing.

IOWs, to redefine this on-disk flag we would also need to have
EXT4_IOC_GETFLAGS / EXT4_IOC_SETFLAGS reject attempts to set/clear
FS_NOTAIL_FL with EOPNOTSUPP or EINVAL. Which we then risk breaking
applications that use this flag even though ext4 does not implement
anything other than setting/clearing the flag on demand.

IOWs, we cannot change the meaning of the EXT4_NOTAIL_FL on disk
flag, because that either changes the user visible behaviour of the
on-disk flag or it changes the definition of a userspace API flag to
mean something it was never meant to mean. Neither of those things
are acceptible changes to make to a generic userspace API.

> It wouldn't be any issue at all to chose an arbitrary unused flag to
> store this in ext4 inode internally, except that chattr/lsattr are used
> by a variety of different filesystems, so whatever flag is chosen will
> immediately also apply to any other filesystem that users use those
> tools on.

The impact on userspace is only a problem if you re-use a flag ext4
already exposes to userspace. And that is not allowed if it causes
the userspace API to be globally redefined for everyone. Which,
clearly, it would.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
