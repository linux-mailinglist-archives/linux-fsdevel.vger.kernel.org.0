Return-Path: <linux-fsdevel+bounces-65597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE1C0899F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAE21C29453
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0CD2BE646;
	Sat, 25 Oct 2025 03:30:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E202580E1;
	Sat, 25 Oct 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363009; cv=none; b=Z0GDEFh8qmdMXYWMWgdCD84CfM4LBi62h9IH6WZjRaa/2h6Rd9oxo9ZnOrF5Mvku8L6FUmEG0+ML67fH7+bUcD3DUTI33ki6C/kEqGzNmWA65UqbPruCKGc4u8jd8zY867gQH1Ht2SSywlRopMqtAhHWXd+YHFXoxdWnromK4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363009; c=relaxed/simple;
	bh=k/RKIM+LzsqDDndA1nXVG1X/v8FpsawgAkLR38cs/YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c/5jJOX4wpSy5aElb+ENbxE8piza7DUUzIzAZmQ/nVMj+zwXdq2uFCfmf1Eqo66G0yT1S1mG0xs8GrqzOlX468q75NgNKnMpFz86mqcjh8H7qgpH9PXo/TnyojE+bpq/W8/ZWwUNaJSM0yLGGhkG3438mSE1lVejWRv8bSODtuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcR5lTbzKHMMn;
	Sat, 25 Oct 2025 11:29:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7CD121A0CD3;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S4;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 00/25] ext4: enable block size larger than page size
Date: Sat, 25 Oct 2025 11:21:56 +0800
Message-Id: <20251025032221.2905818-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw47Jr43Gw1xuryfZw1xGrg_yoWxJr4Dpa
	yfJF13Ar45G3yYk3ZxWw1ktr48Wa18Gr1UXry7t348ur1Iyr18trZFyFy8ZFWjkry7JFyj
	qF1fJr4xG3Wjk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoPEfDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBWj7Ua9I5wAAsJ

From: Baokun Li <libaokun1@huawei.com>

This series enables block size > page size (Large Block Size) in EXT4.

Since large folios are already supported for regular files, the required
changes are not substantial, but they are scattered across the code.
The changes primarily focus on cleaning up potential division-by-zero
errors, resolving negative left/right shifts, and correctly handling
mutually exclusive mount options.

One somewhat troublesome issue is that allocating page units greater than
order-1 with __GFP_NOFAIL in __alloc_pages_slowpath() can trigger an
unexpected WARN_ON. With LBS support, EXT4 and jbd2 may use __GFP_NOFAIL
to allocate large folios when reading metadata.

To avoid this warning, when jbd2_alloc() and grow_dev_folio() attempt to
allocate with order greater than 1, the __GFP_NOFAIL flag is not passed
down; instead, the functions retry internally to satisfy the allocation.

Patch series based on 6.18-rc2. `kvm-xfstests -c ext4/all -g auto` has
been executed with no new failures. `kvm-xfstests -c ext4/64k -g auto`
has been executed and no Oops was observed.

Here are some performance test data for your reference:

Testing EXT4 filesystems with different block sizes, measuring
single-threaded dd bandwidth for BIO/DIO with varying bs values.

Before(PAGE_SIZE=4096):

      BIO     | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
--------------|----------|----------|----------|----------|------------
 4k           | 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
 8k (bigalloc)| 1.4 GB/s | 2.0 GB/s | 2.6 GB/s | 3.1 GB/s | 3.4 GB/s
 16k(bigalloc)| 1.5 GB/s | 2.0 GB/s | 2.6 GB/s | 3.2 GB/s | 3.6 GB/s
 32k(bigalloc)| 1.5 GB/s | 2.1 GB/s | 2.7 GB/s | 3.3 GB/s | 3.7 GB/s
 64k(bigalloc)| 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
              
      DIO     | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
--------------|----------|----------|----------|----------|------------
 4k           | 194 MB/s | 366 MB/s | 626 MB/s | 1.0 GB/s | 1.4 GB/s
 8k (bigalloc)| 188 MB/s | 359 MB/s | 612 MB/s | 996 MB/s | 1.4 GB/s
 16k(bigalloc)| 208 MB/s | 378 MB/s | 642 MB/s | 1.0 GB/s | 1.4 GB/s
 32k(bigalloc)| 184 MB/s | 368 MB/s | 637 MB/s | 995 MB/s | 1.4 GB/s
 64k(bigalloc)| 208 MB/s | 389 MB/s | 634 MB/s | 1.0 GB/s | 1.4 GB/s

Patched(PAGE_SIZE=4096):

   BIO   | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
