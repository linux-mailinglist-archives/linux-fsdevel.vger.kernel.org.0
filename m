Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1F46ED109
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjDXPLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjDXPLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:11:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C35449E;
        Mon, 24 Apr 2023 08:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5CA625E1;
        Mon, 24 Apr 2023 15:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C104DC433EF;
        Mon, 24 Apr 2023 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682349073;
        bh=CH5ETGl1VCk5J+tPCp/iNHJe4ToABvcdm5xjv9j3lBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGQWsqzImKJ+8lpWetGzUbqVKVCqOyNDACZBvfubmDwpHAUKkWDsXk6wIc8LfJqaK
         nyLaJYE9kP1DiwLE8yaDX0eQraEuY6HWKq7r5Hl+BvOmqNN+F/w7jjvUIyotvhxmcc
         AJVuX2xkwrs7BQ/+8D1nH7+PqP0vMBxxrlILiu1rnTe8WBdUM7PrlmX14WU6IGGZVc
         r4s0mGlEBEyV3aQTHdCOSFpyCYTtCoG1k6sm2tQQfPTTcF+xOsdbflSU/ocxbICwO/
         vXjykC6ZZq/0vC+9egeYOjg6yCY+jYo40zseLcQwn6hk0xmlQjWcJW5rNCfvHZp0fi
         I8ql5Fgb0amOg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] xfs: mark the inode for high-res timestamp update in getattr
Date:   Mon, 24 Apr 2023 11:11:04 -0400
Message-Id: <20230424151104.175456-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424151104.175456-1-jlayton@kernel.org>
References: <20230424151104.175456-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the mtime or ctime is being queried via getattr, ensure that we
mark the inode for a high-res timestamp update on the next pass. Also,
switch to current_cmtime for other c/mtime updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_inode.c | 2 +-
 fs/xfs/xfs_acl.c                | 2 +-
 fs/xfs/xfs_inode.c              | 2 +-
 fs/xfs/xfs_inode_item.c         | 2 +-
 fs/xfs/xfs_iops.c               | 9 ++++++---
 fs/xfs/xfs_super.c              | 5 ++++-
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 8b5547073379..c08be3aa3339 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -63,7 +63,7 @@ xfs_trans_ichgtime(
 	ASSERT(tp);
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
 
-	tv = current_time(inode);
+	tv = current_ctime(inode);
 
 	if (flags & XFS_ICHGTIME_MOD)
 		inode->i_mtime = tv;
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 791db7d9c849..85353e6e9004 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -233,7 +233,7 @@ xfs_acl_set_mode(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 	inode->i_mode = mode;
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
 	if (xfs_has_wsync(mp))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 5808abab786c..ac299c1a9838 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -843,7 +843,7 @@ xfs_init_new_inode(
 	ip->i_df.if_nextents = 0;
 	ASSERT(ip->i_nblocks == 0);
 
-	tv = current_time(inode);
+	tv = current_ctime(inode);
 	inode->i_mtime = tv;
 	inode->i_atime = tv;
 	inode->i_ctime = tv;
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index ca2941ab6cbc..dc33f495f4fa 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -381,7 +381,7 @@ xfs_inode_to_log_dinode(
 	memset(to->di_pad3, 0, sizeof(to->di_pad3));
 	to->di_atime = xfs_inode_to_log_dinode_ts(ip, inode->i_atime);
 	to->di_mtime = xfs_inode_to_log_dinode_ts(ip, inode->i_mtime);
-	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, inode->i_ctime);
+	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, timestamp_truncate(inode->i_ctime, inode));
 	to->di_nlink = inode->i_nlink;
 	to->di_gen = inode->i_generation;
 	to->di_mode = inode->i_mode;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 24718adb3c16..b0490e46e825 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -573,8 +573,11 @@ xfs_vn_getattr(
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->ino = ip->i_ino;
 	stat->atime = inode->i_atime;
-	stat->mtime = inode->i_mtime;
-	stat->ctime = inode->i_ctime;
+	if (request_mask & (STATX_MTIME|STATX_CTIME))
+		generic_fill_multigrain_cmtime(inode, stat);
+	else
+		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
+
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
 	if (xfs_has_v3inodes(mp)) {
@@ -917,7 +920,7 @@ xfs_setattr_size(
 	if (newsize != oldsize &&
 	    !(iattr->ia_valid & (ATTR_CTIME | ATTR_MTIME))) {
 		iattr->ia_ctime = iattr->ia_mtime =
-			current_time(inode);
+			current_ctime(inode);
 		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME;
 	}
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 4f814f9e12ab..ee9d0b43bf15 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1620,7 +1620,7 @@ xfs_fs_fill_super(
 	sb->s_blocksize_bits = ffs(sb->s_blocksize) - 1;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_max_links = XFS_MAXLINK;
-	sb->s_time_gran = 1;
+	sb->s_time_gran = 2;
 	if (xfs_has_bigtime(mp)) {
 		sb->s_time_min = xfs_bigtime_to_unix(XFS_BIGTIME_TIME_MIN);
 		sb->s_time_max = xfs_bigtime_to_unix(XFS_BIGTIME_TIME_MAX);
@@ -1633,6 +1633,9 @@ xfs_fs_fill_super(
 
 	set_posix_acl_flag(sb);
 
+	/* Enable multigrain timestamps */
+	sb->s_flags |= SB_MULTIGRAIN_TS;
+
 	/* version 5 superblocks support inode version counters. */
 	if (xfs_has_crc(mp))
 		sb->s_flags |= SB_I_VERSION;
-- 
2.40.0

