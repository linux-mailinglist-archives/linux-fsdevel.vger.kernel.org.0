Return-Path: <linux-fsdevel+bounces-15283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A988BAC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 07:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050A1B21578
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B412F5A8;
	Tue, 26 Mar 2024 06:51:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83E839E4;
	Tue, 26 Mar 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435860; cv=none; b=EflkQFVWyY547fpX8WtlhMKqv6GrWukcu2xkJBgm8zARf5Gz2qrKV8BpF0bWv1G1Dfl3BRbVGy8Bn6ik1VK/XC4VUTp8fa+P3ACI+a9IDhluTNJCKFUvumWsdW3F2uYdMIDZPBR8Sft6ippzt2hb3ZicuNhzdemvSSQF2ctNp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435860; c=relaxed/simple;
	bh=/deAQ2wyhd50qHcyNPfQ1jy/g3euGnoZ/Moi7tOIy4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfNJqPnjO/lXJqMLm9j6iCrsNWQXvFH5DEAbrtv+TNqBt6qovG9DWoyPVYD1mfjsO5UGpwVky+RjmBTodvw7fbma9xiMpQ15NJdIboFMgT+rmCTYe9dJiwKMC7vUxuMiDpozdX3WPpQhxlJcCRprMGjqrTSXwrA5YQeCJj4Yn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V3gNp0L0KzXjlK;
	Tue, 26 Mar 2024 14:48:10 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 64C5A1400DD;
	Tue, 26 Mar 2024 14:50:55 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 26 Mar
 2024 14:50:54 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3] mm/filemap: don't decrease mmap_miss when folio has workingset flag
Date: Tue, 26 Mar 2024 14:50:26 +0800
Message-ID: <20240326065026.1910584-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322093555.226789-3-liushixin2@huawei.com>
References: <20240322093555.226789-3-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd200004.china.huawei.com (7.185.36.141)

If there are too many folios that are recently evicted in a file, then
they will probably continue to be evicted. In such situation, there is
no positive effect to read-ahead this file since it is only a waste of IO.

The mmap_miss is increased in do_sync_mmap_readahead() and decreased in
both do_async_mmap_readahead() and filemap_map_pages(). In order to skip
read-ahead in above scenario, the mmap_miss have to increased exceed
MMAP_LOTSAMISS. This can be done by stop decreased mmap_miss when folio
has workingset flag. The async path is not to care because in above
scenario, it's hard to run into the async path.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
v2->v3: Update the title and comment. And add reviewed-by from Jan.

Andrew, please update patch[2] with this new patch, thanks.

 mm/filemap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8df4797c5287..780aad026b26 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3439,7 +3439,15 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		if (PageHWPoison(page + count))
 			goto skip;
 
-		(*mmap_miss)++;
+		/*
+		 * If there are too many folios that are recently evicted
+		 * in a file, they will probably continue to be evicted.
+		 * In such situation, read-ahead is only a waste of IO.
+		 * Don't decrease mmap_miss in this scenario to make sure
+		 * we can stop read-ahead.
+		 */
+		if (!folio_test_workingset(folio))
+			(*mmap_miss)++;
 
 		/*
 		 * NOTE: If there're PTE markers, we'll leave them to be
@@ -3488,7 +3496,9 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	if (PageHWPoison(page))
 		return ret;
 
-	(*mmap_miss)++;
+	/* See comment of filemap_map_folio_range() */
+	if (!folio_test_workingset(folio))
+		(*mmap_miss)++;
 
 	/*
 	 * NOTE: If there're PTE markers, we'll leave them to be
-- 
2.25.1


