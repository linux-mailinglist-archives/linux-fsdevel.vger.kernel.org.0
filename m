Return-Path: <linux-fsdevel+bounces-71235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CACBA32D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 03:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ECAE310AC02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE1264612;
	Sat, 13 Dec 2025 02:22:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E25248F47;
	Sat, 13 Dec 2025 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592563; cv=none; b=UXCOErToTRNYZQ+ETDgoo6ldas+7+lIV+J0Rq1/79yHBp7VLIji6n5+ATssjBGj5o3zoT8XRno+qKULhVJMbRZLowjnQByGbtzgMDSFdxhkz4xNei6W58ClsPuLXFoXXjXFxKlooc+pp5l3zMHgiu6UR53P9Z/1buebTBhouMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592563; c=relaxed/simple;
	bh=DxNFZZWhhk1L7vHCpdhyl0OkwT6M1sIEsFmtqwCzT+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOsafH8s1kCf2bHVL8XXspTU612zp4bOTCTMeCrtLMwtJy0ivO7iksxgReIbAqCNtwq9GCfIMNbemHSkZqo9ozERo12CXQpn91TtfsR8XMvRYKR2CdKerbV6tHAOXLd2rIyNhMFXPSJMWU65M7wfw2CyI+z7/cJpBRiBOjS6XMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dSqpf5d3lzYQtxC;
	Sat, 13 Dec 2025 10:22:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E94AA1A0AD1;
	Sat, 13 Dec 2025 10:22:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3F1HTzTxpFXQ7Bg--.63968S7;
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
Subject: [PATCH -next 3/7] ext4: avoid starting handle when dio writing an unwritten extent
Date: Sat, 13 Dec 2025 10:20:04 +0800
Message-ID: <20251213022008.1766912-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3F1HTzTxpFXQ7Bg--.63968S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDJFWDArWUCF18Gw47XFb_yoW8uFWxp3
	9agFZ5GF4kWFyUWa97u3Z7Xr4rtw45Kw4xZF4Fgry5XryxGr1Iqws0qF15XF48trZ7uF42
	qFW5J34UZ3ZxArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
---
 fs/ext4/file.c  | 4 +---
 fs/ext4/inode.c | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index ffde24ff7347..08a296122fe0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3819,7 +3819,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			 * For atomic writes the entire requested length should
 			 * be mapped.
 			 */
-			if (map.m_flags & EXT4_MAP_MAPPED) {
+			if ((map.m_flags & EXT4_MAP_MAPPED) ||
+			    (!(flags & IOMAP_DAX) &&
+			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
 				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
 				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
 					goto out;
-- 
2.46.1


