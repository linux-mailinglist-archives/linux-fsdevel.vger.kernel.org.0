Return-Path: <linux-fsdevel+bounces-48697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63466AB2FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032CA189B14E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7876255F4D;
	Mon, 12 May 2025 06:44:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD7255E20;
	Mon, 12 May 2025 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032296; cv=none; b=DyHz+Ig8Q/kyU8y2bwwLK1uESoRmx5v6nZLSRMAlWQu6govSOP2xl/sPLPjQpKlDA6K5taQFWXkEDDV3Lagy66P6TRnlaIe8IsCl23EgRomyB/R2YZf+i8yDgK+YvLyXai/Fol0EEOcDI5rbiCHYoZ0sWeEFTlbEYoLcJCOarBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032296; c=relaxed/simple;
	bh=HgJGF5MVnMvjb1iL2tlQUGgT7/HfS3XiTnJs/CVJbu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urbM0ukzNLiGqfSufz1zsTko1XAhLopcoKI/2/hwfmsqzKj2tEJnfpTRuiwrVkwKNPEsgxl1tObhsxy6IfnNDDEahNZbM/mDx3pZT+L3n2Y1eHHFetruxX7P/f61Vi8mAm7oJLIP/qTCmEeqEKCuQRR9JDJYFVwJYxkJXR0uHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZwqpQ3DPlz4f3jt8;
	Mon, 12 May 2025 14:44:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E52EB1A1026;
	Mon, 12 May 2025 14:44:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DXmCFoxF6sMA--.62010S7;
	Mon, 12 May 2025 14:44:49 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 3/8] ext4: make __ext4_block_zero_page_range() support large folio
Date: Mon, 12 May 2025 14:33:14 +0800
Message-ID: <20250512063319.3539411-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2DXmCFoxF6sMA--.62010S7
X-Coremail-Antispam: 1UD129KBjvJXoW7tFykJF45Zry7ur1UGFyUJrb_yoW8WFWUpF
	s8KFWkCwsrWrWj9ayIgF1kXr1IkayDWa18WFWfJw43XFyaq34Ig3WDt3Z5Za1jqrWxAFy8
	WF4YvryfXa1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUomiiDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The partial block zero range helper __ext4_block_zero_page_range()
currently only supports folios of PAGE_SIZE in size. The calculations
for the start block and the offset within a folio for the given range
are incorrect. Modify the implementation to use offset_in_folio()
instead of directly masking PAGE_SIZE - 1, which will be able to support
for large folios.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4d8187f3814e..573ae0b3be1d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3701,9 +3701,7 @@ void ext4_set_aops(struct inode *inode)
 static int __ext4_block_zero_page_range(handle_t *handle,
 		struct address_space *mapping, loff_t from, loff_t length)
 {
-	ext4_fsblk_t index = from >> PAGE_SHIFT;
-	unsigned offset = from & (PAGE_SIZE-1);
-	unsigned blocksize, pos;
+	unsigned int offset, blocksize, pos;
 	ext4_lblk_t iblock;
 	struct inode *inode = mapping->host;
 	struct buffer_head *bh;
@@ -3718,13 +3716,14 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 
 	blocksize = inode->i_sb->s_blocksize;
 
-	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
+	iblock = folio->index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
 
 	bh = folio_buffers(folio);
 	if (!bh)
 		bh = create_empty_buffers(folio, blocksize, 0);
 
 	/* Find the buffer that contains "offset" */
+	offset = offset_in_folio(folio, from);
 	pos = blocksize;
 	while (offset >= pos) {
 		bh = bh->b_this_page;
-- 
2.46.1


