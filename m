Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9D5A318A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 23:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbiHZVrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 17:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345148AbiHZVrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:47:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB322D0216;
        Fri, 26 Aug 2022 14:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3D2ECE312B;
        Fri, 26 Aug 2022 21:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB54EC433D6;
        Fri, 26 Aug 2022 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661550435;
        bh=3NonU2GerMrPghH8DGEw5liykSCzElPuDvCptLZ61mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8Ibfp1lGyT4j3SfzJhYeRJ8QjoAXjKXdJDHFjIMuOgGhgHPxmaIZu/QUVjuf/pr4
         LOA1O7PldD2eC3Av/Ltux4uQRjoJSIHX1Dhdr6ols5ZZpZ6Ih4+Q0XHobc4mH2VoeE
         fBEGMxNE/3M+SoweiYZYVHCEuD+CGSzC5L68rEwxZO5IrJ3RsxbqIHOSBEx+O9y920
         AcoBAOhQE3BLY9bNwA2dgZO6tkwmEU44wHDolEGLZyv44VtA+MmM1Zq6O8n4/HZxAA
         3fMULJvB+hc1HNPpapY+/RBKQwjDtd9jzjzQuK5iKHBih5L9mbmrE9S8x+9WtNJspy
         gaoOYxIKSFhHg==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Wysochanski <dwysocha@redhat.com>
Subject: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update in xfs_vn_update_time
Date:   Fri, 26 Aug 2022 17:47:00 -0400
Message-Id: <20220826214703.134870-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826214703.134870-1-jlayton@kernel.org>
References: <20220826214703.134870-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xfs will update the i_version when updating only the atime value, which
is not desirable for any of the current consumers of i_version. Doing so
leads to unnecessary cache invalidations on NFS and extra measurement
activity in IMA.

Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
transaction should not update the i_version. Set that value in
xfs_vn_update_time if we're only updating the atime.

Cc: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: David Wysochanski <dwysocha@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_log_format.h  |  2 +-
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_iops.c               | 11 +++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

Dave has NACK'ed this patch, but I'm sending it as a way to illustrate
the problem. I still think this approach should at least fix the worst
problems with atime updates being counted. We can look to carve out
other "spurious" i_version updates as we identify them.

If however there are offline analysis tools that require atime updates
to be counted, then we won't be able to do this. If that's the case, how
can we fix this such that serving xfs via NFSv4 doesn't suck?

diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index b351b9dc6561..866a4c5cf70c 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -323,7 +323,7 @@ struct xfs_inode_log_format_32 {
 #define	XFS_ILOG_ABROOT	0x100	/* log i_af.i_broot */
 #define XFS_ILOG_DOWNER	0x200	/* change the data fork owner on replay */
 #define XFS_ILOG_AOWNER	0x400	/* change the attr fork owner on replay */
-
+#define XFS_ILOG_NOIVER	0x800	/* don't bump i_version */
 
 /*
  * The timestamps are dirty, but not necessarily anything else in the inode
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 8b5547073379..ffe6d296e7f9 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -126,7 +126,7 @@ xfs_trans_log_inode(
 	 * unconditionally.
 	 */
 	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
-		if (IS_I_VERSION(inode) &&
+		if (!(flags & XFS_ILOG_NOIVER) && IS_I_VERSION(inode) &&
 		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
 			iversion_flags = XFS_ILOG_CORE;
 	}
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 45518b8c613c..94f14d96641b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1041,10 +1041,17 @@ xfs_vn_update_time(
 		return error;
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	if (flags & S_CTIME)
+
+	if (!(flags & S_VERSION))
+		log_flags |= XFS_ILOG_NOIVER;
+	if (flags & S_CTIME) {
 		inode->i_ctime = *now;
-	if (flags & S_MTIME)
+		log_flags &= ~XFS_ILOG_NOIVER;
+	}
+	if (flags & S_MTIME) {
 		inode->i_mtime = *now;
+		log_flags &= ~XFS_ILOG_NOIVER;
+	}
 	if (flags & S_ATIME)
 		inode->i_atime = *now;
 
-- 
2.37.2

