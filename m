Return-Path: <linux-fsdevel+bounces-54114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057FAFB5CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA72E4A3128
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B732D9494;
	Mon,  7 Jul 2025 14:23:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C82D8375;
	Mon,  7 Jul 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898180; cv=none; b=CIJnPZBhcpTvMjB+uwcOr+vlgZNY+vKT+gvjKsjHL3o+ZyaZBFgfE8s2+kRTdlXVYXiUCpf5V5rTU6l4FDJA5zdnd1SbSvZW8blEJvjerYjSWD9S93vY75KaKJ2JX4FAcNgFdNPkWAEczFqL25q4hV7Nvz/We9bmIrG3xr+4MYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898180; c=relaxed/simple;
	bh=mwRNkUG9Ads6twT1NddkxxWfD8nyJM5H91oOZh3c1t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnULpuRBOTpjmldiXHrQ3Eta4+IrLlBUwzv+iDAp3Fl05ORZCszhi+fe4vGY0VsG5TBhWlfJ5NO2vn1V64ylAloxKiInorQCsAtBxpZgvhJAaeDfYPQgQekRC48L9hBXpHfvAVJwB9yxNlChgKHW4XjGL4M6zoI0af2M9hpHZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bbRKX4lN0zYQtvZ;
	Mon,  7 Jul 2025 22:22:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 780E91A0E25;
	Mon,  7 Jul 2025 22:22:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyQ22GtoNazLAw--.46745S4;
	Mon, 07 Jul 2025 22:22:53 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	naresh.kamboju@linaro.org,
	jiangqi903@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 00/11] ext4: fix insufficient credits when writing back large folios
Date: Mon,  7 Jul 2025 22:08:03 +0800
Message-ID: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxyQ22GtoNazLAw--.46745S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5tF4kWry5tr1DKFyUJrb_yoWrJF4UpF
	W3CF15Gr1rZw17Za9rXa18CF1rGan5Cr47Xry3K3s8uayDuFyIkFZaga1Y9FyUArZ3GFy0
	qr4jyryDCFy5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFjjgDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v3:
 - Fix the end_pos assignment in patch 01.
 - Rename mpage_submit_buffers() to mpage_submit_partial_folio(), and
   fix a left shift out-of-bounds problem in patch 03.
 - Fix the spelling errors in patch 04.
 - Add a comment for NULL 'handle' test in
   ext4_journal_ensure_extent_credits().
 - Add patch 11 to limit the maximum order of the folio to 2048 fs
   blocks, prevent the overestimation of reserve journal credits during
   folios write-back.
Changes since v2:
 - Convert the processing of folios writeback in bytes instead of pages.
 - Refactor ext4_page_mkwrite() and ensure journal credits in
   ext4_block_write_begin() instead of in _ext4_get_block().
 - Enhance tracepoints in ext4_do_writepages().
 - Replace the outdated ext4_da_writepages_trans_blocks() and
   ext4_writepage_trans_blocks() with the new helper used to reserve
   credits for a single extent.
Changes since v1:
 - Make the write-back process supports writing a partial folio if it
   exits the mapping loop prematurely due to insufficient sapce or
   journal credits, it also fix the potential stale data and
   inconsistency issues.
 - Fix the same issue regarding the allocation of blocks in
   ext4_write_begin() and ext4_page_mkwrite() when delalloc is not
   enabled.

v3: https://lore.kernel.org/linux-ext4/20250701130635.4079595-1-yi.zhang@huaweicloud.com/
v2: https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
v1: https://lore.kernel.org/linux-ext4/20250530062858.458039-1-yi.zhang@huaweicloud.com/

Original Description

This series addresses the issue that Jan pointed out regarding large
folios support for ext4[1]. The problem is that the credits calculation
may insufficient in ext4_meta_trans_blocks() when allocating blocks
during write back a sufficiently large and discontinuous folio, it
doesn't involve the credits for updating bitmap and group descriptor
block. However, if we fix this issue, it may lead to significant
overestimation on the some filesystems with a lot of block groups.

The solution involves first ensure that the current journal transaction
has enough credits when we mapping an extent during allocating blocks.
Then if the credits reach the upper limit, exit the current mapping
loop, submit the partial folio and restart a new transaction. Finally,
fix the wrong credits calculation in ext4_meta_trans_blocks(). Please
see the following patches for details.

[1] https://lore.kernel.org/linux-ext4/ht54j6bvjmiqt62xmcveqlo7bmrunqs4ji7wikfteftdjijzek@7tz5gpejaoen/

Thanks,
Yi.

Zhang Yi (11):
  ext4: process folios writeback in bytes
  ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
  ext4: fix stale data if it bail out of the extents mapping loop
  ext4: refactor the block allocation process of ext4_page_mkwrite()
  ext4: restart handle if credits are insufficient during allocating
    blocks
  ext4: enhance tracepoints during the folios writeback
  ext4: correct the reserved credits for extent conversion
  ext4: reserved credits for one extent during the folio writeback
  ext4: replace ext4_writepage_trans_blocks()
  ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
  ext4: limit the maximum folio order

 fs/ext4/ext4.h              |   4 +-
 fs/ext4/extents.c           |   6 +-
 fs/ext4/ialloc.c            |   3 +-
 fs/ext4/inline.c            |   6 +-
 fs/ext4/inode.c             | 349 +++++++++++++++++++++++-------------
 fs/ext4/move_extent.c       |   3 +-
 fs/ext4/xattr.c             |   2 +-
 include/trace/events/ext4.h |  47 ++++-
 8 files changed, 272 insertions(+), 148 deletions(-)

-- 
2.46.1


