Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F43D89E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733056AbfJPHhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:37:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732871AbfJPHhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:37:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7b3ep115398
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnwj2u3k7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 16 Oct 2019 08:37:30 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:37:26 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7asmN36241772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:36:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C720CAE056;
        Wed, 16 Oct 2019 07:37:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B85C3AE051;
        Wed, 16 Oct 2019 07:37:23 +0000 (GMT)
Received: from dhcp-9-199-158-105.in.ibm.com (unknown [9.199.158.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:37:23 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFC 4/5] ext4: Add support for blocksize < pagesize in dioread_nolock
Date:   Wed, 16 Oct 2019 13:07:10 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016073711.4141-1-riteshh@linux.ibm.com>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0008-0000-0000-000003227AA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0009-0000-0000-00004A4192F3
Message-Id: <20191016073711.4141-5-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the support for blocksize < pagesize for
dioread_nolock feature.

Since in case of blocksize < pagesize, we can have multiple
small buffers of page as unwritten extents, we need to
maintain a vector of these unwritten extents which needs
the conversion after the IO is complete. Thus, we maintain
a list of tuple <offset, size> pair (io_end_vec) for this &
traverse this list to do the unwritten to written conversion.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h    | 11 ++++++++--
 fs/ext4/extents.c | 11 ++++++++--
 fs/ext4/inode.c   | 37 +++++++++++++++++----------------
 fs/ext4/page-io.c | 52 +++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8d924bd19ca7..3616f1b0c987 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -198,6 +198,12 @@ struct ext4_system_blocks {
  */
 #define	EXT4_IO_END_UNWRITTEN	0x0001
 
+struct ext4_io_end_vec {
+	struct list_head list;		/* list of io_end_vec */
+	loff_t offset;			/* offset in the file */
+	ssize_t size;			/* size of the extent */
+};
+
 /*
  * For converting unwritten extents on a work queue. 'handle' is used for
  * buffered writeback.
@@ -211,8 +217,7 @@ typedef struct ext4_io_end {
 						 * bios covering the extent */
 	unsigned int		flag;		/* unwritten or not */
 	atomic_t		count;		/* reference counter */
-	loff_t			offset;		/* offset in the file */
-	ssize_t			size;		/* size of the extent */
+	struct list_head	list_vec;	/* list of ext4_io_end_vec */
 } ext4_io_end_t;
 
 struct ext4_io_submit {
@@ -3324,6 +3329,8 @@ extern int ext4_bio_write_page(struct ext4_io_submit *io,
 			       int len,
 			       struct writeback_control *wbc,
 			       bool keep_towrite);
+extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
+extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
 
 /* mmp.c */
 extern int ext4_multi_mount_protect(struct super_block *, ext4_fsblk_t);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 731e67ccab22..cf6c5f64cb58 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5005,6 +5005,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
 {
 	int ret, err = 0;
+	struct ext4_io_end_vec *io_end_vec;
 
 	/*
 	 * This is somewhat ugly but the idea is clear: When transaction is
@@ -5018,8 +5019,14 @@ int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
 			return PTR_ERR(handle);
 	}
 
-	ret = ext4_convert_unwritten_extents(handle, io_end->inode,
-					     io_end->offset, io_end->size);
+	list_for_each_entry(io_end_vec, &io_end->list_vec, list) {
+		ret = ext4_convert_unwritten_extents(handle, io_end->inode,
+						     io_end_vec->offset,
+						     io_end_vec->size);
+		if (ret)
+			break;
+	}
+
 	if (handle)
 		err = ext4_journal_stop(handle);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3204a7d35581..026666bdc058 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2364,6 +2364,9 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 	ext4_lblk_t lblk = *m_lblk;
 	ext4_fsblk_t pblock = *m_pblk;
 	int err = 0;
+	int blkbits = mpd->inode->i_blkbits;
+	ssize_t io_end_size = 0;
+	struct ext4_io_end_vec *io_end_vec = ext4_last_io_end_vec(io_end);
 
 	bh = head = page_buffers(page);
 	do {
@@ -2376,17 +2379,16 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 			 */
 			mpd->map.m_len = 0;
 			mpd->map.m_flags = 0;
+			io_end_vec->size += io_end_size;
+			io_end_size = 0;
 
-			/*
-			 * FIXME: If dioread_nolock supports
-			 * blocksize < pagesize, we need to make
-			 * sure we add size mapped so far to
-			 * io_end->size as the following call
-			 * can submit the page for IO.
-			 */
 			err = mpage_process_page_bufs(mpd, head, bh, lblk);
 			if (err > 0)
 				err = 0;
+			if (!err && mpd->map.m_len && mpd->map.m_lblk > lblk) {
+				io_end_vec = ext4_alloc_io_end_vec(io_end);
+				io_end_vec->offset = mpd->map.m_lblk << blkbits;
+			}
 			*map_bh = true;
 			goto out;
 		}
@@ -2395,13 +2397,11 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 			bh->b_blocknr = pblock++;
 		}
 		clear_buffer_unwritten(bh);
+		io_end_size += (1 << blkbits);
 	} while (lblk++, (bh = bh->b_this_page) != head);
-	/*
-	 * FIXME: This is going to break if dioread_nolock
-	 * supports blocksize < pagesize as we will try to
-	 * convert potentially unmapped parts of inode.
-	 */
-	io_end->size += PAGE_SIZE;
+
+	io_end_vec->size += io_end_size;
+	io_end_size = 0;
 	*map_bh = false;
 out:
 	*m_lblk = lblk;
@@ -2551,9 +2551,10 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	int err;
 	loff_t disksize;
 	int progress = 0;
