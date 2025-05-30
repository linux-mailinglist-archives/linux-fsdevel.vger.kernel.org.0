Return-Path: <linux-fsdevel+bounces-50143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20063AC8849
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C601881A4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470B120D51C;
	Fri, 30 May 2025 06:41:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3311F4C85;
	Fri, 30 May 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587294; cv=none; b=ejfouJnobyk7oLEhAG2cdLJPCYq8dVrCudfU1xDyEZeiG/nXx/nl4Vs6uj+fRqebuM1reUUUdgFG/0wfy84qOCPYxb3P1srDnp+UA6/ecefPjAay7LKR3UwlBu3nKMBWNVjFq5s+yiPW7X8a1JLKKdEOy9pRW80I7MOBsu+/r6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587294; c=relaxed/simple;
	bh=Ll/nhb4kIGJWBtI5NJo2WY9sphr54tDj2J46vfjmWAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrRw38r7TnWjijDvbs966RdUyNzrJy10LVZYtFWD2fPNBrN9ilt2iEra85aluwIMRu35eGZAyZVvchCRp9BjLUDZXBODytwIvMyKTAqZ/kQRVDGKkOjtvyYEjj9uX06HSpqH4pim9eOfr9hENlDmh9YCCbMSpUApSQjP6WFd5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b7tth08tQzKHMc3;
	Fri, 30 May 2025 14:41:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6CDD21A1A22;
	Fri, 30 May 2025 14:41:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8PUzlo_wXRNw--.6893S6;
	Fri, 30 May 2025 14:41:30 +0800 (CST)
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
Subject: [PATCH 2/5] ext4: correct the reserved credits for extent conversion
Date: Fri, 30 May 2025 14:28:55 +0800
Message-ID: <20250530062858.458039-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl8PUzlo_wXRNw--.6893S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kAw4fJFy3WFW5Jr18Xwb_yoW8Gr4fpF
	nxGFykWr18ua4kua1S93ZrAF1ruay8C3yUJF4fCw1DXa98Grn2gF1qgw1Yy3WUGrWxJrW5
	ZF47CryDu3W3Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now, we reserve journal credits for converting extents in only one page
to written state when the I/O operation is complete. This is
insufficient when large folio is enabled.

Fix this by reserving credits for converting up to one extent per block in
the largest 2MB folio, this calculation should only involve extents index
and leaf blocks, so it should not estimate too many credits.

Fixes: 7ac67301e82f ("ext4: enable large folio for regular file")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5ef34c0c5633..d35c07c1dcac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2808,12 +2808,12 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	mpd->journalled_more_data = 0;
 
 	if (ext4_should_dioread_nolock(inode)) {
+		int bpf = ext4_journal_blocks_per_folio(inode);
 		/*
 		 * We may need to convert up to one extent per block in
-		 * the page and we may dirty the inode.
+		 * the folio and we may dirty the inode.
 		 */
-		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
-						PAGE_SIZE >> inode->i_blkbits);
+		rsv_blocks = 1 + ext4_ext_index_trans_blocks(inode, bpf);
 	}
 
 	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-- 
2.46.1


