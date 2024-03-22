Return-Path: <linux-fsdevel+bounces-15068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151F886961
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 10:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BC228AD9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C132E822;
	Fri, 22 Mar 2024 09:36:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80D224ED;
	Fri, 22 Mar 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100186; cv=none; b=ofw93lK2Xy6pxhMgYXr0H3n2S0t7UwD9NZy7mJ5C1kI5xUYNYdDNbT/oAvGbNZuHUnelQg410wYXwlhx40iSSayiV2JxT8TUbzVRDpJMNRSw+rDUf6nE+LWKWPLi7Doq+6mlzuJd6UIrF/yUfMgMKb5vq6yzPfBiXWzX7PATJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100186; c=relaxed/simple;
	bh=ecB2yv4xVDWojcVvrnD4p1dguHQ3ccRU+epK/KdXcN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvQKfprkEzV4VwRqIIZw6y8F549E/rLNTSzigFuyYl8YEa1I9qrUkzHoYcGRvMaJVcN2ru84HKZ0wsQGEKqgCpTFGInv0qpPXv7RORBxiEjGBXNozCn1ggGDJrqW3pJgxBN7dkXdAUvOysIbRKvhl2j/DMApmfO+JYAo2UdgNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V1HFk6jJXz1h3SL;
	Fri, 22 Mar 2024 17:33:46 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id DAF6F140384;
	Fri, 22 Mar 2024 17:36:21 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 22 Mar
 2024 17:36:21 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 2/2] mm/readahead: don't decrease mmap_miss when folio has workingset flags
Date: Fri, 22 Mar 2024 17:35:55 +0800
Message-ID: <20240322093555.226789-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322093555.226789-1-liushixin2@huawei.com>
References: <20240322093555.226789-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200004.china.huawei.com (7.185.36.141)

If there are too many folios that are recently evicted in a file, then
they will probably continue to be evicted. In such situation, there is
no positive effect to read-ahead this file since it is only a waste of IO.

The mmap_miss is increased in do_sync_mmap_readahead() and decreased in
both do_async_mmap_readahead() and filemap_map_pages(). In order to skip
read-ahead in above scenario, the mmap_miss have to increased exceed
MMAP_LOTSAMISS. This can be done by stop decreased mmap_miss when folio
has workingset flags. The async path is not to care because in above
scenario, it's hard to run into the async path.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/filemap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8df4797c5287..753771310127 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3439,7 +3439,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		if (PageHWPoison(page + count))
 			goto skip;
 
-		(*mmap_miss)++;
+		if (!folio_test_workingset(folio))
+			(*mmap_miss)++;
 
 		/*
 		 * NOTE: If there're PTE markers, we'll leave them to be
@@ -3488,7 +3489,8 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	if (PageHWPoison(page))
 		return ret;
 
-	(*mmap_miss)++;
+	if (!folio_test_workingset(folio))
+		(*mmap_miss)++;
 
 	/*
 	 * NOTE: If there're PTE markers, we'll leave them to be
-- 
2.25.1


