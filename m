Return-Path: <linux-fsdevel+bounces-14823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A86880240
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 17:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C21C23127
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7B82C67;
	Tue, 19 Mar 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d40QN5oh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3881AAA;
	Tue, 19 Mar 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865490; cv=none; b=e0C/5fpUr+G+tW65bACynT2e8aouudZMg5N/9WV8WdRmVo/MIUkzqqixrlat0bkye238AxZtxHh7RCAWl68Dn6kamew1amdO6ZjI86MQoer9Bg40nDlt1bRUCPAnWUPvjhfMUhXo8JIxMSf47lsOvRFe6ZaXPWVmUnhZnetSh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865490; c=relaxed/simple;
	bh=+uv663azIK1NMauzoCHkVkbY7WnTGOQ9YAA/Ri5eJg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kjbyw0ySHbwc2+LfyBaULQyuKOoMn9BqkF89yRTRtbFr8PlU5qhn4L5mxLQNb37YkyxmGhNfnKzXPYWIuiLPa3RDkv4fbBd7zqdHWALMDIaDZy8k5kAlw3pCRo7F13oQY56tc7069GxtffcZegAP9YqWbuHkvXAJ5Q4LOsy2v8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d40QN5oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2FEC433F1;
	Tue, 19 Mar 2024 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710865489;
	bh=+uv663azIK1NMauzoCHkVkbY7WnTGOQ9YAA/Ri5eJg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d40QN5ohLV72dPuF7RHC58nlRyFdxi+xFtXOD/ysllkJDBQ2wWLpEbS5vSFSslsTr
	 Icmwt3SdOV6aXSwxhSHo2geDjNCqpSjT6yRHks2HcL9MoosmMl6UlypoNigOk8jd0d
	 ha27yB+6fjKVU2ZJzTs8VjMs2e9uQOsK3VBEQ2uJxIP6WQZwJaC/vri3kzk6zAqH0c
	 kLjxb3N7jy30G/GxU/aR0BuoOOUCMRxfS6bHgXFrSaeGEDSFx1ke4qD4GMQsbABQhZ
	 XWGu698wHS3nG/RNLXP46/1epIfaijGMVhQWG/xiuGn+Rjny96aEw3ExghB/JAgDLO
	 fI5XnHc38a66A==
Date: Tue, 19 Mar 2024 17:24:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: remove holder ops
Message-ID: <20240319-klippe-kurzweilig-ae6a31a9ff31@brauner>
References: <20240314165814.tne3leyfmb4sqk2t@quack3>
 <20240315-freibad-annehmbar-ca68c375af91@brauner>
 <20240315142802.i3ja63b4b7l3akeb@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6fjadztwmbo3zgnc"
Content-Disposition: inline
In-Reply-To: <20240315142802.i3ja63b4b7l3akeb@quack3>


--6fjadztwmbo3zgnc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> > I ran blktests with nbd enabled which contains a reliable repro for the
> > issue. Thanks to Christoph for pointing in that direction. The
> > underlying issue is not reproducible anymore with this patch applied.
> > xfstests and blktests pass.
> 
> Thanks for the fix! It looks good to me. Feel free to add:

So Linus complained about the fact that we have holder ops when really
it currently isn't needed by anything apart from filesytems. And I think
that he's right and we should consider removing the holder ops and just
calling helpers directly. If there's users outside of filesystems we can
always reintroduce that. So I went ahead and drafted a patch series. I
think it ends up simplifying things and it ends up easier to follow and
we can handle lifetime of the superblock cleaner with relying on
callbacks. Appending the patch series here and pushed to
vfs.bdev.holder. Want to gauge your thoughts before sending it out.

https://gitlab.com/brauner/linux/-/commits/vfs.bdev.holder

--6fjadztwmbo3zgnc
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-RFC-block-add-bdev_fsopen.patch"

From 5a2a2d554a1ba069469ea3e58473a734a60b1f4d Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 19 Mar 2024 10:40:56 +0100
Subject: [PATCH 1/5] [RFC] block: add bdev_fsopen*()

Use a dedicated helper instead of open-coding bdev_file_open_by_*()
everywhere with NULL arguments apart from a few places. This is in
preparation of removing holder ops.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 12 ++++++++++++
 fs/ext4/super.c        |  4 +---
 fs/super.c             |  3 +--
 fs/xfs/xfs_super.c     |  4 ++--
 include/linux/blkdev.h |  3 +++
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e..48bf8ca8b161 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1012,6 +1012,18 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(bdev_file_open_by_path);
 
