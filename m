Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAEA4C4087
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiBYIvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbiBYIvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:51:11 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A228177773;
        Fri, 25 Feb 2022 00:50:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBlO4zIFxmhx3wt8IOztZcQMmeyv2m7n6X9tW0E4NR1miYig6L+KLPPbBZngfC9Pv4Z2+aTRvnq9KQUgQuU5fEUL8fYIWDc0CVOLwewTPB8Dkx+UMWJ/mmyJF2VF80WD7IH9znDb94cncFqYFrdPjppKoG8iVfW5lgIbnGK9A7Yn9g1ZpTo7SO0iBtas5ygeaeUXKh72PbnPJAMJ7b+WVkB/q5s6lqfYopSa4aomOl69rgGI5dZD0nFKxSbSOvjihXrDcrWvlaa7VSE7RgtRKV6Ad8PBheFYsg2+AdvfWs3D7ZzAeeFfokYFK90VGJb7KylRjjjWPEgpHfAHj2R9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1M9kqFuSLuRzAkMql4Y2/4feCJMUalRUwt7co+e448=;
 b=K4zp4D+IPCAhVT5oGaYBOyX7giQHw34lN8XNBSnMy8Eb714urAYLYVo9CRlmGMuWCCd3kLi6R0i4bMVwIVKkU/fE2q4IivbBRjmy4y+Gpv1cLxEmYS0f0Zagr7bzPfi8Cze5O6b4CtfxSmqAhck+j6pWCsShtcM/cqBfMLYGWIAQ28J/4Oaa0xtRphMHamdWjEKGfT1fEhmss5PvoS6vy0HE8BXHkneuRMG7nbac6z8gcw/ve08B07QQMXrHmQpYWfFEyiA+n9mxsaR02LnwLNjVegXKHV/i6g9+90Cgh0a3d+f5RKcJLfodNZ3GFNIvc9cmiUD5f5MuBqS7LN9DLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1M9kqFuSLuRzAkMql4Y2/4feCJMUalRUwt7co+e448=;
 b=GJ2qMS3jPCG1uGGHF19x46M3X0lH+EZNhz6bcbzgRloaM64kotkSCCinVqQ6bk7Uat4AASlYRw32YIFwa098IYmI8YwfhqjGpDlGVn/yQ7u0uEiQIQeTlGILoCdprmhgfhxkc5md12KCfyCZtZW80TP3m77y7PiAo5Ewk/0kQShRB2vaRrpcDktOfHd5Ex83H98oSwV9wmTWQfeAnkmwAwD6XTzZsIMk9YZcS7RvCsSjBIsJgbh0fcid94ld1tCM7Z6AUtgrSkyxcgYwZYBl8No66F+yvMzQisigDfGcMaF+p2YWDG46pO7s6L7cP2slBUJJ0T71xK9Qww4cWjVbbg==
