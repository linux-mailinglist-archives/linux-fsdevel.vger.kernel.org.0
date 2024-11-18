Return-Path: <linux-fsdevel+bounces-35091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE929D1011
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A25F1F2326B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D61A9B2B;
	Mon, 18 Nov 2024 11:45:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F11A0B0C;
	Mon, 18 Nov 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930321; cv=none; b=CyE3v5iSFufWtekSMUScAnwDFzqy7fTQjpVOJ/gSTl22WyMvblKVOioD0AkzDNkaLaTxsqWr/fOlR15Yc4QOvHgxWbrWadeSD427jPQQdcr+etto5RXP9jjh53+Kms08tW3XfiJt+DuUoYARt4yrNaQFJxyCjqSfZiRI+xeEoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930321; c=relaxed/simple;
	bh=bVSQkyJzzpOn0f9mMGo+Q10YPGNGo/OVRmZEMp3yFxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDptvAd2XTggNLhG8gIHMGMyzKjxrjb3ACMpG8TvlNr0p2+tQZfOyYS53JwdnGV5OFn3QRcpX8/iLNx8108Iolx/b4DKBhLd5OcUMixVfIETFM6JlRkIBiYrnpzpkCw7clhMbAjfuEzqLwN8Sze6oK9y2dMaDbKU8ORLaU6WaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsQls4ByNz4f3nZr;
	Mon, 18 Nov 2024 19:44:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E6A721A0196;
	Mon, 18 Nov 2024 19:45:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLEKDtn3fCKCA--.48005S13;
	Mon, 18 Nov 2024 19:45:16 +0800 (CST)
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
Subject: [PATCH 09/11] landlock: use sb_for_each_inodes API
Date: Mon, 18 Nov 2024 19:45:06 +0800
Message-Id: <20241118114508.1405494-10-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnzoLEKDtn3fCKCA--.48005S13
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1UWw13Zr47Gr47KrWruFg_yoW3GrbEkF
	18AF4Uur13ZrnagwsYyanavF9a9w1rGr4Uur97KF1DAwnIvF98tw4xtF95Zry3ua17tas8
	WFnagFy3K397KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jIPfQUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Use sb_for_each_inodes API foreach super_block->s_inodes.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 security/landlock/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index dd9a7297ea4e..ccb7951f1404 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1217,7 +1217,7 @@ static void hook_sb_delete(struct super_block *const sb)
 		return;
 
 	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	sb_for_each_inodes(inode, &sb->s_inodes) {
 		struct landlock_object *object;
 
 		/* Only handles referenced inodes. */
-- 
2.34.1


