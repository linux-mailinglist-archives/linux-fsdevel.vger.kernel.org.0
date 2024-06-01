Return-Path: <linux-fsdevel+bounces-20682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E38D6DB8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1E21F213B5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E54E541;
	Sat,  1 Jun 2024 03:42:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E197EF;
	Sat,  1 Jun 2024 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213324; cv=none; b=aXeSIm/HMXv8Z+f1ujjoOftH4+Hqiuun7DjwvElm+4jLOJ+RfDOFcQZzDURXpeD8O0ZaK+FIuWl4EFE36NC7eSAFfi7AaUCDwqbkiASqiNXY2VKtlx7bB0t0Ws6C/s1uzKwNeZjxOwqlnmvVH97kLoPwnvg/4safT2SjcrnV/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213324; c=relaxed/simple;
	bh=iC5J5NaNVHLn9fKACjdIwUU56j5iHHVCyrp73CAFfc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fvgr/QiG+Pii9Q7LhdLuKmReRnqUdUhxLTefHEZSE2IsdO+i3WcNfS05F1QznLVEnNkCHWz6/N28XERLmjT5zUnPTWLXXFbWtvBcn/4PInjIueP0KHLoj4PzA1fhpPg5dCEM0nErQFIygNqSYS4DN/Fo7PLASt/8GI1RYDBKAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vrm4k6HtSz4f3jXm;
	Sat,  1 Jun 2024 11:41:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 52DC41A016E;
	Sat,  1 Jun 2024 11:41:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFumFpmHN_4OA--.4543S4;
	Sat, 01 Jun 2024 11:41:50 +0800 (CST)
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
Subject: [PATCH 00/10] ext4: simplify the counting and management of delalloc reserved blocks
Date: Sat,  1 Jun 2024 11:41:39 +0800
Message-Id: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFumFpmHN_4OA--.4543S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xXrW3Gr1kGw4rWw15Arb_yoW8uw1DpF
	WfC3W3Gr18Ww17W393Aw1UJw1rW3WfCr4UWrWfKw18ZFWrAr1xZFn2gF1ruFWrKrWxAF1Y
	qF1akw18Cas8CrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hello!

This patch series is the part 3 prepartory changes of the buffered IO
iomap conversion, it simplify the counting and updating logic of delalloc
reserved blocks. I picked them out from my buffered IO iomap conversion
RFC series v4[1], and did some minor change log messages improvement.
It's based on the part 2 prepartory series [2] (not merged yet) +
6.10-rc1.

Patch 1-3 simplify the delalloc extent management logic by changes to
always set EXT4_GET_BLOCKS_DELALLOC_RESERVE flag when allocating
preallocated blocks, and don't add EXTENT_STATUS_DELAYED flag to an
unwritten extent, which means ext4_es_is_delayed() is equal to
ext4_es_is_delonly().

Patch 4-6 simplify the reserved blocks updating logic by moves the
reserved blocks updating from ext4_{ind|ext}_map_blocks() to
ext4_es_insert_extent().

Patch 7-10 drop the unused code (e.g. ext4_es_is_delonly())and update
comments.

This series has passed through kvm-xfstests in auto mode many times,
please take a look at it.

[1] https://lore.kernel.org/linux-ext4/20240410142948.2817554-1-yi.zhang@huaweicloud.com/
[2] https://lore.kernel.org/linux-ext4/20240517124005.347221-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (10):
  ext4: factor out ext4_map_create_blocks() to allocate new blocks
  ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
  ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
  ext4: let __revise_pending() return newly inserted pendings
  ext4: count removed reserved blocks for delalloc only extent entry
  ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
  ext4: drop ext4_es_delayed_clu()
  ext4: use ext4_map_query_blocks() in ext4_map_blocks()
  ext4: drop ext4_es_is_delonly()
  ext4: drop all delonly descriptions

 fs/ext4/extents.c        |  37 ------
 fs/ext4/extents_status.c | 271 ++++++++++++++++-----------------------
 fs/ext4/extents_status.h |   7 -
 fs/ext4/indirect.c       |   7 -
 fs/ext4/inode.c          | 197 +++++++++++++---------------
 5 files changed, 195 insertions(+), 324 deletions(-)

-- 
2.31.1


