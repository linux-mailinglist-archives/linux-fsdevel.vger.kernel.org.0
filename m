Return-Path: <linux-fsdevel+bounces-50043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB52AC7A38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 10:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE594E8284
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D4421A445;
	Thu, 29 May 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SiAyZXoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1E1EB2F;
	Thu, 29 May 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748507369; cv=none; b=XAEihMibYZScncSGFg5XFAV1wVZguY3bsKeXE0qKMU0jAz0cX2R9fNMwKTTapae7aLWgBG6aBzsWqy+kXtAVepGrXHUqie3Kovjmk4+RUhdeGa57loBB9CxVQqopkYU7UEMq/dv/j3ky1aaBY3KBsZu6HE0XAxEbUtNNS8HX5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748507369; c=relaxed/simple;
	bh=oWMfWr38IyfL2mt6nbNwh36u88niY/zrghcvsR120Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9izBJWwQaYyG5EUzMAhGEC+T+wNsvetgtU3YfM8D1ZKS/iBANR7D3UjHsW4k/+LavR+jKuO4UIT2pVb/VsEKKmiECi5H0vrZVxFYLVxJyOha29o3Wt7fqtiyeJOobVtmMuEqgV9pcDnE481/1jlqJXUdQ5ug3zqaAMcP3dZhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SiAyZXoL; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748507363; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0SELs1h7jaP7V5rEcYlTVB8+PGf5ZsGKYSIxuyINI8U=;
	b=SiAyZXoLVGCBW9XtJtM56PYuJUmcQnOUzClvfgM7tVIvyomYf297q7TpO6DKb1Q2GJUwXihKME2rlSKKVrMvZkv7CpkB3ChLURi+duiyzY78CH0ld/ZrCKrVtrjgEwqBTK7m9kpeBZ0ePgCGg5LCwoaDjje6EC9IID8XbgO3Kz4=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcGls7-_1748507043 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 May 2025 16:24:03 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: huge_memory: disallow hugepages if the system-wide THP sysfs settings are disabled
Date: Thu, 29 May 2025 16:23:54 +0800
Message-ID: <d97a9e359ae914e788867b263bb9737afcd3d59d.1748506520.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MADV_COLLAPSE will ignore the system-wide Anon THP sysfs settings, which
means that even though we have disabled the Anon THP configuration, MADV_COLLAPSE
will still attempt to collapse into a Anon THP. This violates the rule we have
agreed upon: never means never.

To address this issue, should check whether the Anon THP configuration is disabled
in thp_vma_allowable_orders(), even when the TVA_ENFORCE_SYSFS flag is set.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c90192d..199ddc9f04a1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -287,20 +287,35 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       unsigned long orders)
 {
 	/* Optimization to check if required orders are enabled early. */
-	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
-		unsigned long mask = READ_ONCE(huge_anon_orders_always);
+	if (vma_is_anonymous(vma)) {
+		unsigned long always = READ_ONCE(huge_anon_orders_always);
+		unsigned long madvise = READ_ONCE(huge_anon_orders_madvise);
+		unsigned long inherit = READ_ONCE(huge_anon_orders_inherit);
+		unsigned long mask = always | madvise;
+
+		/*
+		 * If the system-wide THP/mTHP sysfs settings are disabled,
+		 * then we should never allow hugepages.
+		 */
+		if (!(mask & orders) && !(hugepage_global_enabled() && (inherit & orders)))
+			return 0;
+
+		if (!(tva_flags & TVA_ENFORCE_SYSFS))
+			goto skip;
 
+		mask = always;
 		if (vm_flags & VM_HUGEPAGE)
-			mask |= READ_ONCE(huge_anon_orders_madvise);
+			mask |= madvise;
 		if (hugepage_global_always() ||
 		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
-			mask |= READ_ONCE(huge_anon_orders_inherit);
+			mask |= inherit;
 
 		orders &= mask;
 		if (!orders)
 			return 0;
 	}
 
+skip:
 	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
 }
 
-- 
2.43.5


