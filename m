Return-Path: <linux-fsdevel+bounces-70223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E8C93C6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 11:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC0A3AB50E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA829DB86;
	Sat, 29 Nov 2025 10:35:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37E288C2F;
	Sat, 29 Nov 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412541; cv=none; b=s5ckvMLVlEi3/vB6WvKQJRYmsNA0uCidew68dpEv6AsUTKZ0mIYcTmNmwBVpR1BKRa4Xe46HAARcuezjNMufBw+z8huyYBifmClzX78FFCMTFBdUi06Dzu/oiZZhgUZpyE/Tjp7/k3ToWFavEmQsBBQKwFvo/63rZsh1vNcMlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412541; c=relaxed/simple;
	bh=J9xDl5A5iwswn0zSvX3vOHrpKbNOm+R+P3Z+pJ+Gu60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB0MOFeibNsduPWvEBeSz1EUXpPVsScFy/hwfCj9hEyPBLwoqDlAOOVgoR7FJ2p2bHbRvpA8aEDq8FCQWX8qM7r59hrF/ZNqdxDjJ0IQK72YGxNSk3C66FRCJAMCF/+rGNvtLiCjU+yoXZqDn2CFfuEtGMewpmQ3tSoBZdYhFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJRPM5DYmzKHMQH;
	Sat, 29 Nov 2025 18:34:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DDBC81A07BB;
	Sat, 29 Nov 2025 18:35:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXtfzCpp_56qCQ--.62661S12;
	Sat, 29 Nov 2025 18:35:30 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 08/14] ext4: cleanup zeroout in ext4_split_extent_at()
Date: Sat, 29 Nov 2025 18:32:40 +0800
Message-ID: <20251129103247.686136-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXtfzCpp_56qCQ--.62661S12
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWDCr47Jw18Jr1UZw1rCrg_yoWrWFy7pw
	nI9a4rGrn5J34UW3yxJF47Zr1jg3WfWw4UG3y3Gw1fGa17Xr9agFyfKay0qFyFgFWkXryY
	qr4rt34UC3ZrGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

zero_ex is a temporary variable used only for writing zeros and
inserting extent status entry, it will not be directly inserted into the
tree. Therefore, it can be assigned values from the target extent in
various scenarios, eliminating the need to explicitly assign values to
each variable individually.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 87 ++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 51 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 945995d68c4d..2cfce2c01208 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3287,63 +3287,48 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
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
+		ext4_ext_mark_initialized(&zero_ex);
 
-		if (!err) {
+		err = ext4_ext_zeroout(inode, &zero_ex);
+		if (err)
+			goto fix_extent_len;
+
+		/*
+		 * The first half contains partially valid data, the splitting
+		 * of this extent has not been completed, fix extent length
+		 * and ext4_split_extent() split will the first half again.
+		 */
+		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
 			/*
-			 * The first half contains partially valid data, the
-			 * splitting of this extent has not been completed, fix
-			 * extent length and ext4_split_extent() split will the
-			 * first half again.
+			 * Drop extent cache to prevent stale unwritten
+			 * extents remaining after zeroing out.
 			 */
-			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
-				/*
-				 * Drop extent cache to prevent stale unwritten
-				 * extents remaining after zeroing out.
-				 */
-				ext4_es_remove_extent(inode,
+			ext4_es_remove_extent(inode,
 					le32_to_cpu(zero_ex.ee_block),
 					ext4_ext_get_actual_len(&zero_ex));
-				goto fix_extent_len;
-			}
-
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
+			goto fix_extent_len;
 		}
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


