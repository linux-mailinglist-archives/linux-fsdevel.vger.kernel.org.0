Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E946133A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376963AbhK2LK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhK2LI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:08:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D859C08E90B;
        Mon, 29 Nov 2021 02:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3l7FLtzAqnYh4gF+Ec/d9OSuDMjLokSs8f79jM8yBAE=; b=dFflzIo0AA/DU/9aMi6QPwtNhr
        5GIHF36SJArozdQryqg5utOMEdpIE+RdBiIhAzfx3HDhmEfVNpWthQvTD+P8Mj3aY3hWFt3gX1SZg
        pXIW4nYaWd3RSBYfXpg/z1mwBi8fkeM0/s68yIZ4fKeCCnylRVMH5zyqakroauNowO+h+VS3pBzU8
        FsKzaSOiVpS/WyyMhuRPKBzzzuM9tkW9E4i6VAjndNiqsPbPwmYtnE6lNsg7RKg0E93kzc6VMkhPM
        l5hj4VX9PjEWCR6m32bNrlDMVJ1sBRpS+auVWQ2RReQRu8bA6qImk9rENhP/heQg6MhukJE/5leIb
        ggNbP+yg==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdnZ-0073LD-CV; Mon, 29 Nov 2021 10:22:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 07/29] xfs: factor out a xfs_setup_dax_always helper
Date:   Mon, 29 Nov 2021 11:21:41 +0100
Message-Id: <20211129102203.2243509-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out another DAX setup helper to simplify future changes.  Also
move the experimental warning after the checks to not clutter the log
too much if the setup failed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_super.c | 47 +++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e21459f9923a8..875fd3151d6c9 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -340,6 +340,32 @@ xfs_buftarg_is_dax(
 			bdev_nr_sectors(bt->bt_bdev));
 }
 
+static int
+xfs_setup_dax_always(
+	struct xfs_mount	*mp)
+{
+	struct super_block	*sb = mp->m_super;
+
+	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
+	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
+		xfs_alert(mp,
+			"DAX unsupported by block device. Turning off DAX.");
+		goto disable_dax;
+	}
+
+	if (xfs_has_reflink(mp)) {
+		xfs_alert(mp, "DAX and reflink cannot be used together!");
+		return -EINVAL;
+	}
+
+	xfs_warn(mp, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+	return 0;
+
+disable_dax:
+	xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
+	return 0;
+}
+
 STATIC int
 xfs_blkdev_get(
 	xfs_mount_t		*mp,
@@ -1593,26 +1619,9 @@ xfs_fs_fill_super(
 		sb->s_flags |= SB_I_VERSION;
 
 	if (xfs_has_dax_always(mp)) {
-		bool rtdev_is_dax = false, datadev_is_dax;
-
-		xfs_warn(mp,
-		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-
-		datadev_is_dax = xfs_buftarg_is_dax(sb, mp->m_ddev_targp);
-		if (mp->m_rtdev_targp)
-			rtdev_is_dax = xfs_buftarg_is_dax(sb,
-						mp->m_rtdev_targp);
-		if (!rtdev_is_dax && !datadev_is_dax) {
-			xfs_alert(mp,
-			"DAX unsupported by block device. Turning off DAX.");
-			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
-		}
-		if (xfs_has_reflink(mp)) {
-			xfs_alert(mp,
-		"DAX and reflink cannot be used together!");
-			error = -EINVAL;
+		error = xfs_setup_dax_always(mp);
+		if (error)
 			goto out_filestream_unmount;
-		}
 	}
 
 	if (xfs_has_discard(mp)) {
-- 
2.30.2

