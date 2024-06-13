Return-Path: <linux-fsdevel+bounces-21622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75D99067FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44889285E87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53251140E5E;
	Thu, 13 Jun 2024 09:01:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8FC13C9D5;
	Thu, 13 Jun 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269273; cv=none; b=tMatzhqTB2udQBr47Tzw5eBvfAF48qCtKprNq1quB1Csj53usfXlCz2giOTBqU+IAUNu3NdeUmEtlWdxM5zIq0/FOOkJWPvbJZ+Uwr+fRixbjji7q4saPGNjh05smIKX1mTQH+eax8QmIz+lVJ132K4w2PfUeuAJsjDkOD0wv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269273; c=relaxed/simple;
	bh=Dk1ccNyqE3+a7Sva3IDjFE76nOjLd/K1QdYciQywgH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vo9tQ7+QV/XO86UKH8/JLmoR+LHA0jP7lO9D1ckoq0aZ6qBY7uPW/ErESAtisOuKruYFT6VFPI1IxoLXmezzmx+82xB+W/t6lKA5ikXLmSYjqS1CmipQTCBz6+lZUeFuUD9kBNQk+RY673ZYWjOUSxMkmziVRoMHE02LKgahFuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W0Gbb08ldz4f3jMS;
	Thu, 13 Jun 2024 17:00:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1A3DE1A0185;
	Thu, 13 Jun 2024 17:01:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFOtWpmHK1uPQ--.16895S9;
	Thu, 13 Jun 2024 17:01:08 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH -next v5 5/8] xfs: correct the truncate blocksize of realtime inode
Date: Thu, 13 Jun 2024 17:00:30 +0800
Message-Id: <20240613090033.2246907-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFOtWpmHK1uPQ--.16895S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DZr18AryUuFy8WrW3Wrg_yoW8uFW8pF
	Z7Aa4UGrWkW340k3W0qFn0qw1jka4kAr47ArWrZrn7Xa4kJr13trn2yry0gw43trs7X3WY
	gF15C3y7Z3W5JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18B
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When unaligned truncating down a realtime file which sb_rextsize is
bigger than one block, xfs_truncate_page() only zeros out the tail EOF
block, this could expose stale data since commit '943bc0882ceb ("iomap:
don't increase i_size if it's not a write operation")'.

If we truncate file that contains a large enough written extent:

     |<    rxext    >|<    rtext    >|
  ...WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
        ^ (new EOF)      ^ old EOF

Since we only zeros out the tail of the EOF block, and
xfs_itruncate_extents() unmap the whole ailgned extents, it becomes
this state:

     |<    rxext    >|
  ...WWWzWWWWWWWWWWWWW
        ^ new EOF

Then if we do an extending write like this, the blocks in the previous
tail extent becomes stale:

     |<    rxext    >|
  ...WWWzSSSSSSSSSSSSS..........WWWWWWWWWWWWWWWWW
        ^ old EOF               ^ append start  ^ new EOF

Fix this by zeroing out the tail allocation uint and also make sure
xfs_itruncate_extents() unmap allocation uint aligned extents.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_inode.c | 3 ++-
 fs/xfs/xfs_iops.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 58fb7a5062e1..92daa2279053 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1511,7 +1511,8 @@ xfs_itruncate_extents_flags(
 	 * We have to free all the blocks to the bmbt maximum offset, even if
 	 * the page cache can't scale that far.
 	 */
-	first_unmap_block = XFS_B_TO_FSB(mp, (xfs_ufsize_t)new_size);
+	first_unmap_block = XFS_B_TO_FSB(mp,
+			roundup_64(new_size, xfs_inode_alloc_unitsize(ip)));
 	if (!xfs_verify_fileoff(mp, first_unmap_block)) {
 		WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
 		return 0;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 0919a42cceb6..8e7e6c435fb3 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -858,7 +858,7 @@ xfs_setattr_truncate_data(
 	}
 
 	/* Truncate down */
-	blocksize = i_blocksize(inode);
+	blocksize = xfs_inode_alloc_unitsize(ip);
 
 	/*
 	 * iomap won't detect a dirty page over an unwritten block (or a cow
-- 
2.39.2


