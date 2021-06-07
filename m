Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5309139DFA1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFGOyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 10:54:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51722 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhFGOyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:54:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E170F1FDD5;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623077557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfDin0J2zny5bW8XnWnPVfAKe9yqG7WG/xT8oxb1OFc=;
        b=ko9c25cMZ9m2NiKcrQaoy4jB2KP5+1KJ5AmveEHVcxVC897KyySKjriOsW9ddFUrBmrsnW
        tplhe3RBaLbIBGr/60F4LD9RtyGK0O7MJoXf3rJ2ReLB48rTwVcVr5qpYZnb39Umi7B1TU
        fevxNlW1A1nPHC0/mQw4leHU5yao5Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623077557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfDin0J2zny5bW8XnWnPVfAKe9yqG7WG/xT8oxb1OFc=;
        b=zCJrGdMPlN9oBtyZvI/DiQEevYk2yUhECJIW5Kelc7FBxXz22DF6h0GjiHDGJjDHaYrs2Q
        SEThINadMsXZUtBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B3662A3B90;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ABD5C1F2CB8; Mon,  7 Jun 2021 16:52:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 09/14] xfs: Convert double locking of MMAPLOCK to use VFS helpers
Date:   Mon,  7 Jun 2021 16:52:19 +0200
Message-Id: <20210607145236.31852-9-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607144631.8717-1-jack@suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4917; h=from:subject; bh=Xf/EluwecvDckS87lWRfy77OC8mUhzlKOvkojalUOxs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgvjKjGNBsDA4B/xWBG7QqXcuTTJ84ph+j2kRzoAje 0Eh8m9mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYL4yowAKCRCcnaoHP2RA2Uh7CA DZbcBgGYIBPgI4e6MROhQ7DoBtFZkTvHXvvFzadqOPGkvDAkWZ7mKBrNWv6aRNNMkTBjw6uF7CuYOR AQk0lmW+6Cx7gK1uu5H9A96j7hXnKvCDYplEu4gG5Ac7LQTmWPNtFlG4gATfERUak58My8Ja2eDkLj r74P/RTyjlGIG5SLeKnqQAKaxk1qYZ7ILXWpX4U4VZ1J6U9X7uZYKaU7HfsZd5yqB+QADrj++hrsEG Kgr4bDYlseBkWLvTOGTVyaU+izvpq7aJNMbC+BoWwusx2fNABlDXJo0MDQiivDY0+75/9P3+OatqKt 5Bux1K4NKGY6+gr+NlJqaR6T1oEnwb
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert places in XFS that take MMAPLOCK for two inodes to use helper
VFS provides for it (filemap_invalidate_down_write_two()). Note that
this changes lock ordering for MMAPLOCK from inode number based ordering
to pointer based ordering VFS generally uses.

CC: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_bmap_util.c | 15 ++++++++-------
 fs/xfs/xfs_inode.c     | 37 +++++++++++--------------------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index a5e9d7d34023..7421d6ec4def 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1582,7 +1582,6 @@ xfs_swap_extents(
 	struct xfs_bstat	*sbp = &sxp->sx_stat;
 	int			src_log_flags, target_log_flags;
 	int			error = 0;
-	int			lock_flags;
 	uint64_t		f;
 	int			resblks = 0;
 	unsigned int		flags = 0;
@@ -1594,8 +1593,8 @@ xfs_swap_extents(
 	 * do the rest of the checks.
 	 */
 	lock_two_nondirectories(VFS_I(ip), VFS_I(tip));
-	lock_flags = XFS_MMAPLOCK_EXCL;
-	xfs_lock_two_inodes(ip, XFS_MMAPLOCK_EXCL, tip, XFS_MMAPLOCK_EXCL);
+	filemap_invalidate_lock_two(VFS_I(ip)->i_mapping,
+				    VFS_I(tip)->i_mapping);
 
 	/* Verify that both files have the same format */
 	if ((VFS_I(ip)->i_mode & S_IFMT) != (VFS_I(tip)->i_mode & S_IFMT)) {
@@ -1667,7 +1666,6 @@ xfs_swap_extents(
 	 * or cancel will unlock the inodes from this point onwards.
 	 */
 	xfs_lock_two_inodes(ip, XFS_ILOCK_EXCL, tip, XFS_ILOCK_EXCL);
-	lock_flags |= XFS_ILOCK_EXCL;
 	xfs_trans_ijoin(tp, ip, 0);
 	xfs_trans_ijoin(tp, tip, 0);
 
@@ -1786,13 +1784,16 @@ xfs_swap_extents(
 	trace_xfs_swap_extent_after(ip, 0);
 	trace_xfs_swap_extent_after(tip, 1);
 
+out_unlock_ilock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(tip, XFS_ILOCK_EXCL);
 out_unlock:
-	xfs_iunlock(ip, lock_flags);
-	xfs_iunlock(tip, lock_flags);
+	filemap_invalidate_unlock_two(VFS_I(ip)->i_mapping,
+				      VFS_I(tip)->i_mapping);
 	unlock_two_nondirectories(VFS_I(ip), VFS_I(tip));
 	return error;
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
-	goto out_unlock;
+	goto out_unlock_ilock;
 }
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index e1854a660809..0468f56f3bbb 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -556,12 +556,10 @@ xfs_lock_inodes(
 }
 
 /*
- * xfs_lock_two_inodes() can only be used to lock one type of lock at a time -
- * the mmaplock or the ilock, but not more than one type at a time. If we lock
- * more than one at a time, lockdep will report false positives saying we have
- * violated locking orders.  The iolock must be double-locked separately since
- * we use i_rwsem for that.  We now support taking one lock EXCL and the other
- * SHARED.
+ * xfs_lock_two_inodes() can only be used to lock ilock. The iolock and
+ * mmaplock must be double-locked separately since we use i_rwsem and
+ * invalidate_lock for that. We now support taking one lock EXCL and the
+ * other SHARED.
  */
 void
 xfs_lock_two_inodes(
@@ -579,15 +577,8 @@ xfs_lock_two_inodes(
 	ASSERT(hweight32(ip1_mode) == 1);
 	ASSERT(!(ip0_mode & (XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL)));
 	ASSERT(!(ip1_mode & (XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL)));
-	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
-	       !(ip0_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
-	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
-	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
-	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
-	       !(ip0_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
-	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
-	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
-
+	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)));
+	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)));
 	ASSERT(ip0->i_ino != ip1->i_ino);
 
 	if (ip0->i_ino > ip1->i_ino) {
@@ -3750,11 +3741,8 @@ xfs_ilock2_io_mmap(
 	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
 	if (ret)
 		return ret;
-	if (ip1 == ip2)
-		xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
-	else
-		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
-				    ip2, XFS_MMAPLOCK_EXCL);
+	filemap_invalidate_lock_two(VFS_I(ip1)->i_mapping,
+				    VFS_I(ip2)->i_mapping);
 	return 0;
 }
 
@@ -3764,12 +3752,9 @@ xfs_iunlock2_io_mmap(
 	struct xfs_inode	*ip1,
 	struct xfs_inode	*ip2)
 {
-	bool			same_inode = (ip1 == ip2);
-
-	xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
-	if (!same_inode)
-		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
+	filemap_invalidate_unlock_two(VFS_I(ip1)->i_mapping,
+				      VFS_I(ip2)->i_mapping);
 	inode_unlock(VFS_I(ip2));
-	if (!same_inode)
+	if (ip1 != ip2)
 		inode_unlock(VFS_I(ip1));
 }
-- 
2.26.2

