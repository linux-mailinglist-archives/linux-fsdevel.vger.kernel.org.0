Return-Path: <linux-fsdevel+bounces-62707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905ECB9E58E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 11:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F34D3A4618
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233B2F1FEA;
	Thu, 25 Sep 2025 09:27:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0A2EFD9E;
	Thu, 25 Sep 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792439; cv=none; b=q8NJtr26A0FEDl3MXQKNuaDTxtkKoZVrESLtkgflInX5Rkgy77M3hRASjdFx6D32G0nyeWMixwSYRg7UoW55rKDMJ+pjn5VefglUuHf0/DCZWUYUiDBs0OeJmfNZdR+1+ZqcZNhvZovAFegsQnmBSuxT+dJYv5FzpDnZzLQNPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792439; c=relaxed/simple;
	bh=CtdQNPah8fCyg9jKRCfLDnjPdu7OGL75A8hQuLzLkR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOb4hbxbuaFcvjrj1n13wR2DFD+cxbW7T9QokHeyRIHvo95EhwDYSiJWIt+m/BHbwZ5q4Clc9OiZuFmdSjgczkzDY8gVo8+lMPip8UX1rzq43lTCiisYsMit87XqRsanXuZtHnEfAPWCxguz6ZZXxQ60q2uqEG3bx8QKhdp/jc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXSz65XfDzKHN57;
	Thu, 25 Sep 2025 17:26:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE5BA1A1E42;
	Thu, 25 Sep 2025 17:27:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgD3CGHeCtVovAkNAw--.52999S13;
	Thu, 25 Sep 2025 17:27:06 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 09/13] ext4: rename mext_page_mkuptodate() to mext_folio_mkuptodate()
Date: Thu, 25 Sep 2025 17:26:05 +0800
Message-ID: <20250925092610.1936929-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3CGHeCtVovAkNAw--.52999S13
X-Coremail-Antispam: 1UD129KBjvJXoW7Jr1DtF17ur4kWw1Dtw45GFg_yoW8Jr4rpF
	y7Ca98trW8Zw1xuwn7JFnrZr43t3y7Kr4UWFWfGw1SkFy3tFy0gF4UKa15AFWFgrW8Jw4r
	uF4fKr1jqayUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

mext_page_mkuptodate() no longer works on a single page, so rename it to
mext_folio_mkuptodate().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/move_extent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 0191a3c746db..2df6072b26c0 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -165,7 +165,7 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 }
 
 /* Force folio buffers uptodate w/o dropping folio's lock */
-static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
+static int mext_folio_mkuptodate(struct folio *folio, size_t from, size_t to)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t block;
@@ -358,7 +358,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 data_copy:
 	from = offset_in_folio(folio[0],
 			       orig_blk_offset << orig_inode->i_blkbits);
-	*err = mext_page_mkuptodate(folio[0], from, from + replaced_size);
+	*err = mext_folio_mkuptodate(folio[0], from, from + replaced_size);
 	if (*err)
 		goto unlock_folios;
 
-- 
2.46.1


