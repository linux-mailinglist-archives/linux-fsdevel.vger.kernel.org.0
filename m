Return-Path: <linux-fsdevel+bounces-6650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95481B19C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B01C23391
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA2524C8;
	Thu, 21 Dec 2023 09:01:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72822524AC;
	Thu, 21 Dec 2023 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SwktH6c1nz4f3jMV;
	Thu, 21 Dec 2023 17:00:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AA1FD1A0C57;
	Thu, 21 Dec 2023 17:00:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3OhDH_oNl4h_vEA--.34329S4;
	Thu, 21 Dec 2023 17:00:57 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	roger.pau@citrix.com,
	colyli@suse.de,
	kent.overstreet@gmail.com,
	joern@lazybastard.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	sth@linux.ibm.com,
	hoeppner@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	nico@fluxnic.net,
	xiang@kernel.org,
	chao@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com,
	konishi.ryusuke@gmail.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	hare@suse.de,
	p.raghav@samsung.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v3 for-6.8/block 15/17] ext4: use new helper to read sb block
Date: Thu, 21 Dec 2023 16:58:59 +0800
Message-Id: <20231221085859.1772154-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3OhDH_oNl4h_vEA--.34329S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4kKw17tFyDGFW3Zry5Jwb_yoW7Cr17pa
	sIka9FkryvqFn09a1xKr13tw1Yy3Z2ga1UGayfC34furyqqrn3Xa48tF1I9FWrArZxXry5
	XF1jkryrCr18CFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_JFI_Gr1lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUb
	ZNVDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Remove __ext4_sb_bread_gfp() and ext4_buffer_uptodate() that is defined
by ext4, and convert to use common helper __bread_gfp2() and
buffer_uptodate_or_error().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 13 -------------
 fs/ext4/inode.c   |  8 ++++----
 fs/ext4/super.c   | 45 ++++++++++-----------------------------------
 fs/ext4/symlink.c |  2 +-
 4 files changed, 15 insertions(+), 53 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a5d784872303..8377f6c5264f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3824,19 +3824,6 @@ extern const struct iomap_ops ext4_iomap_ops;
 extern const struct iomap_ops ext4_iomap_overwrite_ops;
 extern const struct iomap_ops ext4_iomap_report_ops;
 
-static inline int ext4_buffer_uptodate(struct buffer_head *bh)
-{
-	/*
-	 * If the buffer has the write error flag, we have failed
-	 * to write out data in the block.  In this  case, we don't
-	 * have to read the block because we may read the old data
-	 * successfully.
-	 */
-	if (buffer_write_io_error(bh))
-		set_buffer_uptodate(bh);
-	return buffer_uptodate(bh);
-}
-
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 61277f7f8722..efb0af6f02f7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -887,7 +887,7 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
 	bh = ext4_getblk(handle, inode, block, map_flags);
 	if (IS_ERR(bh))
 		return bh;
-	if (!bh || ext4_buffer_uptodate(bh))
+	if (!bh || buffer_uptodate_or_error(bh))
 		return bh;
 
 	ret = ext4_read_bh_lock(bh, REQ_META | REQ_PRIO, true);
@@ -915,7 +915,7 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 
 	for (i = 0; i < bh_count; i++)
 		/* Note that NULL bhs[i] is valid because of holes. */
-		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
+		if (bhs[i] && !buffer_uptodate_or_error(bhs[i]))
 			ext4_read_bh_lock(bhs[i], REQ_META | REQ_PRIO, false);
 
 	if (!wait)
@@ -4392,11 +4392,11 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	bh = sb_getblk(sb, block);
 	if (unlikely(!bh))
 		return -ENOMEM;
-	if (ext4_buffer_uptodate(bh))
+	if (buffer_uptodate_or_error(bh))
 		goto has_buffer;
 
 	lock_buffer(bh);
-	if (ext4_buffer_uptodate(bh)) {
+	if (buffer_uptodate_or_error(bh)) {
 		/* Someone brought it uptodate while we waited */
 		unlock_buffer(bh);
 		goto has_buffer;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..3f07eaa33332 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -180,7 +180,7 @@ void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
 {
 	BUG_ON(!buffer_locked(bh));
 
-	if (ext4_buffer_uptodate(bh)) {
+	if (buffer_uptodate_or_error(bh)) {
 		unlock_buffer(bh);
 		return;
 	}
@@ -191,7 +191,7 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io
 {
 	BUG_ON(!buffer_locked(bh));
 
-	if (ext4_buffer_uptodate(bh)) {
+	if (buffer_uptodate_or_error(bh)) {
 		unlock_buffer(bh);
 		return 0;
 	}
@@ -214,49 +214,24 @@ int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
 	return ext4_read_bh(bh, op_flags, NULL);
 }
 
-/*
- * This works like __bread_gfp() except it uses ERR_PTR for error
- * returns.  Currently with sb_bread it's impossible to distinguish
- * between ENOMEM and EIO situations (since both result in a NULL
- * return.
- */
-static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
-					       sector_t block,
-					       blk_opf_t op_flags, gfp_t gfp)
-{
-	struct buffer_head *bh;
-	int ret;
-
-	bh = sb_getblk_gfp(sb, block, gfp);
-	if (bh == NULL)
-		return ERR_PTR(-ENOMEM);
-	if (ext4_buffer_uptodate(bh))
-		return bh;
-
-	ret = ext4_read_bh_lock(bh, REQ_META | op_flags, true);
-	if (ret) {
-		put_bh(bh);
-		return ERR_PTR(ret);
-	}
-	return bh;
-}
-
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 				   blk_opf_t op_flags)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
-			~__GFP_FS) | __GFP_MOVABLE;
+	struct buffer_head *bh = __bread_gfp2(sb->s_bdev, block,
+					      sb->s_blocksize,
+					      REQ_META | op_flags,
+					      __GFP_MOVABLE);
 
-	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
+	return bh ? bh : ERR_PTR(-EIO);
 }
 
 struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 					    sector_t block)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
-			~__GFP_FS);
+	struct buffer_head *bh = __bread_gfp2(sb->s_bdev, block,
+					      sb->s_blocksize, REQ_META, 0);
 
-	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
+	return bh ? bh : ERR_PTR(-EIO);
 }
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 75bf1f88843c..49e918221aac 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -94,7 +94,7 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
 		bh = ext4_getblk(NULL, inode, 0, EXT4_GET_BLOCKS_CACHED_NOWAIT);
 		if (IS_ERR(bh))
 			return ERR_CAST(bh);
-		if (!bh || !ext4_buffer_uptodate(bh))
+		if (!bh || !buffer_uptodate_or_error(bh))
 			return ERR_PTR(-ECHILD);
 	} else {
 		bh = ext4_bread(NULL, inode, 0, 0);
-- 
2.39.2


