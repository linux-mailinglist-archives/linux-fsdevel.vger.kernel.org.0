Return-Path: <linux-fsdevel+bounces-51309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2DAD53F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F94B17CC16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94652749FE;
	Wed, 11 Jun 2025 11:29:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320F25BF06;
	Wed, 11 Jun 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641384; cv=none; b=lu2rLkJVNZCVelZWrme5bYvNs6ZyxKR/h/GxK0NSFLuInp5pGNntltnvoOpBoUT6GTFFAWUBAlPijoZhM0KJR93OOfCYO1fGjvrHjIbBJtt/47u4QjqZkQNThfJOIF8oN1KQSXTNM8p2ZzU4eeMB2KOsNVuQ+lYGzNe+9IRxdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641384; c=relaxed/simple;
	bh=LwJzZfwCzwooaWWIheJ4nFIMPjioADEPy417rmh7ndQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4+EuJlNavvRoF81RNxcXuBzHOs1SWOKZ597HUDmaq5POFzKi0TV35IvGSQoCnM3ofxpuCyJc0wYdRfaMUNYpeCYNAmgi1P9IYFkojY6gVblVXkcUiTK/+CxFs2YZhvOpGHFhaGua2HSjAwtz9xBKYjuOlErsq/Wx6xDVk2Vrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bHNjc29MfzKHNHl;
	Wed, 11 Jun 2025 19:29:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A432C1A13F3;
	Wed, 11 Jun 2025 19:29:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacOXaElofvDPOw--.32023S4;
	Wed, 11 Jun 2025 19:29:36 +0800 (CST)
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
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 0/6] ext4: fix insufficient credits when writing back large folios
Date: Wed, 11 Jun 2025 19:16:19 +0800
Message-ID: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacOXaElofvDPOw--.32023S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyfJF48JF43Zr45KFyDKFg_yoW8uryxpa
	93G3WrG3yrZa47ZFZ3Xa1xGF1rGaykCr1UXr47tw1Dua9xuryxKFsFgF45KFyjyrZ3JFWj
	qr1jyryDCFZ0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v1:
 - Make the write-back process supports writing a partial folio if it
   exits the mapping loop prematurely due to insufficient sapce or
   journal credits, it also fix the potential stale data and
   inconsistency issues.
 - Fix the same issue regarding the allocation of blocks in
   ext4_write_begin() and ext4_page_mkwrite() when delalloc is not
   enabled.

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

Zhang Yi (6):
  ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
  ext4: fix stale data if it bail out of the extents mapping loop
  ext4: restart handle if credits are insufficient during allocating
    blocks
  ext4: correct the reserved credits for extent conversion
  ext4/jbd2: reintroduce jbd2_journal_blocks_per_page()
  ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()

 fs/ext4/ext4_jbd2.h  |   7 +++
 fs/ext4/inode.c      | 118 ++++++++++++++++++++++++++++++++++++-------
 fs/jbd2/journal.c    |   6 +++
 include/linux/jbd2.h |   1 +
 4 files changed, 113 insertions(+), 19 deletions(-)

-- 
2.46.1


