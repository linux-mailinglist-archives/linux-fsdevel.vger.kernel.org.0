Return-Path: <linux-fsdevel+bounces-48696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3DAAB2FF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B207F3BC340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE80256C86;
	Mon, 12 May 2025 06:44:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEA255F50;
	Mon, 12 May 2025 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032295; cv=none; b=cGxq9FEFTSJoYn0+z8o99py2ccPL62kSlMz5LouS+41pc4SSlyOMPvaiC2mvCKLVw5tXQP+qY/91/FRpaX3zFDPcf7Jo+tYhHTfHaurw8z7mbAy5BHS1wSUKh98R9pS6KwalLrAJ+rdtSTAVYfwL2yQyVF9Sid3WethvPfvSTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032295; c=relaxed/simple;
	bh=bJ99H/L/PRWugOH4KwePmEVjn01zU55LI3V/Ko8Mo8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYWUImkgFYaGmcNNb1xTNnz+ECRW/ak18ul6BMv6j+9sOUfRtUtN7xRz3GH/hwFFs0GWaZpQvxayLh9IK1KXpf3NpNafZn/rFKJRiFWqCB4P2CZcenPU6JPTXYVTBH4xGOWq3Lg/8ieIsIIxVGPUvo2ntWcF6LcI60iAx+S66Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4Zwqpq4rlrzYQtyy;
	Mon, 12 May 2025 14:44:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F11B51A0359;
	Mon, 12 May 2025 14:44:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DXmCFoxF6sMA--.62010S9;
	Mon, 12 May 2025 14:44:50 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 5/8] ext4: correct the journal credits calculations of allocating blocks
Date: Mon, 12 May 2025 14:33:16 +0800
Message-ID: <20250512063319.3539411-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2DXmCFoxF6sMA--.62010S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1DurW5Ww4rKrWrZFWDJwb_yoW5JFyfpF
	nxCF4rGr18W34UuFWxKa1UZr18Ga18Ga17ZFW3Jr13XF98J34xKrn0yF18AFyYqFWfXr1q
	vF4Fk34UJ3W3J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUo73vUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The journal credits calculation in ext4_ext_index_trans_blocks() is
currently inadequate. It only multiplies the depth of the extents tree
and doesn't account for the blocks that may be required for adding the
leaf extents themselves.

After enabling large folios, we can easily run out of handle credits,
triggering a warning in jbd2_journal_dirty_metadata() on filesystems
with a 1KB block size. This occurs because we may need more extents when
iterating through each large folio in
ext4_do_writepages()->mpage_map_and_submit_extent(). Therefore, we
should modify ext4_ext_index_trans_blocks() to include a count of the
leaf extents in the worst case as well.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c |  5 +++--
 fs/ext4/inode.c   | 10 ++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36..e759941bd262 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2405,9 +2405,10 @@ int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
 	depth = ext_depth(inode);
 
 	if (extents <= 1)
-		index = depth * 2;
+		index = depth * 2 + extents;
 	else
-		index = depth * 3;
+		index = depth * 3 +
+			DIV_ROUND_UP(extents, ext4_ext_space_block(inode, 0));
 
 	return index;
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ffbf444b56d4..3e962a760d71 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5792,18 +5792,16 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 	int ret;
 
 	/*
-	 * How many index blocks need to touch to map @lblocks logical blocks
-	 * to @pextents physical extents?
+	 * How many index and lead blocks need to touch to map @lblocks
+	 * logical blocks to @pextents physical extents?
 	 */
 	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
 
-	ret = idxblocks;
-
 	/*
 	 * Now let's see how many group bitmaps and group descriptors need
 	 * to account
 	 */
-	groups = idxblocks + pextents;
+	groups = idxblocks;
 	gdpblocks = groups;
 	if (groups > ngroups)
 		groups = ngroups;
@@ -5811,7 +5809,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 		gdpblocks = EXT4_SB(inode->i_sb)->s_gdb_count;
 
 	/* bitmaps and block group descriptor blocks */
-	ret += groups + gdpblocks;
+	ret = idxblocks + groups + gdpblocks;
 
 	/* Blocks for super block, inode, quota and xattr blocks */
 	ret += EXT4_META_TRANS_BLOCKS(inode->i_sb);
-- 
2.46.1


