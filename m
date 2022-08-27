Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3F25A35E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbiH0Iga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiH0IgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:36:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C8B2CFF;
        Sat, 27 Aug 2022 01:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1imsOk9e7Q/mcgS2hXZ0IPOMIg8aHC+QYBAIghQfMIjNoMO6KSqM58Xcp1uCyVaUQUFTZ/eNN/fyPApQtOLP6s5R52Kz0zlTHehbZJnq72DpDRqBgWcYuOwsY0i/IepeLR0XBoUw2gOJnq8BAImK+WxNifJ6AUZ/6QwxYVFx2ViOy4OhzbTN4SGM4cqlzuZl2mjgKXf/jdXTkeXnL9K6qJwf/SFB0QPVBF/HeGScBMDuFyAF4y1ZYyITpg5ioxaX6C/dFiFT+Yzviwj/3jDTYmho2jFj2ykMAuYV8msGWtqUeRiCKGWAlPGsFa9y10ataopMyR1esI7nOv5mt/HZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCJ4cBcOTlL0cm3WRQNtfx2LiFChT7DgHkr76NwhXwE=;
 b=jsnjOB1gOVJv+RXhADCgKN5Q+uF0gy4JO6SNk0f1oaR5uA2+Gzwvx/mtUKch+H0D0cPIavxZ7BsVBJHsaKHTJ5vcy+KVs8+IoZw3/tpO0v2obP7N/545yV1d2OIzvT5hOYBzlr6+vyJVAK9Tg0bYduao08roEjENWnmnF9PXAYJybMqnjTIvH+5xwo2nNvwrUjGDu9WChhzEwkUcEobTOxXtrfnl1w6WC+SJuiuEh4B7GkDV3tgagLz16KtrH3zEYrQofRZDwfBus08ahRUECJYuy8PdfAdX24A+Akt5fllSV9qg09AbUNL2zxrwHkv5AfZdlkyloji1tY3oaK16EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCJ4cBcOTlL0cm3WRQNtfx2LiFChT7DgHkr76NwhXwE=;
 b=HZbyc9jqVhwgkTWi0t/9KFSCao6TcLEV4E903wMuo2uUKPJ7bzPQAw01GfsxYrff3f5GHACulEcS6rLbQkrxI3/wuzzs72IIQfEr1Rt1jK++eqCFvWLp0PebsnyPGfywBhSp9Y/d9rdwf+zqOita3ZIK7Yg5PtIT+gDWsa+X0lLFjpWGmEPnNZVvl3PX7z7NMV6dTn9ArHeg7uPj82g6CqFn+z3Hnd4gLCeU79cHGsHvuenMH0Z3ugj/1cDY2k+BE7/6lG/7zluQUfD6mwCD3XKNedwg6OUtPZJYEM7HUorGwFoFIaxwrZC5R6dsOxifehw7ticWHjgzn8QqrFsF2w==
Received: from DM6PR07CA0109.namprd07.prod.outlook.com (2603:10b6:5:330::17)
 by BYAPR12MB5704.namprd12.prod.outlook.com (2603:10b6:a03:9d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Sat, 27 Aug
 2022 08:36:15 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::d0) by DM6PR07CA0109.outlook.office365.com
 (2603:10b6:5:330::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 08:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 08:36:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sat, 27 Aug 2022 08:36:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sat, 27 Aug 2022 01:36:13 -0700
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 27 Aug 2022 01:36:13 -0700
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
Subject: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Date:   Sat, 27 Aug 2022 01:36:06 -0700
Message-ID: <20220827083607.2345453-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827083607.2345453-1-jhubbard@nvidia.com>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c097dc-a8cd-4984-4acb-08da88073446
X-MS-TrafficTypeDiagnostic: BYAPR12MB5704:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /T7dC52ZIAX2uTlrqTehDTCMXwSnF040OnIZpRiac8bgizTvt8qqB3N/0inFQ2bxMURI0EgvT7U9L77txe8JDN6MS8QjjidQSQpyd8RrYLzznsSKrzGLoyb3uyVulB1UxcmweYfz/1ts98UQNXzjGjkf6dUxY2wLEHAxFwcLpmkMfpkVo9uvqN56RDmeip0ctdOFgHLIhetslm8pyMv5VxYFz18hacdD01G0gZy+5mZWdygCC+xvBSotLybtGwD9D6QqOSXYGCODitg2x4J0klAiOgR5/T5KxdfkY7pSuhohyiFoLTLu2wTXGaweD6arsL4dzgqAz4UifCpnhPaaBFaH+hDq2AUJZcYfCXAYyaQKoyJfLrkVMhrZd4cCDEUnqKheigHKAMPJ8f/xtx0i5GOCXn76+qHc3zl4firm5I2oBfOpbOCoUOXihFNZgEl6EzzSsjyJefpszA8TMR1zKCIYLe399YJ+6W7xXrnkWO82RqGt/1SVRuaehMbkv854dXbyCSCn7kHrGwugFdkbsRPra036jz5DavbM4tBL5c9FcV/yuZf2SOqbGksYbquEJqEqxEKaWw3T9ivy0nF4FrJd7sdW2bTJEM2hk1HDYMFiinROMQQMS8PTajGX13oR9SieBL5/48QkLsosrnsvULBBYLT5ckQr/hz517KqgERrwt2kvuvSspWrNjKp/lju2cIJa+6KqmXpRC6GPrWLYV6JNtrruZqNBhXl3lgol/AS9ATLfRxdYN3gpGi5a7fJuLA5aLh5nfNujeysL3Th1nq7F68Nw7V8Bn1HnDIU8yo=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(81166007)(40460700003)(40480700001)(8676002)(82740400003)(70206006)(36860700001)(70586007)(4326008)(36756003)(5660300002)(7416002)(26005)(6916009)(8936002)(316002)(1076003)(6666004)(478600001)(41300700001)(54906003)(356005)(86362001)(107886003)(47076005)(336012)(186003)(426003)(2906002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 08:36:14.8423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c097dc-a8cd-4984-4acb-08da88073446
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB5704
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

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/nfs/direct.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1707f46b1335..f6e47329e092 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -142,13 +142,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 	return 0;
 }
 
-static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
-{
-	unsigned int i;
-	for (i = 0; i < npages; i++)
-		put_page(pages[i]);
-}
-
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
 			      struct nfs_direct_req *dreq)
 {
@@ -332,11 +325,11 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
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
@@ -362,7 +355,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			pos += req_len;
 			dreq->bytes_left -= req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		dio_w_unpin_user_pages(pagevec, npages);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
@@ -791,8 +784,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 		size_t pgbase;
 		unsigned npages, i;
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
-						  wsize, &pgbase);
+		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
+							wsize, &pgbase);
 		if (result < 0)
 			break;
 
@@ -829,7 +822,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			pos += req_len;
 			dreq->bytes_left -= req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		dio_w_unpin_user_pages(pagevec, npages);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
-- 
2.37.2

