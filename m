Return-Path: <linux-fsdevel+bounces-7114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7BD821C04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D59280CE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8142C12E63;
	Tue,  2 Jan 2024 12:42:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847F156F4;
	Tue,  2 Jan 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CD51x7lz4f3nK9;
	Tue,  2 Jan 2024 20:42:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF7041A0803;
	Tue,  2 Jan 2024 20:42:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S29;
	Tue, 02 Jan 2024 20:42:18 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v2 25/25] ext4: enable large folio for regular file with iomap buffered IO path
Date: Tue,  2 Jan 2024 20:39:18 +0800
Message-Id: <20240102123918.799062-26-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S29
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DXFWfXF47Jw4xAr48Xrb_yoW8Zw4xpr
	nIk3WrGrW8X34q9an3Kry7Zr1jqa18K3yUurWS9w1DuFZrJa4IgF4jkF1xAF48trW8A3yS
	qF4Ikr15Zw13C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After we convert buffered IO path to iomap for regular files, we can
enable large foilo for them together, that should be able to bring a lot
of performance gains for large IO.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ialloc.c      | 4 +++-
 fs/ext4/inode.c       | 4 +++-
 fs/ext4/move_extent.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 956b9d69c559..5a22fe5aa46b 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1336,8 +1336,10 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
-	if (ext4_should_use_buffered_iomap(inode))
+	if (ext4_should_use_buffered_iomap(inode)) {
 		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+		mapping_set_large_folios(inode->i_mapping);
+	}
 
 	if (ext4_handle_valid(handle)) {
 		ei->i_sync_tid = handle->h_transaction->t_tid;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2d2b8f2b634d..49a5b9b85407 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5319,8 +5319,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 
-	if (ext4_should_use_buffered_iomap(inode))
+	if (ext4_should_use_buffered_iomap(inode)) {
 		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+		mapping_set_large_folios(inode->i_mapping);
+	}
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext4_file_inode_operations;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 7a9ca71d4cac..aecd6112d8a2 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -560,6 +560,7 @@ static int ext4_disable_buffered_iomap_aops(struct inode *inode)
 	truncate_inode_pages(inode->i_mapping, 0);
 
 	ext4_clear_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+	mapping_clear_large_folios(inode->i_mapping);
 	ext4_set_aops(inode);
 	filemap_invalidate_unlock(inode->i_mapping);
 
-- 
2.39.2


