Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2343EAF5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 06:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhHMEmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 00:42:05 -0400
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:64736
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238660AbhHMEmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 00:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA2jfN5J0PnmvaLM9C8g0MkGGNg53K0xp9JUbRuQYnwdMkS+7fWSeu/uH63z/YCZGHoLgo6LTO0/yf/T+XfN0Az5ZJ5qY+gY+HgSGB7PSqbVRnyjgyugQ2r/FIGK2RtYP1EV0+qYp/24FcrMPvzoG5NQotfZUwO7vR4OCffxa/CWZO06rO5g2I3yH0I2aa+KwUYg5idMcUUGYbEPwnibFCn7fTIziEHkbG00u6Co803qLAvRrs/i1Qx0Za1xuUe+l0go0DHhmomNoO2mvqkvdzGegNkCC8EGazLvOiUJ0t0a0XHcLNt+Mij5Gm//9wlT9kyOdpGPBAQ8JkjUP8spvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xLf1m1g7cLMUBXRJJepv9cv1cwJzRrbSXYcSu7o0ZE=;
 b=cQIWQdAsYPOVZ0nt0EOT74Pt5YUdzpCOZdIK/nkgdiKa1nS9ab9h19/g6vohk90wv6EJkv3ypRQbfnHs+aUPRZ+I4shBv3APHshoXV3Xg9l/70tqtu7yogYNZXn7a2Zd3G8WIILdLE8nl7ogjmYk4iRf53H+m2e/f4Q0mSy5S+ApDvHMlb4O2UFq6d8O/+CbdlhINz4093GBgRs87gYN9GzW5uo/ObSIwIxFLrT7UYUXQjiQuOVMjOqoBxcVI/4vZxsWzJSHctgxN+qQm3Nd12I8LT6rP5L6eg4QX9wKNOsSO9yqh1b3UKkfBU0/HSsXdXZGVx8+8GhGY8/EQ+y5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xLf1m1g7cLMUBXRJJepv9cv1cwJzRrbSXYcSu7o0ZE=;
 b=CeM3JZJXMy9rkBREESRfsD1esPiH6UvCgMn4NSouu/pRZAB07utnYaUwRFrfBTbhQ99t8R2OQRFfocQACA8IfJaHVKO/6TqIMNI5U8PoeSuD8icqADjf0pcc2fMd/EajxfFxQbpkga2dBId0E9LMD8uiBOnFGZL8IHwHtkZLCUijOGxrA10cBTvvH6ajuDX4pYZNTZhyNRM5bUh8HMAqgceey8P1bpLjx0r6IwGBDwIu8ULl8YMj7dauXg4uZKk9WfAkoUrB+LwXWxOMrKbNXSzR9/ySzXrzY4GnAiZj0cl/RZ1lc0/6KDG7GXWyvlnoCgvysPQxSynKWcAJokMSBg==
