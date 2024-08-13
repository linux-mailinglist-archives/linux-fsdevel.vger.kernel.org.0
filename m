Return-Path: <linux-fsdevel+bounces-25771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC495052F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21FEBB21F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC1199EB1;
	Tue, 13 Aug 2024 12:39:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45A21345;
	Tue, 13 Aug 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552762; cv=none; b=edYsdoTMNuAsgwNJHrRWVruT9XKFFfMAwBcUDnME3wjy6EFZDdfiQI5UCLGVdGRZMJeZbL+NuuFZLET2JvAgG2tvsdA1uwW/rp5+TGcv3m+sQiF868OM3WGrljinf8KjYB3N1wbeLjEj1LnlPU8exW5CYw0UZ/4p3rfLnJjGP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552762; c=relaxed/simple;
	bh=pX4eEmQ9nihbCYgNo9Yn9kct/omhHF8zzhNPMDcVk/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ne+fteXeIY1RSEQjg2rJbwAKWQ8i4kRTyIOX/iPi3xNdxDt87veMvFDJPDm8x1seEEL3/0bZ59DuLQEnsGLNMT5iIRylj8thmB3+NqrZJ8NBRUmXpS2x4kW37Zzo+5BP/+G7ztjopMsa1ZnAtXxyfvNCJGQG3NNAr8icr2VZ3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjrY26lQ8z4f3jHT;
	Tue, 13 Aug 2024 20:39:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9FEAC1A1735;
	Tue, 13 Aug 2024 20:39:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S4;
	Tue, 13 Aug 2024 20:39:14 +0800 (CST)
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
Subject: [PATCH v3 00/12] ext4: simplify the counting and management of delalloc reserved blocks
Date: Tue, 13 Aug 2024 20:34:40 +0800
Message-Id: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy5Jw15Kw4ktF4DJr18Krg_yoW5GFWrpr
	WfC3W3Jr10gw17Wa93Aw1UGw1fWa1xAr4UGrWxKr18uFWrAFyxZFnrKFyrZFyrtrWxJF1Y
	qFyUKw18uas8C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

Changes since v2:
 - In patch 3, update the chang log as Jan suggested.
 - In patch 5 and 6, when moving reserved blocks count updating to
   ext4_es_insert_extent(), chang the condition for determining quota
   claim by passing allocation information instead of counting used
   reserved blocks as Jan suggested.
 - Add patch 9, drop an unused helper ext4_es_store_status().
 - Add patch 10, make extent status type exclusive, add assertion and
   commtents as Jan suggested.

Changes since v1:
 - Just rebase to v6.11-rc1.

This patch series is the part 3 prepartory changes of the buffered IO
iomap conversion, it simplify the counting and updating logic of
delalloc reserved blocks. I picked them out from my buffered IO iomap
conversion RFC series v4[1], and did some minor improvements of commit
messages. This series is based on 6.11-rc3, after it we could save a lot
of code.

Patch 1-3 simplify the delalloc extent management logic by changes to
always set EXT4_GET_BLOCKS_DELALLOC_RESERVE flag when allocating
preallocated blocks, and don't add EXTENT_STATUS_DELAYED flag to an
unwritten extent, which means ext4_es_is_delayed() is equal to
ext4_es_is_delonly().

Patch 4-6 simplify the reserved blocks updating logic by moves the
reserved blocks updating from ext4_{ind|ext}_map_blocks() to
ext4_es_insert_extent().

Patch 7-12 make extent status type exclusive and drop the unused code
(e.g. ext4_es_is_delonly()), update comments and do some cleanup.

[1] https://lore.kernel.org/linux-ext4/20240410142948.2817554-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (12):
  ext4: factor out ext4_map_create_blocks() to allocate new blocks
  ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
  ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
  ext4: let __revise_pending() return newly inserted pendings
  ext4: passing block allocation information to ext4_es_insert_extent()
  ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
  ext4: drop ext4_es_delayed_clu()
  ext4: use ext4_map_query_blocks() in ext4_map_blocks()
  ext4: drop unused ext4_es_store_status()
  ext4: make extent status types exclusive
  ext4: drop ext4_es_is_delonly()
  ext4: drop all delonly descriptions

 fs/ext4/extents.c        |  42 +------
 fs/ext4/extents_status.c | 240 ++++++++++++++-------------------------
 fs/ext4/extents_status.h |  28 ++---
 fs/ext4/indirect.c       |   7 --
 fs/ext4/inode.c          | 201 ++++++++++++++------------------
 5 files changed, 189 insertions(+), 329 deletions(-)

-- 
2.39.2


