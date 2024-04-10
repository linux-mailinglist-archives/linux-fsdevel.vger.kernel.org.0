Return-Path: <linux-fsdevel+bounces-16594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4789FA5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158A228BAC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C73181308;
	Wed, 10 Apr 2024 14:38:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D517BB3E;
	Wed, 10 Apr 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759925; cv=none; b=OHpV7maWwVoU/AwGu8rFNkWvSvhoSF4W8vQboY/3TZLeHpeWFdAtE0yXn+w6HZUPvxzxe1qF567SntVAaTsy/6eKrCmuYO6wCMqM8r8zMok8WaGFvahirmhvTL1BbiGTwmt7MOOF79vvV9ZVw//0GdlktlVA2no3SHVJmjlhq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759925; c=relaxed/simple;
	bh=KM32SNb41b4Lg9S0iKRUmn1qiuXmKsCzoFcVq1tt5Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LfbRM6UsfKcV0atmVtZsPog6LzYnHo6dN2H762qkPozz6cxmP5kQiwlxdcqptRe6DXdVsjo2X82yns95TVydjBrryPdmD+jMYKHUJYczUAsOVaACTII48wsedrv4j/R6ZF1ygNPtOUHowhb/rMk8QOhghTOFYsHRPcmSTYQ3CTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF56d1RbWz4f3kny;
	Wed, 10 Apr 2024 22:38:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0BCAD1A0568;
	Wed, 10 Apr 2024 22:38:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S26;
	Wed, 10 Apr 2024 22:38:39 +0800 (CST)
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
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 22/34] ext4: add a new iomap aops for regular file's buffered IO path
Date: Wed, 10 Apr 2024 22:29:36 +0800
Message-Id: <20240410142948.2817554-23-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S26
X-Coremail-Antispam: 1UD129KBjvJXoWxCryDCFWrXrWrZr17Kr17KFg_yoW5CF17pF
	Z8Kas3Gr18Zr9F9a1fXayDZF4Yya4fGw4UKFW3G3WavFyrGrW7KFWvk3WjkFy5t3y8Ar17
	XF4jkry7WF17CrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4U
	JwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x0pRDPE-UUU
	UU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new iomap address space operations ext4_iomap_aops to
support regular file's buffered IO path, also add an inode state flag
EXT4_STATE_BUFFERED_IOMAP, if it was set on an inode, it means that
inode use the iomap path instead of buffer_head path for buffered IO.
Most of their callbacks can use generic implementations, the left over
read_folio, readahead and writepages will be implemented later.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/inode.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7e27e1e7c579..05949a8136ae 100644
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
index 2704dca96ee7..4c1fed516d9e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3523,6 +3523,22 @@ const struct iomap_ops ext4_iomap_report_ops = {
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
@@ -3612,6 +3628,21 @@ static const struct address_space_operations ext4_da_aops = {
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
+	.error_remove_folio	= generic_error_remove_folio,
+	.swap_activate		= ext4_iomap_swap_activate,
+};
+
 static const struct address_space_operations ext4_dax_aops = {
 	.writepages		= ext4_dax_writepages,
 	.direct_IO		= noop_direct_IO,
@@ -3634,6 +3665,8 @@ void ext4_set_aops(struct inode *inode)
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