+	ext4_io_end_t *io_end = mpd->io_submit.io_end;
+	struct ext4_io_end_vec *io_end_vec = ext4_alloc_io_end_vec(io_end);
 
-	mpd->io_submit.io_end->offset =
-				((loff_t)map->m_lblk) << inode->i_blkbits;
+	io_end_vec->offset = ((loff_t)map->m_lblk) << inode->i_blkbits;
 	do {
 		err = mpage_map_one_extent(handle, mpd);
 		if (err < 0) {
@@ -3654,6 +3655,7 @@ static int ext4_end_io_dio(struct kiocb *iocb, loff_t offset,
 			    ssize_t size, void *private)
 {
         ext4_io_end_t *io_end = private;
+	struct ext4_io_end_vec *io_end_vec;
 
 	/* if not async direct IO just return */
 	if (!io_end)
@@ -3671,8 +3673,9 @@ static int ext4_end_io_dio(struct kiocb *iocb, loff_t offset,
 		ext4_clear_io_unwritten_flag(io_end);
 		size = 0;
 	}
-	io_end->offset = offset;
-	io_end->size = size;
+	io_end_vec = ext4_alloc_io_end_vec(io_end);
+	io_end_vec->offset = offset;
+	io_end_vec->size = size;
 	ext4_put_io_end(io_end);
 
 	return 0;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 3ccf54a380b2..893913d1c2fe 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -31,18 +31,56 @@
 #include "acl.h"
 
 static struct kmem_cache *io_end_cachep;
+static struct kmem_cache *io_end_vec_cachep;
 
 int __init ext4_init_pageio(void)
 {
 	io_end_cachep = KMEM_CACHE(ext4_io_end, SLAB_RECLAIM_ACCOUNT);
 	if (io_end_cachep == NULL)
 		return -ENOMEM;
+
+	io_end_vec_cachep = KMEM_CACHE(ext4_io_end_vec, 0);
+	if (io_end_vec_cachep == NULL) {
+		kmem_cache_destroy(io_end_cachep);
+		return -ENOMEM;
+	}
 	return 0;
 }
 
 void ext4_exit_pageio(void)
 {
 	kmem_cache_destroy(io_end_cachep);
+	kmem_cache_destroy(io_end_vec_cachep);
+}
+
+struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end)
+{
+	struct ext4_io_end_vec *io_end_vec;
+
+	io_end_vec = kmem_cache_zalloc(io_end_vec_cachep, GFP_NOFS);
+	if (!io_end_vec)
+		return ERR_PTR(-ENOMEM);
+	INIT_LIST_HEAD(&io_end_vec->list);
+	list_add_tail(&io_end_vec->list, &io_end->list_vec);
+	return io_end_vec;
+}
+
+static void ext4_free_io_end_vec(ext4_io_end_t *io_end)
+{
+	struct ext4_io_end_vec *io_end_vec, *tmp;
+
+	if (list_empty(&io_end->list_vec))
+		return;
+	list_for_each_entry_safe(io_end_vec, tmp, &io_end->list_vec, list) {
+		list_del(&io_end_vec->list);
+		kmem_cache_free(io_end_vec_cachep, io_end_vec);
+	}
+}
+
+struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end)
+{
+	BUG_ON(list_empty(&io_end->list_vec));
+	return list_last_entry(&io_end->list_vec, struct ext4_io_end_vec, list);
 }
 
 /*
@@ -125,6 +163,7 @@ static void ext4_release_io_end(ext4_io_end_t *io_end)
 		ext4_finish_bio(bio);
 		bio_put(bio);
 	}
+	ext4_free_io_end_vec(io_end);
 	kmem_cache_free(io_end_cachep, io_end);
 }
 
@@ -139,8 +178,6 @@ static void ext4_release_io_end(ext4_io_end_t *io_end)
 static int ext4_end_io_end(ext4_io_end_t *io_end)
 {
 	struct inode *inode = io_end->inode;
-	loff_t offset = io_end->offset;
-	ssize_t size = io_end->size;
 	handle_t *handle = io_end->handle;
 	int ret = 0;
 
@@ -154,8 +191,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 		ext4_msg(inode->i_sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
 			 "extents -- potential data loss!  "
-			 "(inode %lu, offset %llu, size %zd, error %d)",
-			 inode->i_ino, offset, size, ret);
+			 "(inode %lu, error %d)", inode->i_ino, ret);
 	}
 	ext4_clear_io_unwritten_flag(io_end);
 	ext4_release_io_end(io_end);
@@ -247,6 +283,7 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
 	if (io_end) {
 		io_end->inode = inode;
 		INIT_LIST_HEAD(&io_end->list);
+		INIT_LIST_HEAD(&io_end->list_vec);
 		atomic_set(&io_end->count, 1);
 	}
 	return io_end;
@@ -255,7 +292,8 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
 void ext4_put_io_end_defer(ext4_io_end_t *io_end)
 {
 	if (atomic_dec_and_test(&io_end->count)) {
-		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) || !io_end->size) {
+		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
+				list_empty(&io_end->list_vec)) {
 			ext4_release_io_end(io_end);
 			return;
 		}
@@ -307,10 +345,8 @@ static void ext4_end_bio(struct bio *bio)
 		struct inode *inode = io_end->inode;
 
 		ext4_warning(inode->i_sb, "I/O error %d writing to inode %lu "
-			     "(offset %llu size %ld starting block %llu)",
+			     "starting block %llu)",
 			     bio->bi_status, inode->i_ino,
-			     (unsigned long long) io_end->offset,
-			     (long) io_end->size,
 			     (unsigned long long)
 			     bi_sector >> (inode->i_blkbits - 9));
 		mapping_set_error(inode->i_mapping,
-- 
2.21.0

