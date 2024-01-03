Return-Path: <linux-fsdevel+bounces-7205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C5822DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94194285B52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED01BDF7;
	Wed,  3 Jan 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev+/135N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC71BDE2;
	Wed,  3 Jan 2024 12:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE92FC433C7;
	Wed,  3 Jan 2024 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286579;
	bh=rz5i3p27iNGMZq3H+CpgPLh9W7l4W+LguQEvw+kLKyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ev+/135N9BWwr0aYQlv2/LQj9SW2BgsdQk3inDoOwcFy68N6JrurnmMafZ0aCaZJk
	 gxxi1uv2ymTXtK3QyH9CneN6L/iYYXiSDuU35tVmqA9edkWEbTmdl3q8arFQG5uUdG
	 4Xu5Xt8EAlq7sDm+gOecJksQWkvdHJza4IiLgo4uQdzI28Hvw4qpfJE7wFyPU9PVJX
	 fp7QUc9GIF93daZSptMUxwWau6DFfrj/DDoX95w42Gz2ZjfXAcITTcKmjZFK1JijHw
	 9Zht0ohFG6CsVOQ5xUmxABMgknKBQTVt3VuRWHJZXqWFQk0lzzWlQbEwB0acBj7A3c
	 k3TYzK9UjuFNg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:22 +0100
Subject: [PATCH RFC 24/34] nfs: port block device access to files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-24-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=5967; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rz5i3p27iNGMZq3H+CpgPLh9W7l4W+LguQEvw+kLKyI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbT13FJoar1SZPe3+MLPbM7Wadv8ti68qbRhFf8iw
 28zP/t1d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkUhIjw7pTb1gVHh6zXuyg
 WC0txy99d5NA0ZG5l3PMudpMZ+gcvMXw36ft+dT65JyW911m06ZM8p90r++Wf8jhqr6KF0qeLlu
 VeAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfs/blocklayout/blocklayout.h |  2 +-
 fs/nfs/blocklayout/dev.c         | 68 ++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index b4294a8aa2d4..5f9d9a823c9b 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -108,7 +108,7 @@ struct pnfs_block_dev {
 	struct pnfs_block_dev		*children;
 	u64				chunk_size;
 
-	struct bdev_handle		*bdev_handle;
+	struct file			*f_bdev;
 	u64				disk_offset;
 
 	u64				pr_key;
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index f318a05a80e1..d6534ae9eef7 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -25,17 +25,17 @@ bl_free_device(struct pnfs_block_dev *dev)
 	} else {
 		if (dev->pr_registered) {
 			const struct pr_ops *ops =
-				dev->bdev_handle->bdev->bd_disk->fops->pr_ops;
+				F_BDEV(dev->f_bdev)->bd_disk->fops->pr_ops;
 			int error;
 
-			error = ops->pr_register(dev->bdev_handle->bdev,
+			error = ops->pr_register(F_BDEV(dev->f_bdev),
 				dev->pr_key, 0, false);
 			if (error)
 				pr_err("failed to unregister PR key.\n");
 		}
 
-		if (dev->bdev_handle)
-			bdev_release(dev->bdev_handle);
+		if (dev->f_bdev)
+			fput(dev->f_bdev);
 	}
 }
 
@@ -169,7 +169,7 @@ static bool bl_map_simple(struct pnfs_block_dev *dev, u64 offset,
 	map->start = dev->start;
 	map->len = dev->len;
 	map->disk_offset = dev->disk_offset;
-	map->bdev = dev->bdev_handle->bdev;
+	map->bdev = F_BDEV(dev->f_bdev);
 	return true;
 }
 
@@ -236,26 +236,26 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	dev_t dev;
 
 	dev = bl_resolve_deviceid(server, v, gfp_mask);
 	if (!dev)
 		return -EIO;
 
-	bdev_handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+	f_bdev = bdev_file_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
 				       NULL, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(f_bdev)) {
 		printk(KERN_WARNING "pNFS: failed to open device %d:%d (%ld)\n",
-			MAJOR(dev), MINOR(dev), PTR_ERR(bdev_handle));
-		return PTR_ERR(bdev_handle);
+			MAJOR(dev), MINOR(dev), PTR_ERR(f_bdev));
+		return PTR_ERR(f_bdev);
 	}
-	d->bdev_handle = bdev_handle;
-	d->len = bdev_nr_bytes(bdev_handle->bdev);
+	d->f_bdev = f_bdev;
+	d->len = bdev_nr_bytes(F_BDEV(f_bdev));
 	d->map = bl_map_simple;
 
 	printk(KERN_INFO "pNFS: using block device %s\n",
-		bdev_handle->bdev->bd_disk->disk_name);
+		F_BDEV(f_bdev)->bd_disk->disk_name);
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
+	struct file *f_bdev;
 	const char *devname;
 
 	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/%s%*phN",
@@ -311,15 +311,15 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
-	bdev_handle = bdev_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
+	f_bdev = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
 					NULL, NULL);
-	if (IS_ERR(bdev_handle)) {
+	if (IS_ERR(f_bdev)) {
 		pr_warn("pNFS: failed to open device %s (%ld)\n",
-			devname, PTR_ERR(bdev_handle));
+			devname, PTR_ERR(f_bdev));
 	}
 
 	kfree(devname);
-	return bdev_handle;
+	return f_bdev;
 }
 
 static int
@@ -327,7 +327,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	const struct pr_ops *ops;
 	int error;
 
@@ -340,32 +340,32 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
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
+	f_bdev = bl_open_path(v, "dm-uuid-mpath-0x");
+	if (IS_ERR(f_bdev))
+		f_bdev = bl_open_path(v, "wwn-0x");
+	if (IS_ERR(f_bdev))
+		return PTR_ERR(f_bdev);
+	d->f_bdev = f_bdev;
+
+	d->len = bdev_nr_bytes(F_BDEV(d->f_bdev));
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
 	pr_info("pNFS: using block device %s (reservation key 0x%llx)\n",
-		d->bdev_handle->bdev->bd_disk->disk_name, d->pr_key);
+		F_BDEV(d->f_bdev)->bd_disk->disk_name, d->pr_key);
 
-	ops = d->bdev_handle->bdev->bd_disk->fops->pr_ops;
+	ops = F_BDEV(d->f_bdev)->bd_disk->fops->pr_ops;
 	if (!ops) {
 		pr_err("pNFS: block device %s does not support reservations.",
-				d->bdev_handle->bdev->bd_disk->disk_name);
+				F_BDEV(d->f_bdev)->bd_disk->disk_name);
 		error = -EINVAL;
 		goto out_blkdev_put;
 	}
 
-	error = ops->pr_register(d->bdev_handle->bdev, 0, d->pr_key, true);
+	error = ops->pr_register(F_BDEV(d->f_bdev), 0, d->pr_key, true);
 	if (error) {
 		pr_err("pNFS: failed to register key for block device %s.",
-				d->bdev_handle->bdev->bd_disk->disk_name);
+				F_BDEV(d->f_bdev)->bd_disk->disk_name);
 		goto out_blkdev_put;
 	}
 
@@ -373,7 +373,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	return 0;
 
 out_blkdev_put:
-	bdev_release(d->bdev_handle);
+	fput(d->f_bdev);
 	return error;
 }
 

-- 
2.42.0


