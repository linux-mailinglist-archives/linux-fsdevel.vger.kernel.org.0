Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7687873B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbjHXPJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbjHXPIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:08:32 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1A1711
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 08:08:27 -0700 (PDT)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45]) by mx-outbound43-111.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 24 Aug 2023 15:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6izq3ZZ0st4jOdxcylg4+FqLBcZXsthKc6tOg3d5gCjh+k7KetlnyzBx+fqIC00Q4ZJoL89yaarUSN4XA6YHjTHfO5gpLwPe3SqXJvVi1SAh+KwVYNrs531IZAOwvCX59xyVib7/3TyXZWSE9FjChC7Hjbz8YmVHsqCwwQupC1JQJk6Zx3ZeLsLvOaqlUwMxKZzRdaTLpc6M80IvUfwSVjmDtQ1H23UXHHR0pMTi5gMuMCWb63rCJU2zbZ8Fqp6LsG6G1CpS+tWgDfTFTEYpaMXLlvuiX4kPNzbA6j5WSIWJJg182NnZ/NxjdLJdIToKivtWOiRfkCT48eEfkhLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wJ9BHb5XuUtUwN+eDjU1EfspJns/pdiPyjsZxIQFSI=;
 b=HPjaW0gIyJWH/GbEstd4S+kGvFDJN+cwnBXSkWJRwXHFLYTYaonmEexmITJF53cgJtk8RNm1yKS0OPaSPRtpoMC+2gb7kDmWmd0VveXpYqX/bhFezYwtg5RxWa9POt0UhCpzIosNTO4K1j2M+wyr+HaATWzfLmrk6n8tyg6KhWX6p4yvNQPYy+BBE4CxAy1bQWyN/O7HrDq1m5CzMsVaK4/kBgd18jfuj+VhbcxKlif0m8hwEAlpjeYRiUVHRhG28VTRVoSzgAnNmVxmUmcjlnikozDHacTTS0rI3GtNHA7kiV8XJ5jUcTiiVdu7QB7ldeDj1Ouk0FTSmt0Eykv7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wJ9BHb5XuUtUwN+eDjU1EfspJns/pdiPyjsZxIQFSI=;
 b=Atp5ZCVq3Y1trIsa9Ro50Wn9N3Ub6kHrb9uo/sfbw+AR9juUY9pqNdRckY5W1/68kaizRziwLagtFs3ToNtOA5nmuJwoLQC749R/tmKOjHC+xOxkZT41zsGsobomfYHHKFvDavqmzU1holSb6E1v/kC00a94dka9AAQ7PdtQRYA=
