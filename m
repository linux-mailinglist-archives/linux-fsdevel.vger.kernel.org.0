Return-Path: <linux-fsdevel+bounces-14783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959B887F4DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 02:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01548282209
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 01:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2975A17F6;
	Tue, 19 Mar 2024 01:18:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE20620;
	Tue, 19 Mar 2024 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710811123; cv=none; b=ghJkDvBf47bigs2q88qUKzlS6bypGsr9r7OtJxvaalCaoxUfeBKuAKrp9d6+qnAJ/5Elas7+iRZhakhjMMvOI+UpvBRiz/FKUCCRSI+3Ue0UaoMoSIfbAmELVWAub+aWqt8PNvXvIYJwS9RHkpvwbLgOMVeiiZ5not3EgjqM70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710811123; c=relaxed/simple;
	bh=jdGAolbsdclm0Dm+TBgvDSH6fSo2w9v+pLpchiQ+qYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UWqjrOvV1jp5RnbmBAdY1Uglh2tdUmE3gU02gna2oa2bBsZVzyxIPCUCsaOQm/AmOMH/x646g5aRpw+ogiSbZq62qwbgzOKPoOauywR/rp8ZodZSOj7ClmkwbFsc/cK7UGCaMM/nV3EXcOF1Q/lws6+aV1O2G025fFKOnA25uKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TzDPZ0ySvz4f3jd2;
	Tue, 19 Mar 2024 09:18:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 125021A017A;
	Tue, 19 Mar 2024 09:18:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7O5_hlUIGNHQ--.34497S4;
	Tue, 19 Mar 2024 09:18:30 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 0/9] xfs/iomap: fix non-atomic clone operation and don't update size when zeroing range post eof
Date: Tue, 19 Mar 2024 09:10:53 +0800
Message-Id: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7O5_hlUIGNHQ--.34497S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43trykKw4fZryxGF4kZwb_yoW5JFWDpF
	ZxKw43Kr4vgr1fZrn7AF45Jw1rK3Z7GF4UCr4xJws3Z3y5ZF1xuF4IgF4F9rW7Ar93Wa1j
	qF4jyFyxG34DAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UdHUDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

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

 fs/iomap/buffered-io.c   | 101 ++++++++++++++++++++++-----------------
 fs/xfs/libxfs/xfs_bmap.c |  40 ++++++++++++++--
 fs/xfs/xfs_aops.c        |  54 ++++++---------------
 fs/xfs/xfs_iomap.c       |  39 +++++++++++++--
 4 files changed, 142 insertions(+), 92 deletions(-)

-- 
2.39.2


