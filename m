Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10451AE3AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgDQRTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 13:19:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:38364 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgDQRTh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:19:37 -0400
IronPort-SDR: aEyryLCkhgfAPbbLSBdFjw6ieQacCmrTcjjGIE+toJ7E4OuZzeL1F+7hB6d78l7yuyZTA34FAn
 2kQHnsVR4uvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 10:19:36 -0700
IronPort-SDR: PLkem773MNJbcn2ONOYkpbZvrY7xDpNrF167sHCQ6p1V8QhAE99GtvdakzYl9hbOr8WqAiOY9d
 8jS1H0TzeeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="428292211"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2020 10:19:36 -0700
Date:   Fri, 17 Apr 2020 10:19:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200417171936.GT2309605@iweiny-DESK2.sc.intel.com>
References: <20200417022036.GQ2309605@iweiny-DESK2.sc.intel.com>
 <324CEF76-20AA-40F5-A31B-6E0B1CCED736@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <324CEF76-20AA-40F5-A31B-6E0B1CCED736@dilger.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:43:39AM -0600, Andreas Dilger wrote:
> We still need to store an on-disk DAX flag for Ext4, and at that point it
> doesn't make sense not to expose it via the standard Ext4 chattr utility.
> 
> So having EXT4_DAX_FL (== FS_DAX_FL) is no extra effort to add.

I'll leave it exposed then.

Thanks,
Ira

