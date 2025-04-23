Return-Path: <linux-fsdevel+bounces-47071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14439A98498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF82B3BD17F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED7255E38;
	Wed, 23 Apr 2025 09:03:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F61F4CA6;
	Wed, 23 Apr 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399013; cv=none; b=P7lUellyC8nOB8ivVpY/RRAgruRztD8cScACe8Pgefkt4KARqvSrQlaibx4s0RVx9/FV6kI4BkDn9xgX8/VOX9iNQetRQJleOxX03h4YGEOyv34rErgFVxy/tXZOLBIK7awmi2ZqNzKEXF7LjKBjARGo4TKCuYeNTJoJwtgUXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399013; c=relaxed/simple;
	bh=hPm3Ac9/0NCJEAox9EIoQJjvvlaLeqJlLO/BQF9wUS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4X1GofWLTL8WMW9uslzA1iEcp0ompa9diP8iF36jX1J/OMDAzr2LyrQhz+fFHL0uQp+PmpkLsDndQ+/uOULuXjeQ4lxkDcL2PVNG4YS3UwHwHK1QV6V+8CrTwXlwvkcd4MBYMf11bQhSU3GY99VTmDvvM3QW4kEmYet9PPbkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZjCmv6Dsvz4f3kvp;
	Wed, 23 Apr 2025 17:02:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 596AB1A1C6F;
	Wed, 23 Apr 2025 17:03:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S6;
	Wed, 23 Apr 2025 17:03:21 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 2/9] ext4: generalize EXT4_GET_BLOCKS_IO_SUBMIT flag usage
Date: Wed, 23 Apr 2025 16:52:50 +0800
Message-ID: <20250423085257.122685-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
References: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1rtrW5Kry7XryxXF18Zrb_yoW5AFW8pF
	srZ3WIgr4qqay3uwn7CF4Yqry2gr1xK3WDurWYqw4Uuay5tr18tFs0qr1rWa4jgrW8Z390
	vF1j9w1xt3s5CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUl9a9UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, the EXT4_GET_BLOCKS_IO_SUBMIT flag is only used during data
writeback to indicate that in ordered mode, the journal commit thread
should skip re-submitting data and simply wait for I/O completion.

To prepare for later patches that need to detect I/O submission context
in ext4_map_blocks(), generalizes the meaning of
EXT4_GET_BLOCKS_IO_SUBMIT. This flag will be set during:
 1) data I/O writeback,
 2) I/O completion extents conversion,
 3) journal performing commit in fast_commit.

This change doesn't affect current usage of this flag and provides a
clear way to identify I/O submission context.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h        | 13 ++++++++-----
 fs/ext4/fast_commit.c |  3 ++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..ad39bfe4b5d2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -706,9 +706,6 @@ enum {
 #define EXT4_GET_BLOCKS_CONVERT			0x0010
 #define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_PRE_IO|\
 					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)
-	/* Convert extent to initialized after IO complete */
-#define EXT4_GET_BLOCKS_IO_CONVERT_EXT		(EXT4_GET_BLOCKS_CONVERT|\
-					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)
 	/* Eventual metadata allocation (due to growing extent tree)
 	 * should not fail, so try to use reserved blocks for that.*/
 #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
@@ -720,9 +717,15 @@ enum {
 #define EXT4_GET_BLOCKS_ZERO			0x0200
 #define EXT4_GET_BLOCKS_CREATE_ZERO		(EXT4_GET_BLOCKS_CREATE |\
 					EXT4_GET_BLOCKS_ZERO)
-	/* Caller will submit data before dropping transaction handle. This
-	 * allows jbd2 to avoid submitting data before commit. */
+	/* Caller is in the context of data submission, such as writeback,
+	 * fsync, etc. Especially, in the generic writeback path, caller will
+	 * submit data before dropping transaction handle. This allows jbd2
+	 * to avoid submitting data before commit. */
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
+	/* Convert extent to initialized after IO complete */
+#define EXT4_GET_BLOCKS_IO_CONVERT_EXT		(EXT4_GET_BLOCKS_CONVERT |\
+					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT |\
+					 EXT4_GET_BLOCKS_IO_SUBMIT)
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index da4263a14a20..11c42b39478b 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -910,7 +910,8 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	while (cur_lblk_off <= new_blk_size) {
 		map.m_lblk = cur_lblk_off;
 		map.m_len = new_blk_size - cur_lblk_off + 1;
-		ret = ext4_map_blocks(NULL, inode, &map, 0);
+		ret = ext4_map_blocks(NULL, inode, &map,
+				      EXT4_GET_BLOCKS_IO_SUBMIT);
 		if (ret < 0)
 			return -ECANCELED;
 
-- 
2.46.1


