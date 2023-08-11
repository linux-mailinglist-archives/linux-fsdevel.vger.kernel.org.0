Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE74778D0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjHKLGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjHKLFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE11724;
        Fri, 11 Aug 2023 04:05:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 865FA21889;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLZ+FJ5a3X4cEmI/4w/njr2u9gvoqCcJ5q5FaxPPw/w=;
        b=0FVT7xD48P76tt0888SfRlPEilbt2oCqiO7UBAGJq47tsvozHYgzGRnVb2J2c+fy1srV94
        p4pu/6lGi8JXttQiHi04eW0Wr0HP3Pc9+ktcCsSQ7rIdtZiHAdZUftvcdkD8V55+cLZEwT
        AzJZyPr1H6D6dKXaj/uUI5k+93pH7iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLZ+FJ5a3X4cEmI/4w/njr2u9gvoqCcJ5q5FaxPPw/w=;
        b=hSsK4450WmES2AmWHYSPdYVDieNKLOSp2q2vs7bSK8PbRVguVyOhEcuqmOfspmCqe7IROp
        uxgdPiODz0yyllDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75A49139FD;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eXa2HOIV1mR8RQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63F48A077C; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH 28/29] xfs: Convert to bdev_open_by_path()
Date:   Fri, 11 Aug 2023 13:04:59 +0200
Message-Id: <20230811110504.27514-28-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6314; i=jack@suse.cz; h=from:subject; bh=fCjnbGQr51LNGcYyGIghmqbMHxMe2tOBpGwL5yVXyrI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXbRdI4pAvtDs4EY4hf6cZ1EYHrW+thCvo+0j6u RYOSosaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV2wAKCRCcnaoHP2RA2STTB/ 9p/Wg8zf6BN1kxctm4RBmge70UgXLo6Gc2H0ucTrlG/O74Pf/W+3OBLSsF8m4xoGZ+C4iwk/LLiJS3 EJ0xZcjzzQ9l3Tcn9tJo7TNtrkEtXTD0QuLyFdmkj4YIoSZ0sHBu4WkperW5rUAbuvfp9pSp/SpDsE TvnGxGHWvLa8iVhks2Zy2mi69tPNKKE3wN1dPAwRBUbiand/16/XGBVypHJVXQjt50YMYyMez/s7xs v/U0DzS2BaPPGQlvnDPhif/swjs1rdBH0e+kEdglFNyqifrP2uzczruwSokMcei1z/DZHBu8qOInMm VKtorQWvsAWi1DJLVnts3Itl/1xQMs
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert xfs to use bdev_open_by_path() and pass the handle around.

CC: "Darrick J. Wong" <djwong@kernel.org>
CC: linux-xfs@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_buf.c   | 11 +++++-----
 fs/xfs/xfs_buf.h   |  3 ++-
 fs/xfs/xfs_super.c | 54 +++++++++++++++++++++++++---------------------
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 15d1e5a7c2d3..461a5fb6155b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1989,7 +1989,7 @@ xfs_setsize_buftarg_early(
 struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
-	struct block_device	*bdev)
+	struct bdev_handle	*bdev_handle)
 {
 	xfs_buftarg_t		*btp;
 	const struct dax_holder_operations *ops = NULL;
@@ -2000,9 +2000,10 @@ xfs_alloc_buftarg(
 	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
 
 	btp->bt_mount = mp;
-	btp->bt_dev =  bdev->bd_dev;
-	btp->bt_bdev = bdev;
-	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off,
+	btp->bt_bdev_handle = bdev_handle;
+	btp->bt_dev =  bdev_handle->bdev->bd_dev;
+	btp->bt_bdev = bdev_handle->bdev;
+	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
 	/*
@@ -2012,7 +2013,7 @@ xfs_alloc_buftarg(
 	ratelimit_state_init(&btp->bt_ioerror_rl, 30 * HZ,
 			     DEFAULT_RATELIMIT_BURST);
 
-	if (xfs_setsize_buftarg_early(btp, bdev))
+	if (xfs_setsize_buftarg_early(btp, btp->bt_bdev))
 		goto error_free;
 
 	if (list_lru_init(&btp->bt_lru))
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 549c60942208..f6418c1312f5 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -92,6 +92,7 @@ typedef unsigned int xfs_buf_flags_t;
  */
 typedef struct xfs_buftarg {
 	dev_t			bt_dev;
+	struct bdev_handle	*bt_bdev_handle;
 	struct block_device	*bt_bdev;
 	struct dax_device	*bt_daxdev;
 	u64			bt_dax_part_off;
@@ -351,7 +352,7 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
  *	Handling of buftargs.
  */
 struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
-		struct block_device *bdev);
+		struct bdev_handle *bdev_handle);
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5340f2dc28bd..6189f726b309 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -381,14 +381,15 @@ STATIC int
 xfs_blkdev_get(
 	xfs_mount_t		*mp,
 	const char		*name,
-	struct block_device	**bdevp)
+	struct bdev_handle	**handlep)
 {
 	int			error = 0;
 
-	*bdevp = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				    mp->m_super, &fs_holder_ops);
-	if (IS_ERR(*bdevp)) {
-		error = PTR_ERR(*bdevp);
+	*handlep = bdev_open_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				     mp->m_super, &fs_holder_ops);
+	if (IS_ERR(*handlep)) {
+		error = PTR_ERR(*handlep);
+		*handlep = NULL;
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
 	}
 
