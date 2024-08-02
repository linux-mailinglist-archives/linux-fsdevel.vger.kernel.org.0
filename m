Return-Path: <linux-fsdevel+bounces-24870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE3945D8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00441C22846
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE541E7A46;
	Fri,  2 Aug 2024 11:55:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABF1E4849;
	Fri,  2 Aug 2024 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599711; cv=none; b=CkRo7d56iE414DfeUjJ2bSRvIDdoidV+i1K0wAOoZRovgdsF9K7Er0u0ZuBZOZkdVcrF/VQy5zhL5VPhH2dwUZeLwcLi+e8JZNMnlInM+U+8AO9KIUKnnoBAswRAOTIp6Kj6H/mCrjut92/Xrddva1Kahtxv7h0m0agLoEkN6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599711; c=relaxed/simple;
	bh=1VxEAJ5bu0x63+VVR2uQNa6bBk0kcnkzUbZYR5Ia8jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sT9Wwh+FKccux/FNZVwyl1RvoZ4vcCp7UiBSEDGUsM4GhF20ptgADPDkJq8Sn2mtjNIL6T89ymwVD6Dnkt9QB3mFKCBW92WqiafCAAKF6TTFQT7Hz3MqVjT945M5Iq4neyl4kv718z53FJkYxMA2gMbrvOK5t0R6N04qko91tNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb4583XtBz4f3mHg;
	Fri,  2 Aug 2024 19:54:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8A1911A07BB;
	Fri,  2 Aug 2024 19:55:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S13;
	Fri, 02 Aug 2024 19:55:06 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 09/10] ext4: drop ext4_es_is_delonly()
Date: Fri,  2 Aug 2024 19:51:19 +0800
Message-Id: <20240802115120.362902-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXF15uF45Cr17Zry3Zr1DZFb_yoWrtw47pr
	Z8GF18Gr43u34DW3yxt3WUXr1rK3W0qFWjgrySkr1fWFyrXryS9F10yFy8AFyrKrW8ZF13
	XFWjy34UCa17Ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

Since we don't add delayed flag in unwritten extents, so there is no
difference between ext4_es_is_delayed() and ext4_es_is_delonly(),
just drop ext4_es_is_delonly().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 18 +++++++++---------
 fs/ext4/extents_status.h |  5 -----
 fs/ext4/inode.c          |  4 ++--
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index e482ac818317..5fb0a02405ba 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -563,8 +563,8 @@ static int ext4_es_can_be_merged(struct extent_status *es1,
 	if (ext4_es_is_hole(es1))
 		return 1;
 
-	/* we need to check delayed extent is without unwritten status */
-	if (ext4_es_is_delayed(es1) && !ext4_es_is_unwritten(es1))
+	/* we need to check delayed extent */
+	if (ext4_es_is_delayed(es1))
 		return 1;
 
 	return 0;
@@ -1139,7 +1139,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_lblk_t i, end, nclu;
 
-	if (!ext4_es_is_delonly(es))
+	if (!ext4_es_is_delayed(es))
 		return;
 
 	WARN_ON(len <= 0);
@@ -1291,7 +1291,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		es = rc->left_es;
 		while (es && ext4_es_end(es) >=
 		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
-			if (ext4_es_is_delonly(es)) {
+			if (ext4_es_is_delayed(es)) {
 				rc->ndelonly_cluster--;
 				left_delonly = true;
 				break;
@@ -1311,7 +1311,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			}
 			while (es && es->es_lblk <=
 			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
-				if (ext4_es_is_delonly(es)) {
+				if (ext4_es_is_delayed(es)) {
 					rc->ndelonly_cluster--;
 					right_delonly = true;
 					break;
@@ -2239,7 +2239,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) {
 		first = EXT4_LBLK_CMASK(sbi, lblk);
 		if (first != lblk)
-			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						first, lblk - 1);
 		if (f_del) {
 			ret = __insert_pending(inode, first, prealloc);
@@ -2251,7 +2251,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			       sbi->s_cluster_ratio - 1;
 			if (last != end)
 				l_del = __es_scan_range(inode,
-							&ext4_es_is_delonly,
+							&ext4_es_is_delayed,
 							end + 1, last);
 			if (l_del) {
 				ret = __insert_pending(inode, last, prealloc);
@@ -2264,7 +2264,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	} else {
 		first = EXT4_LBLK_CMASK(sbi, lblk);
 		if (first != lblk)
-			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						first, lblk - 1);
 		if (f_del) {
 			ret = __insert_pending(inode, first, prealloc);
@@ -2276,7 +2276,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 
 		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
 		if (last != end)
-			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			l_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						end + 1, last);
 		if (l_del) {
 			ret = __insert_pending(inode, last, prealloc);
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 5b49cb3b9aff..e484c60e55e3 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -184,11 +184,6 @@ static inline int ext4_es_is_mapped(struct extent_status *es)
 	return (ext4_es_is_written(es) || ext4_es_is_unwritten(es));
 }
 
-static inline int ext4_es_is_delonly(struct extent_status *es)
-{
-	return (ext4_es_is_delayed(es) && !ext4_es_is_unwritten(es));
-}
-
 static inline void ext4_es_set_referenced(struct extent_status *es)
 {
 	es->es_pblk |= ((ext4_fsblk_t)EXTENT_STATUS_REFERENCED) << ES_SHIFT;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8bd65a45a26a..2b301c165468 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1645,7 +1645,7 @@ static int ext4_clu_alloc_state(struct inode *inode, ext4_lblk_t lblk)
 	int ret;
 
 	/* Has delalloc reservation? */
-	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
+	if (ext4_es_scan_clu(inode, &ext4_es_is_delayed, lblk))
 		return 1;
 
 	/* Already been allocated? */
@@ -1766,7 +1766,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 		 * Delayed extent could be allocated by fallocate.
 		 * So we need to check it.
 		 */
-		if (ext4_es_is_delonly(&es)) {
+		if (ext4_es_is_delayed(&es)) {
 			map->m_flags |= EXT4_MAP_DELAYED;
 			return 0;
 		}
-- 
2.39.2


