Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0B5A35E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbiH0IgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiH0IgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:36:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C270B08BA;
        Sat, 27 Aug 2022 01:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0QQz/FkFzjCALlCPcJTEURzDt2s/MLKPOgo0rOP5sZ0N1I5WxldqOIy7HZRaG2OIESxRL35viDpiG0sBg4JA9nRmy05N0c2URY9VFq8Tko3rWsX4a5enxg3+sTpaXTnKnhj1sXmFzwl1mcqDF6TwEHIC1+CEtRRO2deQZVNp72BqpdKiiSdD4l2VVyaq2gcuSkKhcMmLtIajhWw1WWUV4avNiEiyP0QVj/bOJgL+Q3I6IB4oB9rBFLH+irp0G7t3XrUOR83FJDnXyEKe281L4Fc53dDR1IaGp4RG8L7bZQPGi0Aq0zgWdxngGmcgUgPBIQkYxhOdfGmjM7C7bdbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6juzxIN+dbVotM4FaLX0WTWAvPmSGnE+qYMrVKn5mE=;
 b=WlwNBc0zGqhVFyz3ork5Cha4bhOF6xPbulatdQ3k6FzCk10WMWdFGVk9a96+Kneo1vzYd7H1zya/qt0wgO0+rG0w//OMUiWER8+8FHSjtRcx9oQ+h0pUO3tzIL9C1WN4e3doxGM4nuWSzRCFIAlxTwMFNQUS7sLW4VNIZFZ0GKl/uIVr5WYNNuxFkpgvMbC67aj4/Xo/liSQhmIJx9Dk5GNM66S9UaUgzs43tihKpPGQHz8wHMLIdXwmsi+9uylvh93cURdtQnAmTYkSfwXoSAAyvxC63akzygBYJe2PMLZIFkICLYn6T/ymjxoCJUeOUu1DRvbyCpuUD98hRIZE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6juzxIN+dbVotM4FaLX0WTWAvPmSGnE+qYMrVKn5mE=;
 b=cGOp7gbrsET+75dtjHxMgRnH08IDxpuQbg5V1tCNMBL/kNwgJc0JYrT3LhhkfI0w2Lo/If9sIVBpyaevu/75IVQH+ZbcikZLB9X3Heoh2xqsFbqiEnbMFmPmSATda7jAJvz68Quk0E8FVPRV+y3TlyRRt8cOUNYvo9kdgzgZ4T802MjYql1wgESW3dyf859jwgiTniv5n4QfUacDNrxy1+HH+9yDIiB5xjy0R9XtuLu+M6G4hiFO1I407/uEn1avJr7NBDKQ95Uey2Y8bBPXH4vI5qIPx8tD00uxyY5h8ezTKtu4YxX5fSlP8nL8MphL4PYYf+QYnlPgcvSdvsKSzA==
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 08:36:12 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::c6) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Sat, 27 Aug 2022 08:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 08:36:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sat, 27 Aug 2022 08:36:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sat, 27 Aug 2022 01:36:11 -0700
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
Subject: [PATCH 2/6] block: add dio_w_*() wrappers for pin, unpin user pages
Date:   Sat, 27 Aug 2022 01:36:03 -0700
Message-ID: <20220827083607.2345453-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827083607.2345453-1-jhubbard@nvidia.com>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c80ba3d-e36b-4be8-f9a6-08da880732bf
X-MS-TrafficTypeDiagnostic: PH7PR12MB6718:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jx7dtFz53tTiOMq5bP8R6GG/n5j0MAjZq9JQWYUEIo4hKL0vrsAHVI/W10uxpuzSVMMq3Z7uZAc35bDAGua1gfhgvFQ8Q9v+QjXYEkwFYfRmjoVyIKmR6a4ywpw1ZpiRDRrMq+kDAPXmngZE9JS8CUmJTL+Sa/gpa+oK90f59M4PEDunl2Tu5NgIn2ZLSNVCmGtbFWFRt8r9/gKtffUhN3h5bHCA4OF754MWCfof3o28W9HvnV6v1LFDyV3kqE7eYkXVLdVu41m0XRUt8/rfYGkGcc2DpUUDT34+fMiplO554QCBozu8C+/YP/rE0TXPp2F8rD//oEGDV0qtO0XJfQHBeJpV2omUGqeveMfuSL+ImPUO8xnAtncDSI9tVv7/A4Ce6NwrQS41xmRmyOXZ3CZXf6zU6SoTY9rAtOXCoGQ3ochiUnAt+ejiC9FG1jh6xdodDA83C+zfAxWec7CU24n+wYYc1mp6HkGOdq9U3/QjL/6KmMQ8HUFYwbfuL4ed2FkWCoebIRp/uiIXahjBHK1BRF4TrdSvr0ETLlH/kp3zjmjKMWmJIC+mim/jZbOirEKl0Q13GS4Gcq+NH9BZo+rrcfuZtR2AK53ZLEtZ0d4T/ZCuVCQKnFptRX8pubAptyAY8QBS+sHJ7bDb7zXLopTmAC1Ns0BIwOWRFTQPndR1O3Wadg5yWQreaYEXJmK1Y1IxF78Nf6wciZqKKIcQkQlAcEPNNaY5d0zKyfBmRmO0aYcvN6D5C/TNmMhHrEf2MZ1op0ZfAeIi7JEjfLRUzLQaySv+vKp1kF72579POtKxMNtoxG/LSbmYqck3rfN/
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(40470700004)(82310400005)(5660300002)(26005)(86362001)(41300700001)(107886003)(6666004)(2616005)(82740400003)(81166007)(356005)(83380400001)(40460700003)(336012)(6916009)(426003)(47076005)(478600001)(40480700001)(36860700001)(2906002)(54906003)(4326008)(8676002)(316002)(70586007)(36756003)(70206006)(186003)(8936002)(7416002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 08:36:12.2843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c80ba3d-e36b-4be8-f9a6-08da880732bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background: The Direct IO part of the block infrastructure is being
changed to use pin_user_page*() and unpin_user_page*() calls, in place
of a mix of get_user_pages_fast(), get_page(), and put_page(). These
have to be changed over all at the same time, for block, bio, and all
filesystems. However, most filesystems can be changed via iomap and core
filesystem routines, so let's get that in place, and then continue on
with converting the remaining filesystems (9P, CIFS) and anything else
that feeds pages into bio that ultimately get released via
bio_release_pages().

Add a new config parameter, CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO, and
dio_w_*() wrapper functions. The dio_w_ prefix was chosen for
uniqueness, so as to ease a subsequent kernel-wide rename via
search-and-replace. Together, these allow the developer to choose
between these sets of routines, for Direct IO code paths:

a) pin_user_pages_fast()
    pin_user_page()
    unpin_user_page()

