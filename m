Return-Path: <linux-fsdevel+bounces-1091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5E57D5476
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E2C281AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767231A6B;
	Tue, 24 Oct 2023 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oer0jVkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB530F8E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FD0C433CA;
	Tue, 24 Oct 2023 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159251;
	bh=zRcxpP10A5inJWak5dVvTMGjF9P0Illhvd9f0A8IowA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oer0jVkX/k/pp7cUbgyG0Qh2bZd4vYNuVTbByf67XTNrXETICZBaLN4883QX2EWTv
	 pCUbWjop3am19IcpdPHPwNIZgbpw7JSTPHWEkrrjHogI2fLZHM3oF2aX1GpUCFMmXM
	 2Jiw6y3fMcMDayZHTlYeJJtKA91COZAUmOgNXBGC7zwmoG2daioqsimw0xofhPk7LW
	 zuT3YID6Iz22wxRyC7WcQ1Kpycf5c+5vA45+2IgUdDsxVS/arZSmDLSAK978EvMgmJ
	 0fMyihlEk8ZxRoLiI0YIIKu0rexXM0oRnAfM9AKGigd6Xc24So91QPv35kW7ql5Cuh
	 jcYW5KztqQ43Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 16:53:43 +0200
Subject: [PATCH RFC 5/6] block: mark device as about to be released
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-rework-v1-5-37a8aa697148@kernel.org>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
In-Reply-To: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=2828; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zRcxpP10A5inJWak5dVvTMGjF9P0Illhvd9f0A8IowA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSa3+oKDctK+VZ8hVHL8ljgP8dMj5w/ne1cJ/UmHFi3vt4t
 UDOoo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLXljMynD1T2xJqKW/nG3D3a8h/kb
 k3VGp2ahYdLbFj1IjV9Tu+keF/isHs5Vd3sLL2LT55Q1NayO3OiX0z3yk3zEtkuhpiEPWDCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it possible for the exclusive holder of a block device to mark it
as about to be closed and exclusive ownership given up. Any concurrent
opener trying to claim the device with the same holder ops can wait
until the device is free to be reclaimed. Requiring the same holder ops
makes it possible to easily define groups of openers that can wait for
each other.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c              | 20 ++++++++++++++++++++
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    |  1 +
 3 files changed, 22 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 7d19e04a8df8..943c7a188bb3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -469,6 +469,11 @@ static bool bd_may_claim(struct block_device *bdev, void *holder,
 				return false;
 			return true;
 		}
+
+		if ((whole->bd_claim == BD_CLAIM_YIELD) &&
+		    (bdev->bd_holder_ops == hops))
+			return true;
+
 		return false;
 	}
 
@@ -608,6 +613,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		mutex_unlock(&bdev->bd_holder_lock);
 		if (bdev->bd_write_holder)
 			unblock = true;
+		bd_clear_claiming(whole);
 	}
 	if (!whole->bd_holders)
 		whole->bd_holder = NULL;
@@ -954,6 +960,20 @@ void bdev_release(struct bdev_handle *handle)
 }
 EXPORT_SYMBOL(bdev_release);
 
+void bdev_yield(struct bdev_handle *handle)
+{
+	struct block_device *bdev = handle->bdev;
+	struct block_device *whole = bdev_whole(bdev);
+
+	mutex_lock(&bdev_lock);
+	WARN_ON_ONCE(bdev->bd_holders == 0);
+	WARN_ON_ONCE(bdev->bd_holder != handle->holder);
+	WARN_ON_ONCE(whole->bd_claim);
+	whole->bd_claim = BD_CLAIM_YIELD;
+	mutex_unlock(&bdev_lock);
+}
+EXPORT_SYMBOL(bdev_yield);
+
 /**
  * lookup_bdev() - Look up a struct block_device by name.
  * @pathname: Name of the block device in the filesystem.
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cbef041fd868..54cf274a436c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -40,6 +40,7 @@ struct bio_crypt_ctx;
 enum bd_claim {
 	BD_CLAIM_DEFAULT = 0,
 	BD_CLAIM_ACQUIRE = 1,
+	BD_CLAIM_YIELD   = 2,
 };
 
 struct block_device {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index abf71cce785c..b15129afcdbe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1513,6 +1513,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 void bd_abort_claiming(struct block_device *bdev, void *holder);
 void blkdev_put(struct block_device *bdev, void *holder);
 void bdev_release(struct bdev_handle *handle);
+void bdev_yield(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);

-- 
2.34.1


