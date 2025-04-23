Return-Path: <linux-fsdevel+bounces-47077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0131A984B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCEB5A438D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C9267F4D;
	Wed, 23 Apr 2025 09:03:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF6242D80;
	Wed, 23 Apr 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399015; cv=none; b=coDnePtzWyuQ9E6zDdZuUUZsmbV3K3v5n0dwdZsGD+fu8t0VaKnNMEVsd89PuztN3MXDBlCIWwOk0I3/Ks8ir9JocVk2HLLpgusrBWsihx37yoog+ZInqBL94uN6rakE3BSZotpxPzFOYgBRHn6F3w7REmLUqbXH3IVeQ4wAFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399015; c=relaxed/simple;
	bh=WKTlVWm2pLhYKYsfki9QxTLxFfgKRro3jYHwiIaL/e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWbDEid2F+YukSP0Z1YZkguaszwnY29gkyMTUYiCSxDpfdTnm1rRnsV6IiFEJ/us6corTwdCL1M+L0yfZBPVVdWP+Lq/sYlXDwv5UE4flQ7M4Ll7Cjh4PokoONbp7DiarV0TUTWsrdDerKba9JwQVznMKW2CkdM+s7UWlHXrS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZjCmy1syNz4f3lDq;
	Wed, 23 Apr 2025 17:02:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B76DB1A1D33;
	Wed, 23 Apr 2025 17:03:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S11;
	Wed, 23 Apr 2025 17:03:23 +0800 (CST)
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
Subject: [PATCH 7/9] ext4: introduce ext4_check_map_extents_env() debug helper
Date: Wed, 23 Apr 2025 16:52:55 +0800
Message-ID: <20250423085257.122685-8-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1kGw1UKrykXF1DWF4DArb_yoW5JFW8pr
	98KFy5Gw1DX3s29w4xtw4UXr15ta48Kr4UCF9akr15tF95J34IgF15tF1ayF15trWrXw4a
	vF4Ykr17uw4jkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUo73vUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Loading and modifying the extents tree and extent status tree without
holding the inode's i_rwsem or the mapping's invalidate_lock is not
permitted, except during the I/O writeback. Add a new debug helper
ext4_check_map_extents_env(), it will verify whether the extent
loading/modifying context is safe.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/inode.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ccc1de1e23a9..3b1bf52737e3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2977,6 +2977,7 @@ static inline bool ext4_mb_cr_expensive(enum criteria cr)
 void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
 			 struct ext4_inode_info *ei);
 int ext4_inode_is_fast_symlink(struct inode *inode);
+void ext4_check_map_extents_env(struct inode *inode);
 struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
 struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
 int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 51801f6d23ef..74c7a902a41d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -416,6 +416,32 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 	return ret;
 }
 
+/*
+ * For generic regular files, when updating the extent tree, Ext4 should
+ * hold the i_rwsem and invalidate_lock exclusively. This ensures
+ * exclusion against concurrent page faults, as well as reads and writes.
+ */
+#ifdef CONFIG_EXT4_DEBUG
+void ext4_check_map_extents_env(struct inode *inode)
+{
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return;
+
+	if (!S_ISREG(inode->i_mode) ||
+	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
+	    is_special_ino(inode->i_sb, inode->i_ino) ||
+	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
+	    ext4_verity_in_progress(inode))
+		return;
+
+	WARN_ON_ONCE(!inode_is_locked(inode) &&
+		     !rwsem_is_locked(&inode->i_mapping->invalidate_lock));
+}
+#else
+void ext4_check_map_extents_env(struct inode *inode) {}
+#endif
+
 #define check_block_validity(inode, map)	\
 	__check_block_validity((inode), __func__, __LINE__, (map))
 
-- 
2.46.1


