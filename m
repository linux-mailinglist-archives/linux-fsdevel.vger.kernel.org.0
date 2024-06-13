Return-Path: <linux-fsdevel+bounces-21623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7585906803
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9942831B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004AB141995;
	Thu, 13 Jun 2024 09:01:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285113D88E;
	Thu, 13 Jun 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269274; cv=none; b=TYMru1/xmT8aFBJK4ddh72rA1v42iS1uYQd5aVTusaGsnt/THjiYQGIKyTNYA/DfvXXuk5jPngvY0iBPIPt5p8NDO9glc1EUuby6yLpwzphclHv+5gwU4Sa82L+h6DA9L9WAA2UCZ7N4kObwsqs/xf4fGgw8sHRau7xe1o6yFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269274; c=relaxed/simple;
	bh=VnFWnNXwhY2NmdloN46mKkABPKdG+djXIidYyS5lLK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLN1XqyIgFPQJ9eMdqphzNtLqN6rH27firMSrFBDnrZnTGfSmsfW8JGncZ5vVQ++x9E774q3RdyzSNu6ajwLDX5C1DUfwYyAFLEY19aOKEdxNseIzgDj+EW82j/kERgUBSdSGKJE3WkWtkX/luyXFlkaDRHtO32tJyp6iSIFw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0Gbg0DxQz4f3kkK;
	Thu, 13 Jun 2024 17:01:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 97BF41A1364;
	Thu, 13 Jun 2024 17:01:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFOtWpmHK1uPQ--.16895S10;
	Thu, 13 Jun 2024 17:01:09 +0800 (CST)
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
Subject: [PATCH -next v5 6/8] xfs: reserve blocks for truncating large realtime inode
Date: Thu, 13 Jun 2024 17:00:31 +0800
Message-Id: <20240613090033.2246907-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFOtWpmHK1uPQ--.16895S10
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyUtw4UGw4rXw45urWDCFg_yoW8AF18pF
	97Ca98Gr4DW3WYkayfZF1rtw1jyaykKr4jkFW8Wrnav3yDtr1SyFn7t3yUKF1rGrZ8Xw4Y
	gr15C398u3W3ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18B
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

For a large realtime inode, __xfs_bunmapi() could split the tail written
extent and convert the later one that beyond EOF block to unwritten, but
it couldn't work as expected on truncate down now since the reserved
block is zero in xfs_setattr_size(), fix this by reserving
XFS_DIOSTRAT_SPACE_RES blocks for large realtime inode.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_iops.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 8e7e6c435fb3..8af13fd37f1b 100644
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
@@ -913,6 +915,7 @@ xfs_setattr_size(
 	struct xfs_trans	*tp;
 	int			error;
 	uint			lock_flags = 0;
+	uint			resblks = 0;
 
 	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
 	ASSERT(S_ISREG(inode->i_mode));
@@ -967,7 +970,17 @@ xfs_setattr_size(
 	if (error)
 		return error;
 
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


