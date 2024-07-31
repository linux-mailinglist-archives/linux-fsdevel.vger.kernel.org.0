Return-Path: <linux-fsdevel+bounces-24667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A1942A1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E491C22631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E96A1AD416;
	Wed, 31 Jul 2024 09:16:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D3C1AC438;
	Wed, 31 Jul 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417399; cv=none; b=IRqhMKjVy/olKzmdv5mrl07AWCMbTgJElelMucnHS+DvGwcftVnyR/tPnwePmaHP0hDnsLYqasRqyvBrBVwksy8a46RCzQkKFHnPe6K3DgND8G4IRV6NA6XYBmfjZMbeTjJkxa8S6nxV9KXnVOC7NYX52fuBcXte4bWr0D34tOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417399; c=relaxed/simple;
	bh=uy8mgM/S34hEPDCgmhroX/MpBBkZfjCRRkuplIYZnJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNZNn3SxzHxjPcu+SpKsEi0NG7EgeotslZ4YqBLeBdoPJG5yGFOYBnPVquu21xv05l7Adx71m422LHC6blVEAVq/pj3RUK6br5nkS7eOKqqiatXw0vCejgB/xvYR3eczU5Bbiv6Gx38uB24QRM7n4VIm3jzNP7yTVU3eIabpjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYmgF6fFDz4f3jtR;
	Wed, 31 Jul 2024 17:16:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9228C1A0C12;
	Wed, 31 Jul 2024 17:16:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILpAKpmm6FzAQ--.49647S8;
	Wed, 31 Jul 2024 17:16:34 +0800 (CST)
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
Subject: [PATCH 4/6] iomap: correct the dirty length in page mkwrite
Date: Wed, 31 Jul 2024 17:13:03 +0800
Message-Id: <20240731091305.2896873-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgB37ILpAKpmm6FzAQ--.49647S8
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1Utw47AF48JrW5Gr45ZFb_yoWkWrX_ur
	yvgws7Gw45t3WfK3W7Z3y5Wrn2g3s8GFs7CFy8tFy5Zr15Grn5AanYkwnxAFs5XFyUJFZx
	Gr4vvr45Zr17GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUDkuxUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When doing page mkwrite, iomap_folio_mkwrite_iter() dirty the entire
folio by folio_mark_dirty() even the map length is shorter than one
folio. However, on the filesystem with more than one blocks per folio,
we'd better to only set counterpart block's dirty bit according to
iomap_length(), so open code folio_mark_dirty() and pass the correct
length.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ec17bf8d62e9..f5668895df66 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1475,7 +1475,10 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 		block_commit_write(&folio->page, 0, length);
 	} else {
 		WARN_ON_ONCE(!folio_test_uptodate(folio));
-		folio_mark_dirty(folio);
+
+		ifs_alloc(iter->inode, folio, 0);
+		iomap_set_range_dirty(folio, 0, length);
+		filemap_dirty_folio(iter->inode->i_mapping, folio);
 	}
 
 	return length;
-- 
2.39.2


