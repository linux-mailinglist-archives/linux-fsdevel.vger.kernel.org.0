Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7C7470FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjGDMYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjGDMXM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39331702;
        Tue,  4 Jul 2023 05:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 947EA2056D;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LO0lP2OUUVNOfhTTtbTWNONPsnXOsrIJo4pCcH/xHpw=;
        b=zmk/f/dIbCPSemJJw8yNvAivVf6UnAY9RcXRoR3NV3n51gjFqjbijZ0WyyezkBlTZgRsL8
        kHdBfpu0FfKN3WGhagL+ypDXPXUmEwpKqeDyVItFLcKgQMoG86zoWhDkxQAyFmHQ79BvMu
        4KU7u4v8Nw8k0GQ1ilDdx8qhVh0Abks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LO0lP2OUUVNOfhTTtbTWNONPsnXOsrIJo4pCcH/xHpw=;
        b=i7OXEYiVNa/UQNd76NJFgYLxHHJ3KF8JTp2k+aQQoUezzQrFbQWPXAApzprfHw+6BQF4xw
        JStcba+ng5fsBeDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 822EB139ED;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /WakHwIPpGRYMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 36B85A0722; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: [PATCH 26/32] nfs/blocklayout: Convert to use blkdev_get_handle_by_dev/path()
Date:   Tue,  4 Jul 2023 14:21:53 +0200
Message-Id: <20230704122224.16257-26-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6163; i=jack@suse.cz; h=from:subject; bh=zUXhguxHVGC1JvPvmR9WfKOB14B9sMuWcUHkkxGAfg8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7hFeLjKXt5Qxa9ph1QDMyPHasyaVa+fYJrIh2e UrgiIhOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO4QAKCRCcnaoHP2RA2cwjB/ 94WrUoxFkVcvylo0GyfciDsPX0kGz1y2Zos71W+bIRj3yTFCaZX9aNV9S4v89vZYE1Do+C4gPJikM3 DtDznTAM8VQUx9wdFR3SVDxlFWXbMOisjKLZm/5a42xejxgpoUnpYM+MH35x8yCtuS3IMm+sbaw3GB JCEP2XcB+6ptWFQjJ9jL57dUrcAczjXxKDNYboWNk0xM985+icne78TxUAngDautmiC7f6hzLW2x3q hAP87GnePLr0qp3WQBVNttfMRlA9b8XfXTuG5t2YBMUt3u/JiwmNpuXh1TRvHAVZqfPlLXPMZFNoPs KdlV8XC1DuAc/pTB5QP+t5363uv4AN
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert block device handling to use blkdev_get_handle_by_dev/path() and
pass the handle around.

CC: linux-nfs@vger.kernel.org
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Anna Schumaker <anna@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nfs/blocklayout/blocklayout.h |  2 +-
 fs/nfs/blocklayout/dev.c         | 76 ++++++++++++++++----------------
 2 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index 716bc75e9ed2..b4294a8aa2d4 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -108,7 +108,7 @@ struct pnfs_block_dev {
 	struct pnfs_block_dev		*children;
 	u64				chunk_size;
 
-	struct block_device		*bdev;
+	struct bdev_handle		*bdev_handle;
 	u64				disk_offset;
 
 	u64				pr_key;
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 70f5563a8e81..549de8600beb 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -25,17 +25,17 @@ bl_free_device(struct pnfs_block_dev *dev)
 	} else {
 		if (dev->pr_registered) {
 			const struct pr_ops *ops =
-				dev->bdev->bd_disk->fops->pr_ops;
+				dev->bdev_handle->bdev->bd_disk->fops->pr_ops;
 			int error;
 
-			error = ops->pr_register(dev->bdev, dev->pr_key, 0,
-				false);
+			error = ops->pr_register(dev->bdev_handle->bdev,
+				dev->pr_key, 0, false);
 			if (error)
 				pr_err("failed to unregister PR key.\n");
 		}
 
-		if (dev->bdev)
-			blkdev_put(dev->bdev, NULL);
+		if (dev->bdev_handle)
+			blkdev_handle_put(dev->bdev_handle);
 	}
 }
 
@@ -169,7 +169,7 @@ static bool bl_map_simple(struct pnfs_block_dev *dev, u64 offset,
 	map->start = dev->start;
 	map->len = dev->len;
 	map->disk_offset = dev->disk_offset;
-	map->bdev = dev->bdev;
+	map->bdev = dev->bdev_handle->bdev;
 	return true;
 }
 
