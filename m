Return-Path: <linux-fsdevel+bounces-19675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A888C8699
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C37B20AF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D360B95;
	Fri, 17 May 2024 12:51:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D65C603;
	Fri, 17 May 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950267; cv=none; b=TMQYtn3saZNUc+shwHbqfdt0vm31SYeeOxIJ/dNILJM5sbZdrmNVOPDDi/cVIfJE/fszQS6xARLouL2BUZNgeFHxEyXd10kq1LsytPE2vHEz19j3t9mLGxM/DdserTan+HZcb0PhMcjRC5+jDblnDq0STnBqLFWizmrENe9hHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950267; c=relaxed/simple;
	bh=s1IkFJd7/I77fwUqJvPyYPWZdG81k2OWJkUa6a76Vkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTUQiq2Ab6ESUpYdy0unt6P7BX1u505QBRIFpzl34xq+y1hkCvLM9Ff/HkelEZE0VYDwpEn9sBsICtPFwHe3oPob1+QZGzEm3OX7QR7J1ASqN3kDcbRffuFfPCU8QnmD6kEARfgC+ibxBxOGnNRdNIPv2cfBk6rliKkdqrVcfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VgmzC6FYVz4f3jrg;
	Fri, 17 May 2024 20:50:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9BFD71A0AE0;
	Fri, 17 May 2024 20:50:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGdUkdmdAmqMw--.14380S8;
	Fri, 17 May 2024 20:50:56 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 04/10] ext4: trim delalloc extent
Date: Fri, 17 May 2024 20:39:59 +0800
Message-Id: <20240517124005.347221-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGdUkdmdAmqMw--.14380S8
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyrAF4kXFy3Wr1UZr4DXFb_yoW5KF45pr
	Z3CF1rGr4xW3429ayxJF1UXF1rG3Z8KrW7Grn5GryrZas8Gr1Ska4qya42yFyjgrs3XF1Y
	qFW8t34UCa1ayrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU17G
	YJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In ext4_da_map_blocks(), we could find four kind of extents in the
extent status tree: hole, unwritten, written and delayed extent. Now we
only trim the map len if we found an unwritten extent or a written
extent. This is okay now since map->m_len is always set to one and we
always insert one delayed block at a time. But this will become isn't
okay for other two cases if ext4_insert_delayed_block() and
ext4_da_map_blocks() support inserting multiple map->len blocks later.

1. If we found a hole in the extent status tree which es->es_len is
   shorter than the length we want to write, we should trim the
   map->m_len to prevent adding extra delay more blocks than we
   expected. For example, assume we write data [A, C) to a file that
   contains a hole extent [A, B) and a written extent [B, D) in the
   cache.

                         A     B  C  D
   before da write:   ...hhhhhh|wwwwww....

   Then we will get extent [A, B), we should trim map->m_len to B-A
   before inserting new delalloc blocks, if not, the range [B, C) will
   be duplicated.

2. If we found a delayed extent in the extent status tree which
   es->es_len is shorter than the length we want to write, we should
   trim the map->m_len to es->es_len and return directly since the front
   part of this map has been delayed, we can't insert the delalloc
   extent that contains the latter part in this round, we should return
   the delayed length and the caller should increase the position and
   call ext4_da_map_blocks() again. For example, assume we write data
   [A, C) to a file that contains a delayed extent [A, B) in the cache.

                         A     B  C
   before da write:   ...dddddd|hhh....

   Then we will get delayed extent [A, B), we should also trim map->m_len
   to B-A and return, if not, we will incorrectly assume that the write
   is complete and won't insert [B, C).

So we need to always trim the map->m_len if the found es->es_len in the
extent status tree is shorter than the map->m_len, prearing for
inserting a extent with multiple delalloc blocks. This patch only does a
pre-fix, the handle is crude and ext4_da_map_blocks() deserve a cleanup,
we will do that later.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6114ca79f464..fb76016e2ab7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1734,6 +1734,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
+		retval = es.es_len - (iblock - es.es_lblk);
+		if (retval > map->m_len)
+			retval = map->m_len;
+		map->m_len = retval;
+
 		if (ext4_es_is_hole(&es))
 			goto add_delayed;
 
@@ -1750,10 +1755,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		}
 
 		map->m_pblk = ext4_es_pblock(&es) + iblock - es.es_lblk;
-		retval = es.es_len - (iblock - es.es_lblk);
-		if (retval > map->m_len)
-			retval = map->m_len;
-		map->m_len = retval;
 		if (ext4_es_is_written(&es))
 			map->m_flags |= EXT4_MAP_MAPPED;
 		else if (ext4_es_is_unwritten(&es))
@@ -1790,6 +1791,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	 * the extent status tree.
 	 */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
+		retval = es.es_len - (iblock - es.es_lblk);
+		if (retval > map->m_len)
+			retval = map->m_len;
+		map->m_len = retval;
+
 		if (!ext4_es_is_hole(&es)) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			goto found;
-- 
2.39.2


