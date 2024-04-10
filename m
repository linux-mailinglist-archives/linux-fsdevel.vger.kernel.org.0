Return-Path: <linux-fsdevel+bounces-16580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D6989FA34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A736B1C22E77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D31791E0;
	Wed, 10 Apr 2024 14:38:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AE17277C;
	Wed, 10 Apr 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759916; cv=none; b=DDcyOZ9TWdH+8DSQclu6Vr6UaEK7Oy3g57TqQ7kL38S2Pa4AVdH524LSp1SSdqKc2LSX5neWslxhiPq7tbQ1RptcX8Go/OAWXOmljGLEkXQyLPwZ5Kmrvl2DJw0EHBYYV65wAWCSgujwLGAqSff9Xoj/hfKj1TKhIfZB5ak7WNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759916; c=relaxed/simple;
	bh=zp8Y8W3yQMUZGx/zUI8wawzP1c/idPCnssYAOGv/w4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxjT33mlTKI4DOSQzADFf3YVP52pbm/BPDpWcn4wIzLBIWpEgU5HAtAdrasAnyxzGTU/YF4tyb5sqwhZTVenQClGeDuzDhi7TxFFZaT15JOn4Mzcaaz/4UmRu2P13JD+HibuZPt/D3Jj+32O4jcdDaCZHzUow7b4azOPMJ6rwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF56P4qpWz4f3m7R;
	Wed, 10 Apr 2024 22:38:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 525141A0568;
	Wed, 10 Apr 2024 22:38:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S11;
	Wed, 10 Apr 2024 22:38:30 +0800 (CST)
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
Subject: [PATCH v4 07/34] ext4: factor out check for whether a cluster is allocated
Date: Wed, 10 Apr 2024 22:29:21 +0800
Message-Id: <20240410142948.2817554-8-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S11
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7CF45JrWUJw1kAr1UWrg_yoW8trWxpr
	ZxGF4rXr43Wr97WF4Sqw1DXF1Yga10q3yUJrWa93W8Zr4fJFy5KF1qyF1rXFyrKrW8A3ZI
	qFWUAryUCF4jka7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
	8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
	s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFI
	xGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWx
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sRibyCP
	UUUUU==
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


