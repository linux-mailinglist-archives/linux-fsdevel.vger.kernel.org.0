Return-Path: <linux-fsdevel+bounces-8403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F615835E64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2790F2860B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FF39FDE;
	Mon, 22 Jan 2024 09:43:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578F39FD3;
	Mon, 22 Jan 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916619; cv=none; b=fsNsSophfg12vJ0k0qFq4je5vJJRxwjnlY1dWO6DrYGfy8FLp9fIxwdnnijOOkY3ECDdckIWmxVxAHBahb5sChcN//+oueFwVIGmn2BiutvSkEaL7RGeCyZS4+wGEYCGdvRSOjICLRBzfj5xGMp6EnPGh1YhZZrLLI6+OgHNfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916619; c=relaxed/simple;
	bh=yGNLyz21m6wfgW6bm0tKN7rje1DaSGXW1t5BN/TxSWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBGt/Q2pX5AHCd1kpLNzccAGRrCkgjWTEJPk9oqb4A4DNhknf13Ovd6x8q+b/Lx6UiInUXLchI+vjObN21O77yktJziwXjpvsKk1RcIIb7aVloWIy4BhII1vlAn57KvUNRrIYVEtR8KqOnDwg6yW4qztMe/cPAcI2PaKvUzLW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TJQJL23gnz1wnCd;
	Mon, 22 Jan 2024 17:43:14 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B5C71400DD;
	Mon, 22 Jan 2024 17:43:20 +0800 (CST)
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
Subject: [PATCH 1/2] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
Date: Mon, 22 Jan 2024 17:45:35 +0800
Message-ID: <20240122094536.198454-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240122094536.198454-1-libaokun1@huawei.com>
References: <20240122094536.198454-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

In [Link] linus mentions that acquire/release makes it clear which
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
index 06ecccbb5bfe..077849bfe89a 100644
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


