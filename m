Return-Path: <linux-fsdevel+bounces-35784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB19D84BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B66286ADF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB05E1B0F29;
	Mon, 25 Nov 2024 11:46:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BEC19CC3C;
	Mon, 25 Nov 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535196; cv=none; b=KZjEtd18XT4vAvQOJdrkB0+UDweCtCdl0sXjP6pNyyZ5m9+yXr/xniMLb7MfARihPQg0floPu4QhhMdQdm6fDbsFeJfPikCDMkuPuN2FxvaHHDNmPtW+j5BMFCpnxELt16yJ6QzgB/iN2KXFkDwMFmSXaGsfig6OPI2UNBczo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535196; c=relaxed/simple;
	bh=l3E2kS7eB0hLq8m5j7Rz9jHUGZaSwRtqvXsOQM0KZZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUsi6nenhPFTxrfq/8GzrLzW6rxA+M8yOBW+cMeYlxHQcd19IXrKwbTbk/kFljFXqM2LwfMTxWghFl+eGvV2qrvidgAuSnNguz3ya6FCdLkm/QSGYCwBj7/ETHlxa1hoIzN2KaA9sB13sSEFG1g8IfczxDyGvNfBYT1l1sfp3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XxkS31PVJz4f3n6H;
	Mon, 25 Nov 2024 19:46:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA3421A018D;
	Mon, 25 Nov 2024 19:46:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4eFY0RnNicrCw--.44046S11;
	Mon, 25 Nov 2024 19:46:30 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 7/9] ext4: make the writeback path support large folios
Date: Mon, 25 Nov 2024 19:44:17 +0800
Message-ID: <20241125114419.903270-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
References: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4eFY0RnNicrCw--.44046S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18CrWxJF4fJF1fCw1UGFg_yoW8AFyxpr
	W5K393CFs7Xr4akrsrtFn8Zr1xKayFgr47GFWxK39xXF15Jr1FkFyUt34vva1rJrZ7Gay8
	Xr4kCryrWa47AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
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
index 0ef41e264ee8..c0179b07d753 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1927,7 +1927,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 		len = size & (len - 1);
 	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
 	if (!err)
-		mpd->wbc->nr_to_write--;
+		mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 
 	return err;
 }
@@ -2150,7 +2150,6 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 
 	start = mpd->map.m_lblk >> bpp_bits;
 	end = (mpd->map.m_lblk + mpd->map.m_len - 1) >> bpp_bits;
-	lblk = start << bpp_bits;
 	pblock = mpd->map.m_pblk;
 
 	folio_batch_init(&fbatch);
@@ -2161,6 +2160,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
+			lblk = folio->index << bpp_bits;
 			err = mpage_process_folio(mpd, folio, &lblk, &pblock,
 						 &map_bh);
 			/*
@@ -2382,7 +2382,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
 	size_t len = folio_size(folio);
 
 	folio_clear_checked(folio);
-	mpd->wbc->nr_to_write--;
+	mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 
 	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(inode))
-- 
2.46.1


