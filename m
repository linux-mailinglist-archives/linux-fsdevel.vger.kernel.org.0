Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9C1AD3AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 02:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgDQAhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 20:37:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:10244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgDQAhU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:37:20 -0400
IronPort-SDR: EZ3usPhr5BEzaIRbEoRk90cqfUZLtLVAbvQhe5tV2t5mL+V4BajMLR7Q24JFd3hUxRa9TEpGDd
 yIFzEHJSuhFw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 17:37:19 -0700
IronPort-SDR: /QRLFOVxKZu12TsgOXc/UwRVE4dxzRPijIffNhwpW4c31b4bGmME3JzmTFQWDWgo8lTord/JCt
 pasq0WeZC8kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="400860752"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2020 17:37:19 -0700
Date:   Thu, 16 Apr 2020 17:37:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200417003719.GP2309605@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-5-ira.weiny@intel.com>
 <20200416162504.GB6733@magnolia>
 <20200416223327.GO2309605@iweiny-DESK2.sc.intel.com>
 <20200416224937.GY6749@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416224937.GY6749@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:49:37PM -0700, Darrick J. Wong wrote:
> On Thu, Apr 16, 2020 at 03:33:27PM -0700, Ira Weiny wrote:
> > On Thu, Apr 16, 2020 at 09:25:04AM -0700, Darrick J. Wong wrote:
> > > On Mon, Apr 13, 2020 at 09:00:26PM -0700, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> > > > 
> > > > Set the flag to be user visible and changeable.  Set the flag to be
> > > > inherited.  Allow applications to change the flag at any time.
> > > > 
> > > > Finally, on regular files, flag the inode to not be cached to facilitate
> > > > changing S_DAX on the next creation of the inode.
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > ---
> > > >  fs/ext4/ext4.h  | 13 +++++++++----
> > > >  fs/ext4/ioctl.c | 21 ++++++++++++++++++++-
> > > >  2 files changed, 29 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > > index 61b37a052052..434021fcec88 100644
> > > > --- a/fs/ext4/ext4.h
> > > > +++ b/fs/ext4/ext4.h
> > > > @@ -415,13 +415,16 @@ struct flex_groups {
> > > >  #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> > > >  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
> > > >  #define EXT4_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
> > > > +
> > > > +#define EXT4_DAX_FL			0x00800000 /* Inode is DAX */
> > > 
> > > Sooo, fun fact about ext4 vs. the world--
> > > 
> > > The GETFLAGS/SETFLAGS ioctl, since it came from ext2, shares the same
> > > flag values as the ondisk inode flags in ext*.  Therefore, each of these
> > > EXT4_[whatever]_FL values are supposed to have a FS_[whatever]_FL
> > > equivalent in include/uapi/linux/fs.h.
> > 
> > Interesting...
> > 
> > > 
> > > (Note that the "[whatever]" is a straight translation since the same
> > > uapi header also defines the FS_XFLAG_[xfswhatever] flag values; ignore
> > > those.)
> > > 
> > > Evidently, FS_NOCOW_FL already took 0x800000, but ext4.h was never
> > > updated to note that the value was taken.  I think Ted might be inclined
> > > to reserve the ondisk inode bit just in case ext4 ever does support copy
> > > on write, though that's his call. :)
> > 
> > Seems like I should change this...  And I did not realize I was inherently
> > changing a bit definition which was exposed to other FS's...
> 
> <nod> This whole thing is a mess, particularly now that we have two vfs
> ioctls to set per-fs inode attributes, both of which were inherited from
> other filesystems... :(
>

Ok I've changed it.

> 
> > > 
> > > Long story short - can you use 0x1000000 for this instead, and add the
> > > corresponding value to the uapi fs.h?  I guess that also means that we
> > > can change FS_XFLAG_DAX (in the form of FS_DAX_FL in FSSETFLAGS) after
> > > that.
> > 
> > :-/
> > 
> > Are there any potential users of FS_XFLAG_DAX now?
> 
> Yes, it's in the userspace ABI so we can't get rid of it.
> 
> (FWIW there are several flags that exist in both FS_XFLAG_* and FS_*_FL
> form.)
> 
> > From what it looks like, changing FS_XFLAG_DAX to FS_DAX_FL would be pretty
> > straight forward.  Just to be sure, looks like XFS converts the FS_[xxx]_FL to
> > FS_XFLAGS_[xxx] in xfs_merge_ioc_xflags()?  But it does not look like all the
> > FS_[xxx]_FL flags are converted.  Is is that XFS does not support those
> > options?  Or is it depending on the VFS layer for some of them?
> 
> XFS doesn't support most of the FS_*_FL flags.

If FS_XFLAG_DAX needs to continue to be user visible I think we need to keep
that flag and we should not expose the EXT4_DAX_FL flag...

I think that works for XFS.

But for ext4 it looks like EXT4_FL_XFLAG_VISIBLE was intended to be used for
[GET|SET]XATTR where EXT4_FL_USER_VISIBLE was intended to for [GET|SET]FLAGS...
But if I don't add EXT4_DAX_FL in EXT4_FL_XFLAG_VISIBLE my test fails.

I've been playing with the flags and looking at the code and I _thought_ the
following patch would ensure that FS_XFLAG_DAX is the only one visible but for
some reason FS_XFLAG_DAX can't be set with this patch.  I still need the
EXT4_FL_USER_VISIBLE mask altered...  Which I believe would expose EXT4_DAX_FL
directly as well.

Jan, Ted?  Any ideas?  Or should we expose EXT4_DAX_FL and FS_XFLAG_DAX in
ext4?

Ira

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fb7e66089a74..c3823f057755 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -423,7 +423,7 @@ struct flex_groups {
 #define EXT4_CASEFOLD_FL               0x40000000 /* Casefolded file */
 #define EXT4_RESERVED_FL               0x80000000 /* reserved for ext4 lib */
 
-#define EXT4_FL_USER_VISIBLE           0x715BDFFF /* User visible flags */
+#define EXT4_FL_USER_VISIBLE           0x705BDFFF /* User visible flags */
 #define EXT4_FL_USER_MODIFIABLE                0x614BC0FF /* User modifiable flags */
 
 /* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index b3c6e891185e..8bd0d3f9ca0b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -744,8 +744,8 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
 {
        struct ext4_inode_info *ei = EXT4_I(inode);
 
-       simple_fill_fsxattr(fa, ext4_iflags_to_xflags(ei->i_flags &
-                                                     EXT4_FL_USER_VISIBLE));
+       simple_fill_fsxattr(fa, (ext4_iflags_to_xflags(ei->i_flags) &
+                                                     EXT4_FL_XFLAG_VISIBLE));
 
        if (ext4_has_feature_project(inode->i_sb))
                fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
