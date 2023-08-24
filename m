Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E400578739F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbjHXPH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242125AbjHXPHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:07:51 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8AAFD
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 08:07:47 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101]) by mx-outbound45-241.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 24 Aug 2023 15:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaOOTLALiEGXCnYNodz6nZv9s6vu3yco1SZ38tdt+r11uSLDhmw0u5B8j6lNUZjWA+9wQ0MDZ7j+4kYOt5CUueIKN7Hi9CHyUWnNkoFhfcGvkfLcgcRGBKjD0r5blm19Ym1yQy6EqcYw185qLxQb8o7XhevOKO2iEc04nxTFF9bLXSJRmQ/gP/fqZQIsYbek4bGEETUCQ0I8zKr65og9h7NEUief9jGonp0BoEzHyBPFho0ZPipr7c+j5jSSl2wCUU725zu+owqBwksidxBF4vxuN/7xONGLOVy8AY5qtQMxIzX4pPvXUAuJeBEHv8Y8CrQQecCA1hT6pniLxoeIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbmTh1TjOZTBwTZXPnUI73gUmgVaABp/k2TUSx+hja0=;
 b=jUIOZAXy5n+3nXRkVktBx8jyT28RBbQrcDVQvC8CHtbPCuFumZ3HQtT/oBCCHLrTgTLlOfwPzOce3XO/ioJeDr5oJd9oo/7zgBDRjFV2NBO8dJHGEXh/qD+FoyedzJTB5BoMwlkigVggVIGmfae/fGCqC18gCYHmcoM89Su6oAIJ3S+EZt8EIx2jOmXrklgJgrebPDcUoEaJp8bkeO0GKudnlqDkV9cFtfA4x+lwYs8G1gVWGd3Q150RfcFGgLAMyJm9Bxif1mv6dTw2m3GeUFUwFK5hgaaMtHTEkFMW/FxwyTar2yMXHDo4SjJGHfLRocpSKt4ElRMDIyn7e1cozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbmTh1TjOZTBwTZXPnUI73gUmgVaABp/k2TUSx+hja0=;
 b=Wr8Eb8gFeh2vh84klKB9i6zGTmwpaZHoya0pCL4/pfRCzLbSyonL8nEttIJUsAMNooZ6Z+Z7l07v+Ga8wM63eEqyqYYrPQjKWV9DuqqBarebOqC53NvZCay8uuZXHYKnQHo2i52BSNxMJufyoaouGftErnh0j+nofnGBkv/e9O4=
