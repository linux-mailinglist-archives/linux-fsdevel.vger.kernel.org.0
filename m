Return-Path: <linux-fsdevel+bounces-37895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886EB9F894A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 02:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D75118986BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010719D8A9;
	Fri, 20 Dec 2024 01:20:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A8172767;
	Fri, 20 Dec 2024 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734657621; cv=none; b=nIwl9unMSg7hkCJRnnwujrBq+8fOlH8ILpAIZpOMQ6V0Use3zDF4v3TifxLg8f9Z/DxI6C38wIlohw5Pp9SpYFSCaC9yGrN+H5jOT9y+aZgMfs36hRv6i83w9mS3k90kng8sWL3r0bm4t5QyYVmrP3TQRX2B6FyueYrOnltlALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734657621; c=relaxed/simple;
	bh=S/6OGyVdvUZmCIYodCqH0jTeVW7c2hE1C3h2S4Y1SY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsQNPASTz8zvJdA/Y3eCkNs6uFvDu6BczMb6HPCkQ5QeHIzboL4fDyiODRbTY+/HbEYD8yGA/9nQwAAOTybQsm/ApaXh0BdNpAJdYj1PLeFT1sTRLswEeqT+C1pwjAUzxGObij3ZdFfMZ7KqL/FhTBP1JfzuiCiNYy1TcTcRwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDqMn72WCz4f3js9;
	Fri, 20 Dec 2024 09:19:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 84B6F1A0197;
	Fri, 20 Dec 2024 09:20:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoI6xmRnETtfFA--.47090S6;
	Fri, 20 Dec 2024 09:20:09 +0800 (CST)
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
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v5 02/10] ext4: don't explicit update times in ext4_fallocate()
Date: Fri, 20 Dec 2024 09:16:29 +0800
Message-ID: <20241220011637.1157197-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241220011637.1157197-1-yi.zhang@huaweicloud.com>
References: <20241220011637.1157197-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoI6xmRnETtfFA--.47090S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyDZr1rur17Xry7Xw18Zrb_yoW5Gry5p3
	yrJa4rGw10gFyq9rWfKr4UZrn7t3ZrGr4UXrZ5u3yxua4DtwnYgF4YyrySyF15trW8Zr4Y
	vFyUK34UJw4jk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After commit 'ad5cd4f4ee4d ("ext4: fix fallocate to use file_modified to
update permissions consistently"), we can update mtime and ctime
appropriately through file_modified() when doing zero range, collapse
rage, insert range and punch hole, hence there is no need to explicit
update times in those paths, just drop them.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 5 -----
 fs/ext4/inode.c   | 1 -
 2 files changed, 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8dc6b4271b15..7fb38aab241d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4674,8 +4674,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			goto out_mutex;
 		}
 
-		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
 		filemap_invalidate_unlock(mapping);
@@ -4699,7 +4697,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		goto out_mutex;
 	}
 
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
@@ -5435,7 +5432,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5545,7 +5541,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1458b21bbb5e..b94cbdb82692 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4139,7 +4139,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret2))
 		ret = ret2;
-- 
2.46.1


