Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FDF7B0087
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjI0Jfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjI0JfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:35:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB319C;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 37B2A1FD6D;
        Wed, 27 Sep 2023 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzLjDwi+lH29ZPtAPIAp2dkUVNFpfi+v7PSMjV/6e0s=;
        b=Bt/KYqeZtJ/Tw0kirBzXRiM1OOau13zZX8KVh8U4J3h8BbT10vlCvRmCR/vqhurUbmeCaj
        I2QhtuFKR5hFGiRs2r6DDrRPTHTpg6Y4kKUTxeeSQE7mplCCvFaeN0/B8T6tW6q2mwRzfI
        Ditju6z7si5RbzdSr8WsCuvZagqFPGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzLjDwi+lH29ZPtAPIAp2dkUVNFpfi+v7PSMjV/6e0s=;
        b=G/t2erTh8AY+UjOX1e1igSvYQC8Rl/4nWfX9fb/PUyEpeUhHfZ5YIOwa6TbR99NZ4d4No5
        CVKDaS/VqWAqV0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25D271338F;
        Wed, 27 Sep 2023 09:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HD79CDX3E2VBEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A33B3A07CC; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 25/29] nfs/blocklayout: Convert to use bdev_open_by_dev/path()
Date:   Wed, 27 Sep 2023 11:34:31 +0200
Message-Id: <20230927093442.25915-25-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6234; i=jack@suse.cz; h=from:subject; bh=kYy/0fBvef/qTORPyMijk/Rp4JAQv4ixPzIBJCrHTU4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cnjwtg3j37C1+8CBYnnRCDeOIIcNgiY5riHOR3 7k7ppL6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3JwAKCRCcnaoHP2RA2ceMB/ 9weGxI4Mw0R+o5nzDFqb1rwStnoJ+urHqxeWaHyRvu983DXt5LuC8rUjmPvXh1fIHQoypbpyfitrtP m9jGgnb6K7zYWHPwKfZIbwlmDBSuqC2sX3MNuMRorFSeHhy9FeSputOZpzd+Yq241DDm3eceYwvtC0 g3dzbyEQnxW6puRXZ+bAIPL8gc4C/nd691sTANoJaXCVGr5wCIOr2NWx5K/64vkmX58pegCCn+fYJK +ProVqJBwo0iTdclorhM8yHCEq4inJ0ShAxLulPCRAvuGn0JnR3F7I3UBvX8XrsvtLtm543Ci+7DmX lJB++yZmawz24ybj8611FLNPh/Hdc2
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

Convert block device handling to use bdev_open_by_dev/path() and pass
the handle around.

CC: linux-nfs@vger.kernel.org
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Anna Schumaker <anna@kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
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
index 65cbb5607a5f..f318a05a80e1 100644
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
+			bdev_release(dev->bdev_handle);
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
+	bdev_handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				       NULL, NULL);
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
+	bdev_handle = bdev_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
+					NULL, NULL);
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
+	bdev_release(d->bdev_handle);
 	return error;
 }
 
-- 
2.35.3

