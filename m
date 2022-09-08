Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8745B159E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIHH1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 03:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIHH1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:27:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DC81B2B
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 00:27:20 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2887Ln54000407;
        Thu, 8 Sep 2022 07:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8dT6JU8X8lswFiawJLkJacIDxINQ68pgKvHg/rE22Vs=;
 b=eedXkseorNqvaSDA3luDnDEs/XyrpJybJsSBA9OPJx6zH4dZ7ERyt9fkVA1gt4yzlI9J
 tOLVRTkvPX5M1aBgllfFlvNBChFgMSjvMahCgi8y7DaOuGG0gFmj6lVlIt2LIn0BYRJ+
 mf1eTgrQUBvJLIwlRYydOaKfWobLdKUuJj853hpQswdwCGMLum9C9I3fEtiDxMc1bpmv
 fPz9u9FAc7ynk7n+3dKGGHXagWjhn5XQUiD+7HIJ2PDqS33jORJk/b2JZbIcq9OZO+yC
 7LJKw+7dMJKcp6ilVh7gGlumcPdc/xbu6j2bVX9djR9Dl7g+lbAJgKT4jwp2X07A1K83 YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfbxj85dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 07:27:11 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2887MVMb004390;
        Thu, 8 Sep 2022 07:27:11 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfbxj85cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 07:27:10 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2887M8mD014033;
        Thu, 8 Sep 2022 07:27:09 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3jbxj9puk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 07:27:09 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2887R9nx63308194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 07:27:09 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3968124054;
        Thu,  8 Sep 2022 07:27:08 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 783F9124053;
        Thu,  8 Sep 2022 07:27:05 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.97.195])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Sep 2022 07:27:05 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH] fs/hugetlb: Fix UBSAN warning reported on hugetlb
Date:   Thu,  8 Sep 2022 12:56:59 +0530
Message-Id: <20220908072659.259324-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jl0EUJKsoYb-AZ90GWCjvaDaxr7FVNNy
X-Proofpoint-GUID: 5D3XfS1LjGF-GCgz95So2Fvsho8nHAkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_04,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=978
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Powerpc architecture supports 16GB hugetlb pages with hash translation. For 4K
page size, this is implemented as a hugepage directory entry at the PGD level
and for 64K it is implemented as a huge page pte at the PUD level

Hugetlbfs sets up file system blocksize same as page size and this patch
switches blocks size usage with 16GB hugetlb to use size_t type.

We only change generic code and hugetlbfs related usage of i_blocksize(). Other
fs specific usage is left unchanged in this patch. A large part of this change
is not relevant to hugetlb, but it is changed to make sure we track block size
using size_t in generic code.

Only functionality w.r.t getattr is observed to be impacted by this change.

The below test shows the user-visible change.

 struct stat a;
 stat("/mnt/a", &a);
 printf("st_blksize = %ld\n", a.st_blksize);

Without patch
 # ./a.out  /mnt/a
 st_blksize = 0
 #

With patch
 # ./a.out /mnt/a
 st_blksize = 17179869184
 #

Statx still has the problem

 # stat /mnt/a
   File: /mnt/a
   Size: 0               Blocks: 0          IO Block: 512    regular empty file
 Device: 2eh/46d Inode: 74584       Links: 1
 Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
 Context: unconfined_u:object_r:hugetlbfs_t:s0
 Access: 2022-09-07 11:42:14.620239084 -0500
 Modify: 2022-09-07 11:42:14.620239084 -0500
 Change: 2022-09-07 11:42:14.620239084 -0500
  Birth: -

because it uses __u32 stx_blksize in uapi.

struct statx {
	/* 0x00 */
	__u32	stx_mask;	/* What results were written [uncond] */
	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */

Fixing statx requires a syscall change where we add STATX_64BLOCKSIZE.

The change also fixes the below report warning.

