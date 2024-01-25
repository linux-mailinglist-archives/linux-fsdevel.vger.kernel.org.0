Return-Path: <linux-fsdevel+bounces-8947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BE183C869
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E091F25CFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15717136646;
	Thu, 25 Jan 2024 16:43:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED789130E3A;
	Thu, 25 Jan 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200993; cv=none; b=bhUNnwGksG+ppZZocD6AoyE+k9p4vHP5avAaWiKUc2KKtrYwPIlaGg5Pm/r0ufGKvNhmmTtkbG+2/Td4ja6P8KN7Ton57+HWd+pqlH/i3JydQLVEh2wZn8RnjAQxI2p02fyo9zxU+qdgEhyzvIN2o2vYhQLcxs4shpCaeppQkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200993; c=relaxed/simple;
	bh=L8FwdsU6xsMs5YX7ltLK2e5AAE0XBTlL9IKmoi9QVAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U797I4sZSM/aDohn/NsXaKf4k8FO493zG2TqJo6hXIg0czH7Gb665yXpH2h/gSPUzdW5i9TEts2GapXTqyAaqStYAmw8sIqnkc70RnODKhII1RvfSSpPH6fvut6MucWHHy8ZLtZgnBlwZ0sDsRJaje/Ow4S5BtQ86SMoHtHpdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D5A1480;
	Thu, 25 Jan 2024 08:43:54 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADAA33F5A1;
	Thu, 25 Jan 2024 08:43:04 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v3 04/35] mm: page_alloc: Partially revert "mm: page_alloc: remove stale CMA guard code"
Date: Thu, 25 Jan 2024 16:42:25 +0000
Message-Id: <20240125164256.4147-5-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch f945116e4e19 ("mm: page_alloc: remove stale CMA guard code")
removed the CMA filter when allocating from the MIGRATE_MOVABLE pcp list
because CMA is always allowed when __GFP_MOVABLE is set.

With the introduction of the arch_alloc_cma() function, the above is not
true anymore, so bring back the filter.

This is a partially revert because the stale comment remains removed.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 mm/page_alloc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a96d47a6393e..0fa34bcfb1af 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2897,10 +2897,17 @@ struct page *rmqueue(struct zone *preferred_zone,
 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
 
 	if (likely(pcp_allowed_order(order))) {
-		page = rmqueue_pcplist(preferred_zone, zone, order,
-				       migratetype, alloc_flags);
-		if (likely(page))
-			goto out;
+		/*
+		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
+		 * we need to skip it when CMA area isn't allowed.
+		 */
+		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
+				migratetype != MIGRATE_MOVABLE) {
+			page = rmqueue_pcplist(preferred_zone, zone, order,
+					migratetype, alloc_flags);
+			if (likely(page))
+				goto out;
+		}
 	}
 
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
-- 
2.43.0


