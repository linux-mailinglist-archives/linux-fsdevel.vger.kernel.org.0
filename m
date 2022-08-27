Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9A5A35FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 10:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiH0IgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 04:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiH0IgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:36:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E9B0887;
        Sat, 27 Aug 2022 01:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAJdBdWOI3pDpYQqb7bGq8aMPrUPBUqrHObEO7HIuzte9iX+cDJiX6+ChHnthHuWlcZp4c46+YLhvMV3J1kuN1DAnFyDKGhnWqopRleHxdV1vJz3wjrtvkdiFGP4nbC2h/gcjsTQ2xZZYPEdWk/Ci0vBHzKNV0/fTN7IZe+tRTuKU35nAWgkCniz0Q3LzGP90eoV/iO+nckrVT3Xe2x0Gbn9i93reBvTvU+Eq0dNpQ5jym1ZLfrYYZdVoFS8wsYOuwdTvP7hBq/XqHnCge2Y/3Xru1ujwsGuSMOdoiAM/dmpHdX0z5ngeAMbrmtdTMTSXxzT1VvJChAFi8suBDA0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO9IhewdmpPOqvg3QpSZ5kTO1SJPtnuFZRi+d4vMGI4=;
 b=O5+JbVTMnM3QYfSOa4LGo5c+9DLOyEg3GkOF5kPSeCogWj2ne0wWZ6LMkQADg3A3RM7IQ7SDxZwTUAVEd5HaKt2pfjo0/bJEC5CIXUsJR4VenzPuKLNTUH+tSjq+aoySaTXfpcw+YUgEIdrpHfBiYyg/NVS4S9w0RLmilc4jtqePcctFPRkqm/MpIlR8lM19e5eQqRFWtKqY9FmQggTVKqcReOMh7cU/TfHzbB617oEX10LzirdE+Iaur67vby1Z4XTuZWYsKQAakcKZD82RFcDT+6xWwPefXULgSc3fuLu1noXN/udzDVmg/BRwAXi1xDghOx+yl/ngCjuzCKq5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO9IhewdmpPOqvg3QpSZ5kTO1SJPtnuFZRi+d4vMGI4=;
 b=ePgpzUylfyGRiv8r47Kk55aMbrdcsdCdGrWr0bN2dNtm1rU3HU+WfB/1iKO6h+U1LuHyoKnYvUHPurCp6IXYfJOAVFJdC/yVPFhbLF6VZwgVTphMBAPnCd13MhKBkVKPhiPBSTCTuLZJPEkobcFefhRaDkJZyvvD17kGLd58pBFpyuce3KarbyS6j1+cppmzLHUWGNbUXEBkqBS56YA3WuJeZxgWcqNNC8WnRCMO2WTNQ3v1gXpABhmHrp4nrqlrwtk/asWJphTRIsZSvmhiO7CjTLoLjlO2bYzzPZ2XjpDG0awDTc67Ybp6a17USVR4VS2y/0cxH/Qg81tQFPYjJw==
