Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FD7A4FB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjIRQvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjIRQvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:51:41 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6ED94
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:51:35 -0700 (PDT)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41]) by mx-outbound-ea46-177.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g71+Dpy6MD5Nh49Fzfvp4g1hYc2Jsoh+nV5371G9xgm6KXkuOBqa2IHuA2oE1T67QMwzCUQT4E0EXzxw5WQ7+5692cYYKGwdE1xszVNnFnZ+Fl9Uxl6C3SLqa9481Bxmfq8leyb7lfHe7yi8R85OBY0xBLxQVmlK/a+oYmD3paGw10WSMLwOgZdgylnSF4gLxwyE8VzXWG0k9ABlvn42Ef6u6yIVBZ1zpFQGSCkd+DVn9IQJ0LEDR039mPrknsxmcfArjprrR5V6PE5chSTn45yWJK0WKFcljGzJt8xVL5vKG8K5zA6koj/uOc0N50sP46PzQo4JoPnz42GY/3MRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y30ZpdTbDkzt6+XgLEJhqMtpIQFbxnZjnrZPlUB969Q=;
 b=IfcEJ3jKHGb6SsAReu9Td7IlWbmZ9fHtIJDhiGNEvT1Q+jrZZXAPBtJprKlueWWNQFVLflIJmdvJ/DHjadGTugBycHN7Wr/H8kryRJFNlSMKQciHmrfLVT8N+4SG0KBLt/ldXPIVZSKMImAXnrp7UrfmKSgs4uSdldmH/uxFuy7mdo8L/qeUAAVKlpdPCz9yJ5yak3lsnD0Ae70oDv5PtwUdW5mLHZvcbCkSGnpLX/6Y/b+iWKLAKB94072ZpGw5j56OD9GLRAKPZ7DyVVwtR7xblTV0iSTsGUV+iQ6UWglKohLYuEOw6UfniJ9GlOn6Fdni6yxP6GCVc6mg3QF9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y30ZpdTbDkzt6+XgLEJhqMtpIQFbxnZjnrZPlUB969Q=;
 b=Y/+XdLk7e3T20I0tBByriEmRjjcvHpyD/ld9wiRNyDfcm5ftkUYlnsKhG24q3gWJ2QJR7X6QMdVB4YOY1063XOZ3ahBGVuOg7q1PFbEzzRoWTt6XBmu55JmVgop/0EtUkzqw1m67XnKbraXd98Z6mJz0s9Kvk6BZRZF8ZGhGWZE=
