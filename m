Return-Path: <linux-fsdevel+bounces-14936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1B881B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 04:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8AA1F2138C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 03:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22124C121;
	Thu, 21 Mar 2024 03:28:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07659B64A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991736; cv=none; b=OG6jXKLeug5H3wk1/KHWurrQOXd/iBcwfclvLNLuynfhcnElwt6hrNkzF9Qh6z7kdpAYLyWWUdPJpsJi1rxiVveiLuYoGMWJkxWfAufY2Oi7L0g/xMUqkpqvc9t7MLx8p8H5kv0v/pxQ4/A5DXm6mb1jii9AZV4zouX+kXsRObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991736; c=relaxed/simple;
	bh=luFjxc9UwTFQiKMIDWbDKcxLe5+j4OKbtLhckaGxBq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOkrG0kydJF3gjk4gdAShxX0I7svm10DBhlx/JDNMNnBQLTetrYqEcwxXb9sTMyPuAtjupGYHeLsC/ijXFuAi2LWVyf4N02bG1kST9WD1VZ85A2bI2cMxpW1SKkFG3Dl0aMvcQa1dc2x8sLA+ORGToPCYiONPXXhgPFR3PMdlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V0W8z1R7Qz1xs0W;
	Thu, 21 Mar 2024 11:26:59 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id CCADA1400CB;
	Thu, 21 Mar 2024 11:28:52 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:28:52 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v1 07/11] mm: add folio_mc_copy()
Date: Thu, 21 Mar 2024 11:27:43 +0800
Message-ID: <20240321032747.87694-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Add a variant of folio_copy() which use copy_mc_highpage() to support
machine check safe copy when folio copy.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h |  1 +
 mm/util.c          | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..bd1bc29c38e2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1312,6 +1312,7 @@ void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
+int folio_mc_copy(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
 
diff --git a/mm/util.c b/mm/util.c
index 669397235787..b186d84b28b6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -828,6 +828,26 @@ void folio_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_copy);
 
+int folio_mc_copy(struct folio *dst, struct folio *src)
+{
+	long nr = folio_nr_pages(src);
+	long i = 0;
+	int ret = 0;
+
+	for (;;) {
+		if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i))) {
+			ret = -EFAULT;
+			break;
+		}
+		if (++i == nr)
+			break;
+		cond_resched();
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(folio_mc_copy);
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 int sysctl_overcommit_ratio __read_mostly = 50;
 unsigned long sysctl_overcommit_kbytes __read_mostly;
-- 
2.27.0


