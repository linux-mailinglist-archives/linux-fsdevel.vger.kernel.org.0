Return-Path: <linux-fsdevel+bounces-12472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F985F8CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5651C24BC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E911487FB;
	Thu, 22 Feb 2024 12:51:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3913665A;
	Thu, 22 Feb 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606305; cv=none; b=NgM9Mz5HjpykBK3MACPv+kS+RuXfXFCdsSL892II4Jq0dB0ywL288bmDqBUaOF1PqGzyD8/dWjPXoXI5hgnNi38bf+HFVy2jclZRHN3BWbwEdVcsiQ6DmNvWX+yk+0JcCq0xnmtl1JwNhxbGc9QYg259X/yc7Z9tP/JSNudNp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606305; c=relaxed/simple;
	bh=CLtmZhg2HrGY6QQ0Xzvw7SHJdwS2EoBr0wF73ADVRJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vc0HURy10xGWyqzkHrn05LdVNSVTPinNec1o2bV8H1TWeJirgQLKpKox9BKLd3u1W4xfmoSW8P9jmTYbLr2fg4ncahOGD/pHujxkQH/MfJTw0uLlNSQfE7Jm8fw5Vl6OzD1ZGvF6/R8jpavtjxKAFUHV209C6nBjKzOgEU8E7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgY1L6mXbz4f3kFc;
	Thu, 22 Feb 2024 20:51:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F2B331A0283;
	Thu, 22 Feb 2024 20:51:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S21;
	Thu, 22 Feb 2024 20:51:39 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [RFC v4 linux-next 17/19] dm-vdo: prevent direct access of bd_inode
Date: Thu, 22 Feb 2024 20:45:53 +0800
Message-Id: <20240222124555.2049140-18-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S21
X-Coremail-Antispam: 1UD129KBjvAXoW3uFykGF4Dur1fuw1DXF47urg_yoW8Gr4xJo
	WaqrW3Wa18Ja1kJFWrJF97JFy3Za1DAw4rC3WrZFZ09a15ta15JFW7Jw15XF13tr10qFn8
	ZryxG34DtFWUJF4Dn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	OBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that dm upper layer already statsh the file of opened device in
'dm_dev->bdev_file', it's ok to get inode from the file.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-vdo/dedupe.c                |  3 ++-
 drivers/md/dm-vdo/dm-vdo-target.c         |  5 +++--
 drivers/md/dm-vdo/indexer/config.c        |  1 +
 drivers/md/dm-vdo/indexer/config.h        |  3 +++
 drivers/md/dm-vdo/indexer/index-layout.c  |  6 +++---
 drivers/md/dm-vdo/indexer/index-layout.h  |  2 +-
 drivers/md/dm-vdo/indexer/index-session.c | 13 +++++++------
 drivers/md/dm-vdo/indexer/index.c         |  4 ++--
 drivers/md/dm-vdo/indexer/index.h         |  2 +-
 drivers/md/dm-vdo/indexer/indexer.h       |  4 +++-
 drivers/md/dm-vdo/indexer/io-factory.c    | 13 ++++++++-----
 drivers/md/dm-vdo/indexer/io-factory.h    |  4 ++--
 drivers/md/dm-vdo/indexer/volume.c        |  4 ++--
 drivers/md/dm-vdo/indexer/volume.h        |  2 +-
 14 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
index a9b189395592..532294a15174 100644
--- a/drivers/md/dm-vdo/dedupe.c
+++ b/drivers/md/dm-vdo/dedupe.c
@@ -2592,7 +2592,8 @@ static void resume_index(void *context, struct vdo_completion *parent)
 	int result;
 
 	zones->parameters.bdev = config->owned_device->bdev;
-	result = uds_resume_index_session(zones->index_session, zones->parameters.bdev);
+	zones->parameters.bdev_file = config->owned_device->bdev_file;
+	result = uds_resume_index_session(zones->index_session, zones->parameters.bdev_file);
 	if (result != UDS_SUCCESS)
 		vdo_log_error_strerror(result, "Error resuming dedupe index");
 
diff --git a/drivers/md/dm-vdo/dm-vdo-target.c b/drivers/md/dm-vdo/dm-vdo-target.c
index 89d00be9f075..b2d7f68e70be 100644
--- a/drivers/md/dm-vdo/dm-vdo-target.c
+++ b/drivers/md/dm-vdo/dm-vdo-target.c
@@ -883,7 +883,7 @@ static int parse_device_config(int argc, char **argv, struct dm_target *ti,
 	}
 
 	if (config->version == 0) {
-		u64 device_size = i_size_read(config->owned_device->bdev->bd_inode);
+		u64 device_size = i_size_read(file_inode(config->owned_device->bdev_file));
 
 		config->physical_blocks = device_size / VDO_BLOCK_SIZE;
 	}
