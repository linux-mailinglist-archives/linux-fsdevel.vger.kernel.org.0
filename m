Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8146596EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiHQNAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiHQNAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:00:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738653DBC5;
        Wed, 17 Aug 2022 06:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8422B81DB6;
        Wed, 17 Aug 2022 13:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6E9C433C1;
        Wed, 17 Aug 2022 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660741204;
        bh=o3va9KY2jYWJf2jOq6pFt/qHnBaE6/IcqZi0Tj91Dv0=;
        h=From:To:Cc:Subject:Date:From;
        b=Pfg1e3ZktAOUZq7PdE61+ZWW29xjhTjEpjw9vUmW+fRffVtcDksv+/BW5coBnF3tt
         vYj4GuWxYwpTYb6TrEleHSjexDJoaZVLl5nvOy1rC5a7UyNvMmfyATpDrCscG73DsU
         Ed7iHR2WNquXH3i4csAwaKhgX9utMDU+y7Tfe3F3XPNjB94iomSan3X7KitC2Yel3O
         I6kbknvzIvK2xkx7KJy2JLrfW3oI97yB1gSyI5rEOQrj06NYH1HmwdiQsLbU0SHRCK
         ClGkLpF1ZGJFbUsAIV8DkWEF/LDyS1RTydcMns5/cgtbbwHA/GFoeR2SCaqIMtN2nb
         NYBhfoNYRr5mw==
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J . Wong" <djwong@kernel.org>, david@fromorbit.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] xfs: don't bump the i_version on an atime update in xfs_vn_update_time
Date:   Wed, 17 Aug 2022 09:00:02 -0400
Message-Id: <20220817130002.93592-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_log_format.h  |  2 +-
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_iops.c               | 10 +++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

Dave,

How about this for an alternate approach? This just explicitly ensures
that we don't bump the i_version on an atime-only update, and seems to
fix the testcase I have.

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
index 45518b8c613c..54db85a43dfb 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1021,7 +1021,7 @@ xfs_vn_update_time(
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	int			log_flags = XFS_ILOG_TIMESTAMP;
+	int			log_flags = XFS_ILOG_TIMESTAMP|XFS_ILOG_NOIVER;
 	struct xfs_trans	*tp;
 	int			error;
 
@@ -1041,10 +1041,14 @@ xfs_vn_update_time(
 		return error;
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	if (flags & S_CTIME)
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

