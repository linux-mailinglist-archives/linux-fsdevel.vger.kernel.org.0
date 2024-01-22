Return-Path: <linux-fsdevel+bounces-8404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB5835E66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497A01F2425A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D639AEE;
	Mon, 22 Jan 2024 09:43:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD639AE7;
	Mon, 22 Jan 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916635; cv=none; b=p+zyD0lmti/BEmemUHEDzkQMM9r0vuGC3giPDYbPjB3mHdUmKgNa/UUHuZlp/rV/AAlTOFwl0lcAgHiSQaCGAE1aI3M00tZGK6b2CbSWpLUdN6AxQElxtnDv760TW3eOswGuQsb7s71RzA17/Hx81qtXObWYkZbNiVz9LZal4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916635; c=relaxed/simple;
	bh=N2BkwODbR5p4I61Zd4giHOOLJ0sc4FCaSVpwgMLT51U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qb9sBFWTuSoCaOt254PXmrJw46za2HqPqV41SaNsK4YOiIcZXPvVNEUITpDrbEWObYBHOzBqj+U4/8fg8f20QTkgM+qHO5zK+1Gm3gWz+XCBTZZR9RWf7A2Az50pQemYEcxdxGcXiE4rIMtGL28L0YkDoINswoTm2QGdomi2BBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJQJ41spfz1xmYn;
	Mon, 22 Jan 2024 17:43:00 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 807AE14066A;
	Mon, 22 Jan 2024 17:43:35 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 17:43:00 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-fsdevel@vger.kernel.org>
CC: <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH 2/2] Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
Date: Mon, 22 Jan 2024 17:45:36 +0800
Message-ID: <20240122094536.198454-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240122094536.198454-1-libaokun1@huawei.com>
References: <20240122094536.198454-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

This reverts commit e2c27b803bb6 ("mm/filemap: avoid buffered read/write
race to read inconsistent data"). After making the i_size_read/write
helpers be smp_load_acquire/store_release(), it is already guaranteed that
changes to page contents are visible before we see increased inode size,
so the extra smp_rmb() in filemap_read() can be removed.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 mm/filemap.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 142864338ca4..bed844b07e87 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2608,15 +2608,6 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			goto put_folios;
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
-		/*
-		 * Pairs with a barrier in
-		 * block_write_end()->mark_buffer_dirty() or other page
-		 * dirtying routines like iomap_write_end() to ensure
-		 * changes to page contents are visible before we see
-		 * increased inode size.
-		 */
-		smp_rmb();
-
 		/*
 		 * Once we start copying data, we don't want to be touching any
 		 * cachelines that might be contended:
-- 
2.31.1


