Return-Path: <linux-fsdevel+bounces-50911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F93EAD0EA1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D016B188F806
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4C1FDA9E;
	Sat,  7 Jun 2025 16:54:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A32AF11;
	Sat,  7 Jun 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749315266; cv=none; b=rNESSHZTYNLd6Yeqkge9eZofk6rVmePyCYeWfgAYhQVKb20f+BUs/dLSxyKBHC2NVqG8JG3rS+NE2yS63FPFwMXXthyYBiey0xUGhmgvYHCmBxgwZl3OMgHQximZXghS3dxgdtNuTZXn7DvmEwQRyX+D4jkCwe/yKCRLBAM7Hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749315266; c=relaxed/simple;
	bh=trourRxiv4hXJ6qej1K0gBPBi2ztPFV4+pE9hQv8ppk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UqZjh33WZQXkciBJHX9B+snlU8h7taop6vsKrWlYGaZnXg5p8izJoggr8OHOX/Fx4+1CHFvzvMXWt91FM0NT8j6+GeO1rECIGxkwApC32WY+g9vDFHFW85p/jo5zYhj15rv4E+ujBfB173bXN23XejcwZgiFcGOywZiC6fcnA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: wangfushuai <wangfushuai@baidu.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <andrii@kernel.org>,
	<osalvador@suse.de>, <Liam.Howlett@Oracle.com>, <christophe.leroy@csgroup.eu>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	wangfushuai <wangfushuai@baidu.com>
Subject: [PATCH] /proc/pid/smaps: add mo info for vma in NOMMU system
Date: Sun, 8 Jun 2025 00:53:35 +0800
Message-ID: <20250607165335.87054-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

Add mo in /proc/[pid]/smaps to indicate vma is marked VM_MAYOVERLAY,
which means the file mapping may overlay in NOMMU system.

Fixes: b6b7a8faf05c ("mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings")
Signed-off-by: wangfushuai <wangfushuai@baidu.com>
---
 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2a17865dfe39..d280594656a3 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -609,6 +609,7 @@ encoded manner. The codes are the following:
     uw    userfaultfd wr-protect tracking
     ss    shadow/guarded control stack page
     sl    sealed
+    mo    may overlay file mapping
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 27972c0749e7..ad08807847de 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -970,7 +970,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_HUGEPAGE)]	= "hg",
 		[ilog2(VM_NOHUGEPAGE)]	= "nh",
 		[ilog2(VM_MERGEABLE)]	= "mg",
+#ifdef CONFIG_MMU
 		[ilog2(VM_UFFD_MISSING)]= "um",
+#else
+		[ilog2(VM_MAYOVERLAY)]	= "mo",
+#endif
 		[ilog2(VM_UFFD_WP)]	= "uw",
 #ifdef CONFIG_ARM64_MTE
 		[ilog2(VM_MTE)]		= "mt",
-- 
2.36.1


