Return-Path: <linux-fsdevel+bounces-19000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9528BF625
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDF31F2373D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2447A5C;
	Wed,  8 May 2024 06:22:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89542BB0F;
	Wed,  8 May 2024 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149369; cv=none; b=UX6B3g340e1fdUxIlIioXXYDJ89iypPn/Qp0BNerpJcx6otAH1s4eyu319xlYD3pVzUHP5C0NBANEpQl8lTn9s/byShpRS1zPTa/c2GlyGVMWGhR4o1KQSULjbp9tQi3A+/asfNXHTs7VxLuhCYAF9iVBahObwBxybZ4qNKW8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149369; c=relaxed/simple;
	bh=6DD/MUNNnaU3ZNGpvaA67ateEJE/cQmliuF+P9E/HAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MbXigIcQmip9JSmHz2lcHUhQumXW5uHzOXmHqQbyzjzOkPbJFkdUYU9rcSYWMrXFknU/n0k916NaXf1ec4rWh/vrdsUZaFNe8AKqfhYWGEpqlxpoRQs4Xh14fbFs1Nk086gZFV5KWe4ht/YEqTuWiOlvfV4jfSg4qiTLJmGRjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZ4nK6BRQz4f3l74;
	Wed,  8 May 2024 14:22:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 27C641A0DBA;
	Wed,  8 May 2024 14:22:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6REbGjtm9_1NMA--.61952S4;
	Wed, 08 May 2024 14:22:36 +0800 (CST)
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
Subject: [PATCH v3 00/10] ext4: support adding multi-delalloc blocks
Date: Wed,  8 May 2024 14:12:10 +0800
Message-Id: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6REbGjtm9_1NMA--.61952S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4xXFWrtr15CF4xWw13twb_yoW8Kw4kpF
	WSk3W5Jr4UGr17Ga93Aw47Gr4rX3Z3CFWUG34fXw1UuFWUAFyfXFsrKF1F9FW8XrZagF15
	ZF17tr18u3Wqka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

Zhang Yi (10):
  ext4: factor out a common helper to query extent map
  ext4: check the extent status again before inserting delalloc block
  ext4: warn if delalloc counters are not zero on inactive
  ext4: trim delalloc extent
  ext4: drop iblock parameter
  ext4: make ext4_es_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_reserve_space() reserve multi-clusters
  ext4: factor out check for whether a cluster is allocated
  ext4: make ext4_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_map_blocks() buffer_head unaware

 fs/ext4/extents_status.c    |  70 +++++++---
 fs/ext4/extents_status.h    |   5 +-
 fs/ext4/inode.c             | 248 +++++++++++++++++++++++-------------
 fs/ext4/super.c             |   6 +-
 include/trace/events/ext4.h |  26 ++--
 5 files changed, 231 insertions(+), 124 deletions(-)

-- 
2.39.2


