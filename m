Return-Path: <linux-fsdevel+bounces-25581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9803994DA52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 05:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4AFB218E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 03:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9050113698E;
	Sat, 10 Aug 2024 03:42:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2161802B;
	Sat, 10 Aug 2024 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261365; cv=none; b=W2r9OcvqFOgnflAvqKwF08vg3p9lNdt73++kcZJFKFsschmbHJTtzvuKV8cIVRBFbtdpOseMs4P7vTA17jKx8smhIGvchkL5yJZqjpJb1CoffClZdy6P4tapk6JR8dpl6N6HySUwYn6AlDjeR/3e0TmyUtFzx/taL5wjjjHsQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261365; c=relaxed/simple;
	bh=bWiOZFESha6w2e8euh3cc5J5iNkTjLJHUyoFWKpq0sQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDjIrwba5oCYb92CzQ4TqX6EfBqS8FUFUAq6SKju4uOovxjbRIjUcdU4SkkC5J6RmkCT73LZCrbMYen+9q0ELD0ZPfarnvuRxjJ9liRP44fKrK0PzPUUyCNRRCfsu6qhsq2TSvwC5FWdua3+c7MvGEpR1pqT/OJnjEjkytqqmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wgmm26TP2zpSvb;
	Sat, 10 Aug 2024 11:41:22 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 21F15180AE5;
	Sat, 10 Aug 2024 11:42:37 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 10 Aug
 2024 11:42:36 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lixiaokeng@huawei.com>
Subject: [PATCH] fuse: fix race conditions on fi->nlookup
Date: Sat, 10 Aug 2024 11:42:09 +0800
Message-ID: <20240810034209.552795-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100024.china.huawei.com (7.221.188.41)

Lock on fi->nlookup is missed in fuse_fill_super_submount(). Add lock
on it to prevent race conditions.

Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
Cc: stable@vger.kernel.org
Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..2e220f245ceb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1593,7 +1593,9 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * that, though, so undo it here.
 	 */
 	fi = get_fuse_inode(root);
+	spin_lock(&fi->lock);
 	fi->nlookup--;
+	spin_unlock(&fi->lock);
 
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
-- 
2.33.0


