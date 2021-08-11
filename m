Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D53E8AB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhHKHGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 03:06:15 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:11361
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234971AbhHKHGN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkCdko77t2ym6I5y0k3NkriOk8EuBNeJmXj0Oifr/fYbvQBn4Qlj8uAC5h8VCTDm+SnUeN9xthn2kd+SPmH+Q6eRBzoZApHoP110iQlxJzsM7awiyCkHmfLhX8lsqPcjIELikbGMucu8i+0uEAwlXxWuUU1W07OJ1G1opiIVSt5NkChT4xE4mpMXUbRdd2NJSKLg5xNU6kZdw1yL6EZZ/s91AQCUpP3cPp101cG/bQZ0Amx1EIh3/V9LmzJw6Uk0F7GiAi4PFKEkGk6lKmX+Mrozez+N++IEQ76f96Ib9QIShun4O3gXRmdO62ymPkZffR229WcA1xzh7sKej8gCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFurwPO74LxxFQUVsB1P0L5yzk54kCcbKJ4Ol1Hsap0=;
 b=ZkgV2PTmi2JjQVmBPgsMHkDRQrJYwWMAgPalnnzYh7395zBa9tGoj42aM5NA4CHb+62U6ioVzq0ykkNHuCZkykBLEndwH36E67cNYMNzXkJTvptooxRywOo0lEOOsRigwVajKpqrl2d6n7JS+tdF9zhjW+Elp7s6aiOSeAPBvYVSk77bFOkLk8cvijGyFKPZUHdCY6IHSw7K9LbwF5szzhV2EFqkwvD9reFgo1HJB+EJq4BA2mLCG9J5FbWMz2ux8XiAr+4l6+E6rwE49sQQEA4H1hPuEmZkXVfKsB7uUP6E/36XRODgx2TD3tfPN9NaselvRtSStbZF4+oCoWWG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFurwPO74LxxFQUVsB1P0L5yzk54kCcbKJ4Ol1Hsap0=;
 b=sQ+CwR1EwQ/iAVWOCKqFau9POzrvSYs4JJOK+DFgY80v9ODRCHII4EBs59JYd1MGfwtNNaCctHZRAWvDEuNK77l9pcJDbgdNjMK5nrxWyZMdrjK+NAmLmQBHkfAVWn3ecFTjFm4XAdLbgs4An75TSV+kuKue83FgTmCsPZlfffor6EQIAYWpEOiQMB8c1IhIUWrwkVolkBCIbMpDPg24ORTb6XC/R+KPPKEYvjZbGxG2tYS02T1rB72ccwTXT6qbjgAlYows54M3EO+x4e4pX/p/zEW+0w2//pCOTN8tbHe21ue/y/l3yHBm7XQfhRDD9ZiFIohQeI/YHEDjX1Vy6Q==
