Return-Path: <linux-fsdevel+bounces-29552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C6997AC1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C23B1F22DDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB0154456;
	Tue, 17 Sep 2024 07:31:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E5310F4;
	Tue, 17 Sep 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558296; cv=none; b=PWk6wBf5DrHzbOyM6TRZzzz3Kea/LFpLOpf8PHc77NY1UWVStF4FHM7ocQrsfeb48taGhx3sjm/ltyfvJuEt5VRghzPyCOtIRavgRLBmQZvE+f3yKywckHZ48yHws1TLZr33af890ze3ffeR88Ktz2gQ1Gulo8U7ZYltiMsSBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558296; c=relaxed/simple;
	bh=TmX1uXjQKugIb41wPU+Bk96PgJuVp8IskJbQ37pXCbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tduRVmv55tolybmWw7yFvetPZicoKwoAO/kGyd4t1cHgtKO25RRi3YvRZdG7yygw2uNLD2HRkuHfNk8jAK/piG6umtZW/zcScfmyR89o9JfIAP2Iuob9ajfIXUyJQG1uEDb1RDhn7ubBX/PW3ylb1+6LJ6lF8D0jVJvd/SMh+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F251063;
	Tue, 17 Sep 2024 00:32:03 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.61.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0D793F64C;
	Tue, 17 Sep 2024 00:31:28 -0700 (PDT)
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
	linux-perf-users@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH V2 1/7] m68k/mm: Change pmd_val()
Date: Tue, 17 Sep 2024 13:01:11 +0530
Message-Id: <20240917073117.1531207-2-anshuman.khandual@arm.com>
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

This changes platform's pmd_val() to access the pmd_t element directly like
other architectures rather than current pointer address based dereferencing
that prevents transition into pmdp_get().

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/m68k/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 8cfb84b49975..be3f2c2a656c 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -19,7 +19,7 @@
  */
 #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
 typedef struct { unsigned long pmd; } pmd_t;
-#define pmd_val(x)	((&x)->pmd)
+#define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) } )
 #endif
 
-- 
2.25.1


