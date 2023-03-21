Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF76C2715
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCUBNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCUBNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23D6D7
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hj3p6UVsCNQhmz1DGuQWm3KjkCdy5BdFQiq0J2uKBAlp6gxgw/EBTnG9MJ+gKZoGq/RC5qQTIdwvn9w0fgasEfhloAs+wNmas/ix7aNwG0+0M3tibbA4Jv3os4rWVfZ1K2MfbR5ja5Paxdv6P69W3kJdBGCEMI9R3Fbs1do7yPVGFi65Dzwz1zgIUVa3IkW8J/fWL9uBuklCA2KABYmG6zZ/v/97EqGsLxhkZBuo6CWKCWA7ff0WP4gz2SG/Xs8ylKFOESz73R0DnD3rbzAj/N7MzW078IRnFrR/JSql6kJ9qb8HtYojDgEbbrAX69De7sOZLAAdZIp0A6yXZAxVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mEYefTqy0fH/jHUrq7Av7RwA9qfBzH0GThKS/G1D48=;
 b=LY/QDyGSAjxApHrcnA/0O6ck6inCULu/R1CtgcpSFKM8hUvuZ5tnUU9UzhmWEwYkMUGCN8cqSUl7AyiWl1vEkGpZMVXj4x0uKfftCFWZoooJKAuuUDnq2WN7ZyqYgDS62qrkALyBWU71/0Zk/IuJLVGQ/2f3p+iuLUlFkHI0Ln6RgR97ve+Jz+z7rpIRORPqhKMqIJboljCDUfzJV+nCYEMDM6+r9Rk8gWRUp2vOLZGsFFujz7hyN316w34cTOA3udHnIttloWJCGaMNKOqDpU/oNQg+eF/8iQPDOsnOrAVwhF7cdhdvi6L1Gc3VFduuN35Dz8cDfxmo5qy/raJaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mEYefTqy0fH/jHUrq7Av7RwA9qfBzH0GThKS/G1D48=;
 b=ouNLuK9XokR1gNcr9bu0D6LCxAIUBUC0UpFSoQa+xA6nhuy/wmO+3ymX090u83izXtxXpOy3p/AII/l9vGqYcvUGDAAci9DyxI/9AVh0gmIaR7GrfolTiGYvoJUbzdB5zrEmbIaQxyBPhPizH4s3K8saGHV1NwV+XOlPN7LpviI=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by DM6PR19MB4328.namprd19.prod.outlook.com (2603:10b6:5:2b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 01:11:23 +0000
Received: from MW2NAM04FT004.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e7) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT004.mail.protection.outlook.com (10.13.30.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:22 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 66FD820C6862;
        Mon, 20 Mar 2023 19:12:30 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 08/13] fuse: Move request bits
Date:   Tue, 21 Mar 2023 02:10:42 +0100
Message-Id: <20230321011047.3425786-9-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT004:EE_|DM6PR19MB4328:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 41ff027b-3afc-499b-9fab-08db29a92fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3s1HsIO4LraFzltb7GGw+bVJkeGK7l/2kIXMhInozOTxmFnViwbsw/ck3a0d1L5H5jiQ3x7gRXhfnjMPMDg2mwQtO99KrUAWCAoK0nCzdGfnCtsVHGKD4eC0K7rapzKgxn63WWbgT7nNTJciOjpuOx7JMjG1cTKPC7DkrKxxTrIdx4nnI2N12i6tukUf89GpfVX75rjXpjLKt4/JJtv7eMBorhtoj+Cqm1UOz7YKIykMlqZMiAnRuWzHsZCcagoKTa3n1LjdAmA4cseE6tIR1Uh5sDlB/p2CW/ot6dIL7diIPbPSERH7JBCHN2nDgqvxLHqURsgB9aSJ+8sBM0J3+mR2oXxzuJrrkQ8a566L+lta5IytNZEvO1mWjzO/VhwEw8uc8aYBt5U3+oP2lswhSMsqYNJ/AUvb20zmT71/4Ze3Y44M0bXtrOMRf5TqY4EI5rnscBJKtHJk5Ph+MZlrmghgXsCEaBhpDCMzOYxE+tFaCbYydLPdtSf9inGxYHInw/b9Uf2AfyBn5kH2D7rrI2pnQlpsuO5NoDue3VBI6TpsMgfe6pxx8xHbBkdmPiTleMxmDSD5BG/MdT4WDx9CLjMimu5JHuz4DiQpCXu8mts1HpQeAWdbF1BBjeQZ/yURDccH85z5SklrH6WQpXXemFLs0A+oGLlu/gagCsxeSGLOMD6L7ErH0P+F3V5+plFMMsCp6ipbNfggir73F6JNmw==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39850400004)(346002)(376002)(136003)(451199018)(46966006)(36840700001)(2616005)(36860700001)(336012)(83380400001)(54906003)(40480700001)(47076005)(82740400003)(81166007)(356005)(6916009)(6666004)(6266002)(82310400005)(70206006)(70586007)(86362001)(8676002)(4326008)(478600001)(36756003)(2906002)(26005)(1076003)(186003)(8936002)(41300700001)(5660300002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:22.8632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ff027b-3afc-499b-9fab-08db29a92fb3
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT004.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are needed by dev_uring functions as well

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev.c        | 4 ----
 fs/fuse/fuse_dev_i.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 256936af4f2e..4e79cdba540c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -27,10 +27,6 @@
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
-/* Ordinary requests have even IDs, while interrupts IDs are odd */
-#define FUSE_INT_REQ_BIT (1ULL << 0)
-#define FUSE_REQ_ID_STEP (1ULL << 1)
-
 static struct kmem_cache *fuse_req_cachep;
 
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index f623a85c4c24..aea1f3f7aa5d 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -7,6 +7,10 @@
 #ifndef _FS_FUSE_DEV_I_H
 #define _FS_FUSE_DEV_I_H
 
+/* Ordinary requests have even IDs, while interrupts IDs are odd */
+#define FUSE_INT_REQ_BIT (1ULL << 0)
+#define FUSE_REQ_ID_STEP (1ULL << 1)
+
 static inline struct fuse_dev *fuse_get_dev(struct file *file)
 {
 	/*
-- 
2.37.2