@@ -236,28 +236,26 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	dev_t dev;
 
 	dev = bl_resolve_deviceid(server, v, gfp_mask);
 	if (!dev)
 		return -EIO;
 
-	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, NULL,
-				 NULL);
-	if (IS_ERR(bdev)) {
+	bdev_handle = blkdev_get_handle_by_dev(dev,
+			BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	if (IS_ERR(bdev_handle)) {
 		printk(KERN_WARNING "pNFS: failed to open device %d:%d (%ld)\n",
-			MAJOR(dev), MINOR(dev), PTR_ERR(bdev));
-		return PTR_ERR(bdev);
+			MAJOR(dev), MINOR(dev), PTR_ERR(bdev_handle));
+		return PTR_ERR(bdev_handle);
 	}
-	d->bdev = bdev;
-
-
-	d->len = bdev_nr_bytes(d->bdev);
+	d->bdev_handle = bdev_handle;
+	d->len = bdev_nr_bytes(bdev_handle->bdev);
 	d->map = bl_map_simple;
 
 	printk(KERN_INFO "pNFS: using block device %s\n",
-		d->bdev->bd_disk->disk_name);
+		bdev_handle->bdev->bd_disk->disk_name);
 	return 0;
 }
 
@@ -302,10 +300,10 @@ bl_validate_designator(struct pnfs_block_volume *v)
 	}
 }
 
-static struct block_device *
+static struct bdev_handle *
 bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 {
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	const char *devname;
 
 	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/%s%*phN",
@@ -313,15 +311,15 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
-	bdev = blkdev_get_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE, NULL,
-				  NULL);
-	if (IS_ERR(bdev)) {
+	bdev_handle = blkdev_get_handle_by_path(devname,
+			BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	if (IS_ERR(bdev_handle)) {
 		pr_warn("pNFS: failed to open device %s (%ld)\n",
-			devname, PTR_ERR(bdev));
+			devname, PTR_ERR(bdev_handle));
 	}
 
 	kfree(devname);
-	return bdev;
+	return bdev_handle;
 }
 
 static int
@@ -329,7 +327,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	const struct pr_ops *ops;
 	int error;
 
@@ -342,32 +340,32 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	 * On other distributions like Debian, the default SCSI by-id path will
 	 * point to the dm-multipath device if one exists.
 	 */
-	bdev = bl_open_path(v, "dm-uuid-mpath-0x");
-	if (IS_ERR(bdev))
-		bdev = bl_open_path(v, "wwn-0x");
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
-	d->bdev = bdev;
-
-	d->len = bdev_nr_bytes(d->bdev);
+	bdev_handle = bl_open_path(v, "dm-uuid-mpath-0x");
+	if (IS_ERR(bdev_handle))
+		bdev_handle = bl_open_path(v, "wwn-0x");
+	if (IS_ERR(bdev_handle))
+		return PTR_ERR(bdev_handle);
+	d->bdev_handle = bdev_handle;
+
+	d->len = bdev_nr_bytes(d->bdev_handle->bdev);
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
 	pr_info("pNFS: using block device %s (reservation key 0x%llx)\n",
-		d->bdev->bd_disk->disk_name, d->pr_key);
+		d->bdev_handle->bdev->bd_disk->disk_name, d->pr_key);
 
-	ops = d->bdev->bd_disk->fops->pr_ops;
+	ops = d->bdev_handle->bdev->bd_disk->fops->pr_ops;
 	if (!ops) {
 		pr_err("pNFS: block device %s does not support reservations.",
-				d->bdev->bd_disk->disk_name);
+				d->bdev_handle->bdev->bd_disk->disk_name);
 		error = -EINVAL;
 		goto out_blkdev_put;
 	}
 
-	error = ops->pr_register(d->bdev, 0, d->pr_key, true);
+	error = ops->pr_register(d->bdev_handle->bdev, 0, d->pr_key, true);
 	if (error) {
 		pr_err("pNFS: failed to register key for block device %s.",
-				d->bdev->bd_disk->disk_name);
+				d->bdev_handle->bdev->bd_disk->disk_name);
 		goto out_blkdev_put;
 	}
 
@@ -375,7 +373,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	return 0;
 
 out_blkdev_put:
-	blkdev_put(d->bdev, NULL);
+	blkdev_handle_put(d->bdev_handle);
 	return error;
 }
 
-- 
2.35.3

