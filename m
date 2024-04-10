Return-Path: <linux-fsdevel+bounces-16540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E289F832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FDF283ADF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC5D15F30A;
	Wed, 10 Apr 2024 13:36:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8513D607;
	Wed, 10 Apr 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756217; cv=none; b=q0A6ncN8ZLdy47FVtRjhjg9P8YBlkfenXJmGl/hmB93yEDvwv5+I9L0LIrfGzNspGUmW/pDzyWPEsdBES3vyKL74HFxjOsW7nrDP+tC480oO2WXV8uRT87a/7IlwOBoEpZnlHHylhd4WnLQobIBZJ9xAMQECqelLjuVRdsXnsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756217; c=relaxed/simple;
	bh=zp8Y8W3yQMUZGx/zUI8wawzP1c/idPCnssYAOGv/w4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwkIgJTcSm09mGzINweDawuwOtDgfGLBSxDqYoS4iKwveuxO5Co56hh6zRjD1X31ciVMgar3W1ekGnf4pawVsxyGqoh7dTKYyGaY2wLDQXS3JNJEwscFIqhiHgrJ8PeSy6TTyTrfqz+gbH761u4AJIkRg0rIV6M/S4Xthr7wlms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF3lH50tYz4f3mHT;
	Wed, 10 Apr 2024 21:36:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 598611A058D;
	Wed, 10 Apr 2024 21:36:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S11;
	Wed, 10 Apr 2024 21:36:52 +0800 (CST)
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
Subject: [PATCH v4 07/34] ext4: factor out check for whether a cluster is allocated
Date: Wed, 10 Apr 2024 21:27:51 +0800
Message-Id: <20240410132818.2812377-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
References: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S11
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7CF45JrWUJw1kAr1UWrg_yoW8trWxpr
	ZxGF4rXr43Wr97WF4Sqw1DXF1Yga10q3yUJrWa93W8Zr4fJFy5KF1qyF1rXFyrKrW8A3ZI
	qFWUAryUCF4jka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Factor out a common helper ext4_da_check_clu_allocated(), check whether
the cluster containing a delalloc block to be added has been delayed or
allocated, no logic changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 52 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1180a9eb4362..46c34baa848a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1649,6 +1649,34 @@ static void ext4_print_free_blocks(struct inode *inode)
 	return;
 }
 
+/*
+ * Check whether the cluster containing lblk has been delayed or allocated,
+ * if not, it means we should reserve a cluster when add delalloc, return 1,
+ * otherwise return 0 or error code.
+ */
+static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
+				       bool *allocated)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int ret;
+
+	*allocated = false;
+	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
+		return 0;
+
+	if (ext4_es_scan_clu(inode, &ext4_es_is_mapped, lblk))
+		goto allocated;
+
+	ret = ext4_clu_mapped(inode, EXT4_B2C(sbi, lblk));
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return 1;
+allocated:
+	*allocated = true;
+	return 0;
+}
+
 /*
  * ext4_insert_delayed_block - adds a delayed block to the extents status
  *                             tree, incrementing the reserved cluster/block
@@ -1682,23 +1710,13 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		if (ret != 0)   /* ENOSPC */
 			return ret;
 	} else {   /* bigalloc */
-		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
-			if (!ext4_es_scan_clu(inode,
-					      &ext4_es_is_mapped, lblk)) {
-				ret = ext4_clu_mapped(inode,
-						      EXT4_B2C(sbi, lblk));
-				if (ret < 0)
-					return ret;
-				if (ret == 0) {
-					ret = ext4_da_reserve_space(inode, 1);
-					if (ret != 0)   /* ENOSPC */
-						return ret;
-				} else {
-					allocated = true;
-				}
-			} else {
-				allocated = true;
-			}
+		ret = ext4_da_check_clu_allocated(inode, lblk, &allocated);
+		if (ret < 0)
+			return ret;
+		if (ret > 0) {
+			ret = ext4_da_reserve_space(inode, 1);
+			if (ret != 0)   /* ENOSPC */
+				return ret;
 		}
 	}
 
-- 
2.39.2


