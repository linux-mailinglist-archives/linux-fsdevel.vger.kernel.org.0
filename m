Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF23E8ABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 09:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhHKHGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 03:06:21 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:24205
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235158AbhHKHGP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:06:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTmLssVWQAT1GE2SKl52o2tBqJ1ASUFjJkzoaQfw9D5W7vB0gyVSi9t4NtygRSIVMAjq6kkUgxoHlv7knpBmuEhFyjAiRObC+26J/26IyJSHRxxKcy1GzasZ6AFodX3Me92ox7/VMAACN0ZZEXyAmwRtJ2RPSkhEET2BS82fpv2GayPCnCGxMR66aH/0YHpy8qaoy2bIsxA9VoiIQx0vK2SdAXY6Bzuklb/ax3ao1qxB2QiMt7ktkVyJtZwrCWQ802wbpL0wlJfM0oUauYa1S6BPK+G5NsqMB+YGE7C3pkAIo0mtXSaYxyUAVSW2VWj3E2oZtz1dZ6d6jY5lJSne9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybaz60lPgObJjALvuFbUJNUk2hvE8HGH24rzOkrOWo4=;
 b=UKr9ofj7JeqgQxHbffrfA5G1ek0ASjPydcrfGwAKNgKXZ2eYZZH2jLijSm+7x5POnyN/SFSmGlG5WU2K/A7O2Eq0IB411yC0ToNK90pEseyc3PrnTqGFM5qm+LQSY1Hb1R7wp0r18RqHiMq5bobPe/wJXo3KASg1FtFmIexFv2adyuTMqU6ahfF37xrF3w6OB/sIzRDOndEuKSkSOlYGdbrbv2nlVm4vltbh9n+o1dQRHLd23WdWRSjrWgmY8wNnmsaztO7lwzhkF2YH7PeU5j548bOGx/L2mWFFmFVcrhgPsUPHwlRoFRp8SiVUQqhwtJcV2ALYZC+YDl3BM/1Qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybaz60lPgObJjALvuFbUJNUk2hvE8HGH24rzOkrOWo4=;
 b=VC+2aAMk92IW4YjyKTahm2XESyIxuNG8QalMY2QZhwr+ZqjhPw42175JLHrpSWlpbmrHwxxe2sN1xma6vmsM/s7LVmYMy8jM1wJlIyiApy3KC1GcxAs6oX9SDlNuSpaPeSy+I0e/+7RmMN0cP0l9e9zB/zyPDZ07I4Jn3/WwsRPKD1lEuiVQCLH06yzMNIOk6um9kBsQQ258+m/WDMF6IA/3+Ups9akSg1569XBbcThNttQ9qMOEenBulRjfbynpumFBMS0fDy29zVNxiFIM1Hd6AZB8OoJWzwBEsd5w1L+uI83xnW9YRu1xisT8e1jhbnC2bd8DionMHfOiyjBrIQ==
Received: from DM3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:0:50::27) by
 BN6PR1201MB0193.namprd12.prod.outlook.com (2603:10b6:405:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 07:05:50 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::42) by DM3PR03CA0017.outlook.office365.com
 (2603:10b6:0:50::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Wed, 11 Aug 2021 07:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 07:05:50 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Aug
 2021 00:05:47 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Aug
 2021 07:05:48 +0000
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
Subject: [PATCH v2 2/3] mm/gup: small refactoring: simplify try_grab_page()
Date:   Wed, 11 Aug 2021 00:05:41 -0700
Message-ID: <20210811070542.3403116-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811070542.3403116-1-jhubbard@nvidia.com>
References: <20210811070542.3403116-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d952777-b2b2-43ed-7b4d-08d95c9673a4
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0193:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0193334E870564FBA7442874A8F89@BN6PR1201MB0193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvcWm3QO1yCCdMOjeUYVkDh5NKvu4ER2Dhya7XuU/E3tYJTyXOSMxudmATrZGdw2r6lAk5rbOz3JGoXpv6NCXzQ4EIQSQ4jRe/m+frYblcFCNyBcLjA5exCjb9n0j9+42SX2fTegH3lwaGemgoeKbQnISambheCBadhW0Doefu9su/H10BKyp0QjctKgxrVk6a2c7CuBUqKPs7ZsnoBJw5fuPPNH3dK18iJeNN3Mq1XAZE8jFY8Azu54gVpzRaXpGpVivcrKjE+Fx8kUksaLW3QmAj5UJIQIKjRObf+sTgaxfp9e8ZKDkBYA/6MyfFa6ROKIssrVGWJUeOj9b83AZjezqITxXxD15Docpo26j8aRilhrXyXzyk0LzYHaYQdAGTohjyYlBwD2mLTB3ReG4K0plGipa++73dTttuHL6H+gmZE+WInhFzos5wbbKOv1bOtDFOdeH8mnaV5kwTNSFGvCx+7Aa8+bwXi8+wsN6ex9Sy4VqDKhYLos9c2VmBI8gjvCkMWf4fofqYPBC9DIplFFU/BsZfNirH6K/+XRxtMCnzD1v7KIxdX/vaVDNxvirXoVAj27eDt7YIAxJETL1VmAaSVsM3O3H+HtdYMqGhvY6jAqdPg8PYRGe28Am6CWd925zjCG+Btlkcnd7vsanf0kXllqIhJh4/UOvpTiqlvByM3h0eGRiITbqK3ggFt4qPAv8yR9N6ETjpBKnIOQqQ==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(478600001)(54906003)(426003)(1076003)(7416002)(83380400001)(47076005)(82740400003)(6916009)(2906002)(5660300002)(186003)(2616005)(36756003)(8676002)(4326008)(336012)(316002)(356005)(70206006)(7636003)(70586007)(86362001)(8936002)(6666004)(36860700001)(26005)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 07:05:50.3535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d952777-b2b2-43ed-7b4d-08d95c9673a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0193
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

try_grab_page() does the same thing as try_grab_compound_head(...,
refs=1, ...), just with a different API. So there is a lot of code
duplication there.

Change try_grab_page() to call try_grab_compound_head(), while keeping
the API contract identical for callers.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 52f08e3177e9..64798d6b5043 100644
--- a/mm/gup.c
+++ b/mm/gup.c
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
+	return try_grab_compound_head(page, 1, flags) != NULL;
 }
 
 /**
-- 
2.32.0

