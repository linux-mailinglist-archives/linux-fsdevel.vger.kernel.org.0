Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2364C409B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiBYIv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbiBYIvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:51:19 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FEF17BC4D;
        Fri, 25 Feb 2022 00:50:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edu6bmnk/q3Pz7CSfnwZvK4X5kz9+qsV9hpYeyh3oaS879yoBxKmQPr+GfMU18JdK6yDWRPf9VB64KpEdm7RewrNheaqivHWU0/d2zCQmLzDcOpc3oUzQ6Pja8gBvykUrPW3pGhwpNOeZYLm477yWOD0kbOTpqfMTT6ip8mmGnkJp3UQRf/00y1qV+Ox/+Kpvsq7+7W/6dJe+Y1/pJ5VOWVsIZY6HaBJx+bhvJ6kEIh5wDuaMMFPW7C3Z6bQV9/g4qeD1Ts0Ll0KkgghR8C/ciQAS7MfjuKMYdLfvcFmtQzDakuejd3dlxYnbP4pDJMdbEEbaiKQHm8+XYCvMiuVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWclyEKq4CVkl7hdRiKCw5b/8BrSgghcSXNAqeSOe0M=;
 b=AwZ9tg/Hxrv5DsLNSqALjbpd0qtYfnjvkN31rDe70RCCLByUC1XWV20VZUUk1JufA+nHqwt9ErWI11brGMwwikSfqAnLpsjgrb2AzTl0WGpMJawkO+xYA7rl9QCU04AMQirVK4HLywEc4yozTdzZ83btEvYXWF9tB3zo9pDFyWmmovDjUqX4ryOElF5HCSGrQeUClvClnXuJubziaGBBMtQ3gKf3aIBu675gGCOcdZtYW6kvd63XakYKziLQd9Xrc1DzazwyjjeX0sC//nN1d4WroYqJVZ3tMhgNIL1Jphf9c1HVgfVram9Zkylkon9tSuIkbSqcottU0A9Yzy7QRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWclyEKq4CVkl7hdRiKCw5b/8BrSgghcSXNAqeSOe0M=;
 b=j+X9aDhPNh5/uMJybg0OIztzh0JteNtmcMpwgRWtoxPx9ekv8c0UgOuUZpT3SYpBmSrLtchssDwceUFhwDBtnegaUDe1GDE8eKMPdCIZILSbvbH8WapNj15QbNO4PTa1dHomFJFzodhYVrjRJJCT6079jM89DBIp31KMNYa/NXbOBRDN6Io0xU6UrCd1JlTuM3BEqA2Pij3UMva3blpq5Yk00TSG/VxcSDEKzAMakUURFVcX1LmVA55UgKjyKytsSI08KgfzzU5k64AjCOUM4x0v83c2nEyKliBhID6HqCSGGhwxmMIe0ks1KrD5Fu7NMoj14WLvV18kkfyXugEU/g==
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 08:50:45 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::66) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 08:50:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 00:50:43 -0800
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 00:50:41 -0800
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
Subject: [RFC PATCH 6/7] fuse: convert direct IO paths to use FOLL_PIN
Date:   Fri, 25 Feb 2022 00:50:24 -0800
Message-ID: <20220225085025.3052894-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e14dc0c9-f000-4920-5c71-08d9f83be98e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5074:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50748B8C3F03D27DA940A91FA83E9@CH0PR12MB5074.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utN9OnhBYfjLaaMUa/ek04txJYqDYRj0suaZTme+Nk7I0fQNDmfMFgZxyUeymK5aCy6c/ophxUtBZYeMkFbULHxkvLrHY/Vxd1wHjhBdVrLJ/sPSWNZw44asH9+UEC2qL6ZOEvJk5UHVGXSZYd2P+idVZNRlkADx3fHfbwtMn519F6FGoWWUsIq0mmSFOloMMoywXNLCQF8j44k+kD+OmU04+jV5oL41tWdySwBvGjaefGKHbr5f1rKQ6OzjtEyQyQK09PY6kyh+gW/15Q76w9loX+xRMoewEj8TA5skT/4oWuNw1FjfHk9zdGzQwMV34CvER6shuj6Sst34qDSnArudSJvY5VvT5wIu81t/1WW51a0/p92lDsaiF7sti7sptewJayv8HHq1jI/B/dlNaEUHLvqvS5daeF6ITGGCtyYMK5KUrSaVFjQu94w7QQS2bINVpudxnTiuMVI5+hac3JfKs+gRvoL/DPimXjRgoJUdHDxy6hgvWvCBMLVe8Ec+OaWQOt4/aWBLcc/yQ2uAxkT0ZrahV1qHivooso1o2LNq0zrQd6r84pGiMEjp7g4VLzclFwy5NIWlvA24zNZLNyybHHxdS5hnBi1tMS2r1XDXbF8kaKeF0BEObdFmO8+UM795qD8Q/VuCdT+lkFUbms5eVLMmADj+VqdEHy752tdoJdmU6kj7+xFRCXdtL+TWobaWAGW+WBsRK/4crIlFi9StDq9uEndIxuJGL1Q6UpdY6WXrX7cKEEULivHZqdH5dWxCz3KaSenB2V/kaVrun+9AyvGxmEujIFY+YPPI8xgBZthMUSYKBIS/orJ6Sndd
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(2906002)(40460700003)(86362001)(82310400004)(70586007)(426003)(7416002)(8936002)(107886003)(6666004)(186003)(2616005)(1076003)(26005)(83380400001)(508600001)(336012)(54906003)(966005)(921005)(356005)(316002)(6636002)(81166007)(110136005)(36860700001)(47076005)(8676002)(36756003)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:45.3097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e14dc0c9-f000-4920-5c71-08d9f83be98e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the fuse filesystem to support the new iov_iter_get_pages()
behavior. That routine now invokes pin_user_pages_fast(), which means that
such pages must be released via unpin_user_page(), rather than via
put_page().

