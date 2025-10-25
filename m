Return-Path: <linux-fsdevel+bounces-65614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AAFC089F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8A63BF888
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6F2DECB9;
	Sat, 25 Oct 2025 03:30:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC82C17A8;
	Sat, 25 Oct 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363015; cv=none; b=fgE3YOBqECT9oz4oJRSFhvJ+VfTLdhhzwYNi9LSirXHJXTq8TymczRvHb972hA0fNHPWMRgfcN5SUL1E+W47BsSnvr9+BA/5kzrUZyu+mSie4AL51ymGjtWuMlNiYMNhvGharMRNLzvmw9kzZYx3eDoNvr8qQvvDhoigxijLpKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363015; c=relaxed/simple;
	bh=B0yDL/dPmU/L+Joe5KnD2c3F3zFSvBdS0TON+hhaZ5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2Srnx8zE2RJerEByfu0lNJnFEOiEw7PueF56Op3sJcH26YouLEowOBq61i2w3Z6QezUgrcsJOD0BdaBqht7Sbqm3NPwdcB+mDAsy/hohT+kh9bD/sRtMb69UnBmVSsenXBbqsNRh6sb5vTp1HR6kCwK7vlBTwTWqmBVhJn+WDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcT0mKYzKHMPX;
	Sat, 25 Oct 2025 11:29:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C6C0C1A121C;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S22;
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
Subject: [PATCH 18/25] ext4: support large block size in mpage_map_and_submit_buffers()
Date: Sat, 25 Oct 2025 11:22:14 +0800
Message-Id: <20251025032221.2905818-19-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S22
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw48Wr18Ww47WF43Ar1DWrg_yoW8XF1fpF
	W5W3ykGFsY9r4I9F4IqF1DZrn7Ka92gF45ZFWSva4aqFy5Kr10grn5t3W8Za95JFyxXrW0
	vF1SkryxW3WxCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRJHwAAso

From: Baokun Li <libaokun1@huawei.com>

Use the EXT4_P_TO_LBLK/EXT4_LBLK_TO_P macros to complete the conversion
between folio indexes and blocks to avoid negative left/right shifts after
supporting blocksize greater than PAGE_SIZE.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d97ce88d6e0a..cbf04b473ae7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2289,15 +2289,14 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 	struct folio_batch fbatch;
 	unsigned nr, i;
 	struct inode *inode = mpd->inode;
-	int bpp_bits = PAGE_SHIFT - inode->i_blkbits;
 	pgoff_t start, end;
 	ext4_lblk_t lblk;
 	ext4_fsblk_t pblock;
 	int err;
 	bool map_bh = false;
 
-	start = mpd->map.m_lblk >> bpp_bits;
-	end = (mpd->map.m_lblk + mpd->map.m_len - 1) >> bpp_bits;
+	start = EXT4_LBLK_TO_P(inode, mpd->map.m_lblk);
+	end = EXT4_LBLK_TO_P(inode, mpd->map.m_lblk + mpd->map.m_len - 1);
 	pblock = mpd->map.m_pblk;
 
 	folio_batch_init(&fbatch);
@@ -2308,7 +2307,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			lblk = folio->index << bpp_bits;
+			lblk = EXT4_P_TO_LBLK(inode, folio->index);
 			err = mpage_process_folio(mpd, folio, &lblk, &pblock,
 						 &map_bh);
 			/*
-- 
2.46.1


