Return-Path: <linux-fsdevel+bounces-16565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC789F886
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED021F30B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B5B17A93C;
	Wed, 10 Apr 2024 13:37:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC115EFA9;
	Wed, 10 Apr 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756229; cv=none; b=g3sLGq8omVI74/AnYlKc9OgRCJBFrRUlylcNcXSAdi0uK+6I8jwe4XK3yMs5HzDdiong1zrXk5hR+f+SJU8m5CCv1EHrOtINYYt5aeVvfbGbhd3dcugPzEN6WDI8GZ6KOGCtkmgrjog6fFRDCPSCNVVHj40twHVwG5BKiv8tI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756229; c=relaxed/simple;
	bh=a0yXsZEWte2+yhfLSEWGmnTc+medZk5RJjxW91j+Nrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJjT+ZQL1jw2r9blfYpebh5ySDLbLaNwdlzyZrlaeXEPo3v2vBpfelltU9tmGn0lCLqKGiOVtGUThYsXx7l9La55LbR8uQksKzd1so3gIkbFq0Y2kvNukXPXBLl7KcohE5A/AXB6Z0mwExT78Dhpj6NXkVl7Z0MFFe8FkCwe7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF3lc2Fqrz4f3jZ7;
	Wed, 10 Apr 2024 21:37:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B14941A058E;
	Wed, 10 Apr 2024 21:37:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHolRZmeCl4Jg--.8806S31;
	Wed, 10 Apr 2024 21:37:04 +0800 (CST)
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
Subject: [RFC PATCH v4 27/34] ext4: implement zero_range iomap path
Date: Wed, 10 Apr 2024 21:28:11 +0800
Message-Id: <20240410132818.2812377-28-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RHolRZmeCl4Jg--.8806S31
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7CrW8XF1rKFW7Gr1rJFb_yoW8JFWDpr
	n5K34UCr47Wr9F9F4IgF9rXr1Iy3W5Gw48WryfGrn8Z3yfW34xKFWrK3WFvF4jg3y7Jayj
	qF45try8Kw17AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUF18B
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add ext4_iomap_zero_range() for the zero_range iomap path, it zero out
the mapped blocks, all work have been done in iomap_zero_range(), so
call it directly.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d694c780007..5af3b8acf1b9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4144,6 +4144,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	return err;
 }
 
+static int ext4_iomap_zero_range(struct inode *inode,
+				 loff_t from, loff_t length)
+{
+	return iomap_zero_range(inode, from, length, NULL,
+				&ext4_iomap_buffered_read_ops);
+}
+
 /*
  * ext4_block_zero_page_range() zeros out a mapping of length 'length'
  * starting from file offset 'from'.  The range to be zero'd must
@@ -4169,6 +4176,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
 	if (IS_DAX(inode)) {
 		return dax_zero_range(inode, from, length, NULL,
 				      &ext4_iomap_ops);
+	} else if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
+		return ext4_iomap_zero_range(inode, from, length);
 	}
 	return __ext4_block_zero_page_range(handle, mapping, from, length);
 }
-- 
2.39.2


