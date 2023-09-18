Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39057A4F77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjIRQm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjIRQmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:42:47 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE82C3590
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:40:42 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47]) by mx-outbound42-104.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ4h/15mqtvm8CD1W1I+1nXRFzKOq6OLkAGl1QrFkzhhzwYlGGgEZxGdB5wJRwIFUFz1569OfEeql5fXz/fTMxcF8Wx/tls+6+U6bzvmxtHKNzMsIsvl+CqBLp2hZ2htFSu2WMgkkBEGuTfAZcUndsFskmprixm0QRWLomKCOzQq+bElwtq5LVr/e9MhFO8Requ3kcYzAqXexKzviLVmOIHFwLC0DV/r8rZhbbx1EHJzNvQxJJix605ue4iWf4xCSsusg3X/FMBu+K0IGljnmAlc9HtL56HSXvonRARIuDTTfveFi6fWpOXIrnhKE66MqWahVHr/WKNqCwwXIANmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KlFA2/6mVNJqCpuPCFywORxSQ7YOxHpVOILpYvjhlQ=;
 b=a4yNDPrjtzhSFDDsyBYifOTA0aC+PTrFQ8HY6cX08hy7Da+Z72KqTFZqX0YVb7zmuCmUIJ0EM5fyyrniizGpBI1HFXiLpXR+P9N3zloITTVUYu68jE5eCLtcn5UylobU1fIAVyLzVDPYaKq/SuzVrSaBxVj9p97mFHGzoaXSwO6jtTOPo0/UeYuYt4BplHu6lwD8+cHUaKEjD2lyWTCliYoXASbc+0iKKK/uuUIO1zbVcMwsk+RiXcFG4rGD4zJNrpeIvlTGec8LbskFfCAHGMCJDd8u+NqvqVMoIZB2cAD4qmNr7pM8CUNZrFcin6BvksyDKabuhQd919nLsNK60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KlFA2/6mVNJqCpuPCFywORxSQ7YOxHpVOILpYvjhlQ=;
 b=dQdh3IvVkvwJxYM3+X978YgnPqq/77w2SCywbgKzR2Pa98OQpViOo+VCaWJALJfxDdO6qnm0iVNaAHVUL1+hEDmYOA/wjsHlsZ3ITCRk23gEWpH64/89DQt18DRJModrRE25KEnP4OCcTIHVdZA/BBIZ6LwZ+t0CvVs7Wwe0pLU=
