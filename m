Return-Path: <linux-fsdevel+bounces-54116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F0AFB5D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB0E3B6CFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6093A2D9791;
	Mon,  7 Jul 2025 14:23:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF72D879D;
	Mon,  7 Jul 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898180; cv=none; b=jUB8QT8QBPJ7lA5IyOwzWYJl8XVverZvaY/M9vz+KprWT8FLqgQf7/an5pSB2PmC+CyXqrjjy2InsIwcK0SuoGvPtUj9LtdsqJVaC+cyQ4VIzJjF2OSLMeidbFudNNxRnZP4kZ7MQjOAIUjrIrCLfRKvW8wCZhZN4f3W9Yf+S6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898180; c=relaxed/simple;
	bh=BYnrg8GfctL0IYNIxCV3Xbhk6Qmu8KmRU6hmRWk3rVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIkZdxL4aRYIO/BEQ7dkKR7xNCHrgbjY84YE2ObMnel1wJBLXdbkbkzfnE72yfFvCR+MX8Ll07f7NyfWSOy9cC06erGfTIymXwSccrbS/yv39BASQrrhYhrOJbUi/CixC2iK4fdaOVqHczfWdwr8Sg0PKvR6OIjO5dtHEe+R6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbRKZ1Rh3zKHMWF;
	Mon,  7 Jul 2025 22:22:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A21771A113F;
	Mon,  7 Jul 2025 22:22:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyQ22GtoNazLAw--.46745S6;
	Mon, 07 Jul 2025 22:22:56 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	naresh.kamboju@linaro.org,
	jiangqi903@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 02/11] ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
Date: Mon,  7 Jul 2025 22:08:05 +0800
Message-ID: <20250707140814.542883-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxyQ22GtoNazLAw--.46745S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UKr4DCFW3Gw1xuw47CFg_yoW8Jw17pF
	Z8Ka4kGFW8Zr909Fn7WFsxZr1xta4fGw4UXFW7Kw13XFy5Ar95KF47t34Y9F4ftrWkJ3yI
	qF48JFy5ua17AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUADGOUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

mpage_folio_done() should be a more appropriate place than
mpage_submit_folio() for updating the wbc->nr_to_write after we have
submitted a fully mapped folio. Preparing to make mpage_submit_folio()
allows to submit partially mapped folio that is still under processing.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 39d59274649c..a88ed7f51afc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2026,6 +2026,7 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
 {
 	mpd->start_pos += folio_size(folio);
+	mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 	folio_unlock(folio);
 }
 
@@ -2056,8 +2057,6 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & (len - 1);
 	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
-	if (!err)
-		mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 
 	return err;
 }
-- 
2.46.1


