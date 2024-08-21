Return-Path: <linux-fsdevel+bounces-26447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB79594F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220C51C21331
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58EB20FAB4;
	Wed, 21 Aug 2024 06:47:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F220FAAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222855; cv=none; b=L41h5YGPCv+8K3bviFJsIQVjSspe6koLtFgsLO5VX71EZ54RAPXVB0kP8x/nIjVBWqpfaBRo0mWe73EI7TAo17XW0NFOgPU1F7zBaikvBGA0aWHPcI5gEp3CZMkDdtgy4Wg5UlQuw6UClyd9bjGRNJuymMOvd4BTRIpl7CU4Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222855; c=relaxed/simple;
	bh=AuvQZ2MC8S6DLgjsStNe+D6za74WpZCrUCJ4oWJ5s2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B4D8jKMLn91u1Q0DPwABv+AOjFIeVJMsdFGEMF1riBFYb9AI+R8PmeP5k+6Aj9O6bCeLpnwrGldNPARwoA5kueft99EBW623/gOX3xaAGJrMw6w9HyinF2M9YXwcIMbPDqsT8I535vbFFBW2HzRiiX5NuNyefzDjRKhbDssQgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WpcMJ41YXzyRCb;
	Wed, 21 Aug 2024 14:47:08 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B6E41401F2;
	Wed, 21 Aug 2024 14:47:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 14:47:30 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] fs: use LIST_HEAD() to simplify code
Date: Wed, 21 Aug 2024 14:54:56 +0800
Message-ID: <20240821065456.2294216-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

list_head can be initialized automatically with LIST_HEAD()
instead of calling INIT_LIST_HEAD().

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e55ad471c530..31a9062cad7e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -774,12 +774,11 @@ EXPORT_SYMBOL(block_dirty_folio);
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
 {
 	struct buffer_head *bh;
-	struct list_head tmp;
 	struct address_space *mapping;
 	int err = 0, err2;
 	struct blk_plug plug;
+	LIST_HEAD(tmp);
 
-	INIT_LIST_HEAD(&tmp);
 	blk_start_plug(&plug);
 
 	spin_lock(lock);
-- 
2.34.1


