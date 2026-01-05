Return-Path: <linux-fsdevel+bounces-72376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92ECF193D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 02:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A5EB300788B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F5E2E719C;
	Mon,  5 Jan 2026 01:48:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483C288A2;
	Mon,  5 Jan 2026 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767577728; cv=none; b=FcXDAki1SrmZjl/3QQ0zU8WI+7o7cTc8WToaa0hiuVySgXAEfJXk82GE03inkGv+ApX0+8l1mEVdhUxSNY4u0S+WlalZ3vLmy9l/9PNcZyIGiIPZZrgXaPrSCmyHTFbxvXJtkFcuGwdZise4QC++GH0JEJj4r58rmLpryA9DOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767577728; c=relaxed/simple;
	bh=ioarUEDEwqb6UsuKBo6rTUr+twTWCIRG8labBV2NIPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3zE4cde8NoOSabT3vULxsm6BPd9p6oCXTUdos2EMKG2w91TvE5j4bOb97UTewpy+Gx2K0SYOM/qDbmZeKhI7p94HlTAoSxSgAIlfS0czDlFKyis8H3yg4y58kTbyWqDb8tMS3AyGoM4NNl2Vq8Bj/3oJl2luEOtAAlVS5NpQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dkxy82jqKzYQtxJ;
	Mon,  5 Jan 2026 09:47:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7424C40590;
	Mon,  5 Jan 2026 09:48:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgBHp_dpGFtppFisCg--.42376S4;
	Mon, 05 Jan 2026 09:48:40 +0800 (CST)
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
Subject: [PATCH -next v3 0/7] ext4: defer unwritten splitting until I/O completion
Date: Mon,  5 Jan 2026 09:45:15 +0800
Message-ID: <20260105014522.1937690-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHp_dpGFtppFisCg--.42376S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1DXr1fuF48KFy5tw4xWFg_yoWruF4Upr
	WS9w17Jr4kKa47K397Ja1jqr1Y9r1fAr47ur1rG348ZF45CFyYgF42qa1rZa45J395W3WY
	vrWYqw1DC3WUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 - Just revise the wording errors in the commit messages of patches 01
   and 06, no code changes.
Changes sicne v1:
 - In patch 03, add a comment explaining how DAX writes to unwritten
   extents, as Jan suggested.

v2: https://lore.kernel.org/linux-ext4/20251223011802.31238-1-yi.zhang@huaweicloud.com/
v1: https://lore.kernel.org/linux-ext4/20251213022008.1766912-1-yi.zhang@huaweicloud.com/

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
  ext4: simplify the mapping query logic in ext4_iomap_begin()
  ext4: remove EXT4_GET_BLOCKS_IO_CREATE_EXT

 fs/ext4/ext4.h    | 10 ---------
 fs/ext4/extents.c | 46 ++++----------------------------------
 fs/ext4/file.c    | 23 ++++++++-----------
 fs/ext4/inode.c   | 56 ++++++++++++-----------------------------------
 4 files changed, 27 insertions(+), 108 deletions(-)

-- 
2.52.0


