Return-Path: <linux-fsdevel+bounces-21884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5990D574
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CD1F23EB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70A15ECFB;
	Tue, 18 Jun 2024 14:22:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF415ECC2;
	Tue, 18 Jun 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720532; cv=none; b=R41dxHZ4JSXw5w1hRSvyNDQJy016pIRnMkQhahnodxSCcgYOUwl+zK5JOGUyT99SEek0kXsC1onJUqKa9rH6bSd9TkScS0tFeSm7PLVfGoh21pYJawl/rAnHeORAaDPL9GjWybx3iOAC15WhYSjkc7S/8qVYJP6bUbYd1rvUL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720532; c=relaxed/simple;
	bh=AASgX6FyNQo1wPqe2DGJl4Sa2ID2dOSRnJtNn9E32Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmfOHHpzPYqmWbmqEPgTBX5cRZ4LCejyUXC2n/yqSfP7p0+zR3ifvOiB2jTkC0Fw7GOmKybV3e3UU08p/pgZ3zw4JVlDivKXyhCWva4AC2Nm/uKB2bCu9fngQgnOUNXFVnWtqwpyjGRBgyA/SKMKrWuZ5dD7+sbLW8eRUyyxVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3TTb2tplz4f3nTc;
	Tue, 18 Jun 2024 22:21:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2D0EB1A0187;
	Tue, 18 Jun 2024 22:22:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB34A0ImHFmVDEoAQ--.31709S5;
	Tue, 18 Jun 2024 22:22:06 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH -next v6 1/2] xfs: reserve blocks for truncating large realtime inode
Date: Tue, 18 Jun 2024 22:21:11 +0800
Message-Id: <20240618142112.1315279-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB34A0ImHFmVDEoAQ--.31709S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw45JF4fCFWDKrWfWw1fCrg_yoW5JFWfpF
	s7Can8Gr4DXw10ka4IyF1ftw4jy3s5Jr47Cryjgrn3Z34DJr1ftrn2qryUKa1rtrZ5Xw4j
	gr15C39xZw15ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSYLPUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When unaligned truncate down a big realtime file, xfs_truncate_page()
only zeros out the tail EOF block, __xfs_bunmapi() should split the tail
written extent and convert the later one that beyond EOF block to
unwritten, but it couldn't work as expected now since the reserved block
is zero in xfs_setattr_size(), this could expose stale data just after
commit '943bc0882ceb ("iomap: don't increase i_size if it's not a write
operation")'.

If we truncate file that contains a large enough written extent:

     |<    rxext    >|<    rtext    >|
  ...WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
        ^ (new EOF)      ^ old EOF

Since we only zeros out the tail of the EOF block, and
xfs_itruncate_extents()->..->__xfs_bunmapi() unmap the whole ailgned
extents, it becomes this state:

     |<    rxext    >|
  ...WWWzWWWWWWWWWWWWW
        ^ new EOF

Then if we do an extending write like this, the blocks in the previous
tail extent becomes stale:

     |<    rxext    >|
  ...WWWzSSSSSSSSSSSSS..........WWWWWWWWWWWWWWWWW
        ^ old EOF               ^ append start  ^ new EOF

Fix this by reserving XFS_DIOSTRAT_SPACE_RES blocks for big realtime
inode.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iops.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ff222827e550..a00dcbc77e12 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -17,6 +17,8 @@
 #include "xfs_da_btree.h"
 #include "xfs_attr.h"
 #include "xfs_trans.h"
+#include "xfs_trans_space.h"
+#include "xfs_bmap_btree.h"
 #include "xfs_trace.h"
 #include "xfs_icache.h"
 #include "xfs_symlink.h"
@@ -811,6 +813,7 @@ xfs_setattr_size(
 	struct xfs_trans	*tp;
 	int			error;
 	uint			lock_flags = 0;
+	uint			resblks = 0;
 	bool			did_zeroing = false;
 
 	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
@@ -917,7 +920,17 @@ xfs_setattr_size(
 			return error;
 	}
 
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
+	/*
+	 * For realtime inode with more than one block rtextsize, we need the
+	 * block reservation for bmap btree block allocations/splits that can
+	 * happen since it could split the tail written extent and convert the
+	 * right beyond EOF one to unwritten.
+	 */
+	if (xfs_inode_has_bigrtalloc(ip))
+		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, resblks,
+				0, 0, &tp);
 	if (error)
 		return error;
 
-- 
2.39.2


