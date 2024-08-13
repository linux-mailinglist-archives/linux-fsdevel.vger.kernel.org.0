Return-Path: <linux-fsdevel+bounces-25782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC45950551
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD9F286FF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2719F49C;
	Tue, 13 Aug 2024 12:39:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7719E83E;
	Tue, 13 Aug 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552772; cv=none; b=hnzxRq5C0ODcA+tDR98Gi7gpMfMqkdJt/mkCO+asoE+/oXzXPnvWTrEIxMcMpxE/mKpAq5Yra68ROffo+gbQWgsAmcJ2Kshr5Kosuozlmh/wy53C/qaX4XgtKq2rQdJVghHHWGkOBJEiLVtVTf6oPJgLQCOETQHaqP5cFgfFSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552772; c=relaxed/simple;
	bh=EOMOwcyJKZIrNu4wntlGgW4/7ED+Ag5YXu/+7+AWogg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=egNg96GB3835NB86bnKSxm2C5YrnP9qTEXuF3mFJYzz4rglhbGxA/TVG6Or3enNZyz2QTgXMu889s102HH4UEWT4U6IHL4NJaaBJoLFlBsJPeRlZYg270KYDCJHVVnq2iOA0JzSU9VYyckV1APTttjfYyIIXDccZykYV/dJnwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjrY718wTz4f3m7N;
	Tue, 13 Aug 2024 20:39:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C9BCE1A018D;
	Tue, 13 Aug 2024 20:39:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S15;
	Tue, 13 Aug 2024 20:39:21 +0800 (CST)
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
Subject: [PATCH v3 11/12] ext4: drop ext4_es_is_delonly()
Date: Tue, 13 Aug 2024 20:34:51 +0800
Message-Id: <20240813123452.2824659-12-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S15
X-Coremail-Antispam: 1UD129KBjvJXoWxXF15uF45Cr1DGrW7tw48Crg_yoWrtFWDpF
	Z8GF18Gr43u34UWw4xt3WUXr1rK3W0qFWjgrySkr1fXFyrXryS9F10yFy8AFyrKrW8ZF13
	XFWjy340ya12ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
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
index b372b98af366..68c47ecc01a5 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -558,8 +558,8 @@ static int ext4_es_can_be_merged(struct extent_status *es1,
 	if (ext4_es_is_hole(es1))
 		return 1;
 
-	/* we need to check delayed extent is without unwritten status */
-	if (ext4_es_is_delayed(es1) && !ext4_es_is_unwritten(es1))
+	/* we need to check delayed extent */
+	if (ext4_es_is_delayed(es1))
 		return 1;
 
 	return 0;
@@ -1135,7 +1135,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_lblk_t i, end, nclu;
 
-	if (!ext4_es_is_delonly(es))
+	if (!ext4_es_is_delayed(es))
 		return;
 
 	WARN_ON(len <= 0);
@@ -1285,7 +1285,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		es = rc->left_es;
 		while (es && ext4_es_end(es) >=
 		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
-			if (ext4_es_is_delonly(es)) {
+			if (ext4_es_is_delayed(es)) {
 				rc->ndelonly--;
 				left_delonly = true;
 				break;
@@ -1305,7 +1305,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			}
 			while (es && es->es_lblk <=
 			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
-				if (ext4_es_is_delonly(es)) {
+				if (ext4_es_is_delayed(es)) {
 					rc->ndelonly--;
 					right_delonly = true;
 					break;
@@ -2226,7 +2226,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) {
 		first = EXT4_LBLK_CMASK(sbi, lblk);
 		if (first != lblk)
-			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						first, lblk - 1);
 		if (f_del) {
 			ret = __insert_pending(inode, first, prealloc);
@@ -2238,7 +2238,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			       sbi->s_cluster_ratio - 1;
 			if (last != end)
 				l_del = __es_scan_range(inode,
-							&ext4_es_is_delonly,
+							&ext4_es_is_delayed,
 							end + 1, last);
 			if (l_del) {
 				ret = __insert_pending(inode, last, prealloc);
@@ -2251,7 +2251,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	} else {
 		first = EXT4_LBLK_CMASK(sbi, lblk);
 		if (first != lblk)
-			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						first, lblk - 1);
 		if (f_del) {
 			ret = __insert_pending(inode, first, prealloc);
@@ -2263,7 +2263,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 
 		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
 		if (last != end)
-			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			l_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						end + 1, last);
 		if (l_del) {
 			ret = __insert_pending(inode, last, prealloc);
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 7d7af642f7b2..4424232de298 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -190,11 +190,6 @@ static inline int ext4_es_is_mapped(struct extent_status *es)
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
index 2fa13e9e78bc..bdf466d5a8d4 100644
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