Received: from BN9PR03CA0420.namprd03.prod.outlook.com (2603:10b6:408:111::35)
 by PH8PR19MB6925.namprd19.prod.outlook.com (2603:10b6:510:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.22; Mon, 18 Sep
 2023 15:03:18 +0000
Received: from BN8NAM04FT008.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::e) by BN9PR03CA0420.outlook.office365.com
 (2603:10b6:408:111::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT008.mail.protection.outlook.com (10.13.161.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16 via Frontend Transport; Mon, 18 Sep 2023 15:03:18 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7105720C684E;
        Mon, 18 Sep 2023 09:04:23 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH v4 02/10] fuse: Create helper function if DIO write needs exclusive lock
Date:   Mon, 18 Sep 2023 17:03:05 +0200
Message-Id: <20230918150313.3845114-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT008:EE_|PH8PR19MB6925:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1349b460-62a5-4603-95eb-08dbb858647f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aycFWN3nxTKlEVpgXB/yrqlTdmUfJ6qGF16FZ2CXStwsVO+YriMS1ZSeQthB+AhoVVdqw90hhSFriXLyzOzGLItPoJEneeAtKAdWueMWYxVY/YmJ62MVs8mBK7XrIP1TZGcpKa32in+5SDp95AXMe53MMdFEJIu0MPkLayf7EGpU9BOa0FNu7gRn2x7FTJNl+cPfmW08ToFEg7MnBMrjZj1WuDtFkjdIDsRUmMeYCqct/r02OrECWMT7V+VEAy8tnlBPvVRb2SIGYkWFsUTp9xzp6YMn//E9pjFru/jLmSoCz8vboZq2fr07Ks/J+YlqFEyDjKTF8IPmXWyQgJ1EShXdIAX1CtBiSx3jMehAoHo65SiJx72EpX1di6sY44p4TFrzBn68X3KOrD5lZHnaGsNGnkUzSnxaXc8SI5Hi7IQ19Kz/WOMcVeJRi8xKpnfCMhNqEkiZS6g5f32AgE5bdtJZ6OOmjO3NMepSovOrGcPgFXLyGSfnMX6hzjX0L1jlmTtxzblETHOyrwTzrizHOc2wTlsMvOYr+w6FKmGo3N6l0qil3quiJjvcoGVdOgYTOzIaQE25TJdCE3tGNVYL9gR9zOyfJ3OR/1VLfCLsOcuDSKCTg5ntP1xEebNk+t0vZsAtyMjgsl1PTyJQ3Eyh3xNEGGV3lopqPxUJa0V/mGIGnvsFyAaSQT9FTK6yRmHy2YhTnKOCNEh2dgNkqLwHwOjSy1e+ztHy9Ietcsn9Tojqz4v3PyunDm7RP/3FG6zw
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39850400004)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(83380400001)(5660300002)(4326008)(6666004)(82740400003)(356005)(40480700001)(36756003)(86362001)(81166007)(36860700001)(2616005)(26005)(1076003)(2906002)(6266002)(336012)(478600001)(41300700001)(47076005)(8676002)(6916009)(8936002)(70206006)(70586007)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9mTq+SxNPdxeDElJOw03b/KY3E3NSaEjYSSyj8+f8TDGkzyL3D0qnu8Sr3IUGJuepzLcBRG+lgikbtIx4DRw8FV+Ue1RWH0t2K+6U2ZGU0R4WovCzREBT0fybnUJE2W1iHlcUVI3PS1NetAn/T9n6x6uBXFodMbHI8wHUy1f4ZKLZ82RkZJNDJoOuRQ7dep/nf9FSLzBBR8CLn80jdTHf/X/ivzTZkTs1QaRwLXb7gfYi/dLOQ/Db5XL+sDleZYi6ylUkDWC/sgrKTalNNGMFln2dSnTRNubxrmCwf1qGviyiR4es2UD3pMyUuFt6gODs92pDzW6NDTsIAfEkgSH7UEAObo7ai0Z//gQu5NWU0101DPinKSF5XOP/oQpmfZQdoZkXV9y3Lc84c8q8UWmAVfrsJzJPg6e04rOHY2xGoF3rpx35aXtJp0rtehuLyAffdDbHQPrIJg2DRoRDb2Z7SYPnVRG4WZczvjTD3jfCLQpwcHFt699BTh8FH5D+iByMf5xmkWBzVL58CqhXfX3ek072+xeOt4qzjSYBdMRWU6QfcHsvXVF4m6lFsq9sZGhTZ+3OdFo9ZXrVKgg5XN9AksOMwLjR8mtVVMBOdOARRnewZJurQhfFo3I0YDjRVGeV9YkV7el13QxkitJCNJXFBBP3sB+ZiiIgW3gdQhlRq1PXSiYjmdTa9q7p8q41nD5MrmNzmbtYjtixzvgXZCmlYcirhzKD4FEiOw4lhxYGYnbjWnY6MNtrK5mZINqHaSklshw53DBc1gXajMpoSwRsmu2d0g1cqqLFugE75tBiLuQX7GT4oyUPkfx8+8470/2SVGxrpQvbGmZTq3dkpWcnkS5wzsW5W4KmJ723MWNKFN+pC07kJrWDBdzBjI5qnfsWsdltf1h3qIgo2BT4KjN/w==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:18.4366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1349b460-62a5-4603-95eb-08dbb858647f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT008.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6925
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055240-110856-31778-765-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.66.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWJkZAVgZQMC0tMSXRNMncLM
        nAwtzUMMUgydDEMCnN0DwtxdTMLClJqTYWAMHOp/FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan18-58.us-east-2b.ess.aws.cudaops.com]
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

This is just a preparation to avoid code duplication in the next
commit.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b1b9f2b9a37d..7606cf376ec3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1298,6 +1298,38 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 	return res;
 }
 
+static bool fuse_io_past_eof(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
+}
+
+/*
+ * @return true if an exclusive lock for direct IO writes is needed
+ */
+static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	/* server side has to advise that it supports parallel dio writes */
+	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
+		return true;
+
+	/* append will need to know the eventual eof - always needs an
+	 * exclusive lock
+	 */
+	if (iocb->ki_flags & IOCB_APPEND)
+		return true;
+
+	/* parallel dio beyond eof is at least for now not supported */
+	if (fuse_io_past_eof(iocb, from))
+		return true;
+
+	return false;
+}
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1557,25 +1589,12 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
-static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
-					       struct iov_iter *iter)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-
-	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
-}
-
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct file *file = iocb->ki_filp;
-	struct fuse_file *ff = file->private_data;
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
-	bool exclusive_lock =
-		!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
-		iocb->ki_flags & IOCB_APPEND ||
-		fuse_direct_write_extending_i_size(iocb, from);
+	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
 
 	/*
 	 * Take exclusive lock if
@@ -1591,7 +1610,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		/* A race with truncate might have come up as the decision for
 		 * the lock type was done without holding the lock, check again.
 		 */
-		if (fuse_direct_write_extending_i_size(iocb, from)) {
+		if (fuse_io_past_eof(iocb, from)) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			exclusive_lock = true;
-- 
2.39.2

