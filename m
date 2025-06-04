Return-Path: <linux-fsdevel+bounces-50575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247FACD720
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DA31799C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9D4262FF8;
	Wed,  4 Jun 2025 04:15:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50BEAF1;
	Wed,  4 Jun 2025 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749010546; cv=none; b=lT1lMsts1LzNVm8J5yvCDA92jv4yJ4WN4tj++Foczskx8gF06wZ34dA7lw7x9DEjijT5P9aTHmbmPHL8iQuF29GAQuOqGyPoTYckagC6RBAW1wuqkBqnek/nNPqHWMf/lITm6Nms8fkj7o/tNbZGWUMGKRV6dgfpnKvbqGr9mEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749010546; c=relaxed/simple;
	bh=TISq2IOqcxgXqiUwD6UtnHmSV44dC7o5qVYxd3d8+2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krl9kK9/WiLDIVBHiX1bxZbriJ5nwKRkrQk5BI1z8LAussZ/Pw80iVbPfdRlMib4TcZ6tY/qPIauTNHL+ob/EIbttzVXmfMjwr3R4LsXdAM6oRdrXB8iF19xvBHFa8XiJ7WXDtg28gwge4D9WysgFk9V8CzO+gwlZpOHWMHjFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFB641756;
	Tue,  3 Jun 2025 21:15:25 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 731363F673;
	Tue,  3 Jun 2025 21:15:39 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	anshuman.khandual@arm.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	aneesh.kumar@kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Wed,  4 Jun 2025 09:45:33 +0530
Message-Id: <20250604041533.91198-1-dev.jain@arm.com>
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
order. For example, suppose we have a shift-6 node having an order-9
entry => 8 - 1 = 7 siblings, so assume the slots are at offset 0 till 7 in
this node. If xas->xa_offset is 6, then the code will compute order as
1 + xas->xa_node->shift = 7. Therefore, the order computation must start
from the beginning of the multi-slot entries, that is, the non-sibling
entry. Thus ensure that the caller is aware of this by triggering a BUG
when the entry is a sibling entry. Note that this BUG_ON() is only
active while running selftests, so there is no overhead in a running
kernel.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
v1->v2:
 - Expand changelog, add comment

Based on Torvalds' master branch.

 lib/xarray.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 76dde3a1cacf..ae3d80f4b4ee 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1910,6 +1910,7 @@ EXPORT_SYMBOL(xa_store_range);
  * @xas: XArray operation state.
  *
  * Called after xas_load, the xas should not be in an error state.
+ * The xas should not be pointing to a sibling entry.
  *
  * Return: A number between 0 and 63 indicating the order of the entry.
  */
@@ -1920,6 +1921,8 @@ int xas_get_order(struct xa_state *xas)
 	if (!xas->xa_node)
 		return 0;
 
+	XA_NODE_BUG_ON(xas->xa_node, xa_is_sibling(xa_entry(xas->xa,
+		       xas->xa_node, xas->xa_offset)));
 	for (;;) {
 		unsigned int slot = xas->xa_offset + (1 << order);
 
-- 
2.30.2


