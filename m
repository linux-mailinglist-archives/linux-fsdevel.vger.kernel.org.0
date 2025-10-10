Return-Path: <linux-fsdevel+bounces-63740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA6BCC8C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA776188AD33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FA92F2902;
	Fri, 10 Oct 2025 10:34:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5E2EF677;
	Fri, 10 Oct 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092482; cv=none; b=Kvbti4sAEqhcXsIl7KXKXVYG1nkGmOgsNZVnUtpRsjxjDMtQi2U8qk5NuPg3GxQ6HharndicgOVIvE/fkMTnyytFTQBY1mno0RRaK2OYFFcAsG/lp+azz7ZXSdpRnOHeuB1vqCxiytxRseGmzLe9Z1sKpGdXCrly56ch8QdSY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092482; c=relaxed/simple;
	bh=E0FvYkwlck0p/qtRr6PpM5dKEIgi05xfOGPjs/5Fylo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdqoefDT2sCDEfzkJJm/4oaR+fsgCYtwDHJnao3gwL7uJl47nEUCUotxCfMKNU4JMYLlCgv0RrlkU/Jy9xPJnk9kp82FS2j/yyV8fHJo6Bj9OGw7ujkBxoGNv+amdT+4JQoh1D+oBoZ7TQ8jBZDRwKXlURTopMJLBjpInzsS+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cjjlc57klzKHMyv;
	Fri, 10 Oct 2025 18:34:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DCA501A1000;
	Fri, 10 Oct 2025 18:34:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCHS2Ms4ehoxOK5CQ--.63632S16;
	Fri, 10 Oct 2025 18:34:34 +0800 (CST)
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
Subject: [PATCH v3 12/12] ext4: add two trace points for moving extents
Date: Fri, 10 Oct 2025 18:33:26 +0800
Message-ID: <20251010103326.3353700-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
References: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHS2Ms4ehoxOK5CQ--.63632S16
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyDAF4DAF1UWr48uFy8Krg_yoWrtr4xpF
	n7AFy5K3ykXaya934xCw4UZr45ua4Ikr4UKrWSg343XayxtrnFgr4kt3WjvF9YyrW8Kryf
	XFWjyryDKa45W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

To facilitate tracking the length, type, and outcome of the move extent,
add a trace point at both the entry and exit of mext_move_extent().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/move_extent.c       | 14 ++++++-
 include/trace/events/ext4.h | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 691edcf5d464..87f21a30a82a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -13,6 +13,8 @@
 #include "ext4.h"
 #include "ext4_extents.h"
 
+#include <trace/events/ext4.h>
+
 struct mext_data {
 	struct inode *orig_inode;	/* Origin file inode */
 	struct inode *donor_inode;	/* Donor file inode */
@@ -311,10 +313,14 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
 	int ret, ret2;
 
 	*m_len = 0;
+	trace_ext4_move_extent_enter(orig_inode, orig_map, donor_inode,
+				     mext->donor_lblk);
 	credits = ext4_chunk_trans_extent(orig_inode, 0) * 2;
 	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, credits);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out;
+	}
 
 	ret = mext_move_begin(mext, folio, &move_type);
 	if (ret)
@@ -374,6 +380,10 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
 	mext_folio_double_unlock(folio);
 stop_handle:
 	ext4_journal_stop(handle);
+out:
+	trace_ext4_move_extent_exit(orig_inode, orig_map->m_lblk, donor_inode,
+				    mext->donor_lblk, orig_map->m_len, *m_len,
+				    move_type, ret);
 	return ret;
 
 repair_branches:
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 6a0754d38acf..a05bdd48e16e 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -3016,6 +3016,80 @@ TRACE_EVENT(ext4_update_sb,
 		  __entry->fsblk, __entry->flags)
 );
 
+TRACE_EVENT(ext4_move_extent_enter,
+	TP_PROTO(struct inode *orig_inode, struct ext4_map_blocks *orig_map,
+		 struct inode *donor_inode, ext4_lblk_t donor_lblk),
+
+	TP_ARGS(orig_inode, orig_map, donor_inode, donor_lblk),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(ino_t, orig_ino)
+		__field(ext4_lblk_t, orig_lblk)
+		__field(unsigned int, orig_flags)
+		__field(ino_t, donor_ino)
+		__field(ext4_lblk_t, donor_lblk)
+		__field(unsigned int, len)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= orig_inode->i_sb->s_dev;
+		__entry->orig_ino	= orig_inode->i_ino;
+		__entry->orig_lblk	= orig_map->m_lblk;
+		__entry->orig_flags	= orig_map->m_flags;
+		__entry->donor_ino	= donor_inode->i_ino;
+		__entry->donor_lblk	= donor_lblk;
+		__entry->len		= orig_map->m_len;
+	),
+
+	TP_printk("dev %d,%d origin ino %lu lblk %u flags %s donor ino %lu lblk %u len %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->orig_ino,  __entry->orig_lblk,
+		  show_mflags(__entry->orig_flags),
+		  (unsigned long) __entry->donor_ino,  __entry->donor_lblk,
+		  __entry->len)
+);
+
+TRACE_EVENT(ext4_move_extent_exit,
+	TP_PROTO(struct inode *orig_inode, ext4_lblk_t orig_lblk,
+		 struct inode *donor_inode, ext4_lblk_t donor_lblk,
+		 unsigned int m_len, u64 move_len, int move_type, int ret),
+
+	TP_ARGS(orig_inode, orig_lblk, donor_inode, donor_lblk, m_len,
+		move_len, move_type, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(ino_t, orig_ino)
+		__field(ext4_lblk_t, orig_lblk)
+		__field(ino_t, donor_ino)
+		__field(ext4_lblk_t, donor_lblk)
+		__field(unsigned int, m_len)
+		__field(u64, move_len)
+		__field(int, move_type)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= orig_inode->i_sb->s_dev;
+		__entry->orig_ino	= orig_inode->i_ino;
+		__entry->orig_lblk	= orig_lblk;
+		__entry->donor_ino	= donor_inode->i_ino;
+		__entry->donor_lblk	= donor_lblk;
+		__entry->m_len		= m_len;
+		__entry->move_len	= move_len;
+		__entry->move_type	= move_type;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("dev %d,%d origin ino %lu lblk %u donor ino %lu lblk %u m_len %u, move_len %llu type %d ret %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->orig_ino,  __entry->orig_lblk,
+		  (unsigned long) __entry->donor_ino,  __entry->donor_lblk,
+		  __entry->m_len, __entry->move_len, __entry->move_type,
+		  __entry->ret)
+);
+
 #endif /* _TRACE_EXT4_H */
 
 /* This part must be outside protection */
-- 
2.46.1