+struct file *bdev_fsopen(dev_t dev, blk_mode_t mode, struct super_block *sb)
+{
+	return bdev_file_open_by_dev(dev, mode, sb, &fs_holder_ops);
+}
+EXPORT_SYMBOL(bdev_fsopen);
+
+struct file *bdev_fsopen_path(const char *path, blk_mode_t mode, struct super_block *sb)
+{
+	return bdev_file_open_by_path(path, mode, sb, &fs_holder_ops);
+}
+EXPORT_SYMBOL(bdev_fsopen_path);
+
 void bdev_release(struct file *bdev_file)
 {
 	struct block_device *bdev = file_bdev(bdev_file);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cfb8449c731f..45bf4278a20a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5851,9 +5851,7 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 	struct ext4_super_block *es;
 	int errno;
 
-	bdev_file = bdev_file_open_by_dev(j_dev,
-		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
-		sb, &fs_holder_ops);
+	bdev_file = bdev_fsopen(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES, sb);
 	if (IS_ERR(bdev_file)) {
 		ext4_msg(sb, KERN_ERR,
 			 "failed to open journal device unknown-block(%u,%u) %ld",
diff --git a/fs/super.c b/fs/super.c
index 71d9779c42b1..71bfa4ffaa7d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1539,7 +1539,6 @@ const struct blk_holder_ops fs_holder_ops = {
 	.get_holder		= fs_bdev_super_get,
 	.put_holder		= fs_bdev_super_put,
 };
-EXPORT_SYMBOL_GPL(fs_holder_ops);
 
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
@@ -1548,7 +1547,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	struct file *bdev_file;
 	struct block_device *bdev;
 
-	bdev_file = bdev_file_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
+	bdev_file = bdev_fsopen(sb->s_dev, mode, sb);
 	if (IS_ERR(bdev_file)) {
 		if (fc)
 			errorf(fc, "%s: Can't open blockdev", fc->source);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c21f10ab0f5d..4c0d208d1d06 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -366,9 +366,9 @@ xfs_blkdev_get(
 {
 	int			error = 0;
 
-	*bdev_filep = bdev_file_open_by_path(name,
+	*bdev_filep = bdev_fsopen_path(name,
 		BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_RESTRICT_WRITES,
-		mp->m_super, &fs_holder_ops);
+		mp->m_super);
 	if (IS_ERR(*bdev_filep)) {
 		error = PTR_ERR(*bdev_filep);
 		*bdev_filep = NULL;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be..5aa2117812d1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1536,6 +1536,9 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
+struct file *bdev_fsopen(dev_t dev, blk_mode_t mode, struct super_block *sb);
+struct file *bdev_fsopen_path(const char *path, blk_mode_t mode,
+			      struct super_block *sb);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-- 
2.43.0


--6fjadztwmbo3zgnc
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-RFC-fs-block-remove-holder_ops-argument-_by_path.patch"

From e21591ed892657ab2b601f398b3273f93be035ce Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 19 Mar 2024 10:59:45 +0100
Subject: [PATCH 2/5] [RFC] fs,block: remove holder_ops argument *_by_path()

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c                        | 53 ++++++++++++++++++++++++-----
 drivers/block/drbd/drbd_nl.c        |  2 +-
 drivers/block/rnbd/rnbd-srv.c       |  2 +-
 drivers/md/bcache/super.c           |  2 +-
 drivers/mtd/devices/block2mtd.c     |  2 +-
 drivers/nvme/target/io-cmd-bdev.c   |  2 +-
 drivers/target/target_core_iblock.c |  3 +-
 drivers/target/target_core_pscsi.c  |  2 +-
 fs/bcachefs/super-io.c              |  7 ++--
 fs/btrfs/dev-replace.c              |  2 +-
 fs/btrfs/volumes.c                  |  6 ++--
 fs/erofs/super.c                    |  2 +-
 fs/f2fs/super.c                     |  2 +-
 fs/nfs/blocklayout/dev.c            |  2 +-
 fs/reiserfs/journal.c               |  2 +-
 include/linux/blkdev.h              |  8 ++++-
 16 files changed, 68 insertions(+), 31 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 48bf8ca8b161..230559fe098c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -952,8 +952,7 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
 	return flags;
 }
 
-struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-				   const struct blk_holder_ops *hops)
+static struct file *bdev_file_open(dev_t dev, blk_mode_t mode, void *holder)
 {
 	struct file *bdev_file;
 	struct block_device *bdev;
@@ -977,7 +976,10 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	}
 	ihold(bdev->bd_inode);
 
-	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
+	if (mode & BLK_OPEN_MOUNTED)
+		ret = bdev_open(bdev, mode, holder, &fs_holder_ops, bdev_file);
+	else
+		ret = bdev_open(bdev, mode, holder, NULL, bdev_file);
 	if (ret) {
 		/* We failed to open the block device. Let ->release() know. */
 		bdev_file->private_data = ERR_PTR(ret);
@@ -986,11 +988,19 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	}
 	return bdev_file;
 }
+
+struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+		const struct blk_holder_ops *hops)
+{
+	if (mode & ~BLK_OPEN_VALID_FLAGS)
+		return ERR_PTR(-EINVAL);
+
+	return bdev_file_open(dev, mode, holder);
+}
 EXPORT_SYMBOL(bdev_file_open_by_dev);
 
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
-				    void *holder,
-				    const struct blk_holder_ops *hops)
+				    void *holder)
 {
 	struct file *file;
 	dev_t dev;
@@ -1000,7 +1010,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 	if (error)
 		return ERR_PTR(error);
 
-	file = bdev_file_open_by_dev(dev, mode, holder, hops);
+	file = bdev_file_open_by_dev(dev, mode, holder, NULL);
 	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
 		if (bdev_read_only(file_bdev(file))) {
 			fput(file);
@@ -1014,13 +1024,38 @@ EXPORT_SYMBOL(bdev_file_open_by_path);
 
 struct file *bdev_fsopen(dev_t dev, blk_mode_t mode, struct super_block *sb)
 {
-	return bdev_file_open_by_dev(dev, mode, sb, &fs_holder_ops);
+	struct file *bdev_file;
+
+	if (WARN_ON_ONCE(!sb))
+		return ERR_PTR(-EINVAL);
+
+	bdev_file = bdev_file_open(dev, mode | BLK_OPEN_MOUNTED, sb);
+	if (!IS_ERR(bdev_file))
+		return bdev_file;
+	return bdev_file;
 }
 EXPORT_SYMBOL(bdev_fsopen);
 
-struct file *bdev_fsopen_path(const char *path, blk_mode_t mode, struct super_block *sb)
+struct file *bdev_fsopen_path(const char *path, blk_mode_t mode,
+			      struct super_block *sb)
 {
-	return bdev_file_open_by_path(path, mode, sb, &fs_holder_ops);
+	struct file *file;
+	dev_t dev;
+	int error;
+
+	error = lookup_bdev(path, &dev);
+	if (error)
+		return ERR_PTR(error);
+
+	file = bdev_fsopen(dev, mode, sb);
+	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
+		if (bdev_read_only(file_bdev(file))) {
+			fput(file);
+			file = ERR_PTR(-EACCES);
+		}
+	}
+
+	return file;
 }
 EXPORT_SYMBOL(bdev_fsopen_path);
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 5d65c9754d83..ffd4721190fd 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1634,7 +1634,7 @@ static struct file *open_backing_dev(struct drbd_device *device,
 	int err = 0;
 
 	file = bdev_file_open_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				      claim_ptr, NULL);
+				      claim_ptr);
 	if (IS_ERR(file)) {
 		drbd_err(device, "open(\"%s\") failed with %ld\n",
 				bdev_path, PTR_ERR(file));
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index f6e3a3c4b76c..cecd44e02945 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -716,7 +716,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
+	bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL);
 	if (IS_ERR(bdev_file)) {
 		ret = PTR_ERR(bdev_file);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %pe\n",
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 330bcd9ea4a9..f8e94ee2c012 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2550,7 +2550,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	ret = -EINVAL;
 	err = "failed to open device";
-	bdev_file = bdev_file_open_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
+	bdev_file = bdev_file_open_by_path(strim(path), BLK_OPEN_READ, NULL);
 	if (IS_ERR(bdev_file))
 		goto out_free_sb;
 
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 97a00ec9a4d4..2390b4010207 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -275,7 +275,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		return NULL;
 
 	/* Get a handle on the device */
-	bdev_file = bdev_file_open_by_path(devname, mode, dev, NULL);
+	bdev_file = bdev_file_open_by_path(devname, mode, dev);
 	if (IS_ERR(bdev_file))
 		bdev_file = mdtblock_early_get_bdev(devname, mode, timeout,
 						      dev);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 6426aac2634a..3fbc6f510952 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -86,7 +86,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 		return -ENOTBLK;
 
 	ns->bdev_file = bdev_file_open_by_path(ns->device_path,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL);
 	if (IS_ERR(ns->bdev_file)) {
 		ret = PTR_ERR(ns->bdev_file);
 		if (ret != -ENOTBLK) {
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 7f6ca8177845..4761b602441a 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -117,8 +117,7 @@ static int iblock_configure_device(struct se_device *dev)
 	else
 		dev->dev_flags |= DF_READ_ONLY;
 
-	bdev_file = bdev_file_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
-					NULL);
+	bdev_file = bdev_file_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev);
 	if (IS_ERR(bdev_file)) {
 		ret = PTR_ERR(bdev_file);
 		goto out_free_bioset;
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index f98ebb18666b..c198b547d609 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -367,7 +367,7 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
 	 */
 	bdev_file = bdev_file_open_by_path(dev->udev_path,
-				BLK_OPEN_WRITE | BLK_OPEN_READ, pdv, NULL);
+				BLK_OPEN_WRITE | BLK_OPEN_READ, pdv);
 	if (IS_ERR(bdev_file)) {
 		pr_err("pSCSI: bdev_open_by_path() failed\n");
 		scsi_device_put(sd);
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index bceac29f3d86..26c98e3a51c8 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -24,9 +24,6 @@
 #include <linux/backing-dev.h>
 #include <linux/sort.h>
 
-static const struct blk_holder_ops bch2_sb_handle_bdev_ops = {
-};
-
 struct bch2_metadata_version {
 	u16		version;
 	const char	*name;
@@ -712,13 +709,13 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
 	if (!opt_get(*opts, nochanges))
 		sb->mode |= BLK_OPEN_WRITE;
 
-	sb->s_bdev_file = bdev_file_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
+	sb->s_bdev_file = bdev_file_open_by_path(path, sb->mode, sb->holder);
 	if (IS_ERR(sb->s_bdev_file) &&
 	    PTR_ERR(sb->s_bdev_file) == -EACCES &&
 	    opt_get(*opts, read_only)) {
 		sb->mode &= ~BLK_OPEN_WRITE;
 
-		sb->s_bdev_file = bdev_file_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
+		sb->s_bdev_file = bdev_file_open_by_path(path, sb->mode, sb->holder);
 		if (!IS_ERR(sb->s_bdev_file))
 			opt_set(*opts, nochanges, true);
 	}
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 7696beec4c21..db1f819365ad 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -256,7 +256,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					fs_info->bdev_holder, NULL);
+					fs_info->bdev_holder);
 	if (IS_ERR(bdev_file)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
 		return PTR_ERR(bdev_file);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a2d07fa3cfdf..fa16296f7629 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -472,7 +472,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	struct block_device *bdev;
 	int ret;
 
-	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, NULL);
+	*bdev_file = bdev_file_open_by_path(device_path, flags, holder);
 
 	if (IS_ERR(*bdev_file)) {
 		ret = PTR_ERR(*bdev_file);
@@ -1341,7 +1341,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev_file = bdev_file_open_by_path(path, flags, NULL, NULL);
+	bdev_file = bdev_file_open_by_path(path, flags, NULL);
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
@@ -2597,7 +2597,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		return -EROFS;
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					fs_info->bdev_holder, NULL);
+					fs_info->bdev_holder);
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 69308fd73e4a..777d64ac2202 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -202,7 +202,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
 		bdev_file = bdev_file_open_by_path(dif->path, BLK_OPEN_READ,
-						sb->s_type, NULL);
+						sb->s_type);
 		if (IS_ERR(bdev_file))
 			return PTR_ERR(bdev_file);
 		dif->bdev_file = bdev_file;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a6867f26f141..c2e03744d9ee 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4204,7 +4204,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 						SEGS_TO_BLKS(sbi,
 						FDEV(i).total_segments) - 1;
 				FDEV(i).bdev_file = bdev_file_open_by_path(
-					FDEV(i).path, mode, sbi->sb, NULL);
+					FDEV(i).path, mode, sbi->sb);
 			}
 		}
 		if (IS_ERR(FDEV(i).bdev_file))
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 93ef7f864980..6ad005745ea0 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -312,7 +312,7 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 		return ERR_PTR(-ENOMEM);
 
 	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
