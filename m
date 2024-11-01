Return-Path: <linux-fsdevel+bounces-33407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B499B8A11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 04:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAEE1F226C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 03:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F9D144304;
	Fri,  1 Nov 2024 03:48:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095E4C79;
	Fri,  1 Nov 2024 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432892; cv=none; b=MgLZPt6ta6wCvHze9kxg5y08xv6DgYL1yN4yVl2b1OplyX7TCzIGseS/wULn2jnOg9cTQKSjnvC+bpQC/LRRy8q1T9nhl3tUKkORls8GGwRRKBI82pbk+Km8GWS92KXcZRfpMx6YxpsKt0rXsa+Iz9cwvvwpYa2CkBDN4YeOrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432892; c=relaxed/simple;
	bh=/8DGfkrX/uyHXqf8uX35ZAlWorNNEDJzm6qaD4+bFVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OitQiMwcl4vlsXCwkND4gy9XonYGpql9VCePYQGfv9k8OMsiymU5IENBXSECGeqkfJ3eT/u/Lo74ll+SLK057gSNEjpZXf160GTQNUbIDXnlwCZVZHYuEAHKwjpbGGdrBR9vVUnXR8G8qRnJJZBRwW/CcAnYGmaHBWLCB04HdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XfmxH6FFczpXjJ;
	Fri,  1 Nov 2024 11:46:11 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 1940C18006C;
	Fri,  1 Nov 2024 11:48:07 +0800 (CST)
Received: from huawei.com (10.44.142.84) by kwepemm600002.china.huawei.com
 (7.193.23.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Nov
 2024 11:48:06 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <holzheu@linux.vnet.ibm.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] fs/proc: Fix compile warning about variable 'vmcore_mmap_ops'
Date: Fri, 1 Nov 2024 11:43:49 +0800
Message-ID: <20241101034349.8915-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <f79d2587-2588-598f-f9b2-2e3548067d92@huawei.com>
References: <f79d2587-2588-598f-f9b2-2e3548067d92@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600002.china.huawei.com (7.193.23.29)

When build with !CONFIG_MMU, the variable 'vmcore_mmap_ops'
is defined but not used:

>> fs/proc/vmcore.c:458:42: warning: unused variable 'vmcore_mmap_ops'
     458 | static const struct vm_operations_struct vmcore_mmap_ops = {

Fix this by only defining it when CONFIG_MMU is enabled.

Fixes: 9cb218131de1 ("vmcore: introduce remap_oldmem_pfn_range()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202410301936.GcE8yUos-lkp@intel.com/
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
v3: move changelogs after the '---' line
v2: use ifdef instead of __maybe_unused

 fs/proc/vmcore.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..9ed1f6902c8f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -455,10 +455,6 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 #endif
 }
 
-static const struct vm_operations_struct vmcore_mmap_ops = {
-	.fault = mmap_vmcore_fault,
-};
-
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
  * @size: size of buffer
@@ -486,6 +482,11 @@ static inline char *vmcore_alloc_buf(size_t size)
  * virtually contiguous user-space in ELF layout.
  */
 #ifdef CONFIG_MMU
+
+static const struct vm_operations_struct vmcore_mmap_ops = {
+	.fault = mmap_vmcore_fault,
+};
+
 /*
  * remap_oldmem_pfn_checked - do remap_oldmem_pfn_range replacing all pages
  * reported as not being ram with the zero page.
-- 
2.33.0


