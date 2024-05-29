Return-Path: <linux-fsdevel+bounces-20393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5731E8D2A41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 04:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8753D1C236D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 02:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB215B55F;
	Wed, 29 May 2024 01:59:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310615AD9A;
	Wed, 29 May 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947965; cv=none; b=Yhe1+j65tpFB/7LS6GaJN5KwnWQ+qOCjhlKkwKMsKvhK+KpnTLjywvvjsRy5bFtzspIU/0uWOQJzyNNk/eWD1L/Ez50arpZakVj8ygkUIJgsSLX1l5v+spAhixl7PyzSqsNmWKAKhRuTC51kDL8GPvrM4J8GFcl3Jaab0XPmiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947965; c=relaxed/simple;
	bh=fQvZYnRp+sSZHSTlH4EKlMFqwqDwCAfksYi/u5y+mCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TO2iQKcTnq5xZgMREkYXqwg5t2MEdUnZUYv4RV+S13ntsSMEDSUlIDC5JOsdF+hWhMrEbZNiryp40SbN4mwY7gRcaDign17acCTAxEUMR3Veyif/uNj2kwCjcdZIpk8+koOGc8SFjXve5FtBEPV/kKiKyTfVdoCUTv3yH4AeQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vpsxn5h6lz4f3nZx;
	Wed, 29 May 2024 09:59:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 91C3A1A0185;
	Wed, 29 May 2024 09:59:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7wi1Zmr3XbNw--.12147S11;
	Wed, 29 May 2024 09:59:20 +0800 (CST)
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
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v4 7/8] xfs: reserve blocks for truncating realtime inode
Date: Wed, 29 May 2024 17:52:05 +0800
Message-Id: <20240529095206.2568162-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7wi1Zmr3XbNw--.12147S11
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW8AFy5urWUZr45Aw1fZwb_yoW8Gr18pF
	n7C3Z8WFs3Ww1jkayxAF1Fyw1UAa4vqr4jkFW8Gwnavw4DGr1ftrnYv3y8K3WUGrW2qw4F
	gr13J395Zw15ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4U
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
	cSsGvfC2KfnxnUUI43ZEXa7sRilksDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

On a realtime inode, __xfs_bunmapi() could convert the unaligned extra
blocks to unwritten state, but it couldn't work as expected on truncate
down since the reserved block is zero in xfs_setattr_size(), fix this by
reserved XFS_IS_REALTIME_INODE blocks for realtime inode.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_iops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ec7b7bdf8825..c53de5e6ef66 100644
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
+	uint			resblks;
 	bool			did_zeroing = false;
 	bool			write_back = false;
 
@@ -932,7 +935,9 @@ xfs_setattr_size(
 		}
 	}
 
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
+	resblks = XFS_IS_REALTIME_INODE(ip) ? XFS_DIOSTRAT_SPACE_RES(mp, 0) : 0;
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, resblks,
+				0, 0, &tp);
 	if (error)
 		return error;
 
-- 
2.39.2


