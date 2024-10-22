Return-Path: <linux-fsdevel+bounces-32569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CDC9A96DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FE41C249BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053D5200C84;
	Tue, 22 Oct 2024 03:13:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9E1F429E;
	Tue, 22 Oct 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566789; cv=none; b=gKpwirXp9N4Z/4pwzKl5AiGo95Nv88AyMBEb5JB5ek+qieOOxvx9dOQxaOSTTj5X5XKu8qv1gGDQG9HRGw5jL1rnHVu2wr4f4G7Ms9+XMH0w5rIEONvjOWN9bz08gUyEqrpKaOXbJftqVyQM1amoEGE5+77HZXx1reT9eRZTkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566789; c=relaxed/simple;
	bh=ubP8dtgkjA6KMpBj7kQAXGPFgndkJ/y1ISEWHCdmxc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XArNYAcLmZ36iknp3MHsUWAlzSrHEOt77K2t7Mx0yvH6XETlYWqPqqEfaaUQofyQ/Ld+KmA/pczOIZYgeuJUQW4Iasj+0d6rLAOIaoOOEmNgf/do0gRHbcJNNB7QlHA+CdIoDvMqJc5gY3Lm6ecPEtwCgOvWza/rQrEucFMNhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXcgK6Gs2z4f3jXy;
	Tue, 22 Oct 2024 11:12:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3E8121A0568;
	Tue, 22 Oct 2024 11:13:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S26;
	Tue, 22 Oct 2024 11:13:02 +0800 (CST)
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
Subject: [PATCH 22/27] ext4: disable online defrag when inode using iomap buffered I/O path
Date: Tue, 22 Oct 2024 19:10:53 +0800
Message-ID: <20241022111059.2566137-23-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S26
X-Coremail-Antispam: 1UD129KBjvdXoW7GrW7Cr45WFy3Cw18Jw1kXwb_yoWDKwc_Ka
	97XrWkWr4FvF4S9an8Ary5JrZ5CF48KF1fXFZ3KF4fuw42y395J34qkrZI9rykWr4jqrZx
	Crs7Jr1YgFy8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbQkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
	A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
	M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2I
	x0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRtl1hUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Online defragmentation does not yet support the inode using iomap
buffered I/O path, as it still relies on ext4_get_block() to get blocks
and copy data. Therefore, we must disable it for the time being.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/move_extent.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index b64661ea6e0e..508e342b4a1d 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -610,6 +610,13 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		return -EOPNOTSUPP;
 	}
 
+	if (ext4_test_inode_state(orig_inode, EXT4_STATE_BUFFERED_IOMAP) ||
+	    ext4_test_inode_state(donor_inode, EXT4_STATE_BUFFERED_IOMAP)) {
+		ext4_msg(orig_inode->i_sb, KERN_ERR,
+			 "Online defrag not supported for inode with iomap buffered IO path");
+		return -EOPNOTSUPP;
+	}
+
 	/* Protect orig and donor inodes against a truncate */
 	lock_two_nondirectories(orig_inode, donor_inode);
 
-- 
2.46.1


