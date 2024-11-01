Return-Path: <linux-fsdevel+bounces-33403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9DE9B89F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 04:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEED21C21317
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 03:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085AC142624;
	Fri,  1 Nov 2024 03:27:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E042E822;
	Fri,  1 Nov 2024 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431650; cv=none; b=qPUWGICK/N+6sAEdaoX6Qo2cCbD+VzR0zM6WZQ7bEfjelk4PhcBEZBnnrKyMDo9w60vD2xdLnpFRHqRJhAp0C41PaXaYbmFImq//rzvA7MGFBg0CP9LliA6SLeS8e5VUEQItHY3OQXgM3cLqh3dHCcJTw+YMG52eU06Y53RznWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431650; c=relaxed/simple;
	bh=b4nNgFcfeOVUBD/UNRPcUJzEYyiiFCsY1nQqS8qaSJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHMnPU7aB0eRL9t/bgUjuwE+rzBsZ3JhMWhy3q5rr+IKkab4/sZIgv38XBJ1vIRc7wd9zvR8fl1FhMCPfoOri2BIpOUveddyqL8xzScdgL21daWTBbtU5PJkZN0LuGf3h7s/Y5hih/hvenhQeuFhaI7kQ7HCHGJz2CSSwazYZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XfmT31JMBz1T975;
	Fri,  1 Nov 2024 11:25:11 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 382DC18006C;
	Fri,  1 Nov 2024 11:27:24 +0800 (CST)
Received: from huawei.com (10.44.142.84) by kwepemm600002.china.huawei.com
 (7.193.23.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Nov
 2024 11:27:23 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <holzheu@linux.vnet.ibm.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fs/proc: Fix compile warning about variable 'vmcore_mmap_ops'
Date: Fri, 1 Nov 2024 11:23:06 +0800
Message-ID: <20241101032306.8344-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241031185235.8bb482766ab10d2ab19fd3f6@linux-foundation.org>
References: <20241031185235.8bb482766ab10d2ab19fd3f6@linux-foundation.org>
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

v2: use ifdef instead of __maybe_unused

Fixes: 9cb218131de1 ("vmcore: introduce remap_oldmem_pfn_range()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202410301936.GcE8yUos-lkp@intel.com/
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
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


