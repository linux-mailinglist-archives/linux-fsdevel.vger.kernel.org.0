Return-Path: <linux-fsdevel+bounces-16596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24D789FA64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E887284057
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A54181B86;
	Wed, 10 Apr 2024 14:38:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E74177984;
	Wed, 10 Apr 2024 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759926; cv=none; b=niHd6H3Rm6QIX256JXjJNfsDEcMzRlaaYytknOvJTgW1jHGH0eDctnEBqmeM8BauthryW1ZcZUTE8gJteYkGNxQDLpxJUqRfvBEJvHG/1xsWgYBEQH6VqiPje00hwGYM0tDzm2TM9/bt6Qkb4KylD++rofMce9xuwZk8UqnjWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759926; c=relaxed/simple;
	bh=T4TB4BlTlfvVUzY1La73B6Y/zTjSnI4NYR/8BDSwrc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TaiLupBW7af84jnHceb9U/UmQ4Z8/iljWKhUOBCn5SRy2WEvz3puZWO8Dr7rzTauPMwCTijJtdPnKrx5xxNKK6Vf0nFDiblWbdfIw7Ba1hb7/sCI4yfKQqUNU1o8vbZp2ddloNvp2AlR2Bh2DZMJ9lAsAyf9hKP29BBlFE/vaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF56h25dqz4f3k6L;
	Wed, 10 Apr 2024 22:38:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ACF081A0568;
	Wed, 10 Apr 2024 22:38:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S27;
	Wed, 10 Apr 2024 22:38:40 +0800 (CST)
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
Subject: [RFC PATCH v4 23/34] ext4: implement buffered read iomap path
Date: Wed, 10 Apr 2024 22:29:37 +0800
Message-Id: <20240410142948.2817554-24-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S27
X-Coremail-Antispam: 1UD129KBjvJXoW7urW3XF4fAFy7KF1UXrW7XFb_yoW8uFy3pF
	98KFy5GF47XrnI9F4SgFZrJr1Yk3Wxtr4UZrWfWasxGFyYkrW2gayjgFyYyF1Yq3y7Ary8
	WF1jkr18GF4UArDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
	1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7sRibyCPUUUU
	U==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add ext4_iomap_buffered_io_begin() for the iomap read path, it call
ext4_map_blocks() to query map status and call ext4_set_iomap() to
convert ext4 map to iomap.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4c1fed516d9e..20eb772f4f62 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3523,14 +3523,46 @@ const struct iomap_ops ext4_iomap_report_ops = {
 	.iomap_begin = ext4_iomap_begin_report,
 };
 
-static int ext4_iomap_read_folio(struct file *file, struct folio *folio)
+static int ext4_iomap_buffered_io_begin(struct inode *inode, loff_t offset,
+				loff_t length, unsigned int iomap_flags,
+				struct iomap *iomap, struct iomap *srcmap)
 {
+	int ret;
+	struct ext4_map_blocks map;
+	u8 blkbits = inode->i_blkbits;
+
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
+		return -EIO;
+	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+		return -EINVAL;
+	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
+		return -ERANGE;
+
+	/* Calculate the first and last logical blocks respectively. */
+	map.m_lblk = offset >> blkbits;
+	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
+			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
+
+	ext4_set_iomap(inode, iomap, &map, offset, length, iomap_flags);
 	return 0;
 }
 
-static void ext4_iomap_readahead(struct readahead_control *rac)
+const struct iomap_ops ext4_iomap_buffered_read_ops = {
+	.iomap_begin = ext4_iomap_buffered_io_begin,
+};
+
+static int ext4_iomap_read_folio(struct file *file, struct folio *folio)
 {
+	return iomap_read_folio(folio, &ext4_iomap_buffered_read_ops);
+}
 
+static void ext4_iomap_readahead(struct readahead_control *rac)
+{
+	iomap_readahead(rac, &ext4_iomap_buffered_read_ops);
 }
 
 static int ext4_iomap_writepages(struct address_space *mapping,
-- 
2.39.2


