Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306B6F59CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjECOVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjECOUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7206A4E;
        Wed,  3 May 2023 07:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5468062DE2;
        Wed,  3 May 2023 14:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0121C4339E;
        Wed,  3 May 2023 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123649;
        bh=C94uikGnRmREVRqdFg93IJBOCnOyg04cXTwa8d6XodU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGf/0QEqpDQZXTu068wUFLNOWy8Vw2aFrmUS39Sk+aS9M1h+fmSuhqkfeMURIG4yw
         g79R4PVRxITnfMa/zkhMXp5ythzx5gBA/0BRSYUuClaLmAm9cN/nKGhQPaplj7KnFg
         LElnkLRm8+5f/u3dVMWvAcFq72UEYQVA1BZ3YsimYJO2tL/8qfIQa9hK0wiS+kZ7df
         ikAJp72Luz2gcgOD8gw24cGJOOTD1aRbEdaql7/ErG9Fatd7zZUh9nOyzfMK5iFRGg
         ntUj12LtHZr0E2DPSc6+h0GwppCRxw1uvtT0XbIlmNKQI7e+BfWMh7ijWOXWFvfB4d
         970UyWItdJc/w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/6] xfs: convert to multigrain timestamps
Date:   Wed,  3 May 2023 10:20:35 -0400
Message-Id: <20230503142037.153531-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503142037.153531-1-jlayton@kernel.org>
References: <20230503142037.153531-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With this change, also have XFS stop reporting a STATX_CHANGE_COOKIE, so
that nfsd will use the ctime instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_inode_buf.c   |  2 +-
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_acl.c                |  2 +-
 fs/xfs/xfs_bmap_util.c          |  2 +-
 fs/xfs/xfs_inode.c              |  2 +-
 fs/xfs/xfs_inode_item.c         |  2 +-
 fs/xfs/xfs_iops.c               | 15 ++++++++++++---
 fs/xfs/xfs_super.c              |  2 +-
 8 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 758aacd8166b..c29e961fac34 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -316,7 +316,7 @@ xfs_inode_to_disk(
 
 	to->di_atime = xfs_inode_to_disk_ts(ip, inode->i_atime);
 	to->di_mtime = xfs_inode_to_disk_ts(ip, inode->i_mtime);
-	to->di_ctime = xfs_inode_to_disk_ts(ip, inode->i_ctime);
+	to->di_ctime = xfs_inode_to_disk_ts(ip, ctime_peek(inode));
 	to->di_nlink = cpu_to_be32(inode->i_nlink);
 	to->di_gen = cpu_to_be32(inode->i_generation);
 	to->di_mode = cpu_to_be16(inode->i_mode);
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
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index a09dd2606479..e9cb1bfb9574 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1757,7 +1757,7 @@ xfs_swap_extents(
 	 * under it.
 	 */
 	if ((sbp->bs_ctime.tv_sec != VFS_I(ip)->i_ctime.tv_sec) ||
-	    (sbp->bs_ctime.tv_nsec != VFS_I(ip)->i_ctime.tv_nsec) ||
+	    (sbp->bs_ctime.tv_nsec != ctime_nsec_peek(VFS_I(ip))) ||
 	    (sbp->bs_mtime.tv_sec != VFS_I(ip)->i_mtime.tv_sec) ||
 	    (sbp->bs_mtime.tv_nsec != VFS_I(ip)->i_mtime.tv_nsec)) {
 		error = -EBUSY;
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
index ca2941ab6cbc..018f187387f0 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -381,7 +381,7 @@ xfs_inode_to_log_dinode(
 	memset(to->di_pad3, 0, sizeof(to->di_pad3));
 	to->di_atime = xfs_inode_to_log_dinode_ts(ip, inode->i_atime);
 	to->di_mtime = xfs_inode_to_log_dinode_ts(ip, inode->i_mtime);
-	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, inode->i_ctime);
+	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, ctime_peek(inode));
 	to->di_nlink = inode->i_nlink;
 	to->di_gen = inode->i_generation;
 	to->di_mode = inode->i_mode;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 24718adb3c16..f41155cfbbe2 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -573,8 +573,17 @@ xfs_vn_getattr(
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->ino = ip->i_ino;
 	stat->atime = inode->i_atime;
-	stat->mtime = inode->i_mtime;
-	stat->ctime = inode->i_ctime;
+	generic_fill_multigrain_cmtime(request_mask, inode, stat);
+
+	/*
+	 * XFS's i_version counter doesn't conform to the rules that other
+	 * filesystems live by. In particular, it changes the version on atime
+	 * updates which leads to excess cache invalidations on NFS. Just clear
+	 * the STATX_CHANGE_COOKIE flag so that nfsd (and others) use the
+	 * (multigrain) ctime instead.
+	 */
+	stat->result_mask &= ~STATX_CHANGE_COOKIE;
+
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
 	if (xfs_has_v3inodes(mp)) {
@@ -917,7 +926,7 @@ xfs_setattr_size(
 	if (newsize != oldsize &&
 	    !(iattr->ia_valid & (ATTR_CTIME | ATTR_MTIME))) {
 		iattr->ia_ctime = iattr->ia_mtime =
-			current_time(inode);
+			current_ctime(inode);
 		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME;
 	}
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 4f814f9e12ab..db3943d09532 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1976,7 +1976,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MULTIGRAIN_TS,
 };
 MODULE_ALIAS_FS("xfs");
 
-- 
2.40.1

