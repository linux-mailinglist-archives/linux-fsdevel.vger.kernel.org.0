Return-Path: <linux-fsdevel+bounces-3885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8157F9992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954F7B2173F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223DE179AD;
	Mon, 27 Nov 2023 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0C13A;
	Sun, 26 Nov 2023 22:22:11 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SdwV71ygyz4f3knW;
	Mon, 27 Nov 2023 14:22:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 13E021A0AD3;
	Mon, 27 Nov 2023 14:22:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDX2hB+NWRlrcU8CA--.57866S12;
	Mon, 27 Nov 2023 14:22:08 +0800 (CST)
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
Subject: [PATCH block/for-next v2 08/16] btrfs: use new helper to get inode from block_device
Date: Mon, 27 Nov 2023 14:21:08 +0800
Message-Id: <20231127062116.2355129-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2hB+NWRlrcU8CA--.57866S12
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1xKFykCFWxKFyUKFy5CFg_yoW5XFWkpr
	9xCF98tw4UXr1jga1kW3yvvr1Sqa1vkayxCr93Jw4S9rWxtryYqFyqkry8Za40yrW8JF17
	XF4jk3yUXr10krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Which is more efficiency, and also prepare to remove the field
'bd_inode' from block_device.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 fs/btrfs/volumes.c | 4 ++--
 fs/btrfs/zoned.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 401ea09ae4b8..88b20cd4d046 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3653,7 +3653,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	struct btrfs_super_block *super;
 	struct page *page;
 	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
@@ -3740,7 +3740,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(device->bdev)->i_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3857,7 +3857,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
+		page = find_get_page(bdev_inode(device->bdev)->i_mapping,
 				     bytenr >> PAGE_SHIFT);
 		if (!page) {
 			errors++;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6f16625af51..bbf157cedab7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1257,8 +1257,8 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index, GFP_KERNEL);
-
+	page = read_cache_page_gfp(bdev_inode(bdev)->i_mapping, index,
+				   GFP_KERNEL);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 188378ca19c7..a5f7f1458edf 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -120,7 +120,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		return -ENOENT;
 	} else if (full[0] && full[1]) {
 		/* Compare two super blocks */
-		struct address_space *mapping = bdev->bd_inode->i_mapping;
+		struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 		struct page *page[BTRFS_NR_SB_LOG_ZONES];
 		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
 		int i;
-- 
2.39.2


