Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D978739A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbjHXPGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbjHXPGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:06:35 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145591BD4
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 08:06:28 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100]) by mx-outbound15-198.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 24 Aug 2023 15:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTOVrrlLwPK9A3jn1wffusTnPaoNOLTxPDhwRgUBEFrgUYhaWl+kwog0yNwKpPeOpZIf1NrVPnGmsACwiDMoPCFw2xrV+Tn3Z0IDZsYZhDHe4KeDpRAjZJM/9aDzw+dlbAcPHf4wtVISG5HCb8LnykM6XPgxeLmQsYvmGaKKkE7nXLObLqO/5MEwjzWT4Y1ph+j1tyV2XCNSb//Si1HXJDuqBdTJS0t9zGVuIJRfa3bWZnI1VaRGIrhad57QayQi7vA+8lirY/7sv0xz4U1rc7Af7LdwocE2z2O6kT2ACMAPSrcOEg8/ot7WK+Gj7YlU9azUDeJiddDyhROIIPfOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzjgxlalg0V8lqWSz1bKqRHpdj4spdXbYosbLVk3/G0=;
 b=MuzVhJADaZrfgC+RrbO54j1G9SiqxVLFXgGAxypMl9a2LQJkxnnq5KHnKwyqDBvhwytKzpX6VAyp2Y1ghK/7nnELHB4dAOIxGre8ZwX0006WGCRlTSl/TEgTu/Klzk/CtVd+f2u2kTk7SSgPnsuJJ03lWLZNqQTUX2Z86XixC2joH852PRGHeF36kNOFbkmhJZouasEyPi9w+ABc9tFlQIeghwXq+9Kf/QEvcGQaNHeod++n1yeAGE8DW0sEG5LQiJoJR46VJg98QJr/c5Z9PnGhO7zq+rboQZEAsy0Af0yJa7G1lxMWNzqSXLEjmBo/9Js6y+H3VJ2vi24/kh9oqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzjgxlalg0V8lqWSz1bKqRHpdj4spdXbYosbLVk3/G0=;
 b=NxvtX7W43tHZDht/1qBBTn7kvC0dGJbKMSSNhM7/K96Mb9tbUXyPA24lKQD7XNkIKxSSD4tJCIBvMhFyVtbKyUXoAMhN9mwWgLnDC+/4rO+xrbnYUcrk1E3IGC4d7CVu+yBOnNZqxUXpNNnoIM+fwhawkoUE3OwrxnpMBNWTU90=
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by DM4PR19MB6075.namprd19.prod.outlook.com (2603:10b6:8:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:06:08 +0000
Received: from MW2NAM04FT064.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::4b) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 15:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT064.mail.protection.outlook.com (10.13.30.189) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17 via Frontend Transport; Thu, 24 Aug 2023 15:06:08 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id EAB7620C684B;
        Thu, 24 Aug 2023 09:07:13 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH 2/5] fuse: Create helper function if DIO write needs exclusive lock
