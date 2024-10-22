Return-Path: <linux-fsdevel+bounces-32547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E59A9695
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E91E2834B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557E13B58E;
	Tue, 22 Oct 2024 03:12:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D64450E2;
	Tue, 22 Oct 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566776; cv=none; b=lV/TBFX4G+ccfgZxBbjWWkcED+IGkwvRgAGjG32jEZMEWtilVjpuqgHVGbDCr04s8rGijtzIAkF1yDzVgF5Fxe5SKK1lo3TWzktd79kES9mR+UYFR+Pv9NucNnMBRF7DT47LcGiYjYFB5vwt8oAo/O0cgU/ILzqJB/IOvnDUKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566776; c=relaxed/simple;
	bh=eTE9FdAXMuVd28LY2UqYUhldzFq3CJH4Ou5K6L/lr0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1rrlLvVb5tsALTTOWBXDT5mCLJSHBDB04yBgfPTyRGhhT+KyrNhVEKNNgTbn/qDfaM7xI4y71tKuUaThhOsPRdYklsZPb0zkKfks6um0Nhxy3tg3eierw4W5FLdw6SianV3zAuuC1xK+qJ1qlcVNgjmrfvcJ7dDotWyo+z2QgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXcg50frNz4f3jMX;
	Tue, 22 Oct 2024 11:12:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 732F71A058E;
	Tue, 22 Oct 2024 11:12:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S6;
	Tue, 22 Oct 2024 11:12:50 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 02/27] ext4: don't explicit update times in ext4_fallocate()
Date: Tue, 22 Oct 2024 19:10:33 +0800
Message-ID: <20241022111059.2566137-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyDZr13KFy8urW5KF48JFb_yoW5GFyrpr
	WrGa4rG3W8WFyq9rWFkr4UZrs7K3W7Gr48XrZ5u34xua4DJwnYgF1jyFySyF4rtrW8Zr4j
	vFyUKw1UWw1Uu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRBT53UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After commit 'ad5cd4f4ee4d ("ext4: fix fallocate to use file_modified to
update permissions consistently"), we can update mtime and ctime
appropriately through file_modified() when doing zero range, collapse
rage, insert range and punch hole, hence there is no need to explicit
update times in those paths, just drop them.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 4 ----
 fs/ext4/inode.c   | 1 -
 2 files changed, 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2a054c3689f0..aa07b5ddaff8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4679,7 +4679,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		/* Now release the pages and zero block aligned part of pages */
 		ext4_truncate_folios_range(inode, start, end);
 		truncate_pagecache_range(inode, start, end - 1);
-		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
@@ -4704,7 +4703,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		goto out_mutex;
 	}
 
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
@@ -5440,7 +5438,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5550,7 +5547,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8b34e79112d5..f8796f7b0f94 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4085,7 +4085,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret2))
 		ret = ret2;
-- 
2.46.1