-					NULL, NULL);
+					NULL);
 	if (IS_ERR(bdev_file)) {
 		pr_warn("pNFS: failed to open device %s (%ld)\n",
 			devname, PTR_ERR(bdev_file));
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 6474529c4253..adea6c49d698 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2633,7 +2633,7 @@ static int journal_init_dev(struct super_block *super,
 	}
 
 	journal->j_bdev_file = bdev_file_open_by_path(jdev_name, blkdev_mode,
-						   holder, NULL);
+						   holder);
 	if (IS_ERR(journal->j_bdev_file)) {
 		result = PTR_ERR(journal->j_bdev_file);
 		journal->j_bdev_file = NULL;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5aa2117812d1..2bbf9ddd0874 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -128,6 +128,12 @@ typedef unsigned int __bitwise blk_mode_t;
 #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
 /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
 #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
+/* open is for filesystem */
+#define BLK_OPEN_MOUNTED ((__force blk_mode_t)(1 << 6))
+
+#define BLK_OPEN_VALID_FLAGS                                                \
+	(BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_EXCL | BLK_OPEN_NDELAY | \
+	 BLK_OPEN_WRITE_IOCTL | BLK_OPEN_RESTRICT_WRITES)
 
 struct gendisk {
 	/*
@@ -1535,7 +1541,7 @@ extern const struct blk_holder_ops fs_holder_ops;
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops);
+		void *holder);
 struct file *bdev_fsopen(dev_t dev, blk_mode_t mode, struct super_block *sb);
 struct file *bdev_fsopen_path(const char *path, blk_mode_t mode,
 			      struct super_block *sb);
-- 
2.43.0


--6fjadztwmbo3zgnc
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0003-RFC-fs-block-remove-holder_ops-argument-from-_by_dev.patch"

From 232edeaf0d2abecb0b949bf8e106a4c81c094245 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 19 Mar 2024 11:02:19 +0100
Subject: [PATCH 3/5] [RFC] fs,block: remove holder_ops argument from
 *_by_dev()

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c                       | 5 ++---
 block/genhd.c                      | 2 +-
 block/ioctl.c                      | 2 +-
 drivers/block/pktcdvd.c            | 4 ++--
 drivers/block/xen-blkback/xenbus.c | 2 +-
 drivers/block/zram/zram_drv.c      | 2 +-
 drivers/md/bcache/super.c          | 2 +-
 drivers/md/dm.c                    | 2 +-
 drivers/md/md.c                    | 2 +-
 drivers/mtd/devices/block2mtd.c    | 2 +-
 drivers/s390/block/dasd_genhd.c    | 2 +-
 fs/jfs/jfs_logmgr.c                | 2 +-
 fs/nfs/blocklayout/dev.c           | 2 +-
 fs/ocfs2/cluster/heartbeat.c       | 2 +-
 fs/reiserfs/journal.c              | 2 +-
 include/linux/blkdev.h             | 3 +--
 kernel/power/swap.c                | 4 ++--
 mm/swapfile.c                      | 2 +-
 18 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 230559fe098c..7db603bcf560 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -989,8 +989,7 @@ static struct file *bdev_file_open(dev_t dev, blk_mode_t mode, void *holder)
 	return bdev_file;
 }
 
-struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops)
+struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder)
 {
 	if (mode & ~BLK_OPEN_VALID_FLAGS)
 		return ERR_PTR(-EINVAL);
@@ -1010,7 +1009,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 	if (error)
 		return ERR_PTR(error);
 
-	file = bdev_file_open_by_dev(dev, mode, holder, NULL);
+	file = bdev_file_open_by_dev(dev, mode, holder);
 	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
 		if (bdev_read_only(file_bdev(file))) {
 			fput(file);
diff --git a/block/genhd.c b/block/genhd.c
index bb29a68e1d67..513ad4318fe3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -367,7 +367,7 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	file = bdev_file_open_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL,
-				     NULL, NULL);
+				     NULL);
 	if (IS_ERR(file))
 		ret = PTR_ERR(file);
 	else
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaa..044980c7953b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -488,7 +488,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
-	file = bdev_file_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
+	file = bdev_file_open_by_dev(bdev->bd_dev, mode, &bdev);
 	if (IS_ERR(file))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 21728e9ea5c3..4804a299ee59 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2176,7 +2176,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	 * so open should not fail.
 	 */
 	bdev_file = bdev_file_open_by_dev(file_bdev(pd->bdev_file)->bd_dev,
-				       BLK_OPEN_READ, pd, NULL);
+				       BLK_OPEN_READ, pd);
 	if (IS_ERR(bdev_file)) {
 		ret = PTR_ERR(bdev_file);
 		goto out;
@@ -2512,7 +2512,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	}
 
 	bdev_file = bdev_file_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
-				       NULL, NULL);
+				       NULL);
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 	sdev = scsi_device_from_queue(file_bdev(bdev_file)->bd_disk->queue);
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 0621878940ae..0127790baa97 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -492,7 +492,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	vbd->pdevice  = MKDEV(major, minor);
 
 	bdev_file = bdev_file_open_by_dev(vbd->pdevice, vbd->readonly ?
-				 BLK_OPEN_READ : BLK_OPEN_WRITE, NULL, NULL);
+				 BLK_OPEN_READ : BLK_OPEN_WRITE, NULL);
 
 	if (IS_ERR(bdev_file)) {
 		pr_warn("xen_vbd_create: device %08x could not be opened\n",
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f0639df6cd18..16cf32b448e5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -514,7 +514,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	}
 
 	bdev_file = bdev_file_open_by_dev(inode->i_rdev,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
+				BLK_OPEN_READ | BLK_OPEN_WRITE, zram);
 	if (IS_ERR(bdev_file)) {
 		err = PTR_ERR(bdev_file);
 		bdev_file = NULL;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index f8e94ee2c012..d0248cefb064 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2571,7 +2571,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	/* Now reopen in exclusive mode with proper holder */
 	bdev_file2 = bdev_file_open_by_dev(file_bdev(bdev_file)->bd_dev,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, holder, NULL);
+			BLK_OPEN_READ | BLK_OPEN_WRITE, holder);
 	fput(bdev_file);
 	bdev_file = bdev_file2;
 	if (IS_ERR(bdev_file)) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56aa2a8b9d71..4a7231ba23cd 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -736,7 +736,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&td->count, 1);
 
