Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F078B7A4F92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjIRQqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjIRQqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:46:18 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C061B1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:39:24 -0700 (PDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169]) by mx-outbound47-161.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 18 Sep 2023 16:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzLnwYlYA0bc8avhTtOLGwiXQUS03CLq4X/6QjvCLoqgT/t1kjpKqo3YhCJE+xGa1jFX1GEd8Op1plgL4YRB2dZNwvHW+/Ps20WS+vZKBg81N9V1Ir368SSDDeyEPi5MbmrsJhCWP6tZ9rSy5v2ms3RJyJDILCdzx7xvtZxr6J9d0BB2emhgo/V77U/RVeHocg+GBjrX+Gv/cJ1+iNEWNzXGRDdRGeWGlwTKuOv9cLB3wIbfpf3q31LK9O7lSlN2RBwOKpiLzEU+UvLmWSKD3kXzADKsAW3nB9WbOAwLIahUHMQhm96hTFQFAHzikAfkhKyjT3aZrKXmQRDBpcMJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjZuvpI15TFd1/LM9T6DCgPLlMbShmb02g+85+dAgZ4=;
 b=AQi8WRHUTjDZ8PtzGSn8ORSTVRmWU/2IQ72VjMOn7rN/ww96JYmyiWTypg5k6QW3W+37v03nIY7yZ+ajWnJHuICm9LbIQTyocLm77dP41I3O0ljyqMQYkhIW0jE+j7zRMOQVvBhxN+tDhNEQslbompUvCm+jtMtVvPTXWLfU8lGFVOR2jr04JvFK65oqIcTjC7E8fgfV/+qjEk907X04y391UlMhGYet4hnUuVh4VW6bN0wNG/bNDwbgYkKIlqncuCsf9TnlKT2SC1ZgdrRcYqT4WGcPyiIvXEKNIY++IQVmSzwcZWVuNIXELHYPxsT3xYY37pMrffbhH4jB+a62Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjZuvpI15TFd1/LM9T6DCgPLlMbShmb02g+85+dAgZ4=;
 b=NwauvEWbwJ3HGZL7CpVbU9zM3GKStsgZPjFvFgRbOtb6SXMHUFJG9RM50HIUtezmifbOjx/K4+YamRijNOI+iYxsdoP60P7DVdISYGjaNSOPr2NG081GbtunKOeKwEPrLQ5POO591bVHlZVpIKFVfdBf9QX47dhKCiLCsZ00o+A=
