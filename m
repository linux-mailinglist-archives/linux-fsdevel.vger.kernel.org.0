Return-Path: <linux-fsdevel+bounces-16606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0F89FB36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0522832C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AB16F91F;
	Wed, 10 Apr 2024 15:11:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29A16DECB;
	Wed, 10 Apr 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761916; cv=none; b=Ki23qOZBr3vgPr0ZyzOHdDcwlQPRYVBgK4G3hE2NgJAHpCGuHlm/VaezQTJN0mus4nyA7tWuGg/YfkdcNAA+vE6KkrlF8Mv5uHEfusTqvjO5jM0e+c7GIhuyP+a8niToMcNEBsTK22DkxAFUyE2/eG6NWIFZ5t3gRS6DH+mDs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761916; c=relaxed/simple;
	bh=T/vqNFdZLEweyqUbp7aJOiOeq8X0ugyC26x/EVdnp2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJ9D3UBEODB2GOuaWOZ5Yrn28QvkclGyvjkJJAus4wGXMUCouF0b5dr7KTw1kdbZKsRf8ZvyveTteDZHEUkNXdOeoOTGd0mNUmClqu4wNB3fxH0fzx5RtZJnGJ0XPQ4/tV0HMhpBPepUX3lwZQsALO1Nw23TOZ18e9O/AZfE3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF5rt4Kcgz4f3mHW;
	Wed, 10 Apr 2024 23:11:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 40BD61A0572;
	Wed, 10 Apr 2024 23:11:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4orBZmFSt+Jg--.51485S8;
	Wed, 10 Apr 2024 23:11:50 +0800 (CST)
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
Subject: [RFC PATCH v4 33/34] ext4: don't mark IOMAP_F_DIRTY for buffer write
Date: Wed, 10 Apr 2024 23:03:12 +0800
Message-Id: <20240410150313.2820364-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn9g4orBZmFSt+Jg--.51485S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1ftw1xCr1fGr13ury3Arb_yoW8CF17pr
	s7tFZ5X3WkXr9F9F4IqrW3ZFWrKa1xKFWUArWIka12v3sxJw1xtrsYgFyrZFZxGFyfAaya
	qF1jq34xWw4xCrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UM4x0x7Aq67
	IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7xRN6wZUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The data sync dirty check in ext4_inode_datasync_dirty() is expansive
since jbd2_transaction_committed() holds journal->j_state lock when
journal is enabled, it costs a lot in high-concurrency iomap buffered
read/write paths, but we never check IOMAP_F_DIRTY in these cases, so
let's check it only in swap file, dax and direct IO cases. Tested by
Unixbench on 100GB ramdisk:

./Run -c 128 -i 10 fstime fsbuffer fsdisk

  == without this patch ==
  128 CPUs in system; running 128 parallel copies of tests

  File Copy 1024 bufsize 2000 maxblocks       6332521.0 KBps
  File Copy 256 bufsize 500 maxblocks         1639726.0 KBps
  File Copy 4096 bufsize 8000 maxblocks      24018572.0 KBps

  == with this patch ==
  128 CPUs in system; running 128 parallel copies of tests

  File Copy 1024 bufsize 2000 maxblocks      49229257.0 KBps
  File Copy 256 bufsize 500 maxblocks        24057510.0 KBps
  File Copy 4096 bufsize 8000 maxblocks      75704437.0 KBps

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1cb219d347af..269503749ef5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3281,9 +3281,13 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	 * there is no other metadata changes being made or are pending.
 	 */
 	iomap->flags = 0;
-	if (ext4_inode_datasync_dirty(inode) ||
-	    offset + length > i_size_read(inode))
-		iomap->flags |= IOMAP_F_DIRTY;
+	if ((flags & (IOMAP_DAX | IOMAP_REPORT)) ||
+	    ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) ==
+	     (IOMAP_WRITE | IOMAP_DIRECT))) {
+		if (offset + length > i_size_read(inode) ||
+		    ext4_inode_datasync_dirty(inode))
+			iomap->flags |= IOMAP_F_DIRTY;
+	}
 
 	if (map->m_flags & EXT4_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
-- 
2.39.2


