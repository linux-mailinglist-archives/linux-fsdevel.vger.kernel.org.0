Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507904C4092
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiBYIvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiBYIvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:51:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1697117BC41;
        Fri, 25 Feb 2022 00:50:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GScl9BenBELXDXb+6CD6bKA7k6rOQ5epj//MZcZFU31oW6psUcZn9InZyemWqPiF5Srt2s3esktruIz24UqRggsxZjKN2rSwAnfNDx6C8fETCtKKGzJzNWZNE+WCZYhkyKmbvvmUt8fAMSbuC3G+nykKMPxwOkJOhY+T34/IRNHpBBtuwb+jON21edEFCm6/TTGpHpNjYbgv1tdsJnJnWvJqO3taxNNFll39bZCYJwCJxSIQ+ZyllkZQMzir5Qhca6WzxDVLpIrC8IN1FK7UqCtBUwnpKjSqH5SG58LPl/wgQleqJ18fM7WAbwuKgk3g+CU0ryvGN9ST1ib0+8q1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4QhKeT9zgdstYjOxfhw3Jd7XZ11uxPnfOza55tfrhs=;
 b=Dt8lBYaS7lwi78FUqI5h9nXg1i8Yfz8WTUVqtw/ISzTdT8UC05k67vlN+jU0p1HLqx0JTpvIZ5OdPF/G4VkHHkAIYK0N2fyP1ioUdQkWhb9Vry30L6pKR55Jd77EBzeW5aiz/RHEwQ1KAwRNh1IvJArhuxl6VN7aM0Bmd3Npnh0KR/fnkvcyi2TAAjxsxy8R9V0MhAuLLmsJDHBhHGF0DKyN57MU4icP9EFKWZSkuDUxp27Djxjhb4cTAWNSlsqzdyaufhIqA3KO0fpPclq63BRy1nf0A910p95Teebyjkm1c61GRQMbI2kouwG3LspQWAJ3cy+4GS8MsmYch2VUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4QhKeT9zgdstYjOxfhw3Jd7XZ11uxPnfOza55tfrhs=;
 b=myiqbymWylkCR/Nhklgo4NfPGEHFsvdGyFN3gJUgLjRC0YEFGqkkr5+ooobHeNqOKgiy8JAV0VXYjhuXouT4YkVvNtAqDv9SSRJTvLn/F/x5GkWTkB8gCqSSGIMYHciOHUPprDSm1ZhPpaFmZWC99OHmVCaBRyVDVG9VbZZ3DyeDaytNbkyYbe2HRqWqAAFaLnuDGDfFUgkw6KTeVqmm+j0gj7PEVI8uFHBg0AlS6m7jvYgBlQVnpNoA5wD10P3Jr9anHNuWuzoXHyiV4C2EqlLlTAZkKGJQ0hSQqabZTiwtyO8hkAwi6vwj0gbK/aqWRQc8KHTZFARil2SACZA4EA==
Received: from DM5PR12CA0049.namprd12.prod.outlook.com (2603:10b6:3:103::11)
 by MWHPR1201MB0256.namprd12.prod.outlook.com (2603:10b6:301:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 08:50:43 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::bd) by DM5PR12CA0049.outlook.office365.com
 (2603:10b6:3:103::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 08:50:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 00:50:41 -0800
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 00:50:40 -0800
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
Subject: [RFC PATCH 5/7] NFS: direct-io: convert to FOLL_PIN pages
Date:   Fri, 25 Feb 2022 00:50:23 -0800
Message-ID: <20220225085025.3052894-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7e90141-910f-495c-939a-08d9f83be833
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0256:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0256317C6192937A0223F8B4A83E9@MWHPR1201MB0256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTqxQpF83G0gwsqmu6gw7wRmodhDJ3kf0EdhJvT31Oz2DxULS3d6Br9SjbF7i8VFPgCb55E165cuUegGM136z1uPz73oXXbz+/iXhweQY5tlk2uJgzp7X2Vbek80Kl7NRox5jlvsHPOQOyFeMDk50Sid0mxnjq/G5ICFkSuCPoouJ1rYZXDNG7n5gzz+Zh9FsilOAVuR+MBMV4Bg6gXJobUjm3iJSQY/7HL/6i1EuQybwTrt6LswCqxznOXm+7OfArf51w6GHNPplxzlGLmH35T2kuMKSiWUjBFnd6G8PHEj+jWln1Src6cHoRq2RmJ0Ulq0mzLSovqGmtAFTHUXQapD7FKJSd5gKVGtqgZy7tgVDkvGeTqp3vdF1Gp5xe9q/h7gcAY7dgq9Qox7oOnRRvEGZlWohK7+X6FnFtW/GSwoT14CHNIqknceVcoW4Yk3L9vj5A8KuAw/cjdax2S+V3qImP0egjQ6gtGRUlqKO+8on1vLykgmmhPqkbTQnyDIJj2/xjBdhb2yDP0uKxF1HgVwn1bDK54XIZScRJeJbxYMs/R3BB+SiaQpcVgrrXUuNJ6znRl0zxJCkQixsFy1rxiNyGiLZvN42OJmx0VJPEW4X0qDubB4qId5ce9L4rR9MP0f52/e+CUwFAlhQr35Jo29fSCaYeZhtS05IXCl6kCayGLltjjRxz5AntCZ8XEfuFhrGnp+jTMVj17B08giZ72xxc3h8Cf6ZcdJPSyanU8=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(6636002)(2906002)(508600001)(316002)(47076005)(186003)(336012)(36860700001)(26005)(110136005)(83380400001)(54906003)(36756003)(426003)(107886003)(2616005)(921005)(82310400004)(7416002)(356005)(40460700003)(86362001)(5660300002)(6666004)(8936002)(70206006)(8676002)(81166007)(1076003)(70586007)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:43.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e90141-910f-495c-939a-08d9f83be833
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0256
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that Direct IO's core allocators invoke pin_user_pages_fast(), those
pages must free released via unpin_user_page(), instead of put_page().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/nfs/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index eabfdab543c8..2e0d399c5a5a 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -181,7 +181,7 @@ static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
 {
 	unsigned int i;
 	for (i = 0; i < npages; i++)
-		put_page(pages[i]);
+		dio_w_unpin_user_page(pages[i]);
 }
 
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
-- 
2.35.1

