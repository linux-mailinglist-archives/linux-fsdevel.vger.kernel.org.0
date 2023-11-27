Return-Path: <linux-fsdevel+bounces-3891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 487147F99C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCFA7B21E5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18A12B99;
	Mon, 27 Nov 2023 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23E136;
	Sun, 26 Nov 2023 22:23:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SdwWj58Zpz4f3kFw;
	Mon, 27 Nov 2023 14:23:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7F7DB1A072F;
	Mon, 27 Nov 2023 14:23:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhDeNWRlxeA8CA--.60190S5;
	Mon, 27 Nov 2023 14:23:30 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	ming.lei@redhat.com,
	axboe@kernel.dk,
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
	agruenba@redhat.com,
	jack@suse.com,
	konishi.ryusuke@gmail.com,
	dchinner@redhat.com,
	linux@weissschuh.net,
	min15.li@samsung.com,
	yukuai3@huawei.com,
	dlemoal@kernel.org,
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
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH block/for-next v2 11/16] ext4: use new helper to get inode from block_device
Date: Mon, 27 Nov 2023 14:22:47 +0800
Message-Id: <20231127062252.2367645-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127062252.2367645-1-yukuai1@huaweicloud.com>
References: <20231127062252.2367645-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhDeNWRlxeA8CA--.60190S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1xKFy7JrWUXF18AF47Jwb_yoW5ZF4xpF
	y3AFyrAr4UZFyj9a92krZFq3W29w1IkFWxWryfuw1a9rWaqw1SqFykKF12yFyFvrW8Jry2
	qF1jkrW8Cr4rKrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUFT5lUUUU
	U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Which is more efficiency, and also prepare to remove the field
'bd_inode' from block_device.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/ext4/dir.c       | 2 +-
 fs/ext4/ext4_jbd2.c | 2 +-
 fs/ext4/super.c     | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..6e9fe408642b 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -192,7 +192,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					(PAGE_SHIFT - inode->i_blkbits);
 			if (!ra_has_index(&file->f_ra, index))
 				page_cache_sync_readahead(
-					sb->s_bdev->bd_inode->i_mapping,
+					bdev_inode(sb->s_bdev)->i_mapping,
 					&file->f_ra, file,
 					index, 1);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d1a2e6624401..e0e7f71d022d 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -206,7 +206,7 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 
 static void ext4_check_bdev_write_error(struct super_block *sb)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(sb->s_bdev)->i_mapping;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..da6af2205e55 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -244,7 +244,7 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 				   blk_opf_t op_flags)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(bdev_inode(sb->s_bdev)->i_mapping,
 			~__GFP_FS) | __GFP_MOVABLE;
 
 	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
@@ -253,7 +253,7 @@ struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 					    sector_t block)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(bdev_inode(sb->s_bdev)->i_mapping,
 			~__GFP_FS);
 
 	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
@@ -502,7 +502,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
  */
 static int block_device_ejected(struct super_block *sb)
 {
-	struct inode *bd_inode = sb->s_bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(sb->s_bdev);
 	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
 
 	return bdi->dev == NULL;
@@ -5585,7 +5585,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * used to detect the metadata async write error.
 	 */
 	spin_lock_init(&sbi->s_bdev_wb_lock);
-	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+	errseq_check_and_advance(&bdev_inode(sb->s_bdev)->i_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
-- 
2.39.2


