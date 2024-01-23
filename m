Return-Path: <linux-fsdevel+bounces-8573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BE839022
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D001F242E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C486612EB;
	Tue, 23 Jan 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf2FzrLg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B26024F;
	Tue, 23 Jan 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016486; cv=none; b=Qf+oESQBi6Zwg7ke2BNjMvk5RFd8mhAtza3n5xFGAdhMzHKUZxRKI0a+aN3mvhqwuCf8Y8T7Cw0bUZLSKcBgruupH8m3ZpP5NStRBXdAxwWFnH/q668GU+oTJKci8u3pWruIFfwQBQ169Y5sCeCwR4Grzsy95VpPcdHBbTqoOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016486; c=relaxed/simple;
	bh=4v+FS2J4YO/hah8YBEWWIbav6AYj2QPklIhHH86pgKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLdGghSMjF+odYguV5xhehzZ2mi9dQkYEbBoyBa3j0jfwIOXKtKSoYNaVlIBX1c+Crw3tYhb8f/frpS2Z5HlmF5lxSXqwRolHMNuoweXdAq9HX9DNRkSUuzJItwN11tC4yOdQLZxkTuVRrar2sWhNaPyL2tvJLhD3voajF5Hah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf2FzrLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985EBC32782;
	Tue, 23 Jan 2024 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016486;
	bh=4v+FS2J4YO/hah8YBEWWIbav6AYj2QPklIhHH86pgKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rf2FzrLgpiinCCTW0fJnyicEqWrsJr3WZqR72m83p8c/3hBnxnz0a7Bo8DIUsvi9e
	 cYsWiruQpuivyYW9gNynzFnRo3sywcSfLo9MHF1X7y4zYyyqPJR3kGKRAnLsNHE3rH
	 8N/w/+SDO1fcci/b5iQPGKsXJUXEZwkRbuoWkcd117bvqHaZkenEulNrkNSb4BBybi
	 Nh+YhRymOCstMTz7Rc9Im03OzsT/3VEwSl+EfWalv8c3RETVUbHIc+159w1YBXla3p
	 vox6CC7TLB+TX1WlUYx7tcMVu3avxuVAqOf5H6uOfdYmUBBO+xog3wRAsIsjBKFgX4
	 nXRE3JgeVvKLg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:45 +0100
Subject: [PATCH v2 28/34] bdev: make bdev_release() private to block layer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-28-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4v+FS2J4YO/hah8YBEWWIbav6AYj2QPklIhHH86pgKI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu37fwdYBinZ1Owf0Hf3Md+auiul3mLMtndLVS/Rhb9
 nvPx4S9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxkmL4X5f/oC1w+1WXlDtG
 Ey8EWD7TKjN3L5q55OTlfcYBTP2Ke4Aq5PQVPDdWzHyie25L38c3xTw7VTsLI+Tb3d5d0tEoy+A
 DAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and move both of them to the private block header. There's no caller in
the tree anymore that uses them directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 2 --
 block/blk.h            | 4 ++++
 include/linux/blkdev.h | 3 ---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index eb5607af6ec5..1f64f213c5fa 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -916,7 +916,6 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	kfree(handle);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(bdev_open_by_dev);
 
 static unsigned blk_to_file_flags(blk_mode_t mode)
 {
@@ -1045,7 +1044,6 @@ void bdev_release(struct bdev_handle *handle)
 	blkdev_put_no_open(bdev);
 	kfree(handle);
 }
-EXPORT_SYMBOL(bdev_release);
 
 /**
  * lookup_bdev() - Look up a struct block_device by name.
diff --git a/block/blk.h b/block/blk.h
index 1ef920f72e0f..c9630774767d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -516,4 +516,8 @@ static inline int req_ref_read(struct request *req)
 	return atomic_read(&req->ref);
 }
 
+void bdev_release(struct bdev_handle *handle);
+struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+		const struct blk_holder_ops *hops);
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5880d5abfebe..495f55587207 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1482,8 +1482,6 @@ struct bdev_handle {
 	blk_mode_t mode;
 };
 
-struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
@@ -1491,7 +1489,6 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-void bdev_release(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);

-- 
2.43.0


