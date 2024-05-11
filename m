Return-Path: <linux-fsdevel+bounces-19318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E38C30F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 13:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D21F217F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FA063417;
	Sat, 11 May 2024 11:37:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69626286;
	Sat, 11 May 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715427433; cv=none; b=p+r2nNc0cK6DQ82R+V0if+ZiKiyKuZ/gCFH5Mi52Jis2Hlp1FI2cY+TYhr5u8hJDtBxsuY4KZMjCzjKDvIvQoEvAuRt+rv1yIqkS1/ip2JWVxGSsR6rqG6wVlNr1WxvxIoX0KoqAV9W/soc0GBf/XgcFNAVEdnEfHuyQf6oMJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715427433; c=relaxed/simple;
	bh=PjouId2AzqErjWZkW13lZDsDZdGjcpMDFIcPFajXrX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aU1Px0dONuSC+PFZtrr9ojGOmANjXEh+ScEexw5CWjCpzXtqxZcvIFTuVz5RYyoyM8Rab/XAKUnqArw5sLKuF9QHJgCiTH3RQu01Q4cVMFIL2NeIHzz4rwHGg4KxKY5Pfp2z9bkJf13Ny85BsFlgdV0cWdSmnzsR7ZGBKoxF49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vc3ck24rkz4f3lVh;
	Sat, 11 May 2024 19:36:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 46E4B1A0C48;
	Sat, 11 May 2024 19:37:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxA+WD9mG0B4MQ--.22689S4;
	Sat, 11 May 2024 19:36:59 +0800 (CST)
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
Subject: [PATCH v4 00/10] ext4: support adding multi-delalloc blocks
Date: Sat, 11 May 2024 19:26:09 +0800
Message-Id: <20240511112619.3656450-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxA+WD9mG0B4MQ--.22689S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1xtw15ArW8KryfAF1fJFb_yoW5GF48pF
	WSka15Jr4UGr17Wa93Aw47GF1rXa1fGFWUG34fJw1UuFWUZFyfXFsrKF1Y9FWkXrZ3W3W5
	XF17tr18u3Wqka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1
	a9aPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

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


