Return-Path: <linux-fsdevel+bounces-19002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518148BF62B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2FAB21930
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8254668;
	Wed,  8 May 2024 06:22:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9FF364AA;
	Wed,  8 May 2024 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149370; cv=none; b=C01oxeC1rrxdrlHg2G8Ogc5d6XbmbWaYFdrAodTu2yLtsvRMWra3pSW0eL73U/07uz/ePoypLjkGwqC6BXFVhpEAdhIno/uMXl0EE+8X4g0OAprhC5WnOoA+0ac+6FSGNBhlDIaYz0XX8U52ZZr2+G4AaYq1EhMFWdJ4gs51z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149370; c=relaxed/simple;
	bh=dP5FthENrhUxyypPohNrXlubPH9wSNs1z1EKZ1Ys6Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khmKIIGHJd8z5GBOjovw0VU8nkBXnQ288d1/ZzbnHSusyq7XizgpPi2t2qGGulLZUzK9sJF0iELTEredkXhv58k+gz+AV5TQM3rm922KDJX7yO/KAJ+h5l00OBbCyyFfthKRc5JWX2ZJqxoyGh8VT68iyMlgD9iUWXbenmZnVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZ4nL5NLjz4f3l7C;
	Wed,  8 May 2024 14:22:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0D3941A017D;
	Wed,  8 May 2024 14:22:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6REbGjtm9_1NMA--.61952S6;
	Wed, 08 May 2024 14:22:38 +0800 (CST)
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
Subject: [PATCH v3 02/10] ext4: check the extent status again before inserting delalloc block
Date: Wed,  8 May 2024 14:12:12 +0800
Message-Id: <20240508061220.967970-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6REbGjtm9_1NMA--.61952S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUAw4DtF15Ar4xWr1rZwb_yoW5Aw4UpF
	9xCrn5Cr10gws7Gan3WF17Zr1rWw4rXrW7GFy3Kr1UZFy3JFySkF12va42va1fKrZ7JF4Y
	qFWYqryUu3WUtrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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

This patch fixes the problem by looking up extent status tree again
while the i_data_sem is held in write mode. If it still can't find
any entry, then we insert a new da entry into the extent status tree.

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


