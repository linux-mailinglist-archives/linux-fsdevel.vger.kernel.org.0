Return-Path: <linux-fsdevel+bounces-29554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F6C97AC24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1611D284179
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1C1531C2;
	Tue, 17 Sep 2024 07:31:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD614E2E3;
	Tue, 17 Sep 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558307; cv=none; b=ilgwBmqTV6xA00s9ykv32/36X6zvtsf7DqBKzg/tYwxV0UIyepSZJpTsSmogARsfSng0nprJZEtcvlbQeMFnAqTNk897TLcVKChcsfMXksXgSfVGuGsygTDlj8oSY86zRx8+TUdQpJe1IdUlNcXotC51ptb7tR8G6KMmVJLl03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558307; c=relaxed/simple;
	bh=Wrn9vGLLb36vMNF1zYZDE7W/OZuIZQCQKfm9bxbLjfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMp7IH/Ag2rf5woitBlH0GcNw7Wy79NozouIP+QXQP8BJhWtPmrDimCCVXhKrtisu/rDMhz+35IkZoiMleQZSiYReK0plm2ATt06bniqjojMMRpyChcgIFqQunew6v/3zOdkX3spQYGvz/IA1v+Kn6vVKXRFZkYIs9XII/2pD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0434D106F;
	Tue, 17 Sep 2024 00:32:15 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.61.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11DEC3F64C;
	Tue, 17 Sep 2024 00:31:40 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V2 3/7] mm: Use ptep_get() for accessing PTE entries
Date: Tue, 17 Sep 2024 13:01:13 +0530
Message-Id: <20240917073117.1531207-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240917073117.1531207-1-anshuman.khandual@arm.com>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert PTE accesses via ptep_get() helper that defaults as READ_ONCE() but
also provides the platform an opportunity to override when required. This
stores read page table entry value in a local variable which can be used in
multiple instances there after. This helps in avoiding multiple memory load
operations as well possible race conditions.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..547eeae8c43f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1060,7 +1060,8 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
  */
 #define set_pte_safe(ptep, pte) \
 ({ \
-	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
+	pte_t __old = ptep_get(ptep); \
+	WARN_ON_ONCE(pte_present(__old) && !pte_same(__old, pte)); \
 	set_pte(ptep, pte); \
 })
 
-- 
2.25.1


