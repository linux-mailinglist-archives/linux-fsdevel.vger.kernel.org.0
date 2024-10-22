Return-Path: <linux-fsdevel+bounces-32559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C069A96B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1187285AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754BC1C7B83;
	Tue, 22 Oct 2024 03:13:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2B1494D8;
	Tue, 22 Oct 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566784; cv=none; b=CMcP0xUkL2PuEDiLi8VuKhXPrsb99eVrT5ZduHEx7vYpyAaSEahAmE8FP3vpQUJ+zYq9tMW5lQfqzAaqRpXbi1NwNZm8PLqFIO9+0G77XnGBlThwbNlVs/mlC1Wat3DBowNB21qZ7xU+PxszWHGu2o6vWEvDmIa+kzjhZ331X6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566784; c=relaxed/simple;
	bh=JtRQRisxrHnV8IY4GtAev6/mcJf6zvVRjOwlQ8nLm5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Awj37Oi5zY/OASHTDzf8+f16e6tda/sPAmb58o8TYUKp7bL/i9MZQMB8C8w7ZiyP+zyZpzjUIhtboN5GzKOnF7oxzDitlK1Vn8EEf7GrEg1ZLdzPBYLyPJBwnpT3xDfMO7t/ZD0TSm1jleL6tNgY11qxaA3cCUwPImk1ZVe4eCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgM0yXXz4f3jkk;
	Tue, 22 Oct 2024 11:12:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 64E721A018C;
	Tue, 22 Oct 2024 11:12:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S20;
	Tue, 22 Oct 2024 11:12:59 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 16/27] ext4: don't order data for inode with EXT4_STATE_BUFFERED_IOMAP
Date: Tue, 22 Oct 2024 19:10:47 +0800
Message-ID: <20241022111059.2566137-17-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S20
X-Coremail-Antispam: 1UD129KBjvdXoWrtr48GFy3AF4rGF4fCryfJFb_yoWkGrc_Ga
	s7Ar48K34SvF1xWFWFkr15Xas29r48Wr1rWFZ5tr4fuFyUJrs7Aw1kZrsrZry5Wr42kF9x
	Cry8Gr1rt3W2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbQAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
	A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
	M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2I
	x0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRio7uDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In the iomap buffered I/O path, there is no risk of exposing stale data
because we always allocate unwritten extents for new allocated blocks,
the extent changes to written only when the I/O is completed. Therefore,
we do not need to order data in this mode.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4_jbd2.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..9dca10027032 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -467,6 +467,14 @@ static inline int ext4_should_journal_data(struct inode *inode)
 
 static inline int ext4_should_order_data(struct inode *inode)
 {
+	/*
+	 * There is no need to order data for inodes with iomap buffered I/O
+	 * path since it always allocate unwritten extents for new allocated
+	 * blocks and have no risk of stale data.
+	 */
+	if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP))
+		return 0;
+
 	return ext4_inode_journal_mode(inode) & EXT4_INODE_ORDERED_DATA_MODE;
 }
 
-- 
2.46.1


