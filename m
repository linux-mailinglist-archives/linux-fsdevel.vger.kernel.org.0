Return-Path: <linux-fsdevel+bounces-62705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C5B9E56D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DBE1BC68E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A882ED174;
	Thu, 25 Sep 2025 09:27:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC572EB87A;
	Thu, 25 Sep 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792436; cv=none; b=jY5Ct9Zu7++yEsMOPkGuWoyJJND5iflpLzIxNqF20aR8EfLRwY9RxGxeK4az+MAx+X1DmJgdUM3GC8lrOVUjMHfT2O/qcoOaX/GgdRy5YfhkaZRbOnV6ZG2MSPU6Cegihl8APyVEnfjxmTOBVh6R926NzjlXZoRDlNZ1dF7RmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792436; c=relaxed/simple;
	bh=zWanX7nogCI8mfA/RsGYcnEjUlgWHFo5O2SiXQ82ETU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmXDY/yySFNkX98VPwxdVv6ZGMCta537St+V4dZLau/oEtdWulRM5wa+E34kTV/jCN6ZK4yx3z3Bd9KnjUzt+tCzrHXM08FaNtJI4m5ZRZCF9YnSBkg2CuPv7dsky+E2pgrW65kaxTvKM4bNTfTAwQMvuQoIeqKaKYN67v4VHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXSz61QV3zKHN4B;
	Thu, 25 Sep 2025 17:26:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1DDD91A1696;
	Thu, 25 Sep 2025 17:27:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgD3CGHeCtVovAkNAw--.52999S4;
	Thu, 25 Sep 2025 17:27:04 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 00/13] ext4: optimize online defragment
Date: Thu, 25 Sep 2025 17:25:56 +0800
Message-ID: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3CGHeCtVovAkNAw--.52999S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1rAFWkJw1xWrW3JFykGrg_yoWrtw4Upa
	yakr1xtrWkJw1kW3yxZFs2qryYkw4rGr47CF4UJr15GF1rJFyFqFW8ta98ZFy8AFWxZ34Y
	va1Iyr1Uu3WUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v1:
 - Fix the syzbot issues reported in v1 by adjusting the order of
   parameter checks in mext_check_validity() in patches 07 and 08.

v1: https://lore.kernel.org/linux-ext4/20250923012724.2378858-1-yi.zhang@huaweicloud.com/


Original Description:

Currently, the online defragmentation of the ext4 is primarily
implemented through the move extent operation in the kernel. This
extent-moving operates at the granularity of PAGE_SIZE, iteratively
performing extent swapping and data movement operations, which is quite
inefficient. Especially since ext4 now supports large folios, iterations
at the PAGE_SIZE granularity are no longer practical and fail to
leverage the advantages of large folios. Additionally, the current
implementation is tightly coupled with buffer_head, making it unable to
support after the conversion of buffered I/O processes to the iomap
infrastructure.

This patch set (based on 6.17-rc7) optimizes the extent-moving process,
deprecates the old move_extent_per_page() interface, and introduces a
new mext_move_extent() interface. The new interface iterates over and
copies data based on the extents of the original file instead of the
PAGE_SIZE, and supporting large folios. The data processing logic in the
iteration remains largely consistent with previous versions, with no
additional optimizations or changes made. 

Additionally, the primary objective of this set of patches is to prepare
for converting the buffered I/O process for regular files to the iomap
infrastructure. These patches decouple the buffer_head from the main
extent-moving process, restricting its use to only the helpers
mext_folio_mkwrite() and mext_folio_mkuptodate(), which handle updating
and marking pages in the swapped page cache as dirty. The overall coding
style of the extent-moving process aligns with the iomap infrastructure,
laying the foundation for supporting online defragmentation once the
iomap infrastructure is adopted.

Patch overview:

Patch 1:    Fix an off-by-one issue.
Patch 2:    Fix a minor issue related to validity checking.
Patch 3-5:  Introduce a sequence counter for the mapping extent status
            tree, this also prepares for the iomap infrastructure.
Patch 6-8:  Refactor the mext_check_arguments() helper function and the
            validity checking to improve code readability.
Patch 9-13: Drop move_extent_per_page() and switch to using the new
            mext_move_extent(). Additionally, add support for large
            folios.

With this patch set, the efficiency of online defragmentation for the
ext4 file system can also be improved under general circumstances. Below
is a set of typical test obtained using the fio e4defrag ioengine on the
environment with Intel Xeon Gold 6240 CPU, 400G memory and a NVMe SSD
device.

  [defrag]
  directory=/mnt
  filesize=400G
  buffered=1
  fadvise_hint=0
  ioengine=e4defrag
  bs=4k         # 4k,32k,128k
  donorname=test.def
  filename=test
  inplace=0
  rw=write
  overwrite=0   # 0 for unwritten extent and 1 for written extent
  numjobs=1
  iodepth=1
  runtime=30s

  [w/o]
   U 4k:    IOPS=225k,  BW=877MiB/s      # U: unwritten extent-moving
   U 32k:   IOPS=33.2k, BW=1037MiB/s
   U 128k:  IOPS=8510,  BW=1064MiB/s
   M 4k:    IOPS=19.8k, BW=77.2MiB/s     # M: written extent-moving
   M 32k:   IOPS=2502,  BW=78.2MiB/s
   M 128k:  IOPS=635,   BW=79.5MiB/s

  [w]
   U 4k:    IOPS=246k,  BW=963MiB/s
   U 32k:   IOPS=209k,  BW=6529MiB/s
   U 128k:  IOPS=146k,  BW=17.8GiB/s
   M 4k:    IOPS=19.5k, BW=76.2MiB/s
   M 32k:   IOPS=4091,  BW=128MiB/s
   M 128k:  IOPS=2814,  BW=352MiB/s 


Best Regards,
Yi.


Zhang Yi (13):
  ext4: fix an off-by-one issue during moving extents
  ext4: correct the checking of quota files before moving extents
  ext4: introduce seq counter for the extent status entry
  ext4: make ext4_es_lookup_extent() pass out the extent seq counter
  ext4: pass out extent seq counter when mapping blocks
  ext4: use EXT4_B_TO_LBLK() in mext_check_arguments()
  ext4: add mext_check_validity() to do basic check
  ext4: refactor mext_check_arguments()
  ext4: rename mext_page_mkuptodate() to mext_folio_mkuptodate()
  ext4: introduce mext_move_extent()
  ext4: switch to using the new extent movement method
  ext4: add large folios support for moving extents
  ext4: add two trace points for moving extents

 fs/ext4/ext4.h              |   3 +
 fs/ext4/extents.c           |   2 +-
 fs/ext4/extents_status.c    |  27 +-
 fs/ext4/extents_status.h    |   2 +-
 fs/ext4/inode.c             |  28 +-
 fs/ext4/ioctl.c             |  10 -
 fs/ext4/move_extent.c       | 773 ++++++++++++++++--------------------
 fs/ext4/super.c             |   1 +
 include/trace/events/ext4.h |  97 ++++-
 9 files changed, 486 insertions(+), 457 deletions(-)

-- 
2.46.1


