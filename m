Return-Path: <linux-fsdevel+bounces-53509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC554AEFA2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF1C7ADB2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FE4275106;
	Tue,  1 Jul 2025 13:21:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D326E718;
	Tue,  1 Jul 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376062; cv=none; b=E71UiCwtm1ZYwo0Fy0L1jA0Jycq0j0tNcy149z35641eFpKUuA4+b1Xq3eZSJpEYvmoHix68MXIyWnHkWxFRbBfOLvAYcwtZhTeRXQkl867Aj20Wy90abAFCyqkDBkKh8CFUoZu8vkOTjNkoluzUGn5Gy7Cwy0KmT5c0Zycfj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376062; c=relaxed/simple;
	bh=i9MiQr/0BulowNHk7GEnIMmNE2BYXp7yvR0z3qHw+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtiSPTqf2fB0aYIBb6pnCmIEYwJVzpBX56/BRgqJw7zYmpsbT0UUsR2zCBWcfIWKWyaI51/PMJs1mW2AdtjCtcmZDrlhr6y7u0527LKgdTUrMawuvCgJy0mrc7lYZIphkAD7hbfwQQpFZg84pqm6NlRDSyTlqCNTO12UR0CwHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bWkDp0jn0zYQvMM;
	Tue,  1 Jul 2025 21:20:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EF2981A0E9A;
	Tue,  1 Jul 2025 21:20:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXeCWu4GNoXmJGAQ--.26904S4;
	Tue, 01 Jul 2025 21:20:54 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 00/10] ext4: fix insufficient credits when writing back large folios
Date: Tue,  1 Jul 2025 21:06:25 +0800
Message-ID: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXeCWu4GNoXmJGAQ--.26904S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr17GFW7ur13AFWkXw4Utwb_yoW5Crykpa
	y3CF15Gr1rZw17ua93Wa18AF1rGan5Cr47Xry3Gwn8uFZxuFyxKFZIgF4Y9FWjyrZ3JFy0
	qr4jyryDCFZ8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 - Convert the processing of folios writeback in bytes instead of pages.
 - Refactor ext4_page_mkwrite() and ensure journal credits in
   ext4_block_write_begin() instead of in _ext4_get_block().
 - Enhance tracepoints in ext4_do_writepages().
 - Replace the outdated ext4_da_writepages_trans_blocks() and
   ext4_writepage_trans_blocks() with the new helper used to reserve
   credits for a single extent.
Changes since v1:
 - Make the write-back process supports writing a partial folio if it
   exits the mapping loop prematurely due to insufficient sapce or
   journal credits, it also fix the potential stale data and
   inconsistency issues.
 - Fix the same issue regarding the allocation of blocks in
   ext4_write_begin() and ext4_page_mkwrite() when delalloc is not
   enabled.

v2: https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
v1: https://lore.kernel.org/linux-ext4/20250530062858.458039-1-yi.zhang@huaweicloud.com/

Original Description

This series addresses the issue that Jan pointed out regarding large
folios support for ext4[1]. The problem is that the credits calculation
may insufficient in ext4_meta_trans_blocks() when allocating blocks
during write back a sufficiently large and discontinuous folio, it
doesn't involve the credits for updating bitmap and group descriptor
block. However, if we fix this issue, it may lead to significant
overestimation on the some filesystems with a lot of block groups.

The solution involves first ensure that the current journal transaction
has enough credits when we mapping an extent during allocating blocks.
Then if the credits reach the upper limit, exit the current mapping
loop, submit the partial folio and restart a new transaction. Finally,
fix the wrong credits calculation in ext4_meta_trans_blocks(). Please
see the following patches for details.

[1] https://lore.kernel.org/linux-ext4/ht54j6bvjmiqt62xmcveqlo7bmrunqs4ji7wikfteftdjijzek@7tz5gpejaoen/

Thanks,
Yi.


Zhang Yi (10):
  ext4: process folios writeback in bytes
  ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
  ext4: fix stale data if it bail out of the extents mapping loop
  ext4: refactor the block allocation process of ext4_page_mkwrite()
  ext4: restart handle if credits are insufficient during allocating
    blocks
  ext4: enhance tracepoints during the folios writeback
  ext4: correct the reserved credits for extent conversion
  ext4: reserved credits for one extent during the folio writeback
  ext4: replace ext4_writepage_trans_blocks()
  ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()

 fs/ext4/ext4.h              |   2 +-
 fs/ext4/extents.c           |   6 +-
 fs/ext4/inline.c            |   6 +-
 fs/ext4/inode.c             | 324 ++++++++++++++++++++++--------------
 fs/ext4/move_extent.c       |   3 +-
 fs/ext4/xattr.c             |   2 +-
 include/trace/events/ext4.h |  47 +++++-
 7 files changed, 248 insertions(+), 142 deletions(-)

-- 
2.46.1


