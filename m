Return-Path: <linux-fsdevel+bounces-3519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6597F5F61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 13:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6911D281DA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1B24A0A;
	Thu, 23 Nov 2023 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540E189;
	Thu, 23 Nov 2023 04:52:03 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SbdKn2bnwz4f3k6X;
	Thu, 23 Nov 2023 20:51:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 090161A046D;
	Thu, 23 Nov 2023 20:51:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S4;
	Thu, 23 Nov 2023 20:51:56 +0800 (CST)
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
Subject: [RFC PATCH 00/18] ext4: use iomap for regular file's buffered IO path and enable large foilo
Date: Thu, 23 Nov 2023 20:51:02 +0800
Message-Id: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGF45GF15GFWUGFWxKrWDCFg_yoWrCFyfpF
	9Ikr1fKr1kZryI9an3Cw47Jr4F9ws5Cr17WFW3Wry8ZFyUuFy8ZFn7KF1FyFyrGrW7Zr1j
	vr4Iyry8Gw1Yy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	XdbUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello,

This is a RFC patch set based on 6.6 that partial switch to use iomap
for regular file's buffered IO path in ext4. Now this only support ext4
filesystem with the default features and mount options, didn't support
inline_data, bigalloc, dax, fs_verity, fs_crypt, and data=journal mode
yet. I have test it through fstests -g quick with 4K block size and
some simple performance tests, all the apparent issues have been fixed
right now. This is just for discussion and check the overall plan is
feasible or not, I haven't done other tests, there must be some other
bugs need to fix later. This is the first time I've developed such a
large feature for ext4, so I hope you would like it, I will keep on
testing and improving these patches, any comments are helpful. For the
convenience of review, I split the implements into small patches.

Patch 1-6: this is a preparation that changes ext4_map_blocks() and
ext4_set_iomap() that could recognize delayed only extents, I've send it
out separately[1] because I've done full tests and suppose this can be
reviewed and merged firstly.

Patch 7: this is also a preparation that let ext4_insert_delayed_block()
can add multi-blocks once a time.

Patch 8-16: Introduce a new aops names ext4_iomap_aops for iomap,
implement buffer read, buffer write, writeback, mmap and 
zero_range/truncate path. Also inculdes two minor modifications in
iomap, Please look at the following patch for details.

Patch 17-18: Switch to iomap for regular file's buffered IO path besides
inline_data, bigalloc, dax, fs_verity, fs_crypt, and data=journal mode,
and enable large folio.

About Tests:
 - I've test it through fstests -g quick with 4k block size.
 - I've done a few quick performance tests below.
   Fio tests with psync and 1 thread on my virt machine's ramdisk.

                    bs  buffer_head              iomap with large foilo
   ---------------------------------------------------------------
   write+fsync      1M  IOPS=651, BW=652MiB/s    IOPS=1442, BW=1442MiB/s
   overwrite+fsync  1M  IOPS=832, BW=832MiB/s    IOPS=2064, BW=2065MiB/s
   read hole        1M  IOPS=1769, BW=1769MiB/s  IOPS=3556, BW=3557MiB/s
   read data        1M  IOPS=1464, BW=1465MiB/s  IOPS=2376, BW=2377MiB/s

TODO
 - Do 'kvm-xfstests -g auto' tests and keep on doing stress tests and
   fixing.
 - Do further performance analyse.
 - I noticed the discussion from Ritesh's ext2 conversion[2], I will
   also check the common part in it.
 - Support more filesystem features and mount options and maybe could
   totally remove ext4_da_aops and ext4_aops in the future.

[1] https://lore.kernel.org/linux-ext4/20231121093429.1827390-1-yi.zhang@huaweicloud.com/T/#t
[2] https://lore.kernel.org/linux-ext4/ZV2k9pR13SbXitRT@infradead.org/T/#t

Thanks,
Yi.

Zhang Yi (18):
  ext4: introduce ext4_es_skip_hole_extent() to skip hole extents
  ext4: make ext4_es_lookup_extent() return the next extent if not found
  ext4: correct the hole length returned by ext4_map_blocks()
  ext4: add a hole extent entry in cache after punch
  ext4: make ext4_map_blocks() distinguish delayed only mapping
  ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC mapping type
  ext4: allow reserving multi-delayed blocks
  ext4: add a new iomap aops for regular file's buffered IO path
  ext4: implement buffered read iomap path
  ext4: implement buffered write iomap path
  iomap: add a fs private parameter to iomap_ioend
  iomap: don't increase i_size if it's not a write operation
  ext4: impliment writeback iomap path
  ext4: impliment zero_range iomap path
  ext4: writeback partial blocks before zero range
  ext4: impliment mmap iomap path
  ext4: partial enable iomap for regular file's buffered IO path
  ext4: enable large folio for regular file which has been switched to
    use iomap

 fs/ext4/ext4.h              |  15 +-
 fs/ext4/ext4_jbd2.c         |   3 +-
 fs/ext4/extents.c           |  14 +-
 fs/ext4/extents_status.c    |  73 ++--
 fs/ext4/extents_status.h    |   6 +-
 fs/ext4/file.c              |  14 +-
 fs/ext4/ialloc.c            |   5 +
 fs/ext4/inode.c             | 737 ++++++++++++++++++++++++++++++++----
 fs/ext4/move_extent.c       |   8 +
 fs/ext4/page-io.c           |  74 ++++
 fs/ext4/super.c             |   2 +
 fs/iomap/buffered-io.c      |   5 +-
 include/linux/iomap.h       |   1 +
 include/trace/events/ext4.h |  40 +-
 14 files changed, 877 insertions(+), 120 deletions(-)

-- 
2.39.2


