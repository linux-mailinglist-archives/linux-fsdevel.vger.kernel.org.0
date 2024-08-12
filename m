Return-Path: <linux-fsdevel+bounces-25669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA87394ECA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8095728124B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7983717B41A;
	Mon, 12 Aug 2024 12:16:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309151607AA;
	Mon, 12 Aug 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464984; cv=none; b=klKwt9xm4wsDvvmAhmUPMnHJ7c45JO2AX57KVZpvQY7H6usfsEoP4+vVUqFc1A+u6B6vQ7NxMqyi2aSeUXMRuslb+fNEhs3j36yvxCOungkUzZ1P7lJSqMEX4X1Kg9a0yMkKCJynvsisfnQLfFmyboKsDRp4VACDxlOYdiX2M1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464984; c=relaxed/simple;
	bh=SvDp59y+w/bRNQ+OV9HJKyhOPPISwBgEA6m0NH31RoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQF29Ps2ULuH2B/IgM7/I9ZB9sq5zYULd+y5zlovcZ3J8RFtUhTKLK6lWNH/K77VSsfqsOTC1AZhqgRELH4Rvzg2jadLgiEecODvcjIPg/NriV6e+XEL18EEFnGXm2Mq746KaUQMcz/hwQaBoBzYzvUzLP35Kgbcov8p+5XtOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjD4t4mZkz4f3mJ3;
	Mon, 12 Aug 2024 20:15:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 456761A018D;
	Mon, 12 Aug 2024 20:16:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDHeLcD_blmHhy7BQ--.21435S8;
	Mon, 12 Aug 2024 20:16:13 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
Date: Mon, 12 Aug 2024 20:11:57 +0800
Message-Id: <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHeLcD_blmHhy7BQ--.21435S8
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1Utw47AF48JrW5Gr45ZFb_yoWkWrX_ur
	yvkwn7Gw45t3WfK3W7Z345Xrn2g345GFs7CFy8tFyrZr15Jrn5J3WvkwnxAFs5XFyUGFZx
	Cr4vqr45Ary7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUWMKtUUUUU=
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
index 79031b7517e5..ac762de9a27f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1492,7 +1492,10 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
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


