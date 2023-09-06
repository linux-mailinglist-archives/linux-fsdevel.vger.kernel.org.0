Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3037940E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjIFP7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjIFP7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:59:50 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B14DD;
        Wed,  6 Sep 2023 08:59:44 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound45-126.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 06 Sep 2023 15:59:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL+q7w3iTYzLCH/BggCQwisKV7yEVRrlDsxlpDoZd0xCNsmH4AXbL76o+RooUSldJQZ+7xsaSLM0RP8OLF4yzyDl4C9QDO32XmitcugvHKkju+tAGbmwGfWqT+eO+Nstnw7b2cACv5o9HV4x/Xl1BmVw9gdYgnBK3/2o0ig0bWboLoukfFmh8txfw07y7FPQAzE7CbWNd46dzXKatmtoVUErhupXGuWWubt395QfaREOwRBYCEtqDaXMkbhUUiE+fy/hTI2yZEuWYbbqbek6+CJ4zd79hV3i69cAS0BxaLTvD9/B61pC4nHZT8/yAa0Od1SeDifHNsKhtedvBIabTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK3hOy8hyTa3VkGdrsisXQORbcXjZsHVaCS+xdbvHc4=;
 b=FEEKzm6ApW7w3x1uD3r36Ftl3osTWB75MxaM97Np000JN8BOgi90Z0LpuFmZGDW9Zf/+E9A9Ng33H/bwrF/E+uieDVFrXK3OllRSMds5E15gfFRhhZ7/8ihJkJKB0wcsnC8/SdfhJwA5t0yslWe4fR5PKuLvvXb2KyoqvcNOy9ZUiaGkvcCT4wWDA2nbo2mM2El9IRB/1j5KvGpHJ7SH50wC5PwQ+AJE3gFse9zgZ3sqLqMGGM3386Vi7gYu8bIKEgBkenRfmIvynL9879eRjWeFjFXwSsDlaZZK7X39jrFFa1SlsYVUIvRa8OJSf03mRzjSxhQUfaxn8thBdXzLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK3hOy8hyTa3VkGdrsisXQORbcXjZsHVaCS+xdbvHc4=;
 b=cCEntQRAruSW4b1cHKuOQQy8IMuILBRm26juKqE330uyZzdnfBqUxPMLKEC7mRxJwdcwN4ZB36C67e3tt6BFeQEPcH1mUgt1s06CGDpn4JOoWN2BOhvzPxVGX9jyNNn5vxE4Aoefd92bb+8AS0DF8Of3S7Bnv8ITaE+azzMrW/c=
