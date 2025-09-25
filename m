Return-Path: <linux-fsdevel+bounces-62700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DEAB9E543
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 11:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A136425CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1B12E8E05;
	Thu, 25 Sep 2025 09:27:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A972EB5C1;
	Thu, 25 Sep 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792434; cv=none; b=YttQInoyqcMsdKzrr1X0Rt8qYbKWx0Gxr9K3yEXmhh7r54q0YZCQ8qg3zu3hP+lL+mglafNeAZU62OFKKbaVaNhDw/VreX3ZQUWh7YdR+8+x05eIhrzgzkG3LH3qlg4B6fb5l+E3/VGbJhF/Uajes22Oxs0EYu6VjwJjKvTTbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792434; c=relaxed/simple;
	bh=HqpjVfJKQKn+4QXy9CAIihBK9F7U2RCqxvPAhPMA774=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1tThuXIWPyozgkIV5ifnkq8xGHm+hfjCpPHMrsUIA3azLsLu89Np+dvW0sExAcGCqHqTolOENNWC6oZ9xeaL5+rrnRramgTH7MD2R+FVQE+dSv+IpuGC8IlVOEutJttYgsRNZsabzVqPOgSI/LvwTQ+yA9e/jEKYu6vWpjLl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cXSz609yrzYQvK8;
	Thu, 25 Sep 2025 17:26:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0B40A1A16D3;
	Thu, 25 Sep 2025 17:27:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgD3CGHeCtVovAkNAw--.52999S17;
	Thu, 25 Sep 2025 17:27:06 +0800 (CST)
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
Subject: [PATCH v2 13/13] ext4: add two trace points for moving extents
Date: Thu, 25 Sep 2025 17:26:09 +0800
Message-ID: <20250925092610.1936929-14-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3CGHeCtVovAkNAw--.52999S17
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyDAF4DAF1kWFykWFykZrb_yoWruw15pF
	n7AFyYg3ykXaya934xAw4UZr45ua4IkrWUKrySg343JayxtrnFgr4kta1jyF9YyrW0kryf
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
---
 fs/ext4/move_extent.c       | 14 ++++++-
 include/trace/events/ext4.h | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 0fa97c207274..53a8b9caeeda 100644
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
@@ -372,6 +378,10 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
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