> 
> Cheers, Andreas
> 
> > On Apr 16, 2020, at 20:20, Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > ﻿On Thu, Apr 16, 2020 at 06:57:31PM -0700, Darrick J. Wong wrote:
> >>> On Thu, Apr 16, 2020 at 05:37:19PM -0700, Ira Weiny wrote:
> >>> On Thu, Apr 16, 2020 at 03:49:37PM -0700, Darrick J. Wong wrote:
> >>>> On Thu, Apr 16, 2020 at 03:33:27PM -0700, Ira Weiny wrote:
> >>>>> On Thu, Apr 16, 2020 at 09:25:04AM -0700, Darrick J. Wong wrote:
> >>>>>> On Mon, Apr 13, 2020 at 09:00:26PM -0700, ira.weiny@intel.com wrote:
> >>>>>>> From: Ira Weiny <ira.weiny@intel.com>
> >>>>>>> 
> >>>>>>> Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> >>>>>>> 
> >>>>>>> Set the flag to be user visible and changeable.  Set the flag to be
> >>>>>>> inherited.  Allow applications to change the flag at any time.
> >>>>>>> 
> >>>>>>> Finally, on regular files, flag the inode to not be cached to facilitate
> >>>>>>> changing S_DAX on the next creation of the inode.
> >>>>>>> 
> >>>>>>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >>>>>>> ---
> >>>>>>> fs/ext4/ext4.h  | 13 +++++++++----
> >>>>>>> fs/ext4/ioctl.c | 21 ++++++++++++++++++++-
> >>>>>>> 2 files changed, 29 insertions(+), 5 deletions(-)
> >>>>>>> 
> >>>>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> >>>>>>> index 61b37a052052..434021fcec88 100644
> >>>>>>> --- a/fs/ext4/ext4.h
> >>>>>>> +++ b/fs/ext4/ext4.h
> >>>>>>> @@ -415,13 +415,16 @@ struct flex_groups {
> >>>>>>> #define EXT4_VERITY_FL            0x00100000 /* Verity protected inode */
> >>>>>>> #define EXT4_EA_INODE_FL            0x00200000 /* Inode used for large EA */
> >>>>>>> #define EXT4_EOFBLOCKS_FL        0x00400000 /* Blocks allocated beyond EOF */
> >>>>>>> +
> >>>>>>> +#define EXT4_DAX_FL            0x00800000 /* Inode is DAX */
> >>>>>> 
> >>>>>> Sooo, fun fact about ext4 vs. the world--
> >>>>>> 
> >>>>>> The GETFLAGS/SETFLAGS ioctl, since it came from ext2, shares the same
> >>>>>> flag values as the ondisk inode flags in ext*.  Therefore, each of these
> >>>>>> EXT4_[whatever]_FL values are supposed to have a FS_[whatever]_FL
> >>>>>> equivalent in include/uapi/linux/fs.h.
> >>>>> 
> >>>>> Interesting...
> >>>>> 
> >>>>>> 
> >>>>>> (Note that the "[whatever]" is a straight translation since the same
> >>>>>> uapi header also defines the FS_XFLAG_[xfswhatever] flag values; ignore
> >>>>>> those.)
> >>>>>> 
> >>>>>> Evidently, FS_NOCOW_FL already took 0x800000, but ext4.h was never
> >>>>>> updated to note that the value was taken.  I think Ted might be inclined
> >>>>>> to reserve the ondisk inode bit just in case ext4 ever does support copy
> >>>>>> on write, though that's his call. :)
> >>>>> 
> >>>>> Seems like I should change this...  And I did not realize I was inherently
> >>>>> changing a bit definition which was exposed to other FS's...
> >>>> 
> >>>> <nod> This whole thing is a mess, particularly now that we have two vfs
> >>>> ioctls to set per-fs inode attributes, both of which were inherited from
> >>>> other filesystems... :(
> >>>> 
> >>> 
> >>> Ok I've changed it.
> >>> 
> >>>> 
> >>>>>> 
> >>>>>> Long story short - can you use 0x1000000 for this instead, and add the
> >>>>>> corresponding value to the uapi fs.h?  I guess that also means that we
> >>>>>> can change FS_XFLAG_DAX (in the form of FS_DAX_FL in FSSETFLAGS) after
> >>>>>> that.
> >>>>> 
> >>>>> :-/
> >>>>> 
> >>>>> Are there any potential users of FS_XFLAG_DAX now?
> >>>> 
> >>>> Yes, it's in the userspace ABI so we can't get rid of it.
> >>>> 
> >>>> (FWIW there are several flags that exist in both FS_XFLAG_* and FS_*_FL
> >>>> form.)
> >>>> 
> >>>>> From what it looks like, changing FS_XFLAG_DAX to FS_DAX_FL would be pretty
> >>>>> straight forward.  Just to be sure, looks like XFS converts the FS_[xxx]_FL to
> >>>>> FS_XFLAGS_[xxx] in xfs_merge_ioc_xflags()?  But it does not look like all the
> >>>>> FS_[xxx]_FL flags are converted.  Is is that XFS does not support those
> >>>>> options?  Or is it depending on the VFS layer for some of them?
> >>>> 
> >>>> XFS doesn't support most of the FS_*_FL flags.
> >>> 
> >>> If FS_XFLAG_DAX needs to continue to be user visible I think we need to keep
> >>> that flag and we should not expose the EXT4_DAX_FL flag...
> >>> 
> >>> I think that works for XFS.
> >>> 
> >>> But for ext4 it looks like EXT4_FL_XFLAG_VISIBLE was intended to be used for
> >>> [GET|SET]XATTR where EXT4_FL_USER_VISIBLE was intended to for [GET|SET]FLAGS...
> >>> But if I don't add EXT4_DAX_FL in EXT4_FL_XFLAG_VISIBLE my test fails.
> >>> 
> >>> I've been playing with the flags and looking at the code and I _thought_ the
> >>> following patch would ensure that FS_XFLAG_DAX is the only one visible but for
> >>> some reason FS_XFLAG_DAX can't be set with this patch.  I still need the
> >>> EXT4_FL_USER_VISIBLE mask altered...  Which I believe would expose EXT4_DAX_FL
> >>> directly as well.
> >>> 
> >>> Jan, Ted?  Any ideas?  Or should we expose EXT4_DAX_FL and FS_XFLAG_DAX in
> >>> ext4?
> >> 
> >> Both flags should be exposed through their respective ioctl interfaces
> >> in both filesystems.  That way we don't have to add even more verbiage
> >> to the documentation to instruct userspace programmers on how to special
> >> case ext4 and XFS for the same piece of functionality.
> > 
> > Wouldn't it be more confusing for the user to have 2 different flags which do
> > the same thing?
> > 
> > I would think that using FS_XFLAG_DAX _only_ (for both ext4 and xfs) would be
> > easier without special cases?
> > 
> > Ira
> > 
