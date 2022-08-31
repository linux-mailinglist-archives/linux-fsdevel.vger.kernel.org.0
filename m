Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481A35A74C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 06:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHaES7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 00:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiHaESz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:18:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D046A99C6;
        Tue, 30 Aug 2022 21:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWQSHQYx708MVm7e09IZuA6TDoe0fBNx3KZydn487SxuAtzJQM4COgkHCJCCZIl1Oq3tzHwjew0hsc7mTLsgFaM3yLa2tGej3Qaptag4tVVyLIoyel5QcqzKz85FzUFersDhsvaCDrs4+tA1MjEgkqcCfu6nxpQTw8w9MA47FkPB+2zgO4aFJaauEgwiE/SCjIwGh73KsoRqs3qRVljGvEuDtWPbvE0lnNjeAjftdzJRlkkbMXrFt4KP4580cOwmJnwfU3z1WA6rwND3ByvFlgchy29r5bHnPDzMNNNTzgdzo1c7XQQCrifZ4TZpVtC0P+Bip1+6HU/SFuJw0JWKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh2ml7UalEADJoQQ8FstIf4E+zz25vcwC1vh2wcDjBs=;
 b=Gs2WPg8yK8aGbAfY40l73CXArIDuKQLNH1AfObthG0UnwPh2iQ1B19wtn9r/5fTJdBHWWpd2Ndb8Di4avdDK/ETSDkRFSJ7OZ70MUMeQfL7aTMtmxwIcLo2otiw6oGdn81ycCg+stporeiKLizvwjoRtxh5L4kIFY7dFWsHm5GlJWQCfrAUnNcTbjTVqdTHyg5VM2JftG98l+w07+KO3qWrCmRvo0nrB8TyYiUPRsu5Pgwd8ZQ4/fREL4M9kg6RqShw+088JPtG+bHwlPKTAQK+RL18JkwQd8yU0N9EQ0JYjFFLqVMSaItnFYzO5tVAuZPikqr5bxoMiM17lEzkZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh2ml7UalEADJoQQ8FstIf4E+zz25vcwC1vh2wcDjBs=;
 b=dWncy413i2Rv7VVHyVeqvmmHCb/TvGfWKBWpuJ9yUT9LOpYdvwzKYZEdPJWIOv/eOOsgAgZSE5AQmUCIE44iJiY0MFVQq9wTzDyDpnwy4OSPCqhdBZtZHFDjHcZeEVizHIY2lpvltb8JUKYXyTv7yIzkxR95nerEJ+OYgBF12vp1/XlVgi6vaIW2ITPZvsmKRde0Ciqy8nnn3FgZfenThl+0GY2YqTiQ6OdFNH7GJCaSD70TIhgcqHvmHRp7OHU9Sv7JLvX4NvL+7ghJMXuAu5IQoJbrtjyQPsbjcX/Qfqs/G9w7XB5BxzQZ1SYv9tnnnQPoPBJXnhT1ZaNEY1rlqw==
Received: from MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Wed, 31 Aug 2022 04:18:52 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::a0) by MW4PR03CA0162.outlook.office365.com
 (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 04:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 04:18:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 04:18:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 21:18:50 -0700
Received: from sandstorm.attlocal.net (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 30 Aug 2022 21:18:49 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 3/7] block: add dio_w_*() wrappers for pin, unpin user pages
Date:   Tue, 30 Aug 2022 21:18:39 -0700
Message-ID: <20220831041843.973026-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831041843.973026-1-jhubbard@nvidia.com>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f22beff-c2c4-4a57-c55a-08da8b07e93a
X-MS-TrafficTypeDiagnostic: DS0PR12MB6416:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVoJlapBVYz7mktkKg4V7KA+LCMYzZqJxl01XKuIOAW2W6mfIu2bN60sygfMSyVc20pEm93mCCuk464EKP0z+48Sdemg5TPkB2cyBNztwbr8lUvOVFDCi8rmieNHT/Q8n7dS6rBXgnDRC2ofYm10K8r4YHc3cEpsrZZuO45C4TyjP9kGMRwx7AYBoM+GM/l+ai5tNoitg8TAIkwaZfGUGUxh8owA9MuaVmAh5afuggARUCk6tBNBemRs/MR/OKV6Z2cANU9Bwmky8hpgFRDyA959qQbHoTJF0g8ewREewic6V2KKg0QZHPO/PWMRanR31D4pbJmNmI+V5oEka1B5U1JZBSRkcyR5hOjWdCoXa2HrkVep5sIIrJ+zzg571TCSbjnzSveNTQ3FkXCkKxs3x0yw/ffoep2eWuDG3EObNdReNRqg7IeQTKBWGNNsIQ6nf5UVWsmXOtimqRnTey1rg1ZtaDgs07tSrB/icdWW2Tf2MRAJEjF69v9VvLGZePeEdC2szFBR6WNPTMqsVcCAhnk2ihqBP7ut8xB5F9nceMejdeR//bcf3J8cKALFJTI5WpVGK/+fBjm16Dutj3GN7b0r3OipaHOtGNqiPbGZ3lqte2SqEO7nlVw3fcXa7Dy2v4KIVArUIOEU5QKBIvJDaj2KE01rTiSxTNxCxzpIYX+4IV8p7+hF5Xd1oGcCXcaXOUG2NYUNgXi7YG8RQ7HWyJWaCrvt+XDO2n7B8xD9Y3oO3YnzeuBsWJBuDElS9TdJH4wGGPeZa4xKyxqhb1QqKU0lXq8Nyx9aOmr1qCPI/+ArRfRysPV3A5XXdUCiaHvJ
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(86362001)(70586007)(54906003)(316002)(6916009)(70206006)(36860700001)(81166007)(356005)(82740400003)(83380400001)(336012)(5660300002)(26005)(82310400005)(6666004)(41300700001)(478600001)(8676002)(2906002)(7416002)(4326008)(107886003)(8936002)(40480700001)(2616005)(426003)(1076003)(186003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:18:51.8759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f22beff-c2c4-4a57-c55a-08da8b07e93a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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
 include/linux/bvec.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index 35c25dff651a..952d869702d2 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -241,4 +241,41 @@ static inline void *bvec_virt(struct bio_vec *bvec)
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
+	release_pages(pages, npages);
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

