Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D644C4096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiBYIvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbiBYIvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:51:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB60E177D3F;
        Fri, 25 Feb 2022 00:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzODPZatyn9W0Fjj7PNYZPtgjou+HfkkWOMOk915RdLejpI39ZqHGopKxsWvfWFf7q6veCcuj8Apyg+4UQonViQSe/m4G7A+jImdlNIW/9moN4gGGT7EIe+yvI1Py37VD9nG6tt9wgi+ri3S0GBykg+Hrk0y4U/pn59YW+++Te/KKHAd3QQ6KuByYfbiu9lU0/oFWeQNlyVpm7zWxkFh+HPLUyHw/3oDOEX+SR5RBJ2yGBpCOzPeT/D2rEe7ws2NicDbrzXzKYOg+x6J8ub90dFMrYqtdCDWgKFsSsdllC6Djp4D9v3Rkwq8ob3BW7Hm0V6dfmrBy2aj1j00vbYkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVjachwLZOJaasM1HxAYAlh+fxfrxwqQnXama3fFC5A=;
 b=ZvvE3gAjRZD6lkDf6bp/VvilesY74JFtFJVK8lP4sJf5cHb1ISF/3bgejS8VwMNP2QeQa39wUl/ZK9maOvC+e3Psgpxk7T6I/6T5Bd5Fw6PxyypwH56xxoN1KKIB4j/e1L/2VDSlSgSYnPJXWAbr0r2NiaYjVT5aklWwUt+1C4wpylkPofOLcFwCHgpNmW+D6Z4j60vrWC17zvplbX62/lLIzkmRgEVuPgHYUNO2bg3Yf2orHzWKEhyvTszx5ouJv8uTSrKctIzgyryhH4RYorsrFMRz212az+eaG1zEsC5gpY8bZ7jlIhcOhnVhhk6w1+u03jlRJHwvlQrqZ4E3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVjachwLZOJaasM1HxAYAlh+fxfrxwqQnXama3fFC5A=;
 b=Zve+2qknEQaTEYfdwjqqoB7LB8CZjjmFxrhuc3oz3egNKcdqFqHa7Wixckcz4FMkeKnTuihuK9Ow/bhYkFCWtp1csu+piBVAdlXPzIloOZmXuf5TptO/xUtIyJPj2yN9k/7j9DTrcyAM1ZoNgH0RQc4DErdFhbUN5lP/KknK1lPgVZZa2EZWDf6X0FAn9Qyl7ztQ2V3NvnpVWbaqN0JW92GKUXndT7PaMDhMDLk0Dq9+1rMjgf2qSQ+ODj5lBRpLnplNVEQFinAYoYfGCQXtDyWYzYh2QI0r2nIs+iKuAWNUHRz8zpbQM9IgDtD7XkTon4zN5ym55dQe6+6AjYqktg==
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by BN6PR1201MB0180.namprd12.prod.outlook.com (2603:10b6:405:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 08:50:48 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::43) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 08:50:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 00:50:45 -0800
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 00:50:44 -0800
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
Subject: [RFC PATCH 7/7] block, direct-io: flip the switch: use pin_user_pages_fast()
Date:   Fri, 25 Feb 2022 00:50:25 -0800
Message-ID: <20220225085025.3052894-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6480806c-cca4-4a7c-20ec-08d9f83beb12
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0180:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB018028CD70BE9A65D9042189A83E9@BN6PR1201MB0180.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lv1rCmizZyWkMNp8GC3k5HyeJ/MMauJ+khLsMeeEYr3My1wa3QL0fdCQFQ23HHqE7WbShOdxgO3/+QGrSOZ+YdeRCRKuDx18PQpVt6QwRqvlYR8TIA82pe0sqJXXgoW49SMM190IM8YZlMTa0ue/j4PXBr7v5D6StzTIjIPHxf9u+PibqrvSkOOZm+QwKwdd/DKQs9mYPLoR4ao5fgz2treiO9ZYnCSEz7f4GokGtu17y0OGMtLAjba2JEncRfcxtwcr2txPuiCSK/XlDUs7C7e+Fa3BmiWwbZ2ZMwtdYFxFAUcRCCxUJglPlbbz+pj4YFnwibpAR1lktacjqpr/X+LPzHxqWteir+V4HAbHYufxqPMvBxyw9lBTvlqxOKQlMZI6e9NiWUkvEFhK1ibu0fwVEnEBPdoFxiWjRRZ0SF+clBeWOSgLhiXI5bbBM29IJTCuzm8BwDov1MO4oxicQa1Nd64HxuNMjGOtzwjZcuRxzzGyvZJGdqvY+oazJoVeizRu8HPSxXd/xqgjyKJgK2a3EvDw9c3YzTOPmAh5+9oXTGQSHpUS4194VBy24VALZO/CeGHuVD4S5uilFwZLjwH+xmuD0fZjIXXx7vSKgAxwA51n4KkinxTtqpxKbwelRdtbgOe+XvUkrm9AibGNBsvW/OFUGCg33qb9VIcyw8+iizU15/sdzHLefCKDp0RB/sSxiU4XngatORUXOErV89OB1FVyj7MhCmMiiPUs2RM=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(82310400004)(336012)(6666004)(40460700003)(110136005)(6636002)(316002)(54906003)(36860700001)(2616005)(1076003)(426003)(47076005)(186003)(81166007)(7416002)(2906002)(36756003)(508600001)(70586007)(356005)(921005)(70206006)(8676002)(86362001)(4326008)(107886003)(26005)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:47.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6480806c-cca4-4a7c-20ec-08d9f83beb12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO, but leave the dio_w_*()
wrapper functions in place, with the pin_user_pages_fast() defines as
the only choice.

