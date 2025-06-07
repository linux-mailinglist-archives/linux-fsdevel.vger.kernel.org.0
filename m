Return-Path: <linux-fsdevel+bounces-50908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B6BAD0D9C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 15:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2081896CD9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5900222586;
	Sat,  7 Jun 2025 13:17:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806611187;
	Sat,  7 Jun 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749302243; cv=none; b=O4zk5101geuSkdjfv5bR+VAeHWlZgqA/G/lglPT7emvcgkbKThIAdBlm32Y1pj3CCb/gntabFRxudQ8GegDVG4nW+r1bDpMDqZhn6TqPof6bNt+gqlw/4tkcCV1m2yaevUXt9TZMD53uvTjBryk4CvlH9EffjFBgwn8StpfMQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749302243; c=relaxed/simple;
	bh=D6/ffpYWsm1WAnxu88V/6bgCFhb8CHWYC8FUk5z0G4w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GXJubulb3jvwr/2Ef1UpEwmhQapiCZdNrcBCENTUYK21fSe0KNiCPfsC6WjKVsXPs+kd2qFKPr1kt13dVCbPyC0BoaMGrTZjDuELU+c+tp4rz46iYCp4owbeuva3jmjpcgyI8XG6x78slP+tSKWQqkNs/lxnMnJauEYbbwVFsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: wangfushuai <wangfushuai@baidu.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <andrii@kernel.org>,
	<osalvador@suse.de>, <Liam.Howlett@Oracle.com>, <christophe.leroy@csgroup.eu>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	wangfushuai <wangfushuai@baidu.com>
Subject: [PATCH v2] fs/proc/task_mmu: add VM_SHADOW_STACK for arm64 when support GCS
Date: Sat, 7 Jun 2025 21:15:25 +0800
Message-ID: <20250607131525.76746-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

The recent commit adding VM_SHADOW_STACK for arm64 GCS did not update
the /proc/[pid]/smaps display logic to show the "ss" flag for GCS pages.
This patch adds the necessary condition to display "ss" flag.

Fixes: ae80e1629aea ("mm: Define VM_SHADOW_STACK for arm64 when we support GCS")
Signed-off-by: wangfushuai <wangfushuai@baidu.com>
---
 fs/proc/task_mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 27972c0749e7..2c2ee893a797 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -994,6 +994,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
+#if defined(CONFIG_ARM64_GCS)
+		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
 #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
 		[ilog2(VM_DROPPABLE)] = "dp",
 #endif
-- 
2.36.1


