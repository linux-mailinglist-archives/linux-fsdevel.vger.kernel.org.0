Return-Path: <linux-fsdevel+bounces-17768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5EE8B2276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FF81C2114D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4308149DF2;
	Thu, 25 Apr 2024 13:23:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE8149C66;
	Thu, 25 Apr 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051388; cv=none; b=kjrw+60Q9sOpmyxCkMPWt4v0yu6C9GjK3WckABiW29WFnAy4Y77EmlDu9FL1snfS2IhNXCoV2++c1qleO/A9dOMYS019x+64Tk2Pdw1GAN9tDjeHXyXm9niXjmFm0SRVUgzxzQhbnvTQZlpYm1SOoUfEGodrozj7rvlgMgv8aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051388; c=relaxed/simple;
	bh=YIeyc2rs/L/mmWn560rSiI949EjkmDH3k+JZWsMuzTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NmhQSlnVTzNkYqbvqYNCwUfef9t22MasNDsMMUOVhzyeJ3zsoVdRWZr113aJ+RQ8Osh3p/B/4pDOcjVTvO1h4SSJ0nadJuH3hYplypPm+5O0OpDQYQL9qrSs3WTtdvKYEXnRJYumHLZMHchrWhRtKY6+X/SCsk0LmYwudFaRe5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VQGkR4fsxz4f3khT;
	Thu, 25 Apr 2024 21:22:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3FF741A016E;
	Thu, 25 Apr 2024 21:23:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEqWSpmHu+2Kw--.61462S4;
	Thu, 25 Apr 2024 21:23:01 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 0/9] xfs/iomap: fix non-atomic clone operation and don't update size when zeroing range post eof
Date: Thu, 25 Apr 2024 21:13:26 +0800
Message-Id: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBEqWSpmHu+2Kw--.61462S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW5WF47AF17XF1rurWxJFb_yoW5Xw45pF
	ZxKwsxKrs5Kr1fZrnayF45Xw1rK3Z3Gr4UCr1xJws3Z3y5ZF1xZa1IgF1F9rWUAr93W3Wj
	qF4jyF97Cr1DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUoOJ5UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Changes since v4:
 - For zeroing range in xfs, move the delalloc check to before searching
   the COW fork when zeroing range. Only modify patch 04, please see it
   for details, not modify other patches.

Changes since v3:
 - Improve some git message comments and do some minor code cleanup, no
   logic changes.

Changes since v2:
 - Merge the patch for dropping of xfs_convert_blocks() and the patch
   for modifying xfs_bmapi_convert_delalloc().
 - Reword the commit message of the second patch.

Changes since v1:
 - Make xfs_bmapi_convert_delalloc() to allocate the target offset and
   drop the writeback helper xfs_convert_blocks().
 - Don't use xfs_iomap_write_direct() to convert delalloc blocks for
   zeroing posteof case, use xfs_bmapi_convert_delalloc() instead.
 - Fix two off-by-one issues when converting delalloc blocks.
 - Add a separate patch to drop the buffered write failure handle in
   zeroing and unsharing.
 - Add a comments do emphasize updating i_size should under folio lock.
 - Make iomap_write_end() to return a boolean, and do some cleanups in
   buffered write begin path.

This patch series fix a problem of exposing zeroed data on xfs since the
non-atomic clone operation. This problem was found while I was
developing ext4 buffered IO iomap conversion (ext4 is relying on this
fix [1]), the root cause of this problem and the discussion about the
solution please see [2]. After fix the problem, iomap_zero_range()
doesn't need to update i_size so that ext4 can use it to zero partial
block, e.g. truncate eof block [3].

[1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
[2] https://lore.kernel.org/linux-ext4/9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com/
[3] https://lore.kernel.org/linux-ext4/9c9f1831-a772-299b-072b-1c8116c3fb35@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (9):
  xfs: match lock mode in xfs_buffered_write_iomap_begin()
  xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
  xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
  xfs: convert delayed extents to unwritten when zeroing post eof blocks
  iomap: drop the write failure handles when unsharing and zeroing
  iomap: don't increase i_size if it's not a write operation
  iomap: use a new variable to handle the written bytes in
    iomap_write_iter()
  iomap: make iomap_write_end() return a boolean
  iomap: do some small logical cleanup in buffered write

 fs/iomap/buffered-io.c   | 105 ++++++++++++++++++++++-----------------
 fs/xfs/libxfs/xfs_bmap.c |  40 +++++++++++++--
 fs/xfs/xfs_aops.c        |  54 ++++++--------------
 fs/xfs/xfs_iomap.c       |  39 +++++++++++++--
 4 files changed, 144 insertions(+), 94 deletions(-)

-- 
2.39.2


