Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3768430F1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 06:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhJREne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 00:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhJREnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:43:33 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F1C06161C;
        Sun, 17 Oct 2021 21:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=glgwSJzGEwQSM6Jz2SxPqM9pJWr388+uRKEOiUyQE70=; b=Xv8p6QGen6vZxngL0hWmmolZLb
        XDO6RQ6yNjTxtsF6/ySZjBm+7+xBt4HLsd34GtAdfbpaiB8L+iI/crRqiyVi1Z9BTMfpBTxHM0c/t
        s6Z7821TpndJq02sLk82ZF6QhgCflPo+WAaFEj/h7lG14I6ytZJVdl4HjqS72LUFDz1tPNIb75x3F
        lxJPOHaeRcwciJEcN7VEq1CGAHdtSo5CBz8vUgxKFU63WEcA/A3w5ELQNosgqe5o22SqEgn/Ddo+o
        4XcPRznSy9Euf+hC3Alw5K4didg/7rWgqdKvHe1REonDzmcqkAjuG9EJcOaBfvxR/xGR4hNewtE4v
        ItppiCVQ==;
Received: from 089144211028.atnat0020.highway.a1.net ([89.144.211.28] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcKSZ-00E3L1-Qh; Mon, 18 Oct 2021 04:41:16 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 06/11] xfs: factor out a xfs_setup_dax helper
Date:   Mon, 18 Oct 2021 06:40:49 +0200
Message-Id: <20211018044054.1779424-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
References: <20211018044054.1779424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out another DAX setup helper to simplify future changes.  Also
move the experimental warning after the checks to not clutter the log
too much if the setup failed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_super.c | 47 +++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c4e0cd1c1c8ca..d07020a8eb9e3 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -339,6 +339,32 @@ xfs_buftarg_is_dax(
 			bdev_nr_sectors(bt->bt_bdev));
 }
 
+static int
+xfs_setup_dax(
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
@@ -1592,26 +1618,9 @@ xfs_fs_fill_super(
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
+		error = xfs_setup_dax(mp);
+		if (error)
 			goto out_filestream_unmount;
-		}
 	}
 
 	if (xfs_has_discard(mp)) {
-- 
2.30.2