Received: from BN9PR03CA0981.namprd03.prod.outlook.com (2603:10b6:408:109::26)
 by BL1PR19MB5793.namprd19.prod.outlook.com (2603:10b6:208:394::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 15:03:28 +0000
Received: from BN8NAM04FT025.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ea) by BN9PR03CA0981.outlook.office365.com
 (2603:10b6:408:109::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24 via Frontend
 Transport; Mon, 18 Sep 2023 15:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT025.mail.protection.outlook.com (10.13.161.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.15 via Frontend Transport; Mon, 18 Sep 2023 15:03:26 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 52FFB20C684D;
        Mon, 18 Sep 2023 09:04:31 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: [PATCH v4 10/10] [RFC] fuse: No privilege removal when FOPEN_DIRECT_IO is set
Date:   Mon, 18 Sep 2023 17:03:13 +0200
Message-Id: <20230918150313.3845114-11-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150313.3845114-1-bschubert@ddn.com>
References: <20230918150313.3845114-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT025:EE_|BL1PR19MB5793:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1601bf84-6e99-489f-4f70-08dbb858693c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7595c3Z2ITObD0sN+P7WOpQ9Cmz7q4knX+EoO710gKr9C3/lbsr38PSTEwVKnGbrSO13TOuHqMAjPQ3X9TX2dnm6+i2WMusc1ixo5A/wGDE5n9hMBUWsrkV1/ozoBC1Bh85I81iK6XY2ZmF2S5HeXRU53zoEYOm0gkolPzq0Nk5I/NXRQCbwgahh9L1u0aLoEsfMtTgJ+X4bh2yBQ0kzPRLCgOrgXo3umzE6CoXtcBvVNYJ3koxSms9dbjrIUCfuaSIRcyK7r1Jt2iFMI9am3fqLGNZHEHVxplTiLoMz1CgpHN2JV9C2Es9nEAgRG7xsbUFZYhpsDKlkllIx0uRI1emkDOPbj2PbKptdRJLTfeA6PFU5D5LpOoRu+0mzgOi+laY0i8OyvYkYobRFTpc8kXEp8U5NlRXZ2yLgLLAEQjHnZEU8tCmvOcfE/mWSY88PkdDQ5hbehTOW159kRTBr12+yU1+rcWUFxHxEdFVv8wrBbQmCyEUvR2VUXI/4sTPeQd/pNiOd4icnPScCDoavByGJjt3QMwBu4awZKb6c3w5MXln4/Wwzq6rYM7CprF2jh508i5isSsSllYO83Ce5FISLMCGLSKjWlWcjNiC6kab1b0GZbmDtkKHlpkFDk/de58N1O0pGpuI7DPKAYk0VW5KSFgTsgC9GKX411MJ81sDLumiDSbL8tZfX0gMLrcTffWb4COLGmpT/mpTK1jmThBlcLEvGczbbPoBMwMfWrNAs+JzRKcBG53oV6O0sdxn
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(136003)(346002)(396003)(376002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(356005)(81166007)(26005)(82740400003)(2616005)(8936002)(1076003)(4326008)(8676002)(83380400001)(36860700001)(2906002)(36756003)(47076005)(336012)(6266002)(40480700001)(5660300002)(86362001)(478600001)(6666004)(6916009)(316002)(54906003)(70586007)(70206006)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RuJ68A0qpYZPUg2nfES0G91qforWhXL7GB668PBcB7ZxEs3Vd2d3VYaAu5chrlnaZntj1/4NsCLH6Xn5c6IG4+tIWNPl116opRUoxBLZX6JNJVD/J4FkOReaaTH4U5bwrdZqXWykuSIDTKVjXeo5Yg7nxvnk5UlhGY2IHJL/JV6MB2IXkXn8BdcRq8+0D+QhTbA+yiHJOQ85iyN5XSiz3TYmT78lrELojodWwRE2XoMxselvHRELItOyyI4/8W4USPlo7XBYqd3aDenRJkvQn6v3kG9dEmPFP/8OJK/pUC9glyw2wwQL6VEr1/S4Ob+Jb2tvtdBQV+Gks5qLvt64/IBaSdmuxEKH/L/eZ5t0eLEvqh3geIhZuMqhAZ/tYdW3YT1Mit6FDb42ip8U3jWtclK/wIbYBgtd5WOIOcP6+pXxmytflm/jr3mPnBdouyWEYXEUUPjTAadDhM/+uKQNuWOqGOZd3uauJS8xYo/gh9+3UXFQ4IOttUTdc6q3d4inX3OJShYzieRef0x5EuCLfSdD9byxhLvT27Fer1wFwPdoOlLlmuFe1hjqOCOAOULTpcvmnOg32gYtpio66qOxmxvcZTmbJNAU7XEc1b2gxh4FviyLFMaajjjJdxrDKD0HdPSROhd8QhkV2PfBtiHEy9OHRD0ctJ8BFP5O+c+v2LBHJMAuiY9srF7VBC34scYVTE1Xa8xXzVxDDQOlejYoUneTzuwYmQLa7XaW5J7gLcNpRrUmLe9j7qVgBtGEpAi1XbB758cBm1Yeto0mvhD/lVHKlUI1cgLxIFq8pBSk3N8I08yssik95bw+Rx3hTWWph+Nlt4xo636/JHMvqeJzTvVGB+bHq8enT8nKtTLg0jNY/x+cgyE6tuWa1xEQ7d12Z3ZReG5iBg6d//oDF6cYhw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:03:26.3843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1601bf84-6e99-489f-4f70-08dbb858693c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT025.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5793
X-OriginatorOrg: ddn.com
X-BESS-ID: 1695055163-112193-10835-1579-1
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.57.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmZpZAVgZQ0NTS3NzQyMLAIj
        XJKMk81SgtxcLEwsAsKdUiKdkszSBFqTYWAKActPxBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250915 [from 
        cloudscan22-72.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

Traditionally this was not done for FOPEN_DIRECT_IO and
adding it might have a performance impact.
The better solution would be probably to have a xattr cache.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 23fd1c4a1de7..91cd25c0c177 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1342,13 +1342,16 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
 	struct address_space *mapping = file->f_mapping;
 	ssize_t written = 0;
 	struct inode *inode = mapping->host;
 	ssize_t err;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	bool excl_lock = fuse_dio_wr_exclusive_lock(iocb, from, inode);
-	int remove_privs = 1;
+
+	/* traditionally FOPEN_DIRECT_IO does not do remove privileges */
+	int remove_privs = ff->open_flags & FOPEN_DIRECT_IO ? 0 : 1;
 
 	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1386,7 +1389,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err <= 0)
 		goto out;
 
-	if (!excl_lock) {
+	if (!excl_lock && remove_privs) {
 		remove_privs = file_needs_remove_privs(file);
 		if (remove_privs) {
 			inode_unlock_shared(inode);
-- 
2.39.2

