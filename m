Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E5174156
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 22:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgB1VQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 16:16:23 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51290 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgB1VQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:16:23 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id EBA1A7E826E;
        Sat, 29 Feb 2020 08:16:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j7mzS-00047t-Te; Sat, 29 Feb 2020 08:16:10 +1100
Date:   Sat, 29 Feb 2020 08:16:10 +1100
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
Message-ID: <20200228211610.GQ10737@dread.disaster.area>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
 <A57E33D1-3D54-405A-8300-13F117DC4633@dilger.ca>
 <eda406cc-8ce3-e67a-37be-3e525b58d5a1@virtuozzo.com>
 <4933D88C-2A2D-4ACA-823E-BDFEE0CE143F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4933D88C-2A2D-4ACA-823E-BDFEE0CE143F@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=TYBLyS7eAAAA:8 a=7-415B0cAAAA:8 a=bsSdMAq58TUpE86ZS_YA:9
        a=eQITBiZyMYxeg7ov:21 a=_jd0Q9eB9b6pY1G7:21 a=CjuIK1q_8ugA:10
        a=zvYvwCWiE4KgVXXeO06c:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 08:35:19AM -0700, Andreas Dilger wrote:
> On Feb 27, 2020, at 5:24 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > On 27.02.2020 00:51, Andreas Dilger wrote:
> >> On Feb 26, 2020, at 1:05 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >> In that case, an interesting userspace interface would be an array of
> >> inode numbers (64-bit please) that should be packed together densely in
> >> the order they are provided (maybe a flag for that).  That allows the
> >> filesystem the freedom to find the physical blocks for the allocation,
> >> while userspace can tell which files are related to each other.
> > 
> > So, this interface is 3-in-1:
> > 
> > 1)finds a placement for inodes extents;
> 
> The target allocation size would be sum(size of inodes), which should
> be relatively small in your case).
> 
> > 2)assigns this space to some temporary donor inode;
> 
> Maybe yes, or just reserves that space from being allocated by anyone.
> 
> > 3)calls ext4_move_extents() for each of them.
> 
> ... using the target space that was reserved earlier
> 
> > Do I understand you right?
> 
> Correct.  That is my "5 minutes thinking about an interface for grouping
> small files together without exposing kernel internals" proposal for this.

You don't need any special kernel interface with XFS for this. It is
simply:

	mkdir tmpdir
	create O_TMPFILEs in tmpdir

Now all the tmpfiles you create and their data will be co-located
around the location of the tmpdir inode. This is the natural
placement policy of the filesystem. i..e the filesystem assumes that
files in the same directory are all related, so will be accessed
together and so should be located in relatively close proximity to
each other.

This is a locality optimisation technique that is older than XFS. It
works remarkably well when the filesystem can spread directories
effectively across it's address space.  It also allows userspace to
use simple techniques to group (or separate) data files as desired.
Indeed, this is how xfs_fsr directs locality for it's tmpfiles when
relocating/defragmenting data....

> > If so, then IMO it's good to start from two inodes, because here may code
> > a very difficult algorithm of placement of many inodes, which may require
> > much memory. Is this OK?
> 
> Well, if the files are small then it won't be a lot of memory.  Even so,
> the kernel would only need to copy a few MB at a time in order to get
> any decent performance, so I don't think that is a huge problem to have
> several MB of dirty data in flight.
> 
> > Can we introduce a flag, that some of inode is unmovable?
> 
> There are very few flags left in the ext4_inode->i_flags for use.
> You could use "IMMUTABLE" or "APPEND_ONLY" to mean that, but they
> also have other semantics.  The EXT4_NOTAIL_FL is for not merging the
> tail of a file, but ext4 doesn't have tails (that was in Reiserfs),
> so we might consider it a generic "do not merge" flag if set?

We've had that in XFS for as long as I can remember. Many
applications were sensitive to the exact layout of the files they
created themselves, so having xfs_fsr defrag/move them about would
cause performance SLAs to be broken.

Indeed, thanks to XFS, ext4 already has an interface that can be
used to set/clear a "no defrag" flag such as you are asking for.
It's the FS_XFLAG_NODEFRAG bit in the FS_IOC_FS[GS]ETXATTR ioctl.
In XFS, that manages the XFS_DIFLAG_NODEFRAG on-disk inode flag,
and it has special meaning for directories. From the 'man 3 xfsctl'
man page where this interface came from:

      Bit 13 (0x2000) - XFS_XFLAG_NODEFRAG
	No defragment file bit - the file should be skipped during a
	defragmentation operation. When applied to  a directory,
	new files and directories created will inherit the no-defrag
	bit.

> > Can this interface use a knowledge about underlining device discard granuality?
> 
> As I wrote above, ext4+mballoc has a very good appreciation for alignment.
> That was written for RAID storage devices, but it doesn't matter what
> the reason is.  It isn't clear if flash discard alignment is easily
> used (it may not be a power-of-two value or similar), but wouldn't be
> harmful to try.

Yup, XFS has the similar (but more complex) alignment controls for
directing allocation to match the underlying storage
characteristics. e.g. stripe unit is also the "small file size
threshold" where the allocation policy changes from packing to
aligning and separating.

> > In the answer to Dave, I wrote a proposition to make fallocate() care about
> > i_write_hint. Could you please comment what you think about that too?
> 
> I'm not against that.  How the two interact would need to be documented
> first and discussed to see if that makes sene, and then implemented.

Individual filesystems can make their own choices as to what they do
with write hints, including ignoring them and leaving it for the
storage device to decide where to physically place the data. Which,
in many cases, ignoring the hint is the right thing for the
filesystem to do...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
