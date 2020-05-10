Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F78B1CC748
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgEJG0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:26:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727122AbgEJG0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:26:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A63AYB043384;
        Sun, 10 May 2020 02:25:52 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ws59bx1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:52 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6KLr6020427;
        Sun, 10 May 2020 06:25:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 30wm558t4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PlEp52363756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 923C042047;
        Sun, 10 May 2020 06:25:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2AE642041;
        Sun, 10 May 2020 06:25:45 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:45 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 15/16] ext4: Make ext_debug() implementation to use pr_debug()
Date:   Sun, 10 May 2020 11:54:55 +0530
Message-Id: <d31dc189b0aeda9384fe7665e36da7cd8c61571f.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=3 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext_debug() msgs could be helpful, provided those could be enabled
without recompiling kernel and also if we could selectively enable
only required prints for case by case debugging.

So make ext_debug() implementation use pr_debug().
Also change ext_debug() to be defined with CONFIG_EXT4_DEBUG.
So EXT_DEBUG macro now mostly remain for below 3 functions.
ext4_ext_show_path/leaf/move() (whose print msgs use ext_debug()
which again could be dynamically enabled using pr_debug())

This also changes the ext_debug() to take inode as a parameter
to add inode no. in all of it's msgs.
Prints additional info like process name / pid, superblock id etc.
This also removes any explicit function names passed in ext_debug().
Since ext_debug() on it's own prints file, func and line no.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/Kconfig   |   2 +-
 fs/ext4/ext4.h    |  18 ++++--
 fs/ext4/extents.c | 144 ++++++++++++++++++++++------------------------
 fs/ext4/inode.c   |  11 ++--
 4 files changed, 87 insertions(+), 88 deletions(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 02376ddb0cb5..cf9e430514c4 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -99,7 +99,7 @@ config EXT4_DEBUG
 	  Enables run-time debugging support for the ext4 filesystem.
 
 	  If you select Y here, then you will be able to turn on debugging
-	  using dynamic debug control for mb_debug() msgs.
+	  using dynamic debug control for mb_debug() / ext_debug() msgs.
 
 config EXT4_KUNIT_TESTS
 	tristate "KUnit tests for ext4"
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42d7af18157d..fb37fb3fe689 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -80,14 +80,22 @@
 #define ext4_debug(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
+ /*
+  * Turn on EXT_DEBUG to enable ext4_ext_show_path/leaf/move in extents.c
+  */
+#define EXT_DEBUG__
+
 /*
- * Turn on EXT_DEBUG to get lots of info about extents operations.
+ * Dynamic printk for controlled extents debugging.
  */
-#define EXT_DEBUG__
-#ifdef EXT_DEBUG
-#define ext_debug(fmt, ...)	printk(fmt, ##__VA_ARGS__)
+#ifdef CONFIG_EXT4_DEBUG
+#define ext_debug(ino, fmt, ...)					\
+	pr_debug("[%s/%d] EXT4-fs (%s): ino %lu: (%s, %d): %s:" fmt,	\
+		 current->comm, task_pid_nr(current),			\
+		 ino->i_sb->s_id, ino->i_ino, __FILE__, __LINE__,	\
+		 __func__, ##__VA_ARGS__)
 #else
-#define ext_debug(fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+#define ext_debug(ino, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /* data type for block offset of block group */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index dc980fbc49aa..155f9c6c1279 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -600,22 +600,22 @@ static void ext4_ext_show_path(struct inode *inode, struct ext4_ext_path *path)
 {
 	int k, l = path->p_depth;
 
-	ext_debug("path:");
+	ext_debug(inode, "path:");
 	for (k = 0; k <= l; k++, path++) {
 		if (path->p_idx) {
-			ext_debug("  %d->%llu",
+			ext_debug(inode, "  %d->%llu",
 				  le32_to_cpu(path->p_idx->ei_block),
 				  ext4_idx_pblock(path->p_idx));
 		} else if (path->p_ext) {
-			ext_debug("  %d:[%d]%d:%llu ",
+			ext_debug(inode, "  %d:[%d]%d:%llu ",
 				  le32_to_cpu(path->p_ext->ee_block),
 				  ext4_ext_is_unwritten(path->p_ext),
 				  ext4_ext_get_actual_len(path->p_ext),
 				  ext4_ext_pblock(path->p_ext));
 		} else
-			ext_debug("  []");
+			ext_debug(inode, "  []");
 	}
-	ext_debug("\n");
+	ext_debug(inode, "\n");
 }
 
 static void ext4_ext_show_leaf(struct inode *inode, struct ext4_ext_path *path)
@@ -631,14 +631,14 @@ static void ext4_ext_show_leaf(struct inode *inode, struct ext4_ext_path *path)
 	eh = path[depth].p_hdr;
 	ex = EXT_FIRST_EXTENT(eh);
 
-	ext_debug("Displaying leaf extents for inode %lu\n", inode->i_ino);
+	ext_debug(inode, "Displaying leaf extents\n");
 
 	for (i = 0; i < le16_to_cpu(eh->eh_entries); i++, ex++) {
-		ext_debug("%d:[%d]%d:%llu ", le32_to_cpu(ex->ee_block),
+		ext_debug(inode, "%d:[%d]%d:%llu ", le32_to_cpu(ex->ee_block),
 			  ext4_ext_is_unwritten(ex),
 			  ext4_ext_get_actual_len(ex), ext4_ext_pblock(ex));
 	}
-	ext_debug("\n");
+	ext_debug(inode, "\n");
 }
 
 static void ext4_ext_show_move(struct inode *inode, struct ext4_ext_path *path,
@@ -651,10 +651,9 @@ static void ext4_ext_show_move(struct inode *inode, struct ext4_ext_path *path,
 		struct ext4_extent_idx *idx;
 		idx = path[level].p_idx;
 		while (idx <= EXT_MAX_INDEX(path[level].p_hdr)) {
-			ext_debug("%d: move %d:%llu in new index %llu\n", level,
-					le32_to_cpu(idx->ei_block),
-					ext4_idx_pblock(idx),
-					newblock);
+			ext_debug(inode, "%d: move %d:%llu in new index %llu\n",
+				  level, le32_to_cpu(idx->ei_block),
+				  ext4_idx_pblock(idx), newblock);
 			idx++;
 		}
 
@@ -663,7 +662,7 @@ static void ext4_ext_show_move(struct inode *inode, struct ext4_ext_path *path,
 
 	ex = path[depth].p_ext;
 	while (ex <= EXT_MAX_EXTENT(path[depth].p_hdr)) {
-		ext_debug("move %d:%llu:[%d]%d in new leaf %llu\n",
+		ext_debug(inode, "move %d:%llu:[%d]%d in new leaf %llu\n",
 				le32_to_cpu(ex->ee_block),
 				ext4_ext_pblock(ex),
 				ext4_ext_is_unwritten(ex),
@@ -707,7 +706,7 @@ ext4_ext_binsearch_idx(struct inode *inode,
 	struct ext4_extent_idx *r, *l, *m;
 
 
-	ext_debug("binsearch for %u(idx):  ", block);
+	ext_debug(inode, "binsearch for %u(idx):  ", block);
 
 	l = EXT_FIRST_INDEX(eh) + 1;
 	r = EXT_LAST_INDEX(eh);
@@ -717,13 +716,13 @@ ext4_ext_binsearch_idx(struct inode *inode,
 			r = m - 1;
 		else
 			l = m + 1;
-		ext_debug("%p(%u):%p(%u):%p(%u) ", l, le32_to_cpu(l->ei_block),
-				m, le32_to_cpu(m->ei_block),
-				r, le32_to_cpu(r->ei_block));
+		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
+			  le32_to_cpu(l->ei_block), m, le32_to_cpu(m->ei_block),
+			  r, le32_to_cpu(r->ei_block));
 	}
 
 	path->p_idx = l - 1;
-	ext_debug("  -> %u->%lld ", le32_to_cpu(path->p_idx->ei_block),
+	ext_debug(inode, "  -> %u->%lld ", le32_to_cpu(path->p_idx->ei_block),
 		  ext4_idx_pblock(path->p_idx));
 
 #ifdef CHECK_BINSEARCH
@@ -774,7 +773,7 @@ ext4_ext_binsearch(struct inode *inode,
 		return;
 	}
 
-	ext_debug("binsearch for %u:  ", block);
+	ext_debug(inode, "binsearch for %u:  ", block);
 
 	l = EXT_FIRST_EXTENT(eh) + 1;
 	r = EXT_LAST_EXTENT(eh);
@@ -785,13 +784,13 @@ ext4_ext_binsearch(struct inode *inode,
 			r = m - 1;
 		else
 			l = m + 1;
-		ext_debug("%p(%u):%p(%u):%p(%u) ", l, le32_to_cpu(l->ee_block),
-				m, le32_to_cpu(m->ee_block),
-				r, le32_to_cpu(r->ee_block));
+		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
+			  le32_to_cpu(l->ee_block), m, le32_to_cpu(m->ee_block),
+			  r, le32_to_cpu(r->ee_block));
 	}
 
 	path->p_ext = l - 1;
-	ext_debug("  -> %d:%llu:[%d]%d ",
+	ext_debug(inode, "  -> %d:%llu:[%d]%d ",
 			le32_to_cpu(path->p_ext->ee_block),
 			ext4_ext_pblock(path->p_ext),
 			ext4_ext_is_unwritten(path->p_ext),
@@ -871,7 +870,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 		ext4_cache_extents(inode, eh);
 	/* walk through the tree */
 	while (i) {
-		ext_debug("depth %d: num %d, max %d\n",
+		ext_debug(inode, "depth %d: num %d, max %d\n",
 			  ppos, le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
 
 		ext4_ext_binsearch_idx(inode, path + ppos, block);
@@ -948,18 +947,20 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 
 	if (logical > le32_to_cpu(curp->p_idx->ei_block)) {
 		/* insert after */
-		ext_debug("insert new index %d after: %llu\n", logical, ptr);
+		ext_debug(inode, "insert new index %d after: %llu\n",
+			  logical, ptr);
 		ix = curp->p_idx + 1;
 	} else {
 		/* insert before */
-		ext_debug("insert new index %d before: %llu\n", logical, ptr);
+		ext_debug(inode, "insert new index %d before: %llu\n",
+			  logical, ptr);
 		ix = curp->p_idx;
 	}
 
 	len = EXT_LAST_INDEX(curp->p_hdr) - ix + 1;
 	BUG_ON(len < 0);
 	if (len > 0) {
-		ext_debug("insert new index %d: "
+		ext_debug(inode, "insert new index %d: "
 				"move %d indices from 0x%p to 0x%p\n",
 				logical, len, ix, ix + 1);
 		memmove(ix + 1, ix, len * sizeof(struct ext4_extent_idx));
@@ -1022,12 +1023,12 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	}
 	if (path[depth].p_ext != EXT_MAX_EXTENT(path[depth].p_hdr)) {
 		border = path[depth].p_ext[1].ee_block;
-		ext_debug("leaf will be split."
+		ext_debug(inode, "leaf will be split."
 				" next leaf starts at %d\n",
 				  le32_to_cpu(border));
 	} else {
 		border = newext->ee_block;
-		ext_debug("leaf will be added."
+		ext_debug(inode, "leaf will be added."
 				" next leaf starts at %d\n",
 				le32_to_cpu(border));
 	}
@@ -1049,7 +1050,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 		return -ENOMEM;
 
 	/* allocate all needed blocks */
-	ext_debug("allocate %d blocks for indexes/leaf\n", depth - at);
+	ext_debug(inode, "allocate %d blocks for indexes/leaf\n", depth - at);
 	for (a = 0; a < depth - at; a++) {
 		newblock = ext4_ext_new_meta_block(handle, inode, path,
 						   newext, &err, flags);
@@ -1135,7 +1136,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 		goto cleanup;
 	}
 	if (k)
-		ext_debug("create %d intermediate indices\n", k);
+		ext_debug(inode, "create %d intermediate indices\n", k);
 	/* insert new index into current index block */
 	/* current depth stored in i var */
 	i = depth - 1;
@@ -1162,7 +1163,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 		fidx->ei_block = border;
 		ext4_idx_store_pblock(fidx, oldblock);
 
-		ext_debug("int.index at %d (block %llu): %u -> %llu\n",
+		ext_debug(inode, "int.index at %d (block %llu): %u -> %llu\n",
 				i, newblock, le32_to_cpu(border), oldblock);
 
 		/* move remainder of path[i] to the new index block */
@@ -1176,7 +1177,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 		}
 		/* start copy indexes */
 		m = EXT_MAX_INDEX(path[i].p_hdr) - path[i].p_idx++;
-		ext_debug("cur 0x%p, last 0x%p\n", path[i].p_idx,
+		ext_debug(inode, "cur 0x%p, last 0x%p\n", path[i].p_idx,
 				EXT_MAX_INDEX(path[i].p_hdr));
 		ext4_ext_show_move(inode, path, newblock, i);
 		if (m) {
@@ -1313,7 +1314,7 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
 		EXT_FIRST_INDEX(neh)->ei_block =
 			EXT_FIRST_EXTENT(neh)->ee_block;
 	}
-	ext_debug("new root: num %d(%d), lblock %d, ptr %llu\n",
+	ext_debug(inode, "new root: num %d(%d), lblock %d, ptr %llu\n",
 		  le16_to_cpu(neh->eh_entries), le16_to_cpu(neh->eh_max),
 		  le32_to_cpu(EXT_FIRST_INDEX(neh)->ei_block),
 		  ext4_idx_pblock(EXT_FIRST_INDEX(neh)));
@@ -1955,7 +1956,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 
 		/* Try to append newex to the ex */
 		if (ext4_can_extents_be_merged(inode, ex, newext)) {
-			ext_debug("append [%d]%d block to %u:[%d]%d"
+			ext_debug(inode, "append [%d]%d block to %u:[%d]%d"
 				  "(from %llu)\n",
 				  ext4_ext_is_unwritten(newext),
 				  ext4_ext_get_actual_len(newext),
@@ -1980,7 +1981,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 prepend:
 		/* Try to prepend newex to the ex */
 		if (ext4_can_extents_be_merged(inode, newext, ex)) {
-			ext_debug("prepend %u[%d]%d block to %u:[%d]%d"
+			ext_debug(inode, "prepend %u[%d]%d block to %u:[%d]%d"
 				  "(from %llu)\n",
 				  le32_to_cpu(newext->ee_block),
 				  ext4_ext_is_unwritten(newext),
@@ -2018,7 +2019,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (le32_to_cpu(newext->ee_block) > le32_to_cpu(fex->ee_block))
 		next = ext4_ext_next_leaf_block(path);
 	if (next != EXT_MAX_BLOCKS) {
-		ext_debug("next leaf block - %u\n", next);
+		ext_debug(inode, "next leaf block - %u\n", next);
 		BUG_ON(npath != NULL);
 		npath = ext4_find_extent(inode, next, NULL, 0);
 		if (IS_ERR(npath))
@@ -2026,12 +2027,12 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		BUG_ON(npath->p_depth != path->p_depth);
 		eh = npath[depth].p_hdr;
 		if (le16_to_cpu(eh->eh_entries) < le16_to_cpu(eh->eh_max)) {
-			ext_debug("next leaf isn't full(%d)\n",
+			ext_debug(inode, "next leaf isn't full(%d)\n",
 				  le16_to_cpu(eh->eh_entries));
 			path = npath;
 			goto has_space;
 		}
-		ext_debug("next leaf has no free space(%d,%d)\n",
+		ext_debug(inode, "next leaf has no free space(%d,%d)\n",
 			  le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
 	}
 
@@ -2057,7 +2058,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 
 	if (!nearex) {
 		/* there is no extent in this leaf, create first one */
-		ext_debug("first extent in the leaf: %u:%llu:[%d]%d\n",
+		ext_debug(inode, "first extent in the leaf: %u:%llu:[%d]%d\n",
 				le32_to_cpu(newext->ee_block),
 				ext4_ext_pblock(newext),
 				ext4_ext_is_unwritten(newext),
@@ -2067,7 +2068,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		if (le32_to_cpu(newext->ee_block)
 			   > le32_to_cpu(nearex->ee_block)) {
 			/* Insert after */
-			ext_debug("insert %u:%llu:[%d]%d before: "
+			ext_debug(inode, "insert %u:%llu:[%d]%d before: "
 					"nearest %p\n",
 					le32_to_cpu(newext->ee_block),
 					ext4_ext_pblock(newext),
@@ -2078,7 +2079,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		} else {
 			/* Insert before */
 			BUG_ON(newext->ee_block == nearex->ee_block);
-			ext_debug("insert %u:%llu:[%d]%d after: "
+			ext_debug(inode, "insert %u:%llu:[%d]%d after: "
 					"nearest %p\n",
 					le32_to_cpu(newext->ee_block),
 					ext4_ext_pblock(newext),
@@ -2088,7 +2089,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		}
 		len = EXT_LAST_EXTENT(eh) - nearex + 1;
 		if (len > 0) {
-			ext_debug("insert %u:%llu:[%d]%d: "
+			ext_debug(inode, "insert %u:%llu:[%d]%d: "
 					"move %d extents from 0x%p to 0x%p\n",
 					le32_to_cpu(newext->ee_block),
 					ext4_ext_pblock(newext),
@@ -2232,7 +2233,7 @@ ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
 			return;
 		hole_len = min(es.es_lblk - hole_start, hole_len);
 	}
-	ext_debug(" -> %u:%u\n", hole_start, hole_len);
+	ext_debug(inode, " -> %u:%u\n", hole_start, hole_len);
 	ext4_es_insert_extent(inode, hole_start, hole_len, ~0,
 			      EXTENT_STATUS_HOLE);
 }
@@ -2269,7 +2270,7 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
 	err = ext4_ext_dirty(handle, inode, path);
 	if (err)
 		return err;
-	ext_debug("index is empty, remove it, free block %llu\n", leaf);
+	ext_debug(inode, "index is empty, remove it, free block %llu\n", leaf);
 	trace_ext4_ext_rm_idx(inode, leaf);
 
 	ext4_free_blocks(handle, inode, NULL, leaf, 1,
@@ -2548,7 +2549,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 	ext4_fsblk_t pblk;
 
 	/* the header must be checked already in ext4_ext_remove_space() */
-	ext_debug("truncate since %u in leaf to %u\n", start, end);
+	ext_debug(inode, "truncate since %u in leaf to %u\n", start, end);
 	if (!path[depth].p_hdr)
 		path[depth].p_hdr = ext_block_hdr(path[depth].p_bh);
 	eh = path[depth].p_hdr;
@@ -2574,7 +2575,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 		else
 			unwritten = 0;
 
-		ext_debug("remove ext %u:[%d]%d\n", ex_ee_block,
+		ext_debug(inode, "remove ext %u:[%d]%d\n", ex_ee_block,
 			  unwritten, ex_ee_len);
 		path[depth].p_ext = ex;
 
@@ -2582,7 +2583,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 		b = ex_ee_block+ex_ee_len - 1 < end ?
 			ex_ee_block+ex_ee_len - 1 : end;
 
-		ext_debug("  border %u:%u\n", a, b);
+		ext_debug(inode, "  border %u:%u\n", a, b);
 
 		/* If this extent is beyond the end of the hole, skip it */
 		if (end < ex_ee_block) {
@@ -2691,7 +2692,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 		if (err)
 			goto out;
 
-		ext_debug("new extent: %u:%u:%llu\n", ex_ee_block, num,
+		ext_debug(inode, "new extent: %u:%u:%llu\n", ex_ee_block, num,
 				ext4_ext_pblock(ex));
 		ex--;
 		ex_ee_block = le32_to_cpu(ex->ee_block);
@@ -2768,7 +2769,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	partial.lblk = 0;
 	partial.state = initial;
 
-	ext_debug("truncate since %u to %u\n", start, end);
+	ext_debug(inode, "truncate since %u to %u\n", start, end);
 
 	/* probably first extent we're gonna free will be last in block */
 	handle = ext4_journal_start_with_revoke(inode, EXT4_HT_TRUNCATE,
@@ -2909,7 +2910,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 
 		/* this is index block */
 		if (!path[i].p_hdr) {
-			ext_debug("initialize header\n");
+			ext_debug(inode, "initialize header\n");
 			path[i].p_hdr = ext_block_hdr(path[i].p_bh);
 		}
 
@@ -2917,7 +2918,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			/* this level hasn't been touched yet */
 			path[i].p_idx = EXT_LAST_INDEX(path[i].p_hdr);
 			path[i].p_block = le16_to_cpu(path[i].p_hdr->eh_entries)+1;
-			ext_debug("init index ptr: hdr 0x%p, num %d\n",
+			ext_debug(inode, "init index ptr: hdr 0x%p, num %d\n",
 				  path[i].p_hdr,
 				  le16_to_cpu(path[i].p_hdr->eh_entries));
 		} else {
@@ -2925,13 +2926,13 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			path[i].p_idx--;
 		}
 
-		ext_debug("level %d - index, first 0x%p, cur 0x%p\n",
+		ext_debug(inode, "level %d - index, first 0x%p, cur 0x%p\n",
 				i, EXT_FIRST_INDEX(path[i].p_hdr),
 				path[i].p_idx);
 		if (ext4_ext_more_to_rm(path + i)) {
 			struct buffer_head *bh;
 			/* go to the next level */
-			ext_debug("move to level %d (block %llu)\n",
+			ext_debug(inode, "move to level %d (block %llu)\n",
 				  i + 1, ext4_idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
 			bh = read_extent_tree_block(inode,
@@ -2967,7 +2968,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			brelse(path[i].p_bh);
 			path[i].p_bh = NULL;
 			i--;
-			ext_debug("return to level %d\n", i);
+			ext_debug(inode, "return to level %d\n", i);
 		}
 	}
 
@@ -3135,8 +3136,7 @@ static int ext4_split_extent_at(handle_t *handle,
 	BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2)) ==
 	       (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
 
-	ext_debug("ext4_split_extents_at: inode %lu, logical"
-		"block %llu\n", inode->i_ino, (unsigned long long)split);
+	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
 
 	ext4_ext_show_leaf(inode, path);
 
@@ -3369,9 +3369,8 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	int err = 0;
 	int split_flag = EXT4_EXT_DATA_VALID2;
 
-	ext_debug("ext4_ext_convert_to_initialized: inode %lu, logical"
-		"block %llu, max_blocks %u\n", inode->i_ino,
-		(unsigned long long)map->m_lblk, map_len);
+	ext_debug(inode, "logical block %llu, max_blocks %u\n",
+		  (unsigned long long)map->m_lblk, map_len);
 
 	sbi = EXT4_SB(inode->i_sb);
 	eof_block = (EXT4_I(inode)->i_disksize + inode->i_sb->s_blocksize - 1)
@@ -3623,8 +3622,7 @@ static int ext4_split_convert_extents(handle_t *handle,
 	unsigned int ee_len;
 	int split_flag = 0, depth;
 
-	ext_debug("%s: inode %lu, logical block %llu, max_blocks %u\n",
-		  __func__, inode->i_ino,
+	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len);
 
 	eof_block = (EXT4_I(inode)->i_disksize + inode->i_sb->s_blocksize - 1)
@@ -3670,8 +3668,7 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 	ee_block = le32_to_cpu(ex->ee_block);
 	ee_len = ext4_ext_get_actual_len(ex);
 
-	ext_debug("ext4_convert_unwritten_extents_endio: inode %lu, logical"
-		"block %llu, max_blocks %u\n", inode->i_ino,
+	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
 	/* If extent is larger than requested it is a clear sign that we still
@@ -3741,8 +3738,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	ee_block = le32_to_cpu(ex->ee_block);
 	ee_len = ext4_ext_get_actual_len(ex);
 
-	ext_debug("%s: inode %lu, logical"
-		"block %llu, max_blocks %u\n", __func__, inode->i_ino,
+	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)ee_block, ee_len);
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
@@ -3798,10 +3794,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	int ret = 0;
 	int err = 0;
 
-	ext_debug("ext4_ext_handle_unwritten_extents: inode %lu, logical "
-		  "block %llu, max_blocks %u, flags %x, allocated %u\n",
-		  inode->i_ino, (unsigned long long)map->m_lblk, map->m_len,
-		  flags, allocated);
+	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
+		  (unsigned long long)map->m_lblk, map->m_len, flags,
+		  allocated);
 	ext4_ext_show_leaf(inode, path);
 
 	/*
@@ -4029,8 +4024,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
 
-	ext_debug("blocks %u/%u requested for inode %lu\n",
-		  map->m_lblk, map->m_len, inode->i_ino);
+	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
 
 	/* find extent for this block */
@@ -4077,8 +4071,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			newblock = map->m_lblk - ee_block + ee_start;
 			/* number of remaining blocks in the extent */
 			allocated = ee_len - (map->m_lblk - ee_block);
-			ext_debug("%u fit into %u:%d -> %llu\n", map->m_lblk,
-				  ee_block, ee_len, newblock);
+			ext_debug(inode, "%u fit into %u:%d -> %llu\n",
+				  map->m_lblk, ee_block, ee_len, newblock);
 
 			/*
 			 * If the extent is initialized check whether the
@@ -4218,7 +4212,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		goto out2;
 	allocated_clusters = ar.len;
 	ar.len = EXT4_C2B(sbi, ar.len) - offset;
-	ext_debug("allocate new block: goal %llu, found %llu/%u, requested %u\n",
+	ext_debug(inode, "allocate new block: goal %llu, found %llu/%u, requested %u\n",
 		  ar.goal, newblock, ar.len, allocated);
 	if (ar.len > allocated)
 		ar.len = allocated;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5f120af22d48..a39fea85ca59 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -493,9 +493,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 #endif
 
 	map->m_flags = 0;
-	ext_debug("ext4_map_blocks(): inode %lu, flag %d, max_blocks %u,"
-		  "logical block %lu\n", inode->i_ino, flags, map->m_len,
-		  (unsigned long) map->m_lblk);
+	ext_debug(inode, "flag 0x%x, max_blocks %u, logical block %lu\n",
+		  flags, map->m_len, (unsigned long) map->m_lblk);
 
 	/*
 	 * ext4_map_blocks returns an int, and m_len is an unsigned int
@@ -728,8 +727,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	if (retval < 0)
-		ext_debug("failed for inode %lu with err %d\n",
-			  inode->i_ino, retval);
+		ext_debug(inode, "failed with err %d\n", retval);
 	return retval;
 }
 
@@ -1685,8 +1683,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		invalid_block = ~0;
 
 	map->m_flags = 0;
-	ext_debug("ext4_da_map_blocks(): inode %lu, max_blocks %u,"
-		  "logical block %lu\n", inode->i_ino, map->m_len,
+	ext_debug(inode, "max_blocks %u, logical block %lu\n", map->m_len,
 		  (unsigned long) map->m_lblk);
 
 	/* Lookup extent status tree firstly */
-- 
2.21.0

