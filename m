Return-Path: <linux-fsdevel+bounces-9175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2E183E97C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6851F21E53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D12E62D;
	Sat, 27 Jan 2024 02:02:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50029410;
	Sat, 27 Jan 2024 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320978; cv=none; b=ZSZOZcIee6UKYxxmuNTCRgOnAqukVdj7aieJsv371VYPOGzxrML6uP9T5xqqagSUmoSCPZt7xVgsrWdvVpyu1n/nR3ikbA/Sdpe95Toni55xiw5L8ARXS3oRaivVIFw+BycEhYiH2Vx1LLUZa2u/6XkUolNARmwjEj3/KDlEoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320978; c=relaxed/simple;
	bh=1w1ccPraBcH8+8h0LBWVZnLu2Uw2lmKPtjyg/SaGOSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A3IMGiT4n6HiBjaxMQbVHfALF/4u8f8lUHLXAQ87+RWLL5opa9MLWgRhMYYDU5sgkkPOvTkNqtAu0ttynXKhQkVCv67exTnfoDSq6P/7bwCW+rIzDqHGa7g9XsNfB/Nnfpd6pDqU+FPIHmg8crXnKfP5mKx8iCYjqSiUSsLmtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMHrk24JZz4f3lg2;
	Sat, 27 Jan 2024 10:02:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A0B0B1A0272;
	Sat, 27 Jan 2024 10:02:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S24;
	Sat, 27 Jan 2024 10:02:52 +0800 (CST)
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
Subject: [RFC PATCH v3 20/26] ext4: implement mmap iomap path
Date: Sat, 27 Jan 2024 09:58:19 +0800
Message-Id: <20240127015825.1608160-21-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S24
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykWr13Gr1xKryUJw1kZrb_yoW8Ar4fpF
	9akrWrGr4xXwnF9FsagFZ8ZryYya4rWr4UWry3GFn5ZrnrZr4rtF48GF1rZF45J3yxZr40
	qr45Cry8u34akrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Implement mmap iomap path, add ext4_iomap_page_mkwrite() to map blocks
and dirty folio, almost everying have been done in iomap_page_mkwrite(),
so invoke it directly.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8ee0eca6a1e8..dee661e64a69 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6466,6 +6466,26 @@ static int ext4_bh_unmapped(handle_t *handle, struct inode *inode,
 	return !buffer_mapped(bh);
 }
 
+static vm_fault_t ext4_iomap_page_mkwrite(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	const struct iomap_ops *iomap_ops;
+
+	/*
+	 * ext4_nonda_switch() could writeback this folio, so have to
+	 * call it before lock folio.
+	 *
+	 * TODO: drop ext4_nonda_switch() after reserving enough sapce
+	 * for metadata and merge delalloc and nodelalloc operations.
+	 */
+	if (test_opt(inode->i_sb, DELALLOC) && !ext4_nonda_switch(inode->i_sb))
+		iomap_ops = &ext4_iomap_buffered_da_write_ops;
+	else
+		iomap_ops = &ext4_iomap_buffered_write_ops;
+
+	return iomap_page_mkwrite(vmf, iomap_ops);
+}
+
 vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -6489,6 +6509,11 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 
 	filemap_invalidate_lock_shared(mapping);
 
+	if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
+		ret = ext4_iomap_page_mkwrite(vmf);
+		goto out;
+	}
+
 	err = ext4_convert_inline_data(inode);
 	if (err)
 		goto out_ret;
-- 
2.39.2


