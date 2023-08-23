Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D567858C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjHWNQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjHWNQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:16:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3368C1704;
        Wed, 23 Aug 2023 06:15:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C481650;
        Wed, 23 Aug 2023 06:16:04 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AFC03F740;
        Wed, 23 Aug 2023 06:15:18 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC 12/37] mm: gup: Don't allow longterm pinning of MIGRATE_METADATA pages
Date:   Wed, 23 Aug 2023 14:13:25 +0100
Message-Id: <20230823131350.114942-13-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823131350.114942-1-alexandru.elisei@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Treat MIGRATE_METADATA pages just like movable or CMA pages and don't allow
them to be pinned longterm.

No special handling needed for migrate_longterm_unpinnable_pages() because
the gfp mask for allocating the destination pages is GFP_USER.  GFP_USER
doesn't include __GFP_MOVABLE, which makes it impossible to accidently
allocate metadata pages for migrating the pinned pages.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/mm.h | 10 +++++++---
 mm/Kconfig         |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2dd73e4f3d8e..ce87d55ecf87 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1925,16 +1925,20 @@ static inline bool is_zero_folio(const struct folio *folio)
 	return is_zero_page(&folio->page);
 }
 
-/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
+/* MIGRATE_CMA, MIGRATE_METADATA and ZONE_MOVABLE do not allow pin folios */
 #ifdef CONFIG_MIGRATION
 static inline bool folio_is_longterm_pinnable(struct folio *folio)
 {
-#ifdef CONFIG_CMA
+#if defined(CONFIG_CMA) || defined(CONFIG_MEMORY_METADATA)
 	int mt = folio_migratetype(folio);
 
-	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
+	if (mt == MIGRATE_ISOLATE)
+		return false;
+
+	if (is_migrate_cma(mt) || is_migrate_metadata(mt))
 		return false;
 #endif
+
 	/* The zero page can be "pinned" but gets special handling. */
 	if (is_zero_folio(folio))
 		return true;
diff --git a/mm/Kconfig b/mm/Kconfig
index 838193522e20..847e1669dba0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1238,6 +1238,8 @@ config LOCK_MM_AND_FIND_VMA
 
 config MEMORY_METADATA
 	bool
+	select MEMORY_ISOLATION
+	select MIGRATION
 
 source "mm/damon/Kconfig"
 
-- 
2.41.0

