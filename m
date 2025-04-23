Return-Path: <linux-fsdevel+bounces-47074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34071A9849F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472773B57CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD3A25C837;
	Wed, 23 Apr 2025 09:03:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07B22F759;
	Wed, 23 Apr 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399013; cv=none; b=IluvfKn3kFvbWgwh8Kc32NG0QYpy2G4OnlMSiyZ7JYLmUZ3NbfV6q6Skk6V2pODP9a0oUfIGUh2uvi3vAYCIazmsVIBEcaM4Jz5UoZKxoHcjAPiKUuYAnl6oXRjrohkjAKhClXBhd7hPWrfoK2Y2ZLdm6x9h/0OrPijLxrEdZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399013; c=relaxed/simple;
	bh=Ne/1VTeng65SAMc+rnShQpGqCimR0JBbmGITWAiAvcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0llUwL23eVmhKh0Wg+Vqemb0za9ndl5I8K74UOAmGLKLbM3UGbt7/+ZzWR/KO4gyxCx7cQHVd4I60r+F9CCXeORTxsgMKnQx0cvd4xvzAFpWHENbeJar0Bbk0NZQe+Pur2leVQk3qYGb7SUcZnHuy/2HyBSqnj42/kAGLfIF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZjCn44MTXz4f3k5t;
	Wed, 23 Apr 2025 17:03:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4094C1A06DC;
	Wed, 23 Apr 2025 17:03:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S10;
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
Subject: [PATCH 6/9] ext4: factor out is_special_ino()
Date: Wed, 23 Apr 2025 16:52:54 +0800
Message-ID: <20250423085257.122685-7-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S10
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy3AF1kXFyxAryfKw4rZrb_yoW8ZrWxpF
	s5KFyxGrWUWr1Dua1fGr17Zr15Aa4xG3yUKFWakwn09Fy3A340yFs5t34rAF13KrWkX342
	vF15Ka1j9w4UCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

Factor out the helper is_special_ino() to facilitate the checking of
special inodes in the subsequent patches.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 11 +++++++++++
 fs/ext4/inode.c |  7 +------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f04cad83d74b..ccc1de1e23a9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3054,6 +3054,17 @@ extern void ext4_da_update_reserve_space(struct inode *inode,
 extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_fsblk_t pblk, ext4_lblk_t len);
 
+static inline bool is_special_ino(struct super_block *sb, unsigned long ino)
+{
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+
+	return (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO) ||
+		ino == le32_to_cpu(es->s_usr_quota_inum) ||
+		ino == le32_to_cpu(es->s_grp_quota_inum) ||
+		ino == le32_to_cpu(es->s_prj_quota_inum) ||
+		ino == le32_to_cpu(es->s_orphan_file_inum);
+}
+
 /* indirect.c */
 extern int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 				struct ext4_map_blocks *map, int flags);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 02eac9ee36f5..51801f6d23ef 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4793,12 +4793,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	gid_t i_gid;
 	projid_t i_projid;
 
-	if ((!(flags & EXT4_IGET_SPECIAL) &&
-	     ((ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO) ||
-	      ino == le32_to_cpu(es->s_usr_quota_inum) ||
-	      ino == le32_to_cpu(es->s_grp_quota_inum) ||
-	      ino == le32_to_cpu(es->s_prj_quota_inum) ||
-	      ino == le32_to_cpu(es->s_orphan_file_inum))) ||
+	if ((!(flags & EXT4_IGET_SPECIAL) && is_special_ino(sb, ino)) ||
 	    (ino < EXT4_ROOT_INO) ||
 	    (ino > le32_to_cpu(es->s_inodes_count))) {
 		if (flags & EXT4_IGET_HANDLE)
-- 
2.46.1


