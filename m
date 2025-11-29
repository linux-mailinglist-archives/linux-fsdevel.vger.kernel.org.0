Return-Path: <linux-fsdevel+bounces-70226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E67C93C8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 11:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3A343440B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E72D0636;
	Sat, 29 Nov 2025 10:35:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40F2C0263;
	Sat, 29 Nov 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412546; cv=none; b=tkIsm+ZyzR6pPlmI6QQ2kGSJnf8s6HAK30hLK/aZMWlnsvsG/dCs5mmXBlDtGRNDWyLWLQEF5hNjadnVmF+Y4TAOj3ix1fNzc8cLeXSwahgBNZM7vgMk+p6X+xbHctRQgDAbqafIq75yaX9MrTNGJ/8dntdwvsbdcYL/7YAM/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412546; c=relaxed/simple;
	bh=KzoY1o5o5HkeAz5GtXXnuXi2hP9iQuJUxW+HhuJTzWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahGOmvpcyqiqcTP5ifsJUEjHPEQra1sI7e8nFF7pqXdyRJMROiaoz2B5Q2Ccm4szGVhF7u6ckzQ9Yi/NPViN5HGYKrM8y9PoP2vj/S9rXPsrJ4JWwUfUS1KUXe9LvPCv1HxweBroN8zngynxKhOYmPbfUAOmkvAx1ANHbdRg6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJRPM5vVYzKHMQH;
	Sat, 29 Nov 2025 18:34:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 014DA1A07BD;
	Sat, 29 Nov 2025 18:35:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXtfzCpp_56qCQ--.62661S13;
	Sat, 29 Nov 2025 18:35:30 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 09/14] ext4: cleanup useless out label in __es_remove_extent()
Date: Sat, 29 Nov 2025 18:32:41 +0800
Message-ID: <20251129103247.686136-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXtfzCpp_56qCQ--.62661S13
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3ZrW8Ar4DWrykWr4Uurg_yoW8ZrW5pa
	1Fv34DWry8Zw40g397tw1Durya93WxGFW7Wryftw1S9FyYqryFgr10ya1YvFyFqFW8K3yU
	XF40yw1jkay7tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The out label in __es_remove_extent() is just return err value, we can
return it directly if something bad happens. Therefore, remove the
useless out label and rename out_get_reserved to out.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
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