This commit also removes any possibility of kernel pages being handled, in
the fuse_get_user_pages() call. Although this may seem like a steep price
to pay, Christoph Hellwig actually recommended it a few years ago for
nearly the same situation [1].

[1] https://lore.kernel.org/kvm/20190724061750.GA19397@infradead.org/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/fuse/dev.c  |  5 ++++-
 fs/fuse/file.c | 23 ++++++++---------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e1b4a846c90d..a93037c96b89 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -675,7 +675,10 @@ static void fuse_copy_finish(struct fuse_copy_state *cs)
 			flush_dcache_page(cs->pg);
 			set_page_dirty_lock(cs->pg);
 		}
-		put_page(cs->pg);
+		if (cs->pipebufs)
+			put_page(cs->pg);
+		else
+			unpin_user_page(cs->pg);
 	}
 	cs->pg = NULL;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 94747bac3489..395c2fb613fb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -619,7 +619,7 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap,
 	for (i = 0; i < ap->num_pages; i++) {
 		if (should_dirty)
 			set_page_dirty_lock(ap->pages[i]);
-		put_page(ap->pages[i]);
+		unpin_user_page(ap->pages[i]);
 	}
 }
 
@@ -1382,20 +1382,13 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	size_t nbytes = 0;  /* # bytes already packed in req */
 	ssize_t ret = 0;
 
-	/* Special case for kernel I/O: can copy directly into the buffer */
-	if (iov_iter_is_kvec(ii)) {
-		unsigned long user_addr = fuse_get_user_addr(ii);
-		size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
-
-		if (write)
-			ap->args.in_args[1].value = (void *) user_addr;
-		else
-			ap->args.out_args[0].value = (void *) user_addr;
-
-		iov_iter_advance(ii, frag_size);
-		*nbytesp = frag_size;
-		return 0;
-	}
+	/*
+	 * TODO: this warning can eventually be removed. It is just to help
+	 * developers, during a transitional period, while direct IO code is
+	 * moving over to FOLL_PIN pages.
+	 */
+	if (WARN_ON_ONCE(!iter_is_iovec(ii)))
+		return -EOPNOTSUPP;
 
 	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
 		unsigned npages;
-- 
2.35.1

