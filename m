Return-Path: <linux-fsdevel+bounces-62456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65783B93D9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 03:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DE6445420
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 01:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589825D1FC;
	Tue, 23 Sep 2025 01:29:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35852405FD;
	Tue, 23 Sep 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590973; cv=none; b=oniG6qOw79P/ddEyj7mnX/3Wd9qq2aC9WAQjW3h1NQvJ2OuCvCBaWOd1V6pl4QHxleifPoHYY6EkoqHB4RH2vxVluanquiNNB0B8y3SlXdKGihaZJ0UbtDifrqT88ksil1B/qeNXi3rilZBJm5gj2urmW/Ky05xJ9+GWg5o3x3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590973; c=relaxed/simple;
	bh=xpHNl9uCs96ADDOmeKTxWjgPzyvdhOzL7M7eU8voDVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3FafHVC+GuTlfuzspor+U7fKsfJWvkIGJRRbNBMRfXEkfv05YTxzFpazZBwZ2i9IF++diRjErbw8NzC41Gnh9OyRzmGDlLRfZJaut5eQAfR8UOhDJiEV//ZXx33J9pK8rvWkmzgqUNKZklD53D0pvhgEFznfaeTbFm82gCEwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cW2Sv2KlpzYQtpy;
	Tue, 23 Sep 2025 09:29:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 776221A1326;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXKWHq99FoGYYGAg--.10941S10;
	Tue, 23 Sep 2025 09:29:24 +0800 (CST)
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
Subject: [PATCH 06/13] ext4: use EXT4_B_TO_LBLK() in mext_check_arguments()
Date: Tue, 23 Sep 2025 09:27:16 +0800
Message-ID: <20250923012724.2378858-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
References: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXKWHq99FoGYYGAg--.10941S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1fCFy3CrW5ur1rZry8Grg_yoW8Gr4xp3
	WIyFs5C3yqqa4Y9w409F1Iv348Ka1xGr47XrWfJr4UWay0kFyFgF1UKan8AFyjqrWkJ34r
	ZFn2kr17X345G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Switch to using EXT4_B_TO_LBLK() to calculate the EOF position of the
origin and donor inodes, instead of using open-coded calculations.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/move_extent.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 0f4b7c89edd3..6175906c7119 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -461,12 +461,6 @@ mext_check_arguments(struct inode *orig_inode,
 		     __u64 donor_start, __u64 *len)
 {
 	__u64 orig_eof, donor_eof;
-	unsigned int blkbits = orig_inode->i_blkbits;
-	unsigned int blocksize = 1 << blkbits;
-
-	orig_eof = (i_size_read(orig_inode) + blocksize - 1) >> blkbits;
-	donor_eof = (i_size_read(donor_inode) + blocksize - 1) >> blkbits;
-
 
 	if (donor_inode->i_mode & (S_ISUID|S_ISGID)) {
 		ext4_debug("ext4 move extent: suid or sgid is set"
@@ -526,6 +520,9 @@ mext_check_arguments(struct inode *orig_inode,
 			orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
+
+	orig_eof = EXT4_B_TO_LBLK(orig_inode, i_size_read(orig_inode));
+	donor_eof = EXT4_B_TO_LBLK(donor_inode, i_size_read(donor_inode));
 	if (orig_eof <= orig_start)
 		*len = 0;
 	else if (orig_eof < orig_start + *len - 1)
-- 
2.46.1