Received: from BN6PR1401CA0020.namprd14.prod.outlook.com
 (2603:10b6:405:4b::30) by DM6PR12MB4220.namprd12.prod.outlook.com
 (2603:10b6:5:21d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 07:05:48 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::8c) by BN6PR1401CA0020.outlook.office365.com
 (2603:10b6:405:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Wed, 11 Aug 2021 07:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 07:05:48 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Aug
 2021 07:05:47 +0000
Received: from sandstorm.attlocal.net (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Aug 2021 00:05:47 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call try_get_compound_head() directly
Date:   Wed, 11 Aug 2021 00:05:42 -0700
Message-ID: <20210811070542.3403116-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811070542.3403116-1-jhubbard@nvidia.com>
References: <20210811070542.3403116-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2196168a-7b6d-49ec-052b-08d95c967294
X-MS-TrafficTypeDiagnostic: DM6PR12MB4220:
X-Microsoft-Antispam-PRVS: <DM6PR12MB422014BC6FA36A0BEFB24B44A8F89@DM6PR12MB4220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WR4p5gupux636D7g92qVjr5vHjGpjXD+sPBVpIpyvBo/xbtcy0KS/JX2G4qQkab60xJyA/Bd/g/Fp8hRM1L6/eldOkFv/hvKNyHle+tMKeP3ZGi5O67WzPpTkajCmwROkfV/eiLoNwyqYzUQXDn0eWP+rUPKxbT+8lmtk1S8x/SpzCnubzC9MDlwttsxwVSFRv/6eeuACXDD3mMdfWet7/tHqKxsiuzT8H8pz2OMVVtjfxMwVq2Xv25R4xso6H6qrZ3kZfeyKcP9uhIHRt23vvY71RA8JlirQ7WhPtrSAJ5pWwhk+BlICgSHw8/89sMbMV5RKaOuUlyptqOkn5hbm7fHYhu5LlWRql3vvrvZULY6jChrDus+sfZ+HA4qiz/+0wjYD+MIakjUiDhsqjMKfM5gStuc/gevMIsuZJGeBKa0VVmyN6zPLie1SUIr3unMU6Wu5XbF0+xOAKy/rjanw3Wzhfvj7pXPB4KtkgNvs3NkYKAB0FiJcoNcLeaAwfcTgOCRkg0r8akS7lD+XJsSVSsABF4eY0hR2OC0/6kDvvKWtn0NAILiyrHVsS2WV9J64Qz90Ao+wWMmqW7EKwcZKrsYpPBFbAmvsAaIcaPAPcvJ0DqSQftzRHDvQlsOUFnDkZJWg1bdAJVtpUz+TRLKiTPfz9YZpEuBytoPMPB+e0rYw2nVBLXvtPhcdTP9nbE7nSPd0GQNADFUQRC+qNdYtg==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(2616005)(6666004)(186003)(426003)(70206006)(70586007)(356005)(2906002)(1076003)(26005)(82310400003)(6916009)(478600001)(47076005)(8936002)(36756003)(8676002)(336012)(36906005)(82740400003)(316002)(36860700001)(83380400001)(7636003)(54906003)(5660300002)(86362001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 07:05:48.5269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2196168a-7b6d-49ec-052b-08d95c967294
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

try_get_page() is very similar to try_get_compound_head(), and in fact
try_get_page() has fallen a little behind in terms of maintenance:
try_get_compound_head() handles speculative page references more
thoroughly.

There are only two try_get_page() callsites, so just call
try_get_compound_head() directly from those, and remove try_get_page()
entirely.

Also, seeing as how this changes try_get_compound_head() into a
non-static function, provide some kerneldoc documentation for it.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/s390/mm/fault.c |  2 +-
 fs/pipe.c            |  2 +-
 include/linux/mm.h   | 10 +---------
 mm/gup.c             | 21 +++++++++++++++++----
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 212632d57db9..fe1d2c1dbe3b 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -822,7 +822,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 		break;
 	case KERNEL_FAULT:
 		page = phys_to_page(addr);
-		if (unlikely(!try_get_page(page)))
+		if (unlikely(try_get_compound_head(page, 1) == NULL))
 			break;
 		rc = arch_make_page_accessible(page);
 		put_page(page);
diff --git a/fs/pipe.c b/fs/pipe.c
index 8e6ef62aeb1c..06ba9df37410 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -191,7 +191,7 @@ EXPORT_SYMBOL(generic_pipe_buf_try_steal);
  */
 bool generic_pipe_buf_get(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 {
-	return try_get_page(buf->page);
+	return try_get_compound_head(buf->page, 1) != NULL;
 }
 EXPORT_SYMBOL(generic_pipe_buf_get);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce8fc0fd6d6e..cd00d1222235 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1207,15 +1207,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags);
 __maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
 						   unsigned int flags);
 
-
-static inline __must_check bool try_get_page(struct page *page)
-{
-	page = compound_head(page);
-	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
-		return false;
-	page_ref_inc(page);
-	return true;
-}
+struct page *try_get_compound_head(struct page *page, int refs);
 
 /**
  * folio_put - Decrement the reference count on a folio.
diff --git a/mm/gup.c b/mm/gup.c
index 64798d6b5043..c2d19d370c99 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -62,11 +62,24 @@ static void put_page_refs(struct page *page, int refs)
 	put_page(page);
 }
 
-/*
- * Return the compound head page with ref appropriately incremented,
- * or NULL if that failed.
+/**
+ * try_get_compound_head() - return the compound head page with refcount
+ * appropriately incremented, or NULL if that failed.
+ *
+ * This handles potential refcount overflow correctly. It also works correctly
+ * for various lockless get_user_pages()-related callers, due to the use of
+ * page_cache_add_speculative().
+ *
+ * Even though the name includes "compound_head", this function is still
+ * appropriate for callers that have a non-compound @page to get.
+ *
+ * @page:  pointer to page to be gotten
+ * @refs:  the value to add to the page's refcount
+ *
+ * Return: head page (with refcount appropriately incremented) for success, or
+ * NULL upon failure.
  */
-static inline struct page *try_get_compound_head(struct page *page, int refs)
+struct page *try_get_compound_head(struct page *page, int refs)
 {
 	struct page *head = compound_head(page);
 
-- 
2.32.0