Received: from DM5PR07CA0092.namprd07.prod.outlook.com (2603:10b6:4:ae::21) by
 PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Sat, 27 Aug
 2022 08:36:12 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::a9) by DM5PR07CA0092.outlook.office365.com
 (2603:10b6:4:ae::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 08:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 08:36:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sat, 27 Aug 2022 08:36:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sat, 27 Aug 2022 01:36:10 -0700
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 27 Aug 2022 01:36:10 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/6] mm/gup: introduce pin_user_page()
Date:   Sat, 27 Aug 2022 01:36:02 -0700
Message-ID: <20220827083607.2345453-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827083607.2345453-1-jhubbard@nvidia.com>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64fbdea3-33e1-42f3-e854-08da8807326b
X-MS-TrafficTypeDiagnostic: PH8PR12MB7027:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnlb2BznKuv8HSR/mOMAdLL3epBJdze+9vbcf+5R1g1XlS+98sCJbl1S4qPk+1WdMa8i82GsCphaSdMgT+43MrcYVLxMY4LmSP6zn2AzLJa28esn7gqkx20aO+nRwTWj4+pD5raxucC0Xp7lIxtFtTiISaeGPnmS2cFK1qoLHqsU6rW5AYY0AWZV9Kqt5zS9ZAFHFjUaumIC99/dcjEyDjI6W3btlj2lbRaUXil/NseqpUgUBAxG7dR4pe0WwCTzfxOSPdeAbQnENJxc6rGj2GLnTKTXx56JZil30dezGUXxOSAJliQgna0OPaEOfkUWm51NlgphKLv1EWd0ODFqIIExYXgIpKmdDcHerJIEJOC1MkVt4P2m25/4viCsQyVAJH6nI9zBEGVeDNVEH4kefpBdLMwyj6AQwSpMC8X1+k8wD/T1sXrm2Z74nbaDqpCmXaxCVZv6CyVQA356qVrHXAGmgnQppWw5hhdnEx/e7R+Q9D5WmD+El0QAOgFEBPIQj9fFjh2V8I25EjSWtURVQBN1NOc9y2mnIZz/2HqXy1G2+qbj7vWUcauZ62RiMoCpCUVHF/iP3LYwvvy6Ho4C0F7s4MmEcvbZAX6Rg59GveOCyJ4CzmTFscuJfagklCSfH3Q9N92d1BvKTNOYg6RKI7Ou9B852gNDQVkDl2HqYgxxS3du9NZJrhHoKe6VJoK79kU5oGqN/Fe3mM1mMAKJ1mHJMqWT9zfUK8LjazyDzHGalG3U9LGMWnrsejcDLDj6KGok4NbLzoZzE/GYdQ8w/y/f795NSfRHBbJZiDhTvF6NZt/95KO7VfQIyGQBNiHm0o/l7zlEYGcDUcje3QI1iPsp2Pz/fh6FgqRYceUmbC4=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(40470700004)(6666004)(8936002)(81166007)(4326008)(36756003)(7416002)(8676002)(40460700003)(356005)(82740400003)(70586007)(82310400005)(40480700001)(5660300002)(186003)(2906002)(86362001)(70206006)(2616005)(1076003)(47076005)(426003)(336012)(26005)(107886003)(83380400001)(36860700001)(316002)(6916009)(54906003)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 08:36:11.7334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fbdea3-33e1-42f3-e854-08da8807326b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pin_user_page() is an externally-usable version of try_grab_page(), but
with semantics that match get_page(), so that it can act as a drop-in
replacement for get_page(). Specifically, pin_user_page() has a void
return type.

pin_user_page() elevates a page's refcount using FOLL_PIN rules. This
means that the caller must release the page via unpin_user_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 982f2607180b..85a105157334 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1869,6 +1869,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 			    unsigned int gup_flags, struct page **pages,
 			    struct vm_area_struct **vmas);
+void pin_user_page(struct page *page);
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
 		    struct vm_area_struct **vmas);
diff --git a/mm/gup.c b/mm/gup.c
index 5abdaf487460..245ccb41ed8c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3213,6 +3213,39 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(pin_user_pages);
 
+/**
+ * pin_user_page() - apply a FOLL_PIN reference to a page
+ *
+ * @page: the page to be pinned.
+ *
+ * This is similar to get_user_pages(), except that the page's refcount is
+ * elevated using FOLL_PIN, instead of FOLL_GET.
+ *
+ * IMPORTANT: The caller must release the page via unpin_user_page().
+ *
+ */
+void pin_user_page(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
+
+	/*
+	 * Similar to try_grab_page(): be sure to *also*
+	 * increment the normal page refcount field at least once,
+	 * so that the page really is pinned.
+	 */
+	if (folio_test_large(folio)) {
+		folio_ref_add(folio, 1);
+		atomic_add(1, folio_pincount_ptr(folio));
+	} else {
+		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+	}
+
+	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+}
+EXPORT_SYMBOL(pin_user_page);
+
 /*
  * pin_user_pages_unlocked() is the FOLL_PIN variant of
  * get_user_pages_unlocked(). Behavior is the same, except that this one sets
-- 
2.37.2

