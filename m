Return-Path: <linux-fsdevel+bounces-63737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DD4BCC8A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E9F3AB3D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DAA2EDD45;
	Fri, 10 Oct 2025 10:34:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3E34BA39;
	Fri, 10 Oct 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092479; cv=none; b=BdqfFqUno2NssdhB6Ya4P4ULXa2oEWr/uZweNsViMLoaZ6C3T8JgoRe3lzjfW60BDxJw9Y9I6LKwOVips46lo5EffMFU1gc7y5RP128X9U28ZfuwP1pLvQrAQ7UDDIsVBF5yHbRPACZUiVFqBk+3Mg3Wendosb6ePKNK7huDLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092479; c=relaxed/simple;
	bh=5/sfsbtw6iIXz/PCef9UHqJUh7c2SsT1Y+pUbzGv4Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YroEdyr6o51nwrzDzEepn/e7VCzhPgC3mQ63vHZYbeXHsyohVHlULMheeyNhcFA0PWKXc1uS71GdYGLCPSAs8b4QICPuxY66zanIZzUSxrUb1GYK4QW4+Io8Xk6yP8G/9snAJE4OeVhbyXacP2r5uSVl+7w2c343LCl6IBFxP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cjjlc13F6zKHMyW;
	Fri, 10 Oct 2025 18:34:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 52E531A0FEA;
	Fri, 10 Oct 2025 18:34:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCHS2Ms4ehoxOK5CQ--.63632S8;
	Fri, 10 Oct 2025 18:34:34 +0800 (CST)
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
Subject: [PATCH v3 04/12] ext4: pass out extent seq counter when mapping blocks
Date: Fri, 10 Oct 2025 18:33:18 +0800
Message-ID: <20251010103326.3353700-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
References: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHS2Ms4ehoxOK5CQ--.63632S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXryrtr4xKrWrGw15CryDJrb_yoW5KFW7pr
	ZrAr1rGr4UWw1q9F4SyF4UZF1a93W5KrW7JrZ7WryFya4fJrn3tF1jyF1SyFyDKrWfX3WF
	qF45K34UCa1fGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When creating or querying mapping blocks using the ext4_map_blocks() and
ext4_map_{query|create}_blocks() helpers, also pass out the extent
sequence number of the block mapping info through the ext4_map_blocks
structure. This sequence number can later serve as a valid cookie within
iomap infrastructure and the move extents procedure.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/inode.c | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index eff97b3a1093..9f127aedbaee 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -260,6 +260,7 @@ struct ext4_map_blocks {
 	ext4_lblk_t m_lblk;
 	unsigned int m_len;
 	unsigned int m_flags;
+	u64 m_seq;
 };
 
 /*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10792772b450..ad8deae1c7c3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -550,10 +550,13 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 		retval = ext4_ext_map_blocks(handle, inode, map, flags);
 	else
 		retval = ext4_ind_map_blocks(handle, inode, map, flags);
-
-	if (retval <= 0)
+	if (retval < 0)
 		return retval;
 
+	/* A hole? */
+	if (retval == 0)
+		goto out;
+
 	if (unlikely(retval != map->m_len)) {
 		ext4_warning(inode->i_sb,
 			     "ES len assertion failed for inode "
@@ -573,11 +576,13 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status, false);
-		return retval;
+	} else {
+		retval = ext4_map_query_blocks_next_in_leaf(handle, inode, map,
+							    orig_mlen);
 	}
-
-	return ext4_map_query_blocks_next_in_leaf(handle, inode, map,
-						  orig_mlen);
+out:
+	map->m_seq = READ_ONCE(EXT4_I(inode)->i_es_seq);
+	return retval;
 }
 
 static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
@@ -649,7 +654,7 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	 * extent status tree.
 	 */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
-	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
+	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
 		if (ext4_es_is_written(&es))
 			return retval;
 	}
@@ -658,6 +663,7 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
 			      status, flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE);
+	map->m_seq = READ_ONCE(EXT4_I(inode)->i_es_seq);
 
 	return retval;
 }
@@ -723,7 +729,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		ext4_check_map_extents_env(inode);
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
 		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
 			map->m_pblk = ext4_es_pblock(&es) +
 					map->m_lblk - es.es_lblk;
@@ -1979,6 +1985,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 
 	map->m_flags |= EXT4_MAP_DELAYED;
 	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
+	if (!retval)
+		map->m_seq = READ_ONCE(EXT4_I(inode)->i_es_seq);
 	up_write(&EXT4_I(inode)->i_data_sem);
 
 	return retval;
-- 
2.46.1


