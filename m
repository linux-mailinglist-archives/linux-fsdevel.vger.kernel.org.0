Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5F3EAF63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 06:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhHMEmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 00:42:09 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:48353
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238685AbhHMEmG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 00:42:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXs8cPnlGKrT+HEtO+Q/zx0WdpxNjd8Qp4buEesJwNqh+jzWlgs27EpSIIkjGXCH6aklCRJQmT+kPn/duSEPudLuN9NGif7B/w9jYcZC33LsXuOAEyuZ8rTfCyWwXTciksdc+TT4GqLv1QlYmU3N+jqXa5FMYJA0o227TWOvaM/9R4tSS/jAKdLqMFgoo8seUwrJhzGVyjGlOFhxXNiqUjpDI7aqfFMIBBMtmt1XNEcUDtDEqkvXtiBCtOHS+gaNjvLqaadvBKua64Vtx3TSbcKkmQCUuX0gbMlPtnFyEuWNo87FXikvhbnQDGuvfZ7R6CpGh7sf/1BHfjNfDLbF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T93KNdHJhW3WHWQJizJ9zl19NjWkpWWPLX17IPvFQpQ=;
 b=bzHmYo2h0KDNnK364aTJoDybAHsV7Wvc9L/i5aaxJhws3oNvY2UK2ovKJRrJHmsyRrLUkG9yxBxeEEhLm5YayAcBlrRGKhs+QVSmgjZKkKrp7DOnuWLX1C3x9efhvI+y5AhIXM4SGRvUeIPfBtp8ndMOQ+xRwjSjpylo4wuV5tboZbpXxlqFTFiR1YK17wDmaHLU/jgUttvpjhYnUP7FHk5IpnydYHCcRvKPjGJ8K5rRmiZ9PM3K6dype8/Z+gnq8rZTg/8Do27Gh2iWIGdzvJIOr/HZfMeXl+5FS7z4Ss7i8qGNO/tT9oh+bZy61Qa4gZyzPo7tT85HbsfN7llGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T93KNdHJhW3WHWQJizJ9zl19NjWkpWWPLX17IPvFQpQ=;
 b=VGMC4j9g6UHVFnhJVOQnVO1nLjfXNHNKA16+Ru9LpBeM5S295as8yKvU5FjrgWvOIJLYBG19PZ5ozxAIMpe2TjaofriYs9PDKs0DQIjcCskCZYQ0edkKguOzdYCxF1TJR3cKXpsp3974mzPdNjU1vapKHvwVHpGtTDmAxxURAEe7mt44ajCWrfxPM2O3PocVvIerMea2Hj7olJVI4p2wmMV6Dc1M1XszfhFwwSybWHk1MhYWrkwjd/a7VxnF8G3B4QjUHM89GNf7LOCdL6BNp1y8GYvZKaT/yJJJvuS4NkuaZafKgtf6Ig1zc+R1hU/dc+xVmFbPMYd7GODGVj6BjA==
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Fri, 13 Aug
 2021 04:41:36 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::58) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Fri, 13 Aug 2021 04:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 04:41:35 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Aug
 2021 04:41:35 +0000
