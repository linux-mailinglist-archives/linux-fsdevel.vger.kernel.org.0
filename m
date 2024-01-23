Return-Path: <linux-fsdevel+bounces-8560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B1839006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B3C1C283F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0165F868;
	Tue, 23 Jan 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+0KvN75"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727A5F861;
	Tue, 23 Jan 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016455; cv=none; b=sM5T9IvwknTCNZEWaeXcDgjAmbhp4W6OBT+CqexoEM+/lhLO6B8BD+gUvpHmLuAcljjQT+dkHaEDea8yGE2G3THFhVWNkUonmWLYkCuEd9x2tw6d+Z67OldZzWsvjCmoxtg+eUR5W160l2NahOEuddc+rqo1TV27gDuEEZvpwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016455; c=relaxed/simple;
	bh=35n4YOych6JNHegijbzxMyBcyHsw6fkGA7wAjH5r/Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuL9fyxY/uAmM5FlwIzGvhrkf4vwI4N9R7i8rpYZSccm9ofHJo1kwgjSDcB/sGTxjLsB/BA5UjzcgnRSyBEtYD+ITDDPCSFaz6YK7BT6bTFKdZrYXV9R4pmYms5mQ8dq6QrqU8OlrSsaoXixQJa+yPyN8BmihzvfvOoaHTjNl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+0KvN75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA4EC43394;
	Tue, 23 Jan 2024 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016455;
	bh=35n4YOych6JNHegijbzxMyBcyHsw6fkGA7wAjH5r/Nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i+0KvN75upBWW407U8yDcNqC22HDMEbTjhI4bD++6JP2Xh8xW0NMGvQLXreaX7ipX
	 HzrLSWGvpqURyNEABEgsYKRpmdk80TTN6PCGndMkl8jDwO2NhmA+QbWbYsBx7o4RjD
	 BypThVRaUg4DAFaLz/B2SG5DAha4wUCXJHp78bU7sZUSPtLn6qkXmfJIkQsefMYX+r
	 exytsHcKT4mpKKABe3JVn/OgSjgusig5VkmPAl/b/MkymvSU68qpOC12/TukMLL7+1
	 9PimO4lmrUSYb0CDmmqwVdDK+5M5LEZv5BTAmLZA2xVl8L0rq1jqaUJiTxgg5vM2xk
	 d20hqyHw79oNA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:32 +0100
Subject: [PATCH v2 15/34] nvme: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-15-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=brauner@kernel.org;
 h=from:subject:message-id; bh=35n4YOych6JNHegijbzxMyBcyHsw6fkGA7wAjH5r/Nc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zc/dEXE8rZKif15XfbZ064utrVL4UgQvOwdUMNqs
 1hWJJyvo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJqCxj+V/xdnfyH+W6m74mz
 Yqo3qpk2/NyoX9B66eWSGTfkVzRYeDAyXN/AILEw7kN4f5n+OgO+G9NktqyfuFw7T9PiAd/GKZv
 fswMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 16 ++++++++--------
 drivers/nvme/target/nvmet.h       |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f11400a908f2..6426aac2634a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -50,10 +50,10 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
-	if (ns->bdev_handle) {
-		bdev_release(ns->bdev_handle);
+	if (ns->bdev_file) {
+		fput(ns->bdev_file);
 		ns->bdev = NULL;
-		ns->bdev_handle = NULL;
+		ns->bdev_file = NULL;
 	}
 }
 
@@ -85,18 +85,18 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (ns->buffered_io)
 		return -ENOTBLK;
 
-	ns->bdev_handle = bdev_open_by_path(ns->device_path,
+	ns->bdev_file = bdev_file_open_by_path(ns->device_path,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(ns->bdev_handle)) {
-		ret = PTR_ERR(ns->bdev_handle);
+	if (IS_ERR(ns->bdev_file)) {
+		ret = PTR_ERR(ns->bdev_file);
 		if (ret != -ENOTBLK) {
 			pr_err("failed to open block device %s: (%d)\n",
 					ns->device_path, ret);
 		}
-		ns->bdev_handle = NULL;
+		ns->bdev_file = NULL;
 		return ret;
 	}
-	ns->bdev = ns->bdev_handle->bdev;
+	ns->bdev = file_bdev(ns->bdev_file);
 	ns->size = bdev_nr_bytes(ns->bdev);
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..33e61b4f478b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -58,7 +58,7 @@
 
 struct nvmet_ns {
 	struct percpu_ref	ref;
-	struct bdev_handle	*bdev_handle;
+	struct file		*bdev_file;
 	struct block_device	*bdev;
 	struct file		*file;
 	bool			readonly;

-- 
2.43.0


