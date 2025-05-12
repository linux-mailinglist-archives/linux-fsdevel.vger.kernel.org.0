Return-Path: <linux-fsdevel+bounces-48702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC9EAB3004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F0267AC550
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7225A329;
	Mon, 12 May 2025 06:44:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3432561C5;
	Mon, 12 May 2025 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032298; cv=none; b=CPeJ7ZTUyUMr+AszmrWBKdZmY2S31BTGYza+rkHg+htaxvu4LUdVuDQo9wLc2UDzuyGRjMiKHdikj/lfVfhYLBUfaKU4QocPT0zG2NAGxOeTdSfcc9Q0U4INN7wSDTSqS3h3rqTXZGiMqTfLGnPrxmgg8j+IkN4mo7QVBTLHuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032298; c=relaxed/simple;
	bh=jmTUtCBUwJFTXU+jbvgxFCS7ttqFbymd5WbFWGx46O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ussY8lD8c2JQa9rgQQoqXz2z6Gwi+VpjkMolMbtHAIp0fu5pJ8qTTbAS8M43qWQ5eIFSDL/6N7d/g7kJq9i6bCb3S7xdIZBXYsMNUPoV7ZPD48jiBT3WCLBM/RwwzxlJIRnrdrsk6QqvLL3ae1JmnPRhDHRkPA5mYqePVOoJlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZwqpJ5BqSz4f3jXm;
	Mon, 12 May 2025 14:44:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 672B21A0359;
	Mon, 12 May 2025 14:44:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DXmCFoxF6sMA--.62010S6;
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
Subject: [PATCH v2 2/8] ext4: make regular file's buffered write path support large folios
Date: Mon, 12 May 2025 14:33:13 +0800
Message-ID: <20250512063319.3539411-3-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHK2DXmCFoxF6sMA--.62010S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy8ur13ZF48XFyUXw4UCFg_yoWrWry5pr
	Z8K3Z7GrW7Zw1q9FWkXFnxXr1Y934xJ3yUCa4fWw1S9F98G3W3Ka1Fka45tFyFqrW8XF48
	XF4jyry8W3WjyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUl9a9UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The current buffered write path in ext4 can only allocate and handle
folios of PAGE_SIZE size. To support larger folios, modify
ext4_da_write_begin() and ext4_write_begin() to allocate higher-order
folios, and trim the write length if it exceeds the folio size.
Additionally, in ext4_da_do_write_end(), use offset_in_folio() instead
of PAGE_SIZE.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..4d8187f3814e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1027,7 +1027,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			   loff_t pos, unsigned len,
 			   get_block_t *get_block)
 {
-	unsigned from = pos & (PAGE_SIZE - 1);
+	unsigned int from = offset_in_folio(folio, pos);
 	unsigned to = from + len;
 	struct inode *inode = folio->mapping->host;
 	unsigned block_start, block_end;
@@ -1041,8 +1041,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 	bool should_journal_data = ext4_should_journal_data(inode);
 
 	BUG_ON(!folio_test_locked(folio));
-	BUG_ON(from > PAGE_SIZE);
-	BUG_ON(to > PAGE_SIZE);
+	BUG_ON(to > folio_size(folio));
 	BUG_ON(from > to);
 
 	head = folio_buffers(folio);
@@ -1152,6 +1151,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	struct folio *folio;
 	pgoff_t index;
 	unsigned from, to;
+	fgf_t fgp = FGP_WRITEBEGIN;
 
 	ret = ext4_emergency_state(inode->i_sb);
 	if (unlikely(ret))
@@ -1164,8 +1164,6 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 */
 	needed_blocks = ext4_writepage_trans_blocks(inode) + 1;
 	index = pos >> PAGE_SHIFT;
-	from = pos & (PAGE_SIZE - 1);
-	to = from + len;
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_try_to_write_inline_data(mapping, inode, pos, len,
@@ -1184,10 +1182,18 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * the folio (if needed) without using GFP_NOFS.
 	 */
 retry_grab:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
-					mapping_gfp_mask(mapping));
+	fgp |= fgf_set_order(len);
+	folio = __filemap_get_folio(mapping, index, fgp,
+				    mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
+
+	if (pos + len > folio_pos(folio) + folio_size(folio))
+		len = folio_pos(folio) + folio_size(folio) - pos;
+
+	from = offset_in_folio(folio, pos);
+	to = from + len;
+
 	/*
 	 * The same as page allocation, we prealloc buffer heads before
 	 * starting the handle.
@@ -2920,6 +2926,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	struct folio *folio;
 	pgoff_t index;
 	struct inode *inode = mapping->host;
+	fgf_t fgp = FGP_WRITEBEGIN;
 
 	ret = ext4_emergency_state(inode->i_sb);
 	if (unlikely(ret))
@@ -2945,11 +2952,15 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 retry:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
-			mapping_gfp_mask(mapping));
+	fgp |= fgf_set_order(len);
+	folio = __filemap_get_folio(mapping, index, fgp,
+				    mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
+	if (pos + len > folio_pos(folio) + folio_size(folio))
+		len = folio_pos(folio) + folio_size(folio) - pos;
+
 	ret = ext4_block_write_begin(NULL, folio, pos, len,
 				     ext4_da_get_block_prep);
 	if (ret < 0) {
@@ -3038,7 +3049,7 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 		unsigned long end;
 
 		i_size_write(inode, new_i_size);
-		end = (new_i_size - 1) & (PAGE_SIZE - 1);
+		end = offset_in_folio(folio, new_i_size - 1);
 		if (copied && ext4_da_should_update_i_disksize(folio, end)) {
 			ext4_update_i_disksize(inode, new_i_size);
 			disksize_changed = true;
-- 
2.46.1


