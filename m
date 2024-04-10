Return-Path: <linux-fsdevel+bounces-16567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A47489F88F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6C21C272C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5717BB03;
	Wed, 10 Apr 2024 13:37:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627117965A;
	Wed, 10 Apr 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756231; cv=none; b=ADbRizN0YxaNTo+fDCykm4eAi75XiHrMxAsKANfIHQHcvZPC1BPT6gMB1XPVpGXA7b5ITRkm+cz/XR+FGDxNYqyx4w9127wloNFClNl5scKWjW7VqDBJOeEnBgmSRYSHkHUmK/C+s0IM9+WoyzcIqMvrcfPs959fmc9ImQfefM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756231; c=relaxed/simple;
	bh=rE9Rcx+buyMmwsXHYp7x2evEfE+Nh2dJdCHXPJa71C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUOXm8MWeAkKAMw0BMcaSC91d2wixe6mJHi+BZ0iWhDmDbrrN5oBiLsswfkxsBnQOYG0LhwwxD4/jCAqdPHW8Q4JywyOzB1o5860Rf8JGdC4ktwI0gbwKlqjolgvauhskEv5TsJeNKX9BzsFSWSQW8v72/R6e6MLLwyQxyJ2KYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF3lZ3NfRz4f3kjM;
	Wed, 10 Apr 2024 21:36:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 512461A058D;
	Wed, 10 Apr 2024 21:37:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S32;
	Wed, 10 Apr 2024 21:37:05 +0800 (CST)
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
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 28/34] ext4: writeback partial blocks before zeroing out range
Date: Wed, 10 Apr 2024 21:28:12 +0800
Message-Id: <20240410132818.2812377-29-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
References: <20240410132818.2812377-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S32
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5Aw4UXw1DtFy5XF47Jwb_yoWkZrc_Xa
	4rJr1kWrWftr92g3s7Cry3ArWIyw409r1fuFy0y3s5ZFy5Kws2k3s5Ar4xZrZ5WFy2gry3
	Cr4qqF48WF9rujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_Gc
	Wl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfU
	UUUU=
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


