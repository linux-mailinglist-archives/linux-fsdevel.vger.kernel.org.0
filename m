Return-Path: <linux-fsdevel+bounces-16286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A389AA05
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA361F21EB4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883033E49E;
	Sat,  6 Apr 2024 09:17:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6F376EB;
	Sat,  6 Apr 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395075; cv=none; b=R3IMJgO774jamWvP78bcnlfo8UMPCmjlef9YVz2Ii5DMKzT5mfANGFgmY7z89hzsu4WV4tB2VZPzF21uwsWXQeYqXm0U9xmlUTyFZ5ZE7UolkfcQysD7e7v+eCTz1+9EgBC7e7+SzyiKc+gm/lLJT3Ee29vkMgsirVwSns8GGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395075; c=relaxed/simple;
	bh=hNZfFgjhdajKdGO70rq9XI6mg40YgL8p68a393SI864=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7PIDYlMzOtxsrF/WkMGlfZOxg/ZuLuNwfXUIw6kDkZcj5Zym9M9Ret/kNwIhs+NAz7dvOnNoafvvTq1f1Zs68cmc4Px6s8cjCEzaGzIJ8nhKjtaL532G+btx7MfZ/R3uEkLlZ/hfwp76VkecXasP90kKGyDKPCfkdF600tUbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBK5Cv8z4f3k69;
	Sat,  6 Apr 2024 17:17:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0D5921A0C0C;
	Sat,  6 Apr 2024 17:17:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S23;
	Sat, 06 Apr 2024 17:17:49 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 19/26] dm-vdo: convert to use bdev_file
Date: Sat,  6 Apr 2024 17:09:23 +0800
Message-Id: <20240406090930.2252838-20-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S23
X-Coremail-Antispam: 1UD129KBjvAXoW3uFyfuFyfuryDWFW3WrWxWFg_yoW8WF48Wo
	WaqrZxWa18Jw4xJFWrJF97JF9xZa1DCw4rC3WrZFZ8Wa15ta15JFW7Jw15XF13tr10qFn8
	ZryxW3srtFWUJF4Dn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYu7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that dm upper layer already statsh the file of opened device in
'dm_dev->bdev_file', it's ok to get inode from the file.

There are no functional changes, prepare to remove 'bd_inode' from
block_device.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-vdo/dedupe.c                |  7 ++++---
 drivers/md/dm-vdo/dm-vdo-target.c         |  9 +++++++--
 drivers/md/dm-vdo/indexer/config.c        |  2 +-
 drivers/md/dm-vdo/indexer/config.h        |  4 ++--
 drivers/md/dm-vdo/indexer/index-layout.c  |  6 +++---
 drivers/md/dm-vdo/indexer/index-layout.h  |  2 +-
 drivers/md/dm-vdo/indexer/index-session.c | 18 ++++++++++--------
 drivers/md/dm-vdo/indexer/index.c         |  4 ++--
 drivers/md/dm-vdo/indexer/index.h         |  2 +-
 drivers/md/dm-vdo/indexer/indexer.h       |  6 +++---
 drivers/md/dm-vdo/indexer/io-factory.c    | 17 +++++++++--------
 drivers/md/dm-vdo/indexer/io-factory.h    |  4 ++--
 drivers/md/dm-vdo/indexer/volume.c        |  4 ++--
 drivers/md/dm-vdo/indexer/volume.h        |  2 +-
 drivers/md/dm-vdo/vdo.c                   |  2 +-
 15 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
