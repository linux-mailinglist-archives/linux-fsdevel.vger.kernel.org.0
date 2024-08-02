Return-Path: <linux-fsdevel+bounces-24867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E496E945D84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C24AB234C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849F1E485A;
	Fri,  2 Aug 2024 11:55:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA31E3CC8;
	Fri,  2 Aug 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599710; cv=none; b=UgUFU5vl1DgelA5zbIP7Jxf2wFfHIdcGN+K/eYunN10Rfg6mpVaCMA9l9r/J+uCFGHmnefxtdnPPYi5rXCZqDjjTe+ZSsmgY5p8Y+q7uto/PZat2jq71z/GRv/yy90cTq2SPw3CbHGF6EjpmGUYoBkFYzyk6jYsK7UwF6lRIsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599710; c=relaxed/simple;
	bh=9kW3tECN9MZ0ta2LI9J8v9Xqm4Vs9wrHW0yWnza1RGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xly648VqU/wvJzFMV3/gBXyZyfT8oBEBkvZ8oftneJqf7RWqYsdWjDQlrydxxW53zuF5cW3oGS+7Iva9GvSgVDpKqHg6c11TvIxfQL89w4KBA5WFusG4kBKmhEnQo4PtLCjimiRBQr0erbJvntldskpGYrXZgbfJDL8DexQYIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb4580GXcz4f3lfp;
	Fri,  2 Aug 2024 19:54:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1B4A41A17E8;
	Fri,  2 Aug 2024 19:55:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S12;
	Fri, 02 Aug 2024 19:55:05 +0800 (CST)
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
Subject: [PATCH v2 08/10] ext4: use ext4_map_query_blocks() in ext4_map_blocks()
Date: Fri,  2 Aug 2024 19:51:18 +0800
Message-Id: <20240802115120.362902-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S12
X-Coremail-Antispam: 1UD129KBjvJXoW7WF18Wry7Wry3Jr1kuF43GFg_yoW8GrW5pr
	9xAryfGw1UWw1q9a1xKF18ZryxK3W5KrWqqFWxGr1rZ345Crn3tF45tFyfAFWDKrZ7Xw4Y
	qFWrGry8C3y5GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VU1zpBDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The blocks map querying logic in ext4_map_blocks() are the same as
ext4_map_query_blocks(), so switch to directly use it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e9ce1e4e6acb..8bd65a45a26a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -658,27 +658,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * file system block.
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		retval = ext4_ext_map_blocks(handle, inode, map, 0);
-	} else {
-		retval = ext4_ind_map_blocks(handle, inode, map, 0);
-	}
-	if (retval > 0) {
-		unsigned int status;
-
-		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
-				     "ES len assertion failed for inode "
-				     "%lu: retval %d != map->m_len %d",
-				     inode->i_ino, retval, map->m_len);
-			WARN_ON(1);
-		}
-
-		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
-				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status);
-	}
+	retval = ext4_map_query_blocks(handle, inode, map);
 	up_read((&EXT4_I(inode)->i_data_sem));
 
 found:
-- 
2.39.2


