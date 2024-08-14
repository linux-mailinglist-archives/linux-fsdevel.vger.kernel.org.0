Return-Path: <linux-fsdevel+bounces-25897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CC9517CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB30D284EF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F271598F4;
	Wed, 14 Aug 2024 09:36:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD4157480;
	Wed, 14 Aug 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628199; cv=none; b=QgVzQlI6QQdjLziwfsQW6BAXQLHfyZhGUefdtT1GoORhcL+tzZ4ZJp2oz2ZV4NnabMalHqc2cVc49fcwyLDM55x42nWFlYPquOZ22AN0SSJefRQN34UVm7U77QBjnHsrY4q7X/gQkkJz646SBjOU6PGi9jOhfzbSttaUgll6SA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628199; c=relaxed/simple;
	bh=69RrlcOgLAlXVu8vt6tr+Q75bTEVVTKF+Lyjw+E3BDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hjBClnGjo8o+p1rbYMYUaFLw+eFhkiRdqaW1ii8rkXcCUzbxzfysNqLRyV4vFUw9sLSnwes0KyAjli3VjD81LnPonKPgidavjwmAemVI0Ty2A0ihd3gq5F7NtbMEjJZZrC7owy+S9gwgV/8BqeAfiptbHECehUhkLfsFlMf7DzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WkNLm0VKMzQpnp;
	Wed, 14 Aug 2024 17:32:00 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 652EC1400C9;
	Wed, 14 Aug 2024 17:36:34 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 14 Aug
 2024 17:36:33 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lixiaokeng@huawei.com>
Subject: [PATCH] fuse: add fast path for fuse_range_is_writeback
Date: Wed, 14 Aug 2024 17:36:00 +0800
Message-ID: <20240814093600.216757-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

In some cases, the fi->writepages may be empty. And there is no need
to check fi->writepages with spin_lock, which may have an impact on
performance due to lock contention. For example, in scenarios where
multiple readers read the same file without any writers, or where
the page cache is not enabled.

Also remove the outdated comment since commit 6b2fb79963fb ("fuse:
optimize writepages search") has optimize the situation by replacing
list with rb-tree.

Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..59c911b61000 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -448,9 +448,6 @@ static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
 
 /*
  * Check if any page in a range is under writeback
- *
- * This is currently done by walking the list of writepage requests
- * for the inode, which can be pretty inefficient.
  */
 static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
 				   pgoff_t idx_to)
@@ -458,6 +455,9 @@ static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	bool found;
 
+	if (RB_EMPTY_ROOT(&fi->writepages))
+		return false;
+
 	spin_lock(&fi->lock);
 	found = fuse_find_writeback(fi, idx_from, idx_to);
 	spin_unlock(&fi->lock);
-- 
2.33.0


