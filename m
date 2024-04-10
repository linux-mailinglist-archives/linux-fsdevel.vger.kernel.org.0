Return-Path: <linux-fsdevel+bounces-16552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4F589F857
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA18E1F2D2A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C88171E7B;
	Wed, 10 Apr 2024 13:37:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9716E889;
	Wed, 10 Apr 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756224; cv=none; b=ZmhQi7J6s8kx39hek+CoxxjvL9e0WZXZi9/yoG/kJN8/U+XJGavGmus2jZGTUxOL8NcP9DhLdpAv59o7bXr/lkxNXN/UpbNNCku2aULeocFpyvDatjU71OoYe3xly3GP5SCEb9HzBGRdH0VpMM6jNVICaiMBQE6FmKMJ7+ZspDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756224; c=relaxed/simple;
	bh=/tzLFxZiQKM1o33YOWMcHkn39HY4IsDvc4ej8fHwAzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ubt6mK0sB4tYZzIImdB+96HgJ3uazIiSAp5lG7DeazE/GXKecgk4n858Y2y4kpWaareHaz7TcNng+aqwtwbmgxDRgUDDpwfYCzkhXVYZs1wnzZG7yCKRs7fdb0R1THmd+I6Z2wbqUFBEwazQLYQDg99TBrw5aqyp/z+yPIcOYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF3lQ3XLtz4f3m7f;
	Wed, 10 Apr 2024 21:36:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2597B1A0568;
	Wed, 10 Apr 2024 21:36:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S22;
	Wed, 10 Apr 2024 21:36:58 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 18/34] ext4: drop ext4_es_is_delonly()
Date: Wed, 10 Apr 2024 21:28:02 +0800
Message-Id: <20240410132818.2812377-19-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
References: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S22
X-Coremail-Antispam: 1UD129KBjvJXoWxXF18AFWxKrW3CrWUJr17Awb_yoWrKryfpF
	Z8JF18Gr43u34DW3yxtw1UXr1rKa10qFWjgrySkF1fWFyrXryS9F10yFyrAFyrKrW8ZF13
	XFWjy34jka17Ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since we don't add delayed flag in unwritten extent status entry, so
there is no difference between ext4_es_is_delayed() and
ext4_es_is_delonly(), just drop ext4_es_is_delonly().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 18 +++++++++---------
 fs/ext4/extents_status.h |  5 -----
 fs/ext4/inode.c          |  4 ++--
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9cac4ea57b73..062293e739cc 100644
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
@@ -2230,7 +2230,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) {
 		first = EXT4_LBLK_CMASK(sbi, lblk);
 		if (first != lblk)
-			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						first, lblk - 1);
 		if (f_del) {
 			ret = __insert_pending(inode, first, prealloc);
@@ -2242,7 +2242,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			       sbi->s_cluster_ratio - 1;
 			if (last != end)
 				l_del = __es_scan_range(inode,
-							&ext4_es_is_delonly,
+							&ext4_es_is_delayed,
 							end + 1, last);
 			if (l_del) {
 				ret = __insert_pending(inode, last, prealloc);
@@ -2255,7 +2255,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	} else {
 		first = EXT4_LBLK_CMASK(sbi, lblk);
 		if (first != lblk)
-			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
+			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
 						first, lblk - 1);
 		if (f_del) {
 			ret = __insert_pending(inode, first, prealloc);
@@ -2267,7 +2267,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 
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
index 64bdfa9e06b2..2704dca96ee7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1643,7 +1643,7 @@ static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
 	int ret;
 
 	*allocated = false;
-	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
+	if (ext4_es_scan_clu(inode, &ext4_es_is_delayed, lblk))
 		return 0;
 
 	if (ext4_es_scan_clu(inode, &ext4_es_is_mapped, lblk))
@@ -1760,7 +1760,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
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


