Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65486C2767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCUBX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCUBXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:23:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1AB5278
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxvl+W0xv/oyyA8jRmsAZgo2oFeSiMGkMqGYCm5vxUK9ZafV/9OAA1IvYS2s+IKkIhfzxk3C6yOx573HKw3s635VjpjwoP6onZSK5EmgOGlDVTJvoQmIhkmZEi1TNVCno0AghFSn5dM3HqfzPB2CYi4t2pxQR7w+3Is2dkzKyqhqrycVXyK4To20hAWsipDW65nssLreQJWlGfg1Bn/argA27gBsF0vNQfWfd/FK9qgCxKuML2bQYEO0knfYdwjllFJTxmwpbNaJpzST4jkMqfhBp/3ZXGr0kWJbpgtFnzOwYec4IE+ZvYwCyZ8l/jwzMMLM99lSDUbTL4xmX+o/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO3+GcJD/foUwPLuFkq0xSyWWA8mvjk3wg91Ynth3ek=;
 b=ivlhiY2CCjPwk2wqCVCmIUgQGBw1EDcQrf7pGSRxC9GoFYzFszsYOrmMJM+Wd0c53Y7D1cnpdi2GcHVO2zvY4FHP1oaIiXwgWPpxYmwSsvcueaFy+bsZa3292WSHHs/m6BdBIWW+bgbtDN/ud++GfxbpxICnt86KQAp3s2EM3qRg//xJIRCyQyaEpNeXJ9q2ggbHaz5wZ7+QL+WJLOVy4PA1KycZPLfvwJrf8iEPhCX40IPN/8n1xaRrAF1QGAJNdFfRzGTccw79fVQ8zXqAJbq37X476avY4CR3gy7GnSFz49FPQkM5J90Q6LsQ/RxrpTbhOiIDofciMilxD5hFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO3+GcJD/foUwPLuFkq0xSyWWA8mvjk3wg91Ynth3ek=;
 b=0Vw8qfwmNQeTPYSxpcAWNsa6Qh+VgHtD7WPHHP/p9ACqGbnGvhNka2VH/QAiD1jNg+hAiFj+iXZZsiImdInhYVWigiNOmkAFS1//wQm0tMnhAJf7Glv3PP7xEeufymfMYY3xS9u+JLxkzY1777LIgTKreLbo+8GpcJWUtd7MK5E=
Received: from DM6PR10CA0007.namprd10.prod.outlook.com (2603:10b6:5:60::20) by
 DS0PR19MB7862.namprd19.prod.outlook.com (2603:10b6:8:15b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 21 Mar 2023 01:11:17 +0000
Received: from DM6NAM04FT050.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::a1) by DM6PR10CA0007.outlook.office365.com
 (2603:10b6:5:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT050.mail.protection.outlook.com (10.13.159.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:17 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 9944320C6862;
        Mon, 20 Mar 2023 19:12:24 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 02/13] fuse: rename to fuse_dev_end_requests and make non-static
Date:   Tue, 21 Mar 2023 02:10:36 +0100
Message-Id: <20230321011047.3425786-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT050:EE_|DS0PR19MB7862:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9b3833ad-4865-4ca5-2b3d-08db29a92c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Vz+sBTVCFh9oq8kkMoEsgg/qoLkTw1lV39PQatBKMvpe2eMRkUCS41j4NwyrHYdSkStuhnD8z/srGaazGIM+rvf1WvqAuwOlgaBicGebqIjfPpbB7L4Di6kcOd7XVu1gX3ZAxJU6hSzFsdMSbnbbwM9Mbi830HQICcbs739x2DvVkkN4lRWfFnurzI72fj4ek11Fo7ko00rOjwVQeqCqrk6JQTfZUyPfFx47Ikp+Pu1fBQFo7lak7PrEItZ5G9IQE6h/eAPWSknenvAlH7PvEj6fheO9PM9hkHS1RDUT6SwqHfZwfmPXMa0DohBfsv4wo71YNN4mn3tX6InBbAeTZuis0ysnfhdaOYrOxdbxfrVOPgkN7ayO3J/IHk0rAiYH8StePfGCQxe6gBckUppIRInzEEQzJU31bkuCU0K4IfBr8YSH3Q3WJ362hOOr7OvlvpTizQyWAjhTs0M3BTJObZhtPKDx6+0HIz10vvwsRdcSH9hUPU36wsP8ImsHzJp2FNVkj348pDuf92QOAnJGCK8laNycsivOJ/1iJntG1q8VImIz88/3zFWWhR8QRHyx6RrNLIw+Y5YgJqBOOGr1uNOUy4WsvGGo+lp3QgtT5VM+6bzTyoQCO81YwrYpfgwAl+tza/itILdmEr3YqLfu3YEz86b1ILvnGKpeJqHeWxKvRXRduKxLRV8kN14OxS86noY0rMsSkwo9rHfmEsPdg==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39850400004)(451199018)(36840700001)(46966006)(81166007)(2906002)(36756003)(356005)(82740400003)(4326008)(82310400005)(8676002)(186003)(6916009)(26005)(1076003)(40480700001)(70206006)(6666004)(36860700001)(6266002)(54906003)(70586007)(86362001)(316002)(478600001)(47076005)(83380400001)(2616005)(336012)(8936002)(41300700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:17.0104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3833ad-4865-4ca5-2b3d-08db29a92c34
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT050.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is needed by fuse_uring.c to clean ring queues,
so make it non static. Especially in non-static mode the function
name 'end_requests' should be prefixed with fuse_

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev.c        |  6 +++---
 fs/fuse/fuse_dev_i.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
 create mode 100644 fs/fuse/fuse_dev_i.h

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e8b60ce72c9a..02e9299ba781 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2075,7 +2075,7 @@ static __poll_t fuse_dev_poll(struct file *file, poll_table *wait)
 }
 
 /* Abort all requests on the given list (pending or processing) */
-static void end_requests(struct list_head *head)
+void fuse_dev_end_requests(struct list_head *head)
 {
 	while (!list_empty(head)) {
 		struct fuse_req *req;
@@ -2178,7 +2178,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		wake_up_all(&fc->blocked_waitq);
 		spin_unlock(&fc->lock);
 
-		end_requests(&to_end);
+		fuse_dev_end_requests(&to_end);
 	} else {
 		spin_unlock(&fc->lock);
 	}
@@ -2208,7 +2208,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 			list_splice_init(&fpq->processing[i], &to_end);
 		spin_unlock(&fpq->lock);
 
-		end_requests(&to_end);
+		fuse_dev_end_requests(&to_end);
 
 		/* Are we the last open device? */
 		if (atomic_dec_and_test(&fc->dev_count)) {
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
new file mode 100644
index 000000000000..68e7da9f96ee
--- /dev/null
+++ b/fs/fuse/fuse_dev_i.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
+ */
+
+#ifndef _FS_FUSE_DEV_I_H
+#define _FS_FUSE_DEV_I_H
+
+void fuse_dev_end_requests(struct list_head *head);
+
+#endif
+
+
-- 
2.37.2

