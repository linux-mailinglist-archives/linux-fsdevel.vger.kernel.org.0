Return-Path: <linux-fsdevel+bounces-14441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9AE87CD91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2801C2088F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AC8376F2;
	Fri, 15 Mar 2024 13:01:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61B241E5;
	Fri, 15 Mar 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507670; cv=none; b=e6uibhpGyhnhfOSUhXfPtsa08DM29TZMCOVCoreoZI+nJ7NyyR4tO5CGm7+xGrTPRrk9nYF1Jd2PHxV+rGL7c0+8zEXh3zklcC/8e+Vo38t2ZaGJefXEUGeX7yxXK7U4frWybTHJP9j42PEIdfPjESpt5zBDwSJm5wom/ADU/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507670; c=relaxed/simple;
	bh=GycSr9g0r0Lj1QSXw7UeMKT8hBAO5Fq+mNRV9BSN5Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dmil5kNsxsj5+/Y5YfsxrQOXvVxGK7fcURFr+NKYk2kh6RaTE7Hf7CTuyEuX8huz2xRIsXOCfqlxV6UeCn7tdSvMpfXwU8DHZQs5BVlnYaCGnEJCz6vZEZwLZZ5bsu1ZLv9gwjUGg3NHeFnBET7XLJZMw4RRqH2bFHwsUejh80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tx49z2FPnz4f3kFB;
	Fri, 15 Mar 2024 21:00:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1BFE91A016E;
	Fri, 15 Mar 2024 21:01:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBF9RvRldVMfHA--.12032S4;
	Fri, 15 Mar 2024 21:00:58 +0800 (CST)
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
Subject: [PATCH v2 00/10] xfs/iomap: fix non-atomic clone operation and don't update size when zeroing range post eof
Date: Fri, 15 Mar 2024 20:53:44 +0800
Message-Id: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBF9RvRldVMfHA--.12032S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5JF1DKF4fur17Ww18AFb_yoW8KF1rpF
	ZxKa1fKr4vgw1fZrn3CF45Xw1rt3Z7GF4UCw4xGws3Z3y5Zr1xuFs2gF4rWrW7Ar93Wr4j
	qrsrAFy8Gw1UA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	XdbUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

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

Zhang Yi (10):
  xfs: match lock mode in xfs_buffered_write_iomap_begin()
  xfs: allow xfs_bmapi_convert_delalloc() to pass NULL seq
  xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
  xfs: drop xfs_convert_blocks()
  xfs: convert delayed extents to unwritten when zeroing post eof blocks
  iomap: drop the write failure handles when unsharing and zeroing
  iomap: don't increase i_size if it's not a write operation
  iomap: use a new variable to handle the written bytes in
    iomap_write_iter()
  iomap: make block_write_end() return a boolean
  iomap: do some small logical cleanup in buffered write

 fs/iomap/buffered-io.c   | 101 ++++++++++++++++++++++-----------------
 fs/xfs/libxfs/xfs_bmap.c |  40 ++++++++++++++--
 fs/xfs/xfs_aops.c        |  54 ++++++---------------
 fs/xfs/xfs_iomap.c       |  39 +++++++++++++--
 4 files changed, 142 insertions(+), 92 deletions(-)

-- 
2.39.2


