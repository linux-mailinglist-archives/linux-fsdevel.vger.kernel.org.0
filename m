Return-Path: <linux-fsdevel+bounces-69351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2385AC77872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4454034D64C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87E2FE072;
	Fri, 21 Nov 2025 06:10:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5F1C8FBA;
	Fri, 21 Nov 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705432; cv=none; b=qe5xIfJG3j3SV9+PBnvUmmfQ/f5UTSvTymVmpEOE8iQog/lJTfuvUVgEj5vMqPduOlklLNrDEhdFuNwUxVMVRVLYNQ/VwT97FZmqLYOlzhrO4CUDuL+fmypwxkqQwkTV9EUO96G+wvSao4OVvG9/QnWg1/G5Gi1hIeNXegJPFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705432; c=relaxed/simple;
	bh=zi3AN8i8AXlP66f3R7EElNkmkBR6iT++xtTay90h6ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxEFG/SPYib9CivRYGmifTQVvg8yPkub49BbQ8J5+YRUcnMfNHmlUlAZBhb2Wo+1ZVOUDEftF6bqYtiqKfnKOoYlNCG7UiORw/4MbPVwLgJFtGnLmFgQYyThX9c6XcWlEKm+WIgjXhUgMc4FYKsNhsGN0JT3iXFXJg4ZlSqYAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCPvC45PyzYQv44;
	Fri, 21 Nov 2025 14:09:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9AC9C1A0D66;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHtAAiBp_of0BQ--.63807S8;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 04/13] ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O
Date: Fri, 21 Nov 2025 14:08:02 +0800
Message-ID: <20251121060811.1685783-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHtAAiBp_of0BQ--.63807S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fJFyftw17XF17Kr4xXrb_yoW5KFW8pF
	4I9F1xJr4vy34ru34xJ3Wqqr17uw18GrsrAryYg3yUKayDtrySgF1Fka4rWFyFgr4rZayY
	yrWFva4Ykas8G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When allocating blocks during within-EOF DIO and writeback with
dioread_nolock enabled, EXT4_GET_BLOCKS_PRE_IO was set to split an
existing large unwritten extent. However, EXT4_GET_BLOCKS_CONVERT was
set when calling ext4_split_convert_extents(), which may potentially
result in stale data issues.

Assume we have an unwritten extent, and then DIO writes the second half.

   [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
   [UUUUUUUUUUUUUUUU] extent status tree
            |<-   ->| ----> dio write this range

First, ext4_iomap_alloc() call ext4_map_blocks() with
EXT4_GET_BLOCKS_PRE_IO, EXT4_GET_BLOCKS_UNWRIT_EXT and
EXT4_GET_BLOCKS_CREATE flags set. ext4_map_blocks() find this extent and
call ext4_split_convert_extents() with EXT4_GET_BLOCKS_CONVERT and the
above flags set.

Then, ext4_split_convert_extents() calls ext4_split_extent() with
EXT4_EXT_MAY_ZEROOUT, EXT4_EXT_MARK_UNWRIT2 and EXT4_EXT_DATA_VALID2
flags set, and it calls ext4_split_extent_at() to split the second half
with EXT4_EXT_DATA_VALID2, EXT4_EXT_MARK_UNWRIT1, EXT4_EXT_MAY_ZEROOUT
and EXT4_EXT_MARK_UNWRIT2 flags set. However, ext4_split_extent_at()
failed to insert extent since a temporary lack -ENOSPC. It zeroes out
the first half but convert the entire on-disk extent to written since
the EXT4_EXT_DATA_VALID2 flag set, but left the second half as unwritten
in the extent status tree.

   [0000000000SSSSSS]  data                S: stale data, 0: zeroed
   [WWWWWWWWWWWWWWWW]  on-disk extent      W: written extent
   [WWWWWWWWWWUUUUUU]  extent status tree

Finally, if the DIO failed to write data to the disk, the stale data in
the second half will be exposed once the cached extent entry is gone.

Fix this issue by not passing EXT4_GET_BLOCKS_CONVERT when splitting
an unwritten extent before submitting I/O, and make
ext4_split_convert_extents() to zero out the entire extent range
to zero for this case, and also mark the extent in the extent status
tree for consistency.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index cafe66cb562f..2db84f6b0056 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3733,11 +3733,15 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	/* Convert to unwritten */
 	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
 		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
-	/* Convert to initialized */
-	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
+	/* Split the existing unwritten extent */
+	} else if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
+			    EXT4_GET_BLOCKS_CONVERT)) {
 		split_flag |= ee_block + ee_len <= eof_block ?
 			      EXT4_EXT_MAY_ZEROOUT : 0;
-		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
+		split_flag |= EXT4_EXT_MARK_UNWRIT2;
+		/* Convert to initialized */
+		if (flags & EXT4_GET_BLOCKS_CONVERT)
+			split_flag |= EXT4_EXT_DATA_VALID2;
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
 	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
@@ -3913,7 +3917,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
 		path = ext4_split_convert_extents(handle, inode, map, path,
-				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
+						  flags, allocated);
 		if (IS_ERR(path))
 			return path;
 		/*
-- 
2.46.1


