Return-Path: <linux-fsdevel+bounces-21617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF8B9067F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22F0281F6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B713D889;
	Thu, 13 Jun 2024 09:01:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3B84D03;
	Thu, 13 Jun 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269272; cv=none; b=KBiVh27tb5VHsiXBI9TYI8kbqIdMTqsKfIFffzSM/AkahjVWMV7WM7+NbMJkCM9xE5XwkF0GPpwnTzh42yl8kDPlaLDJc7j9W5CHN/hKbDM80D5yezpEgQplutScKyoQDdOBYWue/APqwaNYt6a9DDjB+3teTfudEk4QmdKSj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269272; c=relaxed/simple;
	bh=smK+jc7dSgvkAp6lPonVm1WD+q8MJwaXm8XGmu7+Ecg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KvpbdzLteBuMI9HSNMYmNZT13NjesQHzqzvQy8/vXDHFJS5YPRw4kNhzDMcnFjCoJY/wGUdgeYseK3O5TRmvfBOXalgwF4WAWIbKniqY0eWmITVou4PGA9wsh8HcTwMnMYlLV0HiNNRXml53/n7NA0yyUXPvhp4jxp+aqf5FAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W0GbX3Vm2z4f3jMS;
	Thu, 13 Jun 2024 17:00:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8C8E61A0181;
	Thu, 13 Jun 2024 17:01:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFOtWpmHK1uPQ--.16895S4;
	Thu, 13 Jun 2024 17:01:04 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH -next v5 0/8] iomap/xfs: fix stale data exposure when truncating realtime inodes
Date: Thu, 13 Jun 2024 17:00:25 +0800
Message-Id: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFOtWpmHK1uPQ--.16895S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1xWrW5AFW7Cr1kXr47urg_yoWrXw4kpF
	ZxKay5Cr4kJ34furyxZa4DXw45u3Z7CFWjkFy7GrsxC3W5Xr1Ivr1vqF4F93yjkrs7uFs0
	vrsYyFWxur1qyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UZa9-UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v4:
 - Drop the first patch in v4 "iomap: zeroing needs to be pagecache
   aware" since this series is not strongly depends on it, that patch
   still needs furtuer analyse and also should add to handle the case of
   a pending COW extent that extends over a data fork hole. This is a
   big job, so let's fix the exposure stale data issue and brings back
   the changes in iomap_write_end() first, don't block the ext4 buffered
   iomap conversion.
 - In patch 1, drop the 'ifndef rem_u64'.
 - In patch 4, factor out a helper xfs_setattr_truncate_data() to handle
   the zero out, update i_size, write back and drop pagecache on
   truncate.
 - In patch 5, switch to use xfs_inode_alloc_unitsize() in
   xfs_itruncate_extents_flags().
 - In patch 6, changes to reserve blocks for rtextsize > 1 realtime
   inodes on truncate down.
 - In patch 7, drop the unwritten convert threshold, always convert tail
   blocks to unwritten on truncate down realtime inodes.
 - Add patch 8 to bring back 'commit 943bc0882ceb ("iomap: don't
   increase i_size if it's not a write operation")'.

Changes since v3:
 - Factor out a new helper to get the remainder in math64.h as Darrick
   suggested.
 - Adjust the truncating order to prevent too much redundant blocking
   writes as Dave suggested.
 - Improve to convert the tail extent to unwritten when truncating down
   an inode with large rtextsize as Darrick and Dave suggested.

Since 'commit 943bc0882ceb ("iomap: don't increase i_size if it's not a
write operation")' merged, Chandan reported a stale data exposure issue
when running fstests generic/561 on xfs with realtime device [1]. This
issue has been fix on 6.10 by revert this commit through commit
'0841ea4a3b41 ("iomap: keep on increasing i_size in iomap_write_end()")',
but the real problem is xfs_setattr_size() doesn't zero out enough range
when truncate down a realtime inode. So this series fix this problem by
zeroing out allocation unitsize and convert the tail blocks to unwritten
when truncate down realtime inodes, finally we could bring commit
943bc0882ceb back.

Patch 1-3 modify iomap_truncate_page() and dax_truncate_page() to pass
filesystem identified blocksize, and drop the assumption of
i_blocksize() as Dave suggested.

Patch 4-5 refactor and adjust the truncating down processing order to
first zero out the tail aligned blocks, then write back and update
i_size, finally drop cache beyond aligned EOF. Fix the data exposure
issue by zeroing out the entire EOF extent.

Patch 6-7 improves truncate down performace on realtime inodes with
big rtextsize(>1 fsblock) by converting the tail unaligned extent to
unwritten.

Patch 8 reverts commit 0841ea4a3b41 and brings commit 943bc0882ceb back,
don't increase i_size on IOMAP_ZERO and IOMAP_UNSHARE.

I've tested this series on fstests (1) with reflink=0, (2) with
reflink=1, (3) with 28K RT device and (4) with dax, no new failures
detected, and it passed generic/561 on RT device over 1000+ rounds,
please let me know if it needs other tests.

[1] https://lore.kernel.org/linux-xfs/87ttj8ircu.fsf@debian-BULLSEYE-live-builder-AMD64/

Thanks,
Yi.

Zhang Yi (8):
  math64: add rem_u64() to just return the remainder
  iomap: pass blocksize to iomap_truncate_page()
  fsdax: pass blocksize to dax_truncate_page()
  xfs: refactor the truncating order
  xfs: correct the truncate blocksize of realtime inode
  xfs: reserve blocks for truncating large realtime inode
  xfs: speed up truncating down a big realtime inode
  iomap: don't increase i_size in iomap_write_end()

 fs/dax.c               |   8 +-
 fs/ext2/inode.c        |   4 +-
 fs/iomap/buffered-io.c |  61 +++++++-------
 fs/xfs/xfs_inode.c     |   9 ++-
 fs/xfs/xfs_iomap.c     |   5 +-
 fs/xfs/xfs_iomap.h     |   3 +-
 fs/xfs/xfs_iops.c      | 180 ++++++++++++++++++++++++++++-------------
 include/linux/dax.h    |   4 +-
 include/linux/iomap.h  |   4 +-
 include/linux/math64.h |  22 +++++
 10 files changed, 204 insertions(+), 96 deletions(-)

-- 
2.39.2


