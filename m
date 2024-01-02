Return-Path: <linux-fsdevel+bounces-7094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01035821BDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98759B21BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837041172C;
	Tue,  2 Jan 2024 12:42:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA4F9D2;
	Tue,  2 Jan 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CCy2gjkz4f3l85;
	Tue,  2 Jan 2024 20:42:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1BBB81A0972;
	Tue,  2 Jan 2024 20:42:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S9;
	Tue, 02 Jan 2024 20:42:07 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v2 05/25] ext4: make ext4_map_blocks() distinguish delalloc only extent
Date: Tue,  2 Jan 2024 20:38:58 +0800
Message-Id: <20240102123918.799062-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47Xw1xGw1DAry7Wry5CFg_yoW8tr4fpa
	95GF1UGFs8uw1j93yxW3W5XF1UKa9Ykw47Cr4rtr4F9asxJr1ftF4q9F4fZF9YgrWxXF4U
	XFWUt348CanIkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoxhL
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add a new map flag EXT4_MAP_DELAYED to indicate the mapping range is a
delayed allocated only (not unwritten) one, and making
ext4_map_blocks() can distinguish it, no longer mixing it with holes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    | 4 +++-
 fs/ext4/extents.c | 5 +++--
 fs/ext4/inode.c   | 2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a5d784872303..55195909d32f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -252,8 +252,10 @@ struct ext4_allocation_request {
 #define EXT4_MAP_MAPPED		BIT(BH_Mapped)
 #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
 #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
+#define EXT4_MAP_DELAYED	BIT(BH_Delay)
 #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
-				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY)
+				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY |\
+				 EXT4_MAP_DELAYED)
 
 struct ext4_map_blocks {
 	ext4_fsblk_t m_pblk;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0892d0568013..fc69f13cf510 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4073,9 +4073,10 @@ static void ext4_ext_determine_hole(struct inode *inode,
 	} else if (in_range(map->m_lblk, es.es_lblk, es.es_len)) {
 		/*
 		 * Straddle the beginning of the queried range, it's no
-		 * longer a hole, adjust the length to the delayed extent's
-		 * after map->m_lblk.
+		 * longer a hole, mark it is a delalloc and adjust the
+		 * length to the delayed extent's after map->m_lblk.
 		 */
+		map->m_flags |= EXT4_MAP_DELAYED;
 		len = es.es_lblk + es.es_len - map->m_lblk;
 		goto out;
 	} else {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1b5e6409f958..c141bf6d8db2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -515,6 +515,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			map->m_len = retval;
 		} else if (ext4_es_is_delayed(&es) || ext4_es_is_hole(&es)) {
 			map->m_pblk = 0;
+			map->m_flags |= ext4_es_is_delayed(&es) ?
+					EXT4_MAP_DELAYED : 0;
 			retval = es.es_len - (map->m_lblk - es.es_lblk);
 			if (retval > map->m_len)
 				retval = map->m_len;
-- 
2.39.2


