Return-Path: <linux-fsdevel+bounces-13188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1E86C860
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 12:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711001F2457E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D827D3E7;
	Thu, 29 Feb 2024 11:45:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206917C6D2;
	Thu, 29 Feb 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207137; cv=none; b=FkwW9lJP2IkkEs2JpH/KlataUMMQuMAxX5At28vnfOjXvdTF95uIv5dA4+1l9vUVzU/86h3DApvlNzmy+z5eC181oB5hQLF3nnBNdmcDzMmjwu/09iuPEizAQWJ0TQJDU0AmpW+HCa+p2LcUeY+Pc3Xvf1CVIhrSdK28Nv0c4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207137; c=relaxed/simple;
	bh=jsKCtJRRKaJUiyg4hQpnl4lXKjzxpQzJM96ZLAswM1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTJk4a7ox/Ysm5+VTRp66E6CKzWiemB1swaS/Comtsy6GX8qN7jhGJNTsTGBDAIBsGvm1ASv7MaG3wyqth0mLE+yKSt3kuPJMJQYDFVF9OnHYQGV0DHhuyhP32TdWHp8ZMvFQmQKP7FKYEhlTv7X6mG9rP6JO6qi7QfUKb0mtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tlq9J2Zkdz1Q9Mp;
	Thu, 29 Feb 2024 19:43:16 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 9670D140390;
	Thu, 29 Feb 2024 19:45:32 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 19:45:31 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <brauner@kernel.org>, <david@fromorbit.com>, <djwong@kernel.org>,
	<jack@suse.cz>, <tytso@mit.edu>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH RFC 2/2] ext4: Optimize endio process for DIO overwrites
Date: Thu, 29 Feb 2024 19:38:49 +0800
Message-ID: <20240229113849.2222577-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229113849.2222577-1-chengzhihao1@huawei.com>
References: <20240229113849.2222577-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

In DIO overwriting case, there is no need to convert unwritten exntents
and ext4_handle_inode_extension() can be ignored, which means that endio
process can be executed under irq context. Since commit 240930fb7e6b5
("ext4: dio take shared inode lock when overwriting preallocated blocks")
has provided a method to judge whether overwriting is happening, just do
nothing in endio process if DIO overwriting happens.
This patch enables ext4 processing endio under irq context in DIO
overwriting case, which brings a performance improvement in the
following fio test on a x86 physical machine with nvme when irq
and fio run on the same cpu:

Test: fio -direct=1 -iodepth=128 -rw=randwrite -ioengine=libaio -bs=4k
-size=2G -numjobs=1 -overwrite=1 -time_based -runtime=60 -group_reporting
-filename=/test/test -name=Rand_write_Testing --cpus_allowed=1

before: 953 MiB/s  after: 1350 MiB/s, ~41% perf improvement.

Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ext4/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 54d6ff22585c..411a05c6b96e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -503,6 +503,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(from);
 	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
+	const struct iomap_dio_ops *iomap_dops = &ext4_dio_write_ops;
 	bool extend = false, unwritten = false;
 	bool ilock_shared = true;
 	int dio_flags = 0;
@@ -572,9 +573,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ext4_journal_stop(handle);
 	}
 
-	if (ilock_shared && !unwritten)
+	if (ilock_shared && !unwritten) {
 		iomap_ops = &ext4_iomap_overwrite_ops;
-	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
+		iomap_dops = NULL;
+		dio_flags = IOMAP_DIO_MAY_INLINE_COMP;
+	}
+	ret = iomap_dio_rw(iocb, from, iomap_ops, iomap_dops,
 			   dio_flags, NULL, 0);
 	if (ret == -ENOTBLK)
 		ret = 0;
-- 
2.39.2


