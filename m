Return-Path: <linux-fsdevel+bounces-3528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7C7F5F76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 13:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C41F20F00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7026AD1;
	Thu, 23 Nov 2023 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392ACD54;
	Thu, 23 Nov 2023 04:52:08 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SbdKv5x6xz4f3kp1;
	Thu, 23 Nov 2023 20:52:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 838021A055F;
	Thu, 23 Nov 2023 20:52:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S18;
	Thu, 23 Nov 2023 20:52:05 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH 14/18] ext4: impliment zero_range iomap path
Date: Thu, 23 Nov 2023 20:51:16 +0800
Message-Id: <20231123125121.4064694-15-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
References: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S18
X-Coremail-Antispam: 1UD129KBjvJXoWrtry3tF4xJFWfur17Zr13urg_yoW8JF1xpr
	n5Gry8ur47Wr9a9F4xtF9rZrySy3W3Wr48WryfGrn8Z3y3WayxKFWrK3ZY93WYg3y7A3yj
	qF45trWIgw17Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Impliment zero_range iomap path, direct use iomap_zero_range() and add a
branch in ext4_block_zero_page_range().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f72864b9a6b3..ca66afd61fb3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4218,6 +4218,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	return err;
 }
 
+static int ext4_iomap_zero_range(struct inode *inode,
+				 loff_t from, loff_t length)
+{
+	return iomap_zero_range(inode, from, length, NULL,
+				&ext4_iomap_buffered_write_ops);
+}
+
 /*
  * ext4_block_zero_page_range() zeros out a mapping of length 'length'
  * starting from file offset 'from'.  The range to be zero'd must
@@ -4243,6 +4250,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
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