@@ -397,11 +398,10 @@ xfs_blkdev_get(
 
 STATIC void
 xfs_blkdev_put(
-	struct xfs_mount	*mp,
-	struct block_device	*bdev)
+	struct bdev_handle	*handle)
 {
-	if (bdev)
-		blkdev_put(bdev, mp->m_super);
+	if (handle)
+		bdev_release(handle);
 }
 
 STATIC void
@@ -409,16 +409,18 @@ xfs_close_devices(
 	struct xfs_mount	*mp)
 {
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
-		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
+		struct bdev_handle *logdev_handle =
+			mp->m_logdev_targp->bt_bdev_handle;
 
 		xfs_free_buftarg(mp->m_logdev_targp);
-		xfs_blkdev_put(mp, logdev);
+		xfs_blkdev_put(logdev_handle);
 	}
 	if (mp->m_rtdev_targp) {
-		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
+		struct bdev_handle *rtdev_handle =
+			mp->m_rtdev_targp->bt_bdev_handle;
 
 		xfs_free_buftarg(mp->m_rtdev_targp);
-		xfs_blkdev_put(mp, rtdev);
+		xfs_blkdev_put(rtdev_handle);
 	}
 	xfs_free_buftarg(mp->m_ddev_targp);
 }
@@ -439,7 +441,7 @@ xfs_open_devices(
 {
 	struct super_block	*sb = mp->m_super;
 	struct block_device	*ddev = sb->s_bdev;
-	struct block_device	*logdev = NULL, *rtdev = NULL;
+	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
 	int			error;
 
 	/*
@@ -452,17 +454,19 @@ xfs_open_devices(
 	 * Open real time and log devices - order is important.
 	 */
 	if (mp->m_logname) {
-		error = xfs_blkdev_get(mp, mp->m_logname, &logdev);
+		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
 		if (error)
 			goto out_relock;
 	}
 
 	if (mp->m_rtname) {
-		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev);
+		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_handle);
 		if (error)
 			goto out_close_logdev;
 
-		if (rtdev == ddev || rtdev == logdev) {
+		if (rtdev_handle->bdev == ddev ||
+		    (logdev_handle &&
+		     rtdev_handle->bdev == logdev_handle->bdev)) {
 			xfs_warn(mp,
 	"Cannot mount filesystem with identical rtdev and ddev/logdev.");
 			error = -EINVAL;
@@ -474,18 +478,18 @@ xfs_open_devices(
 	 * Setup xfs_mount buffer target pointers
 	 */
 	error = -ENOMEM;
-	mp->m_ddev_targp = xfs_alloc_buftarg(mp, ddev);
+	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_handle);
 	if (!mp->m_ddev_targp)
 		goto out_close_rtdev;
 
-	if (rtdev) {
-		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev);
+	if (rtdev_handle) {
+		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_handle);
 		if (!mp->m_rtdev_targp)
 			goto out_free_ddev_targ;
 	}
 
-	if (logdev && logdev != ddev) {
-		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev);
+	if (logdev_handle && logdev_handle->bdev != ddev) {
+		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_handle);
 		if (!mp->m_logdev_targp)
 			goto out_free_rtdev_targ;
 	} else {
@@ -503,10 +507,10 @@ xfs_open_devices(
  out_free_ddev_targ:
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
-	xfs_blkdev_put(mp, rtdev);
+	xfs_blkdev_put(rtdev_handle);
  out_close_logdev:
-	if (logdev && logdev != ddev)
-		xfs_blkdev_put(mp, logdev);
+	if (logdev_handle && logdev_handle->bdev != ddev)
+		xfs_blkdev_put(logdev_handle);
 	goto out_relock;
 }
 
-- 
2.35.3

