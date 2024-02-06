Return-Path: <linux-fsdevel+bounces-10451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E09FE84B35F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85186B22920
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40612FF93;
	Tue,  6 Feb 2024 11:21:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC6B12D152
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218516; cv=none; b=GKq4xibsWRa90+RMNf0uRLeyXONps84PHFMdNujt24mlEILClSlaaOJNyeMsseMvz7upb+SB25TxLUPiyc0ZwFBABSqmWrjKBac0GO/M5MX3hKjRGBAjIGZDq+Bbcyv5r8km7wA4UfHVDA9vIEUo3NPlAx1VoPFpCkrgT4P/3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218516; c=relaxed/simple;
	bh=hyXJJ6hhmtLyDHUPOkw1GvU2c5nor7sucprHyDsi6J8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGuetQGVu041pZ+sQ57YfKbPYuOlv9Fx+7fBguWefve9TE1H8NEXSvCStPE647owY8YvSTyizta9JFgW4kJr5MInUFmGxFShQyIqNH0zv0y5+aNJDOhc3WxclTHlJa4bl3GwvDfNJT3HKz83IpOcefadhfR7rTblidn+L5b5V7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TTglM0YqtzXh8Z;
	Tue,  6 Feb 2024 19:20:15 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 0644A1400D5;
	Tue,  6 Feb 2024 19:21:47 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:46 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 07/11] mm: add folio_mc_copy()
Date: Tue, 6 Feb 2024 19:21:30 +0800
Message-ID: <20240206112134.1479464-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240206112134.1479464-1-wangkefeng.wang@huawei.com>
References: <20240206112134.1479464-1-wangkefeng.wang@huawei.com>
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
index 68ca71407177..8818aa5a1755 100644
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