-	bdev_file = bdev_file_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
+	bdev_file = bdev_file_open_by_dev(dev, mode, _dm_claim_ptr);
 	if (IS_ERR(bdev_file)) {
 		r = PTR_ERR(bdev_file);
 		goto out_free_td;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index e575e74aabf5..a15da59e7cac 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3780,7 +3780,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 
 	rdev->bdev_file = bdev_file_open_by_dev(newdev,
 			BLK_OPEN_READ | BLK_OPEN_WRITE,
-			super_format == -2 ? &claim_rdev : rdev, NULL);
+			super_format == -2 ? &claim_rdev : rdev);
 	if (IS_ERR(rdev->bdev_file)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 2390b4010207..851729a99eb2 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -249,7 +249,7 @@ static struct file __ref *mdtblock_early_get_bdev(const char *devname,
 		wait_for_device_probe();
 
 		if (!early_lookup_bdev(devname, &devt)) {
-			bdev_file = bdev_file_open_by_dev(devt, mode, dev, NULL);
+			bdev_file = bdev_file_open_by_dev(devt, mode, dev);
 			if (!IS_ERR(bdev_file))
 				break;
 		}
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 4533dd055ca8..723a9ebf591b 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -137,7 +137,7 @@ int dasd_scan_partitions(struct dasd_block *block)
 	int rc;
 
 	bdev_file = bdev_file_open_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
-				       NULL, NULL);
+				       NULL);
 	if (IS_ERR(bdev_file)) {
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 			      "scan partitions error, blkdev_get returned %ld",
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 73389c68e251..1ee57d6fd4d4 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1101,7 +1101,7 @@ int lmLogOpen(struct super_block *sb)
 	 */
 
 	bdev_file = bdev_file_open_by_dev(sbi->logdev,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, log, NULL);
+			BLK_OPEN_READ | BLK_OPEN_WRITE, log);
 	if (IS_ERR(bdev_file)) {
 		rc = PTR_ERR(bdev_file);
 		goto free;
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 6ad005745ea0..036939882edc 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -244,7 +244,7 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
 		return -EIO;
 
 	bdev_file = bdev_file_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				       NULL, NULL);
