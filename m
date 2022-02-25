Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA74C4094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiBYIvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiBYIvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:51:14 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF38177D3F;
        Fri, 25 Feb 2022 00:50:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyACxF7fPkE2rMezm401crnu/DYgiYzX4NkfVZmgP+AqV4eae1UuvF2outqZRNrbfiQJzvBMofrQox3Sxt71gFCW5xToCaiN7RWQiGGPKL8My8pPYh/fU3iWZI7p4IP9pcxTPq0T/ggKWk0cGkuw7cxnKqlbIGXiafL/tkLALhYcXFALXLnoX5hohzYZj7qUdQ5x+i5s2T98fbvP+H9cuQfSZKdwX2svGsAH52T4lXVaC0k/g+WNaMUrHZAaENc+PhDVfvkRUN+p/H5WMnhWBM2+mMUpK4jRCdpozW/XZhcSA5wn5KsqiwVRBItiPt90I64JjlsE91rwGBbfm70qaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCh3aDMkQYStRKBxVavUNPnaTNvm4hCnzAHey6l38Dw=;
 b=Lwkg2W3UPyscDCUYO3ipEP8AfT0b3i56zw2EEsrHTNrMm2azaItP3Rewz0hja+0AZ1+3FfeSsYEjsz09R17yKQj6lz9UdkDQbNGxm0WY61w6yuFwROMXxDrkd9VRzkY2D9rVNTXYqrsZES71crrTVAZp4dnObefkVK/SZy84X33mhYnho6M73B2WFtfl0TcHvyEFmw6GCaZIEiUPkQhtBQb73+lHb0vznZvjSm4UTg5SJcn1o6SiY5iuYMEON6XPT9krjPttEFgwYVPq8rtnuNOSLZcK8X2KTFNsTDFNUwqUZuXGLnnEoLXflmgzWZtxGnrXQmgTpz+SVbt6aeN2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCh3aDMkQYStRKBxVavUNPnaTNvm4hCnzAHey6l38Dw=;
 b=PY8TDTmGFToOfTDgVT1eFl9ditLQvPXUH6v0T+e6nKFDm0QYc2dEcPq2V7YPtr0n1ENen2cg++ij+2r11pxvhpoMr8k+tDL5GdQCfsym15aFAshHlrcKgv1+VpRQ03xjbD7h0qqkNJodqOaYdIEkocgAl9id9alvAhP/uySE0w/oh5UlRAvR8sY0YirWSe9Rim6GYw6FCt128/Lu+kyIllSp2mIDxpBk1GLFSpERnzdPSPxBXG9lIuR6TXGyAb9XjhWvHMlP6tNEQQVOzadS7aQPs6vlzwvCzk/DLwEaqgiG4W0Xh9+sGo6TpVu9Q5PxyYKXJOrOwLZVm1m2+V4XYw==
Received: from MWHPR20CA0029.namprd20.prod.outlook.com (2603:10b6:300:ed::15)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 08:50:40 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::26) by MWHPR20CA0029.outlook.office365.com
 (2603:10b6:300:ed::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 08:50:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 00:50:37 -0800
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 00:50:35 -0800
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
Subject: [RFC PATCH 3/7] block, fs: assert that key paths use iovecs, and nothing else
Date:   Fri, 25 Feb 2022 00:50:21 -0800
Message-ID: <20220225085025.3052894-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 892e3132-73d9-41d6-34a5-08d9f83be61e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4432EE220467AF24A011D6AEA83E9@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: El6t/1kSUiKOsLJMZfaTKBxsmM6FJwsDQiueoSdM8DfLi8Y3qpYgeopIjwbwE+LaikxDletUrU6wQlyJ7ss6d3kr80CdIYlFBiokgVjvCzgGHk3jGURchWTkTzT/0ekN6IRUHS+OgHG50KoY9JyYQCBQCNIZ+0y7fzN/sAz81cwZtFuO/GdmcCM12Vho8VgksEZKQLiDs+bqt6wopBqJ6vWIeju2UyJpHoikw5Wd1ICWNwKm13iQwShzGk4vRtfSrGgXOYXx/JAOUdUP8coyXnd5JF04x0N49gp1vyB42eaauFN5Qn+EeuYQJ4KhP91wx6dmcNaK+uV3mZR4cwKBvb48RAEMzulCvYcvklMp9J/a4lqC5ulaEwNzGd82NIaCz5g9Qi2aGR7eFPpnUujwt+RuQavzx7xlpniniVQQMBjAUkF72wLsI23Z5/guMZg09yxHo4DMWhquDTRoX/PniZCKevgrNlZeKaSjnqdNLeQ6Oux4MvJOWtVx4XjC6dktJEVqTtg/nfXyu0J97bg4L+WVcpKWDVLG46O41uhmAksIfN+dflvQgCvdfmlpBGDjQKkrJ5wlMPwPMd9UXmijetYC2+zBiapjctwBYmxu3nNWptQc/4pjlXePIOao1CYpwlbeLA7rPk1af3XbyJ9804KcHx9HdvxtiPpq4lHPAcgqmaKSf9QOii3/In+H2coHs4m2OnWR066AQNEsIyw+0ci2eDA4ilT4kAIi+wLLm2Q=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(6666004)(8936002)(107886003)(2616005)(356005)(40460700003)(7416002)(508600001)(336012)(426003)(26005)(2906002)(36860700001)(83380400001)(82310400004)(4326008)(8676002)(81166007)(110136005)(5660300002)(921005)(1076003)(86362001)(47076005)(54906003)(316002)(186003)(6636002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:39.6040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892e3132-73d9-41d6-34a5-08d9f83be61e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Upcoming changes to Direct IO will change it from acquiring pages via
get_user_pages_fast(), to calling pin_user_pages_fast() instead.

Place a few assertions at key points, that the pages are IOVEC (user
pages), to enforce the assumptions that there are no kernel or pipe or
other odd variations being passed.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/bio.c    | 4 ++++
 fs/direct-io.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b15f5466ce08..4679d6539e2d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1167,6 +1167,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
+	WARN_ON_ONCE(!iter_is_iovec(iter));
+
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
@@ -1217,6 +1219,8 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
+	WARN_ON_ONCE(!iter_is_iovec(iter));
+
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 38bca4980a1c..7dbbbfef300d 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -169,6 +169,8 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 {
 	ssize_t ret;
 
+	WARN_ON_ONCE(!iter_is_iovec(sdio->iter));
+
 	ret = iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
 				&sdio->from);
 
-- 
2.35.1

