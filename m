Return-Path: <linux-fsdevel+bounces-71926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3069ECD7A0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 003B530028A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7C22B594;
	Tue, 23 Dec 2025 01:20:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198ED1B86C7;
	Tue, 23 Dec 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452847; cv=none; b=d69z/4sOj+Kh+R1B3vNlbswEOugtgXJlJ0izyDFgHu3SUo9iueHhKwWIKMgRV2gmeA7Xjo7qfmwAbGK4uk57CvwDO83IsgnydSRqZbM2dMhB2+REtgRPHdWZHJmmqrbTCMh04zKF0EQaZZqQZhfqxt3e/ZdQClgb1H7XDl2f7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452847; c=relaxed/simple;
	bh=nlbgmvQwi30Dd+QIPMtQgBkEcmK6juxL6P1YXjn5WrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKrixqMU0P4EEOW7T/bTy/s+JB3afrOjWd3MRmCQMjW1h7uHbx+M7hqk7LML87hp4g7FNQUURRzcBa+b+H7ywwOr//KfQ09wZTXk40TgrIJ5UnZlOb5Bm1S5ll3VDgYF7E6i/1WN+wMsrQ9/3iu90PYgGi12Jh+eoUA5y5MIMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZxyJ1BVvzYQtgc;
	Tue, 23 Dec 2025 09:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 55C1440573;
	Tue, 23 Dec 2025 09:20:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_dY7klpHOeZBA--.61342S7;
	Tue, 23 Dec 2025 09:20:44 +0800 (CST)
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
Subject: [PATCH -next v2 3/7] ext4: avoid starting handle when dio writing an unwritten extent
Date: Tue, 23 Dec 2025 09:17:58 +0800
Message-ID: <20251223011802.31238-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXd_dY7klpHOeZBA--.61342S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDJFWDArWUCF18Gw47XFb_yoW5Jr1Upa
	93Ka4kGF4kWFyUua93u3WkXr4rKw4rKw47ZF4Fgry5XryUGr1Iqw4YqF1YvF48trZ7WF42
	qFWSy34ru3Z8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since we have deferred the split of the unwritten extent until after I/O
completion, it is not necessary to initiate the journal handle when
submitting the I/O.

This can improve the write performance of concurrent DIO for multiple
files. The fio tests below show a ~25% performance improvement when
wirting to unwritten files on my VM with a mem disk.

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

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c  | 4 +---
 fs/ext4/inode.c | 9 +++++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7a8b30932189..9f571acc7782 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -418,9 +418,7 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
  *   updating inode i_disksize and/or orphan handling with exclusive lock.
  *
  * - shared locking will only be true mostly with overwrites, including
- *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
- *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
- *   also release exclusive i_rwsem lock.
+ *   initialized blocks and unwritten blocks.
  *
  * - Otherwise we will switch to exclusive i_rwsem lock.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ffde24ff7347..ff3ad1a2df45 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3817,9 +3817,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			ret = ext4_map_blocks(NULL, inode, &map, 0);
 			/*
 			 * For atomic writes the entire requested length should
-			 * be mapped.
+			 * be mapped. For DAX we convert extents to initialized
+			 * ones before copying the data, otherwise we do it
+			 * after I/O so there's no need to call into
+			 * ext4_iomap_alloc().
 			 */
-			if (map.m_flags & EXT4_MAP_MAPPED) {
+			if ((map.m_flags & EXT4_MAP_MAPPED) ||
+			    (!(flags & IOMAP_DAX) &&
+			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
 				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
 				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
 					goto out;
-- 
2.52.0


