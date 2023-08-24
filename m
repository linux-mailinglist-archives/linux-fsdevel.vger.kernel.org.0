Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF078739B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbjHXPH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbjHXPHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:07:22 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440F719AE
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 08:07:19 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177]) by mx-outbound14-35.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 24 Aug 2023 15:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXGaumhoLlXwbhBL9svK58/brtU4rJ3sBeM4nJvg53DSG15rpTeuKevgReQoWAz9HT8t0W5plgDSNPkEBz4uOQtDzNqiptlnTL7Fgy05ieTIc7sYlfrrRfLiFtcPk7mQ7LU+hKaKyfDgk8IA0WfWc8jhO6eV6FsRAtiVz1sVufVXYawyCswXqipBnY1REiXjvn+vmDC91DPKbulWaKQLKm9Er9XgYYgeD+qDJoFEUS90r2ptPgmB4HwPjsgbFqk1TJqk5VKEKSCIwgoOCTUlXb0+oaqZlWEDOI8qAsc4ylbgYQEvPo13XZIgomD1hU0z7eF9cG3mo+Py/ogGPLv6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loPxHHoeDSw1VswjjPQ6bXiarWKNztryADqfMWHphjU=;
 b=od7vtTIo8jDY/ag5I23kGtcLiHxwcc187/UWTNzydOAUjjsC0QEsIN7Xh+kTbRCxwP9aU1bpqeuG4BMbXAFXrZJ/ZQ4u709eeC9CM4K6l3IDC3Mz+jBJzB+rseSOUha4SAY9c5E5thHBzOyCJx6SgPXro0g22K3XY6OCReKOQVrTf3P6mY5gtQB0vA4T9EITfLa+B7pmi7IeEN3vP2eUdzY/u6fZY3GKcXisEt7btBXmvf3A34HlDx/fxUWg7m3dxoaM/wb6/y5J8npYfrFnth326gILp4YTMYHiaVsVpFGm/kMLk524QTrb7GWTm4lwwbvLx99IoTFvG+N1tp9wdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loPxHHoeDSw1VswjjPQ6bXiarWKNztryADqfMWHphjU=;
 b=guEZPcvkgJUTLUpvXF0rDDPvwBq8kWRESqKMGbhuT09hyrpTS8ENOODKbhLbc99m+9kS8DNCOxStCst6aMC4tx39zxKTWdU8DxDn35Z8yWbG2Xn1NcoTcKCTZyGc0HymBoc8KE0qP1/GihNt0GWyahUFjbW55llbxel6Q+oWdTQ=
