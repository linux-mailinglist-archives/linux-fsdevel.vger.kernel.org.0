Return-Path: <linux-fsdevel+bounces-8569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C79839017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DD61C2777F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE38612C6;
	Tue, 23 Jan 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyIWzpkJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832A60EEE;
	Tue, 23 Jan 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016477; cv=none; b=GKOsCsJYtw8bzBXQ+ispN2v1CgUZxqz2TGYUn4pjS/pL5LuxkCIzkd2Jt08fy8lIRM73mPPb9+gtmi3g8Bqpmpi4cVq7SOk1xlqLZH9nlZY1zBusH+SF0NTySCG88WIhRdKVEkqOiwQLbxRyKkEzIyeacWImwx83rwzb77KSUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016477; c=relaxed/simple;
	bh=gkFGdFeWCaOCZKOGSUukUvKWOKWFHAfd6KUpJCWSoic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgARBwmaBhe+vggYVpnhzOqrU7HOGIASNZtFIo/3nkMzslr5S1VIyd07hF65k8IyPZdtdBSvJR/NoUsR6d6lO/b9f/+KrCZ3DyY51mVb4I0rfRC3Z4S2Z29zXljk1HkvGStPZKbsKoQ6OjX9QIpo2Qu6+BB+yQkjN0vT2UyAkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyIWzpkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B1C43143;
	Tue, 23 Jan 2024 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016477;
	bh=gkFGdFeWCaOCZKOGSUukUvKWOKWFHAfd6KUpJCWSoic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QyIWzpkJ7z+ZVAMAGUpN/e6lqZXJYYj14tNprgHM7R9jJ2vKEbqqA9bx4Hy/+yk4m
	 OZ5Chd13stvrNCPYUiwDiLddNnjf7RU6JXGLfa8H7KOHcmXdCU8DKAKpE9YV7vH37i
	 CJz85IShtax+Spe0gZsc3lzgwuJq1VEkM0tIVS169g2i+mKqJNs3a5lckB7rdRUU36
	 Uy+BBRSV8ePduI9fJWc1c6K3Z/S73n42LrjIq+ozG+vzPqbMhrBjMQxEorOw52PRiH
	 cJLC8htfzBiXQB0pFArvkmq6Wgi4k+03ren/R6mk9Pg5+7PouD374RwGuTQucvins4
	 cieK2waoFtBAA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:41 +0100
Subject: [PATCH v2 24/34] nfs: port block device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-24-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=6218; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gkFGdFeWCaOCZKOGSUukUvKWOKWFHAfd6KUpJCWSoic=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37eg6pqJyx++FeePmuaKVYlyCtkX38g+ZGei+/le2
 dwcxv3MHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5EcvwV3LF9cdSd+O9LzD8
 ex7bxHlXaWW8NYeC5anVd5nLp5UxeDH8d841j857P22Tk9pdeb3Dp9cIKehOvjvrCm/dQQX21e7
 WPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfs/blocklayout/blocklayout.h |  2 +-
 fs/nfs/blocklayout/dev.c         | 68 ++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index b4294a8aa2d4..f1eeb4914199 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -108,7 +108,7 @@ struct pnfs_block_dev {
 	struct pnfs_block_dev		*children;
 	u64				chunk_size;
 
-	struct bdev_handle		*bdev_handle;
+	struct file			*bdev_file;
 	u64				disk_offset;
 
 	u64				pr_key;
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index c97ebc42ec0f..93ef7f864980 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -25,17 +25,17 @@ bl_free_device(struct pnfs_block_dev *dev)
 	} else {
 		if (dev->pr_registered) {
 			const struct pr_ops *ops =
-				dev->bdev_handle->bdev->bd_disk->fops->pr_ops;
+				file_bdev(dev->bdev_file)->bd_disk->fops->pr_ops;
 			int error;
 
-			error = ops->pr_register(dev->bdev_handle->bdev,
+			error = ops->pr_register(file_bdev(dev->bdev_file),
 				dev->pr_key, 0, false);
 			if (error)
 				pr_err("failed to unregister PR key.\n");
 		}
 
-		if (dev->bdev_handle)
-			bdev_release(dev->bdev_handle);
+		if (dev->bdev_file)
+			fput(dev->bdev_file);
 	}
 }
 
@@ -169,7 +169,7 @@ static bool bl_map_simple(struct pnfs_block_dev *dev, u64 offset,
 	map->start = dev->start;
 	map->len = dev->len;
 	map->disk_offset = dev->disk_offset;
-	map->bdev = dev->bdev_handle->bdev;
+	map->bdev = file_bdev(dev->bdev_file);
 	return true;
 }
 
