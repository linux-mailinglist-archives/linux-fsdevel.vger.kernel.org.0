Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB14F778AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjHKKJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjHKKJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:09:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAF435AA;
        Fri, 11 Aug 2023 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=G5wFZqrNN2Zky0KlYoq/2FSZYr23+UpMaPMZmuKO/fg=; b=DSJg9AaoLRSDPfwDhpCRuzCfu6
        nOHA3s1SGXSJ3nmeelWIHN3XOBOkaunJdKly2KkRdkuMXeTxYABV9gdStlPZsPlc3c3lUxq8B4HLu
        jST/9KizR8cMMPIIkSDhnh5d0v/5IvJvK46PuMatmJ8JMrg0nLo2jqM2Tx+x09g6X3W152V1Pctya
        IOISTZkXLuibJspnpmF85zSND/RF7ez/xrO22U4jZBAmESYXcfmCaFDFWtMPJwuqDJQPXmluqSfjP
        EWEF6NM7+Cs9+wFmayF2TJFndksnAY629lPLXRwJ1hQqk6mCVjkMWzdm8kRv9K4ny+sMmjEr6ofKB
        mbEvi0rg==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4U-00A5ce-1n;
        Fri, 11 Aug 2023 10:08:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/17] btrfs: split btrfs_fs_devices.opened
Date:   Fri, 11 Aug 2023 12:08:15 +0200
Message-Id: <20230811100828.1897174-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The btrfs_fs_devices.opened member mixes an in use counter for the
fs_devices structure that prevents it from being garbage collected with
a flag if the underlying devices were actually opened.  This not only
makes the code hard to follow, but also prevents btrfs from switching
to opening the block device only after super block creation.  Split it
into an in_use counter and an is_open boolean flag instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 49 ++++++++++++++++++++++++++--------------------
 fs/btrfs/volumes.h |  6 ++++--
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8246578c70f55b..3ac1a3aa8939bc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -405,7 +405,8 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device;
 
-	WARN_ON(fs_devices->opened);
+	WARN_ON_ONCE(fs_devices->in_use);
+	WARN_ON_ONCE(fs_devices->is_open);
 	while (!list_empty(&fs_devices->devices)) {
 		device = list_entry(fs_devices->devices.next,
 				    struct btrfs_device, dev_list);
@@ -578,7 +579,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 				continue;
 			if (devt && devt != device->devt)
 				continue;
-			if (fs_devices->opened) {
+			if (fs_devices->in_use) {
 				/* for an already deleted device return 0 */
 				if (devt && ret != 0)
 					ret = -EBUSY;
@@ -849,7 +850,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	if (!device) {
 		unsigned int nofs_flag;
 
-		if (fs_devices->opened) {
+		if (fs_devices->in_use) {
 			btrfs_err(NULL,
 		"device %s belongs to fsid %pU, and the fs is already mounted",
 				  path, fs_devices->fsid);
@@ -913,7 +914,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (!fs_devices->in_use && found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
@@ -974,7 +975,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	 * it back. We need it to pick the disk with largest generation
 	 * (as above).
 	 */
-	if (!fs_devices->opened) {
+	if (!fs_devices->in_use) {
 		device->generation = found_transid;
 		fs_devices->latest_generation = max_t(u64, found_transid,
 						fs_devices->latest_generation);
@@ -1172,15 +1173,19 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (--fs_devices->opened > 0)
+	if (--fs_devices->in_use > 0)
 		return;
 
+	if (!fs_devices->is_open)
+		goto done;
+
 	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list)
 		btrfs_close_one_device(device);
 
 	WARN_ON(fs_devices->open_devices);
 	WARN_ON(fs_devices->rw_devices);
-	fs_devices->opened = 0;
+	fs_devices->is_open = false;
+done:
 	fs_devices->seeding = false;
 	fs_devices->fs_info = NULL;
 }
@@ -1192,7 +1197,7 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
 
 	mutex_lock(&uuid_mutex);
 	close_fs_devices(fs_devices);
-	if (!fs_devices->opened) {
+	if (!fs_devices->in_use) {
 		list_splice_init(&fs_devices->seed_list, &list);
 
 		/*
@@ -1240,7 +1245,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	if (fs_devices->open_devices == 0)
 		return -EINVAL;
 
-	fs_devices->opened = 1;
+	fs_devices->is_open = true;
 	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
@@ -1277,16 +1282,14 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	 * We also don't need the lock here as this is called during mount and
 	 * exclusion is provided by uuid_mutex
 	 */
-
-	if (fs_devices->opened) {
-		fs_devices->opened++;
-		ret = 0;
-	} else {
+	if (!fs_devices->is_open) {
 		list_sort(NULL, &fs_devices->devices, devid_cmp);
 		ret = open_fs_devices(fs_devices, flags, holder);
+		if (ret)
+			return ret;
 	}
-
-	return ret;
+	fs_devices->in_use++;
+	return 0;
 }
 
 void btrfs_release_disk_super(struct btrfs_super_block *super)
@@ -2242,13 +2245,14 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * This can happen if cur_devices is the private seed devices list.  We
 	 * cannot call close_fs_devices() here because it expects the uuid_mutex
 	 * to be held, but in fact we don't need that for the private
-	 * seed_devices, we can simply decrement cur_devices->opened and then
+	 * seed_devices, we can simply decrement cur_devices->in_use and then
 	 * remove it from our list and free the fs_devices.
 	 */
 	if (cur_devices->num_devices == 0) {
 		list_del_init(&cur_devices->seed_list);
-		ASSERT(cur_devices->opened == 1);
-		cur_devices->opened--;
+		ASSERT(cur_devices->in_use == 1);
+		cur_devices->in_use--;
+		cur_devices->is_open = false;
 		free_fs_devices(cur_devices);
 	}
 
@@ -2478,7 +2482,8 @@ static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 	list_add(&old_devices->fs_list, &fs_uuids);
 
 	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
-	seed_devices->opened = 1;
+	seed_devices->in_use = 1;
+	seed_devices->is_open = true;
 	INIT_LIST_HEAD(&seed_devices->devices);
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
@@ -6883,7 +6888,8 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 			return fs_devices;
 
 		fs_devices->seeding = true;
-		fs_devices->opened = 1;
+		fs_devices->in_use = 1;
+		fs_devices->is_open = true;
 		return fs_devices;
 	}
 
@@ -6900,6 +6906,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
 	}
+	fs_devices->in_use = 1;
 
 	if (!fs_devices->seeding) {
 		close_fs_devices(fs_devices);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 824161c6dd063e..f472d646715e72 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -346,8 +346,10 @@ struct btrfs_fs_devices {
 
 	struct list_head seed_list;
 
-	/* Count fs-devices opened. */
-	int opened;
+	/* Count if fs_device is in used. */
+	unsigned int in_use;
+	/* True if the devices were opened. */
+	bool is_open;
 
 	/* Set when we find or add a device that doesn't have the nonrot flag set. */
 	bool rotating;
-- 
2.39.2

