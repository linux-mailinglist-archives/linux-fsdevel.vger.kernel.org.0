Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776027B007D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjI0JfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjI0Je7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CEF12A;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D48221977;
        Wed, 27 Sep 2023 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiK9GOiMzLUeaSX/rkSPBuJ0eSpi7wf4h/8J7c7Pam4=;
        b=KNBLGTM0pqbZjdV98ejo918JLXFaI77XCKjP+HJL4eFmEpS2pHciVfEpTBSEUoqA+S3xq+
        gpb9G9Gzesslw3alWZMfyv7pD1sh9ISqG0syUI7V+36KSsqlTFj2NPBF2gANdYW/SUPZKc
        XOQ90j3MfLuF4+t60W+gVthvrMr3gvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiK9GOiMzLUeaSX/rkSPBuJ0eSpi7wf4h/8J7c7Pam4=;
        b=dSVD8Uv7PHAZ4yYrBMmn8Bb7EHKQxElTnUKTduWoYYkQhaPDpAZ4IgFPqnrSjnLgrF9foa
        QuNbYNjVtC8gikDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E565F13ADB;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lbr/NzT3E2U6EwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BAEDEA0802; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 28/29] xfs: Convert to bdev_open_by_path()
Date:   Wed, 27 Sep 2023 11:34:34 +0200
Message-Id: <20230927093442.25915-28-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6519; i=jack@suse.cz; h=from:subject; bh=WDaEwTDODmFKMQvrjOP8veQZmRQ3yPNnv3n4KO7nNFY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cprC2u/lY9+ZxE4XFun8Ie5x50uzz/O9TCC3KQ R+LEAHiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3KQAKCRCcnaoHP2RA2UOGB/ 9f5AdBp9W5BFlrCClDnEihV+eaDq/Ye3KvMC/gIsMvodi/WO2oXsE06GRqt+UWHPhFtklCR18kuXpi HiSXBh952rk2o+mHX4GXfj9y9q462y4iPr1t9aV5D9cu+XMEPtwKzu13fGi05ukksVmm74+m1Fgr0d XMKZU9WaJLmgZJyQNxgWll2gRi9jzAL7lUSbgy62tvq09pAc5zizDNFUJaG6/njp9r2oT4w0pl3cDq 5z3RKvzY5PSjMCo35QkHad11ayq3pcVRIRJU/djzvxSXVdXiQP8rk2WqHhvCq2DQofGLE88BqQ9eZg cgAEfI3Jkb9xVyw+FKvLZmOIp0MptS
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert xfs to use bdev_open_by_path() and pass the handle around.

CC: "Darrick J. Wong" <djwong@kernel.org>
CC: linux-xfs@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_buf.c   | 22 ++++++++++------------
 fs/xfs/xfs_buf.h   |  3 ++-
 fs/xfs/xfs_super.c | 42 ++++++++++++++++++++++++------------------
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index c1ece4a08ff4..003e157241da 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1945,8 +1945,6 @@ void
 xfs_free_buftarg(
 	struct xfs_buftarg	*btp)
 {
-	struct block_device	*bdev = btp->bt_bdev;
-
 	unregister_shrinker(&btp->bt_shrinker);
 	ASSERT(percpu_counter_sum(&btp->bt_io_count) == 0);
 	percpu_counter_destroy(&btp->bt_io_count);
@@ -1954,8 +1952,8 @@ xfs_free_buftarg(
 
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
 	/* the main block device is closed by kill_block_super */
-	if (bdev != btp->bt_mount->m_super->s_bdev)
-		blkdev_put(bdev, btp->bt_mount->m_super);
+	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
+		bdev_release(btp->bt_bdev_handle);
 
 	kmem_free(btp);
 }
@@ -1990,16 +1988,15 @@ xfs_setsize_buftarg(
  */
 STATIC int
 xfs_setsize_buftarg_early(
-	xfs_buftarg_t		*btp,
-	struct block_device	*bdev)
+	xfs_buftarg_t		*btp)
 {
-	return xfs_setsize_buftarg(btp, bdev_logical_block_size(bdev));
+	return xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev));
 }
 
 struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
-	struct block_device	*bdev)
+	struct bdev_handle	*bdev_handle)
 {
 	xfs_buftarg_t		*btp;
 	const struct dax_holder_operations *ops = NULL;
@@ -2010,9 +2007,10 @@ xfs_alloc_buftarg(
 	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
 
 	btp->bt_mount = mp;
-	btp->bt_dev =  bdev->bd_dev;
-	btp->bt_bdev = bdev;
-	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off,
+	btp->bt_bdev_handle = bdev_handle;
+	btp->bt_dev = bdev_handle->bdev->bd_dev;
+	btp->bt_bdev = bdev_handle->bdev;
+	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
 	/*
@@ -2022,7 +2020,7 @@ xfs_alloc_buftarg(
 	ratelimit_state_init(&btp->bt_ioerror_rl, 30 * HZ,
 			     DEFAULT_RATELIMIT_BURST);
 
-	if (xfs_setsize_buftarg_early(btp, bdev))
+	if (xfs_setsize_buftarg_early(btp))
 		goto error_free;
 
 	if (list_lru_init(&btp->bt_lru))
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index df8f47953bb4..ada9d310b7d3 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -98,6 +98,7 @@ typedef unsigned int xfs_buf_flags_t;
  */
 typedef struct xfs_buftarg {
 	dev_t			bt_dev;
+	struct bdev_handle	*bt_bdev_handle;
 	struct block_device	*bt_bdev;
 	struct dax_device	*bt_daxdev;
 	u64			bt_dax_part_off;
@@ -364,7 +365,7 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
  *	Handling of buftargs.
  */
 struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
-		struct block_device *bdev);
+		struct bdev_handle *bdev_handle);
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 819a3568b28f..f0ae07828153 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -361,14 +361,15 @@ STATIC int
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
 
@@ -433,7 +434,7 @@ xfs_open_devices(
 {
 	struct super_block	*sb = mp->m_super;
 	struct block_device	*ddev = sb->s_bdev;
-	struct block_device	*logdev = NULL, *rtdev = NULL;
+	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
 	int			error;
 
 	/*
@@ -446,17 +447,19 @@ xfs_open_devices(
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
@@ -468,22 +471,25 @@ xfs_open_devices(
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
 		mp->m_logdev_targp = mp->m_ddev_targp;
+		/* Handle won't be used, drop it */
+		if (logdev_handle)
+			bdev_release(logdev_handle);
 	}
 
 	error = 0;
@@ -497,11 +503,11 @@ xfs_open_devices(
  out_free_ddev_targ:
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
-	 if (rtdev)
-		 blkdev_put(rtdev, sb);
+	 if (rtdev_handle)
+		bdev_release(rtdev_handle);
  out_close_logdev:
-	if (logdev && logdev != ddev)
-		blkdev_put(logdev, sb);
+	if (logdev_handle)
+		bdev_release(logdev_handle);
 	goto out_relock;
 }
 
-- 
2.35.3

