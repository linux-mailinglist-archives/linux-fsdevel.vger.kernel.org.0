Return-Path: <linux-fsdevel+bounces-9312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB1483FEEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C18285489
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C22253E01;
	Mon, 29 Jan 2024 07:09:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798D4E1CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512196; cv=none; b=nQtwXZdnvnQ3YtOl+DnPkpBG8RZ7g4bXpnG6fhnl+LizelK/kxiowwEJeHikd4nS5vC4pQpwTrfenGbsfwuFnw9giCSFgY3GG3vTJQoDci4oldpH+IP3icAechGFRgmuEHSnYUizZtTOhGgoywy7iZq6ffDnmkYWfnCEtbb/rEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512196; c=relaxed/simple;
	bh=bbmyxyFjVa9fP1NemqDtq9Hl8hBlzgorbI3pTpxsR7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoYOwAueM89ZQKcEIRAcwB/4ozogRUh0Ol4e2c1s86hOmZYXrSpjV0QKtHyE9/uzEuRcDX7umeB4ZhLhyUo2RASmGihPfS1zE8140fkAu/ub2AtXeA3wIaMNOVp4dPbCbZLh/cez9886y7n0tXVziL9VVmBfV7kP3j/uwV4lNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TNfY16qdFzNlmb;
	Mon, 29 Jan 2024 15:08:53 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 07984180079;
	Mon, 29 Jan 2024 15:09:52 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 15:09:51 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 9/9] fs: aio: add explicit check for large folio in aio_migrate_folio()
Date: Mon, 29 Jan 2024 15:09:34 +0800
Message-ID: <20240129070934.3717659-10-wangkefeng.wang@huawei.com>
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

Since large folio copy could spend lots of time and it is involved with
a cond_resched(), the aio couldn't support migrate large folio as it takes
a spin lock when folio copy, add explicit check for large folio and return
err directly.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 631e83eee5a1..372f22b85b11 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -411,6 +411,10 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	pgoff_t idx;
 	int rc = 0;
 
+	/* Large folio aren't supported */
+	if (folio_test_large(src))
+		return -EINVAL;
+
 	/* mapping->i_private_lock here protects against the kioctx teardown.  */
 	spin_lock(&mapping->i_private_lock);
 	ctx = mapping->i_private_data;
-- 
2.27.0


