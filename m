Return-Path: <linux-fsdevel+bounces-5488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 791AD80CDB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA86D1C212E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0634E635;
	Mon, 11 Dec 2023 14:08:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE84C4215;
	Mon, 11 Dec 2023 06:08:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpkB66cdZz4f3kKB;
	Mon, 11 Dec 2023 22:08:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 128521A0847;
	Mon, 11 Dec 2023 22:08:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDX2xHtF3dlUJpxDQ--.35009S4;
	Mon, 11 Dec 2023 22:08:47 +0800 (CST)
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
	agruenba@redhat.com,
	jack@suse.com,
	konishi.ryusuke@gmail.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	p.raghav@samsung.com,
	hare@suse.de
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
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 for-6.8/block 11/18] erofs: use bdev api
Date: Mon, 11 Dec 2023 22:07:22 +0800
Message-Id: <20231211140722.974745-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211140552.973290-1-yukuai1@huaweicloud.com>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2xHtF3dlUJpxDQ--.35009S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kuFy3Wr1DurykKryxGrg_yoW8KrW8pF
	W7Cr1rGrWrXrs09wn2gr1UZF43ta97Jw48CayxJw1Fv3yUtryagFy0ywnrGr48Kr4kKrs2
	qF1Ivryxuw1UGrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0J
	UCXdbUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Avoid to access bd_inode directly, prepare to remove bd_inode from
block_devcie.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/erofs/data.c     | 18 ++++++++++++------
 fs/erofs/internal.h |  2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index c98aeda8abb2..8cf3618190ab 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -32,8 +32,7 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
 		  enum erofs_kmap_type type)
 {
-	struct inode *inode = buf->inode;
-	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
+	erofs_off_t offset = (erofs_off_t)blkaddr << buf->blkszbits;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 	struct folio *folio;
@@ -43,7 +42,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
 		erofs_put_metabuf(buf);
 
 		nofs_flag = memalloc_nofs_save();
-		folio = read_cache_folio(inode->i_mapping, index, NULL, NULL);
+		folio = buf->inode ?
+			read_mapping_folio(buf->inode->i_mapping, index, NULL) :
+			bdev_read_folio(buf->bdev, offset);
 		memalloc_nofs_restore(nofs_flag);
 		if (IS_ERR(folio))
 			return folio;
@@ -67,10 +68,15 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
 
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
-	if (erofs_is_fscache_mode(sb))
+	if (erofs_is_fscache_mode(sb)) {
 		buf->inode = EROFS_SB(sb)->s_fscache->inode;
-	else
-		buf->inode = sb->s_bdev->bd_inode;
+		buf->bdev = NULL;
+		buf->blkszbits = buf->inode->i_blkbits;
+	} else {
+		buf->inode = NULL;
+		buf->bdev = sb->s_bdev;
+		buf->blkszbits = EROFS_SB(sb)->blkszbits;
+	}
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb017..c9206351b485 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -224,8 +224,10 @@ enum erofs_kmap_type {
 
 struct erofs_buf {
 	struct inode *inode;
+	struct block_device *bdev;
 	struct page *page;
 	void *base;
+	u8 blkszbits;
 	enum erofs_kmap_type kmap_type;
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
-- 
2.39.2


