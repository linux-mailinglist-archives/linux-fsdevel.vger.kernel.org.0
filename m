Return-Path: <linux-fsdevel+bounces-47070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6D0A98493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B747A2504
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15FD242D62;
	Wed, 23 Apr 2025 09:03:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F721FF47;
	Wed, 23 Apr 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399012; cv=none; b=NMbGmMVvTBZr0t5/QpGWKCe88bOSyNbesfN7BBLs2M7F4AmRleVKjpYW56m+WDNcJbnC8QNxl4pw318m+QWvGuWAnD0pZY8Ex43J4QpzMEX6LjLjLzV+tDRemJc3E2Oa2MY7BBp4RmgskioK6xlRgfkcGU4JJArrYZjD36uM9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399012; c=relaxed/simple;
	bh=iZgg129lpik5ZGSuOYF9PgB8mFRZDSWkTauXVN//Kvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npgXu52kko+rMRmX3+0Y5lzeH2gVYA4BjKILvnE++GaC8zPAS1NdHyi3xXVaeB9XEOzrdk5J+wHH7VRvJ8il4GiwuCp8jrclTCLoh2FaueWZR3khAcILjxKDo3/TrC5suZtW3KeFEA2gFuj/0RRFZ8RTaRYFFEASadqdZIZoJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZjCmt6kNVz4f3lVM;
	Wed, 23 Apr 2025 17:02:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 688651A1479;
	Wed, 23 Apr 2025 17:03:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S4;
	Wed, 23 Apr 2025 17:03:18 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/9] ext4: fix stale extent status entries and clairfy rules
Date: Wed, 23 Apr 2025 16:52:48 +0800
Message-ID: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw43CFyUKw13JFykGw47XFb_yoW8CrWfpF
	sxGw4fWr18Xa4aya9xAw4UJFy5G3yxGa17CF9rJw17uF45uFyjqF48KF1FvFyrXrW8Xr1j
	vF4Iyr17G3WjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

This patch series addresses the potential problems discussed with Jan
Kara regarding the modification rules for mapping extents[1]. Preparing
for the buffered I/O conversion for regular files.

This change includes:

Patch 1-5 fixes problems related to stale extent status entries that
may arise during the collapsing of ranges, the insertion of ranges, or
file truncation when these operations compete with concurrent writeback,
fiemap, or get extent cache.

Patch 6-8 adds a helper function to verify whether the context for
modifying extents is safe when EXT4_DEBUG is enabled. It primarily
checks the inode's i_rwsem and the mapping's invalidate_lock.

Patch 9 adds a comment to clarify the rules for loading, mapping,
modifying, and removing extents.

Please refer to the following patches for details.

[1] https://lore.kernel.org/linux-ext4/20241211160047.qnxvodmbzngo3jtr@quack3/

Thanks,
Yi.

Zhang Yi (9):
  ext4: ext4: unify EXT4_EX_NOCACHE|NOFAIL flags in
    ext4_ext_remove_space()
  ext4: generalize EXT4_GET_BLOCKS_IO_SUBMIT flag usage
  ext4: prevent stale extent cache entries caused by concurrent I/O
    writeback
  ext4: prevent stale extent cache entries caused by concurrent fiemap
  ext4: prevent stale extent cache entries caused by concurrent get
    es_cache
  ext4: factor out is_special_ino()
  ext4: introduce ext4_check_map_extents_env() debug helper
  ext4: check env when mapping and modifying extents
  ext4: clairfy the rules for modifying extents

 fs/ext4/ext4.h           | 26 ++++++++++++---
 fs/ext4/extents.c        | 54 ++++++++++++++++++++----------
 fs/ext4/extents_status.c | 35 ++++++++++++++++++--
 fs/ext4/fast_commit.c    |  4 ++-
 fs/ext4/inode.c          | 71 +++++++++++++++++++++++++++++++---------
 fs/ext4/ioctl.c          |  8 ++++-
 6 files changed, 157 insertions(+), 41 deletions(-)

-- 
2.46.1


