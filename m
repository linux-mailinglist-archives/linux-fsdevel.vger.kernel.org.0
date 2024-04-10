Return-Path: <linux-fsdevel+bounces-16568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09E89F893
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542FB1F31A07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A4E17F37B;
	Wed, 10 Apr 2024 13:37:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E85179964;
	Wed, 10 Apr 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756232; cv=none; b=e4+HBMZ+UbsgpL9mxycZOKJIs6vv5/arVPlSKPUAsgKskUeS4CA4wLK8uQpIVkPnKn2/8JsR0zvMrwuK3YlLfP7j9pPs2KDQICZ2HzTHssBlRiWByH1dEqo2oTfpYxmcbhin5Vy632S32cllRa8ndnj1ItBOfxtskdyHh7fD22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756232; c=relaxed/simple;
	bh=e380bcGvC+0GXftRaUh0mc9IjrgCk3wJCKvPfnu6cRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/NPBk+fTeEZjS7yvgt1aI8Kh8PbjQnqTTt5KVGtTvEqLKEB1lFiwMEKuLwZAgEHH83YPuxzk51kR137ZURzU3F3tM39HcuTSk+j5ys5ih9zlbcEZXyqeycHmgI7o59s2idhSqyhh0VJo+E2LFrO3UW9AQk59JhnVcGAij2IcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF3lf15QNz4f3k5n;
	Wed, 10 Apr 2024 21:37:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8CEFA1A0BE9;
	Wed, 10 Apr 2024 21:37:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S34;
	Wed, 10 Apr 2024 21:37:06 +0800 (CST)
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
Subject: [RFC PATCH v4 30/34] ext4: partial enable iomap for regular file's buffered IO path
Date: Wed, 10 Apr 2024 21:28:14 +0800
Message-Id: <20240410132818.2812377-31-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S34
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1kKrWrCw1DtF43GFW7Jwb_yoWrGr4UpF
	ZIkryrJr4Y93s29a1ftF48Zr1Sv3WxKw4UG3yS9wn5XFy8J34SqF1jyF15A3WrJrZ5ua4S
	qF4jkr1Uuw43urDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfU
	UUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Partial enable iomap for regular file's buffered IO path on default
mount option, support default filesystem features and bigalloc feature,
doesn't support inline data, fs_verity, fs_crypt, defrag and
data=journal mode yet (these would be supported gradually in the
future). ext4 will fallback to buffered_head path automatically if these
options or features are enable.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h   |  1 +
 fs/ext4/ialloc.c |  3 +++
 fs/ext4/inode.c  | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2ec6c7884e9a..4e7667b21c2f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2972,6 +2972,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
+bool ext4_should_use_buffered_iomap(struct inode *inode);
 int ext4_nonda_switch(struct super_block *sb);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e9bbb1da2d0a..956b9d69c559 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1336,6 +1336,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
+	if (ext4_should_use_buffered_iomap(inode))
+		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+
 	if (ext4_handle_valid(handle)) {
 		ei->i_sync_tid = handle->h_transaction->t_tid;
 		ei->i_datasync_tid = handle->h_transaction->t_tid;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5af3b8acf1b9..624eac0cc705 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -770,6 +770,8 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 
 	if (ext4_has_inline_data(inode))
 		return -ERANGE;
+	if (WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)))
+		return -EINVAL;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
@@ -2567,6 +2569,9 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 
 	trace_ext4_writepages(inode, wbc);
 
+	if (WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)))
+		return -EINVAL;
+
 	/*
 	 * No pages to write? This is mainly a kludge to avoid starting
 	 * a transaction for special inodes like journal inode on last iput()
@@ -5107,6 +5112,30 @@ static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
 	return NULL;
 }
 
+bool ext4_should_use_buffered_iomap(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	if (ext4_has_feature_inline_data(sb))
+		return false;
+	if (ext4_has_feature_verity(sb))
+		return false;
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
+		return false;
+	if (!S_ISREG(inode->i_mode))
+		return false;
+	if (IS_DAX(inode))
+		return false;
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+		return false;
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE))
+		return false;
+	if (ext4_test_inode_flag(inode, EXT4_INODE_ENCRYPT))
+		return false;
+
+	return true;
+}
+
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
 			  unsigned int line)
@@ -5371,6 +5400,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 
+	if (ext4_should_use_buffered_iomap(inode))
+		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
-- 
2.39.2


