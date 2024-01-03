Return-Path: <linux-fsdevel+bounces-7209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6764822DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7584E285BAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB41C688;
	Wed,  3 Jan 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsvIqS88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C31C2B3;
	Wed,  3 Jan 2024 12:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6CCC433C8;
	Wed,  3 Jan 2024 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286587;
	bh=8qIsmshufKI60D0UjWvmcqCWK21AUsfl5fAH9rp0xZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jsvIqS88Eh0VWnK3xgOP45wbSmiSkS6wMejaNrgBNXxETSkCu9M+WMBo16riVozE2
	 R8cIZRB5mhyk7Nk251mDyOL7C4MetGxlDDh/DiKWLJOZW0/o4w/eMZP9b2Tn20iuNU
	 hM0k5cO7O1hFILMzf7atZYKhkhjua+p7LwoHHoDODDi7XB1pIj2NkSKFUu2Aic0ZDS
	 agoNQhR6qUoMGKXl6fjCdUULremzM/TabYjm5j/T/FA2vlEuEGMwKAnhIHPurG39eW
	 JSvehDpMzRxH3JHfAWdeVCiLeAYDfyjoyYz4C6hgnpst1RWJkpIRZiuHLBTMa8ooHU
	 1FM02h2xaAkgA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:26 +0100
Subject: [PATCH RFC 28/34] bdev: make bdev_release() private to block layer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-28-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8qIsmshufKI60D0UjWvmcqCWK21AUsfl5fAH9rp0xZU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbT9z/NL60D2Jeaiq37CZ8WvLwj9UO7RKmn5K/7m8
 pxrzxY0dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykz47hf4pAiP2Z+WrnLewF
 rn17qNGwcNOmhEOX7jm8f9HcybD3PwMjQ0O41rw9+3e8m3g+YFvn08tzNf94PzVLslrRk3tjWn0
 0My8A
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
index a5a1b6cd51ee..80caa71a65db 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -918,7 +918,6 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
index 08a358bc0919..3ec5e9b5c26c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -518,4 +518,8 @@ static inline int req_ref_read(struct request *req)
 	return atomic_read(&req->ref);
 }
 
+void bdev_release(struct bdev_handle *handle);
+struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+		const struct blk_holder_ops *hops);
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8864b978fdb0..2d06f02f6d5e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1504,8 +1504,6 @@ struct bdev_handle {
 	blk_mode_t mode;
 };
 
-struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
-		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
@@ -1513,7 +1511,6 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-void bdev_release(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);

-- 
2.42.0


