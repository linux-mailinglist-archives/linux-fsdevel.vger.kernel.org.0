Return-Path: <linux-fsdevel+bounces-69345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E4FC77831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A70E4E7D47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0FD2F747D;
	Fri, 21 Nov 2025 06:10:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD72D97BE;
	Fri, 21 Nov 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705431; cv=none; b=uDi5i+rypWXIHJhGk5+bvvXeNZJdmCAIPkWvo+WbWKVLA02mqu9uAP8wAp9k17CaPH5eI/6EiAI4RHE4JCW/wnSUDW6Ha19Zpp+3GhtiiR9jjQVPb1DX3L3TUr+h1dKsW/1R1Exwv2QpxfQKP8nHfGopm5Y/NWjHzIFP++L2yQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705431; c=relaxed/simple;
	bh=+ncPD1HIKaWAsS9TxBCmIj6UxSAwYN6ZzK8R5wxJAWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1dButW2zc4ctVkU19z8pXFt0nNEkjJ+x34w+lAcsVpNI9TxbeJX5folyzEmyzYq+qpqKrOrFYl6PiEQGHE8trRkHT6m+SG9Pzab7DL6G56cozZR5MAEEtDsVZ9IEx73HTlJeD48j+VQrWoXEhsJiExJJyjnd6aIAFmz+E7tEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCPvC1n89zYQv3p;
	Fri, 21 Nov 2025 14:09:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4BE431A0906;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHtAAiBp_of0BQ--.63807S4;
	Fri, 21 Nov 2025 14:10:24 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when caching on-disk extents
Date: Fri, 21 Nov 2025 14:07:58 +0800
Message-ID: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHtAAiBp_of0BQ--.63807S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4xGrWDWryrXryDtw1kZrb_yoW5Jr45pF
	ZxCr45Xr48X34xK393J3WUXr13G3WfCr47CryxKw1ruFyUAFy2gr4DKa10vFyfXrW8XF15
	AF4Fyrs8Ca45C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

Zhang Yi (13):
  ext4: cleanup zeroout in ext4_split_extent_at()
  ext4: subdivide EXT4_EXT_DATA_VALID1
  ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
  ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before
    submitting I/O
  ext4: correct the mapping status if the extent has been zeroed
  ext4: don't cache extent during splitting extent
  ext4: drop extent cache before splitting extent
  ext4: cleanup useless out tag in __es_remove_extent()
  ext4: make __es_remove_extent() check extent status
  ext4: make ext4_es_cache_extent() support overwrite existing extents
  ext4: adjust the debug info in ext4_es_cache_extent()
  ext4: replace ext4_es_insert_extent() when caching on-disk extents
  ext4: drop the TODO comment in ext4_es_insert_extent()

 fs/ext4/extents.c        | 127 +++++++++++++++++++++++----------------
 fs/ext4/extents_status.c | 121 ++++++++++++++++++++++++++++---------
 fs/ext4/inode.c          |  18 +++---
 3 files changed, 176 insertions(+), 90 deletions(-)

-- 
2.46.1


