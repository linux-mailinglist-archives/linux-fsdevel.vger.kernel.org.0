Return-Path: <linux-fsdevel+bounces-48699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF46AB2FFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2D317962D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C40258CDE;
	Mon, 12 May 2025 06:44:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03B2561C3;
	Mon, 12 May 2025 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032296; cv=none; b=FLKt4J2N0810gOHTzH5p5xmm9WVhg9P92Lo0Gq6g2OuQuSo0a6+S6fjhG5Px710ezes9Z2c/ZoIhQawNIYMJiWL+ga81nWzJfwW3Q0eJJ8JcOVgMKtyfY2MfIObckt76H+rLYVM2qxt+duqdrvDYMXDSZYbSawWi/JMReIjDo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032296; c=relaxed/simple;
	bh=kx/9QQDFlvk6fFfZRVk50AFFkVVs+zDEOe2SMg+WPBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxd6Mz1Fqdsf50KuvYJQ+lyhcRAAcwmHOjtUR44l2RLGmVcJFuXGEyabROtg/x/x1n5VkRNAbgKB/u9FQtycbNOv/9up83utd4t18gpmLQZjxg+5d8tOI7+2Aw/yJBkTfQAnq9KlDRhqWcJvP7R9Xsb1zSVlAM2ao/d1MCPzIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZwqpL5lcRz4f3jXh;
	Mon, 12 May 2025 14:44:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 76E001A01A3;
	Mon, 12 May 2025 14:44:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DXmCFoxF6sMA--.62010S10;
	Mon, 12 May 2025 14:44:51 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 6/8] ext4: make the writeback path support large folios
Date: Mon, 12 May 2025 14:33:17 +0800
Message-ID: <20250512063319.3539411-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2DXmCFoxF6sMA--.62010S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18CrWxJF4fJF1fCw1UGFg_yoW8AFyxpF
	W5K395CFs7Wr4akrsrtFn8Zr1xKa4Fgr4UGFWxK3y3XF15Ar1FkFyjqa4vva1rJryxGayx
	Xr40kFy8W3W7AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUo73vUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In mpage_map_and_submit_buffers(), the 'lblk' is now aligned to
PAGE_SIZE. Convert it to be aligned to folio size. Additionally, modify
the wbc->nr_to_write update to reduce the number of pages in a single
folio, ensuring that the entire writeback path can support large folios.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3e962a760d71..29eccdf8315a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1942,7 +1942,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 		len = size & (len - 1);
 	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
 	if (!err)
-		mpd->wbc->nr_to_write--;
+		mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 
 	return err;
 }
@@ -2165,7 +2165,6 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 
 	start = mpd->map.m_lblk >> bpp_bits;
 	end = (mpd->map.m_lblk + mpd->map.m_len - 1) >> bpp_bits;
-	lblk = start << bpp_bits;
 	pblock = mpd->map.m_pblk;
 
 	folio_batch_init(&fbatch);
@@ -2176,6 +2175,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
+			lblk = folio->index << bpp_bits;
 			err = mpage_process_folio(mpd, folio, &lblk, &pblock,
 						 &map_bh);
 			/*
@@ -2397,7 +2397,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
 	size_t len = folio_size(folio);
 
 	folio_clear_checked(folio);
-	mpd->wbc->nr_to_write--;
+	mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 
 	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(inode))
-- 
2.46.1