Received: from MWHPR18CA0036.namprd18.prod.outlook.com (2603:10b6:320:31::22)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 04:41:37 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::4c) by MWHPR18CA0036.outlook.office365.com
 (2603:10b6:320:31::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Fri, 13 Aug 2021 04:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 04:41:36 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Aug
 2021 04:41:35 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Aug
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
Subject: [PATCH v3 2/3] mm/gup: small refactoring: simplify try_grab_page()
Date:   Thu, 12 Aug 2021 21:41:32 -0700
Message-ID: <20210813044133.1536842-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813044133.1536842-1-jhubbard@nvidia.com>
References: <20210813044133.1536842-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf799d3e-8b0f-41a1-751d-08d95e14a226
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40637B5EBF8A206AA8D9ADF8A8FA9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLp3l3hLR1KDQQrKW4vQMgxNgGO/hyHV1xrgRE+5JgymXMA6JvK1xmOXQbm8HM8dvp1bOeZDrBDYNeHJfl4u8tLCtMvEVzU/8ph4SrhKQFBFIOkfQy0C0helu1xPWsQNp987nv/d6dxuNiNo1nn1/lcKTXeB/9NRIAhy74Jp8NICXECuP1ek8d1MUjihDPpkFpZrgR7gGFgY0l2zq3zuqwggVNLTLHGKFMXLKlCp1n6qoQ94aaD8li2UJvpKpEsarwP0tXAjRxB4iVmM69hrb4RwUMw+YY1GgCNR7iLThxkN9NJ5kDMk5yEp4R11Xiv/ODM+WgyjElTg9gGKQ522+E6TYH4mXlaVtY+OoRzoKNrpah5tzdSOF7L4ydaULn4MgU2ex3LM6MqZ0+sBAhXvexDTCtREH4DXzqPtmleY0Djr3anx6zeY4ZmbWGDTmrnnMi4v7Aath7EieGO/PA6diAlLXI03sgPYqbLRTXmIF4IRdQqzU0X6AZUhNOgvXCp/9UWzG7CZuGlUl8W9FZVFZwsPpdYnwM/SAGGEFwj6kH9kYN4A3YkNUPNPThWtGs1AYAkLc0gmWSd0lRvTqycvCuT4fnQDK5WnxSwCUK25GRB5wnfPbI72Q5PUVkVq7DqP4weHdrLCD53adXZI+qFZaIQsk/HmLi7wrQfe9sQA/GeIvDvLh24E0c9M0k/uXJwuHZBPGOmwFdJ96LVAoBzIiw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(82310400003)(8676002)(2906002)(36906005)(82740400003)(316002)(5660300002)(7636003)(70206006)(70586007)(7416002)(6916009)(86362001)(36860700001)(356005)(83380400001)(6666004)(2616005)(54906003)(1076003)(426003)(4326008)(26005)(186003)(47076005)(107886003)(36756003)(336012)(478600001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 04:41:36.1312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf799d3e-8b0f-41a1-751d-08d95e14a226
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

try_grab_page() does the same thing as try_grab_compound_head(...,
refs=1, ...), just with a different API. So there is a lot of code
duplication there.

Change try_grab_page() to call try_grab_compound_head(), while keeping
the API contract identical for callers.

Also, now that try_grab_compound_head() always has a caller, remove the
__maybe_unused annotation.

Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  4 ++--
 mm/gup.c           | 35 +++++------------------------------
 2 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce8fc0fd6d6e..ba985eaf3f19 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1204,8 +1204,8 @@ static inline void get_page(struct page *page)
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-__maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
-						   unsigned int flags);
+struct page *try_grab_compound_head(struct page *page, int refs,
+				    unsigned int flags);
 
 
 static inline __must_check bool try_get_page(struct page *page)
diff --git a/mm/gup.c b/mm/gup.c
index 52f08e3177e9..886d6148d3d0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -124,8 +124,8 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  * considered failure, and furthermore, a likely bug in the caller, so a warning
  * is also emitted.
  */
-__maybe_unused struct page *try_grab_compound_head(struct page *page,
-						   int refs, unsigned int flags)
+struct page *try_grab_compound_head(struct page *page,
+				    int refs, unsigned int flags)
 {
 	if (flags & FOLL_GET)
 		return try_get_compound_head(page, refs);
@@ -208,35 +208,10 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
  */
 bool __must_check try_grab_page(struct page *page, unsigned int flags)
 {
-	WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == (FOLL_GET | FOLL_PIN));
+	if (!(flags & (FOLL_GET | FOLL_PIN)))
+		return true;
 
-	if (flags & FOLL_GET)
-		return try_get_page(page);
-	else if (flags & FOLL_PIN) {
-		int refs = 1;
-
-		page = compound_head(page);
-
-		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
-			return false;
-
-		if (hpage_pincount_available(page))
-			hpage_pincount_add(page, 1);
-		else
-			refs = GUP_PIN_COUNTING_BIAS;
-
-		/*
-		 * Similar to try_grab_compound_head(): even if using the
-		 * hpage_pincount_add/_sub() routines, be sure to
-		 * *also* increment the normal page refcount field at least
-		 * once, so that the page really is pinned.
-		 */
-		page_ref_add(page, refs);
-
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
-	}
-
-	return true;
+	return try_grab_compound_head(page, 1, flags);
 }
 
 /**
-- 
2.32.0

