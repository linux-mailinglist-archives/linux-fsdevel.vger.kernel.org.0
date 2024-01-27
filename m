Return-Path: <linux-fsdevel+bounces-9179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7283E98B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D187B28F47
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046DC45959;
	Sat, 27 Jan 2024 02:03:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E62E835;
	Sat, 27 Jan 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320981; cv=none; b=lg9UWI/Calw/vxNtZ93urVEyczBauiE7ZquXX9jvbP7DJ13hJPqEYtnA7qFY8xCk/6hSZQpGZkcNTJA4Ic5kyjMTkm+t15zdLlNz5vBsD3WNbJtAsbCd417Xp5HuHYFi788JuYZs60jtINKp6TyXkEg84gRn7dLZraTfBk3rhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320981; c=relaxed/simple;
	bh=c9cDYo070RWgCiBNsjR82t7ubR/rT9rtBYCmXMY6SXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLKbjrEne58Xrj4hNo/POcbzsQvLjsygZ8v02abeZqJcO83aick5ALF3gScIt8dxS7wmxaEMNbqKzDMsSSN39l3WOniwmjG3Z5BgAdsb3sOYnzEcfRpYMWeqTIoEV+endStlPP7kmaFRqdPXf78G2W/h7TlLjWsllDOTzwz2PAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMHrp1sLPz4f3lgF;
	Sat, 27 Jan 2024 10:02:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 997E21A0272;
	Sat, 27 Jan 2024 10:02:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S30;
	Sat, 27 Jan 2024 10:02:56 +0800 (CST)
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
Subject: [RFC PATCH v3 26/26] ext4: enable large folio for regular file with iomap buffered IO path
Date: Sat, 27 Jan 2024 09:58:25 +0800
Message-Id: <20240127015825.1608160-27-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S30
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DXFWfXF47Jw4xAr48Xrb_yoW8Zw4xpr
	nIk3WrGrW8X34q9anagry7Zr1jq3W8K3yUurWS9wn8uFZrJa4IgF4qkF1xAa18trWrA3yS
	qF4Ikr13Zw13K3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbCe
	HDUUUUU==
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
index 30067775e828..a1dbfc2b904c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5384,8 +5384,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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


