Return-Path: <linux-fsdevel+bounces-65592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A42FC0897B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 914224E17C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ECB27464F;
	Sat, 25 Oct 2025 03:30:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327624C66F;
	Sat, 25 Oct 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363007; cv=none; b=FwPvTdWdbD0WlynoRtIHcAeKAEqh/Bpu/SAjXEjXqTri8Nju8zd6CX7P/Ykal0ulSZaTZgS0ZPwAkEmVDne+EX2IUeI9VtlRVx+SIROI5hktc8r2MJ5Xulv7xWqy7/eBp2kJSpDZw86+nVVtv/Nt3gHg3l3PSEJslunTx4zJHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363007; c=relaxed/simple;
	bh=XmVFctZ6RkEHD80dF9plNNnZF5PKlfN5E7U3OBzDcMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9p1qWLnEPkLkxse7jZWJpICQobQUtrRLYqiivCgCT3jErS4SD7YQ3JxJoQb8rtQ8GU+y2zRK6uKJ9Z0GX1oX9MYrI+fSLqj3bs9w3FMMGtDuJmXg5j2YLHFqF1piuaBfg3mwXGFx7A+e6f2srb1/a1zWFl8JLc1kk8Atm42mvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcR6Rb4zKHMMH;
	Sat, 25 Oct 2025 11:29:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 940001A101B;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S6;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 02/25] ext4: remove page offset calculation in ext4_block_truncate_page()
Date: Sat, 25 Oct 2025 11:21:58 +0800
Message-Id: <20251025032221.2905818-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251025032221.2905818-1-libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1fJFy7WrWfAr1kJr48Xrb_yoW8Jw48pF
	y5K3ykur17uFyjga1IvFn5Xryak3ZrGFWUXFWYq345WryIqF1fKr97K3ZYqFW0qrWxXayv
	qFs0yrWxZa17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdManUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRJGQABsv

From: Baokun Li <libaokun1@huawei.com>

For bs <= ps scenarios, calculating the offset within the block is
sufficient. For bs > ps, an initial page offset calculation can lead to
incorrect behavior. Thus this redundant calculation has been removed.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0742039c53a7..4c04af7e51c9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4183,7 +4183,6 @@ static int ext4_block_zero_page_range(handle_t *handle,
 static int ext4_block_truncate_page(handle_t *handle,
 		struct address_space *mapping, loff_t from)
 {
-	unsigned offset = from & (PAGE_SIZE-1);
 	unsigned length;
 	unsigned blocksize;
 	struct inode *inode = mapping->host;
@@ -4192,8 +4191,8 @@ static int ext4_block_truncate_page(handle_t *handle,
 	if (IS_ENCRYPTED(inode) && !fscrypt_has_encryption_key(inode))
 		return 0;
 
-	blocksize = inode->i_sb->s_blocksize;
-	length = blocksize - (offset & (blocksize - 1));
+	blocksize = i_blocksize(inode);
+	length = blocksize - (from & (blocksize - 1));
 
 	return ext4_block_zero_page_range(handle, mapping, from, length);
 }
-- 
2.46.1


