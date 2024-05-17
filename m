Return-Path: <linux-fsdevel+bounces-19671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C878C868C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D4283967
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F0F53E08;
	Fri, 17 May 2024 12:51:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4FB3D97A;
	Fri, 17 May 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950262; cv=none; b=e2u8Kc2vn5w3B3cDtQSTYLZnmn0zIuUb5ih3xuUEZTgdh04FUxGYigaYdQP5lIXP6jhCJ3OhSkJfrFzlYd+biPHNxd/iQVMFClDhj9Ka+Yb8lrNxwBm1Y2Pqm4U75N0Tb/oweFCp4rNnzmYdJ+Q11GBKYeoZ2Q6ibSHy9P7C+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950262; c=relaxed/simple;
	bh=3EQCRuvxHsBDbcUTb197QF5lWUu3o/wXiE93fM+rLPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJohWIga3gGOkEXbROIVhgkCtFW1WXwHgXgygWNqT2csMdESnnLhEElWO4D/Pn56J61lknVfARv+8YjUP5yQGBwUEm8y3oPj0eJNmhG1ulq5cHpW2PYPl7tKaAPhr7rfVqfHhRQ95x7RPjI7YOG3UE7tdcQGlGUdKttKx2dIvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vgmz83grjz4f3mJP;
	Fri, 17 May 2024 20:50:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C084C1A017F;
	Fri, 17 May 2024 20:50:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGdUkdmdAmqMw--.14380S4;
	Fri, 17 May 2024 20:50:52 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 00/10] ext4: support adding multi-delalloc blocks
Date: Fri, 17 May 2024 20:39:55 +0800
Message-Id: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGdUkdmdAmqMw--.14380S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UXrWDXr4UZr47ur47twb_yoW5CF1fpF
	WrCF15Jr47tr17Ka97Aws7GF4rW3Z3GFWUG34fXw1UuFWUAFyrXFsrKF1F9FWkXrZagF1Y
	qF12yF18u3Wqk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Changes since v4:
 - In patch 3, switch to check EXT4_ERROR_FS instead of
   ext4_forced_shutdown() to prevent warning on errors=continue mode as
   Jan suggested.
 - In patch 8, rename ext4_da_check_clu_allocated() to
   ext4_clu_alloc_state() and change the return value according to the
   cluster allocation state as Jan suggested.
 - In patch 9, do some appropriate logic changes since
   the ext4_clu_alloc_state() has been changed in patch 8, so I remove
   the reviewed-by tag from Jan, please take a look again.

Changes since v3:
 - Fix two commit message grammatical issues in patch 2 and 4.

Changes since v2:
 - Improve the commit message in patch 2,4,6 as Ritesh and Jan
   suggested, makes the changes more clear.
 - Add patch 3, add a warning if the delalloc counters are still not
   zero on inactive.
 - In patch 6, add a WARN in ext4_es_insert_delayed_extent(), strictly
   requires the end_allocated parameter to be set to false if the
   inserting extent belongs to one cluster.
 - In patch 9, modify the reserve blocks math formula as Jan suggested,
   prevent the count going to be negative.
 - In patch 10, update the stale ext4_da_map_blocks() function comments.

Hello!

This patch series is the part 2 prepartory changes of the buffered IO
iomap conversion, I picked them out from my buffered IO iomap conversion
RFC series v3[1], add a fix for an issue found in current ext4 code, and
also add bigalloc feature support. Please look the following patches for
details.

The first 3 patches fix an incorrect delalloc reserved blocks count
issue and add a warning to make it easy to detect, the second 6 patches
make ext4_insert_delayed_block() call path support inserting
multi-delalloc blocks once a time, and the last patch makes
ext4_da_map_blocks() buffer_head unaware, prepared for iomap.

This patch set has been passed 'kvm-xfstests -g auto' tests, I hope it
could be reviewed and merged first.

[1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

---
v2: https://lore.kernel.org/linux-ext4/20240410034203.2188357-1-yi.zhang@huaweicloud.com/
v3: https://lore.kernel.org/linux-ext4/20240508061220.967970-1-yi.zhang@huaweicloud.com/

Zhang Yi (10):
  ext4: factor out a common helper to query extent map
  ext4: check the extent status again before inserting delalloc block
  ext4: warn if delalloc counters are not zero on inactive
  ext4: trim delalloc extent
  ext4: drop iblock parameter
  ext4: make ext4_es_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_reserve_space() reserve multi-clusters
  ext4: factor out a helper to check the cluster allocation state
  ext4: make ext4_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_map_blocks() buffer_head unaware

 fs/ext4/extents_status.c    |  70 +++++++---
 fs/ext4/extents_status.h    |   5 +-
 fs/ext4/inode.c             | 250 +++++++++++++++++++++++-------------
 fs/ext4/super.c             |   6 +-
 include/trace/events/ext4.h |  26 ++--
 5 files changed, 234 insertions(+), 123 deletions(-)

-- 
2.39.2


