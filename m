Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D45A74DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 06:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiHaEUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 00:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiHaETa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:19:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B669B775B;
        Tue, 30 Aug 2022 21:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au1kMEZNWkQWqczF+kL+IONwGPN0SGcEuDldSIqN2rXCEtW+6rqM0VeOw7J3nRtHonZgZOybpDbV4xaH4ucg9aJyJ2Ihlq7kMOCnR3fQ/0DsB1qU+DCtHzHkNEfyyi6HfZEsblxftJ14Wj8Fb3Ig/w0/Arx3VCNpDZ28ooMC3c4FCQ4b2BIY/oKiVRABMWYBpXbGla7M/MMZpki6HWvyEQQrvigk6sZMzTeSDuvDVees071KUVsRaxvkt4UaIcnE9e6hDzdTpayEPLwM6NG12+ho0uQ3oiVFzy6lnRbxwYeJdY7BcY8xS1yNk7TSlpCfLwFD15+f76bidr0wKB8DtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aczRj79FDq5zhgDXgkdSZ6tHCMLon+GUs7nYvdVmu24=;
 b=EywoaBpCfsNxHV8bjgnl/AA+fRdZSnxtfym3J+4Uv3VNp4PExjwRSZpEbFo0HS3VPv+5jPQZRMYCfbP08W190S/swl6IXKsPazpwvW61H7vLi1Nf9PefRfqR13pZRk2xjB9W5e+hRx30RR4zg7jjGuNGy5o5CRRRNkin1UkraEGmeysFofGsztU3mLWwAm1WP0TQZnRo3vRX14p2bkw5V98PrTh7GnQIn0PqemLUU0dh89KPg02OkwUsaSnA03nxLyEThqzK/v4MGjFiHro+lFfnhX6WjvsPX2gSn1dbtq2/tJrbxgwddBQ6ODjGoBeHJLUiwtrMJscqYm/hPJ/Tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aczRj79FDq5zhgDXgkdSZ6tHCMLon+GUs7nYvdVmu24=;
 b=Vi8obwFlYuyrSMwI30cNt21RrBFdUoc8tzPUG84uRajCK3pFcfMuzg9qxSWD4Jse0AlNZDXLnoVXAhS/GpW5as2xk97JO9WodeHWdeKXge004BFTmRXmdJCsof74w0UG4ovBvw/4rrwklXtda25q8A710th2wOoD3oscVDnMygvwqnFrscqX2VYKr52ydX28aA4dEWjaIWfBi6r4Uda/zDVqco9jEbBBNgtli6IY+DpPCJwnAlbaoUCzhSUkIKf2notlcEtVug7VFYNBIYsdyKnesfSWBzysRvGpIcftpgBM8/UkO62mstw9HTEhv5ysUNoMq9ee4002e3cjkgGzPw==
