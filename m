Return-Path: <linux-fsdevel+bounces-8763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8983ABA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D471F2CD11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3717C0A1;
	Wed, 24 Jan 2024 14:26:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051B7A713;
	Wed, 24 Jan 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106391; cv=none; b=CkwE2z8c01h4XFx/Qy5y9H2u6FnPgu6/lz+iEkpFotL+MAV9WxpJmohs76ZaUG6ammYhR3SaDfNyHovdQs1h1XzznvPoMaCfxiYLqNjLq/WGV8/q/TDiM7hh82Oxn3tnHddZ4zgJimJ823fffjb0Sy2+FzmezXvoTnaZW3VBRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106391; c=relaxed/simple;
	bh=lPvpLliId+cA8aYHjC8ognT98Fz3rKIw47pkYuX9fn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O01c+c3oobLiKHsI6/aQ8q+Z4IZo5Eq7fQfoffBgafplFN3vcW6I7ik96wmH9C/jIr0NhG7Xa58rd7Mnfd61lOOL1cOG60cUyaFL7+vLZfEFSFxrpe/aFnDKxJq8fys4rgM8o5OEb7p1Year5Kbyo1eUFYVd/8T3u0TFaLv681E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TKmSx4xBfzsWHQ;
	Wed, 24 Jan 2024 22:25:21 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id BB34E14011A;
	Wed, 24 Jan 2024 22:26:24 +0800 (CST)
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
Subject: [PATCH v2 1/3] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
Date: Wed, 24 Jan 2024 22:28:55 +0800
Message-ID: <20240124142857.4146716-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142857.4146716-1-libaokun1@huawei.com>
References: <20240124142857.4146716-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

In [Link] Linus mentions that acquire/release makes it clear which
_particular_ memory accesses are the ordered ones, and it's unlikely
to make any performance difference, so it's much better to pair up
the release->acquire ordering than have a "wmb->rmb" ordering.

=========================================================
 update pagecache
 folio_mark_uptodate(folio)
   smp_wmb()
   set_bit PG_uptodate

 === ↑↑↑ STLR ↑↑↑ === smp_store_release(&inode->i_size, i_size)

 folio_test_uptodate(folio)
   test_bit PG_uptodate
   smp_rmb()

 === ↓↓↓ LDAR ↓↓↓ === smp_load_acquire(&inode->i_size)

 copy_page_to_iter()
=========================================================

Calling smp_store_release() in i_size_write() ensures that the data
in the page and the PG_uptodate bit are updated before the isize is
updated, and calling smp_load_acquire() in i_size_read ensures that
it will not read a newer isize than the data in the page. Therefore,
this avoids buffered read-write inconsistencies caused by Load-Load
reordering.

Link: https://lore.kernel.org/r/CAHk-=wifOnmeJq+sn+2s-P46zw0SFEbw9BSCGgp2c5fYPtRPGw@mail.gmail.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 include/linux/fs.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6bb10bbd7035..1cc1f3f08107 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -907,7 +907,8 @@ static inline loff_t i_size_read(const struct inode *inode)
 	preempt_enable();
 	return i_size;
 #else
-	return inode->i_size;
+	/* Pairs with smp_store_release() in i_size_write() */
+	return smp_load_acquire(&inode->i_size);
 #endif
 }
 
@@ -929,7 +930,12 @@ static inline void i_size_write(struct inode *inode, loff_t i_size)
 	inode->i_size = i_size;
 	preempt_enable();
 #else
-	inode->i_size = i_size;
+	/*
+	 * Pairs with smp_load_acquire() in i_size_read() to ensure
+	 * changes related to inode size (such as page contents) are
+	 * visible before we see the changed inode size.
+	 */
+	smp_store_release(&inode->i_size, i_size);
 #endif
 }
 
-- 
2.31.1