Received: from BY3PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:39a::32)
 by BLAPR19MB4401.namprd19.prod.outlook.com (2603:10b6:208:294::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:06:16 +0000
Received: from MW2NAM04FT065.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:39a:cafe::d4) by BY3PR03CA0027.outlook.office365.com
 (2603:10b6:a03:39a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 15:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT065.mail.protection.outlook.com (10.13.30.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17 via Frontend Transport; Thu, 24 Aug 2023 15:06:15 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 388CC20C684B;
        Thu, 24 Aug 2023 09:07:21 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 5/5] fuse: Remove page flush/invaliation in fuse_direct_io
Date:   Thu, 24 Aug 2023 17:05:33 +0200
Message-Id: <20230824150533.2788317-6-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824150533.2788317-1-bschubert@ddn.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT065:EE_|BLAPR19MB4401:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12b685d0-8829-4d1f-199f-08dba4b3a99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkqL0qAqXAInSv/tS82c52nxNj7VEXMB8OM8m+MFVF077O7p53Bv6qsF6EvjSX1e0dYVzgdhkD9szNk4wyQ9wTi4Jp/pcGr1+36tRqcexUt4NpadP8juQIC0ce0KKltoKt2O+OdIJoLOCXeUWuucc3KS5DW2xcmEBncZKQLbnpTI8D1WFIzDATAcCE7L+LoznpvbjSAn4AtHTs0lvajX+OLNhvhjvNzcTYzsUtilmGWzwf/Sf6mIkDflpT9w+8kqe044ne7sKrPTBdw2y2X3nGqd/4YW/VdBL93tEFOAmJ4a2p8x2MyO3Kn7dyc7KpMXb9HOAsPqORFHRnpGcHRDVj48i3xMfkPf/OEfg2zkg7aDj7/dW9hnFtKWUtKJCJuY7dTceLoaMKilvflb/oxHTOYWOwA/SHhx8hWdbHbSsuNyKhOjffbt5k4oSl1RuIHu/NSgsquUY+wrGWvGOCUwik0TFhdCWSmBSmmkO8ogZH//Cci3965LWQhVR1oTNzxrY5TTTDM4XXjoeD/AFiWZr731WV/EgczeaJzMrYmWJLj3LcuzNy8uReioNc3VGTGEWjD8uF1s3xEv50eRTjuomETiGe1a6FdauzYDGDoApt9RgL24CjBxHIQ+gUjdEeCJPOqUffDeF7Q9t/up+eVf2g027ieLEaYCl/OcnI6CTINhLwlRStKWBTq/4mZnnXc2M7ivQSl3yWCfvbfHdns36y7I4ADNmIKEVJnBcE8nUEJoKdqZnQb550HE9JbRvvB2
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(346002)(376002)(396003)(136003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(1076003)(2616005)(5660300002)(8676002)(8936002)(4326008)(6266002)(336012)(47076005)(36756003)(83380400001)(36860700001)(26005)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(40480700001)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K0SQRUhSh2D9yp8B7C8cW11LNVB4z/1XOmeE1OYZWjwDzitbbKK2MheZHF0BJkzSBAG7ILbdycPrQeNTSY5eon6uRDKMxXzhXdnxdeklJVSbyVEgIRGJRK1r4nGddIAaYFdGfUVy6ozPiGiTtA96yO6SKF0bP1aawulctx4/F6kyO+ZwM+UBrsDIlpJsj/kaojpBtfdGVBj8VXmgdmGDZXJVfFOm3JBcRJ1/h2q99VCN7b4tGoVrruYqUPr5XgKAo7gVttwXaXAPAESl1bViCrjnKHeAcs970SgHNC/+ldkuYi58svgfRadeoqZKWD+Mw9z2VPuYt7VViKf/p//oKbsst7M1kN0d8rA385WpQXxmAUtrS73ngWdiOVxpcBzJ3hataUYhguHxT7GFS6SZhHBDqPd3TDglxRZcKfLeob/aR8VMDfydGUMm+HiF6ALX5AJmzkUwjxSYimUlG/YK8nhqFLXlCtt6FzTTyiO9/3jRm4kZjXvDcG4+mj4XgV7QpplhSJnnSY9NFr1DyE+CSpkqJ7fEMagke04lNoxR9+IqCZcuGFibbF5l5FbT2t5p44RoiVuWF7N8LWqFsE8rfsoKeoyUD3YrcfBU2pUCfCW/xhwJnVXsSE+5J7s1kmFtmea0j0QLilj/UJ/jUG4kv2OY5qA3Se+07L0gnlAD0cJyGgzBeLd9E8p6J9WYE0jLFOksQQEMcwnaYRokJ+xBb0+RccEBBDzAQDnwyfrIf06NvSo6Bdiy5lnhU7E0Eup2jLxcJGGi1tdJVEF3oVrhdZXdk56mrrMK4J3G2DdPje6aQcGMaaUEOMSuMN2kEPJRRy1n1ctwUTgtwnVH7Q/+lg3J1UR3Hk6xl56MfkoHcowrWFBRKGWWdjISCUMyD9olS2Q6Qv2HPQ4K6n1TvICExg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:06:15.3997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b685d0-8829-4d1f-199f-08dba4b3a99f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT065.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4401
X-BESS-ID: 1692889585-103619-12461-29759-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.59.177
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamlhZAVgZQMNEgydjU0NLU2C
        TRKDXV0sDCMM3QxMjY1MjQ3NzUzNBcqTYWACnK1rxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250361 [from 
        cloudscan14-107.us-east-2a.ess.aws.cudaops.com]
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

Page flush and invalidation in fuse_direct_io can when FOPEN_DIRECT_IO
is set can be removed, as the code path is now always via
generic_file_direct_write, which already does it.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 09277a54b711..eab105ef4640 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1473,20 +1473,11 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	int err = 0;
 	struct fuse_io_args *ia;
 	unsigned int max_pages;
-	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
-
 	max_pages = iov_iter_npages(iter, fc->max_pages);
 	ia = fuse_io_alloc(io, max_pages);
 	if (!ia)
 		return -ENOMEM;
 
-	if (fopen_direct_io && fc->direct_io_relax) {
-		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
-		if (res) {
-			fuse_io_free(ia);
-			return res;
-		}
-	}
 	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
 		if (!write)
 			inode_lock(inode);
@@ -1495,14 +1486,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			inode_unlock(inode);
 	}
 
-	if (fopen_direct_io && write) {
-		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
-		if (res) {
-			fuse_io_free(ia);
-			return res;
-		}
-	}
-
 	io->should_dirty = !write && user_backed_iter(iter);
 	while (count) {
 		ssize_t nres;
-- 
2.39.2

