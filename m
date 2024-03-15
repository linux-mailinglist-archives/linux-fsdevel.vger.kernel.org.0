Return-Path: <linux-fsdevel+bounces-14439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7299F87CD8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A43284481
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06060288DB;
	Fri, 15 Mar 2024 13:01:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6DD24B31;
	Fri, 15 Mar 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507669; cv=none; b=LSl3Ww15XaAgepURZ/ToSs5tfMCJOZ4MGsVev1kVmelQx0kByJ0+vnKvxxIcRaf4Lt+S4AWrc6XBqyrVx5LLhqEaSXN6hmQSmragT3Jt2WzfRwrTshZJNbZj4POsWgdykNf5dDY92P4b2jMD+MeOq8as0Po5DR7D/Jvyk/IT5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507669; c=relaxed/simple;
	bh=UTOLNZowp2IpSl/arzU1NA99gai8iyX3y2zfaY0hqyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N7yemSlkC97BZ0Z3YJ7fFsOyMWaobXWfVqKF7glYCi92W51C9EZxaNbq+jYwEmPpfRHno/M73A999nAF1YxcYAOgDdo4rMI71WWxFKqif0Vh9Unbj5JqdK5TbRk0HBSejqn12I86x/aOm1KXEjrH5WzYHnpxL6k291GKfJZpeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tx4B0334Dz4f3kFK;
	Fri, 15 Mar 2024 21:00:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 37C901A0172;
	Fri, 15 Mar 2024 21:01:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBF9RvRldVMfHA--.12032S6;
	Fri, 15 Mar 2024 21:01:01 +0800 (CST)
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
Subject: [PATCH v2 02/10] xfs: allow xfs_bmapi_convert_delalloc() to pass NULL seq
Date: Fri, 15 Mar 2024 20:53:46 +0800
Message-Id: <20240315125354.2480344-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBF9RvRldVMfHA--.12032S6
X-Coremail-Antispam: 1UD129KBjvJXoWrKFWxArWrCF1rXr48KF1fCrg_yoW8Jr4rpF
	s7Gw1UGFZ3Xw1avF1ktF1Yq3WfJ3Z2ka40yFs7Z393ZanrAr4aqr1rKFyYqw1UZw4FqF18
	WF15Gry7Xw45Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

xfs_bmapi_convert_delalloc() always pass out ifp->if_seq now, make it
support not passing out this value if caller doesn't care about it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index f362345467fa..07dc35de8ce5 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4574,7 +4574,8 @@ xfs_bmapi_convert_delalloc(
 	if (!isnullstartblock(bma.got.br_startblock)) {
 		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
 				xfs_iomap_inode_sequence(ip, flags));
-		*seq = READ_ONCE(ifp->if_seq);
+		if (seq)
+			*seq = READ_ONCE(ifp->if_seq);
 		goto out_trans_cancel;
 	}
 
@@ -4623,7 +4624,8 @@ xfs_bmapi_convert_delalloc(
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
 	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
 				xfs_iomap_inode_sequence(ip, flags));
-	*seq = READ_ONCE(ifp->if_seq);
+	if (seq)
+		*seq = READ_ONCE(ifp->if_seq);
 
 	if (whichfork == XFS_COW_FORK)
 		xfs_refcount_alloc_cow_extent(tp, bma.blkno, bma.length);
-- 
2.39.2