Received: from DS7PR03CA0328.namprd03.prod.outlook.com (2603:10b6:8:2b::30) by
 DM4PR19MB6051.namprd19.prod.outlook.com (2603:10b6:8:6e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 15:06:09 +0000
Received: from DM6NAM04FT009.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::50) by DS7PR03CA0328.outlook.office365.com
 (2603:10b6:8:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 15:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT009.mail.protection.outlook.com (10.13.158.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17 via Frontend Transport; Thu, 24 Aug 2023 15:06:09 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 949BB20C684B;
        Thu, 24 Aug 2023 09:07:15 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 3/5] fuse: Allow parallel direct writes for O_DIRECT
Date:   Thu, 24 Aug 2023 17:05:31 +0200
Message-Id: <20230824150533.2788317-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824150533.2788317-1-bschubert@ddn.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT009:EE_|DM4PR19MB6051:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0646dc12-a338-4b29-966c-08dba4b3a633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGezAZ46XssM+RGDrD6+ZHr+RVkm/2mytXmE907/pvc5M9E5snRrI/2VS+GFUl8EPIQqwydWhzXgrmZgwsYd0YJ5+6oNg7BlisjLeYQ0etZk8yjSsbiJv6KWKOvAnQ5I/swi3KHAHwDWCReB5bLiOSwGwhnwXvaUqU0WnWJ+C45F5DWa2uJNuWLHf/xJM9lf/GFplDRpEx5z5mgNCx2PQB9N1vsilOjL1a4OjUEewKClJdtQvj/Wi2lIKeWWV7E0nxgxUkRblkgMGZOoyim/8htrwFbt/h+evhDyvkb9XxA42bz0cmGZzfXC7XUDtW4cDQshFpMIUm7TdGtmpvGwfkbXfky0/4tcsQVC/rEgeCI4C9KuXnQ5GKa+DQ5uc5F/2y2XMlufEXThJMXXAErW7/Pl7xI9lGu/5up8Herjusx7nxGkvaXnlT/4We8VTUpu/Mod2XA/vmZO7IUYZRKu0V6Bu1LA31hZZPVcRFTKtB4MWxcPe9bWWoRAdO45sjOjmu/1rt/deS+AH8MTMSvAIY6xZPC9x8UWQwngNFSBLH6VhjNKSHSt7tNCbukKJq8QiNiht1vsnbv/cKGwbfa5509GmXXy5rNMRdOdGUmhWFlpr0W+5+JM3xt5yPlFb6/fVqTLVgz6si84TDdAU4ZPdaW6qnV/m4iCBw7gV11MKYxgbz9cvk2JHkFkIcraNC+v2UXNWwMQATl9BzV8oOPqhWWf+KQmAPfPkNA8O80aEl00fkpVPfnYTlv7+Fd4l5pf
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(376002)(346002)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(1076003)(2616005)(5660300002)(8936002)(4326008)(8676002)(6266002)(336012)(47076005)(36756003)(83380400001)(36860700001)(26005)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: et83gDw1xhP+eoQIeSFi9GTfGRDDBrkuE7hVlrTmG6nwfOlhbS0JagT1+0Rnv95k4IkEYxSE6cJt/wsFYasI32p6bC5+LFWhr00FiletvHXGFXBpiFNjrWCi8X5UDPmNo32UTU6JUX4wwiGbFUJqo8OY+Yp3TkN3fWgdAfISGq9E8sN9WEN+G1NgDcTxZ4a5Yd6xp2GYqEHpxSsJxOgCMFiaqeE3H5mnMDGagJStgoTjpO0rF6lCIdJosX5nLKndMWoIOQdYfAO4nW0gYAvfAgfx3k1Hxj53nMLjTO32ctKSZzgU+Dp3GxOsmLpFqEyd4WzeZNVfzMpeC5jrrpQQrDEA62yz57V8TBnC2RW2ChxAqdL+vW1DnpQlQzsafLYI3DigxqVDZPoxL9h1IcKXgaVT1pI6cHoW4oFu04ZV3aHM1HzC9/RvZhB9aszBtoObjlpYzaRBfO4v6I/+h7m0pqfwGHMh4qzqGR7wsfWApWdf8NE+6FESYHTVOmHZ5rq9bSGzMu7Re6KHusu70/v/jPxvZHEhJZ6ySoGirNQqrIggU99Ov2DoTblSYXpY4eDZc/0+1wAnNEV8H4sXb/rclxn0SVqRmoJiR7IHJT741ya2cZJhnhiZP1KMNyeFpeRSCsQKDIBVxUDxTAzQSSh0q+zP72KdbPr1moH/tNFIc+hf9gaAcwc7TbeoXTqW4KrqTIWoBraUPPnFv5JC17MGPKO92THRk2CS+uywrDOT1yngwG8X1e9KF1rm2Rdmy/7F5WCXtVDqvw41HYrplMI3YWSWQgFDscKpwGbeOG6+XjoBPylgraKXJNtA/OF2MEGG/pms7MYzgwrD8Ec5W+JDYfXpvAJL5Cqz9r0/hctOagI2+wiLUKCGVkf3lnJQMkisD9qPxCeOwh4pP3+3rjb65A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:06:09.6619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0646dc12-a338-4b29-966c-08dba4b3a633
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT009.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6051
X-BESS-ID: 1692889597-111119-20297-58-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.51.45
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYmpiZAVgZQ0CLJJDXZItUkyS
        DNKDnJIikx2STZ2NzQyDQ1MdnC0jRFqTYWAEwR1G9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250361 [from 
        cloudscan23-219.us-east-2b.ess.aws.cudaops.com]
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

Take a shared lock in fuse_cache_write_iter.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a16f9b6888de..905ce3bb0047 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1314,9 +1314,10 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 
-	return  !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
-		iocb->ki_flags & IOCB_APPEND ||
-		fuse_direct_write_extending_i_size(iocb, from);
+	return ((!(iocb->ki_flags & IOCB_DIRECT)) ||
+		(!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES)) ||
+		 iocb->ki_flags & IOCB_APPEND ||
+		 fuse_direct_write_extending_i_size(iocb, from));
 }
 
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -1327,6 +1328,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool excl_lock = fuse_dio_wr_exclusive_lock(iocb, from);
 
 	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1345,7 +1347,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 writethrough:
-	inode_lock(inode);
+	if (excl_lock)
+		inode_lock(inode);
+	else
+		inode_lock_shared(inode);
 
 	err = generic_write_checks(iocb, from);
 	if (err <= 0)
@@ -1360,6 +1365,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
+		/* file extending writes will trigger i_size_write - exclusive
+		 * lock is needed
+		 */
 		written = generic_file_direct_write(iocb, from);
 		if (written < 0 || !iov_iter_count(from))
 			goto out;
@@ -1369,7 +1377,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		written = fuse_perform_write(iocb, from);
 	}
 out:
-	inode_unlock(inode);
+	if (excl_lock)
+		inode_unlock(inode);
+	else
+		inode_unlock_shared(inode);
 	if (written > 0)
 		written = generic_write_sync(iocb, written);
 
-- 
2.39.2

