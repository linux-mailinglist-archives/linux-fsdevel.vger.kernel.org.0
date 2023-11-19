Return-Path: <linux-fsdevel+bounces-3144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B27F07B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B21C2096F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD7914F9A;
	Sun, 19 Nov 2023 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02FECD52;
	Sun, 19 Nov 2023 08:58:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD2BD1007;
	Sun, 19 Nov 2023 08:58:46 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ACFC3F6C4;
	Sun, 19 Nov 2023 08:57:55 -0800 (PST)
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
Subject: [PATCH RFC v2 04/27] mm: migrate/mempolicy: Add hook to modify migration target gfp
Date: Sun, 19 Nov 2023 16:56:58 +0000
Message-Id: <20231119165721.9849-5-alexandru.elisei@arm.com>
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

It might be desirable for an architecture to modify the gfp flags used to
allocate the destination page for migration based on the page that it is
being replaced. For example, if an architectures has metadata associated
with a page (like arm64, when the memory tagging extension is implemented),
it can request that the destination page similarly has storage for tags
already allocated.

No functional change.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/migrate.h | 4 ++++
 mm/mempolicy.c          | 2 ++
 mm/migrate.c            | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 2ce13e8a309b..0acef592043c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -60,6 +60,10 @@ struct movable_operations {
 /* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];
 
+#ifndef arch_migration_target_gfp
+#define arch_migration_target_gfp(src, gfp) 0
+#endif
+
 #ifdef CONFIG_MIGRATION
 
 void putback_movable_pages(struct list_head *l);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..50bc43ab50d6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1182,6 +1182,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 
 		h = folio_hstate(src);
 		gfp = htlb_alloc_mask(h);
+		gfp |= arch_migration_target_gfp(src, gfp);
 		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
 	}
@@ -1190,6 +1191,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 		gfp = GFP_TRANSHUGE;
 	else
 		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
+	gfp |= arch_migration_target_gfp(src, gfp);
 
 	page = alloc_pages_mpol(gfp, order, pol, ilx, nid);
 	return page_rmappable_folio(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index 35a88334bb3c..dd25ab69e3de 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2016,6 +2016,7 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 		struct hstate *h = folio_hstate(src);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
+		gfp_mask |= arch_migration_target_gfp(src, gfp);
 		return alloc_hugetlb_folio_nodemask(h, nid,
 						mtc->nmask, gfp_mask);
 	}
@@ -2032,6 +2033,7 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 	zidx = zone_idx(folio_zone(src));
 	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
+	gfp_mask |= arch_migration_target_gfp(src, gfp);
 
 	return __folio_alloc(gfp_mask, order, nid, mtc->nmask);
 }
@@ -2500,6 +2502,7 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 			__GFP_NOWARN;
 		gfp &= ~__GFP_RECLAIM;
 	}
+	gfp |= arch_migration_target_gfp(src, gfp);
 	return __folio_alloc_node(gfp, order, nid);
 }
 
-- 
2.42.1


