Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334EC63B4DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 23:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiK1Wep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 17:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiK1Wec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:34:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291E24942;
        Mon, 28 Nov 2022 14:34:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A5E614AC;
        Mon, 28 Nov 2022 22:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5FFC433D7;
        Mon, 28 Nov 2022 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669674870;
        bh=3X6fc23UC0lBFZ7djVCjRFD1/zFuaPNK/8a+62LaZc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iU93FhpU3ojjR2tVktTN7ofU4GJOrLr5yTlqre0cHfeknASw+oSRENuJfFrBbgkvI
         BjdOAvAYsyI+n01GlkjMc0aS7uRfJrgpzwIJ7K7J8ipJm8kQscGa+qGeYkjgWs8EuR
         oXjiV2cLbLbDvl57u7oZ9fJbVG5d5c8EhbVCWLPK0JlH38EBTY+4PLzVNTXyoRXkhh
         mo3+xZZoRjkhD3sgQsOumXW8W+4MwXDzOUTBdIjRCCd93u7Zp/5zoO2kuhmJbicLuE
         VonBW4UWCst9OLZE8fPOk2ef86PU5XJVNvREpFEPlz7fju3fZJG1QBANViwKLOF1/w
         4hGk2dN2kuBnw==
Date:   Mon, 28 Nov 2022 14:34:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/9] xfs: add debug knob to slow down write for fun
Message-ID: <Y4U3dj5qvpKSQuNM@magnolia>
References: <20221123055812.747923-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123055812.747923-1-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a new error injection knob so that we can arbitrarily slow down
pagecahe writes to test for race conditions and aberrant reclaim
behavior if the writeback mechanisms are slow to issue writeback.  This
will enable functional testing for the ifork sequence counters
introduced in commit XXXXXXXXXXXX that fixes write racing with reclaim
writeback.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_errortag.h |    4 +++-
 fs/xfs/xfs_error.c           |    3 +++
 fs/xfs/xfs_iomap.c           |   15 +++++++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index f5f629174eca..01a9e86b3037 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -62,7 +62,8 @@
 #define XFS_ERRTAG_DA_LEAF_SPLIT			40
 #define XFS_ERRTAG_ATTR_LEAF_TO_NODE			41
 #define XFS_ERRTAG_WB_DELAY_MS				42
-#define XFS_ERRTAG_MAX					43
+#define XFS_ERRTAG_WRITE_DELAY_MS			43
+#define XFS_ERRTAG_MAX					44
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -109,5 +110,6 @@
 #define XFS_RANDOM_DA_LEAF_SPLIT			1
 #define XFS_RANDOM_ATTR_LEAF_TO_NODE			1
 #define XFS_RANDOM_WB_DELAY_MS				3000
+#define XFS_RANDOM_WRITE_DELAY_MS			3000
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 13ac52e7f9e5..d9f9ee969fab 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -61,6 +61,7 @@ static unsigned int xfs_errortag_random_default[] = {
 	XFS_RANDOM_DA_LEAF_SPLIT,
 	XFS_RANDOM_ATTR_LEAF_TO_NODE,
 	XFS_RANDOM_WB_DELAY_MS,
+	XFS_RANDOM_WRITE_DELAY_MS,
 };
 
 struct xfs_errortag_attr {
@@ -177,6 +178,7 @@ XFS_ERRORTAG_ATTR_RW(larp,		XFS_ERRTAG_LARP);
 XFS_ERRORTAG_ATTR_RW(da_leaf_split,	XFS_ERRTAG_DA_LEAF_SPLIT);
 XFS_ERRORTAG_ATTR_RW(attr_leaf_to_node,	XFS_ERRTAG_ATTR_LEAF_TO_NODE);
 XFS_ERRORTAG_ATTR_RW(wb_delay_ms,	XFS_ERRTAG_WB_DELAY_MS);
+XFS_ERRORTAG_ATTR_RW(write_delay_ms,	XFS_ERRTAG_WRITE_DELAY_MS);
 
 static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(noerror),
@@ -221,6 +223,7 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(da_leaf_split),
 	XFS_ERRORTAG_ATTR_LIST(attr_leaf_to_node),
 	XFS_ERRORTAG_ATTR_LIST(wb_delay_ms),
+	XFS_ERRORTAG_ATTR_LIST(write_delay_ms),
 	NULL,
 };
 ATTRIBUTE_GROUPS(xfs_errortag);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 1bdd7afc1010..d5e8146d0d50 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -27,6 +27,8 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_reflink.h"
+#include "xfs_error.h"
+#include "xfs_errortag.h"
 
 #define XFS_ALLOC_ALIGN(mp, off) \
 	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
@@ -71,8 +73,17 @@ xfs_iomap_valid(
 	struct inode		*inode,
 	const struct iomap	*iomap)
 {
-	return iomap->validity_cookie ==
-			xfs_iomap_inode_sequence(XFS_I(inode), iomap->flags);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (iomap->validity_cookie !=
+			xfs_iomap_inode_sequence(ip, iomap->flags)) {
+		XFS_ERRORTAG_REPORT(mp, XFS_ERRTAG_WRITE_DELAY_MS);
+		return false;
+	}
+
+	XFS_ERRORTAG_DELAY(mp, XFS_ERRTAG_WRITE_DELAY_MS);
+	return true;
 }
 
 const struct iomap_page_ops xfs_iomap_page_ops = {