b) get_user_pages_fast()
    get_page()
    put_page()

CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO is a temporary setting, and may
be deleted once the conversion is complete. In the meantime, developers
can enable this in order to try out each filesystem.

Please remember that these /proc/vmstat items (below) should normally
contain the same values as each other, except during the middle of
pin/unpin operations. As such, they can be helpful when monitoring test
runs:

    nr_foll_pin_acquired
    nr_foll_pin_released

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/Kconfig        | 24 ++++++++++++++++++++++++
 include/linux/bvec.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 444c5ab3b67e..d4fdd606d138 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -48,6 +48,30 @@ config BLK_DEV_BSG_COMMON
 config BLK_ICQ
 	bool
 
+config BLK_USE_PIN_USER_PAGES_FOR_DIO
+	bool "DEVELOPERS ONLY: Enable pin_user_pages() for Direct IO" if EXPERT
+	default n
+
+	help
+	  For Direct IO code, retain the pages via calls to
+	  pin_user_pages_fast(), instead of via get_user_pages_fast().
+	  Likewise, use pin_user_page() instead of get_page(). And then
+	  release such pages via unpin_user_page(), instead of
+	  put_page().
+
+	  This is a temporary setting, which will be deleted once the
+	  conversion is completed, reviewed, and tested. In the meantime,
+	  developers can enable this in order to try out each filesystem.
+	  For that, it's best to monitor these /proc/vmstat items:
+
+		nr_foll_pin_acquired
+		nr_foll_pin_released
+
+	  ...to ensure that they remain equal, when "at rest".
+
+	  Say yes here ONLY if are actively developing or testing the
+	  block layer or filesystems with pin_user_pages_fast().
+
 config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
 	select BLK_DEV_BSG_COMMON
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff651a..33fc119da9fc 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -241,4 +241,44 @@ static inline void *bvec_virt(struct bio_vec *bvec)
 	return page_address(bvec->bv_page) + bvec->bv_offset;
 }
 
+#ifdef CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO
+#define dio_w_pin_user_pages_fast(s, n, p, f)	pin_user_pages_fast(s, n, p, f)
+#define dio_w_pin_user_page(p)			pin_user_page(p)
+#define dio_w_iov_iter_pin_pages(i, p, m, n, s) iov_iter_pin_pages(i, p, m, n, s)
+#define dio_w_iov_iter_pin_pages_alloc(i, p, m, s) iov_iter_pin_pages_alloc(i, p, m, s)
+#define dio_w_unpin_user_page(p)		unpin_user_page(p)
+#define dio_w_unpin_user_pages(p, n)		unpin_user_pages(p, n)
+#define dio_w_unpin_user_pages_dirty_lock(p, n, d) unpin_user_pages_dirty_lock(p, n, d)
+
+#else
+#define dio_w_pin_user_pages_fast(s, n, p, f)	get_user_pages_fast(s, n, p, f)
+#define dio_w_pin_user_page(p)			get_page(p)
+#define dio_w_iov_iter_pin_pages(i, p, m, n, s) iov_iter_get_pages2(i, p, m, n, s)
+#define dio_w_iov_iter_pin_pages_alloc(i, p, m, s) iov_iter_get_pages_alloc2(i, p, m, s)
+#define dio_w_unpin_user_page(p)		put_page(p)
+
+static inline void dio_w_unpin_user_pages(struct page **pages,
+					  unsigned long npages)
+{
+	unsigned long i;
+
+	for (i = 0; i < npages; i++)
+		put_page(pages[i]);
+}
+
+static inline void dio_w_unpin_user_pages_dirty_lock(struct page **pages,
+						     unsigned long npages,
+						     bool make_dirty)
+{
+	unsigned long i;
+
+	for (i = 0; i < npages; i++) {
+		if (make_dirty)
+			set_page_dirty_lock(pages[i]);
+		put_page(pages[i]);
+	}
+}
+
+#endif
+
 #endif /* __LINUX_BVEC_H */
-- 
2.37.2

