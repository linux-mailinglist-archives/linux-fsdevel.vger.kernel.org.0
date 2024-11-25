Return-Path: <linux-fsdevel+bounces-35778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF1B9D84B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEB716396E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3431A9B4F;
	Mon, 25 Nov 2024 11:46:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD91156997;
	Mon, 25 Nov 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535194; cv=none; b=t8yoJEcKQ4knOUwKiGXH7aW5EYY7Ebvx5MoWrAFjdLrkfNmULdMDPPBZf4IovmfBR9zsiWpAsWOSZpOa/jsJKMr0R008XrJdNJbx6aIg4drdWCTnbQ2Jl228O6yVN5yLi4w/6hh7aF64J1mVih8IXWG4vYF+wDQTtfBBW6zsqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535194; c=relaxed/simple;
	bh=GUFZ2JT2gMyyPyI9pwx8YESa2DS4C93QR0yz4l9nkZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kl5h9E+qMF8qZ//o1csLYdiI84vs8CCoRXPaiuRhSfhshXi7LzJ5m4WlW5ZidOPA7xd7NMMp+4RFA/uEqAI65Ea9Rp/ivKbVXIK5IhwB7U/H5oC3r4ek8UB7rm1a9oOFiz3Eaq/0OvuQf8CjB7cxlfof2WaqMhjRrTNHT0sPv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XxkRz2bVZz4f3n6S;
	Mon, 25 Nov 2024 19:46:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F22601A018C;
	Mon, 25 Nov 2024 19:46:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4eFY0RnNicrCw--.44046S4;
	Mon, 25 Nov 2024 19:46:24 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/9] ext4: enable large folio for regular files
Date: Mon, 25 Nov 2024 19:44:10 +0800
Message-ID: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4eFY0RnNicrCw--.44046S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4fJr1DZryUWrW8XFW7XFb_yoW7CFy5pF
	1akr4fKr43W3y3C39rCr1YvF4Yka18Gw4rZa4xt3y0vryUZF18ur1vgF40k347Zry7Cryr
	t34UJry5WF1YkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello!

Since almost all of the code paths in ext4 have already been converted
to use folios, there isn't much additional work required to support
large folios. This series completes the remaining work and enables large
folios for regular files on ext4, with the exception of fsverity,
fscrypt, and data=journal mode.

This series is based on 6.12, primarily modifies the block offset and
length calculations within a single folio in the buffer write, buffer
read, zero range, writeback, and move extents paths to support large
folios, without further code refactoring or optimization. Please note
that this series conflicts with the online journal data mode conversion
on active inodes, this may requires further discussion, please refer to
the last patch for details.

Unlike my other series[1], which enables large folios by converting the
buffered I/O path from the classic buffer_head to iomap, this large
folio support solution requires fewer modifications and has fewer
limitations at the moment. We can enable it by default and use it until
ext4 switches to iomap.

This series have passed kvm-xfstests in auto mode several times, every
thing looks fine, any comments are welcome.


About performance:

