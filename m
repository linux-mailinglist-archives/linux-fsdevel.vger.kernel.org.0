Return-Path: <linux-fsdevel+bounces-37453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6659F2803
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 02:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E991162324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 01:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401BB1C07C0;
	Mon, 16 Dec 2024 01:42:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E057157469;
	Mon, 16 Dec 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313365; cv=none; b=PFFzs8Dxffb1kjcg5TQl+bNmQLSnqi2m/8n4Uq2sas52mLv4uNP4LIgfI+X3bHi+VGFl2uw4XAV0cKG8bE2AyS/Aql/7GBbHhq2/2b+ElJUiVUrk8FR7dsoZ2gK1+xVTCRJfslJTTVyHoBOmMyz1YcRPtDbjXPwr3eZCZElrJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313365; c=relaxed/simple;
	bh=mIBk19AdS2D+SOvJqNYJC67SIx3vIcw/biv4HJIz8Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYtHvh8pn73zZLdSX8hVjHf4HhTa+9CxqgBZDKT0FJo/XOMavptmQMYmMdeAzFohhs/NiQL+IX0B6rm1GdP41zfZrYR7EO2O8cznWVMShHa1EnNa8EgDwhmqDKKh15FjkdljmmTK41Df7ngTrgkMbGpkUYwwFT6PI1BFk9JdtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YBN3T6RnQz4f3jsr;
	Mon, 16 Dec 2024 09:42:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 508671A0568;
	Mon, 16 Dec 2024 09:42:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4d5hV9nYi3kEg--.4387S4;
	Mon, 16 Dec 2024 09:42:32 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 00/10] ext4: clean up and refactor fallocate
Date: Mon, 16 Dec 2024 09:39:05 +0800
Message-ID: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4d5hV9nYi3kEg--.4387S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4Duw48Zr43GrWxtw15XFb_yoW5urWrpF
	W3WF45Xr1UWwnrCws7Wa1xXF1rK3WrJFW7JryIgw1xur4kuFyIvFsrK3W09FW7JrWrGF12
	vF40yF1ku3WUAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Changes since v3:
 - In patch 1, rename ext4_truncate_folios_range() and move journalled
   mode specified handles and truncate_pagecache_range() into this
   helper.
 - In patch 3, switch to use ext4_truncate_page_cache_block_range().
 - In patch 4, use IS_ALIGNED macro to check offset alignments and
   introduce EXT4_B_TO_LBLK to do the lblk conversion.
 - In patch 5, keep the first ext4_alloc_file_blocks() call before
   truncating pagecache.
 - In patch 9, rename 'out' label to 'out_inode_lock'.
Changes since v2:
 - Add Patch 1 to address a newly discovered data loss issue that occurs
   when using mmap to write after zeroing out a partial page on a
   filesystem with the block size smaller than the page size.
 - Do not write all data before punching hole, zeroing out and
   collapsing range as Jan suggested, also drop current data writeback
   in ext4_punch_hole().
 - Since we don't write back all data in these 4 operations, we only
   writeback data during inserting range,so do not factor out new
   helpers in the last two patches, just move common components of
   sub-operations into ext4_fallocate().
 - Only keep Jan's review tag on patch 2 and 8, other patches contain
   many code adaptations, so please review them again.
Changes since v1:
 - Fix an using uninitialized variable problem in the error out path in
   ext4_do_fallocate() in patch 08.

v3: https://lore.kernel.org/linux-ext4/20241022111059.2566137-1-yi.zhang@huaweicloud.com/
    https://lore.kernel.org/linux-ext4/20241010133333.146793-1-yi.zhang@huawei.com/
v2: https://lore.kernel.org/linux-ext4/20240904062925.716856-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Original Info:

Current ext4 fallocate code is mess with mode checking, locking, input
parameter checking, position calculation, and having some stale code.
Almost all five sub-operation share similar preparation steps, so it
deserves a cleanup now.

This series tries to improve the code by refactoring all operations
related to fallocate. It unifies variable naming, reduces unnecessary
position calculations, and factors out common preparation components.

The first patch addresses a potential data loss issue that occurs when
using mmap to write after zeroing out partial blocks of a page on a
filesystem where the block size is smaller than the page size.
Subsequent patches focus on cleanup and refactoring, please see them for
details. After this series, we will significantly reduce redundant code
and enhance clarity compared to the previous version.


Zhang Yi (10):
  ext4: remove writable userspace mappings before truncating page cache
  ext4: don't explicit update times in ext4_fallocate()
  ext4: don't write back data before punch hole in nojournal mode
  ext4: refactor ext4_punch_hole()
  ext4: refactor ext4_zero_range()
  ext4: refactor ext4_collapse_range()
  ext4: refactor ext4_insert_range()
  ext4: factor out ext4_do_fallocate()
  ext4: move out inode_lock into ext4_fallocate()
  ext4: move out common parts into ext4_fallocate()

 fs/ext4/ext4.h    |   4 +
 fs/ext4/extents.c | 527 +++++++++++++++++-----------------------------
 fs/ext4/inode.c   | 204 ++++++++++--------
 3 files changed, 312 insertions(+), 423 deletions(-)

-- 
2.46.1


