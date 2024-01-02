Return-Path: <linux-fsdevel+bounces-7104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A8E821BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4313D1F242F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9BF14F9B;
	Tue,  2 Jan 2024 12:42:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22814A9A;
	Tue,  2 Jan 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CCz67MYz4f3nKM;
	Tue,  2 Jan 2024 20:42:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7AFD01A07EC;
	Tue,  2 Jan 2024 20:42:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S19;
	Tue, 02 Jan 2024 20:42:13 +0800 (CST)
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
Subject: [RFC PATCH v2 15/25] ext4: add a new iomap aops for regular file's buffered IO path
Date: Tue,  2 Jan 2024 20:39:08 +0800
Message-Id: <20240102123918.799062-16-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S19
X-Coremail-Antispam: 1UD129KBjvJXoWxur43KF1xCr4ruw1kKF13twb_yoW5Cr1UpF
	Z0kas8Gr18Zry7ua1fXFWDZF4Yk34fJw4UKFW3G3WavryrGrW7KFW0ka4jyFyUt3y8Ar1x
	XF4jkry7WF13CrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new iomap address space operations ext4_iomap_aops to
support regular file's buffered IO path and add an inode state flag
EXT4_STATE_BUFFERED_IOMAP to indicate that one inode use the iomap
path. Most of their callbacks should be able to use general
implementation, the left over read_folio, readahead and writepages
should be implemented later.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/inode.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 287284a3f128..3461cb3ff524 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1913,6 +1913,7 @@ enum {
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
 	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
+	EXT4_STATE_BUFFERED_IOMAP,	/* Inode use iomap for buffered IO */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9f9b1fce8da8..6b5cd0dab1ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3492,6 +3492,22 @@ const struct iomap_ops ext4_iomap_report_ops = {
 	.iomap_begin = ext4_iomap_begin_report,
 };
 
+static int ext4_iomap_read_folio(struct file *file, struct folio *folio)
+{
+	return 0;
+}
+
+static void ext4_iomap_readahead(struct readahead_control *rac)
+{
+
+}
+
+static int ext4_iomap_writepages(struct address_space *mapping,
+				 struct writeback_control *wbc)
+{
+	return 0;
+}
+
 /*
  * For data=journal mode, folio should be marked dirty only when it was
  * writeably mapped. When that happens, it was already attached to the
@@ -3581,6 +3597,21 @@ static const struct address_space_operations ext4_da_aops = {
 	.swap_activate		= ext4_iomap_swap_activate,
 };
 
+static const struct address_space_operations ext4_iomap_aops = {
+	.read_folio		= ext4_iomap_read_folio,
+	.readahead		= ext4_iomap_readahead,
+	.writepages		= ext4_iomap_writepages,
+	.dirty_folio		= iomap_dirty_folio,
+	.bmap			= ext4_bmap,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.release_folio		= iomap_release_folio,
+	.direct_IO		= noop_direct_IO,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate  = iomap_is_partially_uptodate,
+	.error_remove_page	= generic_error_remove_page,
+	.swap_activate		= ext4_iomap_swap_activate,
+};
+
 static const struct address_space_operations ext4_dax_aops = {
 	.writepages		= ext4_dax_writepages,
 	.direct_IO		= noop_direct_IO,
@@ -3603,6 +3634,8 @@ void ext4_set_aops(struct inode *inode)
 	}
 	if (IS_DAX(inode))
 		inode->i_mapping->a_ops = &ext4_dax_aops;
+	else if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP))
+		inode->i_mapping->a_ops = &ext4_iomap_aops;
 	else if (test_opt(inode->i_sb, DELALLOC))
 		inode->i_mapping->a_ops = &ext4_da_aops;
 	else
-- 
2.39.2


