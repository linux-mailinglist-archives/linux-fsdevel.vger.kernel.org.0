Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CE59C0BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiHVNkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiHVNkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4674213F8E;
        Mon, 22 Aug 2022 06:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08024B81215;
        Mon, 22 Aug 2022 13:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0989C433D6;
        Mon, 22 Aug 2022 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661175613;
        bh=8Qc9eRpmV/qtcPvoaYrP/gNt01F55WiPH7SQ9+4cdl8=;
        h=From:To:Cc:Subject:Date:From;
        b=MUKVa86fDGQ8tghg6Dgm8Rhh2JnuGDeA053lp9t5u4KhQyArZBKJ5HBKk3kOBYEMN
         nARKvqE6/y2Q5c6ytOfNa84CsKCIc5bOcFmNQD+kawrr7yDkImQoQv85sft0U6iQAL
         zZcdsRutSf5MQTIgVpw+bMIPwaqNpADfth0CLAx7ME0GMoYBn8pbrxkYA8pXAz0CJz
         azRHV43dgsCJ93Ku+k2s6XYLGvP8lKpvpzo7hq3SmSMZdKTK0KLOgc+iMbde/4TRha
         jVbpPmyKbs7oZjLmnIoTU0F2/wqD2IjAbnKLeuALyOvVw9ZYR0swgLUdwXeHTybYob
         86bd1WBvENDiA==
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        David Wysochanski <dwysocha@redhat.com>
Subject: [PATCH v2] xfs: don't bump the i_version on an atime update in xfs_vn_update_time
Date:   Mon, 22 Aug 2022 09:40:11 -0400
Message-Id: <20220822134011.86558-1-jlayton@kernel.org>
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

v2: don't set the NOIVERS flag if S_VERSION is set

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

