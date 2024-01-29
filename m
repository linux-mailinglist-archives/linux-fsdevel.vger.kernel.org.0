Return-Path: <linux-fsdevel+bounces-9310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6383FEE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E613CB224FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17251C30;
	Mon, 29 Jan 2024 07:09:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66804E1DD
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512194; cv=none; b=csrjehTXRVz8LPpCLtd4V8s00GvVw3UN00n6fi1DUOaGwZdqDaicqQxqD/v16Qu+9AiZI85ue1DuHf0xEHY2i6ujCg7ukqHuEyeuSqMuawDGOq7SrlEZf8sLC8t/TUjILyJYq9sEXhsBJc+4Ydp8VbqW8nsD1ctbOu4fX66zDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512194; c=relaxed/simple;
	bh=DX2lXcNhYKP7w4O8BfE3mMhNi9KvlISvzQ4hc3XUHIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEoE5AKV2krvBd+8I0PwwQCo6skcYkeNX92cvLnZwkWvCPlnY5lF9u4m2Uq3emE4Udga8rx8Z5yd9Mt6effz3xgq5DaaqQtyccxzNEoslkVXHgoSPWkifm57jV88/P/slkBPshWuWZQXwIfLpgKom5OCBaNKgrs/3sdBQ4W8pYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TNfSy54GRz1FJfX;
	Mon, 29 Jan 2024 15:05:22 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 757FE140336;
	Mon, 29 Jan 2024 15:09:49 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:09:48 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 5/9] mm: add folio_mc_copy()
Date: Mon, 29 Jan 2024 15:09:30 +0800
Message-ID: <20240129070934.3717659-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Add a variant of folio_copy() which use copy_mc_highpage() to support
machine check safe copy when folio copy.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h |  1 +
 mm/util.c          | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ac6b71cbdffb..fffa6025d8f9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1300,6 +1300,7 @@ void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
+int folio_mc_copy(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
 
diff --git a/mm/util.c b/mm/util.c
index 5faf3adc6f43..63e6e644eb5a 100644
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