Received: from DM6PR02CA0044.namprd02.prod.outlook.com (2603:10b6:5:177::21)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 04:19:05 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::6) by DM6PR02CA0044.outlook.office365.com
 (2603:10b6:5:177::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 04:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 04:19:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 04:18:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 21:18:54 -0700
Received: from sandstorm.attlocal.net (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 30 Aug 2022 21:18:53 -0700
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
Subject: [PATCH v2 6/7] NFS: direct-io: convert to FOLL_PIN pages
Date:   Tue, 30 Aug 2022 21:18:42 -0700
Message-ID: <20220831041843.973026-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831041843.973026-1-jhubbard@nvidia.com>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e423cc-d748-4009-b298-08da8b07f116
X-MS-TrafficTypeDiagnostic: IA1PR12MB6410:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8BaR9LcljAxg9H/peMbr52F7edgS1XU8PnaupyQA6Z5F3k0Y+uPQ+KfiZS2OyUagBOaAicXFiPAKGCXJHVOxKJZsjEENc0NHwLWpLZ2vXsgqXVsdZVQPCHqRbMmlcyFr0Y+1NHaQN3p/AZQcrVVLKDTgj8k8hZDE/KvVzmHobE2GmLAHJF9BTihan12VWSxhO1Ey50PP4X07nryuLwcAE4l5wn2jBk/v0omdkjQc7leNbPUGuF/pgDEmZysEIj9MzV3gMMuwG/SJ6gPmJKN2BsDqmVxwZR5/TAZhgjfYTdpr/GPvqdTfqTwX+Gn7o8qnU3TOIP60VPx2jTz8zlNJmAt18UJDkeLDa6OS5Q6rwCiXkoEyROjjFMAwvgdba5IYolOrIWpOJggaMGEiCEtkwuptGWuWjFl5O3foqmR0AYH5KhkWbxKdpylULYkzUJelbuosy1U0tYj0OAQJ98fmvkvsnR89ZlzrtXIQi2EnyIakJHTw12v24KA1oG3ivtOyI96oeVA93Eg/UwZzpYb/+KtKQL7DjdE9A6UF/+L7+zlz1ov/G66j7xNkuM3OJSlqKHKqE1XcOKKIs2Fkin3RvBDOg7dih4cL/sFJVQ23+B2xksN+eOZeOhXZwbB94TuKga1ssTiIRuoR+2Ge6374+cDeKhDpdYbbfLAt7PZGOvcyHXvL0Gg+SzlMxk6FsFfMmd71+UB3dOh23dDIq7H5yh4x/YgHayq2Hhl/hg7XVSzQBgLHnW/kMkZc1E6Kdveyt6O8BgQXv1yRa9gAe/9YAPcTWjADapjZ6PZZ4LubWzakmyjYouhUV0urI4UFuOg
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(36840700001)(40470700004)(36860700001)(40480700001)(82310400005)(356005)(86362001)(40460700003)(82740400003)(70586007)(70206006)(81166007)(8676002)(4326008)(7416002)(41300700001)(8936002)(54906003)(5660300002)(478600001)(426003)(1076003)(316002)(6916009)(47076005)(2616005)(2906002)(186003)(83380400001)(26005)(6666004)(336012)(107886003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:19:05.0768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e423cc-d748-4009-b298-08da8b07f116
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the NFS Direct IO layer to use pin_user_pages_fast() and
unpin_user_page(), instead of get_user_pages_fast() and put_page().

The user of pin_user_pages_fast() depends upon:

1) CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO, and

2) User-space-backed pages: user_backed_iter(i) == true

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/nfs/direct.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1707f46b1335..71b794f39ee2 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -142,11 +142,13 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 	return 0;
 }
 
-static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
+static void nfs_direct_release_pages(struct iov_iter *iter, struct page **pages,
+				     unsigned int npages)
 {
-	unsigned int i;
-	for (i = 0; i < npages; i++)
-		put_page(pages[i]);
+	if (user_backed_iter(iter) || iov_iter_is_bvec(iter))
+		dio_w_unpin_user_pages(pages, npages);
+	else
+		release_pages(pages, npages);
 }
 
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
@@ -332,11 +334,11 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 		size_t pgbase;
 		unsigned npages, i;
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
+		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
 						  rsize, &pgbase);
 		if (result < 0)
 			break;
-	
+
 		bytes = result;
 		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
 		for (i = 0; i < npages; i++) {
@@ -362,7 +364,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			pos += req_len;
 			dreq->bytes_left -= req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		nfs_direct_release_pages(iter, pagevec, npages);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
@@ -791,8 +793,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 		size_t pgbase;
 		unsigned npages, i;
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
-						  wsize, &pgbase);
+		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
+							wsize, &pgbase);
 		if (result < 0)
 			break;
 
@@ -829,7 +831,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			pos += req_len;
 			dreq->bytes_left -= req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		nfs_direct_release_pages(iter, pagevec, npages);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
-- 
2.37.2

