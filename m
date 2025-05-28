Return-Path: <linux-fsdevel+bounces-49974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F57AC6862
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77903AEF73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A53228368A;
	Wed, 28 May 2025 11:32:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47036A33B;
	Wed, 28 May 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748431920; cv=none; b=iYoEnsP1eQ3bB9VfPm1tyZsisnCuOoZiMG3RDihgJUMjdDjTrYYjiYE0j/OGKXxLFzCnLGI/K5u/ezkf3VytvBCaT4GNUos2a2KymqMIqhvTaQqfT3obbT+tLORD7Feh9yRL5ni39N5nkr25oW43V5KFmXfdQQADC9cIOrslaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748431920; c=relaxed/simple;
	bh=M28L9NabqiiiSMq+L/jI0962Wz2oEsat/29mEBFseHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YuV7YiVqwa3J8q1/EBvRZa0gC8pCD0Qm1zWEzG9dmeh3LZOdPizlntYm+YMXg+xq+V9qNEJYSVZPFGrPDATmzaSAgGHeoSkyFpaaOwn7RKP/QtrKBPlbjpucE55S32f7tSg6qVGbrXbxYAOwCECds6g7HQA7yYdtDQW6NSf2Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7621A25;
	Wed, 28 May 2025 04:31:40 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8666B3F5A1;
	Wed, 28 May 2025 04:31:54 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	anshuman.khandual@arm.com,
	ryan.roberts@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Wed, 28 May 2025 17:01:24 +0530
Message-Id: <20250528113124.87084-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppose xas is pointing somewhere near the end of the multi-entry batch.
Then it may happen that the computed slot already falls beyond the batch,
thus breaking the loop due to !xa_is_sibling(), and computing the wrong
order. Thus ensure that the caller is aware of this by triggering a BUG
when the entry is a sibling entry.

This patch is motivated by code inspection and not a real bug report.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
The patch applies on 6.15 kernel.

 lib/xarray.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 9644b18af18d..0f699766c24f 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1917,6 +1917,8 @@ int xas_get_order(struct xa_state *xas)
 	if (!xas->xa_node)
 		return 0;
 
+	XA_NODE_BUG_ON(xas->xa_node, xa_is_sibling(xa_entry(xas->xa,
+		       xas->xa_node, xas->xa_offset)));
 	for (;;) {
 		unsigned int slot = xas->xa_offset + (1 << order);
 
-- 
2.30.2


