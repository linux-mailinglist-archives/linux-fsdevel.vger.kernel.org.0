Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4D1FDAAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 03:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFRBDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 21:03:55 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5154 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgFRBDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:03:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eeabd170000>; Wed, 17 Jun 2020 18:02:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 17 Jun 2020 18:03:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 17 Jun 2020 18:03:55 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 01:03:54 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 18 Jun 2020 01:03:54 +0000
Received: from ng-desktop.nvidia.com (Not Verified[10.110.48.88]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eeabd7a0000>; Wed, 17 Jun 2020 18:03:54 -0700
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Nitin Gupta <ngupta@nitingupta.dev>,
        Nitin Gupta <nigupta@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Baoquan He <bhe@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC SYSCTL" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: [PATCH] mm: Use unsigned types for fragmentation score
Date:   Wed, 17 Jun 2020 18:03:17 -0700
Message-ID: <20200618010319.13159-1-nigupta@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592442135; bh=wgBrBd0RNj35frLYREzbq9FYrPbCP1PSyyH9jZ1qNpI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=oYMRhJ+kJXm0xcCrHQSm7778uBZTj03omA3m+wKT9ofTUZFkSire1HQlXOsaVrN/C
         uS1F9MbT+iVw6R2vdcfRxUfsxNtpUuhC7ZRXVCCGRpe9+QvRtW7/AT0ciZL9BB3DqW
         sBFyjEH6VfIRB07mRkNTsdeF/MPNUBqSNrrYVRFoncjg0m+46B94Y8qDEL7JFUYT4j
         5xMOt3OOYkcq+0Bd5a3fJSJ1Uz1CB451n64fXz6ldqYDw72rSkbL7WdfdH18KDrP1S
         WX4V4Ak2kXM6Z91NUPOq+gyrw1vRxEzeWjWaPO9kbGFnis7aMxLYoLHubGmnvCP7os
         9emrlNCD6nShg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Proactive compaction uses per-node/zone "fragmentation score" which
is always in range [0, 100], so use unsigned type of these scores
as well as for related constants.

Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
---
 include/linux/compaction.h |  4 ++--
 kernel/sysctl.c            |  2 +-
 mm/compaction.c            | 18 +++++++++---------
 mm/vmstat.c                |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 7a242d46454e..25a521d299c1 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -85,13 +85,13 @@ static inline unsigned long compact_gap(unsigned int or=
der)
=20
 #ifdef CONFIG_COMPACTION
 extern int sysctl_compact_memory;
-extern int sysctl_compaction_proactiveness;
+extern unsigned int sysctl_compaction_proactiveness;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_extfrag_threshold;
 extern int sysctl_compact_unevictable_allowed;
=20
-extern int extfrag_for_order(struct zone *zone, unsigned int order);
+extern unsigned int extfrag_for_order(struct zone *zone, unsigned int orde=
r);
 extern int fragmentation_index(struct zone *zone, unsigned int order);
 extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		unsigned int order, unsigned int alloc_flags,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 58b0a59c9769..40180cdde486 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2833,7 +2833,7 @@ static struct ctl_table vm_table[] =3D {
 	{
 		.procname	=3D "compaction_proactiveness",
 		.data		=3D &sysctl_compaction_proactiveness,
-		.maxlen		=3D sizeof(int),
+		.maxlen		=3D sizeof(sysctl_compaction_proactiveness),
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec_minmax,
 		.extra1		=3D SYSCTL_ZERO,
diff --git a/mm/compaction.c b/mm/compaction.c
index ac2030814edb..45fd24a0ea0b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -53,7 +53,7 @@ static inline void count_compact_events(enum vm_event_ite=
m item, long delta)
 /*
  * Fragmentation score check interval for proactive compaction purposes.
  */
-static const int HPAGE_FRAG_CHECK_INTERVAL_MSEC =3D 500;
+static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC =3D 500;
=20
 /*
  * Page order with-respect-to which proactive compaction
@@ -1890,7 +1890,7 @@ static bool kswapd_is_running(pg_data_t *pgdat)
  * ZONE_DMA32. For smaller zones, the score value remains close to zero,
  * and thus never exceeds the high threshold for proactive compaction.
  */
-static int fragmentation_score_zone(struct zone *zone)
+static unsigned int fragmentation_score_zone(struct zone *zone)
 {
 	unsigned long score;
=20
@@ -1906,9 +1906,9 @@ static int fragmentation_score_zone(struct zone *zone=
)
  * the node's score falls below the low threshold, or one of the back-off
  * conditions is met.
  */
-static int fragmentation_score_node(pg_data_t *pgdat)
+static unsigned int fragmentation_score_node(pg_data_t *pgdat)
 {
-	unsigned long score =3D 0;
+	unsigned int score =3D 0;
 	int zoneid;
=20
 	for (zoneid =3D 0; zoneid < MAX_NR_ZONES; zoneid++) {
@@ -1921,17 +1921,17 @@ static int fragmentation_score_node(pg_data_t *pgda=
t)
 	return score;
 }
=20
-static int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
+static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
 {
-	int wmark_low;
+	unsigned int wmark_low;
=20
 	/*
 	 * Cap the low watermak to avoid excessive compaction
 	 * activity in case a user sets the proactivess tunable
 	 * close to 100 (maximum).
 	 */
-	wmark_low =3D max(100 - sysctl_compaction_proactiveness, 5);
-	return low ? wmark_low : min(wmark_low + 10, 100);
+	wmark_low =3D max(100U - sysctl_compaction_proactiveness, 5U);
+	return low ? wmark_low : min(wmark_low + 10, 100U);
 }
=20
 static bool should_proactive_compact_node(pg_data_t *pgdat)
@@ -2604,7 +2604,7 @@ int sysctl_compact_memory;
  * aggressively the kernel should compact memory in the
  * background. It takes values in the range [0, 100].
  */
-int __read_mostly sysctl_compaction_proactiveness =3D 20;
+unsigned int __read_mostly sysctl_compaction_proactiveness =3D 20;
=20
 /*
  * This is the entry point for compacting all nodes via
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3e7ba8bce2ba..b1de695b826d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1079,7 +1079,7 @@ static int __fragmentation_index(unsigned int order, =
struct contig_page_info *in
  * It is defined as the percentage of pages found in blocks of size
  * less than 1 << order. It returns values in range [0, 100].
  */
-int extfrag_for_order(struct zone *zone, unsigned int order)
+unsigned int extfrag_for_order(struct zone *zone, unsigned int order)
 {
 	struct contig_page_info info;
=20
--=20
2.27.0

