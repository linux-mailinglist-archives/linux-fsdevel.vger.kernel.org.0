Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96998E556A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJYUt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 16:49:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:23023 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfJYUt1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:49:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 13:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="210441346"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 13:49:26 -0700
Date:   Fri, 25 Oct 2019 13:49:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
Message-ID: <20191025204926.GA26184@iweiny-DESK2.sc.intel.com>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area>
 <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
 <20191024213508.GB4614@dread.disaster.area>
 <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
 <20191025003603.GE4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025003603.GE4614@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:36:03AM +1100, Dave Chinner wrote:
> On Fri, Oct 25, 2019 at 02:29:04AM +0300, Boaz Harrosh wrote:
> > On 25/10/2019 00:35, Dave Chinner wrote:
> 
> If something like a find or backup program brings the inode into
> cache, the app may not even get the behaviour it wants, and it can't
> change it until the inode is evicted from cache, which may be never.

Why would this be never?

> Nobody wants implicit/random/uncontrollable/unchangeable behaviour
> like this.

I'm thinking this could work with a bit of effort on the users part.  While the
behavior does have a bit of uncertainty, I feel like there has to be a way to
get the inode to drop from the cache when a final iput() happens on the inode.

Admin programs should not leave files open forever, without the users knowing
about it.  So I don't understand why the inode could not be evicted from the
cache if the FS knew that this change had been made and the inode needs to be
"re-loaded".  See below...

> 
> > (And never change the flag on the fly)
> > (Just brain storming here)
> 
> We went over all this ground when we disabled the flag in the first
> place. We disabled the flag because we couldn't come up with a sane
> way to flip the ops vector short of tracking the number of aops
> calls in progress at any given time. i.e. reference counting the
> aops structure, but that's hard to do with a const ops structure,
> and so it got disabled rather than allowing users to crash
> kernels....

Agreed.  We can't change the a_ops without some guarantee that no one is using
the file.  Which means we need all fds to close and a final iput().  I thought
that would mean an eviction of the inode and a subsequent reload.

Yesterday I coded up the following (applies on top of this series) but I can't
seem to get it to work because I believe xfs is keeping a reference on the
inode.  What am I missing?  I think if I could get xfs to recognize that the
inode needs to be cleared from it's cache this would work, with some caveats.

Currently this works if I remount the fs or if I use <procfs>/drop_caches like
Boaz mentioned.

Isn't there a way to get xfs to do that on it's own?

Ira


From 7762afd95a3e21a782dffd2fd8e13ae4a23b5e4a Mon Sep 17 00:00:00 2001
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 25 Oct 2019 13:32:07 -0700
Subject: [PATCH] squash: Allow phys change on any length file

delay the changing of the effective bit to when the inode is re-read
into the cache.

Currently a work in Progress because xfs seems to cache the inodes as
well and I'm not sure how to get xfs to release it's reference.
---
 fs/xfs/xfs_ioctl.c | 18 +++++++-----------
 include/linux/fs.h |  5 ++++-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 89cf47ef273e..4d730d5781d9 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1233,10 +1233,13 @@ xfs_diflags_to_linux(
 		inode->i_flags |= S_NOATIME;
 	else
 		inode->i_flags &= ~S_NOATIME;
-	if (xflags & FS_XFLAG_DAX)
-		inode->i_flags |= S_DAX;
-	else
-		inode->i_flags &= ~S_DAX;
+	/* NOTE: we do not allow the physical DAX flag to immediately change
+	 * the effective IS_DAX() flag tell the VFS layer to remove the inode
+	 * from the cache on the final iput() to force recreation on the next
+	 * 'fresh' open */
+	if (((xflags & FS_XFLAG_DAX) && !IS_DAX(inode)) ||
+	    (!(xflags & FS_XFLAG_DAX) && IS_DAX(inode)))
+		inode->i_flags |= S_REVALIDATE;
 }
 
 static int
@@ -1320,13 +1323,6 @@ xfs_ioctl_setattr_dax_invalidate(
 	/* lock, flush and invalidate mapping in preparation for flag change */
 	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
 
-	/* File size must be zero to avoid races with asynchronous page
-	 * faults */
-	if (i_size_read(inode) > 0) {
-		error = -EINVAL;
-		goto out_unlock;
-	}
-
 	error = filemap_write_and_wait(inode->i_mapping);
 	if (error)
 		goto out_unlock;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0b4d8fc79e0f..4e9b7bf53c86 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1998,6 +1998,7 @@ struct super_operations {
 #define S_ENCRYPTED	16384	/* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD	32768	/* Casefolded file */
 #define S_VERITY	65536	/* Verity file (using fs/verity/) */
+#define S_REVALIDATE	131072	/* Drop inode from cache on final put */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -2040,6 +2041,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
 #define IS_CASEFOLDED(inode)	((inode)->i_flags & S_CASEFOLD)
 #define IS_VERITY(inode)	((inode)->i_flags & S_VERITY)
+#define IS_REVALIDATE(inode)	((inode)->i_flags & S_REVALIDATE)
 
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
@@ -3027,7 +3029,8 @@ extern int inode_needs_sync(struct inode *inode);
 extern int generic_delete_inode(struct inode *inode);
 static inline int generic_drop_inode(struct inode *inode)
 {
-	return !inode->i_nlink || inode_unhashed(inode);
+	return !inode->i_nlink || inode_unhashed(inode) ||
+		IS_REVALIDATE(inode);
 }
 
 extern struct inode *ilookup5_nowait(struct super_block *sb,
-- 
2.20.1


