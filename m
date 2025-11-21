Return-Path: <linux-fsdevel+bounces-69352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB6FC77861
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A2534E8607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDEB2FF160;
	Fri, 21 Nov 2025 06:10:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70A2DD61E;
	Fri, 21 Nov 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705432; cv=none; b=qc982Fakj/Y+ps0EDnqdD4yFU4rs7WmFPRUTiZ+BwMJjJh4cKEkUqH/HiJRZQYXvqh8shsnOVmPpN3L9tPv/zH8+rr0H3PIFj0B6xNAImb7d4JIJRll6LsuxuqCya5UUFvXp+rK7vQcyGxFGVsOhWooHGV6IKlGbYzLBna/b6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705432; c=relaxed/simple;
	bh=0MLoO882ewegjXjHICfHQsZgqfYKYwtxuiA0T5zEelo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlJD81FbXLvxRhV3B0F6/vp+Y9Wgxoz1yPvdTWu+25seVG1DrTiyhlUcMiSGFYgebceXhVqH2wJsQfNtceEa3g7WKmHtmOWgK0lAink/AZ7Ym5kS11Pw5zfxl5hC8quTRp46wXsGNmJkEqJIyx0g1ZzMQq7V/VnAt30EhZT2kk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCPvR4GXbzKHMYZ;
	Fri, 21 Nov 2025 14:09:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5A2291A018D;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHtAAiBp_of0BQ--.63807S5;
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
Subject: [PATCH v2 01/13] ext4: cleanup zeroout in ext4_split_extent_at()
Date: Fri, 21 Nov 2025 14:07:59 +0800
Message-ID: <20251121060811.1685783-2-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgD3VHtAAiBp_of0BQ--.63807S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWDCr47JFy5uFyxWw18Grg_yoW5AFWfpw
	nIkF9xKr1fJ34UW3yxJF47Zr1UC3WfWw4UGFWfGw1fGay7Xr9agFyfKa40qFyrKFW8Xa4Y
	qFWrJ34UCanrGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU2dgAUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

zero_ex is a temporary variable used only for writing zeros and
inserting extent status entry, it will not be directly inserted into the
tree. Therefore, it can be assigned values from the target extent in
various scenarios, eliminating the need to explicitly assign values to
each variable individually.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 63 ++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c7d219e6c6d8..91682966597d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3278,46 +3278,31 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	ex = path[depth].p_ext;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
-		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
-			if (split_flag & EXT4_EXT_DATA_VALID1) {
-				err = ext4_ext_zeroout(inode, ex2);
-				zero_ex.ee_block = ex2->ee_block;
-				zero_ex.ee_len = cpu_to_le16(
-						ext4_ext_get_actual_len(ex2));
-				ext4_ext_store_pblock(&zero_ex,
-						      ext4_ext_pblock(ex2));
-			} else {
-				err = ext4_ext_zeroout(inode, ex);
-				zero_ex.ee_block = ex->ee_block;
-				zero_ex.ee_len = cpu_to_le16(
-						ext4_ext_get_actual_len(ex));
-				ext4_ext_store_pblock(&zero_ex,
-						      ext4_ext_pblock(ex));
-			}
-		} else {
-			err = ext4_ext_zeroout(inode, &orig_ex);
-			zero_ex.ee_block = orig_ex.ee_block;
-			zero_ex.ee_len = cpu_to_le16(
-						ext4_ext_get_actual_len(&orig_ex));
-			ext4_ext_store_pblock(&zero_ex,
-					      ext4_ext_pblock(&orig_ex));
-		}
+		if (split_flag & EXT4_EXT_DATA_VALID1)
+			memcpy(&zero_ex, ex2, sizeof(zero_ex));
+		else if (split_flag & EXT4_EXT_DATA_VALID2)
+			memcpy(&zero_ex, ex, sizeof(zero_ex));
+		else
+			memcpy(&zero_ex, &orig_ex, sizeof(zero_ex));
 
-		if (!err) {
-			/* update the extent length and mark as initialized */
-			ex->ee_len = cpu_to_le16(ee_len);
-			ext4_ext_try_to_merge(handle, inode, path, ex);
-			err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-			if (!err)
-				/* update extent status tree */
-				ext4_zeroout_es(inode, &zero_ex);
-			/* If we failed at this point, we don't know in which
-			 * state the extent tree exactly is so don't try to fix
-			 * length of the original extent as it may do even more
-			 * damage.
-			 */
-			goto out;
-		}
+		err = ext4_ext_zeroout(inode, &zero_ex);
+		if (err)
+			goto fix_extent_len;
+
+		/* update the extent length and mark as initialized */
+		ex->ee_len = cpu_to_le16(ee_len);
+		ext4_ext_try_to_merge(handle, inode, path, ex);
+		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
+		if (!err)
+			/* update extent status tree */
+			ext4_zeroout_es(inode, &zero_ex);
+		/*
+		 * If we failed at this point, we don't know in which
+		 * state the extent tree exactly is so don't try to fix
+		 * length of the original extent as it may do even more
+		 * damage.
+		 */
+		goto out;
 	}
 
 fix_extent_len:
-- 
2.46.1