index 117266e1b3ae..0e311989247e 100644
--- a/drivers/md/dm-vdo/dedupe.c
+++ b/drivers/md/dm-vdo/dedupe.c
@@ -2191,7 +2191,7 @@ static int initialize_index(struct vdo *vdo, struct hash_zones *zones)
 	uds_offset = ((vdo_get_index_region_start(geometry) -
 		       geometry.bio_offset) * VDO_BLOCK_SIZE);
 	zones->parameters = (struct uds_parameters) {
-		.bdev = vdo->device_config->owned_device->bdev,
+		.bdev_file = vdo->device_config->owned_device->bdev_file,
 		.offset = uds_offset,
 		.size = (vdo_get_index_region_size(geometry) * VDO_BLOCK_SIZE),
 		.memory_size = geometry.index_config.mem,
@@ -2582,8 +2582,9 @@ static void resume_index(void *context, struct vdo_completion *parent)
 	struct device_config *config = parent->vdo->device_config;
 	int result;
 
-	zones->parameters.bdev = config->owned_device->bdev;
-	result = uds_resume_index_session(zones->index_session, zones->parameters.bdev);
+	zones->parameters.bdev_file = config->owned_device->bdev_file;
+	result = uds_resume_index_session(zones->index_session,
+					  zones->parameters.bdev_file);
 	if (result != UDS_SUCCESS)
 		vdo_log_error_strerror(result, "Error resuming dedupe index");
 
diff --git a/drivers/md/dm-vdo/dm-vdo-target.c b/drivers/md/dm-vdo/dm-vdo-target.c
index 5a4b0a927f56..79e861c2887c 100644
--- a/drivers/md/dm-vdo/dm-vdo-target.c
+++ b/drivers/md/dm-vdo/dm-vdo-target.c
@@ -696,6 +696,11 @@ static void handle_parse_error(struct device_config *config, char **error_ptr,
 	*error_ptr = error_str;
 }
 
+static loff_t vdo_get_device_size(const struct device_config *config)
+{
+	return i_size_read(file_inode(config->owned_device->bdev_file));
+}
+
 /**
  * parse_device_config() - Convert the dmsetup table into a struct device_config.
  * @argc: The number of table values.
@@ -878,7 +883,7 @@ static int parse_device_config(int argc, char **argv, struct dm_target *ti,
 	}
 
 	if (config->version == 0) {
-		u64 device_size = i_size_read(config->owned_device->bdev->bd_inode);
+		u64 device_size = vdo_get_device_size(config);
 
 		config->physical_blocks = device_size / VDO_BLOCK_SIZE;
 	}
@@ -1011,7 +1016,7 @@ static void vdo_status(struct dm_target *ti, status_type_t status_type,
 
 static block_count_t __must_check get_underlying_device_block_count(const struct vdo *vdo)
 {
-	return i_size_read(vdo_get_backing_device(vdo)->bd_inode) / VDO_BLOCK_SIZE;
+	return vdo_get_device_size(vdo->device_config) / VDO_BLOCK_SIZE;
 }
 
 static int __must_check process_vdo_message_locked(struct vdo *vdo, unsigned int argc,
diff --git a/drivers/md/dm-vdo/indexer/config.c b/drivers/md/dm-vdo/indexer/config.c
index 5532371b952f..dcf0742a6145 100644
--- a/drivers/md/dm-vdo/indexer/config.c
+++ b/drivers/md/dm-vdo/indexer/config.c
@@ -344,7 +344,7 @@ int uds_make_configuration(const struct uds_parameters *params,
 	config->volume_index_mean_delta = DEFAULT_VOLUME_INDEX_MEAN_DELTA;
 	config->sparse_sample_rate = (params->sparse ? DEFAULT_SPARSE_SAMPLE_RATE : 0);
 	config->nonce = params->nonce;
-	config->bdev = params->bdev;
+	config->bdev_file = params->bdev_file;
 	config->offset = params->offset;
 	config->size = params->size;
 
diff --git a/drivers/md/dm-vdo/indexer/config.h b/drivers/md/dm-vdo/indexer/config.h
index 08507dc2f7a1..8ba0cf72dec9 100644
--- a/drivers/md/dm-vdo/indexer/config.h
+++ b/drivers/md/dm-vdo/indexer/config.h
@@ -25,8 +25,8 @@ enum {
 
 /* A set of configuration parameters for the indexer. */
 struct uds_configuration {
-	/* Storage device for the index */
-	struct block_device *bdev;
+	/* File of opened storage device for the index */
+	struct file *bdev_file;
 
 	/* The maximum allowable size of the index */
 	size_t size;
diff --git a/drivers/md/dm-vdo/indexer/index-layout.c b/drivers/md/dm-vdo/indexer/index-layout.c
index 627adc24af3b..32eee76bc246 100644
--- a/drivers/md/dm-vdo/indexer/index-layout.c
+++ b/drivers/md/dm-vdo/indexer/index-layout.c
@@ -1668,7 +1668,7 @@ static int create_layout_factory(struct index_layout *layout,
 	size_t writable_size;
 	struct io_factory *factory = NULL;
 
-	result = uds_make_io_factory(config->bdev, &factory);
+	result = uds_make_io_factory(config->bdev_file, &factory);
 	if (result != UDS_SUCCESS)
 		return result;
 
@@ -1741,9 +1741,9 @@ void uds_free_index_layout(struct index_layout *layout)
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
index e9ac6f4302d6..28f9be577631 100644
--- a/drivers/md/dm-vdo/indexer/index-layout.h
+++ b/drivers/md/dm-vdo/indexer/index-layout.h
@@ -24,7 +24,7 @@ int __must_check uds_make_index_layout(struct uds_configuration *config, bool ne
 void uds_free_index_layout(struct index_layout *layout);
 
 int __must_check uds_replace_index_layout_storage(struct index_layout *layout,
-						  struct block_device *bdev);
+						  struct file *bdev_file);
 
 int __must_check uds_load_index_state(struct index_layout *layout,
 				      struct uds_index *index);
diff --git a/drivers/md/dm-vdo/indexer/index-session.c b/drivers/md/dm-vdo/indexer/index-session.c
index aee0914d604a..914abf5e006b 100644
--- a/drivers/md/dm-vdo/indexer/index-session.c
+++ b/drivers/md/dm-vdo/indexer/index-session.c
@@ -335,7 +335,7 @@ int uds_open_index(enum uds_open_index_type open_type,
 		vdo_log_error("missing required parameters");
 		return -EINVAL;
 	}
-	if (parameters->bdev == NULL) {
+	if (parameters->bdev_file == NULL) {
 		vdo_log_error("missing required block device");
 		return -EINVAL;
 	}
@@ -349,7 +349,7 @@ int uds_open_index(enum uds_open_index_type open_type,
 		return uds_status_to_errno(result);
 
 	session->parameters = *parameters;
-	format_dev_t(name, parameters->bdev->bd_dev);
+	format_dev_t(name, file_bdev(parameters->bdev_file)->bd_dev);
 	vdo_log_info("%s: %s", get_open_type_string(open_type), name);
 
 	result = initialize_index_session(session, open_type);
@@ -460,15 +460,16 @@ int uds_suspend_index_session(struct uds_index_session *session, bool save)
 	return uds_status_to_errno(result);
 }
 
-static int replace_device(struct uds_index_session *session, struct block_device *bdev)
+static int replace_device(struct uds_index_session *session,
+			  struct file *bdev_file)
 {
 	int result;
 
-	result = uds_replace_index_storage(session->index, bdev);
+	result = uds_replace_index_storage(session->index, bdev_file);
 	if (result != UDS_SUCCESS)
 		return result;
 
-	session->parameters.bdev = bdev;
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
@@ -502,8 +503,9 @@ int uds_resume_index_session(struct uds_index_session *session,
 	if (no_work)
 		return result;
 
-	if ((session->index != NULL) && (bdev != session->parameters.bdev)) {
-		result = replace_device(session, bdev);
+	if (session->index != NULL &&
+	    bdev_file != session->parameters.bdev_file) {
+		result = replace_device(session, bdev_file);
 		if (result != UDS_SUCCESS) {
 			mutex_lock(&session->request_mutex);
 			session->state &= ~IS_FLAG_WAITING;
diff --git a/drivers/md/dm-vdo/indexer/index.c b/drivers/md/dm-vdo/indexer/index.c
index 1ba767144426..48b16275a067 100644
--- a/drivers/md/dm-vdo/indexer/index.c
+++ b/drivers/md/dm-vdo/indexer/index.c
@@ -1336,9 +1336,9 @@ int uds_save_index(struct uds_index *index)
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
index edabb239548e..6e2e203f43f7 100644
--- a/drivers/md/dm-vdo/indexer/index.h
+++ b/drivers/md/dm-vdo/indexer/index.h
@@ -72,7 +72,7 @@ int __must_check uds_save_index(struct uds_index *index);
 void uds_free_index(struct uds_index *index);
 
 int __must_check uds_replace_index_storage(struct uds_index *index,
-					   struct block_device *bdev);
+					   struct file *bdev_file);
 
 void uds_get_index_stats(struct uds_index *index, struct uds_index_stats *counters);
 
diff --git a/drivers/md/dm-vdo/indexer/indexer.h b/drivers/md/dm-vdo/indexer/indexer.h
index 3744aaf625b0..246ff2810e01 100644
--- a/drivers/md/dm-vdo/indexer/indexer.h
+++ b/drivers/md/dm-vdo/indexer/indexer.h
@@ -128,8 +128,8 @@ struct uds_volume_record {
 };
 
 struct uds_parameters {
-	/* The block_device used for storage */
-	struct block_device *bdev;
+	/* The bdev_file used for storage */
+	struct file *bdev_file;
 	/* The maximum allowable size of the index on storage */
 	size_t size;
 	/* The offset where the index should start */
@@ -314,7 +314,7 @@ int __must_check uds_suspend_index_session(struct uds_index_session *session, bo
  * start using the new backing store instead.
  */
 int __must_check uds_resume_index_session(struct uds_index_session *session,
-					  struct block_device *bdev);
+					  struct file *bdev_file);
 
 /* Wait until all outstanding index operations are complete. */
 int __must_check uds_flush_index_session(struct uds_index_session *session);
diff --git a/drivers/md/dm-vdo/indexer/io-factory.c b/drivers/md/dm-vdo/indexer/io-factory.c
index 515765d35794..f4dedb7b7f40 100644
--- a/drivers/md/dm-vdo/indexer/io-factory.c
+++ b/drivers/md/dm-vdo/indexer/io-factory.c
@@ -22,7 +22,7 @@
  * make helper structures that can be used to access sections of the index.
  */
 struct io_factory {
-	struct block_device *bdev;
+	struct file *bdev_file;
 	atomic_t ref_count;
 };
 
@@ -59,7 +59,7 @@ static void uds_get_io_factory(struct io_factory *factory)
 	atomic_inc(&factory->ref_count);
 }
 
-int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_ptr)
+int uds_make_io_factory(struct file *bdev_file, struct io_factory **factory_ptr)
 {
 	int result;
 	struct io_factory *factory;
@@ -68,16 +68,16 @@ int uds_make_io_factory(struct block_device *bdev, struct io_factory **factory_p
 	if (result != VDO_SUCCESS)
 		return result;
 
-	factory->bdev = bdev;
+	factory->bdev_file = bdev_file;
 	atomic_set_release(&factory->ref_count, 1);
 
 	*factory_ptr = factory;
 	return UDS_SUCCESS;
 }
 
-int uds_replace_storage(struct io_factory *factory, struct block_device *bdev)
+int uds_replace_storage(struct io_factory *factory, struct file *bdev_file)
 {
-	factory->bdev = bdev;
+	factory->bdev_file = bdev_file;
 	return UDS_SUCCESS;
 }
 
@@ -90,7 +90,7 @@ void uds_put_io_factory(struct io_factory *factory)
 
 size_t uds_get_writable_size(struct io_factory *factory)
 {
-	return i_size_read(factory->bdev->bd_inode);
+	return i_size_read(file_inode(factory->bdev_file));
 }
 
 /* Create a struct dm_bufio_client for an index region starting at offset. */
@@ -99,8 +99,9 @@ int uds_make_bufio(struct io_factory *factory, off_t block_offset, size_t block_
 {
 	struct dm_bufio_client *client;
 
-	client = dm_bufio_client_create(factory->bdev, block_size, reserved_buffers, 0,
-					NULL, NULL, 0);
+	client = dm_bufio_client_create(file_bdev(factory->bdev_file),
+					block_size, reserved_buffers,
+					0, NULL, NULL, 0);
 	if (IS_ERR(client))
 		return -PTR_ERR(client);
 
diff --git a/drivers/md/dm-vdo/indexer/io-factory.h b/drivers/md/dm-vdo/indexer/io-factory.h
index 7fb5a0616a79..a3ca84d62f2d 100644
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
index 655453bb276b..edbe46252657 100644
--- a/drivers/md/dm-vdo/indexer/volume.c
+++ b/drivers/md/dm-vdo/indexer/volume.c
@@ -1465,12 +1465,12 @@ int uds_find_volume_chapter_boundaries(struct volume *volume, u64 *lowest_vcn,
 
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
index 8679a5e55347..1dc3561b8b43 100644
--- a/drivers/md/dm-vdo/indexer/volume.h
+++ b/drivers/md/dm-vdo/indexer/volume.h
@@ -130,7 +130,7 @@ void uds_free_volume(struct volume *volume);
 
 int __must_check uds_replace_volume_storage(struct volume *volume,
 					    struct index_layout *layout,
-					    struct block_device *bdev);
+					    struct file *bdev_file);
 
 int __must_check uds_find_volume_chapter_boundaries(struct volume *volume,
 						    u64 *lowest_vcn, u64 *highest_vcn,
diff --git a/drivers/md/dm-vdo/vdo.c b/drivers/md/dm-vdo/vdo.c
index fff847767755..eca9f8b51535 100644
--- a/drivers/md/dm-vdo/vdo.c
+++ b/drivers/md/dm-vdo/vdo.c
@@ -809,7 +809,7 @@ void vdo_load_super_block(struct vdo *vdo, struct vdo_completion *parent)
  */
 struct block_device *vdo_get_backing_device(const struct vdo *vdo)
 {
-	return vdo->device_config->owned_device->bdev;
+	return file_bdev(vdo->device_config->owned_device->bdev_file);
 }
 
 /**
-- 
2.39.2


