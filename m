Return-Path: <linux-fsdevel+bounces-16601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5FA89FA74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC89828398B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ED11836F3;
	Wed, 10 Apr 2024 14:38:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB018132B;
	Wed, 10 Apr 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759929; cv=none; b=aoOylt+fX9Si1rBb13qhF1Q23xMUs8pDspNbKa8TzpjVgVAZFRQ0O0a+IA6VUtqUQ+qaftp4hTamQqyhfRxjVbldKJDAkBQBsW1O5un7uFQ/Xv+9APL3Wn5XS4FuxytOWwb5RnwjRIVTHCfNJMN7QwZYmKnCGM0uH/3N2UT9bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759929; c=relaxed/simple;
	bh=rE9Rcx+buyMmwsXHYp7x2evEfE+Nh2dJdCHXPJa71C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSi6UznCoPtZzUnkl0Vrp6O9wxxZ81eGYv/BCVD4S9+MrAO2aQZ5M/yjr8qAd7JiCk6DhUh37//F9zuvXEJIn10h3/hK36sVCj+Cw5ABsAlvujiJTzyMrrcmx6RUp+hyXKJHpxyrK/lLlBOp3X42yzisuZEVulUsyKpYsqmY7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF56l3V9Xz4f3kK0;
	Wed, 10 Apr 2024 22:38:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DE50F1A0175;
	Wed, 10 Apr 2024 22:38:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S32;
	Wed, 10 Apr 2024 22:38:43 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 28/34] ext4: writeback partial blocks before zeroing out range
Date: Wed, 10 Apr 2024 22:29:42 +0800
Message-Id: <20240410142948.2817554-29-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S32
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5Aw4UXw1DtFy5XF47Jwb_yoWkZrc_Xa
	4rJr1kWrWftr92g3s7Cry3ArWIyw409r1fuFy0y3s5ZFy5Kws2k3s5Ar4xZrZ5WFy2gry3
	Cr4qqF48WF9rujkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbl8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_Gc
	Wl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI
	8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr
	0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1l
	IxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjTRtOzsDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

If we zero partial blocks, iomap_zero_iter() will skip zeroing out the
IOMAP_UNWRITTEN srcmap, it works fine in xfs because this type means the
block is pure unwritten and doesn't contain any delayed data. But it
doesn't work in ext4, because IOMAP_UNWRITTEN may contain delayed data
in ext4. For now it's hard to unify the meaning of this flag, so just
fix it by writeback partial blocks before zeroing out.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9849947cec56..c4c38a323ff7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4580,6 +4580,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		if (ret)
 			goto out_mutex;
 
+		ret = filemap_write_and_wait_range(mapping,
+				round_down(offset, 1 << blkbits), offset);
+		if (ret)
+			goto out_mutex;
+
+		ret = filemap_write_and_wait_range(mapping, offset + len,
+				round_up((offset + len), 1 << blkbits));
+		if (ret)
+			goto out_mutex;
 	}
 
 	/* Zero range excluding the unaligned edges */
-- 
2.39.2