---------|----------|----------|----------|----------|------------
 4k      | 1.5 GB/s | 2.1 GB/s | 2.8 GB/s | 3.4 GB/s | 3.8 GB/s
 8k (LBS)| 1.7 GB/s | 2.3 GB/s | 3.2 GB/s | 4.2 GB/s | 4.7 GB/s
 16k(LBS)| 2.0 GB/s | 2.7 GB/s | 3.6 GB/s | 4.7 GB/s | 5.4 GB/s
 32k(LBS)| 2.2 GB/s | 3.1 GB/s | 3.9 GB/s | 4.9 GB/s | 5.7 GB/s
 64k(LBS)| 2.4 GB/s | 3.3 GB/s | 4.2 GB/s | 5.1 GB/s | 6.0 GB/s

   DIO   | bs=4k    | bs=8k    | bs=16k   | bs=32k   | bs=64k
---------|----------|----------|----------|----------|------------
 4k      | 204 MB/s | 355 MB/s | 627 MB/s | 1.0 GB/s | 1.4 GB/s
 8k (LBS)| 210 MB/s | 356 MB/s | 602 MB/s | 997 MB/s | 1.4 GB/s
 16k(LBS)| 191 MB/s | 361 MB/s | 589 MB/s | 981 MB/s | 1.4 GB/s
 32k(LBS)| 181 MB/s | 330 MB/s | 581 MB/s | 951 MB/s | 1.3 GB/s
 64k(LBS)| 148 MB/s | 272 MB/s | 499 MB/s | 840 MB/s | 1.3 GB/s


The results show:

 * The code changes have almost no impact on the original 4k write
   performance of ext4.
 * Compared with bigalloc, LBS improves BIO write performance by about 50%
   on average.
 * Compared with bigalloc, LBS shows degradation in DIO write performance,
   which increases as the filesystem block size grows and the test bs
   decreases, with a maximum degradation of about 30%.

The DIO regression is primarily due to the increased time spent in
crc32c_arch() within ext4_block_bitmap_csum_set() during block allocation,
as the block size grows larger. This indicates that larger filesystem block
sizes are not always better; please choose an appropriate block size based
on your I/O workload characteristics.

We are also planning further optimizations for block allocation under LBS
in the future.

Comments and questions are, as always, welcome.

Thanks,
Baokun


Baokun Li (21):
  ext4: remove page offset calculation in ext4_block_truncate_page()
  ext4: remove PAGE_SIZE checks for rec_len conversion
  ext4: make ext4_punch_hole() support large block size
  ext4: enable DIOREAD_NOLOCK by default for BS > PS as well
  ext4: introduce s_min_folio_order for future BS > PS support
  ext4: support large block size in ext4_calculate_overhead()
  ext4: support large block size in ext4_readdir()
  ext4: add EXT4_LBLK_TO_B macro for logical block to bytes conversion
  ext4: add EXT4_LBLK_TO_P and EXT4_P_TO_LBLK for block/page conversion
  ext4: support large block size in ext4_mb_load_buddy_gfp()
  ext4: support large block size in ext4_mb_get_buddy_page_lock()
  ext4: support large block size in ext4_mb_init_cache()
  ext4: prepare buddy cache inode for BS > PS with large folios
  ext4: support large block size in ext4_mpage_readpages()
  ext4: support large block size in ext4_block_write_begin()
  ext4: support large block size in mpage_map_and_submit_buffers()
  ext4: support large block size in mpage_prepare_extent_to_map()
  fs/buffer: prevent WARN_ON in __alloc_pages_slowpath() when BS > PS
  jbd2: prevent WARN_ON in __alloc_pages_slowpath() when BS > PS
  ext4: add checks for large folio incompatibilities when BS > PS
  ext4: enable block size larger than page size

Zhihao Cheng (4):
  ext4: remove page offset calculation in ext4_block_zero_page_range()
  ext4: rename 'page' references to 'folio' in multi-block allocator
  ext4: support large block size in __ext4_block_zero_page_range()
  ext4: make online defragmentation support large block size

 fs/buffer.c           |  33 +++++++++-
 fs/ext4/dir.c         |   8 +--
 fs/ext4/ext4.h        |  27 ++++-----
 fs/ext4/extents.c     |   2 +-
 fs/ext4/inode.c       |  69 ++++++++++-----------
 fs/ext4/mballoc.c     | 137 ++++++++++++++++++++++--------------------
 fs/ext4/move_extent.c |  20 +++---
 fs/ext4/namei.c       |   8 +--
 fs/ext4/readpage.c    |   7 +--
 fs/ext4/super.c       |  52 ++++++++++++----
 fs/ext4/verity.c      |   2 +-
 fs/jbd2/journal.c     |  28 ++++++++-
 12 files changed, 234 insertions(+), 159 deletions(-)

-- 
2.46.1


