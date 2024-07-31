Return-Path: <linux-fsdevel+bounces-24665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7867942A19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98641C20FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789961AD3EB;
	Wed, 31 Jul 2024 09:16:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984441AC432;
	Wed, 31 Jul 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417399; cv=none; b=BOXWaIVe5MTRVrbk4VLAyv5HWRWLEBe+mgREDR+lyNZ+Q2So60N6qef2pJiatfiafO/40lP6zfn9V0BtyXGzJfTcZKcQyUgCCWQXvXQMRaqezhMl5onFE1PA2ARnpdtK3d9NwQq+ZM9RkgeuM8cH3AlfwENeZVC+VrHDu5Swlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417399; c=relaxed/simple;
	bh=6tbsA7hRaLDVnccW+xjg20Pihxue4wgTdZZBqBt3z9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVphd1Wr+N4lOB1Uw/HJ2FYQHeARCO/vFoS4WY0xmyh8MtSZKNjUUvEo/vrMnUWSy2B3lpfaZ99wv8zsqB1qtFsqqc1MKC1JYiefLtVbY3oRDjWTYpiJzJ4KwlwuM6GR9ByPfib2H5KPuTtmrC7sNw4olc2dQyuWFsx+Uw0RmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYmgD30G3z4f3jtJ;
	Wed, 31 Jul 2024 17:16:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 16C7E1A06DA;
	Wed, 31 Jul 2024 17:16:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILpAKpmm6FzAQ--.49647S5;
	Wed, 31 Jul 2024 17:16:32 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 1/6] iomap: correct the range of a partial dirty clear
Date: Wed, 31 Jul 2024 17:13:00 +0800
Message-Id: <20240731091305.2896873-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB37ILpAKpmm6FzAQ--.49647S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1xWr1ktrWUZF1kXF43KFg_yoW8WryxpF
	s3KF4DKrWDX3srur18ZFyrXrnYka9rXF48JrW3W3s3Wa15XFyYgr1kuay3ZF92grs7AF10
	vFnxKryxCr4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUYg4DUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The block range calculation in ifs_clear_range_dirty() is incorrect when
partial clear a range in a folio. We can't clear the dirty bit of the
first block or the last block if the start or end offset is blocksize
unaligned, this has not yet caused any issue since we always clear a
whole folio in iomap_writepage_map()->iomap_clear_range_dirty(). Fix
this by round up the first block and round down the last block and
correct the calculation of nr_blks.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d46558990279..a896d15c191a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -138,11 +138,14 @@ static void ifs_clear_range_dirty(struct folio *folio,
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
-	unsigned int first_blk = (off >> inode->i_blkbits);
-	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
-	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned int first_blk = DIV_ROUND_UP(off, i_blocksize(inode));
+	unsigned int last_blk = (off + len) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk;
 	unsigned long flags;
 
+	if (!nr_blks)
+		return;
+
 	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_clear(ifs->state, first_blk + blks_per_folio, nr_blks);
 	spin_unlock_irqrestore(&ifs->state_lock, flags);
-- 
2.39.2