Received: from DM5PR08CA0032.namprd08.prod.outlook.com (2603:10b6:4:60::21) by
 PH0PR19MB4843.namprd19.prod.outlook.com (2603:10b6:510:74::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Wed, 6 Sep 2023 15:59:16 +0000
Received: from DM6NAM04FT033.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::2f) by DM5PR08CA0032.outlook.office365.com
 (2603:10b6:4:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 15:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT033.mail.protection.outlook.com (10.13.158.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.26 via Frontend Transport; Wed, 6 Sep 2023 15:59:16 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 0CA0C20C684B;
        Wed,  6 Sep 2023 10:00:21 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-btrfs@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/1] btrfs: file_remove_privs needs an exclusive lock
Date:   Wed,  6 Sep 2023 17:59:03 +0200
Message-Id: <20230906155903.3287672-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906155903.3287672-1-bschubert@ddn.com>
References: <20230906155903.3287672-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT033:EE_|PH0PR19MB4843:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 496fca2b-7158-4387-ce3f-08dbaef23905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HHXFyaTRa/a/TDjfSHYCJ119i62U6ct26kihTE6NcS/ks868XTS6Vn92RR7jVPfWNyrCIxtuBtQ3J/cJ0yxWS8jqFpKFdUNuJLKecqXaDOWTXsuXIIWuPyfMvmonZJqjFyRUpVZc+xryE+hBunpwxxOEmLi5ne2Fu+O6+ccrdmI8ecCI4onemGV1SE8gRd15bvY+AW4N9DGC/zigt7FrodFyyCeXGvnNahZYnOXlVeKZ56WQVdwcOma7J38elYXzHBjb2f7yhKrvXASFJ0zvU0t4YrULmwCbp4jcx71W2aaO38qB8jvondeh6rtuqcZKYykhv++Kgm3Uejr7HZg+oK0Z5xO2mOA12KUnrOmEcene1B2kFvQmZWUSJSmqjtn4dXyEr9pjLZEAFFx4KwvvUosCi3F90YO+VZa2dolqTZ29inoKF19CAcRIn4VTe8G0rAKfgYpURZC2pDbJp6H1/vCpxEI4XXzcpYtct/6Zi682l+Cm0WGUKHhI9gGYj9UIdcK7D81ek/Z1zrJlr2Vvwxys35xYr6MvYAxpHX+9SFoGJEN7BA0D8BD9k7o8a76WbB77kv5AJdaOyMDR1jT1eZ6nNg71hTNgUIpgtdFDZoXXRscU+J1w4tHNCuNA7uuKV2a01d0uv/2wAw4MpvwoSvDZ5Koe0JsgdT2NHl11nGk649Bf7rB7KfnIiicPipIR3AsoM87tO4ybnyUjMq1JHnEJ3nKpsTs6ZNTn3EzYG0oLHNizeeGHximDVbwW+I2
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39850400004)(396003)(376002)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(1076003)(2616005)(40480700001)(4326008)(41300700001)(47076005)(5660300002)(8676002)(336012)(6266002)(83380400001)(36756003)(86362001)(8936002)(2906002)(26005)(6916009)(316002)(6666004)(356005)(82740400003)(81166007)(70206006)(70586007)(478600001)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JhKw0zawtRLzQ6KxXA9S/3m/2QEMVt3JUltLikMfE7BKV5Hn+Vh5doRp8H/AYBp6xjv4RP4wo/CxiLnTrZsiL0OegruyMBp0hYI2i3bt0VYxzwhtLNJlB9qXZsvycP74icV7gy2hori4kz+htEbz4ujcaj/2YZqtBk7jTlT8psTo2ePGCmb4mJ1ey5zKJRXchOC6roE9os523aueGEYHe4X7oE+33cSmP32BT9fmfLZCSqs9fuyfdGuN4uXSOZ5zu4uCSiv2A6YVyFB/dXj7glFNFHha5TGff1DFCew08BO7qGd/3YkDNUhCLzpRbN1gNFkPmRqMHomChAjjifJhsuhFvsEiBMpvqvR6Paqg9nyN1+xCwK7hSywJKvYsSPwx0KiiFPkja4av7rj5lw2ygPhcIhs68+9xeysmGACCXpZSKNAGBIrjQSuHf8a96qJgiURTloI5FHdhMPAAVHINs+e5SAcwwsDGYYlC+Ae+ke91zDke7VN8R7EVTVSbwH/npNKMdDVkUsJOj863Mbp68d5MwHaBYTQo50HT+uCPvAvI8U3WVGGkK0GuZXdEHNGZ3ZRJchohfZk1GlVxnywPYwHEydJXVTKKtMs5Z9xtrLwwt8awSNhaPfzssvSLnzywiDl55pgfR716XgwoCzKgTMRqgsX3Ei7TbFhDXJfbC59r5H3xrm3ExuN4wYXAYDHqiW7nvOJV00bVl/ykNOU5UWtFad1pYX7V03BpizAkoSGU+B0DSZDoh406Z4xRa5WFH2r75zzJnRMV1y4w6Oz36Mntj/p1BhDUsvcokVbm/qPt8v3A2F/GtytyXhyQGnXUVta/y327+ula9Z1556/rO8Npg/s24SrlfYtqjIs7G/ffvGJ77oDMDttj9v/PkhXYs4mj4aVVmo3GTfCjZxaaOqHCf2lQvvDAytgxns4P/Ws=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:59:16.4276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496fca2b-7158-4387-ce3f-08dbaef23905
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT033.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4843
X-BESS-ID: 1694015960-111646-7231-31-1
X-BESS-VER: 2019.1_20230901.1930
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmloZAVgZQMCnJ1CwpxTzZMN
        nCwjwxycDS1MQs1cjCItHExDgxNdlCqTYWAFnRPDlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250646 [from 
        cloudscan10-86.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

file_remove_privs might call into notify_change(), which
requires to hold an exclusive lock.

Fixes: e9adabb9712e ("btrfs: use shared lock for direct writes within EOF")
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/btrfs/file.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fd03e689a6be..c4b304a2948e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1466,8 +1466,12 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
 
-	/* If the write DIO is within EOF, use a shared lock */
-	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
+	/* If the write DIO is within EOF, use a shared lock and also only
+	 * if security bits will likely not be dropped. Either will need
+	 * to be rechecked after the lock was acquired.
+	 */
+	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) &&
+	    IS_NOSEC(inode))
 		ilock_flags |= BTRFS_ILOCK_SHARED;
 
 relock:
@@ -1475,6 +1479,12 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (err < 0)
 		return err;
 
+	if (ilock_flags & BTRFS_ILOCK_SHARED && !IS_NOSEC(inode)) {
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		ilock_flags &= ~BTRFS_ILOCK_SHARED;
+		goto relock;
+	}
+
 	err = generic_write_checks(iocb, from);
 	if (err <= 0) {
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-- 
2.39.2

