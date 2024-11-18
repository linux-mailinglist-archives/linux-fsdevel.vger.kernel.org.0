Return-Path: <linux-fsdevel+bounces-35094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016339D1016
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17881F2360E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612C1AA1C6;
	Mon, 18 Nov 2024 11:45:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EA1A00F8;
	Mon, 18 Nov 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930322; cv=none; b=IGctFQph3MA5777HgMJt6qco4vW4xlpC1jFjDi2RRA5FxRVmOzTWEB0AtZjR4CyYBjBnTXxRBQFM3cgmi8rULZLnr9Y+JzeimcOJVOrOHgwL/0ZpVVXJ9Y1f8sq3SuyuZg0lJ9jGPwqelCdP0Eyw+0fHSBxVW6rKjQ24xgVbnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930322; c=relaxed/simple;
	bh=5kGt5YdPzQR7JjnloKlub9ZvkTDiI38fa29tAWFwlR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pttNn4bi4B6+4suQzKyyIjgu60BFLbSDYhCu0qahQwzRrjNv0yuMdCccV2l7pLDvWhb+Jxdo0InS47VRVvHRss3/KHTdQc5cGAFGfG8060eonnVq0vdzU20ysk9nIpSE7TFoYJFE/9THwSu08PjyrSZaj8pRbga4NkDmWFbElcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XsQlv5nt7z4f3jXs;
	Mon, 18 Nov 2024 19:44:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3F61C1A0568;
	Mon, 18 Nov 2024 19:45:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLEKDtn3fCKCA--.48005S15;
	Mon, 18 Nov 2024 19:45:17 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	agruenba@redhat.com,
	gfs2@lists.linux.dev,
	amir73il@gmail.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Cc: yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 11/11] fs: fix potential soft lockup when 'sb->s_inodes' has large number of inodes
Date: Mon, 18 Nov 2024 19:45:08 +0800
Message-Id: <20241118114508.1405494-12-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118114508.1405494-1-yebin@huaweicloud.com>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoLEKDtn3fCKCA--.48005S15
X-Coremail-Antispam: 1UD129KBjvJXoWxAw18GFWkWFyDXrWUuw47XFb_yoW5Cry7pF
	nIgFW3Xw48KayFgw4ftF1kWrn3ta4v9r4xtryfCr9xAayjy343tF1UAr17XFWrKF47Zr90
	qF48Cry3Ars3AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

If the memory is sufficient, a large number of inodes that do not
meet the conditions may exist in the 'sb->s_inodes' list when
evict_inodes()/invalidate_inodes() traverse the 'sb->s_inodes' list.
Then it maybe trigger soft lockup.
To solve potential soft lockup, move need_resched() check from tail
to head when traverse the 'sb->s_inodes' list.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/inode.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index b78895af8779..e865fc1f5a95 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -867,6 +867,21 @@ void evict_inodes(struct super_block *sb)
 again:
 	spin_lock(&sb->s_inode_list_lock);
 	sb_for_each_inodes_continue_safe(inode, next, &sb->s_inodes) {
+		/*
+		 * We can have a ton of inodes to evict at unmount time given
+		 * enough memory, check to see if we need to go to sleep for a
+		 * bit so we don't livelock.
+		 */
+		if (need_resched()) {
+			list_del(&cursor.i_sb_list);
+			list_add_tail(&cursor.i_sb_list, &inode->i_sb_list);
+			inode = &cursor;
+			spin_unlock(&sb->s_inode_list_lock);
+			cond_resched();
+			dispose_list(&dispose);
+			goto again;
+		}
+
 		if (atomic_read(&inode->i_count))
 			continue;
 
@@ -884,21 +899,6 @@ void evict_inodes(struct super_block *sb)
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
-
-		/*
-		 * We can have a ton of inodes to evict at unmount time given
-		 * enough memory, check to see if we need to go to sleep for a
-		 * bit so we don't livelock.
-		 */
-		if (need_resched()) {
-			list_del(&cursor.i_sb_list);
-			list_add(&cursor.i_sb_list, &inode->i_sb_list);
-			inode = &cursor;
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			goto again;
-		}
 	}
 	list_del(&cursor.i_sb_list);
 	spin_unlock(&sb->s_inode_list_lock);
@@ -926,6 +926,16 @@ void invalidate_inodes(struct super_block *sb)
 again:
 	spin_lock(&sb->s_inode_list_lock);
 	sb_for_each_inodes_continue_safe(inode, next, &sb->s_inodes) {
+		if (need_resched()) {
+			list_del(&cursor.i_sb_list);
+			list_add_tail(&cursor.i_sb_list, &inode->i_sb_list);
+			inode = &cursor;
+			spin_unlock(&sb->s_inode_list_lock);
+			cond_resched();
+			dispose_list(&dispose);
+			goto again;
+		}
+
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
@@ -940,15 +950,6 @@ void invalidate_inodes(struct super_block *sb)
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
-		if (need_resched()) {
-			list_del(&cursor.i_sb_list);
-			list_add(&cursor.i_sb_list, &inode->i_sb_list);
-			inode = &cursor;
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			goto again;
-		}
 	}
 	list_del(&cursor.i_sb_list);
 	spin_unlock(&sb->s_inode_list_lock);
-- 
2.34.1


