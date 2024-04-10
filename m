Return-Path: <linux-fsdevel+bounces-16599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7B789FA6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE481F2BF5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362FD1836C7;
	Wed, 10 Apr 2024 14:38:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8D16E865;
	Wed, 10 Apr 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759928; cv=none; b=kSyDLCFNU/3Hjl3IZFrwKUQhlUO0PyhIp9kLzy7wgrtdESD0pEjzfuaRTWT2UcrRtPrOwZgXnP+alAtF3R+T1ZBxqoU1xoqv9i1tZHvSJNLKJ1JuyhTs7+XY0yeZcRD1OQdov+nKFqZ807/RtiHmIlePsdG3nmdHVdPXM1YKDXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759928; c=relaxed/simple;
	bh=a0yXsZEWte2+yhfLSEWGmnTc+medZk5RJjxW91j+Nrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rP+cFwFsuAySm6l85RR+VdlyUoh3B4gWSZe3NAyhGUc4YPbzfUIw503OgxK4Ih0VXSKfVPVmnNPMo+/BfVPR1pQ15abTG9OsY67PXE3Q7cWDAMh4UHzrl+26XxGFHjapkq0l0H9MuGnwszXEBW3GJ1PNmXLCx8sRRLk1pyPMMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF56h30y5z4f3knS;
	Wed, 10 Apr 2024 22:38:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 419FF1A0179;
	Wed, 10 Apr 2024 22:38:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S31;
	Wed, 10 Apr 2024 22:38:42 +0800 (CST)
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
Subject: [RFC PATCH v4 27/34] ext4: implement zero_range iomap path
Date: Wed, 10 Apr 2024 22:29:41 +0800
Message-Id: <20240410142948.2817554-28-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S31
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7CrW8XF1rKFW7Gr1rJFb_yoW8JFWDpr
	n5K34UCr47Wr9F9F4IgF9rXr1Iy3W5Gw48WryfGrn8Z3yfW34xKFWrK3WFvF4jg3y7Jayj
	qF45try8Kw17AaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
	1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7sRibyCPUUUU
	U==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add ext4_iomap_zero_range() for the zero_range iomap path, it zero out
the mapped blocks, all work have been done in iomap_zero_range(), so
call it directly.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d694c780007..5af3b8acf1b9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4144,6 +4144,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	return err;
 }
 
+static int ext4_iomap_zero_range(struct inode *inode,
+				 loff_t from, loff_t length)
+{
+	return iomap_zero_range(inode, from, length, NULL,
+				&ext4_iomap_buffered_read_ops);
+}
+
 /*
  * ext4_block_zero_page_range() zeros out a mapping of length 'length'
  * starting from file offset 'from'.  The range to be zero'd must
@@ -4169,6 +4176,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
 	if (IS_DAX(inode)) {
 		return dax_zero_range(inode, from, length, NULL,
 				      &ext4_iomap_ops);
+	} else if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
+		return ext4_iomap_zero_range(inode, from, length);
 	}
 	return __ext4_block_zero_page_range(handle, mapping, from, length);
 }
-- 
2.39.2


