Return-Path: <linux-fsdevel+bounces-20691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D998D6DD1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF21F23F55
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28924778C;
	Sat,  1 Jun 2024 03:42:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2627101D4;
	Sat,  1 Jun 2024 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213327; cv=none; b=ByURBUUgx+uzFvvUt1pU5tIn0lUcx+sVWQ9dtRBoT9o3GFe2MfxONqx1p1X3lpKXNLlNrnID54Na1tWmtpszf5r/iJB83snXeqIc0/NYoAdpAMtfv9LVfW6mjIvIMpQ38gC2BeiTn6toqu+4d9jyBEBEwVCdULoda5dhknNvKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213327; c=relaxed/simple;
	bh=OTyvkIxyuAiyex+IcBH+oQTY+y2+JDf3Rf7NxwyuMIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q74Pi6P5rWjrm55YM9XMtkSEF+VubQGv2+h55968sFSyHXcl6+4xImDCNKwTUC1g5CrGd8/NTy+9ugdDXzQTtQfjVonTN8rM92S8wjEAhtulRZRq4IVJe4d49EICOk0Q3hMl3ZyhR2O48+65kI1jpM3A2g5t2I0VZt6GFvxkPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vrm4q12tgz4f3jXm;
	Sat,  1 Jun 2024 11:41:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8F4901A016E;
	Sat,  1 Jun 2024 11:41:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFumFpmHN_4OA--.4543S13;
	Sat, 01 Jun 2024 11:41:56 +0800 (CST)
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
Subject: [PATCH 09/10] ext4: drop ext4_es_is_delonly()
Date: Sat,  1 Jun 2024 11:41:48 +0800
Message-Id: <20240601034149.2169771-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
References: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFumFpmHN_4OA--.4543S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXF15uFy3ZFyUGr18uw4DArb_yoWrtw47pr
	Z8GF18Gr43u34DW3yxtw1UXr1rK3W0qFWjgrySkr1fWFyrXryS9F10yFy8AFyrKrW8ZF13
	XFWUt34UCa17Ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
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
index f28435b2618f..db3fe3ada2e5 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -561,8 +561,8 @@ static int ext4_es_can_be_merged(struct extent_status *es1,
 	if (ext4_es_is_hole(es1))
 		return 1;
 
-	/* we need to check delayed extent is without unwritten status */
-	if (ext4_es_is_delayed(es1) && !ext4_es_is_unwritten(es1))
+	/* we need to check delayed extent */
+	if (ext4_es_is_delayed(es1))
 		return 1;
 
 	return 0;
@@ -1137,7 +1137,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_lblk_t i, end, nclu;
 
-	if (!ext4_es_is_delonly(es))
+	if (!ext4_es_is_delayed(es))
 		return;
 
 	WARN_ON(len <= 0);
@@ -1289,7 +1289,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		es = rc->left_es;
 		while (es && ext4_es_end(es) >=
 		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
-			if (ext4_es_is_delonly(es)) {
+			if (ext4_es_is_delayed(es)) {
 				rc->ndelonly_cluster--;
 				left_delonly = true;
 				break;
@@ -1309,7 +1309,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			}
 			while (es && es->es_lblk <=
 			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
-				if (ext4_es_is_delonly(es)) {
+				if (ext4_es_is_delayed(es)) {
 					rc->ndelonly_cluster--;
 					right_delonly = true;
 					break;
@@ -2237,7 +2237,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) {
 		first = EXT4_LBLK_CMASK(sbi, lblk);
 		if (first != lblk)
-			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						first, lblk - 1);
 		if (f_del) {
 			ret = __insert_pending(inode, first, prealloc);
@@ -2249,7 +2249,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			       sbi->s_cluster_ratio - 1;
 			if (last != end)
 				l_del = __es_scan_range(inode,
-							&ext4_es_is_delonly,
+							&ext4_es_is_delayed,
 							end + 1, last);
 			if (l_del) {
 				ret = __insert_pending(inode, last, prealloc);
@@ -2262,7 +2262,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	} else {
 		first = EXT4_LBLK_CMASK(sbi, lblk);
 		if (first != lblk)
-			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						first, lblk - 1);
 		if (f_del) {
 			ret = __insert_pending(inode, first, prealloc);
@@ -2274,7 +2274,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 
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
index 46e151f26655..f44f114a5c59 100644
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
2.31.1


