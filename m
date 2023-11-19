Return-Path: <linux-fsdevel+bounces-3143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC837F07B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7301C2086A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2486154B9;
	Sun, 19 Nov 2023 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99B28138;
	Sun, 19 Nov 2023 08:57:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 936051476;
	Sun, 19 Nov 2023 08:58:41 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64E5A3F6C4;
	Sun, 19 Nov 2023 08:57:50 -0800 (PST)
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
Subject: [PATCH RFC v2 03/27] mm: cma: Make CMA_ALLOC_SUCCESS/FAIL count the number of pages
Date: Sun, 19 Nov 2023 16:56:57 +0000
Message-Id: <20231119165721.9849-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CMA_ALLOC_SUCCESS, respectively CMA_ALLOC_FAIL, are increased by one
after each cma_alloc() function call. This is done even though cma_alloc()
can allocate an arbitrary number of CMA pages. When looking at
/proc/vmstat, the number of successful (or failed) cma_alloc() calls
doesn't tell much with regards to how many CMA pages were allocated via
cma_alloc() versus via the page allocator (regular allocation request or
PCP lists refill).

This can also be rather confusing to a user who isn't familiar with the
code, since the unit of measurement for nr_free_cma is the number of pages,
but cma_alloc_success and cma_alloc_fail count the number of cma_alloc()
function calls.

Let's make this consistent, and arguably more useful, by having
CMA_ALLOC_SUCCESS count the number of successfully allocated CMA pages, and
CMA_ALLOC_FAIL count the number of pages cma_alloc() failed to allocate.

For users that wish to track the number of cma_alloc() calls, there are
tracepoints for that already implemented.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 mm/cma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2b2494fd6b59..2b74db5116d5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -517,10 +517,10 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	pr_debug("%s(): returned %p\n", __func__, page);
 out:
 	if (page) {
-		count_vm_event(CMA_ALLOC_SUCCESS);
+		count_vm_events(CMA_ALLOC_SUCCESS, count);
 		cma_sysfs_account_success_pages(cma, count);
 	} else {
-		count_vm_event(CMA_ALLOC_FAIL);
+		count_vm_events(CMA_ALLOC_FAIL, count);
 		if (cma)
 			cma_sysfs_account_fail_pages(cma, count);
 	}
-- 
2.42.1