Received: from sandstorm.attlocal.net (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 04:41:35 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 1/3] mm/gup: documentation corrections for gup/pup
Date:   Thu, 12 Aug 2021 21:41:31 -0700
Message-ID: <20210813044133.1536842-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813044133.1536842-1-jhubbard@nvidia.com>
References: <20210813044133.1536842-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 312a56dd-c3af-40d2-4183-08d95e14a1eb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1916:
X-Microsoft-Antispam-PRVS: <DM5PR12MB19169B8DB8DAD269BC61A73DA8FA9@DM5PR12MB1916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHxYscZEFmS5PbL4bQxMivixKzdqYxRNzkq9bmBdKs3TZDA3rf4Ezi2ypg7dSuWmSY6EP8RbyMy1pVz50gB4CrfURg3DJ8prqNfIUInA+UvNthMXCDMOrzTfz6QxQEu8W0WjlAstBLXqWb0b8Z2R/Mjfcu8WrWH3qdAMbb542NE5Xt558mCarzK8+clW0rCPNfaLzrdStcdHVUvH9ThNHU1qjLAowOUzmydHyOPREevnaH8Btd96W3rCSW9y8WdAC4L3qiKPV48OcadUjB4IRJuUbt11gIb3ATqj85FEw1CM/uNEc8IoSSj1krEZmCb1DzzBrocdYCXRDPr/QIULHDDkR6Dd43+ETTzKhfBNHWNhUhqRuTh1wNcSFtjnMyKdZ/Q05YgjYJRAMES9nl12fz0UxxB2B00vCKMjDj9eAcyjUSeUjAAmbaFhF76m5IPNTd2NCOBa/bX23e7IDRIyt7cUY3LdDbp0bxiDapgxuxp0uw3u/X0QMnwyy5gmhUA4NL9T9KBLDpMkcFx1YzixVoPPUASGWTvCKhKfg9Mqd8hKZKR24I/FEhqtRk9IjR9vfcvLqSEZtHwXY7Kk6x7KloiIXv9/sBzYPwQj5QZjOAJ0ywtxwWNBLPTLZRIsivHsovw/01TCMARKXjXHHR2BXYKFgXg2arMUQMecKcbKaKUmqujcfJBEBcZQ6yrHHrRn4ewvijsaIEIjYCWJJ+4uOg==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(36906005)(426003)(316002)(5660300002)(54906003)(6666004)(2616005)(478600001)(336012)(82310400003)(36860700001)(86362001)(356005)(47076005)(83380400001)(36756003)(186003)(4326008)(70206006)(107886003)(2906002)(26005)(70586007)(8936002)(8676002)(6916009)(7416002)(82740400003)(1076003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 04:41:35.7482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312a56dd-c3af-40d2-4183-08d95e14a1eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The documentation for try_grab_compound_head() and try_grab_page() has
fallen a little out of date. Update and clarify a few points.

Also make it kerneldoc-correct, by adding @args documentation.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2630ed1bb4f4..52f08e3177e9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -92,10 +92,17 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
 	return head;
 }
 
-/*
+/**
  * try_grab_compound_head() - attempt to elevate a page's refcount, by a
  * flags-dependent amount.
  *
+ * Even though the name includes "compound_head", this function is still
+ * appropriate for callers that have a non-compound @page to get.
+ *
+ * @page:  pointer to page to be grabbed
+ * @refs:  the value to (effectively) add to the page's refcount
+ * @flags: gup flags: these are the FOLL_* flag values.
+ *
  * "grab" names in this file mean, "look at flags to decide whether to use
  * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
  *
@@ -103,8 +110,14 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  * same time. (That's true throughout the get_user_pages*() and
  * pin_user_pages*() APIs.) Cases:
  *
- *    FOLL_GET: page's refcount will be incremented by 1.
- *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
+ *    FOLL_GET: page's refcount will be incremented by @refs.
+ *
+ *    FOLL_PIN on compound pages that are > two pages long: page's refcount will
+ *    be incremented by @refs, and page[2].hpage_pinned_refcount will be
+ *    incremented by @refs * GUP_PIN_COUNTING_BIAS.
+ *
+ *    FOLL_PIN on normal pages, or compound pages that are two pages long:
+ *    page's refcount will be incremented by @refs * GUP_PIN_COUNTING_BIAS.
  *
  * Return: head page (with refcount appropriately incremented) for success, or
  * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
@@ -141,6 +154,8 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		 *
 		 * However, be sure to *also* increment the normal page refcount
 		 * field at least once, so that the page really is pinned.
+		 * That's why the refcount from the earlier
+		 * try_get_compound_head() is left intact.
 		 */
 		if (hpage_pincount_available(page))
 			hpage_pincount_add(page, refs);
@@ -184,10 +199,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
  * @flags:   gup flags: these are the FOLL_* flag values.
  *
  * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
- * time. Cases:
- *
- *    FOLL_GET: page's refcount will be incremented by 1.
- *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
+ * time. Cases: please see the try_grab_compound_head() documentation, with
+ * "refs=1".
  *
  * Return: true for success, or if no action was required (if neither FOLL_PIN
  * nor FOLL_GET was set, nothing is done). False for failure: FOLL_GET or
-- 
2.32.0

