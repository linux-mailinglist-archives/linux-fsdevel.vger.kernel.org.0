Return-Path: <linux-fsdevel+bounces-8570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74742839019
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77381C27680
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F92612DF;
	Tue, 23 Jan 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBVbRSdv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585B612CE;
	Tue, 23 Jan 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016479; cv=none; b=DMJmZI1J3mSCxsCX4XIh675oxxGbB52vb4v3xtAwjBSQ7L6J4tIxdCJuEbSKeUm8bchg8tbiem2+5V96pRo8jhLMSha3VZh05hihKrP6hX8AO+U5SvWg2GbFMXkXDskhrZlvFVlaitOQsJRHbOTLaoYxV1XVdXBmVHJxiH/dDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016479; c=relaxed/simple;
	bh=2rC41k7//KAxGmKF7zftixpfq9AdqGXiECBRI/DISeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llPjexs8IAWDev1DbEza5826geY89/QNdW15+Ep9O2wt9HMiX58Z9JeIJoGQ4z+84l7c6ihRzYC2Y23U7X8+Wd1x7sDqghIui4n9eXBODRpsW6tml/JsciFv0A3GpuVT3dQeOkmhLtUDTYGFOKUF9tPjAvXm6gCiPpZnKJwnWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBVbRSdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D8BC43141;
	Tue, 23 Jan 2024 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016479;
	bh=2rC41k7//KAxGmKF7zftixpfq9AdqGXiECBRI/DISeE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FBVbRSdvu0irasB9zzaeU1lDdrPJ5NrCoe2kDk7c3GVnVJzlVud/iG1XpPXnzzwVI
	 7AFX25tLAnU3qTEq0LbD7MG6wvrT1MpQ6p0Im7V3baJ2u+FiKIy4G0DnpaDgpSPPBh
	 V4KZHn5vCfxSq8aUUcs3RNSAc/29ElRX08njWY/fR56zNGWqCuc6LVid8kJjGYst6t
	 rNqzRoZcEljXgWXtMOuUnF5vwp/wp+BHgPFFAPVL4nJMH5oFEfU+V2ygxldzGUVN2K
	 RnzqSj0JhDhAxqTJ28/7kiF6TmI/95E6tCUrzaGsboJo4JwGQqHCwtLL7R08hbUUqN
	 zv4kJQofTLBDA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:42 +0100
Subject: [PATCH v2 25/34] ocfs2: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-25-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=3776; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2rC41k7//KAxGmKF7zftixpfq9AdqGXiECBRI/DISeE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37fAZK9YvMTcn3/2SzydvPtp460fAof2TzjQKVf3k
 WVNzcdbFh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATMclkZLi+ObKhXq5L9UVZ
 48+Lk5RDlrQd4TFftED68fJd87QXzapjZHiyXsNi4ZXbrJsW6M/esvO9zYPX+pvfruvxnbb0vsw
 O9u+MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ocfs2/cluster/heartbeat.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 4d7efefa98c5..1bde1281d514 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -213,7 +213,7 @@ struct o2hb_region {
 	unsigned int		hr_num_pages;
 
 	struct page             **hr_slot_data;
-	struct bdev_handle	*hr_bdev_handle;
+	struct file		*hr_bdev_file;
 	struct o2hb_disk_slot	*hr_slots;
 
 	/* live node map of this region */
@@ -263,7 +263,7 @@ struct o2hb_region {
 
 static inline struct block_device *reg_bdev(struct o2hb_region *reg)
 {
-	return reg->hr_bdev_handle ? reg->hr_bdev_handle->bdev : NULL;
+	return reg->hr_bdev_file ? file_bdev(reg->hr_bdev_file) : NULL;
 }
 
 struct o2hb_bio_wait_ctxt {
@@ -1509,8 +1509,8 @@ static void o2hb_region_release(struct config_item *item)
 		kfree(reg->hr_slot_data);
 	}
 
-	if (reg->hr_bdev_handle)
-		bdev_release(reg->hr_bdev_handle);
+	if (reg->hr_bdev_file)
+		fput(reg->hr_bdev_file);
 
 	kfree(reg->hr_slots);
 
@@ -1569,7 +1569,7 @@ static ssize_t o2hb_region_block_bytes_store(struct config_item *item,
 	unsigned long block_bytes;
 	unsigned int block_bits;
 
-	if (reg->hr_bdev_handle)
+	if (reg->hr_bdev_file)
 		return -EINVAL;
 
 	status = o2hb_read_block_input(reg, page, &block_bytes,
@@ -1598,7 +1598,7 @@ static ssize_t o2hb_region_start_block_store(struct config_item *item,
 	char *p = (char *)page;
 	ssize_t ret;
 
-	if (reg->hr_bdev_handle)
+	if (reg->hr_bdev_file)
 		return -EINVAL;
 
 	ret = kstrtoull(p, 0, &tmp);
@@ -1623,7 +1623,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	unsigned long tmp;
 	char *p = (char *)page;
 
-	if (reg->hr_bdev_handle)
+	if (reg->hr_bdev_file)
 		return -EINVAL;
 
 	tmp = simple_strtoul(p, &p, 0);
@@ -1642,7 +1642,7 @@ static ssize_t o2hb_region_dev_show(struct config_item *item, char *page)
 {
 	unsigned int ret = 0;
 
-	if (to_o2hb_region(item)->hr_bdev_handle)
+	if (to_o2hb_region(item)->hr_bdev_file)
 		ret = sprintf(page, "%pg\n", reg_bdev(to_o2hb_region(item)));
 
 	return ret;
@@ -1753,7 +1753,7 @@ static int o2hb_populate_slot_data(struct o2hb_region *reg)
 }
 
 /*
- * this is acting as commit; we set up all of hr_bdev_handle and hr_task or
+ * this is acting as commit; we set up all of hr_bdev_file and hr_task or
  * nothing
  */
 static ssize_t o2hb_region_dev_store(struct config_item *item,
@@ -1769,7 +1769,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 	int live_threshold;
 
-	if (reg->hr_bdev_handle)
+	if (reg->hr_bdev_file)
 		goto out;
 
 	/* We can't heartbeat without having had our node number
@@ -1795,11 +1795,11 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	if (!S_ISBLK(f.file->f_mapping->host->i_mode))
 		goto out2;
 
-	reg->hr_bdev_handle = bdev_open_by_dev(f.file->f_mapping->host->i_rdev,
+	reg->hr_bdev_file = bdev_file_open_by_dev(f.file->f_mapping->host->i_rdev,
 			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
-	if (IS_ERR(reg->hr_bdev_handle)) {
-		ret = PTR_ERR(reg->hr_bdev_handle);
-		reg->hr_bdev_handle = NULL;
+	if (IS_ERR(reg->hr_bdev_file)) {
+		ret = PTR_ERR(reg->hr_bdev_file);
+		reg->hr_bdev_file = NULL;
 		goto out2;
 	}
 
@@ -1903,8 +1903,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 
 out3:
 	if (ret < 0) {
-		bdev_release(reg->hr_bdev_handle);
-		reg->hr_bdev_handle = NULL;
+		fput(reg->hr_bdev_file);
+		reg->hr_bdev_file = NULL;
 	}
 out2:
 	fdput(f);

-- 
2.43.0


