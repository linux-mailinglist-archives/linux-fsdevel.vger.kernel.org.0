Return-Path: <linux-fsdevel+bounces-6635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D77981B0F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9E1F24097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 08:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF6219F6;
	Thu, 21 Dec 2023 08:59:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E52031F;
	Thu, 21 Dec 2023 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwkrH5QHmz4f3k5w;
	Thu, 21 Dec 2023 16:59:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1B9E81A086D;
	Thu, 21 Dec 2023 16:59:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDnNw5d_oNlEQPvEA--.24929S4;
	Thu, 21 Dec 2023 16:59:12 +0800 (CST)
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
Subject: [PATCH RFC v3 for-6.8/block 00/17] block: don't access bd_inode directly from other modules
Date: Thu, 21 Dec 2023 16:56:55 +0800
Message-Id: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnNw5d_oNlEQPvEA--.24929S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw18WF43ur1kJF1xJFW8WFg_yoW5Jr4rpr
	nxKF4fGr48u34xuayS9a17t34rJa1kGayUW3W2y345ZFWrZFyfZrWktF1rJFykJrZ7Xr4k
	Xr1jyryrKr1I9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x0JUd8n5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v3:
 - remove bdev_associated_mapping() and patch 12 from v1;
 - add kerneldoc comments for new bdev apis;
 - rename __bdev_get_folio() to bdev_get_folio;
 - fix a problem in erofs that erofs_init_metabuf() is not always
 called.
 - add reviewed-by tag for patch 15-17;
Changes in v2:
 - remove some bdev apis that is not necessary;
 - pass in offset for bdev_read_folio() and __bdev_get_folio();
 - remove bdev_gfp_constraint() and add a new helper in fs/buffer.c to
 prevent access bd_indoe() directly from mapping_gfp_constraint() in
 ext4.(patch 15, 16);
 - remove block_device_ejected() from ext4.


Patch 1 add some bdev apis, then follow up patches will use these apis
to avoid access bd_inode directly, and hopefully the field bd_inode can
be removed eventually(after figure out a way for fs/buffer.c).

Yu Kuai (17):
  block: add some bdev apis
  xen/blkback: use bdev api in xen_update_blkif_status()
  bcache: use bdev api in read_super()
  mtd: block2mtd: use bdev apis
  s390/dasd: use bdev api in dasd_format()
  scsicam: use bdev api in scsi_bios_ptable()
  bcachefs: remove dead function bdev_sectors()
  bio: export bio_add_folio_nofail()
  btrfs: use bdev apis
  cramfs: use bdev apis in cramfs_blkdev_read()
  erofs: use bdev api
  nilfs2: use bdev api in nilfs_attach_log_writer()
  jbd2: use bdev apis
  buffer: add a new helper to read sb block
  ext4: use new helper to read sb block
  ext4: remove block_device_ejected()
  ext4: use bdev apis

 block/bdev.c                       | 148 +++++++++++++++++++++++++++++
 block/bio.c                        |   1 +
 block/blk.h                        |   2 -
 drivers/block/xen-blkback/xenbus.c |   3 +-
 drivers/md/bcache/super.c          |  11 +--
 drivers/mtd/devices/block2mtd.c    |  81 +++++++---------
 drivers/s390/block/dasd_ioctl.c    |   5 +-
 drivers/scsi/scsicam.c             |   4 +-
 fs/bcachefs/util.h                 |   5 -
 fs/btrfs/disk-io.c                 |  71 +++++++-------
 fs/btrfs/volumes.c                 |  17 ++--
 fs/btrfs/zoned.c                   |  15 +--
 fs/buffer.c                        |  68 +++++++++----
 fs/cramfs/inode.c                  |  36 +++----
 fs/erofs/data.c                    |  18 ++--
 fs/erofs/internal.h                |   2 +
 fs/ext4/dir.c                      |   6 +-
 fs/ext4/ext4.h                     |  13 ---
 fs/ext4/ext4_jbd2.c                |   6 +-
 fs/ext4/inode.c                    |   8 +-
 fs/ext4/super.c                    |  66 +++----------
 fs/ext4/symlink.c                  |   2 +-
 fs/jbd2/journal.c                  |   3 +-
 fs/jbd2/recovery.c                 |   6 +-
 fs/nilfs2/segment.c                |   2 +-
 include/linux/blkdev.h             |  17 ++++
 include/linux/buffer_head.h        |  18 +++-
 27 files changed, 377 insertions(+), 257 deletions(-)

-- 
2.39.2