I used the same test script from my IOMAP series (need to drop the mount
opts parameter MOUNT_OPT) [2], run fio tests on the same machine with
Intel Xeon Gold 6240 CPU with 400GB system ram, 200GB ramdisk and 4TB
nvme ssd disk. Both compared with the base and the IOMAP + large folio
changes.

 == buffer read ==

                base          iomap+large folio base+large folio
 type     bs    IOPS  BW(M/s) IOPS  BW(M/s)     IOPS   BW(M/s)
 ----------------------------------------------------------------
 hole     4K  | 576k  2253  | 762k  2975(+32%) | 747k  2918(+29%)
 hole     64K | 48.7k 3043  | 77.8k 4860(+60%) | 76.3k 4767(+57%)
 hole     1M  | 2960  2960  | 4942  4942(+67%) | 4737  4738(+60%)
 ramdisk  4K  | 443k  1732  | 530k  2069(+19%) | 494k  1930(+11%)
 ramdisk  64K | 34.5k 2156  | 45.6k 2850(+32%) | 41.3k 2584(+20%)
 ramdisk  1M  | 2093  2093  | 2841  2841(+36%) | 2585  2586(+24%)
 nvme     4K  | 339k  1323  | 364k  1425(+8%)  | 344k  1341(+1%)
 nvme     64K | 23.6k 1471  | 25.2k 1574(+7%)  | 25.4k 1586(+8%)
 nvme     1M  | 2012  2012  | 2153  2153(+7%)  | 2122  2122(+5%)


 == buffer write ==

 O: Overwrite; S: Sync; W: Writeback

                     base         iomap+large folio    base+large folio
 type    O S W bs    IOPS  BW     IOPS  BW(M/s)        IOPS  BW(M/s)
 ----------------------------------------------------------------------
 cache   N N N 4K  | 417k  1631 | 440k  1719 (+5%)   | 423k  1655 (+2%)
 cache   N N N 64K | 33.4k 2088 | 81.5k 5092 (+144%) | 59.1k 3690 (+77%)
 cache   N N N 1M  | 2143  2143 | 5716  5716 (+167%) | 3901  3901 (+82%)
 cache   Y N N 4K  | 449k  1755 | 469k  1834 (+5%)   | 452k  1767 (+1%)
 cache   Y N N 64K | 36.6k 2290 | 82.3k 5142 (+125%) | 67.2k 4200 (+83%)
 cache   Y N N 1M  | 2352  2352 | 5577  5577 (+137%  | 4275  4276 (+82%)
 ramdisk N N Y 4K  | 365k  1424 | 354k  1384 (-3%)   | 372k  1449 (+2%)
 ramdisk N N Y 64K | 31.2k 1950 | 74.2k 4640 (+138%) | 56.4k 3528 (+81%)
 ramdisk N N Y 1M  | 1968  1968 | 5201  5201 (+164%) | 3814  3814 (+94%)
 ramdisk N Y N 4K  | 9984  39   | 12.9k 51   (+29%)  | 9871  39   (-1%)
 ramdisk N Y N 64K | 5936  371  | 8960  560  (+51%)  | 6320  395  (+6%)
 ramdisk N Y N 1M  | 1050  1050 | 1835  1835 (+75%)  | 1656  1657 (+58%)
 ramdisk Y N Y 4K  | 411k  1609 | 443k  1731 (+8%)   | 441k  1723 (+7%)
 ramdisk Y N Y 64K | 34.1k 2134 | 77.5k 4844 (+127%) | 66.4k 4151 (+95%)
 ramdisk Y N Y 1M  | 2248  2248 | 5372  5372 (+139%) | 4209  4210 (+87%)
 ramdisk Y Y N 4K  | 182k  711  | 186k  730  (+3%)   | 182k  711  (0%)
 ramdisk Y Y N 64K | 18.7k 1170 | 34.7k 2171 (+86%)  | 31.5k 1969 (+68%)
 ramdisk Y Y N 1M  | 1229  1229 | 2269  2269 (+85%)  | 1943  1944 (+58%)
 nvme    N N Y 4K  | 373k  1458 | 387k  1512 (+4%)   | 399k  1559 (+7%)
 nvme    N N Y 64K | 29.2k 1827 | 70.9k 4431 (+143%) | 54.3k 3390 (+86%)
 nvme    N N Y 1M  | 1835  1835 | 4919  4919 (+168%) | 3658  3658 (+99%)
 nvme    N Y N 4K  | 11.7k 46   | 11.7k 46   (0%)    | 11.5k 45   (-1%)
 nvme    N Y N 64K | 6453  403  | 8661  541  (+34%)  | 7520  470  (+17%)
 nvme    N Y N 1M  | 649   649  | 1351  1351 (+108%) | 885   886  (+37%)
 nvme    Y N Y 4K  | 372k  1456 | 433k  1693 (+16%)  | 419k  1637 (+12%)
 nvme    Y N Y 64K | 33.0k 2064 | 74.7k 4669 (+126%) | 64.1k 4010 (+94%)
 nvme    Y N Y 1M  | 2131  2131 | 5273  5273 (+147%) | 4259  4260 (+100%)
 nvme    Y Y N 4K  | 56.7k 222  | 56.4k 220  (-1%)   | 59.4k 232  (+5%)
 nvme    Y Y N 64K | 13.4k 840  | 19.4k 1214 (+45%)  | 18.5k 1156 (+38%)
 nvme    Y Y N 1M  | 714   714  | 1504  1504 (+111%) | 1319  1320 (+85%)


[1] https://lore.kernel.org/linux-ext4/20241022111059.2566137-1-yi.zhang@huaweicloud.com/
[2] https://lore.kernel.org/linux-ext4/3c01efe6-007a-4422-ad79-0bad3af281b1@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (9):
  fs: make block_read_full_folio() support large folio
  ext4: make ext4_mpage_readpages() support large folios
  ext4: make regular file's buffered write path support large folios
  ext4: make __ext4_block_zero_page_range() support large folio
  ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large
    folio
  ext4: correct the journal credits calculations of allocating blocks
  ext4: make the writeback path support large folios
  ext4: make online defragmentation support large folios
  ext4: enable large folio for regular file

 fs/buffer.c           | 34 ++++++++++----------
 fs/ext4/ext4.h        |  1 +
 fs/ext4/ext4_jbd2.c   |  3 +-
 fs/ext4/ext4_jbd2.h   |  4 +--
 fs/ext4/extents.c     |  5 +--
 fs/ext4/ialloc.c      |  3 ++
 fs/ext4/inode.c       | 72 ++++++++++++++++++++++++++++++-------------
 fs/ext4/move_extent.c | 11 +++----
 fs/ext4/readpage.c    | 28 ++++++++++-------
 fs/jbd2/journal.c     |  7 +++--
 include/linux/jbd2.h  |  2 +-
 11 files changed, 105 insertions(+), 65 deletions(-)

-- 
2.46.1