Received: from DM5PR18CA0073.namprd18.prod.outlook.com (2603:10b6:3:3::11) by
 BN6PR12MB1188.namprd12.prod.outlook.com (2603:10b6:404:19::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 25 Feb 2022 08:50:37 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::73) by DM5PR18CA0073.outlook.office365.com
 (2603:10b6:3:3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 08:50:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 00:50:35 -0800
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 00:50:33 -0800
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
Subject: [RFC PATCH 2/7] block: add dio_w_*() wrappers for pin, unpin user pages
Date:   Fri, 25 Feb 2022 00:50:20 -0800
Message-ID: <20220225085025.3052894-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92112809-dd4f-48be-2f22-08d9f83be46b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1188:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1188DA323B1391E1C39892A7A83E9@BN6PR12MB1188.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUy++dt94z8m32z8jyFAhYaKVBy1XC4rHK5kuji65Rk3Uvn96GsULMmTxXNowEHCpOS1fMzoG3tu+DoQje0a5F8acSVVXe+fUG7ajZfp2ExQHazAdbAPjp0cnmIjLQF55EqL2C12V61EjQASNzP2RpvNpYJ+Cj04sHsE3WZmTVWsHO5TFdNy6hTEhF1/AaSDubme6f+ca/0qQYfpmh1fP9Pga8lufmVju+7hl5wJLCV/66aYw98yQ0n9l06hbf25pK+KWCDWJU8lAp/arfv33dPNwbjQAQT8VukekZqFtDhKmvrdWMTQxvAKUxaNWGv38go3PC5ECWRaiI3R7NN02FyF0kHHEnYCHnjfAURC733IwcW16uqmLldyyOG57qwxmDGEBDG83o6zTabwFjm6G7IqLFpCx7TQuWOqK5I9pKcm5tWSP2i83sW6zXZ6Qz6w+lG9yA5Tt/rDDi56DPnjU8M92zafBg+SUSdDGnmqcUtqe8jYN5qIVRhi7GMKsKk1F0wbQyZHjEWZeAOrYuWVxmWGHyLSk4k30BSQvFTVlWlbL2RSWP3WbjQlIzQfXiLTfQIPTKti3ll3b2edQWMLM5l21DkqUthtsX9fO52zL/F6oQummgUmvIk/3NXmhAU2j4TXaZOfBELf8VQux/EFBQsXXMWYAPozftvRtaaiu8Xub4bfmayQscZCK10JbiA0AMfZpFruh4iKGgVfZ0ojhkqJFQzoQwpKCGTyiWmNbEw=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(336012)(26005)(426003)(107886003)(36756003)(2616005)(7416002)(2906002)(6666004)(508600001)(186003)(8936002)(47076005)(1076003)(83380400001)(110136005)(81166007)(356005)(36860700001)(4326008)(70206006)(70586007)(8676002)(86362001)(921005)(6636002)(82310400004)(54906003)(40460700003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:36.7530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92112809-dd4f-48be-2f22-08d9f83be46b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1188
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new config parameter, CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO, and
dio_w_*() wrapper functions. Together, these allow the developer to
choose between these sets of routines, for Direct IO code paths:

a) pin_user_pages_fast()
   pin_user_page()
   unpin_user_page()

b) get_user_pages_fast()
   get_page()
   put_page()

CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO is a temporary setting, and will
be deleted once the conversion is complete. In the meantime, developers
can enable this in order to try out each filesystem.

More information: The Direct IO part of the block infrastructure is
being changed to use pin_user_page*() and unpin_user_page*() calls, in
place of a mix of get_user_pages_fast(), get_page(), and put_page().
These have to be changed over all at the same time, for block, bio, and
all filesystems.

While that changeover is in progress (but disabled via this new CONFIG
option), kernel developers need a way to test their changes. The steps
are:

a) Enable CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO

b) Monitor these /proc/vmstat items:

nr_foll_pin_acquired
nr_foll_pin_released

...to ensure that they remain equal, when "at rest".

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/Kconfig        | 25 +++++++++++++++++++++++++
 include/linux/bvec.h | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 168b873eb666..f6ca5e9597e4 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -50,6 +50,31 @@ config BLK_DEV_BSG_COMMON
 config BLK_ICQ
 	bool
 
+config BLK_USE_PIN_USER_PAGES_FOR_DIO
+	bool "DEVELOPERS ONLY: Enable pin_user_pages() for Direct IO" if EXPERT
+	default n
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
+	  Otherwise, this is just a way to throw off the refcounting of
+	  pages in the system.
+
 config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
 	select BLK_DEV_BSG_COMMON
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff651a..a96a68c687f6 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -241,4 +241,15 @@ static inline void *bvec_virt(struct bio_vec *bvec)
 	return page_address(bvec->bv_page) + bvec->bv_offset;
 }
 
+#ifdef CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO
+#define dio_w_pin_user_pages_fast(s, n, p, f)	pin_user_pages_fast(s, n, p, f)
+#define dio_w_pin_user_page(p)			pin_user_page(p)
+#define dio_w_unpin_user_page(p)		unpin_user_page(p)
+
+#else
+#define dio_w_pin_user_pages_fast(s, n, p, f)	get_user_pages_fast(s, n, p, f)
+#define dio_w_pin_user_page(p)			get_page(p)
+#define dio_w_unpin_user_page(p)		put_page(p)
+#endif
+
 #endif /* __LINUX_BVEC_H */
-- 
2.35.1

