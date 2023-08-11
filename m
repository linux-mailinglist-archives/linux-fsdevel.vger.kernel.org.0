Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E3778CF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbjHKLGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjHKLF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF24110C0;
        Fri, 11 Aug 2023 04:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6AFB521885;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r56ljdyh4C12jH1H+7RaS1LuLMKIjQFGRxEUY+aZq58=;
        b=V7oie20ChCGKTMDgrUI3Sw8Dt58PhPTvs7VvGSVwZQse0+LV1WCKXbYVJFK9Dyk/ShRdUR
        +kkxoYTsXu5bxErHATJRiEqRByHMEkpWWHK09dvyVq/L0qK8Rt7+iKApuv2TDswaGGvEWo
        EmwbEuqakqmRmqOCbh7dJIrU4yANI78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r56ljdyh4C12jH1H+7RaS1LuLMKIjQFGRxEUY+aZq58=;
        b=lyu2ygVQln/bi5EfdMaarQTeJakBYy2NBL2k9EutByTfp/p1Dk8hPdzL0spaYxmIzBzg8E
        0FfN7z0OccDx2CBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D76C13592;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C9DHFuIV1mR2RQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 51BAEA0775; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: [PATCH 25/29] nfs/blocklayout: Convert to use bdev_open_by_dev/path()
Date:   Fri, 11 Aug 2023 13:04:56 +0200
Message-Id: <20230811110504.27514-25-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6139; i=jack@suse.cz; h=from:subject; bh=rYWDLxZJfkOvGQxYSeKk1k3a9sAq+n3eSEXfZ19XET0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXY5qvaPDUJu8Kor5whY6JXMbZ7b2z6NFsq8+ct xPXKYfSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV2AAKCRCcnaoHP2RA2W0JB/ 99pQ7azPGDM09ZigQskkTYdgQTg+dxijY/IF1zSej3D8LIN9nHThk5h74BQ6HEw79UnhQleTZdyxd5 4fQlB62b8wQzPx1NGds0xC883Rz/MVaBJIR7IA1FovysKyvEpUpOzr1RgCejDs5BUQK0nnq00enLYs PTyO+btAhWceCA3c5ZndbKf5t0jqI3wi8cs6tTs2A+I6fwAlKNzt7GvcLgL3jas1iATLtu0k9BpZri EL743wcY3sKkaU5F/5yvJDr50/e7wJ77/njB8AvSWnx7JT91mApUKp/+pbsVpecGi+RpDm7XhLHSRG d/BmdKp4QAXW+rja6LqQnGS1yVDDio
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 70f5563a8e81..0b57b8a4b7e2 100644
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

