Return-Path: <linux-fsdevel+bounces-36792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93EA9E96AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E103283D7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD823314F;
	Mon,  9 Dec 2024 13:26:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392BD233153;
	Mon,  9 Dec 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750761; cv=none; b=VfeEkQR+Ms3bRwetGUtUKn1UnEhsvtzl3JEniYfTsVuDBpz/+8j/n5ibviZseLb3OGPPlQHoLTEFvu2Nff6DRr0QIPZjt7qbyoudQ1sawXeHQUFWMlltHAOkmmy/eTTenlnpcDULSH29MyPKXOhXNH3Nmd/Y88QPEpGrZBcnYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750761; c=relaxed/simple;
	bh=q5iRf9+iTy7eh/uc4yTUvIHuvCdako30zLorEZSu/tM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTPwmbFKIvPyDm4DB07hXnGzaxR7L0Srv9HO3m6rPsE72FhpQa3JpeKH/DAL0TrjjoTkZrku70KgyuzUHIo8iYfXYo2qdiL36oypD79RMv9/DXSXe+ojuNg/NsVpfQy4N26s90nmm2rv5720EsaDub6wWTqTuT5erp/HVv2YMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y6N0R2QZwz1JDvw;
	Mon,  9 Dec 2024 21:25:43 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AC0A14011D;
	Mon,  9 Dec 2024 21:25:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Dec
 2024 21:25:55 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<akpm@linux-foundation.org>, <Liam.Howlett@Oracle.com>,
	<lokeshgidra@google.com>, <lorenzo.stoakes@oracle.com>, <rppt@kernel.org>,
	<aarcange@redhat.com>, <ruanjinjie@huawei.com>, <Jason@zx2c4.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 2/2] mm, rmap: handle anon_vma_fork() NULL check inline
Date: Mon, 9 Dec 2024 21:25:49 +0800
Message-ID: <20241209132549.2878604-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209132549.2878604-1-ruanjinjie@huawei.com>
References: <20241209132549.2878604-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Check the anon_vma of pvma inline so we can avoid the function call
overhead if the anon_vma is NULL.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/rmap.h | 12 +++++++++++-
 mm/rmap.c            |  6 +-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 683a04088f3f..9ddba9b23a1c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -154,7 +154,17 @@ void anon_vma_init(void);	/* create anon_vma_cachep */
 int  __anon_vma_prepare(struct vm_area_struct *);
 void unlink_anon_vmas(struct vm_area_struct *);
 int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *);
-int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
+
+int __anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
+static inline int anon_vma_fork(struct vm_area_struct *vma,
+				struct vm_area_struct *pvma)
+{
+	/* Don't bother if the parent process has no anon_vma here. */
+	if (!pvma->anon_vma)
+		return 0;
+
+	return __anon_vma_fork(vma, pvma);
+}
 
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4ea29a7..06e9b68447c2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -331,16 +331,12 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
  * the corresponding VMA in the parent process is attached to.
  * Returns 0 on success, non-zero on failure.
  */
-int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
+int __anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 {
 	struct anon_vma_chain *avc;
 	struct anon_vma *anon_vma;
 	int error;
 
-	/* Don't bother if the parent process has no anon_vma here. */
-	if (!pvma->anon_vma)
-		return 0;
-
 	/* Drop inherited anon_vma, we'll reuse existing or allocate new. */
 	vma->anon_vma = NULL;
 
-- 
2.34.1


