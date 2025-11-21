Return-Path: <linux-fsdevel+bounces-69349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84617C77855
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD4E64E90D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7172EBBAF;
	Fri, 21 Nov 2025 06:10:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A72E1C6F;
	Fri, 21 Nov 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705431; cv=none; b=IZos1j4jfDnOZVmKrbbWU+a2PClv2lfbnescj2jVbtjE3hOzGl7hoXNS+lLSjyZSgx4rkgCN084lF8i/4VIxs89NqRFpNXfxZh2dWP88JiAh1/7myXwpo0c0AxIiQ5kX8cChfExk9WzqKj2HvKOTXhTaNlbqbNOgXGaziT8ghDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705431; c=relaxed/simple;
	bh=+lzYgEZSn1+GQtREZCXiiSon7j+Jz5t9UWVUhwwF2aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czPQADLlDLG+5BAVL3H7UCZ9qPMsbB40NqEKVb5TCqh5+TAWsjPcrDDl3JL8Hgx2Hnu6HcqCuL4dCdF8Bsg1dBkFq4zCF0xdD/y7E1bI9xwJDWvNZzd2WDA4quswkyfXGlyk6HRBGzXvarqh57g21BYkPLyiz43P+Ugt9P/MfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCPvC6cFKzYQv4J;
	Fri, 21 Nov 2025 14:09:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F0EDA1A0359;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHtAAiBp_of0BQ--.63807S12;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 08/13] ext4: cleanup useless out tag in __es_remove_extent()
Date: Fri, 21 Nov 2025 14:08:06 +0800
Message-ID: <20251121060811.1685783-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHtAAiBp_of0BQ--.63807S12
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWDuFWfGrWkGryfJFyxZrb_yoW8Cr13pw
	4rZ34DWryrZw10g397tw1Durya9a40krWUWryftw1fuFy5XryFgF10ya1YvFyFqFW0gw4j
	qF40yw1jkay7tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The out tag in __es_remove_extent() is just return err value, we can
return it directly if something bad happens. Therefore, remove the
useless out tag and rename out_get_reserved to out.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index e04fbf10fe4f..04d56f8f6c0c 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1434,7 +1434,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status orig_es;
 	ext4_lblk_t len1, len2;
 	ext4_fsblk_t block;
-	int err = 0;
+	int err;
 	bool count_reserved = true;
 	struct rsvd_count rc;
 
@@ -1443,9 +1443,9 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
-		goto out;
+		return 0;
 	if (es->es_lblk > end)
-		goto out;
+		return 0;
 
 	/* Simply invalidate cache_es. */
 	tree->cache_es = NULL;
@@ -1480,7 +1480,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 				es->es_lblk = orig_es.es_lblk;
 				es->es_len = orig_es.es_len;
-				goto out;
+				return err;
 			}
 		} else {
 			es->es_lblk = end + 1;
@@ -1494,7 +1494,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		if (count_reserved)
 			count_rsvd(inode, orig_es.es_lblk + len1,
 				   orig_es.es_len - len1 - len2, &orig_es, &rc);
-		goto out_get_reserved;
+		goto out;
 	}
 
 	if (len1 > 0) {
@@ -1536,11 +1536,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		}
 	}
 
-out_get_reserved:
+out:
 	if (count_reserved)
 		*reserved = get_rsvd(inode, end, es, &rc);
-out:
-	return err;
+	return 0;
 }
 
 /*
-- 
2.46.1