Received: from MW4PR03CA0227.namprd03.prod.outlook.com (2603:10b6:303:b9::22)
 by MN6PR19MB7866.namprd19.prod.outlook.com (2603:10b6:208:470::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:06:06 +0000
Received: from MW2NAM04FT059.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::81) by MW4PR03CA0227.outlook.office365.com
 (2603:10b6:303:b9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 15:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT059.mail.protection.outlook.com (10.13.30.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17 via Frontend Transport; Thu, 24 Aug 2023 15:06:06 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 51FA820C684B;
        Thu, 24 Aug 2023 09:07:12 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 1/5] fuse: direct IO can use the write-through code path
Date:   Thu, 24 Aug 2023 17:05:29 +0200
Message-Id: <20230824150533.2788317-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824150533.2788317-1-bschubert@ddn.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT059:EE_|MN6PR19MB7866:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 10f3bbeb-599a-443a-c62e-08dba4b3a44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWM1gck2Yt8iLqUzmlNZhKEHGIykYbjX+AE6b9DZ3dXBHICMCfSZmLMqNERxYIUTdRO4NUsyNMPujwb76fBraVGvf6CL6UIpXYbsT/8iVmpEd1egiYsKalt0FJYWpRWDJNvnocnM6e2J0ID0JTYrE2Y3jVT7zqRCujpxj1uRANqQ/zI0gPQs15fgc8NogtNAcnXV0HujmsS51axGJd7rOx8f8gXlcGgUk7MYYtIpQYQqiITA/fMfWMI0VAv8r2izrYYy6TMxhMp+J26G847khb5sCuiq2DhfX8BRX6ZuYmAJ6eaRJroqMrAnQR+1owroJrrsLEfeVVxhQQWP7FhPpWcMY1oETMhzkF+BKbh8bqoVWC5EM1+GaqYW+w2zclH6tTfDplk+ouVDl6T1bxkkzYUKreEXVxgzpQ7B79p9QQZK9JGg6i/i0LaJq4eHz5gEPvJ4V6qbb40CkQvFRYHqbXD+/1B2Kw8iukJjm8nwZlraym51npA+sBrJJ/0HtN8z43TeC0PAMKT8fgU0burDrUfjq0Rc9gR+EnGbEK8B0lBIlOwiW6IShoLWxsHqcZsV1hVI5kzStfBwYDkFUllnT90OT+e2QOPe75yUnX4d4HkQJln1LW81B/9Hs/nxFsT90FIMXgJclVjfeTwhJfwuxQbxdh9/slyql9+ktJSQJupYeEi7K3kmJQJ0fYj5WmGCzuJTzpKF0EwTxJsJFMUV6Dk3cp5N8KueEDzktQjdeOpz3xZszfRLuY//MlQ690ts
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(376002)(346002)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(1076003)(2616005)(5660300002)(8936002)(4326008)(8676002)(6266002)(336012)(47076005)(36756003)(4744005)(83380400001)(36860700001)(26005)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JgioNlo85nOYrlexRhA3QPro5xIZzzmQBjod9yq1YdNei7n799ahnsJSaWUc+Yn3NDh2urZfOHrzC5TMptpuqjWizT6kgHyxX1yKt6xT/fkJqyDEL+r1246BnEKBvhpPcovfC1JKxQGQxShDLG4Jgs4AH8cIQs2tHngry58wH9DxjvX9zV75i/RU5/9eyUyDwUkIlp67Jmlp3n+d2Qy5PCt2yUGlYk8P0AAVpjXmP4Y9c6Fr9GXtxqL/5GBj4a1ZZ03sELoi4G7UqzCTDZbYZIsYGm+r7PGSuw6nyCiVNSBh7lE5qneMCGSF8CNCkKGm+TyMnDIxSMXBTKjUO5rqbb8Sy2DkxRPKCLY+MZEfqwzp0ASRoVbddoqa5WOqhKR29df1Cbt0oKwWCo17CGGz7hYohYfpcp+b7XDjVBO/3B+LD4G+xIaIBd+mDu3sGtPafOdMjUH4w8GCamHzKoFLbbG8lwbgwKG1P85K+mHMI6FU0eC4X/ZDXnlddsk1x18X1QshjcPR7bRJ0On9bTupMqOqW745MY6dd5CjB5arzffX+TIlxhKhwmE0y+vTFkrI3GyrIo5mLXgHEP0cjarddtHQmbcp06SRO5JznnADWeB1zjvmEFYG2Ci8BdAG0j0gA2UYwln+dRTf+/ISykgRsPySkxBEeQI3tzaNgp5rvsX1oOgIiTuRUrAgcZ9QD7NJXzrKHWdVM4TCi9IBO++URY2vRsSd3slgg9768zLZ84YcP1GHx+nEFuku3scXlUVxfPuhG4PXPCjsCDrBrr9B6RBCBe9kcFkTyyq+h1bsZaWoNH/nyER+zHkJEkxTdYe1/z6GFpIq4XgOxYovGHGfNiucR0h/M54Dw96yaNYqbsqTMrFIyZJAaYgjfnIsi3ILb7/eLcKSW6fo1IdS1oFc6Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:06:06.4741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f3bbeb-599a-443a-c62e-08dba4b3a44a
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT059.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR19MB7866
X-BESS-ID: 1692889576-111761-6161-149-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.58.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaWxkBGBlDMzMDCyMDANDHZ3D
        QpMSnNzNzMwjzV0jLZPMU4Lc0gyVCpNhYA2S+ZwEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250361 [from 
        cloudscan11-221.us-east-2a.ess.aws.cudaops.com]
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

Direct IO does not benefit from write back cache and it
also avoides another direct IO write code path.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..b1b9f2b9a37d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1307,7 +1307,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (fc->writeback_cache) {
+	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
 		err = fuse_update_attributes(mapping->host, file,
 					     STATX_SIZE | STATX_MODE);
-- 
2.39.2

