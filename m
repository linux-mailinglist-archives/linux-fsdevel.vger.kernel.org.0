Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AB76C2725
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCUBPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCUBOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:14:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC82E0E4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfPA32RNRq3VbtHjP4LXic5asOnJelNlKeBjJ9kE/WXff7bKJNQU1HaKrqglcTamNQDsBJpjo1AIc9dAxrDmTnlCDSFPN7LRyCZoZHjUrQBTTD/VaZu/ONChfJzCEz5V796oZeEwCJMZHnqBJ1Fq08LnjBHerWbnQVJ46K2V3GARgXMDXDfH4g2I0GwoWh9sMtuFHYEm6ojmNM+YC3gaXwJT1KeV4k9lR4RaYJW54KK43O4Mt8j3r8g2cvE+vvwYcWKj/s0zYJdS9StkplDZZ7NAxOVl6Ek5vIOdB6VgWQuMh/YCan4rrmgLe/A510v+6oedFtKwa5cxGS7jF5g4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2fX+gq9pC3/ot3A7hoT1c0oYoIEP+bVIZmZibce9/0=;
 b=EApwCT9Z/CSuLh/bmOo3E2/++wGYCOfxcEAxVZFWmALRAEAkyci1teijeKEvYDgGUcoND8J6pykoiUELmweqivbbvSyjnPnUjRZdup2dhJV1I0KD6RLZy/1bQKqXOLuSXgogtkoFTdevGlK08VmgEwV+LS2Ipz5SoDlLMgyOP37O0VSTZvZ2ZemzUBO+rJY0XzHZ5ZB7VXqylsykCu/1oOooUjb+9b+VzrAl/bCCAHyHSI5M8Tq2StorkcAstKpuJ76A+vkc4s+54glKekywEt1jf9/XwFvvrLLx1Eo2oG2SZUWsrUoLFuuvqRPLIvNa7CxZlB/QfyMw1O4K2LcBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2fX+gq9pC3/ot3A7hoT1c0oYoIEP+bVIZmZibce9/0=;
 b=u0cORrWWJM62WhaccxHcGLcfvCL//SWxNWPq4ZBTMH6oqXnoBDuCEFeU515TN4tU/m9ZhHjqvCEuUtn9GnvbK39cRk922w2mRwj5ncQkNMuPndhyUG3dfa3F9jKEI2/TajmjLkSPhyX1XYUZbzL8eYYUYvtGZArHVFVdN4D5FOI=
Received: from BN0PR04CA0172.namprd04.prod.outlook.com (2603:10b6:408:eb::27)
 by MW3PR19MB4234.namprd19.prod.outlook.com (2603:10b6:303:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 21 Mar
 2023 01:11:18 +0000
Received: from BN8NAM04FT052.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::a6) by BN0PR04CA0172.outlook.office365.com
 (2603:10b6:408:eb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT052.mail.protection.outlook.com (10.13.160.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:18 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 9196D20C6862;
        Mon, 20 Mar 2023 19:12:25 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 03/13] fuse: Move fuse_get_dev to header file
Date:   Tue, 21 Mar 2023 02:10:37 +0100
Message-Id: <20230321011047.3425786-4-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT052:EE_|MW3PR19MB4234:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a05db88d-9af2-4413-a424-08db29a92cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LU4IZ21DV1kd/zh4QKZQ9wtPFV5Xpqb1CeOL84ErK6UC2VUR2cETiQFL5OFnq/Bxyyw4w8Z9ULB6HURgXY09ZyhMBEB8AexKoTuQWI2N3mqpIwOOBzU6nf/9nOOdUBwcNe9aLq6CmvblD693dGa04ptUdNt21uJE+g2IHYfwhEZYX6ohPrhrQqOrO7nFZpK+qfHrMJ/2HseVr9H37N3bhzfHvR4uMtz1tWNgziORdWLczlr1Pf9xhHaU1cg3JxCQ80rsqYnnVGoGY90MPzaAUIlXR6Q3j37qSE8DQJ8IxFJf8w+eY9YRoNftZ9n9g1VkgXzykyMimnvrl2Z9VjdTB51AHHOkoXJEQiYSYb2sb8cMmkPoUvcoQYEH+Vf8G/lCudeIugcqqVCIaep6BbhPoXjBtlYKwaBRciJEdnT0KlkN2mw4tBpZ6CiuOZIvfK6aeDAqwllCot9EmqfTuIXVligwl8+LYoHy72cCdRjJJHygwBTC7tZ7dZ33jdXg/LMzXHACKK8asVX0eJgk0kcxboWE2p91zH6e1xxbbZxXGc5GpiLgaOKEA8+SMMLo7fMpwzvTQ2YlWqFsgHXsImYmzFHYs77Q+cH5+F9hugWDxDNjrzfBM6y2n85BFFn1F3PNSTDNGVUmE76bU06OKoTrKEfQCbm2EFAqRGp2bONC5nX6dgXTITgYrji2LDyDk8/FHTQ5ma4oe2VT4R1dN0XuyA==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39850400004)(396003)(136003)(451199018)(46966006)(36840700001)(40480700001)(1076003)(26005)(6266002)(6666004)(186003)(478600001)(41300700001)(8936002)(36756003)(86362001)(82310400005)(2906002)(5660300002)(54906003)(4326008)(70586007)(70206006)(6916009)(316002)(8676002)(83380400001)(336012)(82740400003)(36860700001)(81166007)(356005)(47076005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:18.1674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05db88d-9af2-4413-a424-08db29a92cf0
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT052.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Another preparation patch, as this function will be needed by
fuse/dev.c and fuse/dev_uring.c.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev.c        | 10 +---------
 fs/fuse/fuse_dev_i.h |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02e9299ba781..e0669b8e4618 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -31,15 +32,6 @@ MODULE_ALIAS("devname:fuse");
 
 static struct kmem_cache *fuse_req_cachep;
 
-static struct fuse_dev *fuse_get_dev(struct file *file)
-{
-	/*
-	 * Lockless access is OK, because file->private data is set
-	 * once during mount and is valid until the file is released.
-	 */
-	return READ_ONCE(file->private_data);
-}
-
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 {
 	INIT_LIST_HEAD(&req->list);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 68e7da9f96ee..f623a85c4c24 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -7,6 +7,15 @@
 #ifndef _FS_FUSE_DEV_I_H
 #define _FS_FUSE_DEV_I_H
 
+static inline struct fuse_dev *fuse_get_dev(struct file *file)
+{
+	/*
+	 * Lockless access is OK, because file->private data is set
+	 * once during mount and is valid until the file is released.
+	 */
+	return READ_ONCE(file->private_data);
+}
+
 void fuse_dev_end_requests(struct list_head *head);
 
 #endif
-- 
2.37.2

