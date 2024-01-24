Return-Path: <linux-fsdevel+bounces-8764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1D283ABA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A73286878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0F7C0B5;
	Wed, 24 Jan 2024 14:26:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7AF7A718;
	Wed, 24 Jan 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106391; cv=none; b=l/cyCXUPz7YEkH6o6AVeJgA989Df0zQptuot2hIe4wi/sT0SNmPkpxU78Va9/0AKlLYibYeUbu9FU4eFzjeIgsGp03gK1wwgRGRDX+hIj50d3bWvhD0s/LoFGJpQD5THPbizEC4L4wyUZLuds/IlGT9MnQXvF6FTXmMCunSLfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106391; c=relaxed/simple;
	bh=N2BkwODbR5p4I61Zd4giHOOLJ0sc4FCaSVpwgMLT51U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgJDpt3RL/RwtgO4t9ONXgJ2i2U7LrBa3raBv+lQgq7/nPkS4uwV+unKvP1f5FxmRrkqpRLzJok0AkVbMqdRmK30PRaCJAbYwn59MPh7z9CUFJRaqEHBfHrZXRTp7WEo+4fzHTpdxA0evWPXMFgEqu0bjx48iSzTYQscIiuX+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TKmS9199Cz1gy0X;
	Wed, 24 Jan 2024 22:24:41 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 6403114011F;
	Wed, 24 Jan 2024 22:26:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 22:26:24 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-fsdevel@vger.kernel.org>
CC: <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 2/3] Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
Date: Wed, 24 Jan 2024 22:28:56 +0800
Message-ID: <20240124142857.4146716-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142857.4146716-1-libaokun1@huawei.com>
References: <20240124142857.4146716-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


