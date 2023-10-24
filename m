Return-Path: <linux-fsdevel+bounces-1031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E5E7D50F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E949281C63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D3E29437;
	Tue, 24 Oct 2023 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+a0k5qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FABA29429
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC24C433CA;
	Tue, 24 Oct 2023 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152777;
	bh=WFm2ZXpOXnQSHZ4vtEzrtFrRM4tT4/LzuHBZCyjYdVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j+a0k5qju3jFMPZVId4TKWjo6/VBMxuAxr0VyJSavzmKmrvxjFLMfv5Gm93omZx49
	 zr/XF9zuArAEIefs5WZNd4ZiqY8GV0F1s3n1yxGrv+mxk1krPKAf8MdeVqhEVCDXLI
	 7+qvLQxSHdIu5TmB2enEtVTZVgCOGdaBja6JyoM+caT+DKwBiNMCbphT87Ipz6zin8
	 RB6v4yxcNJy36y60pWYEpjdAdU5ud9HP7JQAKIcxq5DH0lMZ9+Viw3DZXaOd86QYa9
	 /TXbwTNR2j3bwE6jqr/G7NN/lnEnBHAb+fe+MONArmKZfsBwFyY4pcN8h4G68GOoo7
	 c1bSz+nPp9iuA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:10 +0200
Subject: [PATCH v2 04/10] bdev: add freeze and thaw holder operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-4-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WFm2ZXpOXnQSHZ4vtEzrtFrRM4tT4/LzuHBZCyjYdVw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3S47hkwQyVu6ZL9gep5b5hMXwmc3PNh449nq3uD/Xc/
 teqr6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIwVOMDGerjSzjdMRlDO95X4v/lr
 babd7C7PpDy7fNaX7Hdapu+SOGv/Jz3SfxSy9PbjR6bnS1u4ZdcbPMkRfZf/KXtZU/8otbxQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add block device freeze and thaw holder operations. Follow-up patches
will implement block device freeze and thaw based on stuct
blk_holder_ops.

Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-2-ecc36d9ab4d9@kernel.org
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7a3da7f44afb..1bc776335ff8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1468,6 +1468,16 @@ struct blk_holder_ops {
 	 * Sync the file system mounted on the block device.
 	 */
 	void (*sync)(struct block_device *bdev);
+
+	/*
+	 * Freeze the file system mounted on the block device.
+	 */
+	int (*freeze)(struct block_device *bdev);
+
+	/*
+	 * Thaw the file system mounted on the block device.
+	 */
+	int (*thaw)(struct block_device *bdev);
 };
 
 extern const struct blk_holder_ops fs_holder_ops;

-- 
2.34.1