+				       NULL);
 	if (IS_ERR(bdev_file)) {
 		printk(KERN_WARNING "pNFS: failed to open device %d:%d (%ld)\n",
 			MAJOR(dev), MINOR(dev), PTR_ERR(bdev_file));
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 1bde1281d514..e0404fad7b00 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1796,7 +1796,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		goto out2;
 
 	reg->hr_bdev_file = bdev_file_open_by_dev(f.file->f_mapping->host->i_rdev,
-			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
+			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL);
 	if (IS_ERR(reg->hr_bdev_file)) {
 		ret = PTR_ERR(reg->hr_bdev_file);
 		reg->hr_bdev_file = NULL;
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index adea6c49d698..ef359e2f4755 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2617,7 +2617,7 @@ static int journal_init_dev(struct super_block *super,
 		if (jdev == super->s_dev)
 			holder = NULL;
 		journal->j_bdev_file = bdev_file_open_by_dev(jdev, blkdev_mode,
-							  holder, NULL);
+							  holder);
 		if (IS_ERR(journal->j_bdev_file)) {
 			result = PTR_ERR(journal->j_bdev_file);
 			journal->j_bdev_file = NULL;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2bbf9ddd0874..7d08afe09849 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1538,8 +1538,7 @@ extern const struct blk_holder_ops fs_holder_ops;
 	(BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
 	 (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
-struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
+struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 		void *holder);
 struct file *bdev_fsopen(dev_t dev, blk_mode_t mode, struct super_block *sb);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2db1..0ce027c66857 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -364,7 +364,7 @@ static int swsusp_swap_check(void)
 	root_swap = res;
 
 	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
-			BLK_OPEN_WRITE, NULL, NULL);
+			BLK_OPEN_WRITE, NULL);
 	if (IS_ERR(hib_resume_bdev_file))
 		return PTR_ERR(hib_resume_bdev_file);
 
@@ -1572,7 +1572,7 @@ int swsusp_check(bool exclusive)
 	int error;
 
 	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
-				BLK_OPEN_READ, holder, NULL);
+				BLK_OPEN_READ, holder);
 	if (!IS_ERR(hib_resume_bdev_file)) {
 		set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
 		clear_page(swsusp_header);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..d4f08b14a68d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2786,7 +2786,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 
 	if (S_ISBLK(inode->i_mode)) {
 		p->bdev_file = bdev_file_open_by_dev(inode->i_rdev,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
+				BLK_OPEN_READ | BLK_OPEN_WRITE, p);
 		if (IS_ERR(p->bdev_file)) {
 			error = PTR_ERR(p->bdev_file);
 			p->bdev_file = NULL;
-- 
2.43.0


--6fjadztwmbo3zgnc
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0004-RFC-fs-block-call-helpers-in-block-layer-directly.patch"

From bac19560ff52cf7140051ca8c477b6e1ba783f23 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 19 Mar 2024 11:27:28 +0100
Subject: [PATCH 4/5] [RFC] fs,block: call helpers in block layer directly

block: pass mode to bd_finish_claiming()

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c              | 34 +++++++++++++++++-----------------
 block/ioctl.c             |  5 +++--
 fs/internal.h             |  7 +++++++
 fs/super.c                | 12 ++++++------
 include/linux/blk_types.h |  1 +
 5 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7db603bcf560..6aed12b12bfa 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -241,8 +241,8 @@ int bdev_freeze(struct block_device *bdev)
 	}
 
 	mutex_lock(&bdev->bd_holder_lock);
-	if (bdev->bd_holder_ops && bdev->bd_holder_ops->freeze) {
-		error = bdev->bd_holder_ops->freeze(bdev);
+	if (bdev->bd_mounted) {
+		error = fs_bdev_freeze(bdev);
 		lockdep_assert_not_held(&bdev->bd_holder_lock);
 	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
@@ -284,8 +284,8 @@ int bdev_thaw(struct block_device *bdev)
 		goto out;
 
 	mutex_lock(&bdev->bd_holder_lock);
-	if (bdev->bd_holder_ops && bdev->bd_holder_ops->thaw) {
-		error = bdev->bd_holder_ops->thaw(bdev);
+	if (bdev->bd_mounted) {
+		error = fs_bdev_thaw(bdev);
 		lockdep_assert_not_held(&bdev->bd_holder_lock);
 	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
@@ -564,7 +564,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  * open by the holder and wake up all waiters for exclusive open to finish.
  */
 static void bd_finish_claiming(struct block_device *bdev, void *holder,
-		const struct blk_holder_ops *hops)
+		const struct blk_holder_ops *hops, blk_mode_t mode)
 {
 	struct block_device *whole = bdev_whole(bdev);
 
@@ -579,13 +579,12 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder,
 	bdev->bd_holders++;
 	mutex_lock(&bdev->bd_holder_lock);
 	bdev->bd_holder = holder;
+	if (mode & BLK_OPEN_MOUNTED)
+		bdev->bd_mounted = true;
 	bdev->bd_holder_ops = hops;
 	mutex_unlock(&bdev->bd_holder_lock);
 	bd_clear_claiming(whole, holder);
 	mutex_unlock(&bdev_lock);
-
-	if (hops && hops->get_holder)
-		hops->get_holder(holder);
 }
 
 /**
@@ -608,8 +607,7 @@ EXPORT_SYMBOL(bd_abort_claiming);
 static void bd_end_claim(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
-	const struct blk_holder_ops *hops = bdev->bd_holder_ops;
-	bool unblock = false;
+	bool unblock = false, mounted = false;
 
 	/*
 	 * Release a claim on the device.  The holder fields are protected with
@@ -619,10 +617,12 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 	WARN_ON_ONCE(bdev->bd_holder != holder);
 	WARN_ON_ONCE(--bdev->bd_holders < 0);
 	WARN_ON_ONCE(--whole->bd_holders < 0);
+	mounted = bdev->bd_mounted;
 	if (!bdev->bd_holders) {
 		mutex_lock(&bdev->bd_holder_lock);
 		bdev->bd_holder = NULL;
 		bdev->bd_holder_ops = NULL;
+		bdev->bd_mounted = false;
 		mutex_unlock(&bdev->bd_holder_lock);
 		if (bdev->bd_write_holder)
 			unblock = true;
@@ -631,8 +631,8 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		whole->bd_holder = NULL;
 	mutex_unlock(&bdev_lock);
 
-	if (hops && hops->put_holder)
-		hops->put_holder(holder);
+	if (mounted)
+		fs_bdev_super_put(holder);
 
 	/*
 	 * If this was the last claim, remove holder link and unblock evpoll if
@@ -883,7 +883,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		goto put_module;
 	bdev_claim_write_access(bdev, mode);
 	if (holder) {
-		bd_finish_claiming(bdev, holder, hops);
+		bd_finish_claiming(bdev, holder, hops, mode);
 
 		/*
 		 * Block event polling for write claims if requested.  Any write
@@ -1030,7 +1030,7 @@ struct file *bdev_fsopen(dev_t dev, blk_mode_t mode, struct super_block *sb)
 
 	bdev_file = bdev_file_open(dev, mode | BLK_OPEN_MOUNTED, sb);
 	if (!IS_ERR(bdev_file))
-		return bdev_file;
+		fs_bdev_super_get(sb);
 	return bdev_file;
 }
 EXPORT_SYMBOL(bdev_fsopen);
@@ -1158,9 +1158,9 @@ EXPORT_SYMBOL(lookup_bdev);
 void bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
 	mutex_lock(&bdev->bd_holder_lock);
-	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
-		bdev->bd_holder_ops->mark_dead(bdev, surprise);
-	else {
+	if (bdev->bd_mounted) {
+		fs_bdev_mark_dead(bdev, surprise);
+	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		sync_blockdev(bdev);
 	}
diff --git a/block/ioctl.c b/block/ioctl.c
index 044980c7953b..4f06b4566b35 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -11,6 +11,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/pr.h>
 #include <linux/uaccess.h>
+#include "../fs/internal.h"
 #include "blk.h"
 
 static int blkpg_do_ioctl(struct block_device *bdev,
@@ -376,8 +377,8 @@ static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 		return -EACCES;
 
 	mutex_lock(&bdev->bd_holder_lock);
-	if (bdev->bd_holder_ops && bdev->bd_holder_ops->sync)
-		bdev->bd_holder_ops->sync(bdev);
+	if (bdev->bd_mounted)
+		fs_bdev_sync(bdev);
 	else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		sync_blockdev(bdev);
diff --git a/fs/internal.h b/fs/internal.h
index 7ca738904e34..1d5875183b46 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -318,3 +318,10 @@ struct stashed_operations {
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
+
+int fs_bdev_freeze(struct block_device *bdev);
+int fs_bdev_thaw(struct block_device *bdev);
+void fs_bdev_mark_dead(struct block_device *bdev, bool surprise);
+void fs_bdev_sync(struct block_device *bdev);
+void fs_bdev_super_get(void *);
+void fs_bdev_super_put(void *);
diff --git a/fs/super.c b/fs/super.c
index 71bfa4ffaa7d..383b945b363d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1394,7 +1394,7 @@ static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
 	return sb;
 }
 
-static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
+void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
 	struct super_block *sb;
 
@@ -1412,7 +1412,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	super_unlock_shared(sb);
 }
 
-static void fs_bdev_sync(struct block_device *bdev)
+void fs_bdev_sync(struct block_device *bdev)
 {
 	struct super_block *sb;
 
@@ -1454,7 +1454,7 @@ static struct super_block *get_bdev_super(struct block_device *bdev)
  * Return: If the freeze was successful zero is returned. If the freeze
  *         failed a negative error code is returned.
  */
-static int fs_bdev_freeze(struct block_device *bdev)
+int fs_bdev_freeze(struct block_device *bdev)
 {
 	struct super_block *sb;
 	int error = 0;
@@ -1494,7 +1494,7 @@ static int fs_bdev_freeze(struct block_device *bdev)
  *         as it may have been frozen multiple times (kernel may hold a
  *         freeze or might be frozen from other block devices).
  */
-static int fs_bdev_thaw(struct block_device *bdev)
+int fs_bdev_thaw(struct block_device *bdev)
 {
 	struct super_block *sb;
 	int error;
@@ -1515,7 +1515,7 @@ static int fs_bdev_thaw(struct block_device *bdev)
 	return error;
 }
 
-static void fs_bdev_super_get(void *data)
+void fs_bdev_super_get(void *data)
 {
 	struct super_block *sb = data;
 
@@ -1524,7 +1524,7 @@ static void fs_bdev_super_get(void *data)
 	spin_unlock(&sb_lock);
 }
 
-static void fs_bdev_super_put(void *data)
+void fs_bdev_super_put(void *data)
 {
 	struct super_block *sb = data;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cb1526ec44b5..afcc58d04ce7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -57,6 +57,7 @@ struct block_device {
 	void *			bd_claiming;
 	void *			bd_holder;
 	const struct blk_holder_ops *bd_holder_ops;
+	bool			bd_mounted;
 	struct mutex		bd_holder_lock;
 	int			bd_holders;
 	struct kobject		*bd_holder_dir;
-- 
2.43.0


--6fjadztwmbo3zgnc
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0005-RFC-fs-block-remove-holder-ops.patch"

From 463ee9ed2668963f2edd2b4d7dcc4669c76c4e4b Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 19 Mar 2024 11:32:48 +0100
Subject: [PATCH 5/5] [RFC] fs,block: remove holder ops

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c              | 46 ++++++++++++---------------------------
 block/blk.h               |  2 +-
 block/fops.c              |  2 +-
 block/genhd.c             |  3 +--
 block/partitions/core.c   |  4 ++--
 drivers/block/loop.c      |  2 +-
 fs/internal.h             |  4 ++--
 fs/super.c                | 17 ++-------------
 include/linux/blk_types.h |  1 -
 include/linux/blkdev.h    | 39 +--------------------------------
 10 files changed, 25 insertions(+), 95 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 6aed12b12bfa..83705c80a9f7 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -111,7 +111,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 	 * under live filesystem.
 	 */
 	if (!(mode & BLK_OPEN_EXCL)) {
-		int err = bd_prepare_to_claim(bdev, truncate_bdev_range, NULL);
+		int err = bd_prepare_to_claim(bdev, truncate_bdev_range);
 		if (err)
 			goto invalidate;
 	}
@@ -462,31 +462,21 @@ long nr_blockdev_pages(void)
  * bd_may_claim - test whether a block device can be claimed
  * @bdev: block device of interest
  * @holder: holder trying to claim @bdev
- * @hops: holder ops
  *
  * Test whether @bdev can be claimed by @holder.
  *
  * RETURNS:
  * %true if @bdev can be claimed, %false otherwise.
  */
-static bool bd_may_claim(struct block_device *bdev, void *holder,
-		const struct blk_holder_ops *hops)
+static bool bd_may_claim(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
 
 	lockdep_assert_held(&bdev_lock);
 
-	if (bdev->bd_holder) {
-		/*
-		 * The same holder can always re-claim.
-		 */
-		if (bdev->bd_holder == holder) {
-			if (WARN_ON_ONCE(bdev->bd_holder_ops != hops))
-				return false;
-			return true;
-		}
-		return false;
-	}
+	/* The same holder can always re-claim. */
+	if (bdev->bd_holder)
+		return bdev->bd_holder == holder;
 
 	/*
 	 * If the whole devices holder is set to bd_may_claim, a partition on
@@ -502,7 +492,6 @@ static bool bd_may_claim(struct block_device *bdev, void *holder,
  * bd_prepare_to_claim - claim a block device
  * @bdev: block device of interest
  * @holder: holder trying to claim @bdev
- * @hops: holder ops.
  *
  * Claim @bdev.  This function fails if @bdev is already claimed by another
  * holder and waits if another claiming is in progress. return, the caller
@@ -511,8 +500,7 @@ static bool bd_may_claim(struct block_device *bdev, void *holder,
  * RETURNS:
  * 0 if @bdev can be claimed, -EBUSY otherwise.
  */
-int bd_prepare_to_claim(struct block_device *bdev, void *holder,
-		const struct blk_holder_ops *hops)
+int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
 
@@ -521,7 +509,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 retry:
 	mutex_lock(&bdev_lock);
 	/* if someone else claimed, fail */
-	if (!bd_may_claim(bdev, holder, hops)) {
+	if (!bd_may_claim(bdev, holder)) {
 		mutex_unlock(&bdev_lock);
 		return -EBUSY;
 	}
@@ -558,18 +546,16 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  * bd_finish_claiming - finish claiming of a block device
  * @bdev: block device of interest
  * @holder: holder that has claimed @bdev
- * @hops: block device holder operations
  *
  * Finish exclusive open of a block device. Mark the device as exlusively
  * open by the holder and wake up all waiters for exclusive open to finish.
  */
-static void bd_finish_claiming(struct block_device *bdev, void *holder,
-		const struct blk_holder_ops *hops, blk_mode_t mode)
+static void bd_finish_claiming(struct block_device *bdev, void *holder, blk_mode_t mode)
 {
 	struct block_device *whole = bdev_whole(bdev);
 
 	mutex_lock(&bdev_lock);
-	BUG_ON(!bd_may_claim(bdev, holder, hops));
+	BUG_ON(!bd_may_claim(bdev, holder));
 	/*
 	 * Note that for a whole device bd_holders will be incremented twice,
 	 * and bd_holder will be set to bd_may_claim before being set to holder
@@ -581,7 +567,6 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder,
 	bdev->bd_holder = holder;
 	if (mode & BLK_OPEN_MOUNTED)
 		bdev->bd_mounted = true;
-	bdev->bd_holder_ops = hops;
 	mutex_unlock(&bdev->bd_holder_lock);
 	bd_clear_claiming(whole, holder);
 	mutex_unlock(&bdev_lock);
@@ -621,7 +606,6 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 	if (!bdev->bd_holders) {
 		mutex_lock(&bdev->bd_holder_lock);
 		bdev->bd_holder = NULL;
-		bdev->bd_holder_ops = NULL;
 		bdev->bd_mounted = false;
 		mutex_unlock(&bdev->bd_holder_lock);
 		if (bdev->bd_write_holder)
@@ -633,7 +617,6 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 
 	if (mounted)
 		fs_bdev_super_put(holder);
-
 	/*
 	 * If this was the last claim, remove holder link and unblock evpoll if
 	 * it was a write holder.
@@ -835,7 +818,6 @@ static void bdev_yield_write_access(struct file *bdev_file)
  * @bdev: block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
- * @hops: holder operations
  * @bdev_file: file for the block device
  *
  * Open the block device. If @holder is not %NULL, the block device is opened
@@ -848,7 +830,7 @@ static void bdev_yield_write_access(struct file *bdev_file)
  * zero on success, -errno on failure.
  */
 int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
-	      const struct blk_holder_ops *hops, struct file *bdev_file)
+	      struct file *bdev_file)
 {
 	bool unblock_events = true;
 	struct gendisk *disk = bdev->bd_disk;
@@ -856,7 +838,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 
 	if (holder) {
 		mode |= BLK_OPEN_EXCL;
-		ret = bd_prepare_to_claim(bdev, holder, hops);
+		ret = bd_prepare_to_claim(bdev, holder);
 		if (ret)
 			return ret;
 	} else {
@@ -883,7 +865,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		goto put_module;
 	bdev_claim_write_access(bdev, mode);
 	if (holder) {
-		bd_finish_claiming(bdev, holder, hops, mode);
+		bd_finish_claiming(bdev, holder, mode);
 
 		/*
 		 * Block event polling for write claims if requested.  Any write
@@ -977,9 +959,9 @@ static struct file *bdev_file_open(dev_t dev, blk_mode_t mode, void *holder)
 	ihold(bdev->bd_inode);
 
 	if (mode & BLK_OPEN_MOUNTED)
-		ret = bdev_open(bdev, mode, holder, &fs_holder_ops, bdev_file);
+		ret = bdev_open(bdev, mode, holder, bdev_file);
 	else
-		ret = bdev_open(bdev, mode, holder, NULL, bdev_file);
+		ret = bdev_open(bdev, mode, holder, bdev_file);
 	if (ret) {
 		/* We failed to open the block device. Let ->release() know. */
 		bdev_file->private_data = ERR_PTR(ret);
diff --git a/block/blk.h b/block/blk.h
index 5cac4e29ae17..dca9c12e205e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -598,7 +598,7 @@ static inline void bio_issue_init(struct bio_issue *issue,
 
 void bdev_release(struct file *bdev_file);
 int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
-	      const struct blk_holder_ops *hops, struct file *bdev_file);
+	      struct file *bdev_file);
 int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
 
 #endif /* BLK_INTERNAL_H */
diff --git a/block/fops.c b/block/fops.c
index 679d9b752fe8..a04d7d3b4189 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -617,7 +617,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (!bdev)
 		return -ENXIO;
 
-	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
+	ret = bdev_open(bdev, mode, filp->private_data, filp);
 	if (ret)
 		blkdev_put_no_open(bdev);
 	return ret;
diff --git a/block/genhd.c b/block/genhd.c
index 513ad4318fe3..e6d64a226c86 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -359,8 +359,7 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	 * scanners.
 	 */
 	if (!(mode & BLK_OPEN_EXCL)) {
-		ret = bd_prepare_to_claim(disk->part0, disk_scan_partitions,
-					  NULL);
+		ret = bd_prepare_to_claim(disk->part0, disk_scan_partitions);
 		if (ret)
 			return ret;
 	}
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b11e88c82c8c..e229580891c3 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -462,10 +462,10 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 
 	/*
 	 * We verified that @part->bd_openers is zero above and so
-	 * @part->bd_holder{_ops} can't be set. And since we hold
+	 * @part->bd_mounted can't be set. And since we hold
 	 * @disk->open_mutex the device can't be claimed by anyone.
 	 *
-	 * So no need to call @part->bd_holder_ops->mark_dead() here.
+	 * So no need to call fs_bdev_mark_dead() here.
 	 * Just delete the partition and invalidate it.
 	 */
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fe..92728e728473 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1014,7 +1014,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & BLK_OPEN_EXCL)) {
-		error = bd_prepare_to_claim(bdev, loop_configure, NULL);
+		error = bd_prepare_to_claim(bdev, loop_configure);
 		if (error)
 			goto out_putf;
 	}
diff --git a/fs/internal.h b/fs/internal.h
index 1d5875183b46..48550b2987a9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -323,5 +323,5 @@ int fs_bdev_freeze(struct block_device *bdev);
 int fs_bdev_thaw(struct block_device *bdev);
 void fs_bdev_mark_dead(struct block_device *bdev, bool surprise);
 void fs_bdev_sync(struct block_device *bdev);
-void fs_bdev_super_get(void *);
-void fs_bdev_super_put(void *);
+void fs_bdev_super_get(struct super_block *sb);
+void fs_bdev_super_put(struct super_block *sb);
diff --git a/fs/super.c b/fs/super.c
index 383b945b363d..84932ff1dd35 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1515,31 +1515,18 @@ int fs_bdev_thaw(struct block_device *bdev)
 	return error;
 }
 
-void fs_bdev_super_get(void *data)
+void fs_bdev_super_get(struct super_block *sb)
 {
-	struct super_block *sb = data;
-
 	spin_lock(&sb_lock);
 	sb->s_count++;
 	spin_unlock(&sb_lock);
 }
 
-void fs_bdev_super_put(void *data)
+void fs_bdev_super_put(struct super_block *sb)
 {
-	struct super_block *sb = data;
-
 	put_super(sb);
 }
 
-const struct blk_holder_ops fs_holder_ops = {
-	.mark_dead		= fs_bdev_mark_dead,
-	.sync			= fs_bdev_sync,
-	.freeze			= fs_bdev_freeze,
-	.thaw			= fs_bdev_thaw,
-	.get_holder		= fs_bdev_super_get,
-	.put_holder		= fs_bdev_super_put,
-};
-
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index afcc58d04ce7..2ad9c0963830 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -56,7 +56,6 @@ struct block_device {
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	void *			bd_claiming;
 	void *			bd_holder;
-	const struct blk_holder_ops *bd_holder_ops;
 	bool			bd_mounted;
 	struct mutex		bd_holder_lock;
 	int			bd_holders;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7d08afe09849..c4040f703479 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1494,42 +1494,6 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 #define BLKDEV_MAJOR_MAX	0
 #endif
 
-struct blk_holder_ops {
-	void (*mark_dead)(struct block_device *bdev, bool surprise);
-
-	/*
-	 * Sync the file system mounted on the block device.
-	 */
-	void (*sync)(struct block_device *bdev);
-
-	/*
-	 * Freeze the file system mounted on the block device.
-	 */
-	int (*freeze)(struct block_device *bdev);
-
-	/*
-	 * Thaw the file system mounted on the block device.
-	 */
-	int (*thaw)(struct block_device *bdev);
-
-	/*
-	 * If needed, get a reference to the holder.
-	 */
-	void (*get_holder)(void *holder);
-
-	/*
-	 * Release the holder.
-	 */
-	void (*put_holder)(void *holder);
-};
-
-/*
- * For filesystems using @fs_holder_ops, the @holder argument passed to
- * helpers used to open and claim block devices via
- * bd_prepare_to_claim() must point to a superblock.
- */
-extern const struct blk_holder_ops fs_holder_ops;
-
 /*
  * Return the correct open flags for blkdev_get_by_* for super block flags
  * as stored in sb->s_flags.
@@ -1544,8 +1508,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 struct file *bdev_fsopen(dev_t dev, blk_mode_t mode, struct super_block *sb);
 struct file *bdev_fsopen_path(const char *path, blk_mode_t mode,
 			      struct super_block *sb);
-int bd_prepare_to_claim(struct block_device *bdev, void *holder,
-		const struct blk_holder_ops *hops);
+int bd_prepare_to_claim(struct block_device *bdev, void *holder);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
 
 /* just for blk-cgroup, don't use elsewhere */
-- 
2.43.0


--6fjadztwmbo3zgnc--

