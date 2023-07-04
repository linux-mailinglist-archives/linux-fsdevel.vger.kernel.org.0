Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C9874712D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjGDMYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjGDMXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6F110EC;
        Tue,  4 Jul 2023 05:22:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B076B20570;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFS5M2L6grqBBXOgmoSqYUX/Uf+MW2IEEBNQjfMYMSc=;
        b=nRBLd/K/np3AvT9ogiL98WkQByUmtFN2vyz+9N/AWbf3prm6dvUscFnyL/W/z7UPYHC5LF
        bWHrNDzUyf2+LaAzXdkP2okvQFXD4pF4Ek4GPahRmSriK+ppH1uSGbO5jUkt27T1svybUl
        +vcJgFxb3QIEYDkaYKQ7wzw07P2eBrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFS5M2L6grqBBXOgmoSqYUX/Uf+MW2IEEBNQjfMYMSc=;
        b=XkcG9+r5cZn3oWxx2NekcdZVQ0Mrf5cQvwwxz8NjUmFV25Q7JpTFkveJirxx7w2fgbAv6o
        YucQZVEDysdxClCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FFA513A98;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6fNTIgIPpGRcMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4CC05A0764; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH 30/32] xfs: Convert to blkdev_get_handle_by_path()
Date:   Tue,  4 Jul 2023 14:21:57 +0200
Message-Id: <20230704122224.16257-30-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6213; i=jack@suse.cz; h=from:subject; bh=Q8wOGOVFZf3erHmDMvcrgVBfjVNcYRAWlRnf/J4U1/o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7kxn2bpukL0GfKH1gUvt7+t9PaDhZih/q7yzkM V6tqcx+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO5AAKCRCcnaoHP2RA2TuaCA Cs4jUssPLt5xXSRV0yWTxullBiorB2dahQK//49XKtenEWMMKcDA49sMfn1TWAxETKgwugOro9gAbg 2YX14PdMskjEj7He1Cdqw2pIvrQpMaYJd/w5p8uue/W9+yn86y+zVRlIUkCpiIOIUDBgWytMZMNPu9 7GR5c13Z4jCA30magkzsye6dmYWgEtWzwZDUZre7x9EtYuj/sqxJuBZR/YrtLGUJ0oz92ixt50+Af1 ZDqLE2AjTwclxmvkCdrXFIutVz6IR1MmrivI5qnkqhR2GstWP5R5c155QxdWDvRlqCDhqIjwnrDAa4 /UbukzUraRdKz/quR+KZuOClnK8Gep
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert xfs to use blkdev_get_handle_by_path() and pass the handle
around.

CC: "Darrick J. Wong" <djwong@kernel.org>
CC: linux-xfs@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_buf.c   | 11 +++++-----
 fs/xfs/xfs_buf.h   |  3 ++-
 fs/xfs/xfs_super.c | 52 ++++++++++++++++++++++++----------------------
 3 files changed, 35 insertions(+), 31 deletions(-)

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
index 818510243130..5a958ae3a3ae 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -392,14 +392,14 @@ STATIC int
 xfs_blkdev_get(
 	xfs_mount_t		*mp,
 	const char		*name,
-	struct block_device	**bdevp)
+	struct bdev_handle	**handlep)
 {
 	int			error = 0;
 
-	*bdevp = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE, mp,
-				    &xfs_holder_ops);
-	if (IS_ERR(*bdevp)) {
-		error = PTR_ERR(*bdevp);
+	*handlep = blkdev_get_handle_by_path(name,
+			BLK_OPEN_READ | BLK_OPEN_WRITE, mp, &xfs_holder_ops);
+	if (IS_ERR(*handlep)) {
+		error = PTR_ERR(*handlep);
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
 	}
 
@@ -408,11 +408,10 @@ xfs_blkdev_get(
 
 STATIC void
 xfs_blkdev_put(
-	struct xfs_mount	*mp,
-	struct block_device	*bdev)
+	struct bdev_handle	*handle)
 {
-	if (bdev)
-		blkdev_put(bdev, mp);
+	if (handle)
+		blkdev_handle_put(handle);
 }
 
 STATIC void
@@ -420,16 +419,18 @@ xfs_close_devices(
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
@@ -449,24 +450,25 @@ xfs_open_devices(
 	struct xfs_mount	*mp)
 {
 	struct block_device	*ddev = mp->m_super->s_bdev;
-	struct block_device	*logdev = NULL, *rtdev = NULL;
+	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
 	int			error;
 
 	/*
 	 * Open real time and log devices - order is important.
 	 */
 	if (mp->m_logname) {
-		error = xfs_blkdev_get(mp, mp->m_logname, &logdev);
+		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
 		if (error)
 			return error;
 	}
 
 	if (mp->m_rtname) {
-		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev);
+		error = xfs_blkdev_get(mp, mp->m_rtname, &rtdev_handle);
 		if (error)
 			goto out_close_logdev;
 
-		if (rtdev == ddev || rtdev == logdev) {
+		if (rtdev_handle->bdev == ddev ||
+		    rtdev_handle->bdev == logdev_handle->bdev) {
 			xfs_warn(mp,
 	"Cannot mount filesystem with identical rtdev and ddev/logdev.");
 			error = -EINVAL;
@@ -478,18 +480,18 @@ xfs_open_devices(
 	 * Setup xfs_mount buffer target pointers
 	 */
 	error = -ENOMEM;
-	mp->m_ddev_targp = xfs_alloc_buftarg(mp, ddev);
+	mp->m_ddev_targp = xfs_alloc_buftarg(mp, mp->m_super->s_bdev_handle);
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
@@ -504,10 +506,10 @@ xfs_open_devices(
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
 	return error;
 }
 
-- 
2.35.3