Date:   Thu, 24 Aug 2023 17:05:30 +0200
Message-Id: <20230824150533.2788317-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824150533.2788317-1-bschubert@ddn.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT064:EE_|DM4PR19MB6075:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9937868c-d90f-45a9-1c24-08dba4b3a544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ry9i0kr5NzrsdCqzHVk1tgZpCUldrvb/otBQG04xK1rbkDoKH0MjbDtBuXkuhH0lHR/IZcQL9VBpyLhLQwoispa8oyCmVSuacx8qu3Dh8hD1fGxkGwEZIgAk8x4vWFNCoD0h6u4NfZOV5qohK2ULyBW8Bkij0ZjYZMSbbn0lO66DoLQWb2WhVaa9l7iDlEGOG4YDV/X7fKAEpZus4EieUdi0TQQOr+0kf8kXq6egSMESLM2s74RmZ9Ajxd5I6ib9diRlj7YxgbRaBjn2s+3Egkh/ygxAa2pv5kF1Y0bXZJDVgJfZlGIq8paEiRDUQwDkHKVneENlj6gtbG7IZp7ted9v2tRMfPJmALaP3bElBIAlxbZe2yQR13FZWx2l324zbR1etgqFusp0uYAf7heGOpvQllQFC616fsjufFOB6ovzv9V6jU+HlWymCF+GCWr6trv5lth3rUcdTVvnkIZRYevI20pfVBg3mcAv73TwAFZy6Ild1VkUPAnGpjAebpWwq/bmY+xdsz6TcK0xe/+LbU/kvGIeBst4Av5RJQc5mM1I5ZhlOqd7L1id/5J7AK1boi5a2NjnXnWmGYmmo0BU4Sxksbz0pz1VOZhw2JeCuRu/pHMnjGIRdVE+zOehsNTjPuEka8RZYYkiA9Nmy9f71xHycuM+ukFGCILOdjzN+GdnBJKqSrw22C7EM7vrxmC6jcp1Fqx+QZQ5Ayvz1lKmui13Z6UurH/E+gPliAtiBsV20QO+DHYrf19vuAHWXQv0
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39850400004)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(6266002)(336012)(47076005)(36756003)(83380400001)(36860700001)(26005)(40480700001)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jRHmjdvJTzqJQTz69d0aOAJhqbpuDJTg0vo+tan+dqqP9eLA3sqzMuR7Z0vyS+NYKDz1nYm1EfKSdZ28ehweChN9rtWel+RMtTlps739QaDqrfV8HjteKhzNNL8xYr9EZSNx92iCWoO/VSsVpWPDOaC5TMCJcgWaPgmihdLhYC6PABebWFU+66KK4eamxktACq4HY8lzxbUU5oUQPecdRJhx6bTDNolq3DMAjEKYgC1VINZ9mdHmddTi6ZUANF0orqZPheKV58ThKhGJIfuP6fYJy3TY9zdZZeYvnSfCrANlzUYy8iae3MZonAR/UjPNTWmapTd8kJSH45nwmQnpNtpLzW7yjt23AwAb98T34vh7y4ii57IgFHgTbEJ5zpKEDMGt0ZBO80UM4qWWTSjUnI8utSpHX6a3jBY4+T4X6blTaiJRSq2Qk9ujlseaDJVFSLTsHixhIL9LtJL2h00OUIFuGQzYUmRT+wtcQhG3nD8RRwy9Ecwvt7A98TDKgIJHP8tjvqvxCw8rrivlMHl17sTiSs/vS9KgjStgrzR3IVOmlumg5DqoCPpN5fQ+Wuu8DuyDhDvsZZzS52CnhubYiZbWAD8RGcDoRts+0rxPdH2sKkd7Y2hk/Ysgn0vspXGjhXrKLxX6/47Arg76GLApZ4E2RbtIcxVkZH0n5ObEjTATD1wKDuk7Sq1dLdwNoGGhUgc4K17X5eRRux1zswNnw4nHl1WY2b672rnQpP+3DCAL7NIZ2rLuOiJv6AF6FTw/oejoEk2Ln+Et7ULKae/xqPb8iaIaohJqFF1kvVwZu9Ky7YSDElFPiI2Tk3XRUvSQn/CHFnLy6MPOhJ9aaJcoLpWNsKqdOAiB2dkgQDwJSeV4/95zmjkP/RJeEmB43T6LP1WyLIufcU26UYpGXHZ9qw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:06:08.1081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9937868c-d90f-45a9-1c24-08dba4b3a544
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT064.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6075
X-BESS-ID: 1692889583-104038-25174-37-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.58.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZGpmZAVgZQ0MjEODHNwjI11T
        TV3Mg4KTklzdw0KdXUPDkpJSU1zdxQqTYWABcGkEBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250361 [from 
        cloudscan18-232.us-east-2b.ess.aws.cudaops.com]
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
 fs/fuse/file.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b1b9f2b9a37d..a16f9b6888de 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1298,6 +1298,27 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 	return res;
 }
 
+static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
+					       struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
+}
+
+/*
+ * @return true if an exclusive lock direct IO writes is needed
+ */
+static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	return  !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
+		iocb->ki_flags & IOCB_APPEND ||
+		fuse_direct_write_extending_i_size(iocb, from);
+}
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1557,25 +1578,12 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
-- 
2.39.2

