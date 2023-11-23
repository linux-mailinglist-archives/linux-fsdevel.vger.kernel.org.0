Return-Path: <linux-fsdevel+bounces-3531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156C7F5F7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 13:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632841C21090
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769F2E855;
	Thu, 23 Nov 2023 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D275D50;
	Thu, 23 Nov 2023 04:52:07 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SbdKs3pZqz4f3kFX;
	Thu, 23 Nov 2023 20:52:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3B2B71A0557;
	Thu, 23 Nov 2023 20:52:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S13;
	Thu, 23 Nov 2023 20:52:03 +0800 (CST)
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
Subject: [RFC PATCH 09/18] ext4: implement buffered read iomap path
Date: Thu, 23 Nov 2023 20:51:11 +0800
Message-Id: <20231123125121.4064694-10-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S13
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17CF4fuF45Ww1kXFyrWFg_yoW8ur1xpF
	98KFy5GF47XrnI9a1SqFZrAr1ak3Wxta1UZrWfWasxCFyYkrW7Kay0gFyYyF15X3y8Ary8
	XF4jkr18GF4UArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Implement ext4_iomap_buffered_io_begin() blocks mapping helper, it query
block mapping and use ext4_set_iomap() convert ext4 map to iomap, then
the buffered read path can be supported by iomap frame.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4eef3828d5fd..4c206cf37a49 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3525,14 +3525,47 @@ const struct iomap_ops ext4_iomap_report_ops = {
 	.iomap_begin = ext4_iomap_begin_report,
 };
 
-static int ext4_iomap_read_folio(struct file *file, struct folio *folio)
+static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
+				loff_t length, unsigned int flags,
+				struct iomap *iomap, struct iomap *srcmap)
 {
+	int ret;
+	struct ext4_map_blocks map;
+	u8 blkbits = inode->i_blkbits;
+
+	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
+		return -ERANGE;
+
+	/*
+	 * Calculate the first and last logical blocks respectively.
+	 */
+	map.m_lblk = offset >> blkbits;
+	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
+			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
+
+	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 	return 0;
 }
 
-static void ext4_iomap_readahead(struct readahead_control *rac)
+const struct iomap_ops ext4_iomap_read_ops = {
+	.iomap_begin = ext4_iomap_buffered_io_begin,
+};
+
+static int ext4_iomap_read_folio(struct file *file, struct folio *folio)
 {
+	return iomap_read_folio(folio, &ext4_iomap_read_ops);
+}
 
+static void ext4_iomap_readahead(struct readahead_control *rac)
+{
+	iomap_readahead(rac, &ext4_iomap_read_ops);
 }
 
 static int ext4_iomap_writepages(struct address_space *mapping,
-- 
2.39.2