A subsequent patch is now possible, to rename all dio_w_*() functions so
as to remove the dio_w_ prefix.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/Kconfig        | 25 -------------------------
 include/linux/bvec.h |  7 -------
 2 files changed, 32 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index f6ca5e9597e4..168b873eb666 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -50,31 +50,6 @@ config BLK_DEV_BSG_COMMON
 config BLK_ICQ
 	bool
 
-config BLK_USE_PIN_USER_PAGES_FOR_DIO
-	bool "DEVELOPERS ONLY: Enable pin_user_pages() for Direct IO" if EXPERT
-	default n
-	help
-	  For Direct IO code, retain the pages via calls to
-	  pin_user_pages_fast(), instead of via get_user_pages_fast().
-	  Likewise, use pin_user_page() instead of get_page(). And then
-	  release such pages via unpin_user_page(), instead of
-	  put_page().
-
-	  This is a temporary setting, which will be deleted once the
-	  conversion is completed, reviewed, and tested. In the meantime,
-	  developers can enable this in order to try out each filesystem.
-	  For that, it's best to monitor these /proc/vmstat items:
-
-		nr_foll_pin_acquired
-		nr_foll_pin_released
-
-	  ...to ensure that they remain equal, when "at rest".
-
-	  Say yes here ONLY if are actively developing or testing the
-	  block layer or filesystems with pin_user_pages_fast().
-	  Otherwise, this is just a way to throw off the refcounting of
-	  pages in the system.
-
 config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
 	select BLK_DEV_BSG_COMMON
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a96a68c687f6..5bc98b334efe 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -241,15 +241,8 @@ static inline void *bvec_virt(struct bio_vec *bvec)
 	return page_address(bvec->bv_page) + bvec->bv_offset;
 }
 
-#ifdef CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO
 #define dio_w_pin_user_pages_fast(s, n, p, f)	pin_user_pages_fast(s, n, p, f)
 #define dio_w_pin_user_page(p)			pin_user_page(p)
 #define dio_w_unpin_user_page(p)		unpin_user_page(p)
 
-#else
-#define dio_w_pin_user_pages_fast(s, n, p, f)	get_user_pages_fast(s, n, p, f)
-#define dio_w_pin_user_page(p)			get_page(p)
-#define dio_w_unpin_user_page(p)		put_page(p)
-#endif
-
 #endif /* __LINUX_BVEC_H */
-- 
2.35.1

