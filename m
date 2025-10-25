Return-Path: <linux-fsdevel+bounces-65608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21BC089DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAC23BDBD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B598258CD9;
	Sat, 25 Oct 2025 03:30:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0226FA56;
	Sat, 25 Oct 2025 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363013; cv=none; b=HZGaEHMdCknY7K9i9xeJ/RPCeXBjQo+ip12dMHQyV2XOzbLWbUUq1mnAwI3E7FswZLZPH/1jhAB8g7aSu7weNtGNojEf/WJqfeIkKslAmDg0BZUx49bDkb4PVeqMJ3L4VS9xCmFHWFQSxqyeStq4tDS2JJlz6JtmvgK0gCpg6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363013; c=relaxed/simple;
	bh=PDQRBBuBI0KtsRbNWXjVRYAFjEtNYpTKodrSUzo/9gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNI6Q7Ni2HL5eJzvnjnc6aMtIbpiUZev8oA+e4wk8SxgleF4VtJADRkSfVAnzFaKh1O73+GloLUcsdYHTwlIQDbq3dJiaSgUCLU59/rEJh33G6jrfmwgtiVLYBhtxFhaAtHDwE1vcFjQHw7NZa5xs1hAMkYUxKvkqP+rWTcK0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcT06ljzKHMPh;
	Sat, 25 Oct 2025 11:29:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B29961A19DA;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S21;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 17/25] ext4: support large block size in ext4_block_write_begin()
Date: Sat, 25 Oct 2025 11:22:13 +0800
Message-Id: <20251025032221.2905818-18-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251025032221.2905818-1-libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S21
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4rJw4kWr43Jw1DCrW5Awb_yoW8Xryrpr
	y3KrZ7Gr4S9r4j93W7WF13Xr18Ka4DWF4UCFW3Zry3Xa48twnagr4kt3s5XF4jqayxZFyk
	ZFyrtryxW3W7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRJHgAEst

From: Baokun Li <libaokun1@huawei.com>

Use the EXT4_P_TO_LBLK() macro to convert folio indexes to blocks to avoid
negative left shifts after supporting blocksize greater than PAGE_SIZE.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 73c1da90b604..d97ce88d6e0a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1162,8 +1162,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 	unsigned block_start, block_end;
 	sector_t block;
 	int err = 0;
-	unsigned blocksize = inode->i_sb->s_blocksize;
-	unsigned bbits;
+	unsigned int blocksize = i_blocksize(inode);
 	struct buffer_head *bh, *head, *wait[2];
 	int nr_wait = 0;
 	int i;
@@ -1172,12 +1171,12 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(to > folio_size(folio));
 	BUG_ON(from > to);
+	WARN_ON_ONCE(blocksize > folio_size(folio));
 
 	head = folio_buffers(folio);
 	if (!head)
 		head = create_empty_buffers(folio, blocksize, 0);
-	bbits = ilog2(blocksize);
-	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
+	block = EXT4_P_TO_LBLK(inode, folio->index);
 
 	for (bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start = block_end, bh = bh->b_this_page) {
-- 
2.46.1


