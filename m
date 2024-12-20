Return-Path: <linux-fsdevel+bounces-37889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E559A9F893A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 02:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AD816E9A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 01:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B131DFF8;
	Fri, 20 Dec 2024 01:20:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EC134AB;
	Fri, 20 Dec 2024 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734657615; cv=none; b=AFcaVEzT40dhdIq+7ghS3tATX+noEfXTSzQwUFFFE4e+wRpjJOHif0JSMZrx16oqwaBgra2hJlZuiEfwCgH9TA9AQRXWuwQnLXPqYjA8n+0GB6a2ieOQjL1gqA4lwAeaIqlVYHAMbLhibix7nG0XNqtHpctvgvC8Y4qWBGHRLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734657615; c=relaxed/simple;
	bh=h5NQM28jRDHud7VIG1UY11jBG6FFv5sCJAg7ojhkqkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peu3tnBZAKzXLJ4pAWm32mp22A815hiqIfpCvlh3U0T0yN1wgGCOi2VJR1wRmJP4VXDX5YoZkvGOy6F86KtBCxTIRxRJ2rWZqnQoJ0Wl5u5vwyu1yDNqSkr3IRCc+X5rQk7Qdet/FKPOPMdjb9MgZhsyx8UwqgHNTtkiZR5TOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDqMl69sNz4f3kvP;
	Fri, 20 Dec 2024 09:19:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 74D771A018D;
	Fri, 20 Dec 2024 09:20:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoI6xmRnETtfFA--.47090S4;
	Fri, 20 Dec 2024 09:20:08 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v5 00/10] ext4: clean up and refactor fallocate
Date: Fri, 20 Dec 2024 09:16:27 +0800
Message-ID: <20241220011637.1157197-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoI6xmRnETtfFA--.47090S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4Duw48Zr43GrWxtw15XFb_yoW5KFyrpF
	W3WF45Xr47WwnrCws7ua1xXF1rK3WrJFW7JryIgw1xur4kuFy2vFsFga109FZrArWrGFy2
	vF4jyF1ku3WUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v4:
 - In patch 1, call ext4_truncate_folio() only if truncating range is
   PAGE_SIZE unaligned, and rename the variable start_boundary to
   page_boundary.
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

v4: https://lore.kernel.org/linux-ext4/20241216013915.3392419-1-yi.zhang@huaweicloud.com/
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
 fs/ext4/inode.c   | 205 ++++++++++--------
 3 files changed, 313 insertions(+), 423 deletions(-)

-- 
2.46.1