 UBSAN: shift-out-of-bounds in ./include/linux/fs.h:709:12
 shift exponent 34 is too large for 32-bit type 'int'
 CPU: 67 PID: 1632 Comm: bash Not tainted 6.0.0-rc2-00327-gee88a56e8517-dirty #1
 Call Trace:
 [c000000021517990] [c000000000cb21e4] dump_stack_lvl+0x98/0xe0 (unreliable)
 [c0000000215179d0] [c000000000cacf60] ubsan_epilogue+0x18/0x70
 [c000000021517a30] [c000000000cac44c] __ubsan_handle_shift_out_of_bounds+0x1bc/0x390
 [c000000021517b30] [c00000000067e5b8] generic_fillattr+0x1b8/0x1d0
 [c000000021517b70] [c00000000067e6ec] vfs_getattr_nosec+0x11c/0x140
 [c000000021517bb0] [c00000000067e888] vfs_statx+0xd8/0x1d0
 [c000000021517c30] [c00000000067f658] vfs_fstatat+0x88/0xd0
 [c000000021517c80] [c00000000067f6e0] __do_sys_newstat+0x40/0x90
 [c000000021517d50] [c00000000003cde0] system_call_exception+0x250/0x600
 [c000000021517e10] [c00000000000c3bc] system_call_common+0xec/0x250

Cc: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 fs/buffer.c            | 6 +++---
 fs/dax.c               | 2 +-
 fs/iomap/buffered-io.c | 6 +++---
 fs/iomap/direct-io.c   | 2 +-
 include/linux/fs.h     | 4 ++--
 include/linux/stat.h   | 2 +-
 mm/truncate.c          | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 55e762a58eb6..15def791325e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2376,7 +2376,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	const struct address_space_operations *aops = mapping->a_ops;
-	unsigned int blocksize = i_blocksize(inode);
+	size_t blocksize = i_blocksize(inode);
 	struct page *page;
 	void *fsdata;
 	pgoff_t index, curidx;
@@ -2454,7 +2454,7 @@ int cont_write_begin(struct file *file, struct address_space *mapping,
 			get_block_t *get_block, loff_t *bytes)
 {
 	struct inode *inode = mapping->host;
-	unsigned int blocksize = i_blocksize(inode);
+	size_t blocksize = i_blocksize(inode);
 	unsigned int zerofrom;
 	int err;
 
@@ -2542,7 +2542,7 @@ int block_truncate_page(struct address_space *mapping,
 {
 	pgoff_t index = from >> PAGE_SHIFT;
 	unsigned offset = from & (PAGE_SIZE-1);
-	unsigned blocksize;
+	size_t blocksize;
 	sector_t iblock;
 	unsigned length, pos;
 	struct inode *inode = mapping->host;
diff --git a/fs/dax.c b/fs/dax.c
index c440dcef4b1b..66673ef56695 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1304,7 +1304,7 @@ EXPORT_SYMBOL_GPL(dax_zero_range);
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops)
 {
-	unsigned int blocksize = i_blocksize(inode);
+	size_t blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
 
 	/* Block boundary? Nothing to do */
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ca5c62901541..4b67018c6e71 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -955,7 +955,7 @@ int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops)
 {
-	unsigned int blocksize = i_blocksize(inode);
+	size_t blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
 
 	/* Block boundary? Nothing to do */
@@ -1297,7 +1297,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
 	sector_t sector = iomap_sector(&wpc->iomap, pos);
-	unsigned len = i_blocksize(inode);
+	size_t len = i_blocksize(inode);
 	size_t poff = offset_in_folio(folio, pos);
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, sector)) {
@@ -1340,7 +1340,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 {
 	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
 	struct iomap_ioend *ioend, *next;
-	unsigned len = i_blocksize(inode);
+	size_t len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
 	u64 pos = folio_pos(folio);
 	int error = 0, count = 0, i;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4eb559a16c9e..d17d9e11cd35 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -241,7 +241,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
-	unsigned int fs_block_size = i_blocksize(inode), pad;
+	size_t fs_block_size = i_blocksize(inode), pad;
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..7fedf9dbcac3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -704,9 +704,9 @@ struct inode {
 
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
 
-static inline unsigned int i_blocksize(const struct inode *node)
+static inline size_t i_blocksize(const struct inode *node)
 {
-	return (1 << node->i_blkbits);
+	return (1UL << node->i_blkbits);
 }
 
 static inline int inode_unhashed(struct inode *inode)
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 7df06931f25d..f362a8d1af0c 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -23,7 +23,7 @@ struct kstat {
 	u32		result_mask;	/* What fields the user got */
 	umode_t		mode;
 	unsigned int	nlink;
-	uint32_t	blksize;	/* Preferred I/O size */
+	size_t		blksize;	/* Preferred I/O size */
 	u64		attributes;
 	u64		attributes_mask;
 #define KSTAT_ATTR_FS_IOC_FLAGS				\
diff --git a/mm/truncate.c b/mm/truncate.c
index 0b0708bf935f..9d4b298d4f83 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -800,7 +800,7 @@ EXPORT_SYMBOL(truncate_setsize);
  */
 void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
 {
-	int bsize = i_blocksize(inode);
+	size_t bsize = i_blocksize(inode);
 	loff_t rounded_from;
 	struct page *page;
 	pgoff_t index;
-- 
2.37.3