@@ -1018,7 +1018,8 @@ static void vdo_status(struct dm_target *ti, status_type_t status_type,
 
 static block_count_t __must_check get_underlying_device_block_count(const struct vdo *vdo)
 {
-	return i_size_read(vdo_get_backing_device(vdo)->bd_inode) / VDO_BLOCK_SIZE;
+	return i_size_read(file_inode(vdo->device_config->owned_device->bdev_file)) /
+		VDO_BLOCK_SIZE;
 }
 
 static int __must_check process_vdo_message_locked(struct vdo *vdo, unsigned int argc,
diff --git a/drivers/md/dm-vdo/indexer/config.c b/drivers/md/dm-vdo/indexer/config.c
index 260993ce1944..f1f66e232b54 100644
--- a/drivers/md/dm-vdo/indexer/config.c
+++ b/drivers/md/dm-vdo/indexer/config.c
@@ -347,6 +347,7 @@ int uds_make_configuration(const struct uds_parameters *params,
 	config->sparse_sample_rate = (params->sparse ? DEFAULT_SPARSE_SAMPLE_RATE : 0);
 	config->nonce = params->nonce;
 	config->bdev = params->bdev;
+	config->bdev_file = params->bdev_file;
 	config->offset = params->offset;
 	config->size = params->size;
 
diff --git a/drivers/md/dm-vdo/indexer/config.h b/drivers/md/dm-vdo/indexer/config.h
index fe7958263ed6..688f7450183e 100644
--- a/drivers/md/dm-vdo/indexer/config.h
+++ b/drivers/md/dm-vdo/indexer/config.h
@@ -28,6 +28,9 @@ struct uds_configuration {
 	/* Storage device for the index */
 	struct block_device *bdev;
 
+	/* Opened device fot the index */
+	struct file *bdev_file;
+
 	/* The maximum allowable size of the index */
 	size_t size;
 
diff --git a/drivers/md/dm-vdo/indexer/index-layout.c b/drivers/md/dm-vdo/indexer/index-layout.c
index 1453fddaa656..6dd80a432fe5 100644
--- a/drivers/md/dm-vdo/indexer/index-layout.c
+++ b/drivers/md/dm-vdo/indexer/index-layout.c
@@ -1672,7 +1672,7 @@ static int create_layout_factory(struct index_layout *layout,
 	size_t writable_size;
 	struct io_factory *factory = NULL;
 
-	result = uds_make_io_factory(config->bdev, &factory);
+	result = uds_make_io_factory(config->bdev_file, &factory);
 	if (result != UDS_SUCCESS)
 		return result;
 
@@ -1745,9 +1745,9 @@ void vdo_free_index_layout(struct index_layout *layout)
 }
 
 int uds_replace_index_layout_storage(struct index_layout *layout,
-				     struct block_device *bdev)
+				     struct file *bdev_file)
 {
-	return uds_replace_storage(layout->factory, bdev);
+	return uds_replace_storage(layout->factory, bdev_file);
 }
 
 /* Obtain a dm_bufio_client for the volume region. */
diff --git a/drivers/md/dm-vdo/indexer/index-layout.h b/drivers/md/dm-vdo/indexer/index-layout.h
index bd9b90c84a70..9b0c850fe9a7 100644
--- a/drivers/md/dm-vdo/indexer/index-layout.h
+++ b/drivers/md/dm-vdo/indexer/index-layout.h
@@ -24,7 +24,7 @@ int __must_check uds_make_index_layout(struct uds_configuration *config, bool ne
 void vdo_free_index_layout(struct index_layout *layout);
 
 int __must_check uds_replace_index_layout_storage(struct index_layout *layout,
-						  struct block_device *bdev);
+						  struct file *bdev_file);
 
 int __must_check uds_load_index_state(struct index_layout *layout,
 				      struct uds_index *index);
diff --git a/drivers/md/dm-vdo/indexer/index-session.c b/drivers/md/dm-vdo/indexer/index-session.c
index 1949a2598656..df8f8122a22d 100644
--- a/drivers/md/dm-vdo/indexer/index-session.c
+++ b/drivers/md/dm-vdo/indexer/index-session.c
@@ -460,15 +460,16 @@ int uds_suspend_index_session(struct uds_index_session *session, bool save)
 	return uds_status_to_errno(result);
 }
 
-static int replace_device(struct uds_index_session *session, struct block_device *bdev)
+static int replace_device(struct uds_index_session *session, struct file *bdev_file)
 {
 	int result;
 
-	result = uds_replace_index_storage(session->index, bdev);
+	result = uds_replace_index_storage(session->index, bdev_file);
 	if (result != UDS_SUCCESS)
 		return result;
 
-	session->parameters.bdev = bdev;
+	session->parameters.bdev = file_bdev(bdev_file);
+	session->parameters.bdev_file = bdev_file;
 	return UDS_SUCCESS;
 }
 
@@ -477,7 +478,7 @@ static int replace_device(struct uds_index_session *session, struct block_device
  * device differs from the current backing store, the index will start using the new backing store.
  */
 int uds_resume_index_session(struct uds_index_session *session,
-			     struct block_device *bdev)
+			     struct file *bdev_file)
 {
 	int result = UDS_SUCCESS;
 	bool no_work = false;
@@ -502,8 +503,8 @@ int uds_resume_index_session(struct uds_index_session *session,
 	if (no_work)
 		return result;
 
-	if ((session->index != NULL) && (bdev != session->parameters.bdev)) {
-		result = replace_device(session, bdev);
+	if ((session->index != NULL) && (bdev_file != session->parameters.bdev_file)) {
+		result = replace_device(session, bdev_file);
 		if (result != UDS_SUCCESS) {
 			mutex_lock(&session->request_mutex);
 			session->state &= ~IS_FLAG_WAITING;
diff --git a/drivers/md/dm-vdo/indexer/index.c b/drivers/md/dm-vdo/indexer/index.c
index bd2405738c50..3600a169ca98 100644
--- a/drivers/md/dm-vdo/indexer/index.c
+++ b/drivers/md/dm-vdo/indexer/index.c
@@ -1334,9 +1334,9 @@ int uds_save_index(struct uds_index *index)
 	return result;
 }
 
-int uds_replace_index_storage(struct uds_index *index, struct block_device *bdev)
+int uds_replace_index_storage(struct uds_index *index, struct file *bdev_file)
 {
-	return uds_replace_volume_storage(index->volume, index->layout, bdev);
+	return uds_replace_volume_storage(index->volume, index->layout, bdev_file);
 }
 
 /* Accessing statistics should be safe from any thread. */
diff --git a/drivers/md/dm-vdo/indexer/index.h b/drivers/md/dm-vdo/indexer/index.h
index 7fbc63db4131..9428ee025cda 100644
--- a/drivers/md/dm-vdo/indexer/index.h
+++ b/drivers/md/dm-vdo/indexer/index.h
@@ -72,7 +72,7 @@ int __must_check uds_save_index(struct uds_index *index);
 void vdo_free_index(struct uds_index *index);
 
 int __must_check uds_replace_index_storage(struct uds_index *index,
-					   struct block_device *bdev);
+					   struct file *bdev_file);
 
 void uds_get_index_stats(struct uds_index *index, struct uds_index_stats *counters);
 
diff --git a/drivers/md/dm-vdo/indexer/indexer.h b/drivers/md/dm-vdo/indexer/indexer.h
index a832a34d9436..5dd2c93f12c2 100644
--- a/drivers/md/dm-vdo/indexer/indexer.h
+++ b/drivers/md/dm-vdo/indexer/indexer.h
@@ -130,6 +130,8 @@ struct uds_volume_record {
 struct uds_parameters {
 	/* The block_device used for storage */
 	struct block_device *bdev;
+	/* Then opened block_device */
+	struct file *bdev_file;
 	/* The maximum allowable size of the index on storage */
 	size_t size;
 	/* The offset where the index should start */
@@ -314,7 +316,7 @@ int __must_check uds_suspend_index_session(struct uds_index_session *session, bo
  * start using the new backing store instead.
  */
 int __must_check uds_resume_index_session(struct uds_index_session *session,
-					  struct block_device *bdev);
+					  struct file *bdev_file);
 
 /* Wait until all outstanding index operations are complete. */
 int __must_check uds_flush_index_session(struct uds_index_session *session);
diff --git a/drivers/md/dm-vdo/indexer/io-factory.c b/drivers/md/dm-vdo/indexer/io-factory.c
index 61104d5ccd61..a855c3ac73bc 100644
--- a/drivers/md/dm-vdo/indexer/io-factory.c
+++ b/drivers/md/dm-vdo/indexer/io-factory.c
@@ -23,6 +23,7 @@
  */
 struct io_factory {
 	struct block_device *bdev;
+	struct file *bdev_file;
 	atomic_t ref_count;
 };
 
@@ -59,7 +60,7 @@ static void uds_get_io_factory(struct io_factory *factory)
 	atomic_inc(&factory->ref_count);
 }
 
-int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_ptr)
+int uds_make_io_factory(struct file *bdev_file, struct io_factory **factory_ptr)
 {
 	int result;
 	struct io_factory *factory;
@@ -68,16 +69,18 @@ int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_p
 	if (result != VDO_SUCCESS)
 		return result;
 
-	factory->bdev = bdev;
+	factory->bdev = file_bdev(bdev_file);
+	factory->bdev_file = bdev_file;
 	atomic_set_release(&factory->ref_count, 1);
 
 	*factory_ptr = factory;
 	return UDS_SUCCESS;
 }
 
-int uds_replace_storage(struct io_factory *factory, struct block_device *bdev)
+int uds_replace_storage(struct io_factory *factory, struct file *bdev_file)
 {
-	factory->bdev = bdev;
+	factory->bdev = file_bdev(bdev_file);
+	factory->bdev_file = bdev_file;
 	return UDS_SUCCESS;
 }
 
@@ -90,7 +93,7 @@ void uds_put_io_factory(struct io_factory *factory)
 
 size_t uds_get_writable_size(struct io_factory *factory)
 {
-	return i_size_read(factory->bdev->bd_inode);
+	return i_size_read(file_inode(factory->bdev_file));
 }
 
 /* Create a struct dm_bufio_client for an index region starting at offset. */
diff --git a/drivers/md/dm-vdo/indexer/io-factory.h b/drivers/md/dm-vdo/indexer/io-factory.h
index 60749a9ff756..e5100ab57754 100644
--- a/drivers/md/dm-vdo/indexer/io-factory.h
+++ b/drivers/md/dm-vdo/indexer/io-factory.h
@@ -24,11 +24,11 @@ enum {
 	SECTORS_PER_BLOCK = UDS_BLOCK_SIZE >> SECTOR_SHIFT,
 };
 
-int __must_check uds_make_io_factory(struct block_device *bdev,
+int __must_check uds_make_io_factory(struct file *bdev_file,
 				     struct io_factory **factory_ptr);
 
 int __must_check uds_replace_storage(struct io_factory *factory,
-				     struct block_device *bdev);
+				     struct file *bdev_file);
 
 void uds_put_io_factory(struct io_factory *factory);
 
diff --git a/drivers/md/dm-vdo/indexer/volume.c b/drivers/md/dm-vdo/indexer/volume.c
index 8b21ec93f3bc..a292840a83e3 100644
--- a/drivers/md/dm-vdo/indexer/volume.c
+++ b/drivers/md/dm-vdo/indexer/volume.c
@@ -1467,12 +1467,12 @@ int uds_find_volume_chapter_boundaries(struct volume *volume, u64 *lowest_vcn,
 
 int __must_check uds_replace_volume_storage(struct volume *volume,
 					    struct index_layout *layout,
-					    struct block_device *bdev)
+					    struct file *bdev_file)
 {
 	int result;
 	u32 i;
 
-	result = uds_replace_index_layout_storage(layout, bdev);
+	result = uds_replace_index_layout_storage(layout, bdev_file);
 	if (result != UDS_SUCCESS)
 		return result;
 
diff --git a/drivers/md/dm-vdo/indexer/volume.h b/drivers/md/dm-vdo/indexer/volume.h
index 7fdd44464db2..5861654d837e 100644
--- a/drivers/md/dm-vdo/indexer/volume.h
+++ b/drivers/md/dm-vdo/indexer/volume.h
@@ -131,7 +131,7 @@ void vdo_free_volume(struct volume *volume);
 
 int __must_check uds_replace_volume_storage(struct volume *volume,
 					    struct index_layout *layout,
-					    struct block_device *bdev);
+					    struct file *bdev_file);
 
 int __must_check uds_find_volume_chapter_boundaries(struct volume *volume,
 						    u64 *lowest_vcn, u64 *highest_vcn,
-- 
2.39.2