@@ -236,26 +236,26 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	dev_t dev;
 
 	dev = bl_resolve_deviceid(server, v, gfp_mask);
 	if (!dev)
 		return -EIO;
 
-	bdev_handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+	bdev_file = bdev_file_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
 				       NULL, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(bdev_file)) {
 		printk(KERN_WARNING "pNFS: failed to open device %d:%d (%ld)\n",
-			MAJOR(dev), MINOR(dev), PTR_ERR(bdev_handle));
-		return PTR_ERR(bdev_handle);
+			MAJOR(dev), MINOR(dev), PTR_ERR(bdev_file));
+		return PTR_ERR(bdev_file);
 	}
-	d->bdev_handle = bdev_handle;
-	d->len = bdev_nr_bytes(bdev_handle->bdev);
+	d->bdev_file = bdev_file;
+	d->len = bdev_nr_bytes(file_bdev(bdev_file));
 	d->map = bl_map_simple;
 
 	printk(KERN_INFO "pNFS: using block device %s\n",
-		bdev_handle->bdev->bd_disk->disk_name);
+		file_bdev(bdev_file)->bd_disk->disk_name);
 	return 0;
 }
 
@@ -300,10 +300,10 @@ bl_validate_designator(struct pnfs_block_volume *v)
 	}
 }
 
-static struct bdev_handle *
+static struct file *
 bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 {
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	const char *devname;
 
 	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/%s%*phN",
@@ -311,15 +311,15 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
-	bdev_handle = bdev_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
+	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
 					NULL, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(bdev_file)) {
 		pr_warn("pNFS: failed to open device %s (%ld)\n",
-			devname, PTR_ERR(bdev_handle));
+			devname, PTR_ERR(bdev_file));
 	}
 
 	kfree(devname);
-	return bdev_handle;
+	return bdev_file;
 }
 
 static int
@@ -327,7 +327,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	const struct pr_ops *ops;
 	int error;
 
@@ -340,14 +340,14 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	 * On other distributions like Debian, the default SCSI by-id path will
 	 * point to the dm-multipath device if one exists.
 	 */
-	bdev_handle = bl_open_path(v, "dm-uuid-mpath-0x");
-	if (IS_ERR(bdev_handle))
-		bdev_handle = bl_open_path(v, "wwn-0x");
-	if (IS_ERR(bdev_handle))
-		return PTR_ERR(bdev_handle);
-	d->bdev_handle = bdev_handle;
-
-	d->len = bdev_nr_bytes(d->bdev_handle->bdev);
+	bdev_file = bl_open_path(v, "dm-uuid-mpath-0x");
+	if (IS_ERR(bdev_file))
+		bdev_file = bl_open_path(v, "wwn-0x");
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+	d->bdev_file = bdev_file;
+
+	d->len = bdev_nr_bytes(file_bdev(d->bdev_file));
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
@@ -355,20 +355,20 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		return -ENODEV;
 
 	pr_info("pNFS: using block device %s (reservation key 0x%llx)\n",
-		d->bdev_handle->bdev->bd_disk->disk_name, d->pr_key);
+		file_bdev(d->bdev_file)->bd_disk->disk_name, d->pr_key);
 
-	ops = d->bdev_handle->bdev->bd_disk->fops->pr_ops;
+	ops = file_bdev(d->bdev_file)->bd_disk->fops->pr_ops;
 	if (!ops) {
 		pr_err("pNFS: block device %s does not support reservations.",
-				d->bdev_handle->bdev->bd_disk->disk_name);
+				file_bdev(d->bdev_file)->bd_disk->disk_name);
 		error = -EINVAL;
 		goto out_blkdev_put;
 	}
 
-	error = ops->pr_register(d->bdev_handle->bdev, 0, d->pr_key, true);
+	error = ops->pr_register(file_bdev(d->bdev_file), 0, d->pr_key, true);
 	if (error) {
 		pr_err("pNFS: failed to register key for block device %s.",
-				d->bdev_handle->bdev->bd_disk->disk_name);
+				file_bdev(d->bdev_file)->bd_disk->disk_name);
 		goto out_blkdev_put;
 	}
 
@@ -376,7 +376,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	return 0;
 
 out_blkdev_put:
-	bdev_release(d->bdev_handle);
+	fput(d->bdev_file);
 	return error;
 }
 

-- 
2.43.0


