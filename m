Return-Path: <linux-fsdevel+bounces-32572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96129A96E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DC62873CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B44E20110D;
	Tue, 22 Oct 2024 03:13:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B071FEFC0;
	Tue, 22 Oct 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566790; cv=none; b=nj+u32SIKCsD1RPAvIMIttvEMKkftKqmksjd2JVzV2OV46qlTQI84NV9aCE+FZ0IJllTsgTtnu2C0CtHw+Zpbj7yCkFxkDKZWGlkFvfL/kOlw7IEiI3UYAZMjZuI3+p+eWjFkA6bsJi02Hngy9lOyBPsLISK6N12h4ZC+fBF+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566790; c=relaxed/simple;
	bh=T7Ax1zmPeYMqNlopQKLb8lsCwVcBJZ9ZJijwkkRpwBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0bPXJsbR0uh3ljwh0Dx/B6IYAE5Eo+fXaFD8QaL1xylCD6bvuqIf3Mwtz+A/0LD7oT9QmXxfFVkqLcRqh/1MLCeNkmFFJTO0iMG6vy8MAMApcuTORkUe3zwGOIJ8MaACR+yhjU/9D60EiwwMhfVS+V8ee/O5Qscj+fMUdwq1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgS68Hhz4f3jks;
	Tue, 22 Oct 2024 11:12:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 235601A018C;
	Tue, 22 Oct 2024 11:13:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S29;
	Tue, 22 Oct 2024 11:13:04 +0800 (CST)
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
Subject: [PATCH 25/27] ext4: enable large folio for regular file with iomap buffered I/O path
Date: Tue, 22 Oct 2024 19:10:56 +0800
Message-ID: <20241022111059.2566137-26-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S29
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyrCw1fZw1xWr1xWF17Jrb_yoW8XrW7pr
	sxK3W8GrWkX34q9ws3KryxZr1Uta1xGw4UuFWF9wn8WrWDJ34SqF4jkF1xAF48JrWrA3y2
	qFyIkr13Z3WfC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRio7uDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since we have converted the buffered I/O path to iomap for regular
files, we can enable large folio support as well. This should result in
significant performance gains for large I/O operations.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ialloc.c | 4 +++-
 fs/ext4/inode.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 2e3e257b9808..6ff03fb74867 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1333,8 +1333,10 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
-	if (ext4_should_use_buffered_iomap(inode))
+	if (ext4_should_use_buffered_iomap(inode)) {
 		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+		mapping_set_large_folios(inode->i_mapping);
+	}
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 512094dc4117..97abc88e6658 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5437,8 +5437,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 
-	if (ext4_should_use_buffered_iomap(inode))
+	if (ext4_should_use_buffered_iomap(inode)) {
 		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+		mapping_set_large_folios(inode->i_mapping);
+	}
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext4_file_inode_operations;
-- 
2.46.1


