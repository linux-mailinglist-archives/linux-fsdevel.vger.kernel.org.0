Return-Path: <linux-fsdevel+bounces-32568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC289A96D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F20286302
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AD513E03E;
	Tue, 22 Oct 2024 03:13:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9401C7B72;
	Tue, 22 Oct 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566787; cv=none; b=J5ST+fbQJtIXz0Wx5bbqfihOneg4tvyGLM3qFfWIdlqYrFX8SDT80CEZWADGCbuxIkNJX5dxySeTRV7bERYPlJIfTnNTsRt/HL1M+QRkXM6xXm03Vy+M2e4G3kV7MQ2GwQy7PJ9+4hRfFWJlzDOaMpDCsdLxT9lJp/VduVoQO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566787; c=relaxed/simple;
	bh=elKdS8cCNg8nXPyquUp1cwsUe+GpytOnFehHkD0Zbvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umLtg3HQorzruYrFelXD6c3dN7zCTIVyGQqf/KQO32glx86y6c0JIMgYVcPogj7JTpZcJv58QXCWJUkDCH1ugdw2CDIHeXztUA87V1VJ7SMqQi7P1LvtcxA4qh1gHo7uf2nXxfyMgP+BNFrvpdafkCNU634xu/3/tS5M9T+3dAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXcgK1cBMz4f3jJD;
	Tue, 22 Oct 2024 11:12:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 91FC31A058E;
	Tue, 22 Oct 2024 11:13:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S25;
	Tue, 22 Oct 2024 11:13:02 +0800 (CST)
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
Subject: [PATCH 21/27] ext4: implement zero_range iomap path
Date: Tue, 22 Oct 2024 19:10:52 +0800
Message-ID: <20241022111059.2566137-22-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S25
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyftF4xAw15Zr15Kw4fuFg_yoW5GF43pr
	4DK3yUWrsrW39F9w4SqFy7Xr1ay3WfGrW8Wry3Gr98Zr95Xa4xKFW5KFySkFyUtrW7A3yj
	qF4jyrW7Kr1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Introduce ext4_iomap_zero_range() to implement the zero_range iomap
path. Currently, this function direct invokes iomap_zero_range() to zero
out a mapped partial block during the truncate down, zeroing range and
punching hole. Almost all operations are handled by iomap_zero_range().

One important aspect to consider is the truncate-down operation. Since
we do not order the data, it is essential to write out zeroed data
before the i_disksize update transaction is committed. Otherwise, stale
data may left over in the last block, which could be exposed during the
next expand truncate operation.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 34701afe61c2..50e4afd17e93 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4147,6 +4147,13 @@ static int __ext4_block_zero_page_range(struct address_space *mapping,
 	return err;
 }
 
+static int ext4_iomap_zero_range(struct inode *inode, loff_t from,
+				 loff_t length, bool *did_zero)
+{
+	return iomap_zero_range(inode, from, length, did_zero,
+				&ext4_iomap_buffered_write_ops);
+}
+
 /*
  * ext4_block_zero_page_range() zeros out a mapping of length 'length'
  * starting from file offset 'from'.  The range to be zero'd must
@@ -4173,6 +4180,8 @@ static int ext4_block_zero_page_range(struct address_space *mapping,
 	if (IS_DAX(inode)) {
 		return dax_zero_range(inode, from, length, NULL,
 				      &ext4_iomap_ops);
+	} else if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
+		return ext4_iomap_zero_range(inode, from, length, did_zero);
 	}
 	return __ext4_block_zero_page_range(mapping, from, length, did_zero);
 }
@@ -4572,6 +4581,22 @@ int ext4_truncate(struct inode *inode)
 			goto out_trace;
 
 		ext4_block_truncate_page(mapping, inode->i_size, &zero_len);
+		/*
+		 * inode with an iomap buffered I/O path does not order data,
+		 * so it is necessary to write out zeroed data before the
+		 * updating i_disksize transaction is committed. Otherwise,
+		 * stale data may remain in the last block, which could be
+		 * exposed during the next expand truncate operation.
+		 */
+		if (zero_len && ext4_test_inode_state(inode,
+					EXT4_STATE_BUFFERED_IOMAP)) {
+			loff_t zero_end = inode->i_size + zero_len;
+
+			err = filemap_write_and_wait_range(mapping,
+					inode->i_size, zero_end - 1);
+			if (err)
+				goto out_trace;
+		}
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-- 
2.46.1


