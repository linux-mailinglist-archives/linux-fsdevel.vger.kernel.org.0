Return-Path: <linux-fsdevel+bounces-27099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4902295E9D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0664A2810AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514384DFE;
	Mon, 26 Aug 2024 07:02:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326753FE4;
	Mon, 26 Aug 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655766; cv=none; b=MS9Nw5YLCwSG0ZGow/rF7PZy4aJAqtOliQ406ZkHNdgGrk3VtIWnNmjXQ+53iLQGJ4tusf0Bu1NJpi2Mi28RcdlEw3aZLhYJkoj0ZUuSLcwae/T1+3rMnzOBuimdkR4iMdG9HNK+SFY659297idnB3VNbW0me3DmqpeQM95ELug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655766; c=relaxed/simple;
	bh=B52qPwd50bZUm3igmSPbTUZbrwC2pA0lHykJcf+RZcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fz2vfZAQbPTQgnazeE9xsq8fAJiuOVJvpx20tTQljSZyXmyrrfk0O5KDu7oe7YvZjzbRIbjkt+rAY6b0z/4bMk+M5TH16tYTbphfQgT8+jCT2Q22/XYdO4d0qkB44yynE1+owHpBx8otH1xSRo4SAESa4b8S8XPmVrSxrnSEYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WshSn3FMHz1j7JH;
	Mon, 26 Aug 2024 15:02:33 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id C6C851A0188;
	Mon, 26 Aug 2024 15:02:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 15:02:41 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>
CC: <lizetao1@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH -next 1/3] mm: Support scope-based resource management for folio_lock/unlock
Date: Mon, 26 Aug 2024 15:10:34 +0800
Message-ID: <20240826071036.2445717-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826071036.2445717-1-lizetao1@huawei.com>
References: <20240826071036.2445717-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

By introducing the DEFINE_LOCK_GUARD_1 definition, it is possible to
lock and unlock of folio's lock based on scope. At the same time, the
use of folio_trylock is also supported.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 include/linux/pagemap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d9c7edb6422b..ed1831c115cc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1537,4 +1537,8 @@ unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
 {
 	return folio_size(folio) >> inode->i_blkbits;
 }
+
+DEFINE_LOCK_GUARD_1(folio, struct folio, folio_lock(_T->lock), folio_unlock(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(folio, _try, folio_trylock(_T->lock))
+
 #endif /* _LINUX_PAGEMAP_H */
-- 
2.34.1


