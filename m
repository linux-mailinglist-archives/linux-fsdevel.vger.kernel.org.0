Return-Path: <linux-fsdevel+bounces-32554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C839A96AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A35028528B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C1146D6A;
	Tue, 22 Oct 2024 03:13:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09351474BF;
	Tue, 22 Oct 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566783; cv=none; b=epPpTKZe+sNEsb6iJtOXxNHKKlQR+Y16fEp/bvTQCkZB9oW6BebaNbypqr/gqVZWKpV76jkWiI0OOH34IyleTYXFWSv35HtbORtbszUZkES+xHFFToHGnP4hRKLrBjmPXpE2pZsRQFEaCE2qNgO+5+iCRIzy3jXHgbZB8ZbIt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566783; c=relaxed/simple;
	bh=mfpbSaLpTZWPmr7Qv9kGMuWgxyR1PGeQlGnSV9/uK1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYhS0NATSfBhQ4zAs9wpB6ZbA7mya340rL5HIai0logD0bomUbUWtLc7vDPn/+uKGEbGdQYvXaq4kdzScU4wQcrU2/u1q5HpbXBsaDMtREZ+CFY51SBLY5Me8wq70gnn/YvXIVpePjfmOFRPyk+jnE3EBNFoVFEpqd2jikB+XGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgK66cyz4f3jkk;
	Tue, 22 Oct 2024 11:12:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 227051A018D;
	Tue, 22 Oct 2024 11:12:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S18;
	Tue, 22 Oct 2024 11:12:57 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 14/27] ext4: implement buffered read iomap path
Date: Tue, 22 Oct 2024 19:10:45 +0800
Message-ID: <20241022111059.2566137-15-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S18
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyDXF1UXrW3Zw4UurWkXrb_yoW8KrWrpF
	98KFy5GF47XrnI9a1SgFZrJr1Fk3WxtF45ZrWfWasxuFyYkrW2gay0gFyYvF1Yq3yxAr10
	qr4jkr1xWF1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRgAFtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new iomap_ops, ext4_iomap_buffered_read_ops to implement the
iomap read paths, specifically .read_folio() and .readahead() of
ext4_iomap_aops. This .iomap_begin() handle invokes ext4_map_blocks() to
query the extent mapping status of the read range and then converts the
mapping information to iomap.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b233f36efefa..f0bc4b58ac4f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3526,14 +3526,47 @@ const struct iomap_ops ext4_iomap_report_ops = {
 	.iomap_begin = ext4_iomap_begin_report,
 };
 
-static int ext4_iomap_read_folio(struct file *file, struct folio *folio)
+static int ext4_iomap_buffered_read_begin(struct inode *inode, loff_t offset,
+			loff_t length, unsigned int flags, struct iomap *iomap,
+			struct iomap *srcmap)
 {
+	int ret;
+	struct ext4_map_blocks map;
+	u8 blkbits = inode->i_blkbits;
+
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
+		return -EIO;
+	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+		return -EINVAL;
+	/* Inline data support is not yet available. */
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
+	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
 	return 0;
 }
 
-static void ext4_iomap_readahead(struct readahead_control *rac)
+const struct iomap_ops ext4_iomap_buffered_read_ops = {
+	.iomap_begin = ext4_iomap_buffered_read_begin,
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
2.46.1


