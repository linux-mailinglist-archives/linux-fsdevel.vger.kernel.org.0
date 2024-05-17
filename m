Return-Path: <linux-fsdevel+bounces-19670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5188C868A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90139B20C66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7C50A6D;
	Fri, 17 May 2024 12:51:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FA4EB33;
	Fri, 17 May 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950261; cv=none; b=UTvlrO0qvL7VJnHqSmrtz+lomsU3NG9rCym0/VJZO1rDpPJnZAx3ESJlQ+/8OYIjWm1/3YhMVJfm3iLoOGmca4frxRRH41RrZReDBDZl/k8oHkLYG9xFSvdFbc6xqPPlqPIixs3aG2kCPjkXQffUv9oDDNmeJ8oq/QQTPAwWEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950261; c=relaxed/simple;
	bh=Rb8wefpBUOybtTo3tMcaH5TP8REz8ZDhedEutpJrV/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6yyZyzmZcihtDlNFjb5DdcopqdUKAyGGCWwnPRQ5ewVKL9FGHNMyq8OUicsa2Dmw7d4Vwp/SX7WvaS5bF4oxeMAeqaz8/gEzke0P9Np6AVrQKFK9qNP25BF1tpfvj7OcVMhoASI8jcJz6GBCuNelMz5IZ3HCvZrFC1sIjzEOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VgmzG0lxKz4f3k6W;
	Fri, 17 May 2024 20:50:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B28A31A016E;
	Fri, 17 May 2024 20:50:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGdUkdmdAmqMw--.14380S6;
	Fri, 17 May 2024 20:50:55 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 02/10] ext4: check the extent status again before inserting delalloc block
Date: Fri, 17 May 2024 20:39:57 +0800
Message-Id: <20240517124005.347221-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGdUkdmdAmqMw--.14380S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUAw4DtF15Ar4xWr1rZwb_yoW5AFWkpF
	9xCrn5Cr10gws7Gan3WF17Zr1rWw4rXrW7GFy3Kr1UZFy3JFySkF12va42va1fKrZ7JF4Y
	qFWYqryUu3WUtrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAGYLUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

ext4_da_map_blocks looks up for any extent entry in the extent status
tree (w/o i_data_sem) and then the looks up for any ondisk extent
mapping (with i_data_sem in read mode).

If it finds a hole in the extent status tree or if it couldn't find any
entry at all, it then takes the i_data_sem in write mode to add a da
entry into the extent status tree. This can actually race with page
mkwrite & fallocate path.

Note that this is ok between
1. ext4 buffered-write path v/s ext4_page_mkwrite(), because of the
   folio lock
2. ext4 buffered write path v/s ext4 fallocate because of the inode
   lock.

But this can race between ext4_page_mkwrite() & ext4 fallocate path

ext4_page_mkwrite()             ext4_fallocate()
 block_page_mkwrite()
  ext4_da_map_blocks()
   //find hole in extent status tree
                                 ext4_alloc_file_blocks()
                                  ext4_map_blocks()
                                   //allocate block and unwritten extent
   ext4_insert_delayed_block()
    ext4_da_reserve_space()
     //reserve one more block
    ext4_es_insert_delayed_block()
     //drop unwritten extent and add delayed extent by mistake

Then, the delalloc extent is wrong until writeback and the extra
reserved block can't be released any more and it triggers below warning:

 EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!

Fix the problem by looking up extent status tree again while the
i_data_sem is held in write mode. If it still can't find any entry, then
we insert a new da entry into the extent status tree.

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6a41172c06e1..6114ca79f464 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1737,6 +1737,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		if (ext4_es_is_hole(&es))
 			goto add_delayed;
 
+found:
 		/*
 		 * Delayed extent could be allocated by fallocate.
 		 * So we need to check it.
@@ -1781,6 +1782,26 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 add_delayed:
 	down_write(&EXT4_I(inode)->i_data_sem);
+	/*
+	 * Page fault path (ext4_page_mkwrite does not take i_rwsem)
+	 * and fallocate path (no folio lock) can race. Make sure we
+	 * lookup the extent status tree here again while i_data_sem
+	 * is held in write mode, before inserting a new da entry in
+	 * the extent status tree.
+	 */
+	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
+		if (!ext4_es_is_hole(&es)) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			goto found;
+		}
+	} else if (!ext4_has_inline_data(inode)) {
+		retval = ext4_map_query_blocks(NULL, inode, map);
+		if (retval) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			return retval;
+		}
+	}
+
 	retval = ext4_insert_delayed_block(inode, map->m_lblk);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
-- 
2.39.2


