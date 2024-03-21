Return-Path: <linux-fsdevel+bounces-14939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC3881B84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 04:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D59283BBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 03:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF379FD;
	Thu, 21 Mar 2024 03:29:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011AEC2E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991739; cv=none; b=R6fh1JWAXsqkkEvgVW0mryRQVDyEmvwg5C2OMfYvd1Ml0q5XvJK3TDszeftDhYRarrfmqzuAw17flzGRSHoF05W1BfwVfzMoQa3wokPXBDooKsf7vZ0jD6LXA3s5pPfb/WwXXtljBRwjaflEnnlm2TFxDMKpAhuARvLVU0zr3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991739; c=relaxed/simple;
	bh=xdL+4/8DuyNmmzkWOPnrWShiRvPm+fr2vL0bTnQZeUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO4OszrtQtSFGT4XgXIbHV/Gdfh3QxqDyCZmtnBi4u0ykAmcV5PbwvXPU06a/BI/c1vFsbr9oUlqNhvc8pzl4i6vnN1kPKS1r4v/QfscLOsMM9R/5fUMK4MMkFcTXRL+Hqj/KDuZY/53iKoeOn983sPyg4gzdMqAFi2LOjWFqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V0W922JF8z1xsC2;
	Thu, 21 Mar 2024 11:27:02 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id EA6431A0172;
	Thu, 21 Mar 2024 11:28:55 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:28:55 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v1 11/11] fs: aio: add explicit check for large folio in aio_migrate_folio()
Date: Thu, 21 Mar 2024 11:27:47 +0800
Message-ID: <20240321032747.87694-12-wangkefeng.wang@huawei.com>
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

Since large folio copy could spend lots of time and it is involved with
a cond_resched(), the aio couldn't support migrate large folio as it takes
a spin lock when folio copy, add explicit check for large folio and return
err directly.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 9783bb5d81e7..0391ef58c564 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -411,6 +411,10 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	pgoff_t idx;
 	int rc = 0;
 
+	/* Large folios aren't supported */
+	if (folio_test_large(src))
+		return -EINVAL;
+
 	/* mapping->i_private_lock here protects against the kioctx teardown.  */
 	spin_lock(&mapping->i_private_lock);
 	ctx = mapping->i_private_data;
-- 
2.27.0


