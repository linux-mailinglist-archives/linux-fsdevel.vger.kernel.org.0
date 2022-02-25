Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5844C4081
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiBYIvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbiBYIvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:51:08 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8161768DA;
        Fri, 25 Feb 2022 00:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrIlI6LmgXIJlvEhBKBeleuNbhB8S+2Sz/uE5ik1xiyvDseFkwUIy5/7mvxN+OBPn/E1eRjyNbCOUfZZhX7FDiNVxKlensBMGhEIl5lChPnfrkNyYRe9BVDuu6YDwPRbhgCIvaO7wZQosJQiWF1gMIUdGSzwxPQh5cHg93ZkaSzqWwe/XS6/OsyXvS0FpgFtmjnYlwwzrjEazbhePXzrroEDaNJI0AvvvsYGzk6bSrUA+OuIC0RPrFoI2BGdWdigjop8b76LRsK3NGgRZ4tXImTbmySPBw3cMiAhipUgscJp2hJzLpcjKzXpyn6MHEx9BkfxULnAxMrG8EHdnbVRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa+H/fbjV0fLvDgOl8iwViOqTlta9iVUjSg5NEzHQXY=;
 b=gFhhWgLj5/DUcALqZDypwFt9pQDxot2CSnch6BQqv+XCd5V/6xVUJb9kwnhfqz1i3KV47l9zqTLMmNFzeRnj8F8iAGEg7yb40BwKyxPj0fB4UUoB3vAPxW534svUN0Yp4YJAQ623UD9PPUBXuHnK9B1YSIWQJnsRKFlFbhazhQb/umyxVkQDk1Wn/20vUE4j89+q4Os+4U1omyAJNKVPHkffCaiAKPCyPmwTfOti2TYoYM0UXBsM7F+Ke4yv7mXVL7nDnSIoHCWQGK3RaK1MxhsSp7Hs7abxfUaQyc1Of1XDlXc/cxSbrSVRGzYSGBQIZSJ6pkP7yKushmM0hl+00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa+H/fbjV0fLvDgOl8iwViOqTlta9iVUjSg5NEzHQXY=;
 b=KDdhhE7hRTl5ZbZNSFRYP2njHiKEf/FTiJARgU/gnqkMXHs1jBqZGQtez1l2XWdtqXpizg2CGyrLUC1yNRikuISmGil2yPQPLhWt3OjrIDlyDit39H+Mv7QqZ+rCfbpVZmC0I6WfZAfju9feToMLROLfl29XVqNGNN1SaXIRNR6TmFmFh7Xo3cszEe+mg1Mq5NaDdDAIIS5Oeq3APGhsIpW+ppVLVIs7x/g0awLwlmqwIJYAunvW8egBbyp+dOwUQfY6cq8trHl91reIQC8GBlRkKjnyJYwmQpgbZW2bpVl6PuhgNyKv0NwSl03kgIElrRoTsAJcL7/3cZPVyVpy0Q==
Received: from BN9PR03CA0790.namprd03.prod.outlook.com (2603:10b6:408:13f::15)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 08:50:35 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::ab) by BN9PR03CA0790.outlook.office365.com
 (2603:10b6:408:13f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 08:50:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 00:50:33 -0800
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 00:50:31 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
CC:     <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 1/7] mm/gup: introduce pin_user_page()
Date:   Fri, 25 Feb 2022 00:50:19 -0800
Message-ID: <20220225085025.3052894-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c8acfe7-76ca-4054-9073-08d9f83be34a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5094:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50943311E351EA8D0DBBF112A83E9@BL1PR12MB5094.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sl3jY+YV8dP/1Cx+ZRwSk+sHTf/28FG9t8fcujr/Gi5Rj8Ql2gwFA2W4AoOxzdcSQ8R/Y/uORHA7tKMQ9iiw6b3zppi1MCjfMtiDHypAbRd5dgJKGNvFwEGDKvkhFyesquuhmzrzmmGEtSbT8QkS9gGN+d8TcvwJWaW66TFgXHwCWF6E2uxEkbpPdxI596Ym16Y4KWEBbm+JQ0Xm1pbsmjkNSWJo/ZXfecQUc8vltUQaY4uOYilxYA3H0UOddatEBqvOqwWOHz3nr2kAd8EbtqWT+lNQRhwbmZrAG5LoJWRPR0vVPvtpPC0m5f70kzQNg3GVFclYIgsNZ5/qXvtD6gTjVCCvqiGNIlYUH39hewP0Dg+517dUjefgImEKKVA4hnS9At1voy9uvQCNqsJG1sY8pxYNFQK6kJ+nkWy1wXd/Pxc0I9ys77EyakvRnkO30UAtIdkS17FA7SxtY7Xi3eo+7agB9GSUgzi2F/Gb6qOqYLQiG0qbFfJq2nDOjcknpPt/fK+4Wm8RpILGsG3/G/4dmwO713NgrcHfXxu37FGdeAWYxIrg72ONywwx6rxBYZzQftFK5PT8AxINPEt5O9iJ+tjg7i8t7RBd4XcrQVBfLi7jA4co1zUHMiOVu8/w6AXJyU/NrP3NTXkxLsBE6KilA60Jz3y66FGlqdFo24XacqaRtb3pllrN2TjIKxxULkh/cg4xmZOSLNzOK5r0FVT4hSBUL4+R0IxVy979IJk=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(8936002)(7416002)(356005)(921005)(81166007)(5660300002)(508600001)(86362001)(40460700003)(8676002)(70206006)(70586007)(47076005)(107886003)(1076003)(6636002)(2616005)(316002)(336012)(426003)(186003)(26005)(2906002)(6666004)(83380400001)(36860700001)(4326008)(82310400004)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:34.7990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8acfe7-76ca-4054-9073-08d9f83be34a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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

pin_user_page() elevates a page's refcount is using FOLL_PIN rules. This
means that the caller must release the page via unpin_user_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 929488a47181..bb51f5487aef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1914,6 +1914,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 			    unsigned int gup_flags, struct page **pages,
 			    struct vm_area_struct **vmas);
+void pin_user_page(struct page *page);
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
 		    struct vm_area_struct **vmas);
diff --git a/mm/gup.c b/mm/gup.c
index 5c3f6ede17eb..44446241c3a9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3034,6 +3034,40 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(pin_user_pages);
 
+/**
+ * pin_user_page() - apply a FOLL_PIN reference to a page ()
+ *
+ * @page: the page to be pinned.
+ *
+ * Similar to get_user_pages(), in that the page's refcount is elevated using
+ * FOLL_PIN rules.
+ *
+ * IMPORTANT: That means that the caller must release the page via
+ * unpin_user_page().
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
2.35.1

