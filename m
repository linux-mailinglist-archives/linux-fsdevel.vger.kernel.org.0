Return-Path: <linux-fsdevel+bounces-44397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1CA68347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CB317C731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 02:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EE524EA80;
	Wed, 19 Mar 2025 02:44:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284324E4B3;
	Wed, 19 Mar 2025 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352268; cv=none; b=ejGtN4zTBn2lqLx7vzoWkBXYMa5BblQ+7E7+OQd0qGbY1xRooe8ukdvQNLIPW3B9nVF/kYB/tOskWI/r57mO2U4mFv6crJHe6YsIxs/WuGR8KG8zOWPVugV56gKwLdmrU3fSh6RJlIA3qOxPb3CylQvt4ktS9qDsdZP0/d6pqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352268; c=relaxed/simple;
	bh=L4ulcOS7GCKn+YrYuDMf8QtN622G6UZFpbIe2jeJhRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+EL5Yzs0cuSPBVNTcGMtZfpiqw3+ox8rtTqyGsqGmWXfVe8i2EuxLhcrfpYguA264WB08ZfPBvH2Cbff84GCnKllEMObmXhdtDyTUntFQkwgJustXpd/J3fBAk+hDOyg+kJaJtpu6qGTPmihZUJczXwXuls9uPLeuSDCOw7hk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZHY1p5XMpz4f3khl;
	Wed, 19 Mar 2025 10:43:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 661281A0EC1;
	Wed, 19 Mar 2025 10:44:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXu198L9pnG5ymGw--.11145S4;
	Wed, 19 Mar 2025 10:44:21 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next] ext4: correct the error handle in ext4_fallocate()
Date: Wed, 19 Mar 2025 10:35:57 +0800
Message-ID: <20250319023557.2785018-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu198L9pnG5ymGw--.11145S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XFykZr45Gw4xKFyDJryrJFb_yoWfJrg_Ca
	yUur4kWrWftFs293yrur1SyF12kw1kGr4rWFs3Xrs3ZF1UJ3yvka4vyr17ZFZ8Wr47Grsx
	CFn2qF18AF1IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The error out label of file_modified() should be out_inode_lock in
ext4_fallocate().

Fixes: 2890e5e0f49e ("ext4: move out common parts into ext4_fallocate()")
Reported-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1b028be19193..dcc49df190ed 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4744,7 +4744,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	ret = file_modified(file);
 	if (ret)
-		return ret;
+		goto out_inode_lock;
 
 	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
 		ret = ext4_do_fallocate(file, offset, len, mode);
-- 
2.46.1


