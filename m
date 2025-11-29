Return-Path: <linux-fsdevel+bounces-70225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A84C93C7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 11:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A143AC281
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5402BE7D9;
	Sat, 29 Nov 2025 10:35:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE782288C13;
	Sat, 29 Nov 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412542; cv=none; b=GuM5QWaFtft7mPRO3Pe/iW7oY9/Tmfmggfwrdv+4V3v8T8Xn5a3UzcKtkebP/NBlhTFsYQAoQMT+vQ/u8eiX4DzvjlElqItRxL5woXEATh1LxHNlYsxgyruvI0togJ1BKEZNdsDndruSs75YZH7nAoqVIgrG7x/MmLQNzK1NKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412542; c=relaxed/simple;
	bh=iK3eScbK46pW7YktF8ZagjcQSK6j59+q/Iw1r0TvfG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CsyEOBgJu1gi1nezcepJTYG/4YlopY34ncwPgn/rZvj2uiT+VeDHg6v7nugseXq34BvgvcgHSfmn1wpaNp3cxW+92Hp23KUK8v/wVnyjPBln0z047s0K782Lyz1eoveTAHkWRJs+OhVt4NHwf/PfCK2dx9Aa8FeVZ0Acu2ry67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJRPM0NfszKHMNY;
	Sat, 29 Nov 2025 18:34:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3A36F1A14F4;
	Sat, 29 Nov 2025 18:35:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXtfzCpp_56qCQ--.62661S4;
	Sat, 29 Nov 2025 18:35:28 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 00/14] ext4: replace ext4_es_insert_extent() when caching on-disk extents
Date: Sat, 29 Nov 2025 18:32:32 +0800
Message-ID: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXtfzCpp_56qCQ--.62661S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXry8ur15ZrWDGr47Zw4rGrg_yoWrJr1xpF
	Wakr45Jr48X34xK3yfJw1UXr13G3WfGr47uryfKw1rZFy5AFy2gr4kKa1YvFyfXrW8W3W5
	ZF4Fyrs8Ga45C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v2:
 - Rebase the codes on ext4.git dev-91ef18b567da.
 - Move the first cleanup patch in v2 to patch 08 to facilitate easier
   backporting.
 - In patch 01, correct the mismatch comments for
   EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_DATA_PARTIAL_VALID1.
 - Modify patch 06 and add 07, cleanup the commit message to avoid
   confusion, and don't always drop extent cache before splitting
   extent, instead, do this only after PARTIAL_VALID1 zeroed out or
   split extent fails.
 - In patch 08, mark zero_ex to initialized.
 - In patch 09, correct the word 'tag' to 'lable' in the commit message.
 - In patch 11, add return value check of __es_remove_extent() in
   ext4_es_cache_extent().
 - Collecting RVB tags.

   Thanks for the comments and suggestions from Jan, Ojaswin and Baokun!
   Next, it is necessary to focus on refactoring and cleaning up the
   code related to ext4_split_extent(). Ojaswin is going to take on this
   work since he has already been exploring it on his local branch.

Changes since v1:
 - Rebase the codes based on the latest linux-next 20251120.
 - Add patches 01-05, fix two stale data problems caused by
   EXT4_EXT_MAY_ZEROOUT when splitting extent.
 - Add patches 06-07, fix two stale extent status entries problems also
   caused by splitting extent.
 - Modify patches 08-10, extend __es_remove_extent() and
   ext4_es_cache_extent() to allow them to overwrite existing extents of
   the same status when caching on-disk extents, while also checking
   extents of different stauts and raising alarms to prevent misuse.
 - Add patch 13 to clear the usage of ext4_es_insert_extent(), and
   remove the TODO comment in it.

v2: https://lore.kernel.org/linux-ext4/20251121060811.1685783-1-yi.zhang@huaweicloud.com/
v1: https://lore.kernel.org/linux-ext4/20251031062905.4135909-1-yi.zhang@huaweicloud.com/

Original Description

This series addresses the optimization that Jan pointed out [1]
regarding the introduction of a sequence number to
ext4_es_insert_extent(). The proposal is to replace all instances where
the cache of on-disk extents is updated by using ext4_es_cache_extent()
instead of ext4_es_insert_extent(). This change can prevent excessive
cache invalidations caused by unnecessarily increasing the extent
sequence number when reading from the on-disk extent tree.

[1] https://lore.kernel.org/linux-ext4/ympvfypw3222g2k4xzd5pba4zhkz5jihw4td67iixvrqhuu43y@wse63ntv4s6u/

Cheers,
Yi.

Zhang Yi (14):
  ext4: subdivide EXT4_EXT_DATA_VALID1
  ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
  ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before
    submitting I/O
  ext4: correct the mapping status if the extent has been zeroed
  ext4: don't cache extent during splitting extent
  ext4: drop extent cache after doing PARTIAL_VALID1 zeroout
  ext4: drop extent cache when splitting extent fails
  ext4: cleanup zeroout in ext4_split_extent_at()
  ext4: cleanup useless out label in __es_remove_extent()
  ext4: make __es_remove_extent() check extent status
  ext4: make ext4_es_cache_extent() support overwrite existing extents
  ext4: adjust the debug info in ext4_es_cache_extent()
  ext4: replace ext4_es_insert_extent() when caching on-disk extents
  ext4: drop the TODO comment in ext4_es_insert_extent()

 fs/ext4/extents.c        | 135 ++++++++++++++++++++++++---------------
 fs/ext4/extents_status.c | 124 ++++++++++++++++++++++++++---------
 fs/ext4/inode.c          |  18 +++---
 3 files changed, 187 insertions(+), 90 deletions(-)

-- 
2.46.1


