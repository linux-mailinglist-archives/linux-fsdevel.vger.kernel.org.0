Return-Path: <linux-fsdevel+bounces-71233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA0CBA31E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 03:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E15D130E97C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D2258EC3;
	Sat, 13 Dec 2025 02:22:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E89248F57;
	Sat, 13 Dec 2025 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592562; cv=none; b=KeVSfhn0CFG9gJCm2SZMwJRQRNQBO9GABkcX6NxxhzsMZmBd7uy86Vx2kfX+RrRxioWuNAys1YOhZEdMnbhgDvTBRVrG+reDh/l2RjUjx533oQyftNtGfE+1p4XSgTjtLJu6DqbJH18xXGZxc3+h7nb9/Jq1CIqtGj0u6FczTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592562; c=relaxed/simple;
	bh=9Fh+wnXa7RWRzm6Xw6UefjCoM266FzSd8Ylt+FWL3Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mArBXbfwY1IS7XnTUiQ3NUDQtGXBl8XjPYxXlvl+0Kfgt5a5MePt8dIVEaY+uaPs6ZE/1bobtzv1TBSW2ZedHn2yrCJUr8FoSgXdUE/Si9HaOjATvX2Sg+YfZ/Il2jKHgB878ItJpXZuy07t/YssLe69S7LMIMvCZKsyv2rHpnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dSqpf54QKzYQtwN;
	Sat, 13 Dec 2025 10:22:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B62C71A084E;
	Sat, 13 Dec 2025 10:22:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3F1HTzTxpFXQ7Bg--.63968S4;
	Sat, 13 Dec 2025 10:22:28 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next 0/7] ext4: defer unwritten splitting until I/O completion
Date: Sat, 13 Dec 2025 10:20:01 +0800
Message-ID: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3F1HTzTxpFXQ7Bg--.63968S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4UKrykWFy7CryxKF1kAFb_yoWrWw4fpr
	WS9w17Jr4kta4jk3s7Za1jqr1F9w1fAr47ur1rG348AF15CF12gr42q3WrXa45t395W3WY
	vr4Yqw1UC3WUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hello!

This series proposes deferring the splitting of unwritten extents from
the point of I/O submission until I/O completion when partially writing
to a preallocated file.

This change primarily needs to address whether it will increase the
likelihood of extent conversion failure due to the inability to split
extents in scenarios with insufficient space, which could result in I/O
write failures and data loss. After analysis, it has been confirmed that
two existing mechanisms ensure I/O operations do not fail.

The first is the EXT4_GET_BLOCKS_METADATA_NOFAIL flag, which is a best
effort, it permits the use of 2% of the reserved space or 4,096 blocks
in the file system when splitting extents. This flag covers most
scenarios where extent splitting might fail. The second is the
EXT4_EXT_MAY_ZEROOUT flag, which is also set during extent splitting. If
the reserved space is insufficient and splitting fails, it does not
retry the allocation. Instead, it directly zeros out the extra part of
the extent, thereby avoiding splitting and directly converting the
entire extent to the written type.

These two mechanisms currently have no difference before I/O submission
or after I/O completion. Therefore, Although deferring extent splitting
will add pressure on reserved space after I/O completion, but it won't
increase the risk of I/O failure and data loss. On the contrary, if some
I/Os can be merged when I/O completion during writeback, it can also
reduce unnecessary splitting operations, thereby alleviating the
pressure on reserved space. 

In addition, deferring extent splitting until I/O completion can also
simplify the I/O submission process and avoid initiating unnecessary
journal handles when writing unwritten extents.

Patch 01-03: defer splitting extent until I/O completion.
Patch 04-07: do some cleanup of the DIO path and remove
             EXT4_GET_BLOCKS_IO_CREATE_EXT.

Tests:

 - Run xfstests with the -g enospc option approximately 50 times. Before
   applying this series, the reserved blocks were used over 6000/7000
   times on a 1 GB filesystem with a 4 KB / 1 KB block size. After
   applying this series, the counts remain nearly the same. In both
   cases, there were no splitting failures.
 - Run xfstests with the -g enospc option about one day, no regressions
   occurred.
 - Intentionally create a scenario in which reserved blocks are
   exhausted. Before applying the patch, zero out the extent before I/O
   submission; after applying the patch, zero out the extent after I/O
   completion. There are no other differences.
 - xfstests-bld shows no regression.

Performance:

This can improve the write performance of concurrent DIO for multiple
files. The fio tests below show a ~25% performance improvement when
wirting to unwritten files on my VM with a 100G memory backed disk.

  [unwritten]
  direct=1
  ioengine=psync
  numjobs=16
  rw=write     # write/randwrite
  bs=4K
  iodepth=1
  directory=/mnt
  size=5G
  runtime=30s
  overwrite=0
  norandommap=1
  fallocate=native
  ramp_time=5s
  group_reporting=1

 [w/o]
  w:  IOPS=62.5k, BW=244MiB/s
  rw: IOPS=56.7k, BW=221MiB/s

 [w]
  w:  IOPS=79.6k, BW=311MiB/s
  rw: IOPS=70.2k, BW=274MiB/s

TODO:

Next, we can investigate whether, during the buffer I/O write-back
process, writing an unwritten extent can also avoid initiating a journal
handle.

Thank,
Yi.

Zhang Yi (7):
  ext4: use reserved metadata blocks when splitting extent on endio
  ext4: don't split extent before submitting I/O
  ext4: avoid starting handle when dio writing an unwritten extent
  ext4: remove useless ext4_iomap_overwrite_ops
  ext4: remove unused unwritten parameter in ext4_dio_write_iter()
  ext4: simply the mapping query logic in ext4_iomap_begin()
  ext4: remove EXT4_GET_BLOCKS_IO_CREATE_EXT

 fs/ext4/ext4.h    | 10 ---------
 fs/ext4/extents.c | 46 ++++-----------------------------------
 fs/ext4/file.c    | 23 ++++++++------------
 fs/ext4/inode.c   | 55 ++++++++++-------------------------------------
 4 files changed, 24 insertions(+), 110 deletions(-)

-- 
2.46.1


