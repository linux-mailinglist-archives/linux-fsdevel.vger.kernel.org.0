Return-Path: <linux-fsdevel+bounces-63879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1BBD126F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7CB3BF20B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 01:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CEE2F7AB1;
	Mon, 13 Oct 2025 01:52:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECBD2F5487;
	Mon, 13 Oct 2025 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320374; cv=none; b=iiFSqb/jfSzAIXYEf1LhsZWrbSCbBvHyeD1tZeq/z5FK3L2Jy9OcQllbMnntHM6fqLNo95vEJMRooda8UqlF1Me5rCf1G8axQUXapNpkqziHxhValbezFfot+2RuwsD++8+/STpAJuqJEJkE5kD0DWv60+KlXGQh49iXY077c2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320374; c=relaxed/simple;
	bh=q8mg2kuq2sHXCI6ihLB3DjnwFpvHDG62+/A3Yw/8XG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7qXE38xLuHBarAm2nVCISNTYo3q8Zzu2QFntjF8vpW7FiKwCHQpAdYFV9CcK7Y3N1xEi/i9ZpFaXAoIQjcvBaAwfgbJVYP7vVwVM8DpgDXeSU2v1mX8PEfVfyyu3H32yBSm8eKodMCeEIWgBMdxthDLF6cjQIA3XxMhV06UCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4clL1s2plvzYQtnf;
	Mon, 13 Oct 2025 09:52:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 03B8A1A133D;
	Mon, 13 Oct 2025 09:52:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UVfW+xoNhu7AA--.53067S12;
	Mon, 13 Oct 2025 09:52:39 +0800 (CST)
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
Subject: [PATCH v4 08/12] ext4: rename mext_page_mkuptodate() to mext_folio_mkuptodate()
Date: Mon, 13 Oct 2025 09:51:24 +0800
Message-ID: <20251013015128.499308-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
References: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UVfW+xoNhu7AA--.53067S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Jr1DtF17ur4kWw1Dtw45GFg_yoW8JF13pF
	y7Ca98trW8Zw1xuwn7JFnrZr45tay7Kr4UWFWfGw1SkFy7tFy0gF1UKa15ZFWFgFWkJrs5
	uF4fKr1jqayUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

mext_page_mkuptodate() no longer works on a single page, so rename it to
mext_folio_mkuptodate().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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


