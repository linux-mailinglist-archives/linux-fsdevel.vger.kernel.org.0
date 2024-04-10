Return-Path: <linux-fsdevel+bounces-16509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC2289E884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 05:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4351C212B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 03:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16CC148;
	Wed, 10 Apr 2024 03:50:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927F35256;
	Wed, 10 Apr 2024 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721052; cv=none; b=VCOCZ/P4TANTAEZO3EEIYJ/zvch5L/usoRDpV1lmrlGoejm/RH6jKXH6iakd0rU9lIsDwP5x9mQdXXkRwu4KF0Ilz3DyOVCU7L2i2dHmIpmMuPf7yxkNsttstSSLA4Ojwwic5LdaQUYGphTDvEebS+bQ6VulYC2FSWPbnerNy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721052; c=relaxed/simple;
	bh=yeB6z5EAfe7IOQv8OW6VQNX7Eu6xtR4ZEQqtzaQ7UDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n5cCvGgaIvanlw8IfjG6xNs2k4o8E0MW6nGpA+ogwZuWXBEqg6m0yBUtzk7w3iB4DmD96gSZqdaE++vsFPS3niGqOt1we/fRQn1e80CtYqxI9XV8BQAYBs9xXYH6do3CwjT0zf1+XafYIi3QwwKAHmgx6O9vyqA1aZIeVlppc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VDpl221dJz4f3m6g;
	Wed, 10 Apr 2024 11:50:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E476A1A0BE8;
	Wed, 10 Apr 2024 11:50:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGADBZmy5ZTJg--.21880S4;
	Wed, 10 Apr 2024 11:50:45 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 0/9] ext4: support adding multi-delalloc blocks
Date: Wed, 10 Apr 2024 11:41:54 +0800
Message-Id: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGADBZmy5ZTJg--.21880S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry7tF13Xw1DJw4rGw47XFb_yoW8WrWDpF
	WfKF4rXr4UWr1agan3Aa1UGr4Fqw4fCrW7G343tw1UZrWUZFyfZFsrKF1F9ayrJrZ3uF1Y
	qF129rykua1qka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello!

This patch series is the part 2 prepartory changes of the buffered IO
iomap conversion, I picked them out from my buffered IO iomap conversion
RFC series v3[1], add a fix for an issue found in current ext4 code,and
also add bigalloc feature support. Please look the following patches for
details.

The first 2 patches fix an incorrect delalloc reserved blocks count
issue, the second 6 patches make ext4_insert_delayed_block() call path
support inserting multi-delalloc blocks once a time, and the last patch
makes ext4_da_map_blocks() buffer_head unaware, prepared for iomap.

This patch set has been passed 'kvm-xfstests -g auto' tests, I hope it
could be reviewed and merged first.

[1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (9):
  ext4: factor out a common helper to query extent map
  ext4: check the extent status again before inserting delalloc block
  ext4: trim delalloc extent
  ext4: drop iblock parameter
  ext4: make ext4_es_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_reserve_space() reserve multi-clusters
  ext4: factor out check for whether a cluster is allocated
  ext4: make ext4_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_map_blocks() buffer_head unaware

 fs/ext4/extents_status.c    |  63 ++++++----
 fs/ext4/extents_status.h    |   5 +-
 fs/ext4/inode.c             | 240 +++++++++++++++++++++++-------------
 include/trace/events/ext4.h |  26 ++--
 4 files changed, 213 insertions(+), 121 deletions(-)

-- 
2.39.2