Received: from BN9P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::12)
 by LV2PR19MB6126.namprd19.prod.outlook.com (2603:10b6:408:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 15:03:25 +0000
Received: from BN8NAM04FT030.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::e5) by BN9P222CA0007.outlook.office365.com
 (2603:10b6:408:10c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT030.mail.protection.outlook.com (10.13.161.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Mon, 18 Sep 2023 15:03:25 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 58B0E20C684C;
        Mon, 18 Sep 2023 09:04:30 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH v4 09/10] fuse: Use the existing inode fuse_cache_write_iter
Date:   Mon, 18 Sep 2023 17:03:12 +0200
Message-Id: <20230918150313.3845114-10-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT030:EE_|LV2PR19MB6126:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9eecafd2-e7df-42d3-4b53-08dbb858688c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /84LUhBdqge2aFLQOzXW9tC+xgru1Gi4v/JhtN1/qdmHv+H7VDKMe02pMFVrWgOLOy1HazsRK28S07X1w1H/k2TOzlKSAwhzq3mhZ9TnnCeDSN1138hmyV3YrZym/rJB7fksxvvktAZUXFjCgCzWbfKg4faBpu0W15ra/pKea8sePN3g7x/KuvGD+Ffm3AKAUnIDyR8QI68P72zCUjTL8duex1D7RVCa0+ZLPbBBPm/eJjmJ5RsC+fhz/ByTo3/xq90oom87fyNUhmvtL75mpmcpIcBl3xX+B2rPnPsaRVt2gNc4S7mkF/hWGy3cMAkaMbU5Dq0O/QJFeKYLgZQmp9PhCupNkQcfFdE3q3zHbbSnlRnwdJtDST49WI2lWJQm1eugREocmrHGKsZxDlCbppxwboxy4yjaEI8n/PenHBF/6HCAG9A0Fb7MsXDLEmYZZ24BeEbWByLtvJ+ZUHXifjhOFCxjIQeF/YyIU6fp4UENy98zO5feYyf0BPE/NoqhRQoCFOl/+uq8ctjxa7op5maTuf2vqe8dMyCS7yUC3MSGwpGxadhz2s+QCzNmURPUYpnYQW9qEOMoCWgIoElG2v7oJvztvi8lKQRAppPjhaqRRxWUgnXL2Y7zV/9SH+sRDm7aChXFJvvPAWr+dYZ42SQNCUUi2kKJ3PCPL/1sCGOonwj2fs1TahMvEoqx/gG5qTRwO4zDOXoCW6lOTbCXB2v896/FuzxhUSE5HgsxWf4LYG/l1ok2UnV4o5YaYdD0
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(346002)(396003)(136003)(376002)(186009)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(36756003)(40480700001)(336012)(6266002)(1076003)(2616005)(26005)(2906002)(4744005)(5660300002)(86362001)(4326008)(8676002)(8936002)(6916009)(82740400003)(47076005)(316002)(81166007)(356005)(41300700001)(36860700001)(70206006)(70586007)(54906003)(478600001)(6666004)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3sKjiVDHylnsdJtIEImQ8wTgOascysBrkimnT4TVkQ9jGg8uKzMObGzJi1NBBgLL8O9tGpOG3cXTp0lqbZaMESeAIemdEjb5USvA/O38opeJPKM71LrdbZnr5RW6PcGW13UYYlc5qVmxzigX1n9asLjoWgobKgvUnD8rQ4mwtlMDUvUVrkgQWx8kg1TUPgPDeJTNBM48bIOUvCOX5OZ//Qik0zHyfxfRNhOx3t/3sVRq9YWcPnlc0TFtsg3o4/+jI4jzmdouipy3FLku+GW9zxyOjnxHDjf+4raCsXVANzy0C/Fc0yAhz4yqZ5JUEv56grbTL1dYDKzEm8GQKnmq/+4TOaQqfey8E51bjeUm+ZQfcd7RHpgdJwlitO7hH5x77WXEVKstz8UvOy7pnqGDv/2SMKRiiDmIn9QxjjJO06KjlmNR2ElLOP9qVW7K+0oubSWjyEKiLPvdVr7st88I8sluQIFHqeX6qwBEsOhvuetQxJBUzmIkKExX/cLfRGODaH7o2Gw8M04jRgig4LlfSf/MJmnq9UQk613OlwCNTSEeR0cDhMabV+XuM9ctZa3J7n1cUQFklMVlQiGJcmo0wzkYKeBcLxk3Cr2eBnvyRvZ2NiYophsSAnZ9PQLAwi3DJSw+csuEO5eGznWQo9rcOSVCDKUdXTVsTZwtWI7clYy+8c5NWUtub/zrWZDIQ0qdyPA0dt7jBdLNOGgHh7KZXPGHBEmog1s/h5HV9/+4gy3PrgTDhD46YdgR59fiGK9iXLzeyYjWNTvnJtZF3Zj9QGH74TYvJZCHt96HUeQDmySu4iYlGnl2LvU/Im6gxAGczL/Zojs7gkPnsDivBRIKYHHTwExWKTxus6kLDyqAq8NvheQQNEBy5SMmfUfTEs4HfuLcmU9YUXX3jxYIzj1A0w==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:25.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eecafd2-e7df-42d3-4b53-08dbb858688c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT030.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB6126
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055894-111953-32472-4867-1
X-BESS-VER: 2019.3_20230913.1605
X-BESS-Apparent-Source-IP: 104.47.74.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpaWRkBGBlDMzCDNwsA4zTzFLD
        nFLMks2cIg1TI5LSXFyNDAIC05yVSpNhYAafKvrEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan17-192.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

makes the code slightly smaller, I guess the compiler would havve
optimized that out already.
The other is file_inode(file), but I'm not sure if there is
any risk that they might differ.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a996368cd38b..23fd1c4a1de7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1352,7 +1352,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
-		err = fuse_update_attributes(mapping->host, file,
+		err = fuse_update_attributes(inode, file,
 					     STATX_SIZE | STATX_MODE);
 		if (err)
 			return err;
-- 
2.39.2

