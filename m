Return-Path: <linux-fsdevel+bounces-51308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87843AD53EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8F317AE84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF8271443;
	Wed, 11 Jun 2025 11:29:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67025F7B7;
	Wed, 11 Jun 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641383; cv=none; b=fVIw8YOqCnH8oGgvER1I3pTB2OltufwZ5gODvT3yTRPbXDVwIi9kWbsXwwgODYXhmzUHgKcWOASvb1YBGgN4VUAZ3xseox/08oHcf2VQO5Oe3FCCCPABJyQVtK7UOjzZojd2QhA0S2otr7s1aqWohyKQUPGdcRe62qhbKse0/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641383; c=relaxed/simple;
	bh=aWFl6Wl3JHoXR2aAcYYUwJU4szeoESNVnGFjDgiiTUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T50ek3Q5DPiuQNr1od4QtbXICoHxQ3aCP4tpC2Hy62bc+FIVHQwWnrWVbqKU9tsGELlBPVzEP7w/b+MTU0g34hg2cNEw96ztxVbmbV8xSoSUwMjIZY+2BB+xxZUDjMshKIsagbEMHKi9HyeG/J+XU+3QYymddvjPKezCeVvTs1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bHNjc16LDzYQvvB;
	Wed, 11 Jun 2025 19:29:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2678D1A0C6F;
	Wed, 11 Jun 2025 19:29:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacOXaElofvDPOw--.32023S5;
	Wed, 11 Jun 2025 19:29:38 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 1/6] ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
Date: Wed, 11 Jun 2025 19:16:20 +0800
Message-ID: <20250611111625.1668035-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacOXaElofvDPOw--.32023S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UKr4xtFy3KFW5Gw1DGFg_yoW8Jw1UpF
	W5Ka4kWay8Xr9Igrn7WFsrZr1xtF95GF4UXFWfWw43WFy5ArykKF4jq34YvF43JrWkJ3yI
	qFs5JFy5uF17JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUIiiDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

mpage_folio_done() should be a more appropriate place than
mpage_submit_folio() for updating the wbc->nr_to_write after we have
submitted a fully mapped folio. Preparing to make mpage_submit_folio()
allows to submit partially mapped folio that is still under processing.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd..3a086fee7989 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2024,7 +2024,10 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 
 static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
 {
-	mpd->first_page += folio_nr_pages(folio);
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	mpd->first_page += nr_pages;
+	mpd->wbc->nr_to_write -= nr_pages;
 	folio_unlock(folio);
 }
 
@@ -2055,8 +2058,6 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & (len - 1);
 	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
-	if (!err)
-		mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 
 	return err;
 }
-- 
2.46.1


