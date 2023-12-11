Return-Path: <linux-fsdevel+bounces-5487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE74E80CD90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37A21C210D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CC84CE09;
	Mon, 11 Dec 2023 14:07:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E50093E1;
	Mon, 11 Dec 2023 06:07:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Spk8j1vMMz4f3kkY;
	Mon, 11 Dec 2023 22:07:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 66DE61A0A1D;
	Mon, 11 Dec 2023 22:07:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xGTF3dlDYFxDQ--.28013S14;
	Mon, 11 Dec 2023 22:07:33 +0800 (CST)
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
Subject: [PATCH RFC v2 for-6.8/block 10/18] cramfs: use bdev apis in cramfs_blkdev_read()
Date: Mon, 11 Dec 2023 22:05:44 +0800
Message-Id: <20231211140552.973290-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDn6xGTF3dlDYFxDQ--.28013S14
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww17ur1fXryfAFyrJF4fKrg_yoW8tF4UpF
	1akanIkr4q9ryI9ayfXr1DZF15Ga4kXF4DCFWxu3y3Z3W5Jrna9r10kry0qFW8GrZFqryv
	9r4jkryfur15Ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand covert to use folio while reading bdev inode, on the
other hand prevent to access bd_inode directly.

Also do some cleanup that there is no need for two for loop, and remove
local array pages.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/cramfs/inode.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 60dbfa0f8805..fad95d683d97 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -183,9 +183,6 @@ static int next_buffer;
 static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 				unsigned int len)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
-	struct file_ra_state ra = {};
-	struct page *pages[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer;
 	unsigned long devsize;
 	char *data;
@@ -214,37 +211,30 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 	devsize = bdev_nr_bytes(sb->s_bdev) >> PAGE_SHIFT;
 
 	/* Ok, read in BLKS_PER_BUF pages completely first. */
-	file_ra_state_init(&ra, mapping);
-	page_cache_sync_readahead(mapping, &ra, NULL, blocknr, BLKS_PER_BUF);
-
-	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct page *page = NULL;
-
-		if (blocknr + i < devsize) {
-			page = read_mapping_page(mapping, blocknr + i, NULL);
-			/* synchronous error? */
-			if (IS_ERR(page))
-				page = NULL;
-		}
-		pages[i] = page;
-	}
+	bdev_sync_readahead(sb->s_bdev, NULL, NULL, blocknr, BLKS_PER_BUF);
 
 	buffer = next_buffer;
 	next_buffer = NEXT_BUFFER(buffer);
 	buffer_blocknr[buffer] = blocknr;
 	buffer_dev[buffer] = sb;
-
 	data = read_buffers[buffer];
+
 	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct page *page = pages[i];
+		struct folio *folio = NULL;
+
+		if (blocknr + i < devsize)
+			folio = bdev_read_folio(sb->s_bdev,
+						(blocknr + i) << PAGE_SHIFT);
 
-		if (page) {
-			memcpy_from_page(data, page, 0, PAGE_SIZE);
-			put_page(page);
-		} else
+		if (IS_ERR_OR_NULL(folio)) {
 			memset(data, 0, PAGE_SIZE);
+		} else {
+			memcpy_from_folio(data, folio, 0, PAGE_SIZE);
+			folio_put(folio);
+		}
 		data += PAGE_SIZE;
 	}
+
 	return read_buffers[buffer] + offset;
 }
 
-- 
2.39.2


