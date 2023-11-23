Return-Path: <linux-fsdevel+bounces-3525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AC7F5F6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 13:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14F1B21807
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621602557A;
	Thu, 23 Nov 2023 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABFD43;
	Thu, 23 Nov 2023 04:52:04 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SbdKp5DtBz4f3jYW;
	Thu, 23 Nov 2023 20:51:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6C0F21A0221;
	Thu, 23 Nov 2023 20:52:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S7;
	Thu, 23 Nov 2023 20:52:00 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH 03/18] ext4: correct the hole length returned by ext4_map_blocks()
Date: Thu, 23 Nov 2023 20:51:05 +0800
Message-Id: <20231123125121.4064694-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
References: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S7
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17Xw4fCr47trWDJrW3Awb_yoW8Kw1fpr
	ZxAF1fGw48Ww129F4fJF4UWF13K3W8tay7JrWfJr1rCay5C3WSgF1UAF1IyFZYgrW8XF1Y
	qF4UtryUCw4ay3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In ext4_map_blocks(), if we can't find a range of mapping in the
extents cache, we are calling ext4_ext_map_blocks() to search the real
path. But if the querying range was tail overlaped by a delayed extent,
we can't find it on the real extent path, so the returned hole length
could be larger than it really is.

      |          querying map          |
      v                                v
      |----------{-------------}{------|----------------}-----...
      ^          ^             ^^                       ^
      | uncached | hole extent ||     delayed extent    |

We have to adjust the mapping length to the next not hole extent's
lblk before searching the extent path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4ce35f1c8b0a..94e7b8500878 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -479,6 +479,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    struct ext4_map_blocks *map, int flags)
 {
 	struct extent_status es;
+	ext4_lblk_t next;
 	int retval;
 	int ret = 0;
 #ifdef ES_AGGRESSIVE_TEST
@@ -502,8 +503,10 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		return -EFSCORRUPTED;
 
 	/* Lookup extent status tree firstly */
-	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
-	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		goto uncached;
+
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
 			map->m_pblk = ext4_es_pblock(&es) +
 					map->m_lblk - es.es_lblk;
@@ -532,6 +535,23 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 #endif
 		goto found;
 	}
+	/*
+	 * Not found, maybe a hole, need to adjust the map length before
+	 * seraching the real extent path. It can prevent incorrect hole
+	 * length returned if the following entries have delayed only
+	 * ones.
+	 */
+	if (!(flags & EXT4_GET_BLOCKS_CREATE) && es.es_lblk > map->m_lblk) {
+		next = es.es_lblk;
+		if (ext4_es_is_hole(&es))
+			next = ext4_es_skip_hole_extent(inode, map->m_lblk,
+							map->m_len);
+		retval = next - map->m_lblk;
+		if (map->m_len > retval)
+			map->m_len = retval;
+	}
+
+uncached:
 	/*
 	 * In the query cache no-wait mode, nothing we can do more if we
 	 * cannot find extent in the cache.
-- 
2.39.2


